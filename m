Return-Path: <netdev+bounces-216856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9C2B3582F
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9187C1B63
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 09:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1D73112A0;
	Tue, 26 Aug 2025 09:06:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D70530F7FA;
	Tue, 26 Aug 2025 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199203; cv=none; b=lAsgNtoTCm+e8X7JMBFL6XxGgbStLlVxMwmcfgEyfuAReZXFM5IQmoULq9DxqaV23oMZ7cYhY30meBfs0BFqsKdQUhCOTR1AiQnubczJErNtPeaSPu84tJeA6WLIpWO0FGWfjzUKISZmq+wnJvzsrXQW11BIxy3K6OGtgVQHaao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199203; c=relaxed/simple;
	bh=oM2mZZcCxbisaDf3IMGe0AwAZIPuz7BIU+k0v9GJlaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hw2BkJ10oCBdRd/zzKrHL9w9QtwJ5cokuyIPK1ipl3wLm4KJF13U6tK5hbUJz+E5HPhF2uZepLZlbVy2MAMw683qm6VGeoyPV+1iNEUgo54V4iDMfWjlWGL4srm+hHb/+L6XSaMkzskg97evgTyKjwDmudgPQynfgL7/M0UndtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cB1wM20zBztTL0;
	Tue, 26 Aug 2025 17:05:39 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 153541800B2;
	Tue, 26 Aug 2025 17:06:37 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 Aug 2025 17:06:35 +0800
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
Subject: [PATCH net-next v01 11/12] hinic3: Add port management
Date: Tue, 26 Aug 2025 17:05:53 +0800
Message-ID: <d52bd0c13fde98a4df0518930882a451db9851a1.1756195078.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1756195078.git.zhuyikai1@h-partners.com>
References: <cover.1756195078.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Add port management of enable/disable/query/flush function.

Co-developed-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../huawei/hinic3/hinic3_mgmt_interface.h     | 29 ++++++++
 .../huawei/hinic3/hinic3_netdev_ops.c         | 57 ++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 68 +++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  4 ++
 4 files changed, 158 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
index 7012130bba1d..6cc0345c39e4 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
@@ -69,12 +69,27 @@ struct l2nic_cmd_set_ci_attr {
 	u64                  ci_addr;
 };
 
+struct l2nic_cmd_clear_qp_resource {
+	struct mgmt_msg_head msg_head;
+	u16                  func_id;
+	u16                  rsvd1;
+};
+
 struct l2nic_cmd_force_pkt_drop {
 	struct mgmt_msg_head msg_head;
 	u8                   port;
 	u8                   rsvd1[3];
 };
 
