Return-Path: <netdev+bounces-248342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E749D07150
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 05:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D4D03015AEE
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 04:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E8132F74F;
	Fri,  9 Jan 2026 04:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZmVrAKOP"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FAD32824D;
	Fri,  9 Jan 2026 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767931833; cv=none; b=RRr5t+J9Vz7zSUi/S8b6Bmm2thiEvFMXsuGj1J7yo6edqaji11wRBThL/wWxkkcREYIJ6ECwo2KqkCVkwJ/ImGVSiS6S++BsH3QheHHw+o9ENZizbsVHWrJBjRWr38VFNV6iOElekTvndeaOad+i9i8CLIxgVvmfnrwOMQ++KRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767931833; c=relaxed/simple;
	bh=nDIAQIMWm4smxwX8AbbVJ3wy0kU2V9tKAp9Rf/7tG3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYHT++q6eznhOJg52LZBECwNKsHcuXvxIONwdaSVK0Gr1zd9NlWEsj5q67++O2YBnEJ8RfLHZij8qD8minzi5vhk8IS55/bLP3YVwTo21U2zwJImlKgLbsyB4i/VgoIFDI+JjwaGQzFO9W2KK5YrCDBbUZyFionK+xFId59QHig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZmVrAKOP; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bbFy0m9RPTUd0cF/ffkOwZYCHxiIA2STuQ2c/VxSYLQ=;
	b=ZmVrAKOP3uOd+i+aQwWkr+tlL6wimHaYuHm2G+wFRwOhXJS6zqIb7dNuFpid6SnO2ZtpDh55l
	HYhk1IM+OED9v+nT6cIPSkQr/RPUrZnl5920eYeVT8kxeT1lJwsLVmZ+wALhnEhTWeQoxmq1Kk+
	M1DyoN1qxiJiI5WDcxDvlKU=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dnSrt52sDzcb3h;
	Fri,  9 Jan 2026 12:06:54 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id BCABC404AD;
	Fri,  9 Jan 2026 12:10:29 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 9 Jan 2026 12:10:28 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Markus Elfring <Markus.Elfring@web.de>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>
Subject: [PATCH net-next v10 9/9] hinic3: Add HW event handler
Date: Fri, 9 Jan 2026 10:35:59 +0800
Message-ID: <71a878bfceb88e4d5aca3d232427e54403329785.1767861236.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1767861236.git.zhuyikai1@h-partners.com>
References: <cover.1767861236.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Add HINIC3_INIT_UP flags to trace netdev open status.
Add port module event handler.
Add link status event type(FAULT, PCIE link down, heart lost, mgmt
watchdog).

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |  9 ++++
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |  3 +-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  | 50 +++++++++++++++++++
 .../huawei/hinic3/hinic3_netdev_ops.c         | 12 +++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   | 18 +++++++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  1 +
 6 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
index 58bc561f95b3..9686c2600b46 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
@@ -17,6 +17,15 @@ enum hinic3_event_service_type {
 	HINIC3_EVENT_SRV_NIC  = 1
 };
 
