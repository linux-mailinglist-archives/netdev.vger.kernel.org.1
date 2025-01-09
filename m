Return-Path: <netdev+bounces-156850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C54A07FF5
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C703A39DF
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7211E1FDE2B;
	Thu,  9 Jan 2025 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tc7gM17j"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B971EBA0C;
	Thu,  9 Jan 2025 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447926; cv=none; b=dtva0qeoNlpUItVwtvIi5I6BmmZnanZDkPes9xYJWhrPO9Lf5AHRsxNHlrcQGmojZwzuJ2/BV85osXDt6dzuFlpVNZR79VR9Sw/G/g2tIf6ZE5Ibcp05v6uDEJvdi5pr6kEaX1nsLu9ctd6uHsrvQux3KOevvOm/8HMPoeoxSdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447926; c=relaxed/simple;
	bh=92h0SKh/xwIPzYkXOI/HkhctPfTKzkI+it/PGtWRfzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZShTT0Hxh2kIcYlHS+fK+wrJEV29pB1UMHse0/SJw78KiI0zlLEHXrZlhKtkYlNcaji+6SD+W7S9S1QLPmwG/ONpCIQ0iZe8mKvj25vlhsGwZc66JAx7qbkWJOiD7YWLPFPFmcO2Irf8lBHHgtzEs9tHX0zVdLobfpnvJTY1NPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tc7gM17j; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736447924; x=1767983924;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=92h0SKh/xwIPzYkXOI/HkhctPfTKzkI+it/PGtWRfzo=;
  b=tc7gM17jVRoSHUv6WHhNpOXeA8HNm1JD08SGWBT8ZJnoF4y3PrY0VGZ0
   z78CUZlWgOlmvJQ3oHyiJXTph1N+ry7jaoWCKNS1nNBUcAzfFplNv/P30
   ZRMamp+EK2SMXRDqAucw8+Kc28gjaFtD249+p6r6C+uyZ87ZZutrztsx6
   UpICCFaCuyrgRY41MNDDHbLmNkptOSmXYuWPZHb2eZftcJ3mDAkE5o5MS
   EPHWyJvD1VsQ1U0mb+4G9AxEbpGYCgiNlMtyuJGBwtx9qeKvqDvr1bfVy
   rMXqWJ7qhFsjYTc4QQ9OEVLWDN9P1FvdB/9LdqqLyJrJF1LsRzbhhZQZ/
   Q==;
X-CSE-ConnectionGUID: EEpZxm35SCOeNwgRklSfsQ==
X-CSE-MsgGUID: 08XnVAoISUumCEpn+ceKlQ==
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36007575"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2025 11:38:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 Jan 2025 11:38:21 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 9 Jan 2025 11:38:18 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 9 Jan 2025 19:37:57 +0100
Subject: [PATCH net-next 5/6] net: sparx5: ops out certain FDMA functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250109-sparx5-lan969x-switch-driver-5-v1-5-13d6d8451e63@microchip.com>
References: <20250109-sparx5-lan969x-switch-driver-5-v1-0-13d6d8451e63@microchip.com>
In-Reply-To: <20250109-sparx5-lan969x-switch-driver-5-v1-0-13d6d8451e63@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	<jensemil.schulzostergaard@microchip.com>, <horatiu.vultur@microchip.com>,
	<jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14-dev

We are going to implement the RX  and TX paths a bit differently on
lan969x and therefore need to introduce new ops for FDMA functions:
init, deinit, xmit and poll. Assign the Sparx5 equivalents for these and
update the code throughout.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c   | 5 +++--
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c   | 9 +++++++--
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h   | 5 +++++
 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c | 5 ++++-
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index cb78acd356d2..49f5af1eab94 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -183,7 +183,7 @@ static bool sparx5_fdma_rx_get_frame(struct sparx5 *sparx5, struct sparx5_rx *rx
 	return true;
 }
 