+struct l2nic_cmd_set_vport_state {
+	struct mgmt_msg_head msg_head;
+	u16                  func_id;
+	u16                  rsvd1;
+	/* 0--disable, 1--enable */
+	u8                   state;
+	u8                   rsvd2[3];
+};
+
 struct l2nic_cmd_set_dcb_state {
 	struct mgmt_msg_head head;
 	u16                  func_id;
@@ -172,6 +187,20 @@ enum l2nic_ucode_cmd {
 	L2NIC_UCODE_CMD_SET_RSS_INDIR_TBL = 4,
 };
 
+/* hilink mac group command */
+enum mag_cmd {
+	MAG_CMD_GET_LINK_STATUS = 7,
+};
+
+/* firmware also use this cmd report link event to driver */
+struct mag_cmd_get_link_status {
+	struct mgmt_msg_head head;
+	u8                   port_id;
+	/* 0:link down  1:link up */
+	u8                   status;
+	u8                   rsvd0[2];
+};
+
 enum hinic3_nic_feature_cap {
 	HINIC3_NIC_F_CSUM           = BIT(0),
 	HINIC3_NIC_F_SCTP_CRC       = BIT(1),
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index 2ba9f0936589..8e0d89c636b7 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -334,6 +334,55 @@ static void hinic3_close_channel(struct net_device *netdev)
 	hinic3_free_qp_ctxts(nic_dev);
 }
 
+static int hinic3_vport_up(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	bool link_status_up;
+	u16 glb_func_id;
+	int err;
+
+	glb_func_id = hinic3_global_func_id(nic_dev->hwdev);
+	err = hinic3_set_vport_enable(nic_dev->hwdev, glb_func_id, true);
+	if (err) {
+		netdev_err(netdev, "Failed to enable vport\n");
+		goto err_flush_qps_res;
+	}
+
+	netif_set_real_num_tx_queues(netdev, nic_dev->q_params.num_qps);
+	netif_set_real_num_rx_queues(netdev, nic_dev->q_params.num_qps);
+	netif_tx_start_all_queues(netdev);
+
+	err = hinic3_get_link_status(nic_dev->hwdev, &link_status_up);
+	if (!err && link_status_up)
+		netif_carrier_on(netdev);
+
+	return 0;
+
+err_flush_qps_res:
+	hinic3_flush_qps_res(nic_dev->hwdev);
+	/* wait to guarantee that no packets will be sent to host */
+	msleep(100);
+
+	return err;
+}
+
+static void hinic3_vport_down(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 glb_func_id;
+
+	netif_carrier_off(netdev);
+	netif_tx_disable(netdev);
+
+	glb_func_id = hinic3_global_func_id(nic_dev->hwdev);
+	hinic3_set_vport_enable(nic_dev->hwdev, glb_func_id, false);
+
+	hinic3_flush_txqs(netdev);
+	/* wait to guarantee that no packets will be sent to host */
+	msleep(100);
+	hinic3_flush_qps_res(nic_dev->hwdev);
+}
+
 static int hinic3_open(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
@@ -363,8 +412,15 @@ static int hinic3_open(struct net_device *netdev)
 	if (err)
 		goto err_uninit_qps;
 
+	err = hinic3_vport_up(netdev);
+	if (err)
+		goto err_close_channel;
+
 	return 0;
 
+err_close_channel:
+	hinic3_close_channel(netdev);
+
 err_uninit_qps:
 	hinic3_uninit_qps(nic_dev, &qp_params);
 	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
@@ -383,6 +439,7 @@ static int hinic3_close(struct net_device *netdev)
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
 	struct hinic3_dyna_qp_params qp_params;
 
+	hinic3_vport_down(netdev);
 	hinic3_close_channel(netdev);
 	hinic3_uninit_qps(nic_dev, &qp_params);
 	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index 8f9c806681ef..7f5d0effcc12 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -268,6 +268,28 @@ int hinic3_set_ci_table(struct hinic3_hwdev *hwdev, struct hinic3_sq_attr *attr)
 	return 0;
 }
 
+int hinic3_flush_qps_res(struct hinic3_hwdev *hwdev)
+{
+	struct l2nic_cmd_clear_qp_resource sq_res = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	sq_res.func_id = hinic3_global_func_id(hwdev);
+
+	mgmt_msg_params_init_default(&msg_params, &sq_res, sizeof(sq_res));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
+				       L2NIC_CMD_CLEAR_QP_RESOURCE,
+				       &msg_params);
+	if (err || sq_res.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to clear sq resources, err: %d, status: 0x%x\n",
+			err, sq_res.msg_head.status);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev)
 {
 	struct l2nic_cmd_force_pkt_drop pkt_drop = {};
@@ -315,3 +337,49 @@ int hinic3_sync_dcb_state(struct hinic3_hwdev *hwdev, u8 op_code, u8 state)
 
 	return 0;
 }
+
+int hinic3_get_link_status(struct hinic3_hwdev *hwdev, bool *link_status_up)
+{
+	struct mag_cmd_get_link_status get_link = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	get_link.port_id = hinic3_physical_port_id(hwdev);
+
+	mgmt_msg_params_init_default(&msg_params, &get_link, sizeof(get_link));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_HILINK,
+				       MAG_CMD_GET_LINK_STATUS, &msg_params);
+	if (err || get_link.head.status) {
+		dev_err(hwdev->dev, "Failed to get link state, err: %d, status: 0x%x\n",
+			err, get_link.head.status);
+		return -EIO;
+	}
+
+	*link_status_up = !!get_link.status;
+
+	return 0;
+}
+
+int hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, u16 func_id,
+			    bool enable)
+{
+	struct l2nic_cmd_set_vport_state en_state = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	en_state.func_id = func_id;
+	en_state.state = enable ? 1 : 0;
+
+	mgmt_msg_params_init_default(&msg_params, &en_state, sizeof(en_state));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
+				       L2NIC_CMD_SET_VPORT_ENABLE, &msg_params);
+	if (err || en_state.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to set vport state, err: %d, status: 0x%x\n",
+			err, en_state.msg_head.status);
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
index 719b81e2bc2a..b83b567fa542 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
@@ -50,8 +50,12 @@ int hinic3_update_mac(struct hinic3_hwdev *hwdev, const u8 *old_mac,
 
 int hinic3_set_ci_table(struct hinic3_hwdev *hwdev,
 			struct hinic3_sq_attr *attr);
+int hinic3_flush_qps_res(struct hinic3_hwdev *hwdev);
 int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev);
 
 int hinic3_sync_dcb_state(struct hinic3_hwdev *hwdev, u8 op_code, u8 state);
+int hinic3_get_link_status(struct hinic3_hwdev *hwdev, bool *link_status_up);
+int hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, u16 func_id,
+			    bool enable);
 
 #endif
-- 
2.43.0


