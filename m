Return-Path: <netdev+bounces-197963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A97ADA96F
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 09:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE9C17095E
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 07:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1151E9B23;
	Mon, 16 Jun 2025 07:28:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA857F9;
	Mon, 16 Jun 2025 07:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750058896; cv=none; b=GemPkYZjvDaAAsdqbD1J9LGTVv6QKiZ8D1HLVN8j93bVzBbGvmrS8xWw5RYj3Wy8rfn/88wfLV1htFHGi8PyIKhRQsWCMH84ZM7mwgx1ndnTd2djgF1tUyfH1I7w4cVa5iXgleH6nsogLRY23NvXQ1OUa4kpAIy804MUOTF1M3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750058896; c=relaxed/simple;
	bh=TYgNJ0ayODp3uq/e1O+xYtjg/h0fuCvvxPMLyUixXOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lv7xsOrg7QWgB7NLQKhL9Mg2nRdBfPDYtpzsP0nPlpSk4Zt6GJBmLbhwpxWjwIGaQ+9F8OhZ6W2ZeRZsfSMQx1bzmANanirdomOZvG22c60WgzR7EVvxwdQk1dO3hN3h5TscslY25teRTKALieo9GFJNWwauHBlHZcag05R3Zv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bLM1y5BmLz2Cfb5;
	Mon, 16 Jun 2025 15:24:06 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 0DB491400D4;
	Mon, 16 Jun 2025 15:28:00 +0800 (CST)
Received: from DESKTOP-F6Q6J7K.china.huawei.com (10.174.175.220) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Jun 2025 15:27:58 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
	<gur.stavi@huawei.com>, Lee Trager <lee@trager.us>, Michael Ellerman
	<mpe@ellerman.id.au>, Suman Ghosh <sumang@marvell.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v03 1/1] hinic3: management interfaces
Date: Mon, 16 Jun 2025 15:27:50 +0800
Message-ID: <c17133d2629728942ade513d3e761277cca4b44d.1750054732.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <cover.1750054732.git.zhuyikai1@h-partners.com>
References: <cover.1750054732.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100013.china.huawei.com (7.202.181.12)

This is [2/3] part of hinic3 Ethernet driver initial submission.
With this patch hinic3 is a valid kernel module but non-functional
driver.

The driver parts contained in this patch:
Mailbox management interface.
Command queue management interface.
Event queues, AEQ and CEQ upon which management relies.
Some of thew IRQ implementation but without full initialization yet.

Co-developed-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/Makefile   |   4 +-
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.c  | 912 ++++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.h  | 156 +++
 .../ethernet/huawei/hinic3/hinic3_common.c    |  31 +
 .../ethernet/huawei/hinic3/hinic3_common.h    |  27 +
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |  79 ++
 .../net/ethernet/huawei/hinic3/hinic3_eqs.c   | 803 +++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_eqs.h   | 130 +++
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    |  43 +
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |  31 +
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |  13 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  36 +
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  | 153 ++-
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  16 +
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   | 137 ++-
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |   5 +
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |  65 +-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  | 843 +++++++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  | 127 +++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |   2 +
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  14 +-
 .../huawei/hinic3/hinic3_queue_common.h       |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    |   2 +
 .../net/ethernet/huawei/hinic3/hinic3_wq.c    | 109 +++
 .../net/ethernet/huawei/hinic3/hinic3_wq.h    |  11 +
 25 files changed, 3735 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/Makefile b/drivers/net/ethernet/huawei/hinic3/Makefile
index 509dfbfb0e96..2a0ed8e2c63e 100644
--- a/drivers/net/ethernet/huawei/hinic3/Makefile
+++ b/drivers/net/ethernet/huawei/hinic3/Makefile
@@ -3,7 +3,9 @@
 
 obj-$(CONFIG_HINIC3) += hinic3.o
 