-static int sparx5_fdma_napi_callback(struct napi_struct *napi, int weight)
+int sparx5_fdma_napi_callback(struct napi_struct *napi, int weight)
 {
 	struct sparx5_rx *rx = container_of(napi, struct sparx5_rx, napi);
 	struct sparx5 *sparx5 = container_of(rx, struct sparx5, rx);
@@ -452,12 +452,13 @@ static u32 sparx5_fdma_port_ctrl(struct sparx5 *sparx5)
 
 int sparx5_fdma_start(struct sparx5 *sparx5)
 {
+	const struct sparx5_ops *ops = sparx5->data->ops;
 	struct sparx5_rx *rx = &sparx5->rx;
 	struct sparx5_tx *tx = &sparx5->tx;
 
 	netif_napi_add_weight(rx->ndev,
 			      &rx->napi,
-			      sparx5_fdma_napi_callback,
+			      ops->fdma_poll,
 			      FDMA_WEIGHT);
 
 	napi_enable(&rx->napi);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index a60f6a166522..6a0e5b83ecd0 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -793,7 +793,7 @@ static int sparx5_start(struct sparx5 *sparx5)
 					       0,
 					       "sparx5-fdma", sparx5);
 		if (!err) {
-			err = sparx5_fdma_init(sparx5);
+			err = ops->fdma_init(sparx5);
 			if (!err)
 				sparx5_fdma_start(sparx5);
 		}
@@ -1030,6 +1030,7 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 static void mchp_sparx5_remove(struct platform_device *pdev)
 {
 	struct sparx5 *sparx5 = platform_get_drvdata(pdev);
+	const struct sparx5_ops *ops = sparx5->data->ops;
 
 	debugfs_remove_recursive(sparx5->debugfs_root);
 	if (sparx5->xtr_irq) {
@@ -1041,7 +1042,7 @@ static void mchp_sparx5_remove(struct platform_device *pdev)
 		sparx5->fdma_irq = -ENXIO;
 	}
 	sparx5_ptp_deinit(sparx5);
-	sparx5_fdma_stop(sparx5);
+	ops->fdma_deinit(sparx5);
 	sparx5_cleanup_ports(sparx5);
 	sparx5_vcap_destroy(sparx5);
 	/* Unregister netdevs */
@@ -1096,6 +1097,10 @@ static const struct sparx5_ops sparx5_ops = {
 	.set_port_mux            = &sparx5_port_mux_set,
 	.ptp_irq_handler         = &sparx5_ptp_irq_handler,
 	.dsm_calendar_calc       = &sparx5_dsm_calendar_calc,
+	.fdma_init               = &sparx5_fdma_init,
+	.fdma_deinit             = &sparx5_fdma_deinit,
+	.fdma_poll               = &sparx5_fdma_napi_callback,
+	.fdma_xmit               = &sparx5_fdma_xmit,
 };
 
 static const struct sparx5_match_data sparx5_desc = {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 7433a77204cd..35706e9a27c8 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -326,6 +326,10 @@ struct sparx5_ops {
 				 struct sparx5_calendar_data *data);
 	int (*port_config_rgmii)(struct sparx5_port *port,
 				 struct sparx5_port_config *conf);
+	int (*fdma_init)(struct sparx5 *sparx5);
+	int (*fdma_deinit)(struct sparx5 *sparx5);
+	int (*fdma_poll)(struct napi_struct *napi, int weight);
+	int (*fdma_xmit)(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb);
 };
 
 struct sparx5_main_io_resource {
@@ -440,6 +444,7 @@ int sparx5_fdma_init(struct sparx5 *sparx5);
 int sparx5_fdma_deinit(struct sparx5 *sparx5);
 int sparx5_fdma_start(struct sparx5 *sparx5);
 int sparx5_fdma_stop(struct sparx5 *sparx5);
+int sparx5_fdma_napi_callback(struct napi_struct *napi, int weight);
 int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb);
 irqreturn_t sparx5_fdma_handler(int irq, void *args);
 
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
index e776fa0845c6..bb71ee09977a 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
@@ -232,9 +232,12 @@ netdev_tx_t sparx5_port_xmit_impl(struct sk_buff *skb, struct net_device *dev)
 	struct net_device_stats *stats = &dev->stats;
 	struct sparx5_port *port = netdev_priv(dev);
 	struct sparx5 *sparx5 = port->sparx5;
+	const struct sparx5_ops *ops;
 	u32 ifh[IFH_LEN];
 	netdev_tx_t ret;
 
+	ops = sparx5->data->ops;
+
 	memset(ifh, 0, IFH_LEN * 4);
 	sparx5_set_port_ifh(sparx5, ifh, port->portno);
 
@@ -254,7 +257,7 @@ netdev_tx_t sparx5_port_xmit_impl(struct sk_buff *skb, struct net_device *dev)
 	skb_tx_timestamp(skb);
 	spin_lock(&sparx5->tx_lock);
 	if (sparx5->fdma_irq > 0)
-		ret = sparx5_fdma_xmit(sparx5, ifh, skb);
+		ret = ops->fdma_xmit(sparx5, ifh, skb);
 	else
 		ret = sparx5_inject(sparx5, ifh, skb, dev);
 	spin_unlock(&sparx5->tx_lock);

-- 
2.34.1


