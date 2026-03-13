Return-Path: <netdev+bounces-267319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMP0AZfEs2mEagAAu9opvQ
	(envelope-from <netdev+bounces-267319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:02:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BEA27F2E0
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98423313DF92
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 07:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB36372681;
	Fri, 13 Mar 2026 07:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="W205RCm+"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED27370D65;
	Fri, 13 Mar 2026 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773388477; cv=none; b=nNaVdvGc2HKpbL8tViKMLZ8H8c6hq2EQwqmwnjfcyNtVRzgRNYpkzQsZAihnHOIdeeVKn0Qgpw+4dGHiwlDc3BNhfJTewjqWh097N+PBVY42gc1hMuM8ZKh+f4WZqRsgtslppaSgocSWSpu0lbykIKsZH+HKakEWLr1SpHeoQ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773388477; c=relaxed/simple;
	bh=8+X3q6F/jZfAMyv34AL8tb2po7jTGk7rM5d4dOYXops=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RoAaFPe/NeSzvDIH9IYQkDvm86JY3+rwj3iD4c2TqUPY6Hy442dveUoLelj3n056ep9BLI0Kcr6n1sLjMzpfCPI29n7UhDQi+tNTqgljgb53OtuPCC7Fg/LGaVs1wbL3y9OpLeyt8JzKUzyfksQ4drK7xQPE2wqfm7n2Xrtno/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=W205RCm+; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=w9lHUGUlUhYZBEjPQSrarg2h5anxVpuvT+8wDZDaAwA=;
	b=W205RCm+JsJ8Zoga/4B26I+H3/bAs62jTeu/wVeFKAT9xkEu0FwQz4EcFL2uxss4q9j+KSdeb
	8bJMXJIOb5pYmQSkfi7QhYwKOlOQkovmuAA6Qa8SEGpZEvJ4BLc6PGsx5afhiuxy8zoYmkkyu28
	rfkHNDop4Z1oBP+TGa3T6AE=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fXGpf487pzRhTH;
	Fri, 13 Mar 2026 15:49:30 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BBC940561;
	Fri, 13 Mar 2026 15:54:26 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 13 Mar 2026 15:54:25 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v01 1/7] hinic3: Add ethtool queue ops
Date: Fri, 13 Mar 2026 15:54:08 +0800
Message-ID: <1f59df0a636d17fd3e43ff2f478145c2f0a54450.1773387649.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1773387649.git.zhuyikai1@h-partners.com>
References: <cover.1773387649.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267319-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[h-partners.com:email,h-partners.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:email]
X-Rspamd-Queue-Id: 76BEA27F2E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

  Implement following ethtool callback function:
.get_ringparam
.set_ringparam

  These callbacks allow users to utilize ethtool for detailed
queue depth configuration and monitoring.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 94 +++++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |  3 +-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |  3 +
 .../huawei/hinic3/hinic3_netdev_ops.c         | 61 ++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   | 12 +++
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    |  4 +
 6 files changed, 176 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
index 90fc16288de9..d78aff802a20 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
@@ -409,6 +409,98 @@ hinic3_get_link_ksettings(struct net_device *netdev,
 	return 0;
 }
 