-hinic3-objs := hinic3_common.o \
+hinic3-objs := hinic3_cmdq.o \
+	       hinic3_common.o \
+	       hinic3_eqs.o \
 	       hinic3_hw_cfg.o \
 	       hinic3_hw_comm.o \
 	       hinic3_hwdev.o \
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
new file mode 100644
index 000000000000..f2af187281e0
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
@@ -0,0 +1,912 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
+
+#include <linux/bitfield.h>
+#include <linux/dma-mapping.h>
+
+#include "hinic3_cmdq.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_hwif.h"
+#include "hinic3_mbox.h"
+
+#define CMDQ_BUF_SIZE             2048
+#define CMDQ_WQEBB_SIZE           64
+
+#define CMDQ_CMD_TIMEOUT          5000
+#define CMDQ_ENABLE_WAIT_TIMEOUT  300
+
+#define CMDQ_CTXT_CURR_WQE_PAGE_PFN_MASK  GENMASK_ULL(51, 0)
+#define CMDQ_CTXT_EQ_ID_MASK              GENMASK_ULL(60, 53)
+#define CMDQ_CTXT_CEQ_ARM_MASK            BIT_ULL(61)
+#define CMDQ_CTXT_CEQ_EN_MASK             BIT_ULL(62)
+#define CMDQ_CTXT_HW_BUSY_BIT_MASK        BIT_ULL(63)
+
+#define CMDQ_CTXT_WQ_BLOCK_PFN_MASK       GENMASK_ULL(51, 0)
+#define CMDQ_CTXT_CI_MASK                 GENMASK_ULL(63, 52)
+#define CMDQ_CTXT_SET(val, member)  \
+	FIELD_PREP(CMDQ_CTXT_##member##_MASK, val)
+
+#define CMDQ_WQE_HDR_BUFDESC_LEN_MASK        GENMASK(7, 0)
+#define CMDQ_WQE_HDR_COMPLETE_FMT_MASK       BIT(15)
+#define CMDQ_WQE_HDR_DATA_FMT_MASK           BIT(22)
+#define CMDQ_WQE_HDR_COMPLETE_REQ_MASK       BIT(23)
+#define CMDQ_WQE_HDR_COMPLETE_SECT_LEN_MASK  GENMASK(28, 27)
+#define CMDQ_WQE_HDR_CTRL_LEN_MASK           GENMASK(30, 29)
+#define CMDQ_WQE_HDR_HW_BUSY_BIT_MASK        BIT(31)
+#define CMDQ_WQE_HDR_SET(val, member)  \
+	FIELD_PREP(CMDQ_WQE_HDR_##member##_MASK, val)
+#define CMDQ_WQE_HDR_GET(val, member)  \
+	FIELD_GET(CMDQ_WQE_HDR_##member##_MASK, val)
+
+#define CMDQ_CTRL_PI_MASK              GENMASK(15, 0)
+#define CMDQ_CTRL_CMD_MASK             GENMASK(23, 16)
+#define CMDQ_CTRL_MOD_MASK             GENMASK(28, 24)
+#define CMDQ_CTRL_HW_BUSY_BIT_MASK     BIT(31)
+#define CMDQ_CTRL_SET(val, member)  \
+	FIELD_PREP(CMDQ_CTRL_##member##_MASK, val)
+#define CMDQ_CTRL_GET(val, member)  \
+	FIELD_GET(CMDQ_CTRL_##member##_MASK, val)
+
+#define CMDQ_WQE_ERRCODE_VAL_MASK      GENMASK(30, 0)
+#define CMDQ_WQE_ERRCODE_GET(val, member)  \
+	FIELD_GET(CMDQ_WQE_ERRCODE_##member##_MASK, val)
+
+#define CMDQ_DB_INFO_HI_PROD_IDX_MASK  GENMASK(7, 0)
+#define CMDQ_DB_INFO_SET(val, member)  \
+	FIELD_PREP(CMDQ_DB_INFO_##member##_MASK, val)
+
+#define CMDQ_DB_HEAD_QUEUE_TYPE_MASK   BIT(23)
+#define CMDQ_DB_HEAD_CMDQ_TYPE_MASK    GENMASK(26, 24)
+#define CMDQ_DB_HEAD_SET(val, member)  \
+	FIELD_PREP(CMDQ_DB_HEAD_##member##_MASK, val)
+
+#define CMDQ_CEQE_TYPE_MASK            GENMASK(2, 0)
+#define CMDQ_CEQE_GET(val, member)  \
+	FIELD_GET(CMDQ_CEQE_##member##_MASK, val)
+
+#define CMDQ_WQE_HEADER(wqe)           ((struct cmdq_header *)(wqe))
+#define CMDQ_WQE_COMPLETED(ctrl_info)  CMDQ_CTRL_GET(ctrl_info, HW_BUSY_BIT)
+
+#define CMDQ_PFN(addr)  ((addr) >> 12)
+
+/* cmdq work queue's chip logical address table is up to 512B */
+#define CMDQ_WQ_CLA_SIZE  512
+
+/* Completion codes: send, direct sync, force stop */
+#define CMDQ_SEND_CMPT_CODE         10
+#define CMDQ_DIRECT_SYNC_CMPT_CODE  11
+#define CMDQ_FORCE_STOP_CMPT_CODE   12
+
+enum cmdq_data_format {
+	CMDQ_DATA_SGE    = 0,
+	CMDQ_DATA_DIRECT = 1,
+};
+
+enum cmdq_ctrl_sect_len {
+	CMDQ_CTRL_SECT_LEN        = 1,
+	CMDQ_CTRL_DIRECT_SECT_LEN = 2,
+};
+
+enum cmdq_bufdesc_len {
+	CMDQ_BUFDESC_LCMD_LEN = 2,
+	CMDQ_BUFDESC_SCMD_LEN = 3,
+};
+
+enum cmdq_completion_format {
+	CMDQ_COMPLETE_DIRECT = 0,
+	CMDQ_COMPLETE_SGE    = 1,
+};
+
+enum cmdq_cmd_type {
+	CMDQ_CMD_DIRECT_RESP,
+	CMDQ_CMD_SGE_RESP,
+};
+
+#define CMDQ_WQE_NUM_WQEBBS  1
+
+static struct cmdq_wqe *cmdq_read_wqe(struct hinic3_wq *wq, u16 *ci)
+{
+	if (hinic3_wq_get_used(wq) == 0)
+		return NULL;
+
+	*ci = wq->cons_idx & wq->idx_mask;
+
+	return get_q_element(&wq->qpages, wq->cons_idx, NULL);
+}
+
+struct hinic3_cmd_buf *hinic3_alloc_cmd_buf(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmd_buf *cmd_buf;
+	struct hinic3_cmdqs *cmdqs;
+
+	cmdqs = hwdev->cmdqs;
+
+	cmd_buf = kzalloc(sizeof(*cmd_buf), GFP_ATOMIC);
+	if (!cmd_buf)
+		return NULL;
+
+	cmd_buf->buf = dma_pool_alloc(cmdqs->cmd_buf_pool, GFP_ATOMIC,
+				      &cmd_buf->dma_addr);
+	if (!cmd_buf->buf) {
+		dev_err(hwdev->dev, "Failed to allocate cmdq cmd buf from the pool\n");
+		goto err_free_cmd_buf;
+	}
+
+	cmd_buf->size = CMDQ_BUF_SIZE;
+	refcount_set(&cmd_buf->ref_cnt, 1);
+
+	return cmd_buf;
+
+err_free_cmd_buf:
+	kfree(cmd_buf);
+
+	return NULL;
+}
+
+void hinic3_free_cmd_buf(struct hinic3_hwdev *hwdev,
+			 struct hinic3_cmd_buf *cmd_buf)
+{
+	struct hinic3_cmdqs *cmdqs;
+
+	if (!refcount_dec_and_test(&cmd_buf->ref_cnt))
+		return;
+
+	cmdqs = hwdev->cmdqs;
+
+	dma_pool_free(cmdqs->cmd_buf_pool, cmd_buf->buf, cmd_buf->dma_addr);
+	kfree(cmd_buf);
+}
+
+static void cmdq_clear_cmd_buf(struct hinic3_cmdq_cmd_info *cmd_info,
+			       struct hinic3_hwdev *hwdev)
+{
+	if (cmd_info->buf_in) {
+		hinic3_free_cmd_buf(hwdev, cmd_info->buf_in);
+		cmd_info->buf_in = NULL;
+	}
+}
+
+static void clear_wqe_complete_bit(struct hinic3_cmdq *cmdq,
+				   struct cmdq_wqe *wqe, u16 ci)
+{
+	struct cmdq_header *hdr = CMDQ_WQE_HEADER(wqe);
+	u32 header_info = hdr->header_info;
+	enum cmdq_data_format df;
+	struct cmdq_ctrl *ctrl;
+
+	df = CMDQ_WQE_HDR_GET(header_info, DATA_FMT);
+	if (df == CMDQ_DATA_SGE)
+		ctrl = &wqe->wqe_lcmd.ctrl;
+	else
+		ctrl = &wqe->wqe_scmd.ctrl;
+
+	/* clear HW busy bit */
+	ctrl->ctrl_info = 0;
+	cmdq->cmd_infos[ci].cmd_type = HINIC3_CMD_TYPE_NONE;
+	wmb(); /* verify wqe is clear */
+	hinic3_wq_put_wqebbs(&cmdq->wq, CMDQ_WQE_NUM_WQEBBS);
+}
+
+static void cmdq_update_cmd_status(struct hinic3_cmdq *cmdq, u16 prod_idx,
+				   struct cmdq_wqe *wqe)
+{
+	struct hinic3_cmdq_cmd_info *cmd_info;
+	struct cmdq_wqe_lcmd *wqe_lcmd;
+	u32 status_info;
+
+	wqe_lcmd = &wqe->wqe_lcmd;
+	cmd_info = &cmdq->cmd_infos[prod_idx];
+	if (cmd_info->errcode) {
+		status_info = wqe_lcmd->status.status_info;
+		*cmd_info->errcode = CMDQ_WQE_ERRCODE_GET(status_info, VAL);
+	}
+
+	if (cmd_info->direct_resp)
+		*cmd_info->direct_resp = wqe_lcmd->completion.resp.direct.val;
+}
+
+static void cmdq_sync_cmd_handler(struct hinic3_cmdq *cmdq,
+				  struct cmdq_wqe *wqe, u16 ci)
+{
+	spin_lock(&cmdq->cmdq_lock);
+	cmdq_update_cmd_status(cmdq, ci, wqe);
+	if (cmdq->cmd_infos[ci].cmpt_code) {
+		*cmdq->cmd_infos[ci].cmpt_code = CMDQ_DIRECT_SYNC_CMPT_CODE;
+		cmdq->cmd_infos[ci].cmpt_code = NULL;
+	}
+
+	/* Ensure that completion code has been updated before updating done */
+	smp_rmb();
+	if (cmdq->cmd_infos[ci].done) {
+		complete(cmdq->cmd_infos[ci].done);
+		cmdq->cmd_infos[ci].done = NULL;
+	}
+	spin_unlock(&cmdq->cmdq_lock);
+
+	cmdq_clear_cmd_buf(&cmdq->cmd_infos[ci], cmdq->hwdev);
+	clear_wqe_complete_bit(cmdq, wqe, ci);
+}
+
+void hinic3_cmdq_ceq_handler(struct hinic3_hwdev *hwdev, u32 ceqe_data)
+{
+	enum hinic3_cmdq_type cmdq_type = CMDQ_CEQE_GET(ceqe_data, TYPE);
+	struct hinic3_cmdqs *cmdqs = hwdev->cmdqs;
+	struct hinic3_cmdq_cmd_info *cmd_info;
+	struct cmdq_wqe_lcmd *wqe_lcmd;
+	struct hinic3_cmdq *cmdq;
+	struct cmdq_wqe *wqe;
+	u32 ctrl_info;
+	u16 ci;
+
+	if (unlikely(cmdq_type >= ARRAY_SIZE(cmdqs->cmdq)))
+		return;
+
+	cmdq = &cmdqs->cmdq[cmdq_type];
+	while ((wqe = cmdq_read_wqe(&cmdq->wq, &ci)) != NULL) {
+		cmd_info = &cmdq->cmd_infos[ci];
+		switch (cmd_info->cmd_type) {
+		case HINIC3_CMD_TYPE_NONE:
+			return;
+		case HINIC3_CMD_TYPE_TIMEOUT:
+			dev_warn(hwdev->dev, "Cmdq timeout, q_id: %u, ci: %u\n",
+				 cmdq_type, ci);
+			fallthrough;
+		case HINIC3_CMD_TYPE_FAKE_TIMEOUT:
+			cmdq_clear_cmd_buf(cmd_info, hwdev);
+			clear_wqe_complete_bit(cmdq, wqe, ci);
+			break;
+		default:
+			/* only arm bit is using scmd wqe,
+			 * the other wqe is lcmd
+			 */
+			wqe_lcmd = &wqe->wqe_lcmd;
+			ctrl_info = wqe_lcmd->ctrl.ctrl_info;
+			if (!CMDQ_WQE_COMPLETED(ctrl_info))
+				return;
+
+			dma_rmb();
+			/* For FORCE_STOP cmd_type, we also need to wait for
+			 * the firmware processing to complete to prevent the
+			 * firmware from accessing the released cmd_buf
+			 */
+			if (cmd_info->cmd_type == HINIC3_CMD_TYPE_FORCE_STOP) {
+				cmdq_clear_cmd_buf(cmd_info, hwdev);
+				clear_wqe_complete_bit(cmdq, wqe, ci);
+			} else {
+				cmdq_sync_cmd_handler(cmdq, wqe, ci);
+			}
+
+			break;
+		}
+	}
+}
+
+static int wait_cmdqs_enable(struct hinic3_cmdqs *cmdqs)
+{
+	unsigned long end;
+
+	end = jiffies + msecs_to_jiffies(CMDQ_ENABLE_WAIT_TIMEOUT);
+	do {
+		if (cmdqs->status & HINIC3_CMDQ_ENABLE)
+			return 0;
+	} while (time_before(jiffies, end) && !cmdqs->disable_flag);
+
+	cmdqs->disable_flag = 1;
+
+	return -EBUSY;
+}
+
+static void cmdq_set_completion(struct cmdq_completion *complete,
+				struct hinic3_cmd_buf *buf_out)
+{
+	struct hinic3_sge *sge = &complete->resp.sge;
+
+	hinic3_set_sge(sge, buf_out->dma_addr, CMDQ_BUF_SIZE);
+}
+
+static struct cmdq_wqe *cmdq_get_wqe(struct hinic3_wq *wq, u16 *pi)
+{
+	if (!hinic3_wq_free_wqebbs(wq))
+		return NULL;
+
+	return hinic3_wq_get_one_wqebb(wq, pi);
+}
+
+static void cmdq_set_lcmd_bufdesc(struct cmdq_wqe_lcmd *wqe,
+				  struct hinic3_cmd_buf *buf_in)
+{
+	hinic3_set_sge(&wqe->buf_desc.sge, buf_in->dma_addr, buf_in->size);
+}
+
+static void cmdq_set_db(struct hinic3_cmdq *cmdq,
+			enum hinic3_cmdq_type cmdq_type, u16 prod_idx)
+{
+	u8 __iomem *db_base = cmdq->hwdev->cmdqs->cmdqs_db_base;
+	u16 db_ofs = (prod_idx & 0xFF) << 3;
+	struct cmdq_db db;
+
+	db.db_info = CMDQ_DB_INFO_SET(prod_idx >> 8, HI_PROD_IDX);
+	db.db_head = CMDQ_DB_HEAD_SET(1, QUEUE_TYPE) |
+		     CMDQ_DB_HEAD_SET(cmdq_type, CMDQ_TYPE);
+	writeq(*(u64 *)&db, db_base + db_ofs);
+}
+
+static void cmdq_wqe_fill(struct cmdq_wqe *hw_wqe,
+			  const struct cmdq_wqe *shadow_wqe)
+{
+	const struct cmdq_header *src = (struct cmdq_header *)shadow_wqe;
+	struct cmdq_header *dst = (struct cmdq_header *)hw_wqe;
+	size_t len;
+
+	len = sizeof(struct cmdq_wqe) - sizeof(struct cmdq_header);
+	memcpy(dst + 1, src + 1, len);
+	/* Header should be written last */
+	wmb();
+	WRITE_ONCE(*dst, *src);
+}
+
+static void cmdq_prepare_wqe_ctrl(struct cmdq_wqe *wqe, u8 wrapped,
+				  u8 mod, u8 cmd, u16 prod_idx,
+				  enum cmdq_completion_format complete_format,
+				  enum cmdq_data_format data_format,
+				  enum cmdq_bufdesc_len buf_len)
+{
+	struct cmdq_header *hdr = CMDQ_WQE_HEADER(wqe);
+	enum cmdq_ctrl_sect_len ctrl_len;
+	struct cmdq_wqe_lcmd *wqe_lcmd;
+	struct cmdq_wqe_scmd *wqe_scmd;
+	struct cmdq_ctrl *ctrl;
+
+	if (data_format == CMDQ_DATA_SGE) {
+		wqe_lcmd = &wqe->wqe_lcmd;
+		wqe_lcmd->status.status_info = 0;
+		ctrl = &wqe_lcmd->ctrl;
+		ctrl_len = CMDQ_CTRL_SECT_LEN;
+	} else {
+		wqe_scmd = &wqe->wqe_scmd;
+		wqe_scmd->status.status_info = 0;
+		ctrl = &wqe_scmd->ctrl;
+		ctrl_len = CMDQ_CTRL_DIRECT_SECT_LEN;
+	}
+
+	ctrl->ctrl_info =
+		CMDQ_CTRL_SET(prod_idx, PI) |
+		CMDQ_CTRL_SET(cmd, CMD) |
+		CMDQ_CTRL_SET(mod, MOD);
+
+	hdr->header_info =
+		CMDQ_WQE_HDR_SET(buf_len, BUFDESC_LEN) |
+		CMDQ_WQE_HDR_SET(complete_format, COMPLETE_FMT) |
+		CMDQ_WQE_HDR_SET(data_format, DATA_FMT) |
+		CMDQ_WQE_HDR_SET(1, COMPLETE_REQ) |
+		CMDQ_WQE_HDR_SET(3, COMPLETE_SECT_LEN) |
+		CMDQ_WQE_HDR_SET(ctrl_len, CTRL_LEN) |
+		CMDQ_WQE_HDR_SET(wrapped, HW_BUSY_BIT);
+}
+
+static void cmdq_set_lcmd_wqe(struct cmdq_wqe *wqe,
+			      enum cmdq_cmd_type cmd_type,
+			      struct hinic3_cmd_buf *buf_in,
+			      struct hinic3_cmd_buf *buf_out,
+			      u8 wrapped, u8 mod, u8 cmd, u16 prod_idx)
+{
+	enum cmdq_completion_format complete_format = CMDQ_COMPLETE_DIRECT;
+	struct cmdq_wqe_lcmd *wqe_lcmd = &wqe->wqe_lcmd;
+
+	switch (cmd_type) {
+	case CMDQ_CMD_DIRECT_RESP:
+		wqe_lcmd->completion.resp.direct.val = 0;
+		break;
+	case CMDQ_CMD_SGE_RESP:
+		if (buf_out) {
+			complete_format = CMDQ_COMPLETE_SGE;
+			cmdq_set_completion(&wqe_lcmd->completion, buf_out);
+		}
+		break;
+	}
+
+	cmdq_prepare_wqe_ctrl(wqe, wrapped, mod, cmd, prod_idx, complete_format,
+			      CMDQ_DATA_SGE, CMDQ_BUFDESC_LCMD_LEN);
+	cmdq_set_lcmd_bufdesc(wqe_lcmd, buf_in);
+}
+
+static int hinic3_cmdq_sync_timeout_check(struct hinic3_cmdq *cmdq,
+					  struct cmdq_wqe *wqe, u16 pi)
+{
+	struct cmdq_wqe_lcmd *wqe_lcmd;
+	struct cmdq_ctrl *ctrl;
+	u32 ctrl_info;
+
+	wqe_lcmd = &wqe->wqe_lcmd;
+	ctrl = &wqe_lcmd->ctrl;
+	ctrl_info = ctrl->ctrl_info;
+	if (!CMDQ_WQE_COMPLETED(ctrl_info)) {
+		dev_dbg(cmdq->hwdev->dev, "Cmdq sync command check busy bit not set\n");
+		return -EFAULT;
+	}
+	cmdq_update_cmd_status(cmdq, pi, wqe);
+
+	return 0;
+}
+
+static void clear_cmd_info(struct hinic3_cmdq_cmd_info *cmd_info,
+			   const struct hinic3_cmdq_cmd_info *saved_cmd_info)
+{
+	if (cmd_info->errcode == saved_cmd_info->errcode)
+		cmd_info->errcode = NULL;
+
+	if (cmd_info->done == saved_cmd_info->done)
+		cmd_info->done = NULL;
+
+	if (cmd_info->direct_resp == saved_cmd_info->direct_resp)
+		cmd_info->direct_resp = NULL;
+}
+
+static int wait_cmdq_sync_cmd_completion(struct hinic3_cmdq *cmdq,
+					 struct hinic3_cmdq_cmd_info *cmd_info,
+					 struct hinic3_cmdq_cmd_info *saved_cmd_info,
+					 u64 curr_msg_id, u16 curr_prod_idx,
+					 struct cmdq_wqe *curr_wqe,
+					 u32 timeout)
+{
+	ulong timeo = msecs_to_jiffies(timeout);
+	int err;
+
+	if (wait_for_completion_timeout(saved_cmd_info->done, timeo))
+		return 0;
+
+	spin_lock_bh(&cmdq->cmdq_lock);
+	if (cmd_info->cmpt_code == saved_cmd_info->cmpt_code)
+		cmd_info->cmpt_code = NULL;
+
+	if (*saved_cmd_info->cmpt_code == CMDQ_DIRECT_SYNC_CMPT_CODE) {
+		dev_dbg(cmdq->hwdev->dev, "Cmdq direct sync command has been completed\n");
+		spin_unlock_bh(&cmdq->cmdq_lock);
+		return 0;
+	}
+
+	if (curr_msg_id == cmd_info->cmdq_msg_id) {
+		err = hinic3_cmdq_sync_timeout_check(cmdq, curr_wqe,
+						     curr_prod_idx);
+		if (err)
+			cmd_info->cmd_type = HINIC3_CMD_TYPE_TIMEOUT;
+		else
+			cmd_info->cmd_type = HINIC3_CMD_TYPE_FAKE_TIMEOUT;
+	} else {
+		err = -ETIMEDOUT;
+		dev_err(cmdq->hwdev->dev,
+			"Cmdq sync command current msg id mismatch cmd_info msg id\n");
+	}
+
+	clear_cmd_info(cmd_info, saved_cmd_info);
+	spin_unlock_bh(&cmdq->cmdq_lock);
+
+	return err;
+}
+
+static int cmdq_sync_cmd_direct_resp(struct hinic3_cmdq *cmdq, u8 mod, u8 cmd,
+				     struct hinic3_cmd_buf *buf_in,
+				     u64 *out_param)
+{
+	struct hinic3_cmdq_cmd_info *cmd_info, saved_cmd_info;
+	int cmpt_code = CMDQ_SEND_CMPT_CODE;
+	struct cmdq_wqe *curr_wqe, wqe = {};
+	struct hinic3_wq *wq = &cmdq->wq;
+	u16 curr_prod_idx, next_prod_idx;
+	struct completion done;
+	u64 curr_msg_id;
+	int errcode;
+	u8 wrapped;
+	int err;
+
+	spin_lock_bh(&cmdq->cmdq_lock);
+	curr_wqe = cmdq_get_wqe(wq, &curr_prod_idx);
+	if (!curr_wqe) {
+		spin_unlock_bh(&cmdq->cmdq_lock);
+		return -EBUSY;
+	}
+
+	wrapped = cmdq->wrapped;
+	next_prod_idx = curr_prod_idx + CMDQ_WQE_NUM_WQEBBS;
+	if (next_prod_idx >= wq->q_depth) {
+		cmdq->wrapped ^= 1;
+		next_prod_idx -= wq->q_depth;
+	}
+
+	cmd_info = &cmdq->cmd_infos[curr_prod_idx];
+	init_completion(&done);
+	refcount_inc(&buf_in->ref_cnt);
+	cmd_info->cmd_type = HINIC3_CMD_TYPE_DIRECT_RESP;
+	cmd_info->done = &done;
+	cmd_info->errcode = &errcode;
+	cmd_info->direct_resp = out_param;
+	cmd_info->cmpt_code = &cmpt_code;
+	cmd_info->buf_in = buf_in;
+	saved_cmd_info = *cmd_info;
+	cmdq_set_lcmd_wqe(&wqe, CMDQ_CMD_DIRECT_RESP, buf_in, NULL,
+			  wrapped, mod, cmd, curr_prod_idx);
+
+	cmdq_wqe_fill(curr_wqe, &wqe);
+	(cmd_info->cmdq_msg_id)++;
+	curr_msg_id = cmd_info->cmdq_msg_id;
+	cmdq_set_db(cmdq, HINIC3_CMDQ_SYNC, next_prod_idx);
+	spin_unlock_bh(&cmdq->cmdq_lock);
+
+	err = wait_cmdq_sync_cmd_completion(cmdq, cmd_info, &saved_cmd_info,
+					    curr_msg_id, curr_prod_idx,
+					    curr_wqe, CMDQ_CMD_TIMEOUT);
+	if (err) {
+		dev_err(cmdq->hwdev->dev,
+			"Cmdq sync command timeout, mod: %u, cmd: %u, prod idx: 0x%x\n",
+			mod, cmd, curr_prod_idx);
+		err = -ETIMEDOUT;
+	}
+
+	if (cmpt_code == CMDQ_FORCE_STOP_CMPT_CODE) {
+		dev_dbg(cmdq->hwdev->dev,
+			"Force stop cmdq cmd, mod: %u, cmd: %u\n", mod, cmd);
+		err = -EAGAIN;
+	}
+
+	smp_rmb(); /* read error code after completion */
+
+	return err ? err : errcode;
+}
+
+int hinic3_cmdq_direct_resp(struct hinic3_hwdev *hwdev, u8 mod, u8 cmd,
+			    struct hinic3_cmd_buf *buf_in, u64 *out_param)
+{
+	struct hinic3_cmdqs *cmdqs;
+	int err;
+
+	cmdqs = hwdev->cmdqs;
+	err = wait_cmdqs_enable(cmdqs);
+	if (err) {
+		dev_err(hwdev->dev, "Cmdq is disabled\n");
+		return err;
+	}
+
+	err = cmdq_sync_cmd_direct_resp(&cmdqs->cmdq[HINIC3_CMDQ_SYNC],
+					mod, cmd, buf_in, out_param);
+
+	return err;
+}
+
+static void cmdq_init_queue_ctxt(struct hinic3_hwdev *hwdev, u8 cmdq_id,
+				 struct comm_cmdq_ctxt_info *ctxt_info)
+{
+	const struct hinic3_cmdqs *cmdqs;
+	u64 cmdq_first_block_paddr, pfn;
+	const struct hinic3_wq *wq;
+
+	cmdqs = hwdev->cmdqs;
+	wq = &cmdqs->cmdq[cmdq_id].wq;
+	pfn = CMDQ_PFN(hinic3_wq_get_first_wqe_page_addr(wq));
+
+	ctxt_info->curr_wqe_page_pfn =
+		CMDQ_CTXT_SET(1, HW_BUSY_BIT) |
+		CMDQ_CTXT_SET(1, CEQ_EN)	|
+		CMDQ_CTXT_SET(1, CEQ_ARM)	|
+		CMDQ_CTXT_SET(0, EQ_ID) |
+		CMDQ_CTXT_SET(pfn, CURR_WQE_PAGE_PFN);
+
+	if (!hinic3_wq_is_0_level_cla(wq)) {
+		cmdq_first_block_paddr = cmdqs->wq_block_paddr;
+		pfn = CMDQ_PFN(cmdq_first_block_paddr);
+	}
+
+	ctxt_info->wq_block_pfn =
+		CMDQ_CTXT_SET(wq->cons_idx, CI) |
+		CMDQ_CTXT_SET(pfn, WQ_BLOCK_PFN);
+}
+
+static int init_cmdq(struct hinic3_cmdq *cmdq, struct hinic3_hwdev *hwdev,
+		     enum hinic3_cmdq_type q_type)
+{
+	int err;
+
+	cmdq->cmdq_type = q_type;
+	cmdq->wrapped = 1;
+	cmdq->hwdev = hwdev;
+
+	spin_lock_init(&cmdq->cmdq_lock);
+
+	cmdq->cmd_infos = kcalloc(cmdq->wq.q_depth, sizeof(*cmdq->cmd_infos),
+				  GFP_KERNEL);
+	if (!cmdq->cmd_infos) {
+		err = -ENOMEM;
+		return err;
+	}
+
+	return 0;
+}
+
+static int hinic3_set_cmdq_ctxt(struct hinic3_hwdev *hwdev, u8 cmdq_id)
+{
+	struct comm_cmd_set_cmdq_ctxt cmdq_ctxt = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	cmdq_init_queue_ctxt(hwdev, cmdq_id, &cmdq_ctxt.ctxt);
+	cmdq_ctxt.func_id = hinic3_global_func_id(hwdev);
+	cmdq_ctxt.cmdq_id = cmdq_id;
+
+	mgmt_msg_params_init_default(&msg_params, &cmdq_ctxt,
+				     sizeof(cmdq_ctxt));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
+				       COMM_CMD_SET_CMDQ_CTXT, &msg_params);
+	if (err || cmdq_ctxt.head.status) {
+		dev_err(hwdev->dev, "Failed to set cmdq ctxt, err: %d, status: 0x%x\n",
+			err, cmdq_ctxt.head.status);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int hinic3_set_cmdq_ctxts(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmdqs *cmdqs = hwdev->cmdqs;
+	u8 cmdq_type;
+	int err;
+
+	for (cmdq_type = 0; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
+		err = hinic3_set_cmdq_ctxt(hwdev, cmdq_type);
+		if (err)
+			return err;
+	}
+
+	cmdqs->status |= HINIC3_CMDQ_ENABLE;
+	cmdqs->disable_flag = 0;
+
+	return 0;
+}
+
+static int create_cmdq_wq(struct hinic3_hwdev *hwdev,
+			  struct hinic3_cmdqs *cmdqs)
+{
+	u8 cmdq_type;
+	int err;
+
+	for (cmdq_type = 0; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
+		err = hinic3_wq_create(hwdev, &cmdqs->cmdq[cmdq_type].wq,
+				       CMDQ_DEPTH, CMDQ_WQEBB_SIZE);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to create cmdq wq\n");
+			goto err_destroy_wq;
+		}
+	}
+
+	/* 1-level Chip Logical Address (CLA) must put all
+	 * cmdq's wq page addr in one wq block
+	 */
+	if (!hinic3_wq_is_0_level_cla(&cmdqs->cmdq[HINIC3_CMDQ_SYNC].wq)) {
+		if (cmdqs->cmdq[HINIC3_CMDQ_SYNC].wq.qpages.num_pages >
+		    CMDQ_WQ_CLA_SIZE / sizeof(u64)) {
+			err = -EINVAL;
+			dev_err(hwdev->dev,
+				"Cmdq number of wq pages exceeds limit: %lu\n",
+				CMDQ_WQ_CLA_SIZE / sizeof(u64));
+			goto err_destroy_wq;
+		}
+
+		cmdqs->wq_block_vaddr =
+			dma_alloc_coherent(hwdev->dev, HINIC3_MIN_PAGE_SIZE,
+					   &cmdqs->wq_block_paddr, GFP_KERNEL);
+		if (!cmdqs->wq_block_vaddr) {
+			err = -ENOMEM;
+			goto err_destroy_wq;
+		}
+
+		for (cmdq_type = 0; cmdq_type < cmdqs->cmdq_num; cmdq_type++)
+			memcpy((u8 *)cmdqs->wq_block_vaddr +
+			       CMDQ_WQ_CLA_SIZE * cmdq_type,
+			       cmdqs->cmdq[cmdq_type].wq.wq_block_vaddr,
+			       cmdqs->cmdq[cmdq_type].wq.qpages.num_pages *
+			       sizeof(__be64));
+	}
+
+	return 0;
+
+err_destroy_wq:
+	while (cmdq_type > 0) {
+		cmdq_type--;
+		hinic3_wq_destroy(hwdev, &cmdqs->cmdq[cmdq_type].wq);
+	}
+
+	return err;
+}
+
+static void destroy_cmdq_wq(struct hinic3_hwdev *hwdev,
+			    struct hinic3_cmdqs *cmdqs)
+{
+	u8 cmdq_type;
+
+	if (cmdqs->wq_block_vaddr)
+		dma_free_coherent(hwdev->dev, HINIC3_MIN_PAGE_SIZE,
+				  cmdqs->wq_block_vaddr, cmdqs->wq_block_paddr);
+
+	for (cmdq_type = 0; cmdq_type < cmdqs->cmdq_num; cmdq_type++)
+		hinic3_wq_destroy(hwdev, &cmdqs->cmdq[cmdq_type].wq);
+}
+
+static int init_cmdqs(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmdqs *cmdqs;
+
+	cmdqs = kzalloc(sizeof(*cmdqs), GFP_KERNEL);
+	if (!cmdqs)
+		return -ENOMEM;
+
+	hwdev->cmdqs = cmdqs;
+	cmdqs->hwdev = hwdev;
+	cmdqs->cmdq_num = hwdev->max_cmdq;
+
+	cmdqs->cmd_buf_pool = dma_pool_create("hinic3_cmdq", hwdev->dev,
+					      CMDQ_BUF_SIZE, CMDQ_BUF_SIZE, 0);
+	if (!cmdqs->cmd_buf_pool) {
+		dev_err(hwdev->dev, "Failed to create cmdq buffer pool\n");
+		kfree(cmdqs);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void cmdq_flush_sync_cmd(struct hinic3_cmdq_cmd_info *cmd_info)
+{
+	if (cmd_info->cmd_type != HINIC3_CMD_TYPE_DIRECT_RESP)
+		return;
+
+	cmd_info->cmd_type = HINIC3_CMD_TYPE_FORCE_STOP;
+
+	if (cmd_info->cmpt_code &&
+	    *cmd_info->cmpt_code == CMDQ_SEND_CMPT_CODE)
+		*cmd_info->cmpt_code = CMDQ_FORCE_STOP_CMPT_CODE;
+
+	if (cmd_info->done) {
+		complete(cmd_info->done);
+		cmd_info->done = NULL;
+		cmd_info->cmpt_code = NULL;
+		cmd_info->direct_resp = NULL;
+		cmd_info->errcode = NULL;
+	}
+}
+
+static void hinic3_cmdq_flush_cmd(struct hinic3_cmdq *cmdq)
+{
+	struct hinic3_cmdq_cmd_info *cmd_info;
+	u16 ci;
+
+	spin_lock_bh(&cmdq->cmdq_lock);
+	while (cmdq_read_wqe(&cmdq->wq, &ci)) {
+		hinic3_wq_put_wqebbs(&cmdq->wq, CMDQ_WQE_NUM_WQEBBS);
+		cmd_info = &cmdq->cmd_infos[ci];
+		if (cmd_info->cmd_type == HINIC3_CMD_TYPE_DIRECT_RESP)
+			cmdq_flush_sync_cmd(cmd_info);
+	}
+	spin_unlock_bh(&cmdq->cmdq_lock);
+}
+
+void hinic3_cmdq_flush_sync_cmd(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmdq *cmdq;
+	u16 wqe_cnt, wqe_idx, i;
+	struct hinic3_wq *wq;
+
+	cmdq = &hwdev->cmdqs->cmdq[HINIC3_CMDQ_SYNC];
+	spin_lock_bh(&cmdq->cmdq_lock);
+	wq = &cmdq->wq;
+	wqe_cnt = hinic3_wq_get_used(wq);
+	for (i = 0; i < wqe_cnt; i++) {
+		wqe_idx = (wq->cons_idx + i) & wq->idx_mask;
+		cmdq_flush_sync_cmd(cmdq->cmd_infos + wqe_idx);
+	}
+	spin_unlock_bh(&cmdq->cmdq_lock);
+}
+
+static void hinic3_cmdq_reset_all_cmd_buf(struct hinic3_cmdq *cmdq)
+{
+	u16 i;
+
+	for (i = 0; i < cmdq->wq.q_depth; i++)
+		cmdq_clear_cmd_buf(&cmdq->cmd_infos[i], cmdq->hwdev);
+}
+
+int hinic3_reinit_cmdq_ctxts(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmdqs *cmdqs = hwdev->cmdqs;
+	u8 cmdq_type;
+
+	for (cmdq_type = 0; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
+		hinic3_cmdq_flush_cmd(&cmdqs->cmdq[cmdq_type]);
+		hinic3_cmdq_reset_all_cmd_buf(&cmdqs->cmdq[cmdq_type]);
+		cmdqs->cmdq[cmdq_type].wrapped = 1;
+		hinic3_wq_reset(&cmdqs->cmdq[cmdq_type].wq);
+	}
+
+	return hinic3_set_cmdq_ctxts(hwdev);
+}
+
+int hinic3_cmdqs_init(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmdqs *cmdqs;
+	void __iomem *db_base;
+	u8 cmdq_type;
+	int err;
+
+	err = init_cmdqs(hwdev);
+	if (err)
+		goto err_out;
+
+	cmdqs = hwdev->cmdqs;
+	err = create_cmdq_wq(hwdev, cmdqs);
+	if (err)
+		goto err_free_cmdqs;
+
+	err = hinic3_alloc_db_addr(hwdev, &db_base, NULL);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to allocate doorbell address\n");
+		goto err_destroy_cmdq_wq;
+	}
+	cmdqs->cmdqs_db_base = db_base;
+
+	for (cmdq_type = 0; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
+		err = init_cmdq(&cmdqs->cmdq[cmdq_type], hwdev, cmdq_type);
+		if (err) {
+			dev_err(hwdev->dev,
+				"Failed to initialize cmdq type : %d\n",
+				cmdq_type);
+			goto err_free_cmd_infos;
+		}
+	}
+
+	err = hinic3_set_cmdq_ctxts(hwdev);
+	if (err)
+		goto err_free_cmd_infos;
+
+	return 0;
+
+err_free_cmd_infos:
+	while (cmdq_type > 0) {
+		cmdq_type--;
+		kfree(cmdqs->cmdq[cmdq_type].cmd_infos);
+	}
+
+	hinic3_free_db_addr(hwdev, cmdqs->cmdqs_db_base);
+
+err_destroy_cmdq_wq:
+	destroy_cmdq_wq(hwdev, cmdqs);
+
+err_free_cmdqs:
+	dma_pool_destroy(cmdqs->cmd_buf_pool);
+	kfree(cmdqs);
+
+err_out:
+	return err;
+}
+
+void hinic3_cmdqs_free(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmdqs *cmdqs = hwdev->cmdqs;
+	u8 cmdq_type;
+
+	cmdqs->status &= ~HINIC3_CMDQ_ENABLE;
+
+	for (cmdq_type = 0; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
+		hinic3_cmdq_flush_cmd(&cmdqs->cmdq[cmdq_type]);
+		hinic3_cmdq_reset_all_cmd_buf(&cmdqs->cmdq[cmdq_type]);
+		kfree(cmdqs->cmdq[cmdq_type].cmd_infos);
+	}
+
+	hinic3_free_db_addr(hwdev, cmdqs->cmdqs_db_base);
+	destroy_cmdq_wq(hwdev, cmdqs);
+	dma_pool_destroy(cmdqs->cmd_buf_pool);
+	kfree(cmdqs);
+}
+
+bool hinic3_cmdq_idle(struct hinic3_cmdq *cmdq)
+{
+	return hinic3_wq_get_used(&cmdq->wq) == 0;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h
new file mode 100644
index 000000000000..c1d1c4e20ffe
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. */
+
+#ifndef _HINIC3_CMDQ_H_
+#define _HINIC3_CMDQ_H_
+
+#include <linux/dmapool.h>
+
+#include "hinic3_hw_intf.h"
+#include "hinic3_wq.h"
+
+#define CMDQ_DEPTH  4096
+
+struct cmdq_db {
+	u32 db_head;
+	u32 db_info;
+};
+
+/* hw defined cmdq wqe header */
+struct cmdq_header {
+	u32 header_info;
+	u32 saved_data;
+};
+
+struct cmdq_lcmd_bufdesc {
+	struct hinic3_sge sge;
+	u64               rsvd2;
+	u64               rsvd3;
+};
+
+struct cmdq_status {
+	u32 status_info;
+};
+
+struct cmdq_ctrl {
+	u32 ctrl_info;
+};
+
+struct cmdq_direct_resp {
+	u64 val;
+	u64 rsvd;
+};
+
+struct cmdq_completion {
+	union {
+		struct hinic3_sge       sge;
+		struct cmdq_direct_resp direct;
+	} resp;
+};
+
+struct cmdq_wqe_scmd {
+	struct cmdq_header     header;
+	u64                    rsvd3;
+	struct cmdq_status     status;
+	struct cmdq_ctrl       ctrl;
+	struct cmdq_completion completion;
+	u32                    rsvd10[6];
+};
+
+struct cmdq_wqe_lcmd {
+	struct cmdq_header       header;
+	struct cmdq_status       status;
+	struct cmdq_ctrl         ctrl;
+	struct cmdq_completion   completion;
+	struct cmdq_lcmd_bufdesc buf_desc;
+};
+
+struct cmdq_wqe {
+	union {
+		struct cmdq_wqe_scmd wqe_scmd;
+		struct cmdq_wqe_lcmd wqe_lcmd;
+	};
+};
+
+static_assert(sizeof(struct cmdq_wqe) == 64);
+
+enum hinic3_cmdq_type {
+	HINIC3_CMDQ_SYNC      = 0,
+	HINIC3_MAX_CMDQ_TYPES = 4
+};
+
+enum hinic3_cmdq_status {
+	HINIC3_CMDQ_ENABLE = BIT(0),
+};
+
+enum hinic3_cmdq_cmd_type {
+	HINIC3_CMD_TYPE_NONE,
+	HINIC3_CMD_TYPE_DIRECT_RESP,
+	HINIC3_CMD_TYPE_FAKE_TIMEOUT,
+	HINIC3_CMD_TYPE_TIMEOUT,
+	HINIC3_CMD_TYPE_FORCE_STOP,
+};
+
+struct hinic3_cmd_buf {
+	void       *buf;
+	dma_addr_t dma_addr;
+	u16        size;
+	refcount_t ref_cnt;
+};
+
+struct hinic3_cmdq_cmd_info {
+	enum hinic3_cmdq_cmd_type cmd_type;
+	struct completion         *done;
+	int                       *errcode;
+	/* completion code */
+	int                       *cmpt_code;
+	u64                       *direct_resp;
+	u64                       cmdq_msg_id;
+	struct hinic3_cmd_buf     *buf_in;
+};
+
+struct hinic3_cmdq {
+	struct hinic3_wq            wq;
+	enum hinic3_cmdq_type       cmdq_type;
+	u8                          wrapped;
+	/* synchronize command submission with completions via event queue */
+	spinlock_t                  cmdq_lock;
+	struct hinic3_cmdq_cmd_info *cmd_infos;
+	struct hinic3_hwdev         *hwdev;
+};
+
+struct hinic3_cmdqs {
+	struct hinic3_hwdev *hwdev;
+	struct hinic3_cmdq  cmdq[HINIC3_MAX_CMDQ_TYPES];
+	struct dma_pool     *cmd_buf_pool;
+	/* doorbell area */
+	u8 __iomem          *cmdqs_db_base;
+
+	/* When command queue uses multiple memory pages (1-level CLA), this
+	 * block will hold aggregated indirection table for all command queues
+	 * of cmdqs. Not used for small cmdq (0-level CLA).
+	 */
+	dma_addr_t          wq_block_paddr;
+	void                *wq_block_vaddr;
+
+	u32                 status;
+	u32                 disable_flag;
+	u8                  cmdq_num;
+};
+
+int hinic3_cmdqs_init(struct hinic3_hwdev *hwdev);
+void hinic3_cmdqs_free(struct hinic3_hwdev *hwdev);
+
+struct hinic3_cmd_buf *hinic3_alloc_cmd_buf(struct hinic3_hwdev *hwdev);
+void hinic3_free_cmd_buf(struct hinic3_hwdev *hwdev,
+			 struct hinic3_cmd_buf *cmd_buf);
+void hinic3_cmdq_ceq_handler(struct hinic3_hwdev *hwdev, u32 ceqe_data);
+
+int hinic3_cmdq_direct_resp(struct hinic3_hwdev *hwdev, u8 mod, u8 cmd,
+			    struct hinic3_cmd_buf *buf_in, u64 *out_param);
+
+void hinic3_cmdq_flush_sync_cmd(struct hinic3_hwdev *hwdev);
+int hinic3_reinit_cmdq_ctxts(struct hinic3_hwdev *hwdev);
+bool hinic3_cmdq_idle(struct hinic3_cmdq *cmdq);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.c b/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
index 0aa42068728c..016da1911072 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
@@ -3,6 +3,7 @@
 
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/iopoll.h>
 
 #include "hinic3_common.h"
 
@@ -51,3 +52,33 @@ void hinic3_dma_free_coherent_align(struct device *dev,
 	dma_free_coherent(dev, mem_align->real_size,
 			  mem_align->ori_vaddr, mem_align->ori_paddr);
 }
+
+int hinic3_wait_for_timeout(void *priv_data, wait_cpl_handler handler,
+			    u32 wait_total_ms, u32 wait_once_us)
+{
+	enum hinic3_wait_return ret;
+	int err;
+
+	err = read_poll_timeout(handler, ret, ret == HINIC3_WAIT_PROCESS_CPL,
+				wait_once_us, wait_total_ms * USEC_PER_MSEC,
+				false, priv_data);
+
+	return err;
+}
+
+/* Data provided to/by cmdq is arranged in structs with little endian fields but
+ * every dword (32bits) should be swapped since HW swaps it again when it
+ * copies it from/to host memory. This is a mandatory swap regardless of the
+ * CPU endianness.
+ */
+void hinic3_cmdq_buf_swab32(void *data, int len)
+{
+	int i, chunk_sz = sizeof(u32);
+	int data_len = len;
+	u32 *mem = data;
+
+	data_len = data_len / chunk_sz;
+
+	for (i = 0; i < data_len; i++)
+		mem[i] = swab32(mem[i]);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.h b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
index bb795dace04c..50d1fd038b48 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
@@ -18,10 +18,37 @@ struct hinic3_dma_addr_align {
 	dma_addr_t align_paddr;
 };
 
+enum hinic3_wait_return {
+	HINIC3_WAIT_PROCESS_CPL     = 0,
+	HINIC3_WAIT_PROCESS_WAITING = 1,
+};
+
+struct hinic3_sge {
+	u32 hi_addr;
+	u32 lo_addr;
+	u32 len;
+	u32 rsvd;
+};
+
+static inline void hinic3_set_sge(struct hinic3_sge *sge, dma_addr_t addr,
+				  int len)
+{
+	sge->hi_addr = upper_32_bits(addr);
+	sge->lo_addr = lower_32_bits(addr);
+	sge->len = len;
+	sge->rsvd = 0;
+}
+
 int hinic3_dma_zalloc_coherent_align(struct device *dev, u32 size, u32 align,
 				     gfp_t flag,
 				     struct hinic3_dma_addr_align *mem_align);
 void hinic3_dma_free_coherent_align(struct device *dev,
 				    struct hinic3_dma_addr_align *mem_align);
 
+typedef enum hinic3_wait_return (*wait_cpl_handler)(void *priv_data);
+int hinic3_wait_for_timeout(void *priv_data, wait_cpl_handler handler,
+			    u32 wait_total_ms, u32 wait_once_us);
+
+void hinic3_cmdq_buf_swab32(void *data, int len);
+
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h b/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
new file mode 100644
index 000000000000..e7417e8efa99
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. */
+
+#ifndef _HINIC3_CSR_H_
+#define _HINIC3_CSR_H_
+
+#define HINIC3_CFG_REGS_FLAG                  0x40000000
+#define HINIC3_REGS_FLAG_MASK                 0x3FFFFFFF
+
+#define HINIC3_VF_CFG_REG_OFFSET              0x2000
+
+/* HW interface registers */
+#define HINIC3_CSR_FUNC_ATTR0_ADDR            (HINIC3_CFG_REGS_FLAG + 0x0)
+#define HINIC3_CSR_FUNC_ATTR1_ADDR            (HINIC3_CFG_REGS_FLAG + 0x4)
+#define HINIC3_CSR_FUNC_ATTR2_ADDR            (HINIC3_CFG_REGS_FLAG + 0x8)
+#define HINIC3_CSR_FUNC_ATTR3_ADDR            (HINIC3_CFG_REGS_FLAG + 0xC)
+#define HINIC3_CSR_FUNC_ATTR4_ADDR            (HINIC3_CFG_REGS_FLAG + 0x10)
+#define HINIC3_CSR_FUNC_ATTR5_ADDR            (HINIC3_CFG_REGS_FLAG + 0x14)
+#define HINIC3_CSR_FUNC_ATTR6_ADDR            (HINIC3_CFG_REGS_FLAG + 0x18)
+
+#define HINIC3_FUNC_CSR_MAILBOX_DATA_OFF      0x80
+#define HINIC3_FUNC_CSR_MAILBOX_CONTROL_OFF   (HINIC3_CFG_REGS_FLAG + 0x0100)
+#define HINIC3_FUNC_CSR_MAILBOX_INT_OFF       (HINIC3_CFG_REGS_FLAG + 0x0104)
+#define HINIC3_FUNC_CSR_MAILBOX_RESULT_H_OFF  (HINIC3_CFG_REGS_FLAG + 0x0108)
+#define HINIC3_FUNC_CSR_MAILBOX_RESULT_L_OFF  (HINIC3_CFG_REGS_FLAG + 0x010C)
+
+#define HINIC3_CSR_DMA_ATTR_TBL_ADDR          (HINIC3_CFG_REGS_FLAG + 0x380)
+#define HINIC3_CSR_DMA_ATTR_INDIR_IDX_ADDR    (HINIC3_CFG_REGS_FLAG + 0x390)
+
+/* MSI-X registers */
+#define HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR       (HINIC3_CFG_REGS_FLAG + 0x58)
+
+#define HINIC3_MSI_CLR_INDIR_RESEND_TIMER_CLR_MASK  BIT(0)
+#define HINIC3_MSI_CLR_INDIR_INT_MSK_SET_MASK       BIT(1)
+#define HINIC3_MSI_CLR_INDIR_INT_MSK_CLR_MASK       BIT(2)
+#define HINIC3_MSI_CLR_INDIR_AUTO_MSK_SET_MASK      BIT(3)
+#define HINIC3_MSI_CLR_INDIR_AUTO_MSK_CLR_MASK      BIT(4)
+#define HINIC3_MSI_CLR_INDIR_SIMPLE_INDIR_IDX_MASK  GENMASK(31, 22)
+#define HINIC3_MSI_CLR_INDIR_SET(val, member)  \
+	FIELD_PREP(HINIC3_MSI_CLR_INDIR_##member##_MASK, val)
+
+/* EQ registers */
+#define HINIC3_AEQ_INDIR_IDX_ADDR      (HINIC3_CFG_REGS_FLAG + 0x210)
+#define HINIC3_CEQ_INDIR_IDX_ADDR      (HINIC3_CFG_REGS_FLAG + 0x290)
+
+#define HINIC3_EQ_INDIR_IDX_ADDR(type)  \
+	((type == HINIC3_AEQ) ? HINIC3_AEQ_INDIR_IDX_ADDR :  \
+	 HINIC3_CEQ_INDIR_IDX_ADDR)
+
+#define HINIC3_AEQ_MTT_OFF_BASE_ADDR   (HINIC3_CFG_REGS_FLAG + 0x240)
+#define HINIC3_CEQ_MTT_OFF_BASE_ADDR   (HINIC3_CFG_REGS_FLAG + 0x2C0)
+
+#define HINIC3_CSR_EQ_PAGE_OFF_STRIDE  8
+
+#define HINIC3_AEQ_HI_PHYS_ADDR_REG(pg_num)  \
+	(HINIC3_AEQ_MTT_OFF_BASE_ADDR + (pg_num) *  \
+	 HINIC3_CSR_EQ_PAGE_OFF_STRIDE)
+
+#define HINIC3_AEQ_LO_PHYS_ADDR_REG(pg_num)  \
+	(HINIC3_AEQ_MTT_OFF_BASE_ADDR + (pg_num) *  \
+	 HINIC3_CSR_EQ_PAGE_OFF_STRIDE + 4)
+
+#define HINIC3_CEQ_HI_PHYS_ADDR_REG(pg_num)  \
+	(HINIC3_CEQ_MTT_OFF_BASE_ADDR + (pg_num) *  \
+	 HINIC3_CSR_EQ_PAGE_OFF_STRIDE)
+
+#define HINIC3_CEQ_LO_PHYS_ADDR_REG(pg_num)  \
+	(HINIC3_CEQ_MTT_OFF_BASE_ADDR + (pg_num) *  \
+	 HINIC3_CSR_EQ_PAGE_OFF_STRIDE + 4)
+
+#define HINIC3_CSR_AEQ_CTRL_0_ADDR           (HINIC3_CFG_REGS_FLAG + 0x200)
+#define HINIC3_CSR_AEQ_CTRL_1_ADDR           (HINIC3_CFG_REGS_FLAG + 0x204)
+#define HINIC3_CSR_AEQ_PROD_IDX_ADDR         (HINIC3_CFG_REGS_FLAG + 0x20C)
+#define HINIC3_CSR_AEQ_CI_SIMPLE_INDIR_ADDR  (HINIC3_CFG_REGS_FLAG + 0x50)
+
+#define HINIC3_CSR_CEQ_PROD_IDX_ADDR         (HINIC3_CFG_REGS_FLAG + 0x28c)
+#define HINIC3_CSR_CEQ_CI_SIMPLE_INDIR_ADDR  (HINIC3_CFG_REGS_FLAG + 0x54)
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
new file mode 100644
index 000000000000..0d1f1b406064
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
@@ -0,0 +1,803 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
+
+#include <linux/delay.h>
+
+#include "hinic3_csr.h"
+#include "hinic3_eqs.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_hwif.h"
+#include "hinic3_mbox.h"
+
+#define AEQ_CTRL_0_INTR_IDX_MASK      GENMASK(9, 0)
+#define AEQ_CTRL_0_DMA_ATTR_MASK      GENMASK(17, 12)
+#define AEQ_CTRL_0_PCI_INTF_IDX_MASK  GENMASK(22, 20)
+#define AEQ_CTRL_0_INTR_MODE_MASK     BIT(31)
+#define AEQ_CTRL_0_SET(val, member)  \
+	FIELD_PREP(AEQ_CTRL_0_##member##_MASK, val)
+
+#define AEQ_CTRL_1_LEN_MASK           GENMASK(20, 0)
+#define AEQ_CTRL_1_ELEM_SIZE_MASK     GENMASK(25, 24)
+#define AEQ_CTRL_1_PAGE_SIZE_MASK     GENMASK(31, 28)
+#define AEQ_CTRL_1_SET(val, member)  \
+	FIELD_PREP(AEQ_CTRL_1_##member##_MASK, val)
+
+#define CEQ_CTRL_0_INTR_IDX_MASK      GENMASK(9, 0)
+#define CEQ_CTRL_0_DMA_ATTR_MASK      GENMASK(17, 12)
+#define CEQ_CTRL_0_LIMIT_KICK_MASK    GENMASK(23, 20)
+#define CEQ_CTRL_0_PCI_INTF_IDX_MASK  GENMASK(25, 24)
+#define CEQ_CTRL_0_PAGE_SIZE_MASK     GENMASK(30, 27)
+#define CEQ_CTRL_0_INTR_MODE_MASK     BIT(31)
+#define CEQ_CTRL_0_SET(val, member)  \
+	FIELD_PREP(CEQ_CTRL_0_##member##_MASK, val)
+
+#define CEQ_CTRL_1_LEN_MASK           GENMASK(19, 0)
+#define CEQ_CTRL_1_SET(val, member)  \
+	FIELD_PREP(CEQ_CTRL_1_##member##_MASK, val)
+
+#define CEQE_TYPE_MASK                GENMASK(25, 23)
+#define CEQE_TYPE(type)               FIELD_GET(CEQE_TYPE_MASK, type)
+
+#define CEQE_DATA_MASK                GENMASK(25, 0)
+#define CEQE_DATA(data)               ((data) & CEQE_DATA_MASK)
+
+#define EQ_ELEM_DESC_TYPE_MASK        GENMASK(6, 0)
+#define EQ_ELEM_DESC_SRC_MASK         BIT(7)
+#define EQ_ELEM_DESC_SIZE_MASK        GENMASK(15, 8)
+#define EQ_ELEM_DESC_WRAPPED_MASK     BIT(31)
+#define EQ_ELEM_DESC_GET(val, member)  \
+	FIELD_GET(EQ_ELEM_DESC_##member##_MASK, val)
+
+#define EQ_CI_SIMPLE_INDIR_CI_MASK       GENMASK(20, 0)
+#define EQ_CI_SIMPLE_INDIR_ARMED_MASK    BIT(21)
+#define EQ_CI_SIMPLE_INDIR_AEQ_IDX_MASK  GENMASK(31, 30)
+#define EQ_CI_SIMPLE_INDIR_CEQ_IDX_MASK  GENMASK(31, 24)
+#define EQ_CI_SIMPLE_INDIR_SET(val, member)  \
+	FIELD_PREP(EQ_CI_SIMPLE_INDIR_##member##_MASK, val)
+
+#define EQ_CI_SIMPLE_INDIR_REG_ADDR(eq)  \
+	(((eq)->type == HINIC3_AEQ) ?  \
+	 HINIC3_CSR_AEQ_CI_SIMPLE_INDIR_ADDR :  \
+	 HINIC3_CSR_CEQ_CI_SIMPLE_INDIR_ADDR)
+
+#define EQ_PROD_IDX_REG_ADDR(eq)  \
+	(((eq)->type == HINIC3_AEQ) ?  \
+	 HINIC3_CSR_AEQ_PROD_IDX_ADDR : HINIC3_CSR_CEQ_PROD_IDX_ADDR)
+
+#define EQ_HI_PHYS_ADDR_REG(type, pg_num)  \
+	(((type) == HINIC3_AEQ) ?  \
+	       HINIC3_AEQ_HI_PHYS_ADDR_REG(pg_num) :  \
+	       HINIC3_CEQ_HI_PHYS_ADDR_REG(pg_num))
+
+#define EQ_LO_PHYS_ADDR_REG(type, pg_num)  \
+	(((type) == HINIC3_AEQ) ?  \
+	       HINIC3_AEQ_LO_PHYS_ADDR_REG(pg_num) :  \
+	       HINIC3_CEQ_LO_PHYS_ADDR_REG(pg_num))
+
+#define EQ_MSIX_RESEND_TIMER_CLEAR  1
+
+#define HINIC3_EQ_MAX_PAGES(eq)  \
+	((eq)->type == HINIC3_AEQ ?  \
+	 HINIC3_AEQ_MAX_PAGES : HINIC3_CEQ_MAX_PAGES)
+
+#define HINIC3_TASK_PROCESS_EQE_LIMIT  1024
+#define HINIC3_EQ_UPDATE_CI_STEP       64
+#define HINIC3_EQS_WQ_NAME             "hinic3_eqs"
+
+#define HINIC3_EQ_VALID_SHIFT          31
+#define HINIC3_EQ_WRAPPED(eq)  \
+	((eq)->wrapped << HINIC3_EQ_VALID_SHIFT)
+
+#define HINIC3_EQ_WRAPPED_SHIFT        20
+#define HINIC3_EQ_CONS_IDX(eq)  \
+	((eq)->cons_idx | ((eq)->wrapped << HINIC3_EQ_WRAPPED_SHIFT))
+
+static const struct hinic3_aeq_elem *get_curr_aeq_elem(const struct hinic3_eq *eq)
+{
+	return get_q_element(&eq->qpages, eq->cons_idx, NULL);
+}
+
+static const __be32 *get_curr_ceq_elem(const struct hinic3_eq *eq)
+{
+	return get_q_element(&eq->qpages, eq->cons_idx, NULL);
+}
+
+int hinic3_aeq_register_cb(struct hinic3_hwdev *hwdev,
+			   enum hinic3_aeq_type event,
+			   hinic3_aeq_event_cb hwe_cb)
+{
+	struct hinic3_aeqs *aeqs;
+	unsigned long *cb_state;
+
+	aeqs = hwdev->aeqs;
+	cb_state = &aeqs->aeq_cb_state[event];
+	aeqs->aeq_cb[event] = hwe_cb;
+	set_bit(HINIC3_AEQ_CB_REG, cb_state);
+
+	return 0;
+}
+
+void hinic3_aeq_unregister_cb(struct hinic3_hwdev *hwdev,
+			      enum hinic3_aeq_type event)
+{
+	struct hinic3_aeqs *aeqs;
+	unsigned long *cb_state;
+
+	aeqs = hwdev->aeqs;
+	cb_state = &aeqs->aeq_cb_state[event];
+	clear_bit(HINIC3_AEQ_CB_REG, cb_state);
+	/* Ensure handler can observe our intent to unregister. */
+	mb();
+	while (test_bit(HINIC3_AEQ_CB_RUNNING, cb_state))
+		usleep_range(HINIC3_EQ_USLEEP_LOW_BOUND,
+			     HINIC3_EQ_USLEEP_HIGH_BOUND);
+
+	aeqs->aeq_cb[event] = NULL;
+}
+
+int hinic3_ceq_register_cb(struct hinic3_hwdev *hwdev,
+			   enum hinic3_ceq_event event,
+			   hinic3_ceq_event_cb callback)
+{
+	struct hinic3_ceqs *ceqs;
+
+	ceqs = hwdev->ceqs;
+	ceqs->ceq_cb[event] = callback;
+	set_bit(HINIC3_CEQ_CB_REG, &ceqs->ceq_cb_state[event]);
+
+	return 0;
+}
+
+void hinic3_ceq_unregister_cb(struct hinic3_hwdev *hwdev,
+			      enum hinic3_ceq_event event)
+{
+	struct hinic3_ceqs *ceqs;
+
+	ceqs = hwdev->ceqs;
+	clear_bit(HINIC3_CEQ_CB_REG, &ceqs->ceq_cb_state[event]);
+	/* Ensure handler can observe our intent to unregister. */
+	mb();
+	while (test_bit(HINIC3_CEQ_CB_RUNNING, &ceqs->ceq_cb_state[event]))
+		usleep_range(HINIC3_EQ_USLEEP_LOW_BOUND,
+			     HINIC3_EQ_USLEEP_HIGH_BOUND);
+
+	ceqs->ceq_cb[event] = NULL;
+}
+
+/* Set consumer index in the hw. */
+static void set_eq_cons_idx(struct hinic3_eq *eq, u32 arm_state)
+{
+	u32 addr = EQ_CI_SIMPLE_INDIR_REG_ADDR(eq);
+	u32 eq_wrap_ci, val;
+
+	eq_wrap_ci = HINIC3_EQ_CONS_IDX(eq);
+	val = EQ_CI_SIMPLE_INDIR_SET(arm_state, ARMED);
+	if (eq->type == HINIC3_AEQ) {
+		val = val |
+			EQ_CI_SIMPLE_INDIR_SET(eq_wrap_ci, CI) |
+			EQ_CI_SIMPLE_INDIR_SET(eq->q_id, AEQ_IDX);
+	} else {
+		val = val |
+			EQ_CI_SIMPLE_INDIR_SET(eq_wrap_ci, CI) |
+			EQ_CI_SIMPLE_INDIR_SET(eq->q_id, CEQ_IDX);
+	}
+
+	hinic3_hwif_write_reg(eq->hwdev->hwif, addr, val);
+}
+
+static struct hinic3_ceqs *ceq_to_ceqs(const struct hinic3_eq *eq)
+{
+	return container_of(eq, struct hinic3_ceqs, ceq[eq->q_id]);
+}
+
+static void ceq_event_handler(struct hinic3_ceqs *ceqs, u32 ceqe)
+{
+	enum hinic3_ceq_event event = CEQE_TYPE(ceqe);
+	struct hinic3_hwdev *hwdev = ceqs->hwdev;
+	u32 ceqe_data = CEQE_DATA(ceqe);
+
+	if (event >= HINIC3_MAX_CEQ_EVENTS) {
+		dev_warn(hwdev->dev, "Ceq unknown event:%d, ceqe data: 0x%x\n",
+			 event, ceqe_data);
+		return;
+	}
+
+	set_bit(HINIC3_CEQ_CB_RUNNING, &ceqs->ceq_cb_state[event]);
+	/* Ensure unregister sees we are running. */
+	mb();
+	if (ceqs->ceq_cb[event] &&
+	    test_bit(HINIC3_CEQ_CB_REG, &ceqs->ceq_cb_state[event]))
+		ceqs->ceq_cb[event](hwdev, ceqe_data);
+
+	clear_bit(HINIC3_CEQ_CB_RUNNING, &ceqs->ceq_cb_state[event]);
+}
+
+static struct hinic3_aeqs *aeq_to_aeqs(const struct hinic3_eq *eq)
+{
+	return container_of(eq, struct hinic3_aeqs, aeq[eq->q_id]);
+}
+
+static void aeq_event_handler(struct hinic3_aeqs *aeqs, u32 aeqe,
+			      const struct hinic3_aeq_elem *aeqe_pos)
+{
+	struct hinic3_hwdev *hwdev = aeqs->hwdev;
+	u8 data[HINIC3_AEQE_DATA_SIZE], size;
+	enum hinic3_aeq_type event;
+	hinic3_aeq_event_cb hwe_cb;
+	unsigned long *cb_state;
+
+	if (EQ_ELEM_DESC_GET(aeqe, SRC))
+		return;
+
+	event = EQ_ELEM_DESC_GET(aeqe, TYPE);
+	if (event >= HINIC3_MAX_AEQ_EVENTS) {
+		dev_warn(hwdev->dev, "Aeq unknown event:%d\n", event);
+		return;
+	}
+
+	memcpy(data, aeqe_pos->aeqe_data, HINIC3_AEQE_DATA_SIZE);
+	hinic3_cmdq_buf_swab32(data, HINIC3_AEQE_DATA_SIZE);
+	size = EQ_ELEM_DESC_GET(aeqe, SIZE);
+	cb_state = &aeqs->aeq_cb_state[event];
+	set_bit(HINIC3_AEQ_CB_RUNNING, cb_state);
+	/* Ensure unregister sees we are running. */
+	mb();
+	hwe_cb = aeqs->aeq_cb[event];
+	if (hwe_cb && test_bit(HINIC3_AEQ_CB_REG, cb_state))
+		hwe_cb(aeqs->hwdev, data, size);
+	clear_bit(HINIC3_AEQ_CB_RUNNING, cb_state);
+}
+
+static int aeq_irq_handler(struct hinic3_eq *eq)
+{
+	const struct hinic3_aeq_elem *aeqe_pos;
+	struct hinic3_aeqs *aeqs;
+	u32 i, eqe_cnt = 0;
+	u32 aeqe;
+
+	aeqs = aeq_to_aeqs(eq);
+	for (i = 0; i < HINIC3_TASK_PROCESS_EQE_LIMIT; i++) {
+		aeqe_pos = get_curr_aeq_elem(eq);
+		aeqe = be32_to_cpu(aeqe_pos->desc);
+		/* HW updates wrapped bit, when it adds eq element event */
+		if (EQ_ELEM_DESC_GET(aeqe, WRAPPED) == eq->wrapped)
+			return 0;
+
+		/* Prevent speculative reads from element */
+		dma_rmb();
+		aeq_event_handler(aeqs, aeqe, aeqe_pos);
+		eq->cons_idx++;
+		if (eq->cons_idx == eq->eq_len) {
+			eq->cons_idx = 0;
+			eq->wrapped = !eq->wrapped;
+		}
+
+		if (++eqe_cnt >= HINIC3_EQ_UPDATE_CI_STEP) {
+			eqe_cnt = 0;
+			set_eq_cons_idx(eq, HINIC3_EQ_NOT_ARMED);
+		}
+	}
+
+	return -EAGAIN;
+}
+
+static int ceq_irq_handler(struct hinic3_eq *eq)
+{
+	struct hinic3_ceqs *ceqs;
+	u32 ceqe, eqe_cnt = 0;
+	__be32 ceqe_raw;
+	u32 i;
+
+	ceqs = ceq_to_ceqs(eq);
+	for (i = 0; i < HINIC3_TASK_PROCESS_EQE_LIMIT; i++) {
+		ceqe_raw = *get_curr_ceq_elem(eq);
+		ceqe = be32_to_cpu(ceqe_raw);
+
+		/* HW updates wrapped bit, when it adds eq element event */
+		if (EQ_ELEM_DESC_GET(ceqe, WRAPPED) == eq->wrapped)
+			return 0;
+
+		ceq_event_handler(ceqs, ceqe);
+		eq->cons_idx++;
+		if (eq->cons_idx == eq->eq_len) {
+			eq->cons_idx = 0;
+			eq->wrapped = !eq->wrapped;
+		}
+
+		if (++eqe_cnt >= HINIC3_EQ_UPDATE_CI_STEP) {
+			eqe_cnt = 0;
+			set_eq_cons_idx(eq, HINIC3_EQ_NOT_ARMED);
+		}
+	}
+
+	return -EAGAIN;
+}
+
+static void reschedule_eq_handler(struct hinic3_eq *eq)
+{
+	if (eq->type == HINIC3_AEQ) {
+		struct hinic3_aeqs *aeqs = aeq_to_aeqs(eq);
+
+		queue_work_on(WORK_CPU_UNBOUND, aeqs->workq, &eq->aeq_work);
+	} else {
+		tasklet_schedule(&eq->ceq_tasklet);
+	}
+}
+
+static int eq_irq_handler(struct hinic3_eq *eq)
+{
+	int err;
+
+	if (eq->type == HINIC3_AEQ)
+		err = aeq_irq_handler(eq);
+	else
+		err = ceq_irq_handler(eq);
+
+	set_eq_cons_idx(eq, err ? HINIC3_EQ_NOT_ARMED :
+			HINIC3_EQ_ARMED);
+
+	return err;
+}
+
+static void eq_irq_work(struct work_struct *work)
+{
+	struct hinic3_eq *eq = container_of(work, struct hinic3_eq, aeq_work);
+	int err;
+
+	err = eq_irq_handler(eq);
+	if (err)
+		reschedule_eq_handler(eq);
+}
+
+static void ceq_tasklet(ulong ceq_data)
+{
+	struct hinic3_eq *eq = (struct hinic3_eq *)ceq_data;
+	int err;
+
+	err = eq_irq_handler(eq);
+	if (err)
+		reschedule_eq_handler(eq);
+}
+
+static irqreturn_t aeq_interrupt(int irq, void *data)
+{
+	struct hinic3_eq *aeq = data;
+	struct hinic3_aeqs *aeqs = aeq_to_aeqs(aeq);
+	struct hinic3_hwdev *hwdev = aeq->hwdev;
+	struct workqueue_struct *workq;
+
+	/* clear resend timer cnt register */
+	workq = aeqs->workq;
+	hinic3_msix_intr_clear_resend_bit(hwdev, aeq->msix_entry_idx,
+					  EQ_MSIX_RESEND_TIMER_CLEAR);
+	queue_work_on(WORK_CPU_UNBOUND, workq, &aeq->aeq_work);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ceq_interrupt(int irq, void *data)
+{
+	struct hinic3_eq *ceq = data;
+
+	/* clear resend timer counters */
+	hinic3_msix_intr_clear_resend_bit(ceq->hwdev, ceq->msix_entry_idx,
+					  EQ_MSIX_RESEND_TIMER_CLEAR);
+	tasklet_schedule(&ceq->ceq_tasklet);
+
+	return IRQ_HANDLED;
+}
+
+static int hinic3_set_ceq_ctrl_reg(struct hinic3_hwdev *hwdev, u16 q_id,
+				   u32 ctrl0, u32 ctrl1)
+{
+	struct comm_cmd_set_ceq_ctrl_reg ceq_ctrl = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	ceq_ctrl.func_id = hinic3_global_func_id(hwdev);
+	ceq_ctrl.q_id = q_id;
+	ceq_ctrl.ctrl0 = ctrl0;
+	ceq_ctrl.ctrl1 = ctrl1;
+
+	mgmt_msg_params_init_default(&msg_params, &ceq_ctrl, sizeof(ceq_ctrl));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
+				       COMM_CMD_SET_CEQ_CTRL_REG, &msg_params);
+	if (err || ceq_ctrl.head.status) {
+		dev_err(hwdev->dev, "Failed to set ceq %u ctrl reg, err: %d status: 0x%x\n",
+			q_id, err, ceq_ctrl.head.status);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int set_eq_ctrls(struct hinic3_eq *eq)
+{
+	struct hinic3_hwif *hwif = eq->hwdev->hwif;
+	struct hinic3_queue_pages *qpages;
+	u8 pci_intf_idx, elem_size;
+	u32 mask, ctrl0, ctrl1;
+	u32 page_size_val;
+	int err;
+
+	qpages = &eq->qpages;
+	page_size_val = ilog2(qpages->page_size / HINIC3_MIN_PAGE_SIZE);
+	pci_intf_idx = hwif->attr.pci_intf_idx;
+
+	if (eq->type == HINIC3_AEQ) {
+		/* set ctrl0 using read-modify-write */
+		mask = AEQ_CTRL_0_INTR_IDX_MASK |
+		       AEQ_CTRL_0_DMA_ATTR_MASK |
+		       AEQ_CTRL_0_PCI_INTF_IDX_MASK |
+		       AEQ_CTRL_0_INTR_MODE_MASK;
+		ctrl0 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_AEQ_CTRL_0_ADDR);
+		ctrl0 = (ctrl0 & ~mask) |
+			AEQ_CTRL_0_SET(eq->msix_entry_idx, INTR_IDX) |
+			AEQ_CTRL_0_SET(0, DMA_ATTR) |
+			AEQ_CTRL_0_SET(pci_intf_idx, PCI_INTF_IDX) |
+			AEQ_CTRL_0_SET(HINIC3_INTR_MODE_ARMED, INTR_MODE);
+		hinic3_hwif_write_reg(hwif, HINIC3_CSR_AEQ_CTRL_0_ADDR, ctrl0);
+
+		/* HW expects log2(number of 32 byte units). */
+		elem_size = qpages->elem_size_shift - 5;
+		ctrl1 = AEQ_CTRL_1_SET(eq->eq_len, LEN) |
+			AEQ_CTRL_1_SET(elem_size, ELEM_SIZE) |
+			AEQ_CTRL_1_SET(page_size_val, PAGE_SIZE);
+		hinic3_hwif_write_reg(hwif, HINIC3_CSR_AEQ_CTRL_1_ADDR, ctrl1);
+	} else {
+		ctrl0 = CEQ_CTRL_0_SET(eq->msix_entry_idx, INTR_IDX) |
+			CEQ_CTRL_0_SET(0, DMA_ATTR) |
+			CEQ_CTRL_0_SET(0, LIMIT_KICK) |
+			CEQ_CTRL_0_SET(pci_intf_idx, PCI_INTF_IDX) |
+			CEQ_CTRL_0_SET(page_size_val, PAGE_SIZE) |
+			CEQ_CTRL_0_SET(HINIC3_INTR_MODE_ARMED, INTR_MODE);
+
+		ctrl1 = CEQ_CTRL_1_SET(eq->eq_len, LEN);
+
+		/* set ceq ctrl reg through mgmt cpu */
+		err = hinic3_set_ceq_ctrl_reg(eq->hwdev, eq->q_id, ctrl0,
+					      ctrl1);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void ceq_elements_init(struct hinic3_eq *eq, u32 init_val)
+{
+	__be32 *ceqe;
+	u32 i;
+
+	for (i = 0; i < eq->eq_len; i++) {
+		ceqe = get_q_element(&eq->qpages, i, NULL);
+		*ceqe = cpu_to_be32(init_val);
+	}
+
+	wmb();    /* Write the init values */
+}
+
+static void aeq_elements_init(struct hinic3_eq *eq, u32 init_val)
+{
+	struct hinic3_aeq_elem *aeqe;
+	u32 i;
+
+	for (i = 0; i < eq->eq_len; i++) {
+		aeqe = get_q_element(&eq->qpages, i, NULL);
+		aeqe->desc = cpu_to_be32(init_val);
+	}
+
+	wmb();    /* Write the init values */
+}
+
+static void eq_elements_init(struct hinic3_eq *eq, u32 init_val)
+{
+	if (eq->type == HINIC3_AEQ)
+		aeq_elements_init(eq, init_val);
+	else
+		ceq_elements_init(eq, init_val);
+}
+
+static int alloc_eq_pages(struct hinic3_eq *eq)
+{
+	struct hinic3_hwif *hwif = eq->hwdev->hwif;
+	struct hinic3_queue_pages *qpages;
+	dma_addr_t page_paddr;
+	u32 reg, init_val;
+	u16 pg_idx;
+	int err;
+
+	qpages = &eq->qpages;
+	err = hinic3_queue_pages_alloc(eq->hwdev, qpages, HINIC3_MIN_PAGE_SIZE);
+	if (err)
+		return err;
+
+	for (pg_idx = 0; pg_idx < qpages->num_pages; pg_idx++) {
+		page_paddr = qpages->pages[pg_idx].align_paddr;
+		reg = EQ_HI_PHYS_ADDR_REG(eq->type, pg_idx);
+		hinic3_hwif_write_reg(hwif, reg, upper_32_bits(page_paddr));
+		reg = EQ_LO_PHYS_ADDR_REG(eq->type, pg_idx);
+		hinic3_hwif_write_reg(hwif, reg, lower_32_bits(page_paddr));
+	}
+
+	init_val = HINIC3_EQ_WRAPPED(eq);
+	eq_elements_init(eq, init_val);
+
+	return 0;
+}
+
+static void eq_calc_page_size_and_num(struct hinic3_eq *eq, u32 elem_size)
+{
+	u32 max_pages, min_page_size, page_size, total_size;
+
+	/* No need for complicated arithmetics. All values must be power of 2.
+	 * Multiplications give power of 2 and divisions give power of 2 without
+	 * remainder.
+	 */
+	max_pages = HINIC3_EQ_MAX_PAGES(eq);
+	min_page_size = HINIC3_MIN_PAGE_SIZE;
+	total_size = eq->eq_len * elem_size;
+
+	if (total_size <= max_pages * min_page_size)
+		page_size = min_page_size;
+	else
+		page_size = total_size / max_pages;
+
+	hinic3_queue_pages_init(&eq->qpages, eq->eq_len, page_size, elem_size);
+}
+
+static int request_eq_irq(struct hinic3_eq *eq)
+{
+	int err;
+
+	if (eq->type == HINIC3_AEQ) {
+		INIT_WORK(&eq->aeq_work, eq_irq_work);
+		snprintf(eq->irq_name, sizeof(eq->irq_name),
+			 "hinic3_aeq%u@pci:%s", eq->q_id,
+			 pci_name(eq->hwdev->pdev));
+		err = request_irq(eq->irq_id, aeq_interrupt, 0,
+				  eq->irq_name, eq);
+	} else {
+		tasklet_init(&eq->ceq_tasklet, ceq_tasklet, (ulong)eq);
+		snprintf(eq->irq_name, sizeof(eq->irq_name),
+			 "hinic3_ceq%u@pci:%s", eq->q_id,
+			 pci_name(eq->hwdev->pdev));
+		err = request_irq(eq->irq_id, ceq_interrupt, 0,
+				  eq->irq_name, eq);
+	}
+
+	return err;
+}
+
+static void reset_eq(struct hinic3_eq *eq)
+{
+	/* clear eq_len to force eqe drop in hardware */
+	if (eq->type == HINIC3_AEQ)
+		hinic3_hwif_write_reg(eq->hwdev->hwif,
+				      HINIC3_CSR_AEQ_CTRL_1_ADDR, 0);
+	else
+		hinic3_set_ceq_ctrl_reg(eq->hwdev, eq->q_id, 0, 0);
+
+	hinic3_hwif_write_reg(eq->hwdev->hwif, EQ_PROD_IDX_REG_ADDR(eq), 0);
+}
+
+static int init_eq(struct hinic3_eq *eq, struct hinic3_hwdev *hwdev, u16 q_id,
+		   u32 q_len, enum hinic3_eq_type type,
+		   struct msix_entry *msix_entry)
+{
+	u32 elem_size;
+	int err;
+
+	eq->hwdev = hwdev;
+	eq->q_id = q_id;
+	eq->type = type;
+	eq->eq_len = q_len;
+
+	/* Indirect access should set q_id first */
+	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_EQ_INDIR_IDX_ADDR(eq->type),
+			      eq->q_id);
+
+	reset_eq(eq);
+
+	eq->cons_idx = 0;
+	eq->wrapped = 0;
+
+	elem_size = (type == HINIC3_AEQ) ? HINIC3_AEQE_SIZE : HINIC3_CEQE_SIZE;
+	eq_calc_page_size_and_num(eq, elem_size);
+
+	err = alloc_eq_pages(eq);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to allocate pages for eq\n");
+		return err;
+	}
+
+	eq->msix_entry_idx = msix_entry->entry;
+	eq->irq_id = msix_entry->vector;
+
+	err = set_eq_ctrls(eq);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set ctrls for eq\n");
+		goto err_free_queue_pages;
+	}
+
+	set_eq_cons_idx(eq, HINIC3_EQ_ARMED);
+
+	err = request_eq_irq(eq);
+	if (err) {
+		dev_err(hwdev->dev,
+			"Failed to request irq for the eq, err: %d\n", err);
+		goto err_free_queue_pages;
+	}
+
+	hinic3_set_msix_state(hwdev, eq->msix_entry_idx, HINIC3_MSIX_DISABLE);
+
+	return 0;
+
+err_free_queue_pages:
+	hinic3_queue_pages_free(hwdev, &eq->qpages);
+
+	return err;
+}
+
+static void remove_eq(struct hinic3_eq *eq)
+{
+	hinic3_set_msix_state(eq->hwdev, eq->msix_entry_idx,
+			      HINIC3_MSIX_DISABLE);
+	synchronize_irq(eq->irq_id);
+	free_irq(eq->irq_id, eq);
+	/* Indirect access should set q_id first */
+	hinic3_hwif_write_reg(eq->hwdev->hwif,
+			      HINIC3_EQ_INDIR_IDX_ADDR(eq->type),
+			      eq->q_id);
+
+	if (eq->type == HINIC3_AEQ) {
+		cancel_work_sync(&eq->aeq_work);
+		/* clear eq_len to avoid hw access host memory */
+		hinic3_hwif_write_reg(eq->hwdev->hwif,
+				      HINIC3_CSR_AEQ_CTRL_1_ADDR, 0);
+	} else {
+		tasklet_kill(&eq->ceq_tasklet);
+		hinic3_set_ceq_ctrl_reg(eq->hwdev, eq->q_id, 0, 0);
+	}
+
+	/* update consumer index to avoid invalid interrupt */
+	eq->cons_idx = hinic3_hwif_read_reg(eq->hwdev->hwif,
+					    EQ_PROD_IDX_REG_ADDR(eq));
+	set_eq_cons_idx(eq, HINIC3_EQ_NOT_ARMED);
+	hinic3_queue_pages_free(eq->hwdev, &eq->qpages);
+}
+
+int hinic3_aeqs_init(struct hinic3_hwdev *hwdev, u16 num_aeqs,
+		     struct msix_entry *msix_entries)
+{
+	struct hinic3_aeqs *aeqs;
+	u16 q_id;
+	int err;
+
+	aeqs = kzalloc(sizeof(*aeqs), GFP_KERNEL);
+	if (!aeqs)
+		return -ENOMEM;
+
+	hwdev->aeqs = aeqs;
+	aeqs->hwdev = hwdev;
+	aeqs->num_aeqs = num_aeqs;
+	aeqs->workq = alloc_workqueue(HINIC3_EQS_WQ_NAME, WQ_MEM_RECLAIM,
+				      HINIC3_MAX_AEQS);
+	if (!aeqs->workq) {
+		dev_err(hwdev->dev, "Failed to initialize aeq workqueue\n");
+		err = -ENOMEM;
+		goto err_free_aeqs;
+	}
+
+	for (q_id = 0; q_id < num_aeqs; q_id++) {
+		err = init_eq(&aeqs->aeq[q_id], hwdev, q_id,
+			      HINIC3_DEFAULT_AEQ_LEN, HINIC3_AEQ,
+			      &msix_entries[q_id]);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to init aeq %u\n",
+				q_id);
+			goto err_remove_eqs;
+		}
+	}
+	for (q_id = 0; q_id < num_aeqs; q_id++)
+		hinic3_set_msix_state(hwdev, aeqs->aeq[q_id].msix_entry_idx,
+				      HINIC3_MSIX_ENABLE);
+
+	return 0;
+
+err_remove_eqs:
+	while (q_id > 0) {
+		q_id--;
+		remove_eq(&aeqs->aeq[q_id]);
+	}
+
+	destroy_workqueue(aeqs->workq);
+
+err_free_aeqs:
+	kfree(aeqs);
+
+	return err;
+}
+
+void hinic3_aeqs_free(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_aeqs *aeqs = hwdev->aeqs;
+	enum hinic3_aeq_type aeq_event;
+	struct hinic3_eq *eq;
+	u16 q_id;
+
+	for (q_id = 0; q_id < aeqs->num_aeqs; q_id++) {
+		eq = aeqs->aeq + q_id;
+		remove_eq(eq);
+		hinic3_free_irq(hwdev, eq->irq_id);
+	}
+
+	for (aeq_event = 0; aeq_event < HINIC3_MAX_AEQ_EVENTS; aeq_event++)
+		hinic3_aeq_unregister_cb(hwdev, aeq_event);
+
+	destroy_workqueue(aeqs->workq);
+
+	kfree(aeqs);
+}
+
+int hinic3_ceqs_init(struct hinic3_hwdev *hwdev, u16 num_ceqs,
+		     struct msix_entry *msix_entries)
+{
+	struct hinic3_ceqs *ceqs;
+	u16 q_id;
+	int err;
+
+	ceqs = kzalloc(sizeof(*ceqs), GFP_KERNEL);
+	if (!ceqs)
+		return -ENOMEM;
+
+	hwdev->ceqs = ceqs;
+	ceqs->hwdev = hwdev;
+	ceqs->num_ceqs = num_ceqs;
+
+	for (q_id = 0; q_id < num_ceqs; q_id++) {
+		err = init_eq(&ceqs->ceq[q_id], hwdev, q_id,
+			      HINIC3_DEFAULT_CEQ_LEN, HINIC3_CEQ,
+			      &msix_entries[q_id]);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to init ceq %u\n",
+				q_id);
+			goto err_free_ceqs;
+		}
+	}
+	for (q_id = 0; q_id < num_ceqs; q_id++)
+		hinic3_set_msix_state(hwdev, ceqs->ceq[q_id].msix_entry_idx,
+				      HINIC3_MSIX_ENABLE);
+
+	return 0;
+
+err_free_ceqs:
+	while (q_id > 0) {
+		q_id--;
+		remove_eq(&ceqs->ceq[q_id]);
+	}
+
+	kfree(ceqs);
+
+	return err;
+}
+
+void hinic3_ceqs_free(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_ceqs *ceqs = hwdev->ceqs;
+	enum hinic3_ceq_event ceq_event;
+	struct hinic3_eq *eq;
+	u16 q_id;
+
+	for (q_id = 0; q_id < ceqs->num_ceqs; q_id++) {
+		eq = ceqs->ceq + q_id;
+		remove_eq(eq);
+		hinic3_free_irq(hwdev, eq->irq_id);
+	}
+
+	for (ceq_event = 0; ceq_event < HINIC3_MAX_CEQ_EVENTS; ceq_event++)
+		hinic3_ceq_unregister_cb(hwdev, ceq_event);
+
+	kfree(ceqs);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h
new file mode 100644
index 000000000000..c7535910adbd
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. */
+
+#ifndef _HINIC3_EQS_H_
+#define _HINIC3_EQS_H_
+
+#include <linux/interrupt.h>
+
+#include "hinic3_hw_cfg.h"
+#include "hinic3_queue_common.h"
+
+#define HINIC3_MAX_AEQS              4
+#define HINIC3_MAX_CEQS              32
+
+#define HINIC3_AEQ_MAX_PAGES         4
+#define HINIC3_CEQ_MAX_PAGES         8
+
+#define HINIC3_AEQE_SIZE             64
+#define HINIC3_CEQE_SIZE             4
+
+#define HINIC3_AEQE_DESC_SIZE        4
+#define HINIC3_AEQE_DATA_SIZE        (HINIC3_AEQE_SIZE - HINIC3_AEQE_DESC_SIZE)
+
+#define HINIC3_DEFAULT_AEQ_LEN       0x10000
+#define HINIC3_DEFAULT_CEQ_LEN       0x10000
+
+#define HINIC3_EQ_IRQ_NAME_LEN       64
+
+#define HINIC3_EQ_USLEEP_LOW_BOUND   900
+#define HINIC3_EQ_USLEEP_HIGH_BOUND  1000
+
+enum hinic3_eq_type {
+	HINIC3_AEQ = 0,
+	HINIC3_CEQ = 1,
+};
+
+enum hinic3_eq_intr_mode {
+	HINIC3_INTR_MODE_ARMED  = 0,
+	HINIC3_INTR_MODE_ALWAYS = 1,
+};
+
+enum hinic3_eq_ci_arm_state {
+	HINIC3_EQ_NOT_ARMED = 0,
+	HINIC3_EQ_ARMED     = 1,
+};
+
+struct hinic3_eq {
+	struct hinic3_hwdev       *hwdev;
+	struct hinic3_queue_pages qpages;
+	u16                       q_id;
+	enum hinic3_eq_type       type;
+	u32                       eq_len;
+	u32                       cons_idx;
+	u8                        wrapped;
+	u32                       irq_id;
+	u16                       msix_entry_idx;
+	char                      irq_name[HINIC3_EQ_IRQ_NAME_LEN];
+	struct work_struct        aeq_work;
+	struct tasklet_struct     ceq_tasklet;
+};
+
+struct hinic3_aeq_elem {
+	u8     aeqe_data[HINIC3_AEQE_DATA_SIZE];
+	__be32 desc;
+};
+
+enum hinic3_aeq_cb_state {
+	HINIC3_AEQ_CB_REG     = 0,
+	HINIC3_AEQ_CB_RUNNING = 1,
+};
+
+enum hinic3_aeq_type {
+	HINIC3_HW_INTER_INT   = 0,
+	HINIC3_MBX_FROM_FUNC  = 1,
+	HINIC3_MSG_FROM_FW    = 2,
+	HINIC3_MAX_AEQ_EVENTS = 6,
+};
+
+typedef void (*hinic3_aeq_event_cb)(struct hinic3_hwdev *hwdev, u8 *data,
+				    u8 size);
+
+struct hinic3_aeqs {
+	struct hinic3_hwdev     *hwdev;
+	hinic3_aeq_event_cb     aeq_cb[HINIC3_MAX_AEQ_EVENTS];
+	unsigned long           aeq_cb_state[HINIC3_MAX_AEQ_EVENTS];
+	struct hinic3_eq        aeq[HINIC3_MAX_AEQS];
+	u16                     num_aeqs;
+	struct workqueue_struct *workq;
+};
+
+enum hinic3_ceq_cb_state {
+	HINIC3_CEQ_CB_REG     = 0,
+	HINIC3_CEQ_CB_RUNNING = 1,
+};
+
+enum hinic3_ceq_event {
+	HINIC3_CMDQ           = 3,
+	HINIC3_MAX_CEQ_EVENTS = 6,
+};
+
+typedef void (*hinic3_ceq_event_cb)(struct hinic3_hwdev *hwdev, u32 ceqe_data);
+
+struct hinic3_ceqs {
+	struct hinic3_hwdev *hwdev;
+
+	hinic3_ceq_event_cb ceq_cb[HINIC3_MAX_CEQ_EVENTS];
+	unsigned long       ceq_cb_state[HINIC3_MAX_CEQ_EVENTS];
+
+	struct hinic3_eq    ceq[HINIC3_MAX_CEQS];
+	u16                 num_ceqs;
+};
+
+int hinic3_aeqs_init(struct hinic3_hwdev *hwdev, u16 num_aeqs,
+		     struct msix_entry *msix_entries);
+void hinic3_aeqs_free(struct hinic3_hwdev *hwdev);
+int hinic3_aeq_register_cb(struct hinic3_hwdev *hwdev,
+			   enum hinic3_aeq_type event,
+			   hinic3_aeq_event_cb hwe_cb);
+void hinic3_aeq_unregister_cb(struct hinic3_hwdev *hwdev,
+			      enum hinic3_aeq_type event);
+int hinic3_ceqs_init(struct hinic3_hwdev *hwdev, u16 num_ceqs,
+		     struct msix_entry *msix_entries);
+void hinic3_ceqs_free(struct hinic3_hwdev *hwdev);
+int hinic3_ceq_register_cb(struct hinic3_hwdev *hwdev,
+			   enum hinic3_ceq_event event,
+			   hinic3_ceq_event_cb callback);
+void hinic3_ceq_unregister_cb(struct hinic3_hwdev *hwdev,
+			      enum hinic3_ceq_event event);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
index 87d9450c30ca..0599fc4f3fb0 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
@@ -8,6 +8,49 @@
 #include "hinic3_hwif.h"
 #include "hinic3_mbox.h"
 
+int hinic3_alloc_irqs(struct hinic3_hwdev *hwdev, u16 num,
+		      struct msix_entry *alloc_arr, u16 *act_num)
+{
+	struct hinic3_irq_info *irq_info;
+	struct hinic3_irq *curr;
+	u16 i, found = 0;
+
+	irq_info = &hwdev->cfg_mgmt->irq_info;
+	mutex_lock(&irq_info->irq_mutex);
+	for (i = 0; i < irq_info->num_irq && found < num; i++) {
+		curr = irq_info->irq + i;
+		if (curr->allocated)
+			continue;
+		curr->allocated = true;
+		alloc_arr[found].vector = curr->irq_id;
+		alloc_arr[found].entry = curr->msix_entry_idx;
+		found++;
+	}
+	mutex_unlock(&irq_info->irq_mutex);
+
+	*act_num = found;
+
+	return found == 0 ? -ENOMEM : 0;
+}
+
+void hinic3_free_irq(struct hinic3_hwdev *hwdev, u32 irq_id)
+{
+	struct hinic3_irq_info *irq_info;
+	struct hinic3_irq *curr;
+	u16 i;
+
+	irq_info = &hwdev->cfg_mgmt->irq_info;
+	mutex_lock(&irq_info->irq_mutex);
+	for (i = 0; i < irq_info->num_irq; i++) {
+		curr = irq_info->irq + i;
+		if (curr->irq_id == irq_id) {
+			curr->allocated = false;
+			break;
+		}
+	}
+	mutex_unlock(&irq_info->irq_mutex);
+}
+
 bool hinic3_support_nic(struct hinic3_hwdev *hwdev)
 {
 	return hwdev->cfg_mgmt->cap.supp_svcs_bitmap &
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
index 434696ce7dc2..7adcdd569c7b 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
@@ -8,6 +8,37 @@
 #include "hinic3_hwif.h"
 #include "hinic3_mbox.h"
 
+int hinic3_set_interrupt_cfg_direct(struct hinic3_hwdev *hwdev,
+				    const struct hinic3_interrupt_info *info)
+{
+	struct comm_cmd_cfg_msix_ctrl_reg msix_cfg = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	msix_cfg.func_id = hinic3_global_func_id(hwdev);
+	msix_cfg.msix_index = info->msix_index;
+	msix_cfg.opcode = MGMT_MSG_CMD_OP_SET;
+
+	msix_cfg.lli_credit_cnt = info->lli_credit_limit;
+	msix_cfg.lli_timer_cnt = info->lli_timer_cfg;
+	msix_cfg.pending_cnt = info->pending_limit;
+	msix_cfg.coalesce_timer_cnt = info->coalesc_timer_cfg;
+	msix_cfg.resend_timer_cnt = info->resend_timer_cfg;
+
+	mgmt_msg_params_init_default(&msg_params, &msix_cfg, sizeof(msix_cfg));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
+				       COMM_CMD_CFG_MSIX_CTRL_REG, &msg_params);
+	if (err || msix_cfg.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set interrupt config, err: %d, status: 0x%x\n",
+			err, msix_cfg.head.status);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag)
 {
 	struct comm_cmd_func_reset func_reset = {};
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
index c33a1c77da9c..2270987b126f 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
@@ -8,6 +8,19 @@
 
 struct hinic3_hwdev;
 
+struct hinic3_interrupt_info {
+	u32 lli_set;
+	u32 interrupt_coalesc_set;
+	u16 msix_index;
+	u8  lli_credit_limit;
+	u8  lli_timer_cfg;
+	u8  pending_limit;
+	u8  coalesc_timer_cfg;
+	u8  resend_timer_cfg;
+};
+
+int hinic3_set_interrupt_cfg_direct(struct hinic3_hwdev *hwdev,
+				    const struct hinic3_interrupt_info *info);
 int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
index 22c84093efa2..5f161f1314ac 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
@@ -70,6 +70,20 @@ enum comm_cmd {
 	COMM_CMD_SET_DMA_ATTR            = 25,
 };
 
+struct comm_cmd_cfg_msix_ctrl_reg {
+	struct mgmt_msg_head head;
+	u16                  func_id;
+	u8                   opcode;
+	u8                   rsvd1;
+	u16                  msix_index;
+	u8                   pending_cnt;
+	u8                   coalesce_timer_cnt;
+	u8                   resend_timer_cnt;
+	u8                   lli_timer_cnt;
+	u8                   lli_credit_cnt;
+	u8                   rsvd2[5];
+};
+
 enum comm_func_reset_bits {
 	COMM_FUNC_RESET_BIT_FLUSH        = BIT(0),
 	COMM_FUNC_RESET_BIT_MQM          = BIT(1),
@@ -100,6 +114,28 @@ struct comm_cmd_feature_nego {
 	u64                  s_feature[COMM_MAX_FEATURE_QWORD];
 };
 
+struct comm_cmd_set_ceq_ctrl_reg {
+	struct mgmt_msg_head head;
+	u16                  func_id;
+	u16                  q_id;
+	u32                  ctrl0;
+	u32                  ctrl1;
+	u32                  rsvd1;
+};
+
+struct comm_cmdq_ctxt_info {
+	u64 curr_wqe_page_pfn;
+	u64 wq_block_pfn;
+};
+
+struct comm_cmd_set_cmdq_ctxt {
+	struct mgmt_msg_head       head;
+	u16                        func_id;
+	u8                         cmdq_id;
+	u8                         rsvd1[5];
+	struct comm_cmdq_ctxt_info ctxt;
+};
+
 /* Services supported by HW. HW uses these values when delivering events.
  * HW supports multiple services that are not yet supported by driver
  * (e.g. RoCE).
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
index 0865453bf0e7..9b1e98e349b1 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
@@ -6,13 +6,164 @@
 #include <linux/io.h>
 
 #include "hinic3_common.h"
+#include "hinic3_csr.h"
 #include "hinic3_hwdev.h"
 #include "hinic3_hwif.h"
 
+/* config BAR4/5 4MB, DB & DWQE both 2MB */
+#define HINIC3_DB_DWQE_SIZE    0x00400000
+
+/* db/dwqe page size: 4K */
+#define HINIC3_DB_PAGE_SIZE    0x00001000
+#define HINIC3_DWQE_OFFSET     0x00000800
+#define HINIC3_DB_MAX_AREAS    (HINIC3_DB_DWQE_SIZE / HINIC3_DB_PAGE_SIZE)
+
+#define HINIC3_GET_REG_ADDR(reg)  ((reg) & (HINIC3_REGS_FLAG_MASK))
+
+static void __iomem *hinic3_reg_addr(struct hinic3_hwif *hwif, u32 reg)
+{
+	return hwif->cfg_regs_base + HINIC3_GET_REG_ADDR(reg);
+}
+
+u32 hinic3_hwif_read_reg(struct hinic3_hwif *hwif, u32 reg)
+{
+	void __iomem *addr = hinic3_reg_addr(hwif, reg);
+	__be32 raw_val;
+
+	raw_val = (__force __be32)readl(addr);
+
+	return be32_to_cpu(raw_val);
+}
+
+void hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val)
+{
+	void __iomem *addr = hinic3_reg_addr(hwif, reg);
+	__be32 raw_val = cpu_to_be32(val);
+
+	writel((__force u32)raw_val, addr);
+}
+
+static int get_db_idx(struct hinic3_hwif *hwif, u32 *idx)
+{
+	struct hinic3_db_area *db_area = &hwif->db_area;
+	u32 pg_idx;
+
+	spin_lock(&db_area->idx_lock);
+	pg_idx = find_first_zero_bit(db_area->db_bitmap_array,
+				     db_area->db_max_areas);
+	if (pg_idx == db_area->db_max_areas) {
+		spin_unlock(&db_area->idx_lock);
+		return -ENOMEM;
+	}
+	set_bit(pg_idx, db_area->db_bitmap_array);
+	spin_unlock(&db_area->idx_lock);
+
+	*idx = pg_idx;
+
+	return 0;
+}
+
+static void free_db_idx(struct hinic3_hwif *hwif, u32 idx)
+{
+	struct hinic3_db_area *db_area = &hwif->db_area;
+
+	spin_lock(&db_area->idx_lock);
+	clear_bit(idx, db_area->db_bitmap_array);
+	spin_unlock(&db_area->idx_lock);
+}
+
+void hinic3_free_db_addr(struct hinic3_hwdev *hwdev, const u8 __iomem *db_base)
+{
+	struct hinic3_hwif *hwif;
+	uintptr_t distance;
+	u32 idx;
+
+	hwif = hwdev->hwif;
+	distance = (const char __iomem *)db_base -
+		   (const char __iomem *)hwif->db_base;
+	idx = distance / HINIC3_DB_PAGE_SIZE;
+
+	free_db_idx(hwif, idx);
+}
+
+int hinic3_alloc_db_addr(struct hinic3_hwdev *hwdev, void __iomem **db_base,
+			 void __iomem **dwqe_base)
+{
+	struct hinic3_hwif *hwif;
+	u8 __iomem *addr;
+	u32 idx;
+	int err;
+
+	hwif = hwdev->hwif;
+
+	err = get_db_idx(hwif, &idx);
+	if (err)
+		return err;
+
+	addr = hwif->db_base + idx * HINIC3_DB_PAGE_SIZE;
+	*db_base = addr;
+
+	if (dwqe_base)
+		*dwqe_base = addr + HINIC3_DWQE_OFFSET;
+
+	return 0;
+}
+
 void hinic3_set_msix_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
 			   enum hinic3_msix_state flag)
 {
-	/* Completed by later submission due to LoC limit. */
+	struct hinic3_hwif *hwif;
+	u8 int_msk = 1;
+	u32 mask_bits;
+	u32 addr;
+
+	hwif = hwdev->hwif;
+
+	if (flag)
+		mask_bits = HINIC3_MSI_CLR_INDIR_SET(int_msk, INT_MSK_SET);
+	else
+		mask_bits = HINIC3_MSI_CLR_INDIR_SET(int_msk, INT_MSK_CLR);
+	mask_bits = mask_bits |
+		    HINIC3_MSI_CLR_INDIR_SET(msix_idx, SIMPLE_INDIR_IDX);
+
+	addr = HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR;
+	hinic3_hwif_write_reg(hwif, addr, mask_bits);
+}
+
+void hinic3_msix_intr_clear_resend_bit(struct hinic3_hwdev *hwdev, u16 msix_idx,
+				       u8 clear_resend_en)
+{
+	struct hinic3_hwif *hwif;
+	u32 msix_ctrl, addr;
+
+	hwif = hwdev->hwif;
+
+	msix_ctrl = HINIC3_MSI_CLR_INDIR_SET(msix_idx, SIMPLE_INDIR_IDX) |
+		    HINIC3_MSI_CLR_INDIR_SET(clear_resend_en, RESEND_TIMER_CLR);
+
+	addr = HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR;
+	hinic3_hwif_write_reg(hwif, addr, msix_ctrl);
+}
+
+void hinic3_set_msix_auto_mask_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
+				     enum hinic3_msix_auto_mask flag)
+{
+	struct hinic3_hwif *hwif;
+	u32 mask_bits;
+	u32 addr;
+
+	hwif = hwdev->hwif;
+
+	if (flag)
+		mask_bits = HINIC3_MSI_CLR_INDIR_SET(1, AUTO_MSK_SET);
+	else
+		mask_bits = HINIC3_MSI_CLR_INDIR_SET(1, AUTO_MSK_CLR);
+
+	mask_bits = mask_bits |
+		    HINIC3_MSI_CLR_INDIR_SET(msix_idx, SIMPLE_INDIR_IDX);
+
+	addr = HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR;
+	hinic3_hwif_write_reg(hwif, addr, mask_bits);
 }
 
 u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
index 513c9680e6b6..29dd86eb458a 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
@@ -50,8 +50,24 @@ enum hinic3_msix_state {
 	HINIC3_MSIX_DISABLE,
 };
 
+enum hinic3_msix_auto_mask {
+	HINIC3_CLR_MSIX_AUTO_MASK,
+	HINIC3_SET_MSIX_AUTO_MASK,
+};
+
+u32 hinic3_hwif_read_reg(struct hinic3_hwif *hwif, u32 reg);
+void hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val);
+
+int hinic3_alloc_db_addr(struct hinic3_hwdev *hwdev, void __iomem **db_base,
+			 void __iomem **dwqe_base);
+void hinic3_free_db_addr(struct hinic3_hwdev *hwdev, const u8 __iomem *db_base);
+
 void hinic3_set_msix_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
 			   enum hinic3_msix_state flag);
+void hinic3_msix_intr_clear_resend_bit(struct hinic3_hwdev *hwdev, u16 msix_idx,
+				       u8 clear_resend_en);
+void hinic3_set_msix_auto_mask_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
+				     enum hinic3_msix_auto_mask flag);
 
 u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev);
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
index 8b92eed25edf..cee28e67f252 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -38,7 +38,7 @@ static int hinic3_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
-void qp_add_napi(struct hinic3_irq_cfg *irq_cfg)
+static void qp_add_napi(struct hinic3_irq_cfg *irq_cfg)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(irq_cfg->netdev);
 
@@ -50,7 +50,7 @@ void qp_add_napi(struct hinic3_irq_cfg *irq_cfg)
 	napi_enable(&irq_cfg->napi);
 }
 
-void qp_del_napi(struct hinic3_irq_cfg *irq_cfg)
+static void qp_del_napi(struct hinic3_irq_cfg *irq_cfg)
 {
 	napi_disable(&irq_cfg->napi);
 	netif_queue_set_napi(irq_cfg->netdev, irq_cfg->irq_id,
@@ -60,3 +60,136 @@ void qp_del_napi(struct hinic3_irq_cfg *irq_cfg)
 	netif_stop_subqueue(irq_cfg->netdev, irq_cfg->irq_id);
 	netif_napi_del(&irq_cfg->napi);
 }
+
+static irqreturn_t qp_irq(int irq, void *data)
+{
+	struct hinic3_irq_cfg *irq_cfg = data;
+	struct hinic3_nic_dev *nic_dev;
+
+	nic_dev = netdev_priv(irq_cfg->netdev);
+	hinic3_msix_intr_clear_resend_bit(nic_dev->hwdev,
+					  irq_cfg->msix_entry_idx, 1);
+
+	napi_schedule(&irq_cfg->napi);
+
+	return IRQ_HANDLED;
+}
+
+static int hinic3_request_irq(struct hinic3_irq_cfg *irq_cfg, u16 q_id)
+{
+	struct hinic3_interrupt_info info = {};
+	struct hinic3_nic_dev *nic_dev;
+	struct net_device *netdev;
+	int err;
+
+	netdev = irq_cfg->netdev;
+	nic_dev = netdev_priv(netdev);
+	qp_add_napi(irq_cfg);
+
+	info.msix_index = irq_cfg->msix_entry_idx;
+	info.interrupt_coalesc_set = 1;
+	info.pending_limit = nic_dev->intr_coalesce[q_id].pending_limit;
+	info.coalesc_timer_cfg =
+		nic_dev->intr_coalesce[q_id].coalesce_timer_cfg;
+	info.resend_timer_cfg = nic_dev->intr_coalesce[q_id].resend_timer_cfg;
+	err = hinic3_set_interrupt_cfg_direct(nic_dev->hwdev, &info);
+	if (err) {
+		netdev_err(netdev, "Failed to set RX interrupt coalescing attribute.\n");
+		qp_del_napi(irq_cfg);
+		return err;
+	}
+
+	err = request_irq(irq_cfg->irq_id, qp_irq, 0, irq_cfg->irq_name,
+			  irq_cfg);
+	if (err) {
+		qp_del_napi(irq_cfg);
+		return err;
+	}
+
+	irq_set_affinity_hint(irq_cfg->irq_id, &irq_cfg->affinity_mask);
+
+	return 0;
+}
+
+static void hinic3_release_irq(struct hinic3_irq_cfg *irq_cfg)
+{
+	irq_set_affinity_hint(irq_cfg->irq_id, NULL);
+	synchronize_irq(irq_cfg->irq_id);
+	free_irq(irq_cfg->irq_id, irq_cfg);
+}
+
+int hinic3_qps_irq_init(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct pci_dev *pdev = nic_dev->pdev;
+	struct hinic3_irq_cfg *irq_cfg;
+	struct msix_entry *msix_entry;
+	u32 local_cpu;
+	u16 q_id;
+	int err;
+
+	for (q_id = 0; q_id < nic_dev->q_params.num_qps; q_id++) {
+		msix_entry = &nic_dev->qps_msix_entries[q_id];
+		irq_cfg = &nic_dev->q_params.irq_cfg[q_id];
+
+		irq_cfg->irq_id = msix_entry->vector;
+		irq_cfg->msix_entry_idx = msix_entry->entry;
+		irq_cfg->netdev = netdev;
+		irq_cfg->txq = &nic_dev->txqs[q_id];
+		irq_cfg->rxq = &nic_dev->rxqs[q_id];
+		nic_dev->rxqs[q_id].irq_cfg = irq_cfg;
+
+		local_cpu = cpumask_local_spread(q_id, dev_to_node(&pdev->dev));
+		cpumask_set_cpu(local_cpu, &irq_cfg->affinity_mask);
+
+		snprintf(irq_cfg->irq_name, sizeof(irq_cfg->irq_name),
+			 "%s_qp%u", netdev->name, q_id);
+
+		err = hinic3_request_irq(irq_cfg, q_id);
+		if (err) {
+			netdev_err(netdev, "Failed to request Rx irq\n");
+			goto err_release_irqs;
+		}
+
+		hinic3_set_msix_auto_mask_state(nic_dev->hwdev,
+						irq_cfg->msix_entry_idx,
+						HINIC3_SET_MSIX_AUTO_MASK);
+		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
+				      HINIC3_MSIX_ENABLE);
+	}
+
+	return 0;
+
+err_release_irqs:
+	while (q_id > 0) {
+		q_id--;
+		irq_cfg = &nic_dev->q_params.irq_cfg[q_id];
+		qp_del_napi(irq_cfg);
+		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
+				      HINIC3_MSIX_DISABLE);
+		hinic3_set_msix_auto_mask_state(nic_dev->hwdev,
+						irq_cfg->msix_entry_idx,
+						HINIC3_CLR_MSIX_AUTO_MASK);
+		hinic3_release_irq(irq_cfg);
+	}
+
+	return err;
+}
+
+void hinic3_qps_irq_uninit(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_irq_cfg *irq_cfg;
+	u16 q_id;
+
+	for (q_id = 0; q_id < nic_dev->q_params.num_qps; q_id++) {
+		irq_cfg = &nic_dev->q_params.irq_cfg[q_id];
+		qp_del_napi(irq_cfg);
+		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
+				      HINIC3_MSIX_DISABLE);
+		hinic3_set_msix_auto_mask_state(nic_dev->hwdev,
+						irq_cfg->msix_entry_idx,
+						HINIC3_CLR_MSIX_AUTO_MASK);
+		hinic3_release_irq(irq_cfg);
+	}
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
index 4827326e6a59..129b53c4c91b 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
@@ -121,6 +121,7 @@ static int hinic3_attach_aux_devices(struct hinic3_hwdev *hwdev)
 			goto err_del_adevs;
 	}
 	mutex_unlock(&pci_adapter->pdev_mutex);
+
 	return 0;
 
 err_del_adevs:
@@ -132,6 +133,7 @@ static int hinic3_attach_aux_devices(struct hinic3_hwdev *hwdev)
 		}
 	}
 	mutex_unlock(&pci_adapter->pdev_mutex);
+
 	return -ENOMEM;
 }
 
@@ -153,6 +155,7 @@ struct hinic3_hwdev *hinic3_adev_get_hwdev(struct auxiliary_device *adev)
 	struct hinic3_adev *hadev;
 
 	hadev = container_of(adev, struct hinic3_adev, adev);
+
 	return hadev->hwdev;
 }
 
@@ -333,6 +336,7 @@ static int hinic3_probe_func(struct hinic3_pcidev *pci_adapter)
 
 err_out:
 	dev_err(&pdev->dev, "PCIe device probe function failed\n");
+
 	return err;
 }
 
@@ -365,6 +369,7 @@ static int hinic3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 err_out:
 	dev_err(&pdev->dev, "PCIe device probe failed\n");
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 497f2a36f35d..8d1c7a388762 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -17,12 +17,57 @@
 
 #define HINIC3_NIC_DRV_DESC  "Intelligent Network Interface Card Driver"
 
-#define HINIC3_RX_BUF_LEN            2048
-#define HINIC3_LRO_REPLENISH_THLD    256
-#define HINIC3_NIC_DEV_WQ_NAME       "hinic3_nic_dev_wq"
+#define HINIC3_RX_BUF_LEN          2048
+#define HINIC3_LRO_REPLENISH_THLD  256
+#define HINIC3_NIC_DEV_WQ_NAME     "hinic3_nic_dev_wq"
 
-#define HINIC3_SQ_DEPTH              1024
-#define HINIC3_RQ_DEPTH              1024
+#define HINIC3_SQ_DEPTH            1024
+#define HINIC3_RQ_DEPTH            1024
+
+#define HINIC3_DEFAULT_TXRX_MSIX_PENDING_LIMIT      2
+#define HINIC3_DEFAULT_TXRX_MSIX_COALESC_TIMER_CFG  25
+#define HINIC3_DEFAULT_TXRX_MSIX_RESEND_TIMER_CFG   7
+
+static void init_intr_coal_param(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_intr_coal_info *info;
+	u16 i;
+
+	for (i = 0; i < nic_dev->max_qps; i++) {
+		info = &nic_dev->intr_coalesce[i];
+		info->pending_limit = HINIC3_DEFAULT_TXRX_MSIX_PENDING_LIMIT;
+		info->coalesce_timer_cfg = HINIC3_DEFAULT_TXRX_MSIX_COALESC_TIMER_CFG;
+		info->resend_timer_cfg = HINIC3_DEFAULT_TXRX_MSIX_RESEND_TIMER_CFG;
+	}
+}
+
+static int hinic3_init_intr_coalesce(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	u64 size;
+
+	size = sizeof(*nic_dev->intr_coalesce) * nic_dev->max_qps;
+	if (!size) {
+		dev_err(hwdev->dev, "Cannot allocate zero size intr coalesce\n");
+		return -EINVAL;
+	}
+	nic_dev->intr_coalesce = kzalloc(size, GFP_KERNEL);
+	if (!nic_dev->intr_coalesce)
+		return -ENOMEM;
+
+	init_intr_coal_param(netdev);
+
+	return 0;
+}
+
+static void hinic3_free_intr_coalesce(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	kfree(nic_dev->intr_coalesce);
+}
 
 static int hinic3_alloc_txrxqs(struct net_device *netdev)
 {
@@ -42,8 +87,17 @@ static int hinic3_alloc_txrxqs(struct net_device *netdev)
 		goto err_free_txqs;
 	}
 
+	err = hinic3_init_intr_coalesce(netdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init_intr_coalesce\n");
+		goto err_free_rxqs;
+	}
+
 	return 0;
 
+err_free_rxqs:
+	hinic3_free_rxqs(netdev);
+
 err_free_txqs:
 	hinic3_free_txqs(netdev);
 
@@ -52,6 +106,7 @@ static int hinic3_alloc_txrxqs(struct net_device *netdev)
 
 static void hinic3_free_txrxqs(struct net_device *netdev)
 {
+	hinic3_free_intr_coalesce(netdev);
 	hinic3_free_rxqs(netdev);
 	hinic3_free_txqs(netdev);
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
index e74d1eb09730..a6c692a4c010 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
@@ -4,13 +4,852 @@
 #include <linux/dma-mapping.h>
 
 #include "hinic3_common.h"
+#include "hinic3_csr.h"
 #include "hinic3_hwdev.h"
 #include "hinic3_hwif.h"
 #include "hinic3_mbox.h"
 
+#define MBOX_INT_DST_AEQN_MASK        GENMASK(11, 10)
+#define MBOX_INT_SRC_RESP_AEQN_MASK   GENMASK(13, 12)
+#define MBOX_INT_STAT_DMA_MASK        GENMASK(19, 14)
+/* TX size, expressed in 4 bytes units */
+#define MBOX_INT_TX_SIZE_MASK         GENMASK(24, 20)
+/* SO_RO == strong order, relaxed order */
+#define MBOX_INT_STAT_DMA_SO_RO_MASK  GENMASK(26, 25)
+#define MBOX_INT_WB_EN_MASK           BIT(28)
+#define MBOX_INT_SET(val, field)  \
+	FIELD_PREP(MBOX_INT_##field##_MASK, val)
+
+#define MBOX_CTRL_TRIGGER_AEQE_MASK   BIT(0)
+#define MBOX_CTRL_TX_STATUS_MASK      BIT(1)
+#define MBOX_CTRL_DST_FUNC_MASK       GENMASK(28, 16)
+#define MBOX_CTRL_SET(val, field)  \
+	FIELD_PREP(MBOX_CTRL_##field##_MASK, val)
+
+#define MBOX_MSG_POLLING_TIMEOUT_MS  8000 // send msg seg timeout
+#define MBOX_COMP_POLLING_TIMEOUT_MS 40000 // response
+
+#define MBOX_MAX_BUF_SZ           2048
+#define MBOX_HEADER_SZ            8
+
+/* MBOX size is 64B, 8B for mbox_header, 8B reserved */
+#define MBOX_SEG_LEN              48
+#define MBOX_SEG_LEN_ALIGN        4
+#define MBOX_WB_STATUS_LEN        16
+
+#define MBOX_SEQ_ID_START_VAL     0
+#define MBOX_SEQ_ID_MAX_VAL       42
+#define MBOX_LAST_SEG_MAX_LEN  \
+	(MBOX_MAX_BUF_SZ - MBOX_SEQ_ID_MAX_VAL * MBOX_SEG_LEN)
+
+/* mbox write back status is 16B, only first 4B is used */
+#define MBOX_WB_STATUS_ERRCODE_MASK      0xFFFF
+#define MBOX_WB_STATUS_MASK              0xFF
+#define MBOX_WB_ERROR_CODE_MASK          0xFF00
+#define MBOX_WB_STATUS_FINISHED_SUCCESS  0xFF
+#define MBOX_WB_STATUS_NOT_FINISHED      0x00
+
+#define MBOX_STATUS_FINISHED(wb)  \
+	(((wb) & MBOX_WB_STATUS_MASK) != MBOX_WB_STATUS_NOT_FINISHED)
+#define MBOX_STATUS_SUCCESS(wb)  \
+	(((wb) & MBOX_WB_STATUS_MASK) == MBOX_WB_STATUS_FINISHED_SUCCESS)
+#define MBOX_STATUS_ERRCODE(wb)  \
+	((wb) & MBOX_WB_ERROR_CODE_MASK)
+
+#define MBOX_DMA_MSG_QUEUE_DEPTH    32
+#define MBOX_BODY_FROM_HDR(header)  ((u8 *)(header) + MBOX_HEADER_SZ)
+#define MBOX_AREA(hwif)  \
+	((hwif)->cfg_regs_base + HINIC3_FUNC_CSR_MAILBOX_DATA_OFF)
+
+#define MBOX_MQ_CI_OFFSET  \
+	(HINIC3_CFG_REGS_FLAG + HINIC3_FUNC_CSR_MAILBOX_DATA_OFF + \
+	 MBOX_HEADER_SZ + MBOX_SEG_LEN)
+
+#define MBOX_MQ_SYNC_CI_MASK   GENMASK(7, 0)
+#define MBOX_MQ_ASYNC_CI_MASK  GENMASK(15, 8)
+#define MBOX_MQ_CI_GET(val, field)  \
+	FIELD_GET(MBOX_MQ_##field##_CI_MASK, val)
+
+#define MBOX_MGMT_FUNC_ID         0x1FFF
+#define MBOX_COMM_F_MBOX_SEGMENT  BIT(3)
+
+static struct hinic3_msg_desc *get_mbox_msg_desc(struct hinic3_mbox *mbox,
+						 enum mbox_msg_direction_type dir,
+						 u16 src_func_id)
+{
+	struct hinic3_msg_channel *msg_ch;
+
+	msg_ch = (src_func_id == MBOX_MGMT_FUNC_ID) ?
+		&mbox->mgmt_msg : mbox->func_msg;
+
+	return (dir == MBOX_MSG_SEND) ?
+		&msg_ch->recv_msg : &msg_ch->resp_msg;
+}
+
+static void resp_mbox_handler(struct hinic3_mbox *mbox,
+			      const struct hinic3_msg_desc *msg_desc)
+{
+	spin_lock(&mbox->mbox_lock);
+	if (msg_desc->msg_info.msg_id == mbox->send_msg_id &&
+	    mbox->event_flag == MBOX_EVENT_START)
+		mbox->event_flag = MBOX_EVENT_SUCCESS;
+	spin_unlock(&mbox->mbox_lock);
+}
+
+static bool mbox_segment_valid(struct hinic3_mbox *mbox,
+			       struct hinic3_msg_desc *msg_desc,
+			       u64 mbox_header)
+{
+	u8 seq_id, seg_len, msg_id, mod;
+	u16 src_func_idx, cmd;
+
+	seq_id = MBOX_MSG_HEADER_GET(mbox_header, SEQID);
+	seg_len = MBOX_MSG_HEADER_GET(mbox_header, SEG_LEN);
+	msg_id = MBOX_MSG_HEADER_GET(mbox_header, MSG_ID);
+	mod = MBOX_MSG_HEADER_GET(mbox_header, MODULE);
+	cmd = MBOX_MSG_HEADER_GET(mbox_header, CMD);
+	src_func_idx = MBOX_MSG_HEADER_GET(mbox_header, SRC_GLB_FUNC_IDX);
+
+	if (seq_id > MBOX_SEQ_ID_MAX_VAL || seg_len > MBOX_SEG_LEN ||
+	    (seq_id == MBOX_SEQ_ID_MAX_VAL && seg_len > MBOX_LAST_SEG_MAX_LEN))
+		goto err_seg;
+
+	if (seq_id == 0) {
+		msg_desc->seq_id = seq_id;
+		msg_desc->msg_info.msg_id = msg_id;
+		msg_desc->mod = mod;
+		msg_desc->cmd = cmd;
+	} else {
+		if (seq_id != msg_desc->seq_id + 1 ||
+		    msg_id != msg_desc->msg_info.msg_id ||
+		    mod != msg_desc->mod || cmd != msg_desc->cmd)
+			goto err_seg;
+
+		msg_desc->seq_id = seq_id;
+	}
+
+	return true;
+
+err_seg:
+	dev_err(mbox->hwdev->dev,
+		"Mailbox segment check failed, src func id: 0x%x, front seg info: seq id: 0x%x, msg id: 0x%x, mod: 0x%x, cmd: 0x%x\n",
+		src_func_idx, msg_desc->seq_id, msg_desc->msg_info.msg_id,
+		msg_desc->mod, msg_desc->cmd);
+	dev_err(mbox->hwdev->dev,
+		"Current seg info: seg len: 0x%x, seq id: 0x%x, msg id: 0x%x, mod: 0x%x, cmd: 0x%x\n",
+		seg_len, seq_id, msg_id, mod, cmd);
+
+	return false;
+}
+
+static void recv_mbox_handler(struct hinic3_mbox *mbox,
+			      u64 *header, struct hinic3_msg_desc *msg_desc)
+{
+	void *mbox_body = MBOX_BODY_FROM_HDR(((void *)header));
+	u64 mbox_header = *header;
+	u8 seq_id, seg_len;
+	int pos;
+
+	if (!mbox_segment_valid(mbox, msg_desc, mbox_header)) {
+		msg_desc->seq_id = MBOX_SEQ_ID_MAX_VAL;
+		return;
+	}
+
+	seq_id = MBOX_MSG_HEADER_GET(mbox_header, SEQID);
+	seg_len = MBOX_MSG_HEADER_GET(mbox_header, SEG_LEN);
+
+	pos = seq_id * MBOX_SEG_LEN;
+	memcpy((u8 *)msg_desc->msg + pos, mbox_body, seg_len);
+
+	if (!MBOX_MSG_HEADER_GET(mbox_header, LAST))
+		return;
+
+	msg_desc->msg_len = MBOX_MSG_HEADER_GET(mbox_header, MSG_LEN);
+	msg_desc->msg_info.status = MBOX_MSG_HEADER_GET(mbox_header, STATUS);
+
+	if (MBOX_MSG_HEADER_GET(mbox_header, DIRECTION) == MBOX_MSG_RESP)
+		resp_mbox_handler(mbox, msg_desc);
+}
+
+void hinic3_mbox_func_aeqe_handler(struct hinic3_hwdev *hwdev, u8 *header,
+				   u8 size)
+{
+	u64 mbox_header = *((u64 *)header);
+	enum mbox_msg_direction_type dir;
+	struct hinic3_mbox *mbox;
+	struct hinic3_msg_desc *msg_desc;
+	u16 src_func_id;
+
+	mbox = hwdev->mbox;
+	dir = MBOX_MSG_HEADER_GET(mbox_header, DIRECTION);
+	src_func_id = MBOX_MSG_HEADER_GET(mbox_header, SRC_GLB_FUNC_IDX);
+	msg_desc = get_mbox_msg_desc(mbox, dir, src_func_id);
+	recv_mbox_handler(mbox, (u64 *)header, msg_desc);
+}
+
+static int init_mbox_dma_queue(struct hinic3_hwdev *hwdev,
+			       struct mbox_dma_queue *mq)
+{
+	u32 size;
+
+	mq->depth = MBOX_DMA_MSG_QUEUE_DEPTH;
+	mq->prod_idx = 0;
+	mq->cons_idx = 0;
+
+	size = mq->depth * MBOX_MAX_BUF_SZ;
+	mq->dma_buf_vaddr = dma_alloc_coherent(hwdev->dev, size,
+					       &mq->dma_buf_paddr,
+					       GFP_KERNEL);
+	if (!mq->dma_buf_vaddr)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void uninit_mbox_dma_queue(struct hinic3_hwdev *hwdev,
+				  struct mbox_dma_queue *mq)
+{
+	dma_free_coherent(hwdev->dev, mq->depth * MBOX_MAX_BUF_SZ,
+			  mq->dma_buf_vaddr, mq->dma_buf_paddr);
+}
+
+static int hinic3_init_mbox_dma_queue(struct hinic3_mbox *mbox)
+{
+	u32 val;
+	int err;
+
+	err = init_mbox_dma_queue(mbox->hwdev, &mbox->sync_msg_queue);
+	if (err)
+		return err;
+
+	err = init_mbox_dma_queue(mbox->hwdev, &mbox->async_msg_queue);
+	if (err) {
+		uninit_mbox_dma_queue(mbox->hwdev, &mbox->sync_msg_queue);
+		return err;
+	}
+
+	val = hinic3_hwif_read_reg(mbox->hwdev->hwif, MBOX_MQ_CI_OFFSET);
+	val &= ~MBOX_MQ_SYNC_CI_MASK;
+	val &= ~MBOX_MQ_ASYNC_CI_MASK;
+	hinic3_hwif_write_reg(mbox->hwdev->hwif, MBOX_MQ_CI_OFFSET, val);
+
+	return 0;
+}
+
+static void hinic3_uninit_mbox_dma_queue(struct hinic3_mbox *mbox)
+{
+	uninit_mbox_dma_queue(mbox->hwdev, &mbox->sync_msg_queue);
+	uninit_mbox_dma_queue(mbox->hwdev, &mbox->async_msg_queue);
+}
+
+static int alloc_mbox_msg_channel(struct hinic3_msg_channel *msg_ch)
+{
+	msg_ch->resp_msg.msg = kzalloc(MBOX_MAX_BUF_SZ, GFP_KERNEL);
+	if (!msg_ch->resp_msg.msg)
+		return -ENOMEM;
+
+	msg_ch->recv_msg.msg = kzalloc(MBOX_MAX_BUF_SZ, GFP_KERNEL);
+	if (!msg_ch->recv_msg.msg) {
+		kfree(msg_ch->resp_msg.msg);
+		return -ENOMEM;
+	}
+
+	msg_ch->resp_msg.seq_id = MBOX_SEQ_ID_MAX_VAL;
+	msg_ch->recv_msg.seq_id = MBOX_SEQ_ID_MAX_VAL;
+
+	return 0;
+}
+
+static void free_mbox_msg_channel(struct hinic3_msg_channel *msg_ch)
+{
+	kfree(msg_ch->recv_msg.msg);
+	kfree(msg_ch->resp_msg.msg);
+}
+
+static int init_mgmt_msg_channel(struct hinic3_mbox *mbox)
+{
+	int err;
+
+	err = alloc_mbox_msg_channel(&mbox->mgmt_msg);
+	if (err) {
+		dev_err(mbox->hwdev->dev, "Failed to alloc mgmt message channel\n");
+		return err;
+	}
+
+	err = hinic3_init_mbox_dma_queue(mbox);
+	if (err) {
+		dev_err(mbox->hwdev->dev, "Failed to init mbox dma queue\n");
+		free_mbox_msg_channel(&mbox->mgmt_msg);
+		return err;
+	}
+
+	return 0;
+}
+
+static void uninit_mgmt_msg_channel(struct hinic3_mbox *mbox)
+{
+	hinic3_uninit_mbox_dma_queue(mbox);
+	free_mbox_msg_channel(&mbox->mgmt_msg);
+}
+
+static int hinic3_init_func_mbox_msg_channel(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_mbox *mbox;
+	int err;
+
+	mbox = hwdev->mbox;
+	mbox->func_msg = kzalloc(sizeof(*mbox->func_msg), GFP_KERNEL);
+	if (!mbox->func_msg)
+		return -ENOMEM;
+
+	err = alloc_mbox_msg_channel(mbox->func_msg);
+	if (err)
+		goto err_free_func_msg;
+
+	return 0;
+
+err_free_func_msg:
+	kfree(mbox->func_msg);
+	mbox->func_msg = NULL;
+
+	return err;
+}
+
+static void hinic3_uninit_func_mbox_msg_channel(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_mbox *mbox = hwdev->mbox;
+
+	free_mbox_msg_channel(mbox->func_msg);
+	kfree(mbox->func_msg);
+	mbox->func_msg = NULL;
+}
+
+static void prepare_send_mbox(struct hinic3_mbox *mbox)
+{
+	struct hinic3_send_mbox *send_mbox = &mbox->send_mbox;
+
+	send_mbox->data = MBOX_AREA(mbox->hwdev->hwif);
+}
+
+static int alloc_mbox_wb_status(struct hinic3_mbox *mbox)
+{
+	struct hinic3_send_mbox *send_mbox = &mbox->send_mbox;
+	struct hinic3_hwdev *hwdev = mbox->hwdev;
+	u32 addr_h, addr_l;
+
+	send_mbox->wb_vaddr = dma_alloc_coherent(hwdev->dev,
+						 MBOX_WB_STATUS_LEN,
+						 &send_mbox->wb_paddr,
+						 GFP_KERNEL);
+	if (!send_mbox->wb_vaddr)
+		return -ENOMEM;
+
+	addr_h = upper_32_bits(send_mbox->wb_paddr);
+	addr_l = lower_32_bits(send_mbox->wb_paddr);
+	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_FUNC_CSR_MAILBOX_RESULT_H_OFF,
+			      addr_h);
+	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_FUNC_CSR_MAILBOX_RESULT_L_OFF,
+			      addr_l);
+
+	return 0;
+}
+
+static void free_mbox_wb_status(struct hinic3_mbox *mbox)
+{
+	struct hinic3_send_mbox *send_mbox = &mbox->send_mbox;
+	struct hinic3_hwdev *hwdev = mbox->hwdev;
+
+	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_FUNC_CSR_MAILBOX_RESULT_H_OFF,
+			      0);
+	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_FUNC_CSR_MAILBOX_RESULT_L_OFF,
+			      0);
+
+	dma_free_coherent(hwdev->dev, MBOX_WB_STATUS_LEN,
+			  send_mbox->wb_vaddr, send_mbox->wb_paddr);
+}
+
+static int hinic3_mbox_pre_init(struct hinic3_hwdev *hwdev,
+				struct hinic3_mbox **mbox)
+{
+	(*mbox) = kzalloc(sizeof(struct hinic3_mbox), GFP_KERNEL);
+	if (!(*mbox))
+		return -ENOMEM;
+
+	(*mbox)->hwdev = hwdev;
+	mutex_init(&(*mbox)->mbox_send_lock);
+	mutex_init(&(*mbox)->msg_send_lock);
+	spin_lock_init(&(*mbox)->mbox_lock);
+
+	(*mbox)->workq = create_singlethread_workqueue(HINIC3_MBOX_WQ_NAME);
+	if (!(*mbox)->workq) {
+		dev_err(hwdev->dev, "Failed to initialize MBOX workqueue\n");
+		kfree((*mbox));
+		return -ENOMEM;
+	}
+	hwdev->mbox = (*mbox);
+
+	return 0;
+}
+
+int hinic3_init_mbox(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_mbox *mbox;
+	int err;
+
+	err = hinic3_mbox_pre_init(hwdev, &mbox);
+	if (err)
+		return err;
+
+	err = init_mgmt_msg_channel(mbox);
+	if (err)
+		goto err_destroy_workqueue;
+
+	err = hinic3_init_func_mbox_msg_channel(hwdev);
+	if (err)
+		goto err_uninit_mgmt_msg_ch;
+
+	err = alloc_mbox_wb_status(mbox);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to alloc mbox write back status\n");
+		goto err_uninit_func_mbox_msg_ch;
+	}
+
+	prepare_send_mbox(mbox);
+
+	return 0;
+
+err_uninit_func_mbox_msg_ch:
+	hinic3_uninit_func_mbox_msg_channel(hwdev);
+
+err_uninit_mgmt_msg_ch:
+	uninit_mgmt_msg_channel(mbox);
+
+err_destroy_workqueue:
+	destroy_workqueue(mbox->workq);
+	kfree(mbox);
+
+	return err;
+}
+
+void hinic3_free_mbox(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_mbox *mbox = hwdev->mbox;
+
+	destroy_workqueue(mbox->workq);
+	free_mbox_wb_status(mbox);
+	hinic3_uninit_func_mbox_msg_channel(hwdev);
+	uninit_mgmt_msg_channel(mbox);
+	kfree(mbox);
+}
+
+#define MBOX_DMA_MSG_INIT_XOR_VAL    0x5a5a5a5a
+#define MBOX_XOR_DATA_ALIGN          4
+static u32 mbox_dma_msg_xor(u32 *data, u32 msg_len)
+{
+	u32 xor = MBOX_DMA_MSG_INIT_XOR_VAL;
+	u32 dw_len = msg_len / sizeof(u32);
+	u32 i;
+
+	for (i = 0; i < dw_len; i++)
+		xor ^= data[i];
+
+	return xor;
+}
+
+#define MBOX_MQ_ID_MASK(mq, idx)  ((idx) & ((mq)->depth - 1))
+
+static bool is_msg_queue_full(struct mbox_dma_queue *mq)
+{
+	return (MBOX_MQ_ID_MASK(mq, (mq)->prod_idx + 1) ==
+		MBOX_MQ_ID_MASK(mq, (mq)->cons_idx));
+}
+
+static int mbox_prepare_dma_entry(struct hinic3_mbox *mbox,
+				  struct mbox_dma_queue *mq,
+				  struct mbox_dma_msg *dma_msg,
+				  const void *msg, u32 msg_len)
+{
+	u64 dma_addr, offset;
+	void *dma_vaddr;
+
+	if (is_msg_queue_full(mq)) {
+		dev_err(mbox->hwdev->dev, "Mbox sync message queue is busy, pi: %u, ci: %u\n",
+			mq->prod_idx, MBOX_MQ_ID_MASK(mq, mq->cons_idx));
+		return -EBUSY;
+	}
+
+	/* copy data to DMA buffer */
+	offset = mq->prod_idx * MBOX_MAX_BUF_SZ;
+	dma_vaddr = (u8 *)mq->dma_buf_vaddr + offset;
+	memcpy(dma_vaddr, msg, msg_len);
+	dma_addr = mq->dma_buf_paddr + offset;
+	dma_msg->dma_addr_high = upper_32_bits(dma_addr);
+	dma_msg->dma_addr_low = lower_32_bits(dma_addr);
+	dma_msg->msg_len = msg_len;
+	/* The firmware obtains message based on 4B alignment. */
+	dma_msg->xor = mbox_dma_msg_xor(dma_vaddr,
+					ALIGN(msg_len, MBOX_XOR_DATA_ALIGN));
+	mq->prod_idx++;
+	mq->prod_idx = MBOX_MQ_ID_MASK(mq, mq->prod_idx);
+
+	return 0;
+}
+
+static int mbox_prepare_dma_msg(struct hinic3_mbox *mbox,
+				enum mbox_msg_ack_type ack_type,
+				struct mbox_dma_msg *dma_msg, const void *msg,
+				u32 msg_len)
+{
+	struct mbox_dma_queue *mq;
+	u32 val;
+
+	val = hinic3_hwif_read_reg(mbox->hwdev->hwif, MBOX_MQ_CI_OFFSET);
+	if (ack_type == MBOX_MSG_ACK) {
+		mq = &mbox->sync_msg_queue;
+		mq->cons_idx = MBOX_MQ_CI_GET(val, SYNC);
+	} else {
+		mq = &mbox->async_msg_queue;
+		mq->cons_idx = MBOX_MQ_CI_GET(val, ASYNC);
+	}
+
+	return mbox_prepare_dma_entry(mbox, mq, dma_msg, msg, msg_len);
+}
+
+static void clear_mbox_status(struct hinic3_send_mbox *mbox)
+{
+	__be64 *wb_status = mbox->wb_vaddr;
+
+	*wb_status = 0;
+	/* clear mailbox write back status */
+	wmb();
+}
+
+static void mbox_dword_write(const void *src, void __iomem *dst, u32 count)
+{
+	u32 __iomem *dst32 = dst;
+	const u32 *src32 = src;
+	u32 i;
+
+	/* Data written to mbox is arranged in structs with little endian fields
+	 * but when written to HW every dword (32bits) should be swapped since
+	 * the HW will swap it again. This is a mandatory swap regardless of the
+	 * CPU endianness.
+	 */
+	for (i = 0; i < count; i++)
+		__raw_writel(swab32(src32[i]), dst32 + i);
+}
+
+static void mbox_copy_header(struct hinic3_hwdev *hwdev,
+			     struct hinic3_send_mbox *mbox, u64 *header)
+{
+	mbox_dword_write(header, mbox->data, MBOX_HEADER_SZ / sizeof(u32));
+}
+
+static void mbox_copy_send_data(struct hinic3_hwdev *hwdev,
+				struct hinic3_send_mbox *mbox, void *seg,
+				u32 seg_len)
+{
+	u32 __iomem *dst = (u32 __iomem *)(mbox->data + MBOX_HEADER_SZ);
+	u32 count, leftover, last_dword;
+	const u32 *src = seg;
+
+	count = seg_len / sizeof(u32);
+	leftover = seg_len % sizeof(u32);
+	if (count > 0)
+		mbox_dword_write(src, dst, count);
+
+	if (leftover > 0) {
+		last_dword = 0;
+		memcpy(&last_dword, src + count, leftover);
+		mbox_dword_write(&last_dword, dst + count, 1);
+	}
+}
+
+static void write_mbox_msg_attr(struct hinic3_mbox *mbox,
+				u16 dst_func, u16 dst_aeqn, u32 seg_len)
+{
+	struct hinic3_hwif *hwif = mbox->hwdev->hwif;
+	u32 mbox_int, mbox_ctrl, tx_size;
+
+	tx_size = ALIGN(seg_len + MBOX_HEADER_SZ, MBOX_SEG_LEN_ALIGN) >> 2;
+
+	mbox_int = MBOX_INT_SET(dst_aeqn, DST_AEQN) |
+		   MBOX_INT_SET(0, STAT_DMA) |
+		   MBOX_INT_SET(tx_size, TX_SIZE) |
+		   MBOX_INT_SET(0, STAT_DMA_SO_RO) |
+		   MBOX_INT_SET(1, WB_EN);
+
+	mbox_ctrl = MBOX_CTRL_SET(1, TX_STATUS) |
+		    MBOX_CTRL_SET(0, TRIGGER_AEQE) |
+		    MBOX_CTRL_SET(dst_func, DST_FUNC);
+
+	hinic3_hwif_write_reg(hwif, HINIC3_FUNC_CSR_MAILBOX_INT_OFF, mbox_int);
+	hinic3_hwif_write_reg(hwif, HINIC3_FUNC_CSR_MAILBOX_CONTROL_OFF,
+			      mbox_ctrl);
+}
+
+static u16 get_mbox_status(const struct hinic3_send_mbox *mbox)
+{
+	__be64 *wb_status = mbox->wb_vaddr;
+	u64 wb_val;
+
+	wb_val = be64_to_cpu(*wb_status);
+	/* verify reading before check */
+	rmb();
+
+	return wb_val & MBOX_WB_STATUS_ERRCODE_MASK;
+}
+
+static enum hinic3_wait_return check_mbox_wb_status(void *priv_data)
+{
+	struct hinic3_mbox *mbox = priv_data;
+	u16 wb_status;
+
+	wb_status = get_mbox_status(&mbox->send_mbox);
+
+	return MBOX_STATUS_FINISHED(wb_status) ?
+	       HINIC3_WAIT_PROCESS_CPL : HINIC3_WAIT_PROCESS_WAITING;
+}
+
+static int send_mbox_seg(struct hinic3_mbox *mbox, u64 header,
+			 u16 dst_func, void *seg, u32 seg_len, void *msg_info)
+{
+	struct hinic3_send_mbox *send_mbox = &mbox->send_mbox;
+	struct hinic3_hwdev *hwdev = mbox->hwdev;
+	u8 num_aeqs = hwdev->hwif->attr.num_aeqs;
+	enum mbox_msg_direction_type dir;
+	u16 dst_aeqn, wb_status, errcode;
+	int err;
+
+	/* mbox to mgmt cpu, hardware doesn't care about dst aeq id */
+	if (num_aeqs > MBOX_MSG_AEQ_FOR_MBOX) {
+		dir = MBOX_MSG_HEADER_GET(header, DIRECTION);
+		dst_aeqn = (dir == MBOX_MSG_SEND) ?
+			   MBOX_MSG_AEQ_FOR_EVENT : MBOX_MSG_AEQ_FOR_MBOX;
+	} else {
+		dst_aeqn = 0;
+	}
+
+	clear_mbox_status(send_mbox);
+	mbox_copy_header(hwdev, send_mbox, &header);
+	mbox_copy_send_data(hwdev, send_mbox, seg, seg_len);
+	write_mbox_msg_attr(mbox, dst_func, dst_aeqn, seg_len);
+
+	err = hinic3_wait_for_timeout(mbox, check_mbox_wb_status,
+				      MBOX_MSG_POLLING_TIMEOUT_MS,
+				      USEC_PER_MSEC);
+	wb_status = get_mbox_status(send_mbox);
+	if (err) {
+		dev_err(hwdev->dev, "Send mailbox segment timeout, wb status: 0x%x\n",
+			wb_status);
+		return err;
+	}
+
+	if (!MBOX_STATUS_SUCCESS(wb_status)) {
+		dev_err(hwdev->dev,
+			"Send mailbox segment to function %u error, wb status: 0x%x\n",
+			dst_func, wb_status);
+		errcode = MBOX_STATUS_ERRCODE(wb_status);
+		return errcode ? errcode : -EFAULT;
+	}
+
+	return 0;
+}
+
+static int send_mbox_msg(struct hinic3_mbox *mbox, u8 mod, u16 cmd,
+			 const void *msg, u32 msg_len, u16 dst_func,
+			 enum mbox_msg_direction_type direction,
+			 enum mbox_msg_ack_type ack_type,
+			 struct mbox_msg_info *msg_info)
+{
+	enum mbox_msg_data_type data_type = MBOX_MSG_DATA_INLINE;
+	struct hinic3_hwdev *hwdev = mbox->hwdev;
+	struct mbox_dma_msg dma_msg;
+	u32 seg_len = MBOX_SEG_LEN;
+	u64 header = 0;
+	u32 seq_id = 0;
+	u16 rsp_aeq_id;
+	u8 *msg_seg;
+	int err = 0;
+	u32 left;
+
+	if (hwdev->hwif->attr.num_aeqs > MBOX_MSG_AEQ_FOR_MBOX)
+		rsp_aeq_id = MBOX_MSG_AEQ_FOR_MBOX;
+	else
+		rsp_aeq_id = 0;
+
+	mutex_lock(&mbox->msg_send_lock);
+
+	if (dst_func == MBOX_MGMT_FUNC_ID &&
+	    !(hwdev->features[0] & MBOX_COMM_F_MBOX_SEGMENT)) {
+		err = mbox_prepare_dma_msg(mbox, ack_type, &dma_msg,
+					   msg, msg_len);
+		if (err)
+			goto err_send;
+
+		msg = &dma_msg;
+		msg_len = sizeof(dma_msg);
+		data_type = MBOX_MSG_DATA_DMA;
+	}
+
+	msg_seg = (u8 *)msg;
+	left = msg_len;
+
+	header = MBOX_MSG_HEADER_SET(msg_len, MSG_LEN) |
+		 MBOX_MSG_HEADER_SET(mod, MODULE) |
+		 MBOX_MSG_HEADER_SET(seg_len, SEG_LEN) |
+		 MBOX_MSG_HEADER_SET(ack_type, NO_ACK) |
+		 MBOX_MSG_HEADER_SET(data_type, DATA_TYPE) |
+		 MBOX_MSG_HEADER_SET(MBOX_SEQ_ID_START_VAL, SEQID) |
+		 MBOX_MSG_HEADER_SET(direction, DIRECTION) |
+		 MBOX_MSG_HEADER_SET(cmd, CMD) |
+		 MBOX_MSG_HEADER_SET(msg_info->msg_id, MSG_ID) |
+		 MBOX_MSG_HEADER_SET(rsp_aeq_id, AEQ_ID) |
+		 MBOX_MSG_HEADER_SET(MBOX_MSG_FROM_MBOX, SOURCE) |
+		 MBOX_MSG_HEADER_SET(!!msg_info->status, STATUS);
+
+	while (!(MBOX_MSG_HEADER_GET(header, LAST))) {
+		if (left <= MBOX_SEG_LEN) {
+			header &= ~MBOX_MSG_HEADER_SEG_LEN_MASK;
+			header |= MBOX_MSG_HEADER_SET(left, SEG_LEN) |
+				  MBOX_MSG_HEADER_SET(1, LAST);
+			seg_len = left;
+		}
+
+		err = send_mbox_seg(mbox, header, dst_func, msg_seg,
+				    seg_len, msg_info);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to send mbox seg, seq_id=0x%llx\n",
+				MBOX_MSG_HEADER_GET(header, SEQID));
+			goto err_send;
+		}
+
+		left -= MBOX_SEG_LEN;
+		msg_seg += MBOX_SEG_LEN;
+		seq_id++;
+		header &= ~MBOX_MSG_HEADER_SEG_LEN_MASK;
+		header |= MBOX_MSG_HEADER_SET(seq_id, SEQID);
+	}
+
+err_send:
+	mutex_unlock(&mbox->msg_send_lock);
+
+	return err;
+}
+
+static void set_mbox_to_func_event(struct hinic3_mbox *mbox,
+				   enum mbox_event_state event_flag)
+{
+	spin_lock(&mbox->mbox_lock);
+	mbox->event_flag = event_flag;
+	spin_unlock(&mbox->mbox_lock);
+}
+
+static enum hinic3_wait_return check_mbox_msg_finish(void *priv_data)
+{
+	struct hinic3_mbox *mbox = priv_data;
+
+	return (mbox->event_flag == MBOX_EVENT_SUCCESS) ?
+		HINIC3_WAIT_PROCESS_CPL : HINIC3_WAIT_PROCESS_WAITING;
+}
+
+static int wait_mbox_msg_completion(struct hinic3_mbox *mbox,
+				    u32 timeout)
+{
+	u32 wait_time;
+	int err;
+
+	wait_time = (timeout != 0) ? timeout : MBOX_COMP_POLLING_TIMEOUT_MS;
+	err = hinic3_wait_for_timeout(mbox, check_mbox_msg_finish,
+				      wait_time, USEC_PER_MSEC);
+	if (err) {
+		set_mbox_to_func_event(mbox, MBOX_EVENT_TIMEOUT);
+		return err;
+	}
+	set_mbox_to_func_event(mbox, MBOX_EVENT_END);
+
+	return 0;
+}
+
 int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
 			     const struct mgmt_msg_params *msg_params)
 {
-	/* Completed by later submission due to LoC limit. */
-	return -EFAULT;
+	struct hinic3_mbox *mbox = hwdev->mbox;
+	struct mbox_msg_info msg_info = {};
+	struct hinic3_msg_desc *msg_desc;
+	int err;
+
+	/* expect response message */
+	msg_desc = get_mbox_msg_desc(mbox, MBOX_MSG_RESP, MBOX_MGMT_FUNC_ID);
+	mutex_lock(&mbox->mbox_send_lock);
+	msg_info.msg_id = (msg_info.msg_id + 1) & 0xF;
+	mbox->send_msg_id = msg_info.msg_id;
+	set_mbox_to_func_event(mbox, MBOX_EVENT_START);
+
+	err = send_mbox_msg(mbox, mod, cmd, msg_params->buf_in,
+			    msg_params->in_size, MBOX_MGMT_FUNC_ID,
+			    MBOX_MSG_SEND, MBOX_MSG_ACK, &msg_info);
+	if (err) {
+		dev_err(hwdev->dev, "Send mailbox mod %u, cmd %u failed, msg_id: %u, err: %d\n",
+			mod, cmd, msg_info.msg_id, err);
+		set_mbox_to_func_event(mbox, MBOX_EVENT_FAIL);
+		goto err_send;
+	}
+
+	if (wait_mbox_msg_completion(mbox, msg_params->timeout_ms)) {
+		dev_err(hwdev->dev,
+			"Send mbox msg timeout, msg_id: %u\n", msg_info.msg_id);
+		err = -ETIMEDOUT;
+		goto err_send;
+	}
+
+	if (mod != msg_desc->mod || cmd != msg_desc->cmd) {
+		dev_err(hwdev->dev,
+			"Invalid response mbox message, mod: 0x%x, cmd: 0x%x, expect mod: 0x%x, cmd: 0x%x\n",
+			msg_desc->mod, msg_desc->cmd, mod, cmd);
+		err = -EFAULT;
+		goto err_send;
+	}
+
+	if (msg_desc->msg_info.status) {
+		err = msg_desc->msg_info.status;
+		goto err_send;
+	}
+
+	if (msg_params->buf_out) {
+		if (msg_desc->msg_len != msg_params->expected_out_size) {
+			dev_err(hwdev->dev,
+				"Invalid response mbox message length: %u for mod %d cmd %u, expected length: %u\n",
+				msg_desc->msg_len, mod, cmd,
+				msg_params->expected_out_size);
+			err = -EFAULT;
+			goto err_send;
+		}
+
+		memcpy(msg_params->buf_out, msg_desc->msg, msg_desc->msg_len);
+	}
+
+err_send:
+	mutex_unlock(&mbox->mbox_send_lock);
+
+	return err;
+}
+
+int hinic3_send_mbox_to_mgmt_no_ack(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
+				    const struct mgmt_msg_params *msg_params)
+{
+	struct hinic3_mbox *mbox = hwdev->mbox;
+	struct mbox_msg_info msg_info = {};
+	int err;
+
+	mutex_lock(&mbox->mbox_send_lock);
+	err = send_mbox_msg(mbox, mod, cmd, msg_params->buf_in,
+			    msg_params->in_size, MBOX_MGMT_FUNC_ID,
+			    MBOX_MSG_SEND, MBOX_MSG_NO_ACK, &msg_info);
+	if (err)
+		dev_err(hwdev->dev, "Send mailbox no ack failed\n");
+
+	mutex_unlock(&mbox->mbox_send_lock);
+
+	return err;
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
index d7a6c37b7eff..2435df31d9e5 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
@@ -9,7 +9,134 @@
 
 struct hinic3_hwdev;
 
+#define MBOX_MSG_HEADER_SRC_GLB_FUNC_IDX_MASK  GENMASK_ULL(12, 0)
+#define MBOX_MSG_HEADER_STATUS_MASK            BIT_ULL(13)
+#define MBOX_MSG_HEADER_SOURCE_MASK            BIT_ULL(15)
+#define MBOX_MSG_HEADER_AEQ_ID_MASK            GENMASK_ULL(17, 16)
+#define MBOX_MSG_HEADER_MSG_ID_MASK            GENMASK_ULL(21, 18)
+#define MBOX_MSG_HEADER_CMD_MASK               GENMASK_ULL(31, 22)
+#define MBOX_MSG_HEADER_MSG_LEN_MASK           GENMASK_ULL(42, 32)
+#define MBOX_MSG_HEADER_MODULE_MASK            GENMASK_ULL(47, 43)
+#define MBOX_MSG_HEADER_SEG_LEN_MASK           GENMASK_ULL(53, 48)
+#define MBOX_MSG_HEADER_NO_ACK_MASK            BIT_ULL(54)
+#define MBOX_MSG_HEADER_DATA_TYPE_MASK         BIT_ULL(55)
+#define MBOX_MSG_HEADER_SEQID_MASK             GENMASK_ULL(61, 56)
+#define MBOX_MSG_HEADER_LAST_MASK              BIT_ULL(62)
+#define MBOX_MSG_HEADER_DIRECTION_MASK         BIT_ULL(63)
+
+#define MBOX_MSG_HEADER_SET(val, member) \
+	FIELD_PREP(MBOX_MSG_HEADER_##member##_MASK, val)
+#define MBOX_MSG_HEADER_GET(val, member) \
+	FIELD_GET(MBOX_MSG_HEADER_##member##_MASK, val)
+
+/* identifies if a segment belongs to a message or to a response. A VF is only
+ * expected to send messages and receive responses. PF driver could receive
+ * messages and send responses.
+ */
+enum mbox_msg_direction_type {
+	MBOX_MSG_SEND = 0,
+	MBOX_MSG_RESP = 1,
+};
+
+/* Indicates if mbox message expects a response (ack) or not */
+enum mbox_msg_ack_type {
+	MBOX_MSG_ACK    = 0,
+	MBOX_MSG_NO_ACK = 1,
+};
+
+enum mbox_msg_data_type {
+	MBOX_MSG_DATA_INLINE = 0,
+	MBOX_MSG_DATA_DMA    = 1,
+};
+
+enum mbox_msg_src_type {
+	MBOX_MSG_FROM_MBOX = 1,
+};
+
+enum mbox_msg_aeq_type {
+	MBOX_MSG_AEQ_FOR_EVENT = 0,
+	MBOX_MSG_AEQ_FOR_MBOX  = 1,
+};
+
+#define HINIC3_MBOX_WQ_NAME  "hinic3_mbox"
+
+struct mbox_msg_info {
+	u8 msg_id;
+	u8 status;
+};
+
+struct hinic3_msg_desc {
+	void                 *msg;
+	u16                  msg_len;
+	u8                   seq_id;
+	u8                   mod;
+	u16                  cmd;
+	struct mbox_msg_info msg_info;
+};
+
+struct hinic3_msg_channel {
+	struct   hinic3_msg_desc resp_msg;
+	struct   hinic3_msg_desc recv_msg;
+};
+
+struct hinic3_send_mbox {
+	u8 __iomem *data;
+	void       *wb_vaddr;
+	dma_addr_t wb_paddr;
+};
+
+enum mbox_event_state {
+	MBOX_EVENT_START   = 0,
+	MBOX_EVENT_FAIL    = 1,
+	MBOX_EVENT_SUCCESS = 2,
+	MBOX_EVENT_TIMEOUT = 3,
+	MBOX_EVENT_END     = 4,
+};
+
+struct mbox_dma_msg {
+	u32 xor;
+	u32 dma_addr_high;
+	u32 dma_addr_low;
+	u32 msg_len;
+	u64 rsvd;
+};
+
+struct mbox_dma_queue {
+	void       *dma_buf_vaddr;
+	dma_addr_t dma_buf_paddr;
+	u16        depth;
+	u16        prod_idx;
+	u16        cons_idx;
+};
+
+struct hinic3_mbox {
+	struct hinic3_hwdev       *hwdev;
+	/* lock for send mbox message and ack message */
+	struct mutex              mbox_send_lock;
+	/* lock for send mbox message */
+	struct mutex              msg_send_lock;
+	struct hinic3_send_mbox   send_mbox;
+	struct mbox_dma_queue     sync_msg_queue;
+	struct mbox_dma_queue     async_msg_queue;
+	struct workqueue_struct   *workq;
+	/* driver and MGMT CPU */
+	struct hinic3_msg_channel mgmt_msg;
+	/* VF to PF */
+	struct hinic3_msg_channel *func_msg;
+	u8                        send_msg_id;
+	enum mbox_event_state     event_flag;
+	/* lock for mbox event flag */
+	spinlock_t                mbox_lock;
+};
+
+void hinic3_mbox_func_aeqe_handler(struct hinic3_hwdev *hwdev, u8 *header,
+				   u8 size);
+int hinic3_init_mbox(struct hinic3_hwdev *hwdev);
+void hinic3_free_mbox(struct hinic3_hwdev *hwdev);
+
 int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
 			     const struct mgmt_msg_params *msg_params);
+int hinic3_send_mbox_to_mgmt_no_ack(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
+				    const struct mgmt_msg_params *msg_params);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index 5b1a91a18c67..37f9ecf3404e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -89,6 +89,7 @@ int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu)
 	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
 
 	func_tbl_cfg.mtu = new_mtu;
+
 	return hinic3_set_function_table(hwdev, BIT(L2NIC_FUNC_TBL_CFG_MTU),
 					 &func_tbl_cfg);
 }
