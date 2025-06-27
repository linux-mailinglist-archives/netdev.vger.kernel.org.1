Return-Path: <netdev+bounces-201759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BEBAEAECB
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F2218970B8
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 06:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471A6202965;
	Fri, 27 Jun 2025 06:13:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E7F1FF1B4;
	Fri, 27 Jun 2025 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751004799; cv=none; b=nMfj91yuD0pJbCTu+2e3IQFsLCuELqFelKBMxQH96rXnR9jejUgf7Ivut2GOk9tqxQI7K5/qxUfg//p/m1LmhO4si3wdXjHaowqLXOXZGhhPG0GOLAlq49dqvs8hSbMAskMcz6INeY9UNt0B9Z/ZRk2Qvk9rsPZZdga5iz805uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751004799; c=relaxed/simple;
	bh=Z3OYwxJwLXCivx7PJr1HJLXf2f4EUZ6Gku+szxNC8Zs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgvnwTnK/veISq1fr1ozFvIIMQbfNoMgzd9/x3Mnf/A2e/3mGa/5CgvuIaS8ow7y87tlD76AwghEI+YUFdZcLQ+nkAfPPi5UG3KGxE+apvDNVG8fQMcsa1IFz5VCbwMe0Qjxx2tYamlK/tiDeZWAdKnzoLcreaKcRVD0KfHsD24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bT4ql5l6dz10WsW;
	Fri, 27 Jun 2025 14:08:35 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id E9728180B48;
	Fri, 27 Jun 2025 14:13:13 +0800 (CST)
Received: from DESKTOP-F6Q6J7K.china.huawei.com (10.174.175.220) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Jun 2025 14:13:10 +0800
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
	<mpe@ellerman.id.au>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Suman
 Ghosh <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joe Damato <jdamato@fastly.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v06 3/8] hinic3: Command Queue framework
Date: Fri, 27 Jun 2025 14:12:51 +0800
Message-ID: <bae89c9cd84ee7ad6d0d0f1b7d8a5d19d632fa45.1750937080.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <cover.1750937080.git.zhuyikai1@h-partners.com>
References: <cover.1750937080.git.zhuyikai1@h-partners.com>
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

Add Command Queue framework initialization.
It is used to set the related table items of the driver and obtain the
HW configuration.

Co-developed-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/Makefile   |   3 +-
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.c  | 408 ++++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.h  | 151 +++++++
 .../ethernet/huawei/hinic3/hinic3_common.h    |   7 +
 .../net/ethernet/huawei/hinic3/hinic3_wq.c    | 109 +++++
 .../net/ethernet/huawei/hinic3/hinic3_wq.h    |  11 +
 6 files changed, 688 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/Makefile b/drivers/net/ethernet/huawei/hinic3/Makefile
index 5fb4d1370049..2a0ed8e2c63e 100644
--- a/drivers/net/ethernet/huawei/hinic3/Makefile
+++ b/drivers/net/ethernet/huawei/hinic3/Makefile
@@ -3,7 +3,8 @@
 
 obj-$(CONFIG_HINIC3) += hinic3.o
 
-hinic3-objs := hinic3_common.o \
+hinic3-objs := hinic3_cmdq.o \
+	       hinic3_common.o \
 	       hinic3_eqs.o \
 	       hinic3_hw_cfg.o \
 	       hinic3_hw_comm.o \
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
new file mode 100644
index 000000000000..67bfd73aebb8
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
@@ -0,0 +1,408 @@
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
index 000000000000..80c9a108b5f5
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h
@@ -0,0 +1,151 @@
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
+void hinic3_free_cmd_buf(struct hinic3_hwdev *hwdev,
+			 struct hinic3_cmd_buf *cmd_buf);
+
+void hinic3_cmdq_flush_sync_cmd(struct hinic3_hwdev *hwdev);
+int hinic3_reinit_cmdq_ctxts(struct hinic3_hwdev *hwdev);
+bool hinic3_cmdq_idle(struct hinic3_cmdq *cmdq);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.h b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
index c8e8a491adbf..3e8875abb4e1 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
@@ -18,6 +18,13 @@ struct hinic3_dma_addr_align {
 	dma_addr_t align_paddr;
 };
 
+struct hinic3_sge {
+	u32 hi_addr;
+	u32 lo_addr;
+	u32 len;
+	u32 rsvd;
+};
+
 int hinic3_dma_zalloc_coherent_align(struct device *dev, u32 size, u32 align,
 				     gfp_t flag,
 				     struct hinic3_dma_addr_align *mem_align);
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


