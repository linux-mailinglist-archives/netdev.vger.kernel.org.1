Return-Path: <netdev+bounces-265832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPmOBW1ur2m6YQIAu9opvQ
	(envelope-from <netdev+bounces-265832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:05:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C941E24348A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35D1A300DCF4
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E20264A97;
	Tue, 10 Mar 2026 01:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TqFUdLEr"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469F82DC77A;
	Tue, 10 Mar 2026 01:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104719; cv=none; b=qi11rM5VpJE8FhUuWQL6tFJfJBzlapAyNDWGo1CVHc9LVzohDB/cezG37VU8P1EE67zU68Z/eN+VK3LMG+RrXUs1O8FSUdM4MnRsSgKey6wASMwWmpvhk1RJBPn7PyccnwnR4tvoDKKNiEbupm1JyBTkKWcDFp/hd/MTjsOSkXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104719; c=relaxed/simple;
	bh=Zm/WqhY59r+hZOdwXe4ODkDBbEQ0+FP7HfDWSrF/oS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IuExem6XHURxxTuXmCqZMvupQGT0S8Zlv50kBQUfKlHAwTt/z5IVlSz9kWH5Cs5s6O0achJAnwHsPRQb7wEqp1nddYoaGF553D8/DU7T2Z+4OH4RTbujly+R1UfjMCv9w4tzGOnIdgs6zlvyQJgif3I3v58FUchpyK3SnVfIhSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TqFUdLEr; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2F2L3wXobRr+pRxtHTTad95trf0o8K73mNUVItCeYm0=;
	b=TqFUdLErINSvQ+L/oe8lQUnqde7kggnd6czb3ONween+f37HvZ97RpsgFIZ913lAMspbCHvtB
	NHgToee6VzhJR2BvnmOu6grXYVuIWsTpEHWM5oiIGZMrk7texrfAhzAWrxcG4Ly1cQ0A9Ty4fBJ
	VwWKPAUNc7UgHeGD8jASwTE=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fVFsX6K6pz1T4Hq;
	Tue, 10 Mar 2026 09:00:00 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CD534056B;
	Tue, 10 Mar 2026 09:05:10 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 10 Mar 2026 09:05:09 +0800
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
Subject: [PATCH net-next v03 3/9] hinic3: Add chip_present_flag checks to prevent errors when card is absent
Date: Tue, 10 Mar 2026 09:04:51 +0800
Message-ID: <3954f22df125f5e843aaa62953d7506eb66922ac.1773062356.git.zhuyikai1@h-partners.com>
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
X-Rspamd-Queue-Id: C941E24348A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265832-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[h-partners.com:mid,h-partners.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,huawei.com:dkim,huawei.com:email]
X-Rspamd-Action: no action

  chip_present_flag is added for driver to prevent errors when card does
not exist. It has been added to multiple critical functions, including
command queue, mailbox and network device operations, ensuring that the
existence of the network card is verified before performing operations.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c | 10 +++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_common.c   |  6 +++++-
 .../net/ethernet/huawei/hinic3/hinic3_common.h   |  1 +
 .../net/ethernet/huawei/hinic3/hinic3_hw_comm.c  |  7 +++++++
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c    |  5 +++++
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h    |  1 +
 drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c |  2 ++
 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c | 12 ++++++++++++
 .../ethernet/huawei/hinic3/hinic3_netdev_ops.c   | 16 ++++++++++------
 9 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
index 946e699cbe10..1b0ba244a68f 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
@@ -353,7 +353,8 @@ static int wait_cmdqs_enable(struct hinic3_cmdqs *cmdqs)
 		if (cmdqs->status & HINIC3_CMDQ_ENABLE)
 			return 0;
 		usleep_range(1000, 2000);
-	} while (time_before(jiffies, end) && !cmdqs->disable_flag);
+	} while (time_before(jiffies, end) && !cmdqs->disable_flag &&
+		 cmdqs->hwdev->chip_present_flag);
 
 	cmdqs->disable_flag = 1;
 