+static void hinic3_get_ringparam(struct net_device *netdev,
+				 struct ethtool_ringparam *ring,
+				 struct kernel_ethtool_ringparam *kernel_ring,
+				 struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	ring->rx_max_pending = HINIC3_MAX_RX_QUEUE_DEPTH;
+	ring->tx_max_pending = HINIC3_MAX_TX_QUEUE_DEPTH;
+	ring->rx_pending = nic_dev->rxqs[0].q_depth;
+	ring->tx_pending = nic_dev->txqs[0].q_depth;
+}
+
+static void hinic3_update_qp_depth(struct net_device *netdev,
+				   u32 sq_depth, u32 rq_depth)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 i;
+
+	nic_dev->q_params.sq_depth = sq_depth;
+	nic_dev->q_params.rq_depth = rq_depth;
+	for (i = 0; i < nic_dev->max_qps; i++) {
+		nic_dev->txqs[i].q_depth = sq_depth;
+		nic_dev->txqs[i].q_mask = sq_depth - 1;
+		nic_dev->rxqs[i].q_depth = rq_depth;
+		nic_dev->rxqs[i].q_mask = rq_depth - 1;
+	}
+}
+
+static int hinic3_check_ringparam_valid(struct net_device *netdev,
+					const struct ethtool_ringparam *ring)
+{
+	if (ring->rx_jumbo_pending || ring->rx_mini_pending) {
+		netdev_err(netdev, "Unsupported rx_jumbo_pending/rx_mini_pending\n");
+		return -EINVAL;
+	}
+
+	if (ring->tx_pending > HINIC3_MAX_TX_QUEUE_DEPTH ||
+	    ring->tx_pending < HINIC3_MIN_QUEUE_DEPTH ||
+	    ring->rx_pending > HINIC3_MAX_RX_QUEUE_DEPTH ||
+	    ring->rx_pending < HINIC3_MIN_QUEUE_DEPTH) {
+		netdev_err(netdev,
+			   "Queue depth out of range tx[%d-%d] rx[%d-%d]\n",
+			   HINIC3_MIN_QUEUE_DEPTH, HINIC3_MAX_TX_QUEUE_DEPTH,
+			   HINIC3_MIN_QUEUE_DEPTH, HINIC3_MAX_RX_QUEUE_DEPTH);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hinic3_set_ringparam(struct net_device *netdev,
+				struct ethtool_ringparam *ring,
+				struct kernel_ethtool_ringparam *kernel_ring,
+				struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_txrxq_params q_params = {};
+	u32 new_sq_depth, new_rq_depth;
+	int err;
+
+	err = hinic3_check_ringparam_valid(netdev, ring);
+	if (err)
+		return err;
+
+	new_sq_depth = 1U << ilog2(ring->tx_pending);
+	new_rq_depth = 1U << ilog2(ring->rx_pending);
+	if (new_sq_depth == nic_dev->q_params.sq_depth &&
+	    new_rq_depth == nic_dev->q_params.rq_depth)
+		return 0;
+
+	netdev_dbg(netdev, "Change Tx/Rx ring depth from %u/%u to %u/%u\n",
+		   nic_dev->q_params.sq_depth, nic_dev->q_params.rq_depth,
+		   new_sq_depth, new_rq_depth);
+
+	if (!netif_running(netdev)) {
+		hinic3_update_qp_depth(netdev, new_sq_depth, new_rq_depth);
+	} else {
+		q_params = nic_dev->q_params;
+		q_params.sq_depth = new_sq_depth;
+		q_params.rq_depth = new_rq_depth;
+
+		err = hinic3_change_channel_settings(netdev, &q_params);
+		if (err) {
+			netdev_err(netdev, "Failed to change channel settings\n");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 static const struct ethtool_ops hinic3_ethtool_ops = {
 	.supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
 					  ETHTOOL_COALESCE_PKT_RATE_RX_USECS,
@@ -417,6 +509,8 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
 	.get_msglevel                   = hinic3_get_msglevel,
 	.set_msglevel                   = hinic3_set_msglevel,
 	.get_link                       = ethtool_op_get_link,
+	.get_ringparam                  = hinic3_get_ringparam,
+	.set_ringparam                  = hinic3_set_ringparam,
 };
 
 void hinic3_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
index e7d6c2033b45..fb3865fc986a 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -137,7 +137,8 @@ static int hinic3_set_interrupt_moder(struct net_device *netdev, u16 q_id,
 	struct hinic3_interrupt_info info = {};
 	int err;
 
-	if (q_id >= nic_dev->q_params.num_qps)
+	if (!HINIC3_CHANNEL_RES_VALID(nic_dev) ||
+	    q_id >= nic_dev->q_params.num_qps)
 		return 0;
 
 	info.interrupt_coalesc_set = 1;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 0a888fe4c975..de3e71f75f0c 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -315,6 +315,9 @@ static void hinic3_link_status_change(struct net_device *netdev,
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
 
+	if (!HINIC3_CHANNEL_RES_VALID(nic_dev))
+		return;
+
 	if (link_status_up) {
 		if (netif_carrier_ok(netdev))
 			return;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index da73811641a9..ea487505dc80 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -428,6 +428,60 @@ static void hinic3_vport_down(struct net_device *netdev)
 	}
 }
 
+int
+hinic3_change_channel_settings(struct net_device *netdev,
+			       struct hinic3_dyna_txrxq_params *trxq_params)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_qp_params new_qp_params = {};
+	struct hinic3_dyna_qp_params cur_qp_params = {};
+	int err;
+
+	hinic3_config_num_qps(netdev, trxq_params);
+
+	err = hinic3_alloc_channel_resources(netdev, &new_qp_params,
+					     trxq_params);
+	if (err) {
+		netdev_err(netdev, "Failed to alloc channel resources\n");
+		return err;
+	}
+
+	if (!test_and_set_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags)) {
+		hinic3_vport_down(netdev);
+		hinic3_close_channel(netdev);
+		hinic3_uninit_qps(nic_dev, &cur_qp_params);
+		hinic3_free_channel_resources(netdev, &cur_qp_params,
+					      &nic_dev->q_params);
+	}
+
+	if (nic_dev->num_qp_irq > trxq_params->num_qps)
+		hinic3_qp_irq_change(netdev, trxq_params->num_qps);
+	nic_dev->q_params = *trxq_params;
+
+	hinic3_init_qps(nic_dev, &new_qp_params);
+
+	err = hinic3_open_channel(netdev);
+	if (err)
+		goto err_uninit_qps;
+
+	err = hinic3_vport_up(netdev);
+	if (err)
+		goto err_close_channel;
+
+	clear_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags);
+
+	return 0;
+
+err_close_channel:
+	hinic3_close_channel(netdev);
+err_uninit_qps:
+	clear_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags);
+	hinic3_uninit_qps(nic_dev, &new_qp_params);
+	hinic3_free_channel_resources(netdev, &new_qp_params, trxq_params);
+
+	return err;
+}
+
 static int hinic3_open(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
@@ -493,11 +547,18 @@ static int hinic3_close(struct net_device *netdev)
 		return 0;
 	}
 
+	if (test_and_clear_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags))
+		goto out;
+
 	hinic3_vport_down(netdev);
 	hinic3_close_channel(netdev);
 	hinic3_uninit_qps(nic_dev, &qp_params);
 	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
 
+out:
+	hinic3_free_nicio_res(nic_dev);
+	hinic3_destroy_num_qps(netdev);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index 9502293ff710..a94c3dde421e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -10,6 +10,9 @@
 #include "hinic3_hw_cfg.h"
 #include "hinic3_hwdev.h"
 #include "hinic3_mgmt_interface.h"
+#include "hinic3_nic_io.h"
+#include "hinic3_tx.h"
+#include "hinic3_rx.h"
 
 #define HINIC3_VLAN_BITMAP_BYTE_SIZE(nic_dev)  (sizeof(*(nic_dev)->vlan_bitmap))
 #define HINIC3_VLAN_BITMAP_SIZE(nic_dev)  \
@@ -20,8 +23,13 @@ enum hinic3_flags {
 	HINIC3_MAC_FILTER_CHANGED,
 	HINIC3_RSS_ENABLE,
 	HINIC3_UPDATE_MAC_FILTER,
+	HINIC3_CHANGE_RES_INVALID,
 };
 
+#define HINIC3_CHANNEL_RES_VALID(nic_dev) \
+	(test_bit(HINIC3_INTF_UP, &(nic_dev)->flags) && \
+	 !test_bit(HINIC3_CHANGE_RES_INVALID, &(nic_dev)->flags))
+
 enum hinic3_event_work_flags {
 	HINIC3_EVENT_WORK_TX_TIMEOUT,
 };
@@ -143,6 +151,10 @@ struct hinic3_nic_dev {
 
 void hinic3_set_netdev_ops(struct net_device *netdev);
 int hinic3_set_hw_features(struct net_device *netdev);
+int
+hinic3_change_channel_settings(struct net_device *netdev,
+			       struct hinic3_dyna_txrxq_params *trxq_params);
+
 int hinic3_qps_irq_init(struct net_device *netdev);
 void hinic3_qps_irq_uninit(struct net_device *netdev);
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
index 12eefabcf1db..3791b9bc865b 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
@@ -14,6 +14,10 @@ struct hinic3_nic_dev;
 #define HINIC3_RQ_WQEBB_SHIFT      3
 #define HINIC3_SQ_WQEBB_SIZE       BIT(HINIC3_SQ_WQEBB_SHIFT)
 
+#define HINIC3_MAX_TX_QUEUE_DEPTH  65536
+#define HINIC3_MAX_RX_QUEUE_DEPTH  16384
+#define HINIC3_MIN_QUEUE_DEPTH     128
+
 /* ******************** RQ_CTRL ******************** */
 enum hinic3_rq_wqe_type {
 	HINIC3_NORMAL_RQ_WQE = 1,
-- 
2.43.0