@@ -206,6 +207,7 @@ int hinic3_update_mac(struct hinic3_hwdev *hwdev, const u8 *old_mac,
 			err, mac_info.msg_head.status);
 		return -EIO;
 	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index c994fc9b6ee0..9fad834f9e92 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -51,6 +51,12 @@ struct hinic3_dyna_txrxq_params {
 	struct hinic3_irq_cfg      *irq_cfg;
 };
 
+struct hinic3_intr_coal_info {
+	u8 pending_limit;
+	u8 coalesce_timer_cfg;
+	u8 resend_timer_cfg;
+};
+
 struct hinic3_nic_dev {
 	struct pci_dev                  *pdev;
 	struct net_device               *netdev;
@@ -70,13 +76,13 @@ struct hinic3_nic_dev {
 	u16                             num_qp_irq;
 	struct msix_entry               *qps_msix_entries;
 
+	struct hinic3_intr_coal_info    *intr_coalesce;
+
 	bool                            link_status_up;
 };
 
 void hinic3_set_netdev_ops(struct net_device *netdev);
-
-/* Temporary prototypes. Functions become static in later submission. */
-void qp_add_napi(struct hinic3_irq_cfg *irq_cfg);
-void qp_del_napi(struct hinic3_irq_cfg *irq_cfg);
+int hinic3_qps_irq_init(struct net_device *netdev);
+void hinic3_qps_irq_uninit(struct net_device *netdev);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h b/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h
index ec4cae0a0929..2bf7a70251bb 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h
@@ -48,6 +48,7 @@ static inline void *get_q_element(const struct hinic3_queue_pages *qpages,
 		*remaining_in_page = elem_per_pg - elem_idx;
 	ofs = elem_idx << qpages->elem_size_shift;
 	page = qpages->pages + page_idx;
+
 	return (char *)page->align_vaddr + ofs;
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index 3f7f73430be4..4dbe610457d9 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -116,6 +116,7 @@ static int hinic3_tx_map_skb(struct net_device *netdev, struct sk_buff *skb,
 	}
 	dma_unmap_single(&pdev->dev, dma_info[0].dma, dma_info[0].len,
 			 DMA_TO_DEVICE);
+
 	return err;
 }
 
@@ -575,6 +576,7 @@ netdev_tx_t hinic3_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 
 err_drop_pkt:
 	dev_kfree_skb_any(skb);
+
 	return NETDEV_TX_OK;
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_wq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.c
index 2ac7efcd1365..bc3ffdc25cf6 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_wq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.c
@@ -6,6 +6,110 @@
 #include "hinic3_hwdev.h"
 #include "hinic3_wq.h"
 
+#define WQ_MIN_DEPTH            64
+#define WQ_MAX_DEPTH            65536
+#define WQ_PAGE_ADDR_SIZE       sizeof(u64)
+#define WQ_MAX_NUM_PAGES        (HINIC3_MIN_PAGE_SIZE / WQ_PAGE_ADDR_SIZE)
+
+static int wq_init_wq_block(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq)
+{
+	struct hinic3_queue_pages *qpages = &wq->qpages;
+	int i;
+
+	if (hinic3_wq_is_0_level_cla(wq)) {
+		wq->wq_block_paddr = qpages->pages[0].align_paddr;
+		wq->wq_block_vaddr = qpages->pages[0].align_vaddr;
+
+		return 0;
+	}
+
+	if (wq->qpages.num_pages > WQ_MAX_NUM_PAGES) {
+		dev_err(hwdev->dev, "wq num_pages exceed limit: %lu\n",
+			WQ_MAX_NUM_PAGES);
+		return -EFAULT;
+	}
+
+	wq->wq_block_vaddr = dma_alloc_coherent(hwdev->dev,
+						HINIC3_MIN_PAGE_SIZE,
+						&wq->wq_block_paddr,
+						GFP_KERNEL);
+	if (!wq->wq_block_vaddr)
+		return -ENOMEM;
+
+	for (i = 0; i < qpages->num_pages; i++)
+		wq->wq_block_vaddr[i] = cpu_to_be64(qpages->pages[i].align_paddr);
+
+	return 0;
+}
+
+static int wq_alloc_pages(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq)
+{
+	int err;
+
+	err = hinic3_queue_pages_alloc(hwdev, &wq->qpages, 0);
+	if (err)
+		return err;
+
+	err = wq_init_wq_block(hwdev, wq);
+	if (err) {
+		hinic3_queue_pages_free(hwdev, &wq->qpages);
+		return err;
+	}
+
+	return 0;
+}
+
+static void wq_free_pages(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq)
+{
+	if (!hinic3_wq_is_0_level_cla(wq))
+		dma_free_coherent(hwdev->dev,
+				  HINIC3_MIN_PAGE_SIZE,
+				  wq->wq_block_vaddr,
+				  wq->wq_block_paddr);
+
+	hinic3_queue_pages_free(hwdev, &wq->qpages);
+}
+
+int hinic3_wq_create(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq,
+		     u32 q_depth, u16 wqebb_size)
+{
+	u32 wq_page_size;
+
+	if (q_depth < WQ_MIN_DEPTH || q_depth > WQ_MAX_DEPTH ||
+	    !is_power_of_2(q_depth) || !is_power_of_2(wqebb_size)) {
+		dev_err(hwdev->dev, "Invalid WQ: q_depth %u, wqebb_size %u\n",
+			q_depth, wqebb_size);
+		return -EINVAL;
+	}
+
+	wq_page_size = ALIGN(hwdev->wq_page_size, HINIC3_MIN_PAGE_SIZE);
+
+	memset(wq, 0, sizeof(*wq));
+	wq->q_depth = q_depth;
+	wq->idx_mask = q_depth - 1;
+
+	hinic3_queue_pages_init(&wq->qpages, q_depth, wq_page_size, wqebb_size);
+
+	return wq_alloc_pages(hwdev, wq);
+}
+
+void hinic3_wq_destroy(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq)
+{
+	wq_free_pages(hwdev, wq);
+}
+
+void hinic3_wq_reset(struct hinic3_wq *wq)
+{
+	struct hinic3_queue_pages *qpages = &wq->qpages;
+	u16 pg_idx;
+
+	wq->cons_idx = 0;
+	wq->prod_idx = 0;
+
+	for (pg_idx = 0; pg_idx < qpages->num_pages; pg_idx++)
+		memset(qpages->pages[pg_idx].align_vaddr, 0, qpages->page_size);
+}
+
 void hinic3_wq_get_multi_wqebbs(struct hinic3_wq *wq,
 				u16 num_wqebbs, u16 *prod_idx,
 				struct hinic3_sq_bufdesc **first_part_wqebbs,
@@ -27,3 +131,8 @@ void hinic3_wq_get_multi_wqebbs(struct hinic3_wq *wq,
 		*second_part_wqebbs = get_q_element(&wq->qpages, idx, NULL);
 	}
 }
+
+bool hinic3_wq_is_0_level_cla(const struct hinic3_wq *wq)
+{
+	return wq->qpages.num_pages == 1;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_wq.h b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.h
index ab37893efd7e..20949f7f636b 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_wq.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.h
@@ -59,6 +59,7 @@ static inline void *hinic3_wq_get_one_wqebb(struct hinic3_wq *wq, u16 *pi)
 {
 	*pi = wq->prod_idx & wq->idx_mask;
 	wq->prod_idx++;
+
 	return get_q_element(&wq->qpages, *pi, NULL);
 }
 
@@ -67,10 +68,20 @@ static inline void hinic3_wq_put_wqebbs(struct hinic3_wq *wq, u16 num_wqebbs)
 	wq->cons_idx += num_wqebbs;
 }
 
+static inline u64 hinic3_wq_get_first_wqe_page_addr(const struct hinic3_wq *wq)
+{
+	return wq->qpages.pages[0].align_paddr;
+}
+
+int hinic3_wq_create(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq,
+		     u32 q_depth, u16 wqebb_size);
+void hinic3_wq_destroy(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq);
+void hinic3_wq_reset(struct hinic3_wq *wq);
 void hinic3_wq_get_multi_wqebbs(struct hinic3_wq *wq,
 				u16 num_wqebbs, u16 *prod_idx,
 				struct hinic3_sq_bufdesc **first_part_wqebbs,
 				struct hinic3_sq_bufdesc **second_part_wqebbs,
 				u16 *first_part_wqebbs_num);
+bool hinic3_wq_is_0_level_cla(const struct hinic3_wq *wq);
 
 #endif
-- 
2.43.0