+enum hinic3_comm_event_type {
+	HINIC3_COMM_EVENT_PCIE_LINK_DOWN = 0,
+	HINIC3_COMM_EVENT_HEART_LOST = 1,
+	HINIC3_COMM_EVENT_FAULT = 2,
+	HINIC3_COMM_EVENT_SRIOV_STATE_CHANGE = 3,
+	HINIC3_COMM_EVENT_CARD_REMOVE = 4,
+	HINIC3_COMM_EVENT_MGMT_WATCHDOG = 5,
+};
+
 enum hinic3_fault_err_level {
 	HINIC3_FAULT_LEVEL_SERIOUS_FLR = 3,
 };
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
index 63932a1fa8ee..6950ee4d037b 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -19,7 +19,8 @@ static void hinic3_net_dim(struct hinic3_nic_dev *nic_dev,
 	struct hinic3_rxq *rxq = irq_cfg->rxq;
 	struct dim_sample sample = {};
 
-	if (!nic_dev->adaptive_rx_coal)
+	if (!test_bit(HINIC3_INTF_UP, &nic_dev->flags) ||
+	    !nic_dev->adaptive_rx_coal)
 		return;
 
 	dim_update_sample(irq_cfg->total_events, rxq->rxq_stats.packets,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 2c16ec2b4616..a33f86675954 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -331,6 +331,44 @@ static void hinic3_link_status_change(struct net_device *netdev,
 	}
 }
 
+static void hinic3_port_module_event_handler(struct net_device *netdev,
+					     struct hinic3_event_info *event)
+{
+	const char *g_hinic3_module_link_err[LINK_ERR_NUM] = {
+		"Unrecognized module"
+	};
+	struct hinic3_port_module_event *module_event;
+	enum port_module_event_type type;
+	enum link_err_type err_type;
+
+	module_event = (struct hinic3_port_module_event *)event->event_data;
+	type = module_event->type;
+	err_type = module_event->err_type;
+
+	switch (type) {
+	case HINIC3_PORT_MODULE_CABLE_PLUGGED:
+	case HINIC3_PORT_MODULE_CABLE_UNPLUGGED:
+		netdev_info(netdev, "Port module event: Cable %s\n",
+			    type == HINIC3_PORT_MODULE_CABLE_PLUGGED ?
+			    "plugged" : "unplugged");
+		break;
+	case HINIC3_PORT_MODULE_LINK_ERR:
+		if (err_type >= LINK_ERR_NUM) {
+			netdev_info(netdev, "Link failed, Unknown error type: 0x%x\n",
+				    err_type);
+		} else {
+			netdev_info(netdev,
+				    "Link failed, error type: 0x%x: %s\n",
+				    err_type,
+				    g_hinic3_module_link_err[err_type]);
+		}
+		break;
+	default:
+		netdev_err(netdev, "Unknown port module type %d\n", type);
+		break;
+	}
+}
+
 static void hinic3_nic_event(struct auxiliary_device *adev,
 			     struct hinic3_event_info *event)
 {
@@ -344,8 +382,20 @@ static void hinic3_nic_event(struct auxiliary_device *adev,
 				   HINIC3_NIC_EVENT_LINK_UP):
 		hinic3_link_status_change(netdev, true);
 		break;
+	case HINIC3_SRV_EVENT_TYPE(HINIC3_EVENT_SRV_NIC,
+				   HINIC3_NIC_EVENT_PORT_MODULE_EVENT):
+		hinic3_port_module_event_handler(netdev, event);
+		break;
 	case HINIC3_SRV_EVENT_TYPE(HINIC3_EVENT_SRV_NIC,
 				   HINIC3_NIC_EVENT_LINK_DOWN):
+	case HINIC3_SRV_EVENT_TYPE(HINIC3_EVENT_SRV_COMM,
+				   HINIC3_COMM_EVENT_FAULT):
+	case HINIC3_SRV_EVENT_TYPE(HINIC3_EVENT_SRV_COMM,
+				   HINIC3_COMM_EVENT_PCIE_LINK_DOWN):
+	case HINIC3_SRV_EVENT_TYPE(HINIC3_EVENT_SRV_COMM,
+				   HINIC3_COMM_EVENT_HEART_LOST):
+	case HINIC3_SRV_EVENT_TYPE(HINIC3_EVENT_SRV_COMM,
+				   HINIC3_COMM_EVENT_MGMT_WATCHDOG):
 		hinic3_link_status_change(netdev, false);
 		break;
 	default:
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index 58629a24d458..75adfe897e81 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -432,6 +432,11 @@ static int hinic3_open(struct net_device *netdev)
 	struct hinic3_dyna_qp_params qp_params;
 	int err;
 
+	if (test_bit(HINIC3_INTF_UP, &nic_dev->flags)) {
+		netdev_dbg(netdev, "Netdev already open, do nothing\n");
+		return 0;
+	}
+
 	err = hinic3_init_nicio_res(nic_dev);
 	if (err) {
 		netdev_err(netdev, "Failed to init nicio resources\n");
@@ -459,6 +464,8 @@ static int hinic3_open(struct net_device *netdev)
 	if (err)
 		goto err_close_channel;
 
+	set_bit(HINIC3_INTF_UP, &nic_dev->flags);
+
 	return 0;
 
 err_close_channel:
@@ -479,6 +486,11 @@ static int hinic3_close(struct net_device *netdev)
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
 	struct hinic3_dyna_qp_params qp_params;
 
+	if (!test_and_clear_bit(HINIC3_INTF_UP, &nic_dev->flags)) {
+		netdev_dbg(netdev, "Netdev already close, do nothing\n");
+		return 0;
+	}
+
 	hinic3_vport_down(netdev);
 	hinic3_close_channel(netdev);
 	hinic3_uninit_qps(nic_dev, &qp_params);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
index f83913e74cb5..c32eaa886e17 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
@@ -22,6 +22,7 @@ struct hinic3_nic_dev;
 enum hinic3_nic_event_type {
 	HINIC3_NIC_EVENT_LINK_DOWN = 0,
 	HINIC3_NIC_EVENT_LINK_UP   = 1,
+	HINIC3_NIC_EVENT_PORT_MODULE_EVENT = 2,
 };
 
 struct hinic3_sq_attr {
@@ -51,6 +52,23 @@ struct mag_cmd_set_port_enable {
 	u8                   rsvd1[3];
 };
 
+enum link_err_type {
+	LINK_ERR_MODULE_UNRECOGENIZED,
+	LINK_ERR_NUM,
+};
+
+enum port_module_event_type {
+	HINIC3_PORT_MODULE_CABLE_PLUGGED,
+	HINIC3_PORT_MODULE_CABLE_UNPLUGGED,
+	HINIC3_PORT_MODULE_LINK_ERR,
+	HINIC3_PORT_MODULE_MAX_EVENT,
+};
+
+struct hinic3_port_module_event {
+	enum port_module_event_type type;
+	enum link_err_type          err_type;
+};
+
 int hinic3_get_nic_feature_from_hw(struct hinic3_nic_dev *nic_dev);
 int hinic3_set_nic_feature_to_hw(struct hinic3_nic_dev *nic_dev);
 bool hinic3_test_support(struct hinic3_nic_dev *nic_dev,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index 9bd46541b3e3..29189241f446 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -16,6 +16,7 @@
 	(VLAN_N_VID / HINIC3_VLAN_BITMAP_BYTE_SIZE(nic_dev))
 
 enum hinic3_flags {
+	HINIC3_INTF_UP,
 	HINIC3_MAC_FILTER_CHANGED,
 	HINIC3_RSS_ENABLE,
 	HINIC3_UPDATE_MAC_FILTER,
-- 
2.43.0