@@ -681,6 +682,10 @@ int hinic3_cmdq_direct_resp(struct hinic3_hwdev *hwdev, u8 mod, u8 cmd,
 {
 	struct hinic3_cmdqs *cmdqs;
 	int err;
+
+	if (!hwdev->chip_present_flag)
+		return -ETIMEDOUT;
+
 	err = cmdq_params_valid(hwdev, buf_in);
 	if (err) {
 		dev_err(hwdev->dev, "Invalid CMDQ parameters\n");
@@ -712,6 +717,9 @@ int hinic3_cmdq_detail_resp(struct hinic3_hwdev *hwdev, u8 mod, u8 cmd,
 	struct hinic3_cmdqs *cmdqs;
 	int err;
 
+	if (!hwdev->chip_present_flag)
+		return -ETIMEDOUT;
+
 	err = cmdq_params_valid(hwdev, buf_in);
 	if (err)
 		goto err_out;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.c b/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
index fe4778d152cf..b28576debdc8 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
@@ -59,10 +59,14 @@ int hinic3_wait_for_timeout(void *priv_data, wait_cpl_handler handler,
 	enum hinic3_wait_return ret;
 	int err;
 
-	err = read_poll_timeout(handler, ret, ret == HINIC3_WAIT_PROCESS_CPL,
+	err = read_poll_timeout(handler, ret,
+				!(ret & HINIC3_WAIT_PROCESS_WAITING),
 				wait_once_us, wait_total_ms * USEC_PER_MSEC,
 				false, priv_data);
 
+	if (ret == HINIC3_WAIT_PROCESS_ERR)
+		return -EIO;
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.h b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
index a8fabfae90fb..c892439fa3cd 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
@@ -21,6 +21,7 @@ struct hinic3_dma_addr_align {
 enum hinic3_wait_return {
 	HINIC3_WAIT_PROCESS_CPL     = 0,
 	HINIC3_WAIT_PROCESS_WAITING = 1,
+	HINIC3_WAIT_PROCESS_ERR     = 2,
 };
 
 struct hinic3_sge {
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
index ecfe6265954e..1defd6800790 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
@@ -300,6 +300,10 @@ static enum hinic3_wait_return check_cmdq_stop_handler(void *priv_data)
 	enum hinic3_cmdq_type cmdq_type;
 	struct hinic3_cmdqs *cmdqs;
 
+	/* Stop waiting when card unpresent */
+	if (!hwdev->chip_present_flag)
+		return HINIC3_WAIT_PROCESS_ERR;
+
 	cmdqs = hwdev->cmdqs;
 	for (cmdq_type = 0; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
 		if (!hinic3_cmdq_idle(&cmdqs->cmdq[cmdq_type]))
@@ -347,6 +351,9 @@ int hinic3_func_rx_tx_flush(struct hinic3_hwdev *hwdev)
 	int ret = 0;
 	int err;
 
+	if (!hwdev->chip_present_flag)
+		return 0;
+
 	err = wait_cmdq_stop(hwdev);
 	if (err) {
 		dev_warn(hwdev->dev, "CMDQ is still working, CMDQ timeout value is unreasonable\n");
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
index 0074d0c6dbaf..04c0385b3344 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
@@ -32,6 +32,9 @@
 #define HINIC3_PCIE_PH_DISABLE       0
 #define HINIC3_PCIE_MSIX_ATTR_ENTRY  0
 
+#define HINIC3_CHIP_PRESENT          1
+#define HINIC3_CHIP_ABSENT           0
+
 #define HINIC3_DEFAULT_EQ_MSIX_PENDING_LIMIT      0
 #define HINIC3_DEFAULT_EQ_MSIX_COALESC_TIMER_CFG  0xFF
 #define HINIC3_DEFAULT_EQ_MSIX_RESEND_TIMER_CFG   7
@@ -545,6 +548,7 @@ int hinic3_init_hwdev(struct pci_dev *pdev)
 		dev_err(hwdev->dev, "Failed to init hwif\n");
 		goto err_free_hwdev;
 	}
+	hwdev->chip_present_flag = HINIC3_CHIP_PRESENT;
 
 	hwdev->workq = alloc_workqueue(HINIC3_HWDEV_WQ_NAME, WQ_MEM_RECLAIM | WQ_PERCPU,
 				       HINIC3_WQ_MAX_REQ);
@@ -621,6 +625,7 @@ void hinic3_set_api_stop(struct hinic3_hwdev *hwdev)
 	struct hinic3_recv_msg *recv_resp_msg;
 	struct hinic3_mbox *mbox;
 
+	hwdev->chip_present_flag = HINIC3_CHIP_ABSENT;
 	spin_lock_bh(&hwdev->channel_lock);
 	if (HINIC3_IS_PF(hwdev) &&
 	    test_bit(HINIC3_HWDEV_MGMT_INITED, &hwdev->func_state)) {
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
index 9686c2600b46..4276ac136464 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
@@ -76,6 +76,7 @@ struct hinic3_hwdev {
 	u32                         wq_page_size;
 	u8                          max_cmdq;
 	ulong                       func_state;
+	int                         chip_present_flag;
 };
 
 struct hinic3_event_info {
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
index 771883174b3b..70d70556dca6 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
@@ -97,6 +97,8 @@ static enum hinic3_wait_return check_hwif_ready_handler(void *priv_data)
 	u32 attr1;
 
 	attr1 = hinic3_hwif_read_reg(hwdev->hwif, HINIC3_CSR_FUNC_ATTR1_ADDR);
+	if (attr1 == HINIC3_PCIE_LINK_DOWN)
+		return HINIC3_WAIT_PROCESS_ERR;
 
 	return HINIC3_AF1_GET(attr1, MGMT_INIT_STATUS) ?
 	       HINIC3_WAIT_PROCESS_CPL : HINIC3_WAIT_PROCESS_WAITING;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
index 7d31e215b14f..c82370cf401d 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
@@ -646,6 +646,9 @@ static enum hinic3_wait_return check_mbox_wb_status(void *priv_data)
 	struct hinic3_mbox *mbox = priv_data;
 	u16 wb_status;
 
+	if (!mbox->hwdev->chip_present_flag)
+		return HINIC3_WAIT_PROCESS_ERR;
+
 	wb_status = get_mbox_status(&mbox->send_mbox);
 
 	return MBOX_STATUS_FINISHED(wb_status) ?
@@ -788,6 +791,9 @@ static enum hinic3_wait_return check_mbox_msg_finish(void *priv_data)
 {
 	struct hinic3_mbox *mbox = priv_data;
 
+	if (!mbox->hwdev->chip_present_flag)
+		return HINIC3_WAIT_PROCESS_ERR;
+
 	return (mbox->event_flag == MBOX_EVENT_SUCCESS) ?
 		HINIC3_WAIT_PROCESS_CPL : HINIC3_WAIT_PROCESS_WAITING;
 }
@@ -819,6 +825,9 @@ int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
 	u32 msg_len;
 	int err;
 
+	if (!hwdev->chip_present_flag)
+		return -EPERM;
+
 	/* expect response message */
 	msg_desc = get_mbox_msg_desc(mbox, MBOX_MSG_RESP, MBOX_MGMT_FUNC_ID);
 	mutex_lock(&mbox->mbox_send_lock);
@@ -897,6 +906,9 @@ int hinic3_send_mbox_to_mgmt_no_ack(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
 	struct mbox_msg_info msg_info = {};
 	int err;
 
+	if (!hwdev->chip_present_flag)
+		return -EPERM;
+
 	mutex_lock(&mbox->mbox_send_lock);
 	err = send_mbox_msg(mbox, mod, cmd, msg_params->buf_in,
 			    msg_params->in_size, MBOX_MGMT_FUNC_ID,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index cabb8523f246..da73811641a9 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -415,13 +415,17 @@ static void hinic3_vport_down(struct net_device *netdev)
 	netif_carrier_off(netdev);
 	netif_tx_disable(netdev);
 
-	glb_func_id = hinic3_global_func_id(nic_dev->hwdev);
-	hinic3_set_vport_enable(nic_dev->hwdev, glb_func_id, false);
+	if (nic_dev->hwdev->chip_present_flag) {
+		hinic3_maybe_set_port_state(netdev, false);
 
-	hinic3_flush_txqs(netdev);
-	/* wait to guarantee that no packets will be sent to host */
-	msleep(100);
-	hinic3_flush_qps_res(nic_dev->hwdev);
+		glb_func_id = hinic3_global_func_id(nic_dev->hwdev);
+		hinic3_set_vport_enable(nic_dev->hwdev, glb_func_id, false);
+
+		hinic3_flush_txqs(netdev);
+		/* wait to guarantee that no packets will be sent to host */
+		msleep(100);
+		hinic3_flush_qps_res(nic_dev->hwdev);
+	}
 }
 
 static int hinic3_open(struct net_device *netdev)
-- 
2.43.0


