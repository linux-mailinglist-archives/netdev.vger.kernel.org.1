Return-Path: <netdev+bounces-265834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEz6LLZur2m6YQIAu9opvQ
	(envelope-from <netdev+bounces-265834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:07:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 324972434DA
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83DA0303A0AC
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A222727FD;
	Tue, 10 Mar 2026 01:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NXrF0Z+F"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B332DF12A;
	Tue, 10 Mar 2026 01:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104722; cv=none; b=YK5+Dj+JgK5TQ44yx1V4qhZTUlYCzqtb5YJth97ppEYQhOzEQR58exEOXrK5slLBhZ73YY4ZivrlhpB89j9e1sTbA0oPORYelfSpBOFE0VjmSkUNYuV/AUQOnfzHjX10zad5LXxzRn3bm4rv8I/fVYlEp2a6qAmFyR6AbdZybbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104722; c=relaxed/simple;
	bh=zTJ2V40QLSM2WgDcLXlsGB9K8d1M3h/JNgGsxWOa4P4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbm07FSH6k4avLLAxXVzhAE84ua5foQJijbfrRYAfOIeZjemKtsEJuY4LmrgkT6PZ0YJTK8Yx/MaVCPhHCXRvthULPgmYpR3WiMz2LPuSInjkvcwy0cJ+FRCo82jbaOJTWrVgEPcl5xdHuOb8BHjj9VSCb9qZrBmeQh2WMJHvQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NXrF0Z+F; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QJEePGXBfMwZ/14xCr7/9JPvKQWlrIW1p7PRlc8Z39Y=;
	b=NXrF0Z+Fhv/XcGzlexCawFW2OoPaNJbJsJF9hjobKwPSXM1qPXoDBiJtZy18+wqy5p5tFGP8U
	BFi/tc3gNSDoEViA1ejM4FVRI8M9WHCcQoqi/BSsA/cfBDiCyBk/R213W+vlRIyjEgVEOCH9nEO
	UtOUbqlMMF96oDOxbPln9NA=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fVFry1D8dz12LCw;
	Tue, 10 Mar 2026 08:59:30 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 61BD14056E;
	Tue, 10 Mar 2026 09:05:06 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 10 Mar 2026 09:05:05 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>
Subject: [PATCH net-next v03 1/9] hinic3: Add command queue detailed-response interfaces
Date: Tue, 10 Mar 2026 09:04:49 +0800
Message-ID: <cc3cff8458aeb27b07749dc9dcee43c11c45a4c1.1773062356.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1773062356.git.zhuyikai1@h-partners.com>
References: <cover.1773062356.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Rspamd-Queue-Id: 324972434DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265834-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[h-partners.com:mid,h-partners.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:dkim,huawei.com:email]
X-Rspamd-Action: no action

   Add new detailed response interfaces for the hinic3 command
queue (CMDQ), enhancing its functionality to handle commands
requiring input and output buffer pairs.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.c  | 166 ++++++++++++++++--
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.h  |  15 ++
 2 files changed, 169 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
index bc5b80c31693..4e63280beea5 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
@@ -61,6 +61,10 @@
 #define CMDQ_DB_HEAD_SET(val, member)  \
 	FIELD_PREP(CMDQ_DB_HEAD_##member##_MASK, val)
 
+#define SAVED_DATA_ARM_MASK          BIT(31)
+#define SAVED_DATA_SET(val, member)  \
+	FIELD_PREP(SAVED_DATA_##member##_MASK, val)
+
 #define CMDQ_CEQE_TYPE_MASK            GENMASK(2, 0)
 #define CMDQ_CEQE_GET(val, member)  \
 	FIELD_GET(CMDQ_CEQE_##member##_MASK, le32_to_cpu(val))
@@ -84,6 +88,10 @@ enum cmdq_data_format {
 	CMDQ_DATA_DIRECT = 1,
 };
 
+enum cmdq_scmd_type {
+	CMDQ_SET_ARM_CMD = 2,
+};
+
 enum cmdq_ctrl_sect_len {
 	CMDQ_CTRL_SECT_LEN        = 1,
 	CMDQ_CTRL_DIRECT_SECT_LEN = 2,
@@ -166,6 +174,11 @@ static void cmdq_clear_cmd_buf(struct hinic3_cmdq_cmd_info *cmd_info,
 		hinic3_free_cmd_buf(hwdev, cmd_info->buf_in);
 		cmd_info->buf_in = NULL;
 	}
+
+	if (cmd_info->buf_out) {
+		hinic3_free_cmd_buf(hwdev, cmd_info->buf_out);
+		cmd_info->buf_out = NULL;
+	}
 }
 
 static void clear_wqe_complete_bit(struct hinic3_cmdq *cmdq,
@@ -189,6 +202,20 @@ static void clear_wqe_complete_bit(struct hinic3_cmdq *cmdq,
 	hinic3_wq_put_wqebbs(&cmdq->wq, CMDQ_WQE_NUM_WQEBBS);
 }
 
+static int cmdq_arm_ceq_handler(struct hinic3_cmdq *cmdq,
+				struct cmdq_wqe *wqe, u16 ci)
+{
+	struct cmdq_ctrl *ctrl = &wqe->wqe_scmd.ctrl;
+	__le32 ctrl_info = ctrl->ctrl_info;
+
+	if (!CMDQ_WQE_COMPLETED(ctrl_info))
+		return -EBUSY;
+
+	clear_wqe_complete_bit(cmdq, wqe, ci);
+
+	return 0;
+}
+
 static void cmdq_update_cmd_status(struct hinic3_cmdq *cmdq, u16 prod_idx,
 				   struct cmdq_wqe *wqe)
 {
@@ -257,6 +284,11 @@ void hinic3_cmdq_ceq_handler(struct hinic3_hwdev *hwdev, __le32 ceqe_data)
 			cmdq_clear_cmd_buf(cmd_info, hwdev);
 			clear_wqe_complete_bit(cmdq, wqe, ci);
 			break;
+		case HINIC3_CMD_TYPE_SET_ARM:
+			/* arm_bit was set until here */
+			if (cmdq_arm_ceq_handler(cmdq, wqe, ci))
+				return;
+			break;
 		default:
 			/* only arm bit is using scmd wqe,
 			 * the other wqe is lcmd
@@ -283,6 +315,18 @@ void hinic3_cmdq_ceq_handler(struct hinic3_hwdev *hwdev, __le32 ceqe_data)
 	}
 }
 
+static int cmdq_params_valid(const struct hinic3_hwdev *hwdev,
+			     const struct hinic3_cmd_buf *buf_in)
+{
+	if (le16_to_cpu(buf_in->size) > CMDQ_BUF_SIZE) {
+		dev_err(hwdev->dev, "Invalid CMDQ buffer size: 0x%x\n",
+			le16_to_cpu(buf_in->size));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int wait_cmdqs_enable(struct hinic3_cmdqs *cmdqs)
 {
 	unsigned long end;
@@ -356,6 +400,7 @@ static void cmdq_prepare_wqe_ctrl(struct cmdq_wqe *wqe, u8 wrapped,
 				  enum cmdq_bufdesc_len buf_len)
 {
 	struct cmdq_header *hdr = CMDQ_WQE_HEADER(wqe);
+	__le32 saved_data = hdr->saved_data;
 	enum cmdq_ctrl_sect_len ctrl_len;
 	struct cmdq_wqe_lcmd *wqe_lcmd;
 	struct cmdq_wqe_scmd *wqe_scmd;
@@ -386,6 +431,11 @@ static void cmdq_prepare_wqe_ctrl(struct cmdq_wqe *wqe, u8 wrapped,
 			    CMDQ_WQE_HDR_SET(3, COMPLETE_SECT_LEN) |
 			    CMDQ_WQE_HDR_SET(ctrl_len, CTRL_LEN) |
 			    CMDQ_WQE_HDR_SET(wrapped, HW_BUSY_BIT));
+
+	saved_data &= ~cpu_to_le32(SAVED_DATA_ARM_MASK);
+	if (cmd == CMDQ_SET_ARM_CMD && mod == MGMT_MOD_COMM)
+		saved_data |= cpu_to_le32(SAVED_DATA_SET(1, ARM));
+	hdr->saved_data = saved_data;
 }
 
 static void cmdq_set_lcmd_wqe(struct cmdq_wqe *wqe,
@@ -488,9 +538,10 @@ static int wait_cmdq_sync_cmd_completion(struct hinic3_cmdq *cmdq,
 	return err;
 }
 
-static int cmdq_sync_cmd_direct_resp(struct hinic3_cmdq *cmdq, u8 mod, u8 cmd,
-				     struct hinic3_cmd_buf *buf_in,
-				     __le64 *out_param)
+static int cmdq_sync_cmd_exec(struct hinic3_cmdq *cmdq, u8 mod, u8 cmd,
+			      struct hinic3_cmd_buf *buf_in,
+			      struct hinic3_cmd_buf *buf_out,
+			      __le64 *out_param, u8 cmd_type, u8 wqe_cmd)
 {
 	struct hinic3_cmdq_cmd_info *cmd_info, saved_cmd_info;
 	int cmpt_code = CMDQ_SEND_CMPT_CODE;
@@ -520,31 +571,35 @@ static int cmdq_sync_cmd_direct_resp(struct hinic3_cmdq *cmdq, u8 mod, u8 cmd,
 	cmd_info = &cmdq->cmd_infos[curr_prod_idx];
 	init_completion(&done);
 	refcount_inc(&buf_in->ref_cnt);
-	cmd_info->cmd_type = HINIC3_CMD_TYPE_DIRECT_RESP;
+	if (buf_out)
+		refcount_inc(&buf_out->ref_cnt);
+
+	cmd_info->cmd_type = cmd_type;
 	cmd_info->done = &done;
 	cmd_info->errcode = &errcode;
 	cmd_info->direct_resp = out_param;
 	cmd_info->cmpt_code = &cmpt_code;
 	cmd_info->buf_in = buf_in;
+	if (buf_out)
+		cmd_info->buf_out = buf_out;
+
 	saved_cmd_info = *cmd_info;
-	cmdq_set_lcmd_wqe(&wqe, CMDQ_CMD_DIRECT_RESP, buf_in, NULL,
+	cmdq_set_lcmd_wqe(&wqe, wqe_cmd, buf_in, buf_out,
 			  wrapped, mod, cmd, curr_prod_idx);
 
 	cmdq_wqe_fill(curr_wqe, &wqe);
 	(cmd_info->cmdq_msg_id)++;
 	curr_msg_id = cmd_info->cmdq_msg_id;
-	cmdq_set_db(cmdq, HINIC3_CMDQ_SYNC, next_prod_idx);
+	cmdq_set_db(cmdq, cmdq->cmdq_type, next_prod_idx);
 	spin_unlock_bh(&cmdq->cmdq_lock);
 
 	err = wait_cmdq_sync_cmd_completion(cmdq, cmd_info, &saved_cmd_info,
 					    curr_msg_id, curr_prod_idx,
 					    curr_wqe, CMDQ_CMD_TIMEOUT);
-	if (err) {
+	if (err)
 		dev_err(cmdq->hwdev->dev,
 			"Cmdq sync command timeout, mod: %u, cmd: %u, prod idx: 0x%x\n",
 			mod, cmd, curr_prod_idx);
-		err = -ETIMEDOUT;
-	}
 
 	if (cmpt_code == CMDQ_FORCE_STOP_CMPT_CODE) {
 		dev_dbg(cmdq->hwdev->dev,
@@ -557,22 +612,107 @@ static int cmdq_sync_cmd_direct_resp(struct hinic3_cmdq *cmdq, u8 mod, u8 cmd,
 	return err ? err : errcode;
 }
 
+static int cmdq_sync_cmd_direct_resp(struct hinic3_cmdq *cmdq, u8 mod, u8 cmd,
+				     struct hinic3_cmd_buf *buf_in,
+				     __le64 *out_param)
+{
+	return cmdq_sync_cmd_exec(cmdq, mod, cmd, buf_in, NULL, out_param,
+				    HINIC3_CMD_TYPE_DIRECT_RESP,
+				    CMDQ_CMD_DIRECT_RESP);
+}
+
+static int cmdq_sync_cmd_detail_resp(struct hinic3_cmdq *cmdq, u8 mod, u8 cmd,
+				     struct hinic3_cmd_buf *buf_in,
+				     struct hinic3_cmd_buf *buf_out,
+				     __le64 *out_param)
+{
+	return cmdq_sync_cmd_exec(cmdq, mod, cmd, buf_in, buf_out, out_param,
+				    HINIC3_CMD_TYPE_SGE_RESP,
+				    CMDQ_CMD_SGE_RESP);
+}
+
+int hinic3_cmd_buf_pair_init(struct hinic3_hwdev *hwdev,
+			     struct hinic3_cmd_buf_pair *pair)
+{
+	pair->in = hinic3_alloc_cmd_buf(hwdev);
+	if (!pair->in)
+		goto err_out;
+
+	pair->out = hinic3_alloc_cmd_buf(hwdev);
+	if (!pair->out)
+		goto err_free_cmd_buf_in;
+
+	return 0;
+
+err_free_cmd_buf_in:
+	hinic3_free_cmd_buf(hwdev, pair->in);
+err_out:
+	return -ENOMEM;
+}
+
+void hinic3_cmd_buf_pair_uninit(struct hinic3_hwdev *hwdev,
+				struct hinic3_cmd_buf_pair *pair)
+{
+	hinic3_free_cmd_buf(hwdev, pair->in);
+	hinic3_free_cmd_buf(hwdev, pair->out);
+}
+
 int hinic3_cmdq_direct_resp(struct hinic3_hwdev *hwdev, u8 mod, u8 cmd,
 			    struct hinic3_cmd_buf *buf_in, __le64 *out_param)
 {
 	struct hinic3_cmdqs *cmdqs;
 	int err;
+	err = cmdq_params_valid(hwdev, buf_in);
+	if (err) {
+		dev_err(hwdev->dev, "Invalid CMDQ parameters\n");
+		goto err_out;
+	}
 
 	cmdqs = hwdev->cmdqs;
 	err = wait_cmdqs_enable(cmdqs);
 	if (err) {
 		dev_err(hwdev->dev, "Cmdq is disabled\n");
-		return err;
+		goto err_out;
 	}
 
 	err = cmdq_sync_cmd_direct_resp(&cmdqs->cmdq[HINIC3_CMDQ_SYNC],
 					mod, cmd, buf_in, out_param);
+	if (err)
+		goto err_out;
 
+	return 0;
+
+err_out:
+	return err;
+}
+
+int hinic3_cmdq_detail_resp(struct hinic3_hwdev *hwdev, u8 mod, u8 cmd,
+			    struct hinic3_cmd_buf *buf_in,
+			    struct hinic3_cmd_buf *buf_out, __le64 *out_param)
+{
+	struct hinic3_cmdqs *cmdqs;
+	int err;
+
+	err = cmdq_params_valid(hwdev, buf_in);
+	if (err)
+		goto err_out;
+
+	cmdqs = hwdev->cmdqs;
+
+	err = wait_cmdqs_enable(cmdqs);
+	if (err) {
+		dev_err(hwdev->dev, "Cmdq is disabled\n");
+		goto err_out;
+	}
+
+	err = cmdq_sync_cmd_detail_resp(&cmdqs->cmdq[HINIC3_CMDQ_SYNC],
+					mod, cmd, buf_in, buf_out, out_param);
+	if (err)
+		goto err_out;
+
+	return 0;
+
+err_out:
 	return err;
 }
 
@@ -758,7 +898,8 @@ static int init_cmdqs(struct hinic3_hwdev *hwdev)
 
 static void cmdq_flush_sync_cmd(struct hinic3_cmdq_cmd_info *cmd_info)
 {
-	if (cmd_info->cmd_type != HINIC3_CMD_TYPE_DIRECT_RESP)
+	if (cmd_info->cmd_type != HINIC3_CMD_TYPE_DIRECT_RESP &&
+	    cmd_info->cmd_type != HINIC3_CMD_TYPE_SGE_RESP)
 		return;
 
 	cmd_info->cmd_type = HINIC3_CMD_TYPE_FORCE_STOP;
@@ -785,7 +926,8 @@ static void hinic3_cmdq_flush_cmd(struct hinic3_cmdq *cmdq)
 	while (cmdq_read_wqe(&cmdq->wq, &ci)) {
 		hinic3_wq_put_wqebbs(&cmdq->wq, CMDQ_WQE_NUM_WQEBBS);
 		cmd_info = &cmdq->cmd_infos[ci];
-		if (cmd_info->cmd_type == HINIC3_CMD_TYPE_DIRECT_RESP)
+		if (cmd_info->cmd_type == HINIC3_CMD_TYPE_DIRECT_RESP ||
+		    cmd_info->cmd_type == HINIC3_CMD_TYPE_SGE_RESP)
 			cmdq_flush_sync_cmd(cmd_info);
 	}
 	spin_unlock_bh(&cmdq->cmdq_lock);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h
index f99c386a2780..29bad2fae7ba 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h
@@ -85,7 +85,9 @@ enum hinic3_cmdq_status {
 
 enum hinic3_cmdq_cmd_type {
 	HINIC3_CMD_TYPE_NONE,
+	HINIC3_CMD_TYPE_SET_ARM,
 	HINIC3_CMD_TYPE_DIRECT_RESP,
+	HINIC3_CMD_TYPE_SGE_RESP,
 	HINIC3_CMD_TYPE_FAKE_TIMEOUT,
 	HINIC3_CMD_TYPE_TIMEOUT,
 	HINIC3_CMD_TYPE_FORCE_STOP,
@@ -98,6 +100,11 @@ struct hinic3_cmd_buf {
 	refcount_t ref_cnt;
 };
 
+struct hinic3_cmd_buf_pair {
+	struct hinic3_cmd_buf *in;
+	struct hinic3_cmd_buf *out;
+};
+
 struct hinic3_cmdq_cmd_info {
 	enum hinic3_cmdq_cmd_type cmd_type;
 	struct completion         *done;
@@ -107,6 +114,7 @@ struct hinic3_cmdq_cmd_info {
 	__le64                    *direct_resp;
 	u64                       cmdq_msg_id;
 	struct hinic3_cmd_buf     *buf_in;
+	struct hinic3_cmd_buf     *buf_out;
 };
 
 struct hinic3_cmdq {
@@ -146,8 +154,15 @@ void hinic3_free_cmd_buf(struct hinic3_hwdev *hwdev,
 			 struct hinic3_cmd_buf *cmd_buf);
 void hinic3_cmdq_ceq_handler(struct hinic3_hwdev *hwdev, __le32 ceqe_data);
 
+int hinic3_cmd_buf_pair_init(struct hinic3_hwdev *hwdev,
+			     struct hinic3_cmd_buf_pair *pair);
+void hinic3_cmd_buf_pair_uninit(struct hinic3_hwdev *hwdev,
+				struct hinic3_cmd_buf_pair *pair);
 int hinic3_cmdq_direct_resp(struct hinic3_hwdev *hwdev, u8 mod, u8 cmd,
 			    struct hinic3_cmd_buf *buf_in, __le64 *out_param);
+int hinic3_cmdq_detail_resp(struct hinic3_hwdev *hwdev, u8 mod, u8 cmd,
+			    struct hinic3_cmd_buf *buf_in,
+			    struct hinic3_cmd_buf *buf_out, __le64 *out_param);
 
 void hinic3_cmdq_flush_sync_cmd(struct hinic3_hwdev *hwdev);
 int hinic3_reinit_cmdq_ctxts(struct hinic3_hwdev *hwdev);
-- 
2.43.0


