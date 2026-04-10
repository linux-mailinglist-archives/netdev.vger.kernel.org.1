Return-Path: <netdev+bounces-277531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGJUMhpV2WlGoggAu9opvQ
	(envelope-from <netdev+bounces-277531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:52:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6C63DC205
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E192430562BA
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908963806C8;
	Fri, 10 Apr 2026 19:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vu9KgETs"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDD9299959;
	Fri, 10 Apr 2026 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850733; cv=none; b=n2+KZS2jnY25EoicHTxywwiwgyX4aVa5W4jLjORu/QRpD2WWwIu/t3qHYRlT39BEeB4iDWG6AM+Zn8CKYfjE/yuH2sTN9WPw5RdV1QwidqrbCHuz007bSjgn5zVfc2QmYBuBbSsbkUxjObh48aByji5hEp3r9ga9D4ZUaPmZjBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850733; c=relaxed/simple;
	bh=DXLZ5jia+w5t3//drXoi4sOPLEZz7C5/LE3xsfGIGx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Io7hfDyePehzA1N2aSAhbmpHrQZ2qMrHr7+zAfRSB4b7AZdyanUdhcr602nR4GR0mUUHIlW6hvG6GGj8lzyND4uuMybMDvYnRoUgYwDpNFsnWPiRQpWCiZa6zCetIEmD+SwIgaLGYa5Lu/67zaAhmkguphU8eKbO8DZ+UXKtUz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vu9KgETs; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F061EC5C1A7;
	Fri, 10 Apr 2026 19:52:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A8409603F0;
	Fri, 10 Apr 2026 19:52:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 34EDB10450082;
	Fri, 10 Apr 2026 21:52:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775850726; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vRx1s/Xm9Zf81gS/dTPLcXPhL5ExtEnYzFcCGg4EzO4=;
	b=Vu9KgETssi0UGWoAFLHI3dIcJOuPtSV9NJwWlihNkKpRZZ4GMBTArgktdudZHDwyyG/Aeb
	0HntUCSFQ4jf4mUzdBKJM1i7unYDhKI4IsZsi3esXXjKCTyiaVuP3BxtUsZYviLhn7ecHE
	oKCN5YF3BlFCs6bpoF6wtSrqvo2DAhE1WRnygjpj+uufP8VLURgFMH3B6Lu0QStmrbEs+/
	uqYOgygOisCOoLImmhnbXa4RmWb9nkEhoG8Gf5kykrjqcbkoE8nZPsFWtCTxER4p9hGQw6
	VV63Hxr/zyU9Innq5qCdI/MDIBggf+gSOsewrZQ2jvX1ZrKEnTJrkFZ3Hnglzw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 10 Apr 2026 21:51:49 +0200
Subject: [PATCH net-next v2 01/14] net: macb: unify device pointer naming
 convention
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-macb-context-v2-1-af39f71d40b6@bootlin.com>
References: <20260410-macb-context-v2-0-af39f71d40b6@bootlin.com>
In-Reply-To: <20260410-macb-context-v2-0-af39f71d40b6@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Paolo Valerio <pvalerio@redhat.com>, Conor Dooley <conor@kernel.org>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15.1
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277531-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1D6C63DC205
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Here are all device pointer variable permutations inside MACB:

   struct device *dev;
   struct net_device *dev;
   struct net_device *ndev;
   struct net_device *netdev;
   struct pci_dev *pdev;              // inside macb_pci.c
   struct platform_device *pdev;
   struct platform_device *plat_dev;  // inside macb_pci.c

Unify to this convention:

   struct device *dev;
   struct net_device *netdev;
   struct pci_dev *pci;
   struct platform_device *pdev;

Ensure nothing slipped through using ctags tooling:

⟩ ctags -o - --kinds-c='{local}{member}{parameter}' \
    --fields='{typeref}' drivers/net/ethernet/cadence/* | \
  awk -F"\t" '
    $NF~/struct:.*(device|dev) / {print $NF, $1}' | \
  sort -u
typeref:struct:device * dev
typeref:struct:in_device * idev        // ignored
typeref:struct:net_device * netdev
typeref:struct:pci_dev * pci
typeref:struct:phy_device * phy        // ignored
typeref:struct:phy_device * phydev     // ignored
typeref:struct:platform_device * pdev

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |  20 +-
 drivers/net/ethernet/cadence/macb_main.c | 632 ++++++++++++++++---------------
 drivers/net/ethernet/cadence/macb_pci.c  |  46 +--
 drivers/net/ethernet/cadence/macb_ptp.c  |  18 +-
 4 files changed, 359 insertions(+), 357 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 2de56017ee0d..9857df5b57f0 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1207,11 +1207,11 @@ struct macb_or_gem_ops {
 
 /* MACB-PTP interface: adapt to platform needs. */
 struct macb_ptp_info {
-	void (*ptp_init)(struct net_device *ndev);
-	void (*ptp_remove)(struct net_device *ndev);
+	void (*ptp_init)(struct net_device *netdev);
+	void (*ptp_remove)(struct net_device *netdev);
 	s32 (*get_ptp_max_adj)(void);
 	unsigned int (*get_tsu_rate)(struct macb *bp);
-	int (*get_ts_info)(struct net_device *dev,
+	int (*get_ts_info)(struct net_device *netdev,
 			   struct kernel_ethtool_ts_info *info);
 	int (*get_hwtst)(struct net_device *netdev,
 			 struct kernel_hwtstamp_config *tstamp_config);
@@ -1326,7 +1326,7 @@ struct macb {
 	struct clk		*tx_clk;
 	struct clk		*rx_clk;
 	struct clk		*tsu_clk;
-	struct net_device	*dev;
+	struct net_device	*netdev;
 	/* Protects hw_stats and ethtool_stats */
 	spinlock_t		stats_lock;
 	union {
@@ -1406,8 +1406,8 @@ enum macb_bd_control {
 	TSTAMP_ALL_FRAMES,
 };
 
-void gem_ptp_init(struct net_device *ndev);
-void gem_ptp_remove(struct net_device *ndev);
+void gem_ptp_init(struct net_device *netdev);
+void gem_ptp_remove(struct net_device *netdev);
 void gem_ptp_txstamp(struct macb *bp, struct sk_buff *skb, struct macb_dma_desc *desc);
 void gem_ptp_rxstamp(struct macb *bp, struct sk_buff *skb, struct macb_dma_desc *desc);
 static inline void gem_ptp_do_txstamp(struct macb *bp, struct sk_buff *skb, struct macb_dma_desc *desc)
@@ -1426,14 +1426,14 @@ static inline void gem_ptp_do_rxstamp(struct macb *bp, struct sk_buff *skb, stru
 	gem_ptp_rxstamp(bp, skb, desc);
 }
 
-int gem_get_hwtst(struct net_device *dev,
+int gem_get_hwtst(struct net_device *netdev,
 		  struct kernel_hwtstamp_config *tstamp_config);
-int gem_set_hwtst(struct net_device *dev,
+int gem_set_hwtst(struct net_device *netdev,
 		  struct kernel_hwtstamp_config *tstamp_config,
 		  struct netlink_ext_ack *extack);
 #else
-static inline void gem_ptp_init(struct net_device *ndev) { }
-static inline void gem_ptp_remove(struct net_device *ndev) { }
+static inline void gem_ptp_init(struct net_device *netdev) { }
+static inline void gem_ptp_remove(struct net_device *netdev) { }
 
 static inline void gem_ptp_do_txstamp(struct macb *bp, struct sk_buff *skb, struct macb_dma_desc *desc) { }
 static inline void gem_ptp_do_rxstamp(struct macb *bp, struct sk_buff *skb, struct macb_dma_desc *desc) { }
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d9716c56f705..896d481e0f95 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -252,9 +252,9 @@ static void macb_set_hwaddr(struct macb *bp)
 	u32 bottom;
 	u16 top;
 
-	bottom = get_unaligned_le32(bp->dev->dev_addr);
+	bottom = get_unaligned_le32(bp->netdev->dev_addr);
 	macb_or_gem_writel(bp, SA1B, bottom);
-	top = get_unaligned_le16(bp->dev->dev_addr + 4);
+	top = get_unaligned_le16(bp->netdev->dev_addr + 4);
 	macb_or_gem_writel(bp, SA1T, top);
 
 	if (gem_has_ptp(bp)) {
@@ -291,13 +291,13 @@ static void macb_get_hwaddr(struct macb *bp)
 		addr[5] = (top >> 8) & 0xff;
 
 		if (is_valid_ether_addr(addr)) {
-			eth_hw_addr_set(bp->dev, addr);
+			eth_hw_addr_set(bp->netdev, addr);
 			return;
 		}
 	}
 
 	dev_info(&bp->pdev->dev, "invalid hw address, using random\n");
-	eth_hw_addr_random(bp->dev);
+	eth_hw_addr_random(bp->netdev);
 }
 
 static int macb_mdio_wait_for_idle(struct macb *bp)
@@ -509,12 +509,12 @@ static void macb_set_tx_clk(struct macb *bp, int speed)
 	ferr = abs(rate_rounded - rate);
 	ferr = DIV_ROUND_UP(ferr, rate / 100000);
 	if (ferr > 5)
-		netdev_warn(bp->dev,
+		netdev_warn(bp->netdev,
 			    "unable to generate target frequency: %ld Hz\n",
 			    rate);
 
 	if (clk_set_rate(bp->tx_clk, rate_rounded))
-		netdev_err(bp->dev, "adjusting tx_clk failed.\n");
+		netdev_err(bp->netdev, "adjusting tx_clk failed.\n");
 }
 
 static void macb_usx_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
@@ -697,8 +697,8 @@ static void macb_tx_lpi_wake(struct macb *bp)
 
 static void macb_mac_disable_tx_lpi(struct phylink_config *config)
 {
-	struct net_device *ndev = to_net_dev(config->dev);
-	struct macb *bp = netdev_priv(ndev);
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct macb *bp = netdev_priv(netdev);
 	unsigned long flags;
 
 	cancel_delayed_work_sync(&bp->tx_lpi_work);
@@ -712,8 +712,8 @@ static void macb_mac_disable_tx_lpi(struct phylink_config *config)
 static int macb_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 				  bool tx_clk_stop)
 {
-	struct net_device *ndev = to_net_dev(config->dev);
-	struct macb *bp = netdev_priv(ndev);
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct macb *bp = netdev_priv(netdev);
 	unsigned long flags;
 
 	spin_lock_irqsave(&bp->lock, flags);
@@ -732,8 +732,8 @@ static int macb_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 			    const struct phylink_link_state *state)
 {
-	struct net_device *ndev = to_net_dev(config->dev);
-	struct macb *bp = netdev_priv(ndev);
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct macb *bp = netdev_priv(netdev);
 	unsigned long flags;
 	u32 old_ctrl, ctrl;
 	u32 old_ncr, ncr;
@@ -774,8 +774,8 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 static void macb_mac_link_down(struct phylink_config *config, unsigned int mode,
 			       phy_interface_t interface)
 {
-	struct net_device *ndev = to_net_dev(config->dev);
-	struct macb *bp = netdev_priv(ndev);
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue;
 	unsigned int q;
 	u32 ctrl;
@@ -789,7 +789,7 @@ static void macb_mac_link_down(struct phylink_config *config, unsigned int mode,
 	ctrl = macb_readl(bp, NCR) & ~(MACB_BIT(RE) | MACB_BIT(TE));
 	macb_writel(bp, NCR, ctrl);
 
-	netif_tx_stop_all_queues(ndev);
+	netif_tx_stop_all_queues(netdev);
 }
 
 /* Use juggling algorithm to left rotate tx ring and tx skb array */
@@ -884,13 +884,13 @@ static void gem_shuffle_tx_rings(struct macb *bp)
 }
 
 static void macb_mac_link_up(struct phylink_config *config,
-			     struct phy_device *phy,
+			     struct phy_device *phydev,
 			     unsigned int mode, phy_interface_t interface,
 			     int speed, int duplex,
 			     bool tx_pause, bool rx_pause)
 {
-	struct net_device *ndev = to_net_dev(config->dev);
-	struct macb *bp = netdev_priv(ndev);
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue;
 	unsigned long flags;
 	unsigned int q;
@@ -946,14 +946,14 @@ static void macb_mac_link_up(struct phylink_config *config,
 
 	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
 
-	netif_tx_wake_all_queues(ndev);
+	netif_tx_wake_all_queues(netdev);
 }
 
 static struct phylink_pcs *macb_mac_select_pcs(struct phylink_config *config,
 					       phy_interface_t interface)
 {
-	struct net_device *ndev = to_net_dev(config->dev);
-	struct macb *bp = netdev_priv(ndev);
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct macb *bp = netdev_priv(netdev);
 
 	if (interface == PHY_INTERFACE_MODE_10GBASER)
 		return &bp->phylink_usx_pcs;
@@ -982,7 +982,7 @@ static bool macb_phy_handle_exists(struct device_node *dn)
 static int macb_phylink_connect(struct macb *bp)
 {
 	struct device_node *dn = bp->pdev->dev.of_node;
-	struct net_device *dev = bp->dev;
+	struct net_device *netdev = bp->netdev;
 	struct phy_device *phydev;
 	int ret;
 
@@ -992,7 +992,7 @@ static int macb_phylink_connect(struct macb *bp)
 	if (!dn || (ret && !macb_phy_handle_exists(dn))) {
 		phydev = phy_find_first(bp->mii_bus);
 		if (!phydev) {
-			netdev_err(dev, "no PHY found\n");
+			netdev_err(netdev, "no PHY found\n");
 			return -ENXIO;
 		}
 
@@ -1001,7 +1001,7 @@ static int macb_phylink_connect(struct macb *bp)
 	}
 
 	if (ret) {
-		netdev_err(dev, "Could not attach PHY (%d)\n", ret);
+		netdev_err(netdev, "Could not attach PHY (%d)\n", ret);
 		return ret;
 	}
 
@@ -1013,21 +1013,21 @@ static int macb_phylink_connect(struct macb *bp)
 static void macb_get_pcs_fixed_state(struct phylink_config *config,
 				     struct phylink_link_state *state)
 {
-	struct net_device *ndev = to_net_dev(config->dev);
-	struct macb *bp = netdev_priv(ndev);
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct macb *bp = netdev_priv(netdev);
 
 	state->link = (macb_readl(bp, NSR) & MACB_BIT(NSR_LINK)) != 0;
 }
 
 /* based on au1000_eth. c*/
-static int macb_mii_probe(struct net_device *dev)
+static int macb_mii_probe(struct net_device *netdev)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 
 	bp->phylink_sgmii_pcs.ops = &macb_phylink_pcs_ops;
 	bp->phylink_usx_pcs.ops = &macb_phylink_usx_pcs_ops;
 
-	bp->phylink_config.dev = &dev->dev;
+	bp->phylink_config.dev = &netdev->dev;
 	bp->phylink_config.type = PHYLINK_NETDEV;
 	bp->phylink_config.mac_managed_pm = true;
 
@@ -1086,7 +1086,7 @@ static int macb_mii_probe(struct net_device *dev)
 	bp->phylink = phylink_create(&bp->phylink_config, bp->pdev->dev.fwnode,
 				     bp->phy_interface, &macb_phylink_ops);
 	if (IS_ERR(bp->phylink)) {
-		netdev_err(dev, "Could not create a phylink instance (%ld)\n",
+		netdev_err(netdev, "Could not create a phylink instance (%ld)\n",
 			   PTR_ERR(bp->phylink));
 		return PTR_ERR(bp->phylink);
 	}
@@ -1133,7 +1133,7 @@ static int macb_mii_init(struct macb *bp)
 	 */
 	mdio_np = of_get_child_by_name(np, "mdio");
 	if (!mdio_np && of_phy_is_fixed_link(np))
-		return macb_mii_probe(bp->dev);
+		return macb_mii_probe(bp->netdev);
 
 	/* Enable management port */
 	macb_writel(bp, NCR, MACB_BIT(MPE));
@@ -1154,13 +1154,13 @@ static int macb_mii_init(struct macb *bp)
 	bp->mii_bus->priv = bp;
 	bp->mii_bus->parent = &bp->pdev->dev;
 
-	dev_set_drvdata(&bp->dev->dev, bp->mii_bus);
+	dev_set_drvdata(&bp->netdev->dev, bp->mii_bus);
 
 	err = macb_mdiobus_register(bp, mdio_np);
 	if (err)
 		goto err_out_free_mdiobus;
 
-	err = macb_mii_probe(bp->dev);
+	err = macb_mii_probe(bp->netdev);
 	if (err)
 		goto err_out_unregister_bus;
 
@@ -1268,7 +1268,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	unsigned long		flags;
 
 	queue_index = queue - bp->queues;
-	netdev_vdbg(bp->dev, "macb_tx_error_task: q = %u, t = %u, h = %u\n",
+	netdev_vdbg(bp->netdev, "macb_tx_error_task: q = %u, t = %u, h = %u\n",
 		    queue_index, queue->tx_tail, queue->tx_head);
 
 	/* Prevent the queue NAPI TX poll from running, as it calls
@@ -1281,14 +1281,14 @@ static void macb_tx_error_task(struct work_struct *work)
 	spin_lock_irqsave(&bp->lock, flags);
 
 	/* Make sure nobody is trying to queue up new packets */
-	netif_tx_stop_all_queues(bp->dev);
+	netif_tx_stop_all_queues(bp->netdev);
 
 	/* Stop transmission now
 	 * (in case we have just queued new packets)
 	 * macb/gem must be halted to write TBQP register
 	 */
 	if (macb_halt_tx(bp)) {
-		netdev_err(bp->dev, "BUG: halt tx timed out\n");
+		netdev_err(bp->netdev, "BUG: halt tx timed out\n");
 		macb_writel(bp, NCR, macb_readl(bp, NCR) & (~MACB_BIT(TE)));
 		halt_timeout = true;
 	}
@@ -1317,13 +1317,13 @@ static void macb_tx_error_task(struct work_struct *work)
 			 * since it's the only one written back by the hardware
 			 */
 			if (!(ctrl & MACB_BIT(TX_BUF_EXHAUSTED))) {
-				netdev_vdbg(bp->dev, "txerr skb %u (data %p) TX complete\n",
+				netdev_vdbg(bp->netdev, "txerr skb %u (data %p) TX complete\n",
 					    macb_tx_ring_wrap(bp, tail),
 					    skb->data);
-				bp->dev->stats.tx_packets++;
+				bp->netdev->stats.tx_packets++;
 				queue->stats.tx_packets++;
 				packets++;
-				bp->dev->stats.tx_bytes += skb->len;
+				bp->netdev->stats.tx_bytes += skb->len;
 				queue->stats.tx_bytes += skb->len;
 				bytes += skb->len;
 			}
@@ -1333,7 +1333,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			 * those. Statistics are updated by hardware.
 			 */
 			if (ctrl & MACB_BIT(TX_BUF_EXHAUSTED))
-				netdev_err(bp->dev,
+				netdev_err(bp->netdev,
 					   "BUG: TX buffers exhausted mid-frame\n");
 
 			desc->ctrl = ctrl | MACB_BIT(TX_USED);
@@ -1342,7 +1342,7 @@ static void macb_tx_error_task(struct work_struct *work)
 		macb_tx_unmap(bp, tx_skb, 0);
 	}
 
-	netdev_tx_completed_queue(netdev_get_tx_queue(bp->dev, queue_index),
+	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, queue_index),
 				  packets, bytes);
 
 	/* Set end of TX queue */
@@ -1367,7 +1367,7 @@ static void macb_tx_error_task(struct work_struct *work)
 		macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TE));
 
 	/* Now we are ready to start transmission again */
-	netif_tx_start_all_queues(bp->dev);
+	netif_tx_start_all_queues(bp->netdev);
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
 
 	spin_unlock_irqrestore(&bp->lock, flags);
@@ -1446,12 +1446,12 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 				    !ptp_one_step_sync(skb))
 					gem_ptp_do_txstamp(bp, skb, desc);
 
-				netdev_vdbg(bp->dev, "skb %u (data %p) TX complete\n",
+				netdev_vdbg(bp->netdev, "skb %u (data %p) TX complete\n",
 					    macb_tx_ring_wrap(bp, tail),
 					    skb->data);
-				bp->dev->stats.tx_packets++;
+				bp->netdev->stats.tx_packets++;
 				queue->stats.tx_packets++;
-				bp->dev->stats.tx_bytes += skb->len;
+				bp->netdev->stats.tx_bytes += skb->len;
 				queue->stats.tx_bytes += skb->len;
 				packets++;
 				bytes += skb->len;
@@ -1469,14 +1469,14 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		}
 	}
 
-	netdev_tx_completed_queue(netdev_get_tx_queue(bp->dev, queue_index),
+	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, queue_index),
 				  packets, bytes);
 
 	queue->tx_tail = tail;
-	if (__netif_subqueue_stopped(bp->dev, queue_index) &&
+	if (__netif_subqueue_stopped(bp->netdev, queue_index) &&
 	    CIRC_CNT(queue->tx_head, queue->tx_tail,
 		     bp->tx_ring_size) <= MACB_TX_WAKEUP_THRESH(bp))
-		netif_wake_subqueue(bp->dev, queue_index);
+		netif_wake_subqueue(bp->netdev, queue_index);
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 
 	if (packets)
@@ -1504,9 +1504,9 @@ static void gem_rx_refill(struct macb_queue *queue)
 
 		if (!queue->rx_skbuff[entry]) {
 			/* allocate sk_buff for this free entry in ring */
-			skb = netdev_alloc_skb(bp->dev, bp->rx_buffer_size);
+			skb = netdev_alloc_skb(bp->netdev, bp->rx_buffer_size);
 			if (unlikely(!skb)) {
-				netdev_err(bp->dev,
+				netdev_err(bp->netdev,
 					   "Unable to allocate sk_buff\n");
 				break;
 			}
@@ -1555,8 +1555,8 @@ static void gem_rx_refill(struct macb_queue *queue)
 	/* Make descriptor updates visible to hardware */
 	wmb();
 
-	netdev_vdbg(bp->dev, "rx ring: queue: %p, prepared head %d, tail %d\n",
-			queue, queue->rx_prepared_head, queue->rx_tail);
+	netdev_vdbg(bp->netdev, "rx ring: queue: %p, prepared head %d, tail %d\n",
+		    queue, queue->rx_prepared_head, queue->rx_tail);
 }
 
 /* Mark DMA descriptors from begin up to and not including end as unused */
@@ -1616,17 +1616,17 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		count++;
 
 		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF))) {
-			netdev_err(bp->dev,
+			netdev_err(bp->netdev,
 				   "not whole frame pointed by descriptor\n");
-			bp->dev->stats.rx_dropped++;
+			bp->netdev->stats.rx_dropped++;
 			queue->stats.rx_dropped++;
 			break;
 		}
 		skb = queue->rx_skbuff[entry];
 		if (unlikely(!skb)) {
-			netdev_err(bp->dev,
+			netdev_err(bp->netdev,
 				   "inconsistent Rx descriptor chain\n");
-			bp->dev->stats.rx_dropped++;
+			bp->netdev->stats.rx_dropped++;
 			queue->stats.rx_dropped++;
 			break;
 		}
@@ -1634,28 +1634,28 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		queue->rx_skbuff[entry] = NULL;
 		len = ctrl & bp->rx_frm_len_mask;
 
-		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
+		netdev_vdbg(bp->netdev, "gem_rx %u (len %u)\n", entry, len);
 
 		skb_put(skb, len);
 		dma_unmap_single(&bp->pdev->dev, addr,
 				 bp->rx_buffer_size, DMA_FROM_DEVICE);
 
-		skb->protocol = eth_type_trans(skb, bp->dev);
+		skb->protocol = eth_type_trans(skb, bp->netdev);
 		skb_checksum_none_assert(skb);
-		if (bp->dev->features & NETIF_F_RXCSUM &&
-		    !(bp->dev->flags & IFF_PROMISC) &&
+		if (bp->netdev->features & NETIF_F_RXCSUM &&
+		    !(bp->netdev->flags & IFF_PROMISC) &&
 		    GEM_BFEXT(RX_CSUM, ctrl) & GEM_RX_CSUM_CHECKED_MASK)
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 
-		bp->dev->stats.rx_packets++;
+		bp->netdev->stats.rx_packets++;
 		queue->stats.rx_packets++;
-		bp->dev->stats.rx_bytes += skb->len;
+		bp->netdev->stats.rx_bytes += skb->len;
 		queue->stats.rx_bytes += skb->len;
 
 		gem_ptp_do_rxstamp(bp, skb, desc);
 
 #if defined(DEBUG) && defined(VERBOSE_DEBUG)
-		netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
+		netdev_vdbg(bp->netdev, "received skb of length %u, csum: %08x\n",
 			    skb->len, skb->csum);
 		print_hex_dump(KERN_DEBUG, " mac: ", DUMP_PREFIX_ADDRESS, 16, 1,
 			       skb_mac_header(skb), 16, true);
@@ -1684,9 +1684,9 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 	desc = macb_rx_desc(queue, last_frag);
 	len = desc->ctrl & bp->rx_frm_len_mask;
 
-	netdev_vdbg(bp->dev, "macb_rx_frame frags %u - %u (len %u)\n",
-		macb_rx_ring_wrap(bp, first_frag),
-		macb_rx_ring_wrap(bp, last_frag), len);
+	netdev_vdbg(bp->netdev, "macb_rx_frame frags %u - %u (len %u)\n",
+		    macb_rx_ring_wrap(bp, first_frag),
+		    macb_rx_ring_wrap(bp, last_frag), len);
 
 	/* The ethernet header starts NET_IP_ALIGN bytes into the
 	 * first buffer. Since the header is 14 bytes, this makes the
@@ -1696,9 +1696,9 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 	 * the two padding bytes into the skb so that we avoid hitting
 	 * the slowpath in memcpy(), and pull them off afterwards.
 	 */
-	skb = netdev_alloc_skb(bp->dev, len + NET_IP_ALIGN);
+	skb = netdev_alloc_skb(bp->netdev, len + NET_IP_ALIGN);
 	if (!skb) {
-		bp->dev->stats.rx_dropped++;
+		bp->netdev->stats.rx_dropped++;
 		for (frag = first_frag; ; frag++) {
 			desc = macb_rx_desc(queue, frag);
 			desc->addr &= ~MACB_BIT(RX_USED);
@@ -1742,11 +1742,11 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 	wmb();
 
 	__skb_pull(skb, NET_IP_ALIGN);
-	skb->protocol = eth_type_trans(skb, bp->dev);
+	skb->protocol = eth_type_trans(skb, bp->netdev);
 
-	bp->dev->stats.rx_packets++;
-	bp->dev->stats.rx_bytes += skb->len;
-	netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
+	bp->netdev->stats.rx_packets++;
+	bp->netdev->stats.rx_bytes += skb->len;
+	netdev_vdbg(bp->netdev, "received skb of length %u, csum: %08x\n",
 		    skb->len, skb->csum);
 	napi_gro_receive(napi, skb);
 
@@ -1826,7 +1826,7 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 		unsigned long flags;
 		u32 ctrl;
 
-		netdev_err(bp->dev, "RX queue corruption: reset it\n");
+		netdev_err(bp->netdev, "RX queue corruption: reset it\n");
 
 		spin_lock_irqsave(&bp->lock, flags);
 
@@ -1873,7 +1873,7 @@ static int macb_rx_poll(struct napi_struct *napi, int budget)
 
 	work_done = bp->macbgem_ops.mog_rx(queue, napi, budget);
 
-	netdev_vdbg(bp->dev, "RX poll: queue = %u, work_done = %d, budget = %d\n",
+	netdev_vdbg(bp->netdev, "RX poll: queue = %u, work_done = %d, budget = %d\n",
 		    (unsigned int)(queue - bp->queues), work_done, budget);
 
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
@@ -1892,7 +1892,7 @@ static int macb_rx_poll(struct napi_struct *napi, int budget)
 		if (macb_rx_pending(queue)) {
 			queue_writel(queue, IDR, bp->rx_intr_mask);
 			macb_queue_isr_clear(bp, queue, MACB_BIT(RCOMP));
-			netdev_vdbg(bp->dev, "poll: packets pending, reschedule\n");
+			netdev_vdbg(bp->netdev, "poll: packets pending, reschedule\n");
 			napi_schedule(napi);
 		}
 	}
@@ -1956,11 +1956,11 @@ static int macb_tx_poll(struct napi_struct *napi, int budget)
 	rmb(); // ensure txubr_pending is up to date
 	if (queue->txubr_pending) {
 		queue->txubr_pending = false;
-		netdev_vdbg(bp->dev, "poll: tx restart\n");
+		netdev_vdbg(bp->netdev, "poll: tx restart\n");
 		macb_tx_restart(queue);
 	}
 
-	netdev_vdbg(bp->dev, "TX poll: queue = %u, work_done = %d, budget = %d\n",
+	netdev_vdbg(bp->netdev, "TX poll: queue = %u, work_done = %d, budget = %d\n",
 		    (unsigned int)(queue - bp->queues), work_done, budget);
 
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
@@ -1979,7 +1979,7 @@ static int macb_tx_poll(struct napi_struct *napi, int budget)
 		if (macb_tx_complete_pending(queue)) {
 			queue_writel(queue, IDR, MACB_BIT(TCOMP));
 			macb_queue_isr_clear(bp, queue, MACB_BIT(TCOMP));
-			netdev_vdbg(bp->dev, "TX poll: packets pending, reschedule\n");
+			netdev_vdbg(bp->netdev, "TX poll: packets pending, reschedule\n");
 			napi_schedule(napi);
 		}
 	}
@@ -1990,7 +1990,7 @@ static int macb_tx_poll(struct napi_struct *napi, int budget)
 static void macb_hresp_error_task(struct work_struct *work)
 {
 	struct macb *bp = from_work(bp, work, hresp_err_bh_work);
-	struct net_device *dev = bp->dev;
+	struct net_device *netdev = bp->netdev;
 	struct macb_queue *queue;
 	unsigned int q;
 	u32 ctrl;
@@ -2004,8 +2004,8 @@ static void macb_hresp_error_task(struct work_struct *work)
 	ctrl &= ~(MACB_BIT(RE) | MACB_BIT(TE));
 	macb_writel(bp, NCR, ctrl);
 
-	netif_tx_stop_all_queues(dev);
-	netif_carrier_off(dev);
+	netif_tx_stop_all_queues(netdev);
+	netif_carrier_off(netdev);
 
 	bp->macbgem_ops.mog_init_rings(bp);
 
@@ -2022,8 +2022,8 @@ static void macb_hresp_error_task(struct work_struct *work)
 	ctrl |= MACB_BIT(RE) | MACB_BIT(TE);
 	macb_writel(bp, NCR, ctrl);
 
-	netif_carrier_on(dev);
-	netif_tx_start_all_queues(dev);
+	netif_carrier_on(netdev);
+	netif_tx_start_all_queues(netdev);
 }
 
 static void macb_wol_interrupt(struct macb_queue *queue, u32 status)
@@ -2032,7 +2032,7 @@ static void macb_wol_interrupt(struct macb_queue *queue, u32 status)
 
 	queue_writel(queue, IDR, MACB_BIT(WOL));
 	macb_writel(bp, WOL, 0);
-	netdev_vdbg(bp->dev, "MACB WoL: queue = %u, isr = 0x%08lx\n",
+	netdev_vdbg(bp->netdev, "MACB WoL: queue = %u, isr = 0x%08lx\n",
 		    (unsigned int)(queue - bp->queues),
 		    (unsigned long)status);
 	macb_queue_isr_clear(bp, queue, MACB_BIT(WOL));
@@ -2045,7 +2045,7 @@ static void gem_wol_interrupt(struct macb_queue *queue, u32 status)
 
 	queue_writel(queue, IDR, GEM_BIT(WOL));
 	gem_writel(bp, WOL, 0);
-	netdev_vdbg(bp->dev, "GEM WoL: queue = %u, isr = 0x%08lx\n",
+	netdev_vdbg(bp->netdev, "GEM WoL: queue = %u, isr = 0x%08lx\n",
 		    (unsigned int)(queue - bp->queues),
 		    (unsigned long)status);
 	macb_queue_isr_clear(bp, queue, GEM_BIT(WOL));
@@ -2055,10 +2055,10 @@ static void gem_wol_interrupt(struct macb_queue *queue, u32 status)
 static int macb_interrupt_misc(struct macb_queue *queue, u32 status)
 {
 	struct macb *bp = queue->bp;
-	struct net_device *dev;
+	struct net_device *netdev;
 	u32 ctrl;
 
-	dev = bp->dev;
+	netdev = bp->netdev;
 
 	if (unlikely(status & (MACB_TX_ERR_FLAGS))) {
 		queue_writel(queue, IDR, MACB_TX_INT_FLAGS);
@@ -2099,7 +2099,7 @@ static int macb_interrupt_misc(struct macb_queue *queue, u32 status)
 
 	if (status & MACB_BIT(HRESP)) {
 		queue_work(system_bh_wq, &bp->hresp_err_bh_work);
-		netdev_err(dev, "DMA bus error: HRESP not OK\n");
+		netdev_err(netdev, "DMA bus error: HRESP not OK\n");
 		macb_queue_isr_clear(bp, queue, MACB_BIT(HRESP));
 	}
 
@@ -2118,7 +2118,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 {
 	struct macb_queue *queue = dev_id;
 	struct macb *bp = queue->bp;
-	struct net_device *dev = bp->dev;
+	struct net_device *netdev = bp->netdev;
 	u32 status;
 
 	status = queue_readl(queue, ISR);
@@ -2130,13 +2130,13 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 
 	while (status) {
 		/* close possible race with dev_close */
-		if (unlikely(!netif_running(dev))) {
+		if (unlikely(!netif_running(netdev))) {
 			queue_writel(queue, IDR, -1);
 			macb_queue_isr_clear(bp, queue, -1);
 			break;
 		}
 
-		netdev_vdbg(bp->dev, "queue = %u, isr = 0x%08lx\n",
+		netdev_vdbg(netdev, "queue = %u, isr = 0x%08lx\n",
 			    (unsigned int)(queue - bp->queues),
 			    (unsigned long)status);
 
@@ -2181,16 +2181,16 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 /* Polling receive - used by netconsole and other diagnostic tools
  * to allow network i/o with interrupts disabled.
  */
-static void macb_poll_controller(struct net_device *dev)
+static void macb_poll_controller(struct net_device *netdev)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue;
 	unsigned long flags;
 	unsigned int q;
 
 	local_irq_save(flags);
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
-		macb_interrupt(dev->irq, queue);
+		macb_interrupt(netdev->irq, queue);
 	local_irq_restore(flags);
 }
 #endif
@@ -2277,7 +2277,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 
 	/* Should never happen */
 	if (unlikely(!tx_skb)) {
-		netdev_err(bp->dev, "BUG! empty skb!\n");
+		netdev_err(bp->netdev, "BUG! empty skb!\n");
 		return 0;
 	}
 
@@ -2328,7 +2328,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 		if (i == queue->tx_head) {
 			ctrl |= MACB_BF(TX_LSO, lso_ctrl);
 			ctrl |= MACB_BF(TX_TCP_SEQ_SRC, seq_ctrl);
-			if ((bp->dev->features & NETIF_F_HW_CSUM) &&
+			if ((bp->netdev->features & NETIF_F_HW_CSUM) &&
 			    skb->ip_summed != CHECKSUM_PARTIAL && !lso_ctrl &&
 			    !ptp_one_step_sync(skb))
 				ctrl |= MACB_BIT(TX_NOCRC);
@@ -2352,7 +2352,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 	return 0;
 
 dma_error:
-	netdev_err(bp->dev, "TX DMA map failed\n");
+	netdev_err(bp->netdev, "TX DMA map failed\n");
 
 	for (i = queue->tx_head; i != tx_head; i++) {
 		tx_skb = macb_tx_skb(queue, i);
@@ -2364,7 +2364,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 }
 
 static netdev_features_t macb_features_check(struct sk_buff *skb,
-					     struct net_device *dev,
+					     struct net_device *netdev,
 					     netdev_features_t features)
 {
 	unsigned int nr_frags, f;
@@ -2416,7 +2416,7 @@ static inline int macb_clear_csum(struct sk_buff *skb)
 	return 0;
 }
 
-static int macb_pad_and_fcs(struct sk_buff **skb, struct net_device *ndev)
+static int macb_pad_and_fcs(struct sk_buff **skb, struct net_device *netdev)
 {
 	bool cloned = skb_cloned(*skb) || skb_header_cloned(*skb) ||
 		      skb_is_nonlinear(*skb);
@@ -2425,7 +2425,7 @@ static int macb_pad_and_fcs(struct sk_buff **skb, struct net_device *ndev)
 	struct sk_buff *nskb;
 	u32 fcs;
 
-	if (!(ndev->features & NETIF_F_HW_CSUM) ||
+	if (!(netdev->features & NETIF_F_HW_CSUM) ||
 	    !((*skb)->ip_summed != CHECKSUM_PARTIAL) ||
 	    skb_shinfo(*skb)->gso_size || ptp_one_step_sync(*skb))
 		return 0;
@@ -2467,10 +2467,11 @@ static int macb_pad_and_fcs(struct sk_buff **skb, struct net_device *ndev)
 	return 0;
 }
 
-static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
+				   struct net_device *netdev)
 {
 	u16 queue_index = skb_get_queue_mapping(skb);
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue = &bp->queues[queue_index];
 	unsigned int desc_cnt, nr_frags, frag_size, f;
 	unsigned int hdrlen;
@@ -2483,7 +2484,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		return ret;
 	}
 
-	if (macb_pad_and_fcs(&skb, dev)) {
+	if (macb_pad_and_fcs(&skb, netdev)) {
 		dev_kfree_skb_any(skb);
 		return ret;
 	}
@@ -2502,7 +2503,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		else
 			hdrlen = skb_tcp_all_headers(skb);
 		if (skb_headlen(skb) < hdrlen) {
-			netdev_err(bp->dev, "Error - LSO headers fragmented!!!\n");
+			netdev_err(bp->netdev, "Error - LSO headers fragmented!!!\n");
 			/* if this is required, would need to copy to single buffer */
 			return NETDEV_TX_BUSY;
 		}
@@ -2510,7 +2511,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		hdrlen = umin(skb_headlen(skb), bp->max_tx_length);
 
 #if defined(DEBUG) && defined(VERBOSE_DEBUG)
-	netdev_vdbg(bp->dev,
+	netdev_vdbg(bp->netdev,
 		    "start_xmit: queue %hu len %u head %p data %p tail %p end %p\n",
 		    queue_index, skb->len, skb->head, skb->data,
 		    skb_tail_pointer(skb), skb_end_pointer(skb));
@@ -2538,8 +2539,8 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* This is a hard error, log it. */
 	if (CIRC_SPACE(queue->tx_head, queue->tx_tail,
 		       bp->tx_ring_size) < desc_cnt) {
-		netif_stop_subqueue(dev, queue_index);
-		netdev_dbg(bp->dev, "tx_head = %u, tx_tail = %u\n",
+		netif_stop_subqueue(netdev, queue_index);
+		netdev_dbg(netdev, "tx_head = %u, tx_tail = %u\n",
 			   queue->tx_head, queue->tx_tail);
 		ret = NETDEV_TX_BUSY;
 		goto unlock;
@@ -2554,7 +2555,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* Make newly initialized descriptor visible to hardware */
 	wmb();
 	skb_tx_timestamp(skb);
-	netdev_tx_sent_queue(netdev_get_tx_queue(bp->dev, queue_index),
+	netdev_tx_sent_queue(netdev_get_tx_queue(bp->netdev, queue_index),
 			     skb->len);
 
 	spin_lock(&bp->lock);
@@ -2563,7 +2564,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	spin_unlock(&bp->lock);
 
 	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
-		netif_stop_subqueue(dev, queue_index);
+		netif_stop_subqueue(netdev, queue_index);
 
 unlock:
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
@@ -2579,7 +2580,7 @@ static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
 		bp->rx_buffer_size = MIN(size, RX_BUFFER_MAX);
 
 		if (bp->rx_buffer_size % RX_BUFFER_MULTIPLE) {
-			netdev_dbg(bp->dev,
+			netdev_dbg(bp->netdev,
 				   "RX buffer must be multiple of %d bytes, expanding\n",
 				   RX_BUFFER_MULTIPLE);
 			bp->rx_buffer_size =
@@ -2587,8 +2588,8 @@ static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
 		}
 	}
 
-	netdev_dbg(bp->dev, "mtu [%u] rx_buffer_size [%zu]\n",
-		   bp->dev->mtu, bp->rx_buffer_size);
+	netdev_dbg(bp->netdev, "mtu [%u] rx_buffer_size [%zu]\n",
+		   bp->netdev->mtu, bp->rx_buffer_size);
 }
 
 static void gem_free_rx_buffers(struct macb *bp)
@@ -2687,7 +2688,7 @@ static int gem_alloc_rx_buffers(struct macb *bp)
 		if (!queue->rx_skbuff)
 			return -ENOMEM;
 		else
-			netdev_dbg(bp->dev,
+			netdev_dbg(bp->netdev,
 				   "Allocated %d RX struct sk_buff entries at %p\n",
 				   bp->rx_ring_size, queue->rx_skbuff);
 	}
@@ -2705,7 +2706,7 @@ static int macb_alloc_rx_buffers(struct macb *bp)
 	if (!queue->rx_buffers)
 		return -ENOMEM;
 
-	netdev_dbg(bp->dev,
+	netdev_dbg(bp->netdev,
 		   "Allocated RX buffers of %d bytes at %08lx (mapped %p)\n",
 		   size, (unsigned long)queue->rx_buffers_dma, queue->rx_buffers);
 	return 0;
@@ -2731,14 +2732,14 @@ static int macb_alloc_consistent(struct macb *bp)
 	tx = dma_alloc_coherent(dev, size, &tx_dma, GFP_KERNEL);
 	if (!tx || upper_32_bits(tx_dma) != upper_32_bits(tx_dma + size - 1))
 		goto out_err;
-	netdev_dbg(bp->dev, "Allocated %zu bytes for %u TX rings at %08lx (mapped %p)\n",
+	netdev_dbg(bp->netdev, "Allocated %zu bytes for %u TX rings at %08lx (mapped %p)\n",
 		   size, bp->num_queues, (unsigned long)tx_dma, tx);
 
 	size = bp->num_queues * macb_rx_ring_size_per_queue(bp);
 	rx = dma_alloc_coherent(dev, size, &rx_dma, GFP_KERNEL);
 	if (!rx || upper_32_bits(rx_dma) != upper_32_bits(rx_dma + size - 1))
 		goto out_err;
-	netdev_dbg(bp->dev, "Allocated %zu bytes for %u RX rings at %08lx (mapped %p)\n",
+	netdev_dbg(bp->netdev, "Allocated %zu bytes for %u RX rings at %08lx (mapped %p)\n",
 		   size, bp->num_queues, (unsigned long)rx_dma, rx);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -2966,7 +2967,7 @@ static void macb_configure_dma(struct macb *bp)
 		else
 			dmacfg |= GEM_BIT(ENDIA_DESC); /* CPU in big endian */
 
-		if (bp->dev->features & NETIF_F_HW_CSUM)
+		if (bp->netdev->features & NETIF_F_HW_CSUM)
 			dmacfg |= GEM_BIT(TXCOEN);
 		else
 			dmacfg &= ~GEM_BIT(TXCOEN);
@@ -2976,7 +2977,7 @@ static void macb_configure_dma(struct macb *bp)
 			dmacfg |= GEM_BIT(ADDR64);
 		if (macb_dma_ptp(bp))
 			dmacfg |= GEM_BIT(RXEXT) | GEM_BIT(TXEXT);
-		netdev_dbg(bp->dev, "Cadence configure DMA with 0x%08x\n",
+		netdev_dbg(bp->netdev, "Cadence configure DMA with 0x%08x\n",
 			   dmacfg);
 		gem_writel(bp, DMACFG, dmacfg);
 	}
@@ -3000,11 +3001,11 @@ static void macb_init_hw(struct macb *bp)
 		config |= MACB_BIT(JFRAME);	/* Enable jumbo frames */
 	else
 		config |= MACB_BIT(BIG);	/* Receive oversized frames */
-	if (bp->dev->flags & IFF_PROMISC)
+	if (bp->netdev->flags & IFF_PROMISC)
 		config |= MACB_BIT(CAF);	/* Copy All Frames */
-	else if (macb_is_gem(bp) && bp->dev->features & NETIF_F_RXCSUM)
+	else if (macb_is_gem(bp) && bp->netdev->features & NETIF_F_RXCSUM)
 		config |= GEM_BIT(RXCOEN);
-	if (!(bp->dev->flags & IFF_BROADCAST))
+	if (!(bp->netdev->flags & IFF_BROADCAST))
 		config |= MACB_BIT(NBC);	/* No BroadCast */
 	config |= macb_dbw(bp);
 	macb_writel(bp, NCFGR, config);
@@ -3078,17 +3079,17 @@ static int hash_get_index(__u8 *addr)
 }
 
 /* Add multicast addresses to the internal multicast-hash table. */
-static void macb_sethashtable(struct net_device *dev)
+static void macb_sethashtable(struct net_device *netdev)
 {
 	struct netdev_hw_addr *ha;
 	unsigned long mc_filter[2];
 	unsigned int bitnr;
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 
 	mc_filter[0] = 0;
 	mc_filter[1] = 0;
 
-	netdev_for_each_mc_addr(ha, dev) {
+	netdev_for_each_mc_addr(ha, netdev) {
 		bitnr = hash_get_index(ha->addr);
 		mc_filter[bitnr >> 5] |= 1 << (bitnr & 31);
 	}
@@ -3098,14 +3099,14 @@ static void macb_sethashtable(struct net_device *dev)
 }
 
 /* Enable/Disable promiscuous and multicast modes. */
-static void macb_set_rx_mode(struct net_device *dev)
+static void macb_set_rx_mode(struct net_device *netdev)
 {
 	unsigned long cfg;
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 
 	cfg = macb_readl(bp, NCFGR);
 
-	if (dev->flags & IFF_PROMISC) {
+	if (netdev->flags & IFF_PROMISC) {
 		/* Enable promiscuous mode */
 		cfg |= MACB_BIT(CAF);
 
@@ -3117,20 +3118,20 @@ static void macb_set_rx_mode(struct net_device *dev)
 		cfg &= ~MACB_BIT(CAF);
 
 		/* Enable RX checksum offload only if requested */
-		if (macb_is_gem(bp) && dev->features & NETIF_F_RXCSUM)
+		if (macb_is_gem(bp) && netdev->features & NETIF_F_RXCSUM)
 			cfg |= GEM_BIT(RXCOEN);
 	}
 
-	if (dev->flags & IFF_ALLMULTI) {
+	if (netdev->flags & IFF_ALLMULTI) {
 		/* Enable all multicast mode */
 		macb_or_gem_writel(bp, HRB, -1);
 		macb_or_gem_writel(bp, HRT, -1);
 		cfg |= MACB_BIT(NCFGR_MTI);
-	} else if (!netdev_mc_empty(dev)) {
+	} else if (!netdev_mc_empty(netdev)) {
 		/* Enable specific multicasts */
-		macb_sethashtable(dev);
+		macb_sethashtable(netdev);
 		cfg |= MACB_BIT(NCFGR_MTI);
-	} else if (dev->flags & (~IFF_ALLMULTI)) {
+	} else if (netdev->flags & (~IFF_ALLMULTI)) {
 		/* Disable all multicast mode */
 		macb_or_gem_writel(bp, HRB, 0);
 		macb_or_gem_writel(bp, HRT, 0);
@@ -3140,15 +3141,15 @@ static void macb_set_rx_mode(struct net_device *dev)
 	macb_writel(bp, NCFGR, cfg);
 }
 
-static int macb_open(struct net_device *dev)
+static int macb_open(struct net_device *netdev)
 {
-	size_t bufsz = dev->mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
-	struct macb *bp = netdev_priv(dev);
+	size_t bufsz = netdev->mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
+	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue;
 	unsigned int q;
 	int err;
 
-	netdev_dbg(bp->dev, "open\n");
+	netdev_dbg(bp->netdev, "open\n");
 
 	err = pm_runtime_resume_and_get(&bp->pdev->dev);
 	if (err < 0)
@@ -3159,7 +3160,7 @@ static int macb_open(struct net_device *dev)
 
 	err = macb_alloc_consistent(bp);
 	if (err) {
-		netdev_err(dev, "Unable to allocate DMA memory (error %d)\n",
+		netdev_err(netdev, "Unable to allocate DMA memory (error %d)\n",
 			   err);
 		goto pm_exit;
 	}
@@ -3186,10 +3187,10 @@ static int macb_open(struct net_device *dev)
 	if (err)
 		goto phy_off;
 
-	netif_tx_start_all_queues(dev);
+	netif_tx_start_all_queues(netdev);
 
 	if (bp->ptp_info)
-		bp->ptp_info->ptp_init(dev);
+		bp->ptp_info->ptp_init(netdev);
 
 	return 0;
 
@@ -3208,19 +3209,19 @@ static int macb_open(struct net_device *dev)
 	return err;
 }
 
-static int macb_close(struct net_device *dev)
+static int macb_close(struct net_device *netdev)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue;
 	unsigned long flags;
 	unsigned int q;
 
-	netif_tx_stop_all_queues(dev);
+	netif_tx_stop_all_queues(netdev);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		napi_disable(&queue->napi_rx);
 		napi_disable(&queue->napi_tx);
-		netdev_tx_reset_queue(netdev_get_tx_queue(dev, q));
+		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, q));
 	}
 
 	cancel_delayed_work_sync(&bp->tx_lpi_work);
@@ -3232,38 +3233,38 @@ static int macb_close(struct net_device *dev)
 
 	spin_lock_irqsave(&bp->lock, flags);
 	macb_reset_hw(bp);
-	netif_carrier_off(dev);
+	netif_carrier_off(netdev);
 	spin_unlock_irqrestore(&bp->lock, flags);
 
 	macb_free_consistent(bp);
 
 	if (bp->ptp_info)
-		bp->ptp_info->ptp_remove(dev);
+		bp->ptp_info->ptp_remove(netdev);
 
 	pm_runtime_put(&bp->pdev->dev);
 
 	return 0;
 }
 
-static int macb_change_mtu(struct net_device *dev, int new_mtu)
+static int macb_change_mtu(struct net_device *netdev, int new_mtu)
 {
-	if (netif_running(dev))
+	if (netif_running(netdev))
 		return -EBUSY;
 
-	WRITE_ONCE(dev->mtu, new_mtu);
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	return 0;
 }
 
-static int macb_set_mac_addr(struct net_device *dev, void *addr)
+static int macb_set_mac_addr(struct net_device *netdev, void *addr)
 {
 	int err;
 
-	err = eth_mac_addr(dev, addr);
+	err = eth_mac_addr(netdev, addr);
 	if (err < 0)
 		return err;
 
-	macb_set_hwaddr(netdev_priv(dev));
+	macb_set_hwaddr(netdev_priv(netdev));
 	return 0;
 }
 
@@ -3301,7 +3302,7 @@ static void gem_get_stats(struct macb *bp, struct rtnl_link_stats64 *nstat)
 	struct gem_stats *hwstat = &bp->hw_stats.gem;
 
 	spin_lock_irq(&bp->stats_lock);
-	if (netif_running(bp->dev))
+	if (netif_running(bp->netdev))
 		gem_update_stats(bp);
 
 	nstat->rx_errors = (hwstat->rx_frame_check_sequence_errors +
@@ -3334,10 +3335,10 @@ static void gem_get_stats(struct macb *bp, struct rtnl_link_stats64 *nstat)
 	spin_unlock_irq(&bp->stats_lock);
 }
 
-static void gem_get_ethtool_stats(struct net_device *dev,
+static void gem_get_ethtool_stats(struct net_device *netdev,
 				  struct ethtool_stats *stats, u64 *data)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 
 	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
@@ -3346,9 +3347,9 @@ static void gem_get_ethtool_stats(struct net_device *dev,
 	spin_unlock_irq(&bp->stats_lock);
 }
 
-static int gem_get_sset_count(struct net_device *dev, int sset)
+static int gem_get_sset_count(struct net_device *netdev, int sset)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 
 	switch (sset) {
 	case ETH_SS_STATS:
@@ -3358,9 +3359,9 @@ static int gem_get_sset_count(struct net_device *dev, int sset)
 	}
 }
 
-static void gem_get_ethtool_strings(struct net_device *dev, u32 sset, u8 *p)
+static void gem_get_ethtool_strings(struct net_device *netdev, u32 sset, u8 *p)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue;
 	unsigned int i;
 	unsigned int q;
@@ -3379,13 +3380,13 @@ static void gem_get_ethtool_strings(struct net_device *dev, u32 sset, u8 *p)
 	}
 }
 
-static void macb_get_stats(struct net_device *dev,
+static void macb_get_stats(struct net_device *netdev,
 			   struct rtnl_link_stats64 *nstat)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 	struct macb_stats *hwstat = &bp->hw_stats.macb;
 
-	netdev_stats_to_stats64(nstat, &bp->dev->stats);
+	netdev_stats_to_stats64(nstat, &bp->netdev->stats);
 	if (macb_is_gem(bp)) {
 		gem_get_stats(bp, nstat);
 		return;
@@ -3429,10 +3430,10 @@ static void macb_get_stats(struct net_device *dev,
 	spin_unlock_irq(&bp->stats_lock);
 }
 
-static void macb_get_pause_stats(struct net_device *dev,
+static void macb_get_pause_stats(struct net_device *netdev,
 				 struct ethtool_pause_stats *pause_stats)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 	struct macb_stats *hwstat = &bp->hw_stats.macb;
 
 	spin_lock_irq(&bp->stats_lock);
@@ -3442,10 +3443,10 @@ static void macb_get_pause_stats(struct net_device *dev,
 	spin_unlock_irq(&bp->stats_lock);
 }
 
-static void gem_get_pause_stats(struct net_device *dev,
+static void gem_get_pause_stats(struct net_device *netdev,
 				struct ethtool_pause_stats *pause_stats)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 	struct gem_stats *hwstat = &bp->hw_stats.gem;
 
 	spin_lock_irq(&bp->stats_lock);
@@ -3455,10 +3456,10 @@ static void gem_get_pause_stats(struct net_device *dev,
 	spin_unlock_irq(&bp->stats_lock);
 }
 
-static void macb_get_eth_mac_stats(struct net_device *dev,
+static void macb_get_eth_mac_stats(struct net_device *netdev,
 				   struct ethtool_eth_mac_stats *mac_stats)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 	struct macb_stats *hwstat = &bp->hw_stats.macb;
 
 	spin_lock_irq(&bp->stats_lock);
@@ -3480,10 +3481,10 @@ static void macb_get_eth_mac_stats(struct net_device *dev,
 	spin_unlock_irq(&bp->stats_lock);
 }
 
-static void gem_get_eth_mac_stats(struct net_device *dev,
+static void gem_get_eth_mac_stats(struct net_device *netdev,
 				  struct ethtool_eth_mac_stats *mac_stats)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 	struct gem_stats *hwstat = &bp->hw_stats.gem;
 
 	spin_lock_irq(&bp->stats_lock);
@@ -3513,10 +3514,10 @@ static void gem_get_eth_mac_stats(struct net_device *dev,
 }
 
 /* TODO: Report SQE test errors when added to phy_stats */
-static void macb_get_eth_phy_stats(struct net_device *dev,
+static void macb_get_eth_phy_stats(struct net_device *netdev,
 				   struct ethtool_eth_phy_stats *phy_stats)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 	struct macb_stats *hwstat = &bp->hw_stats.macb;
 
 	spin_lock_irq(&bp->stats_lock);
@@ -3525,10 +3526,10 @@ static void macb_get_eth_phy_stats(struct net_device *dev,
 	spin_unlock_irq(&bp->stats_lock);
 }
 
-static void gem_get_eth_phy_stats(struct net_device *dev,
+static void gem_get_eth_phy_stats(struct net_device *netdev,
 				  struct ethtool_eth_phy_stats *phy_stats)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 	struct gem_stats *hwstat = &bp->hw_stats.gem;
 
 	spin_lock_irq(&bp->stats_lock);
@@ -3537,11 +3538,11 @@ static void gem_get_eth_phy_stats(struct net_device *dev,
 	spin_unlock_irq(&bp->stats_lock);
 }
 
-static void macb_get_rmon_stats(struct net_device *dev,
+static void macb_get_rmon_stats(struct net_device *netdev,
 				struct ethtool_rmon_stats *rmon_stats,
 				const struct ethtool_rmon_hist_range **ranges)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 	struct macb_stats *hwstat = &bp->hw_stats.macb;
 
 	spin_lock_irq(&bp->stats_lock);
@@ -3563,11 +3564,11 @@ static const struct ethtool_rmon_hist_range gem_rmon_ranges[] = {
 	{ },
 };
 
-static void gem_get_rmon_stats(struct net_device *dev,
+static void gem_get_rmon_stats(struct net_device *netdev,
 			       struct ethtool_rmon_stats *rmon_stats,
 			       const struct ethtool_rmon_hist_range **ranges)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 	struct gem_stats *hwstat = &bp->hw_stats.gem;
 
 	spin_lock_irq(&bp->stats_lock);
@@ -3598,10 +3599,10 @@ static int macb_get_regs_len(struct net_device *netdev)
 	return MACB_GREGS_NBR * sizeof(u32);
 }
 
-static void macb_get_regs(struct net_device *dev, struct ethtool_regs *regs,
+static void macb_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 			  void *p)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 	unsigned int tail, head;
 	u32 *regs_buff = p;
 
@@ -3718,16 +3719,16 @@ static int macb_set_ringparam(struct net_device *netdev,
 		return 0;
 	}
 
-	if (netif_running(bp->dev)) {
+	if (netif_running(bp->netdev)) {
 		reset = 1;
-		macb_close(bp->dev);
+		macb_close(bp->netdev);
 	}
 
 	bp->rx_ring_size = new_rx_size;
 	bp->tx_ring_size = new_tx_size;
 
 	if (reset)
-		macb_open(bp->dev);
+		macb_open(bp->netdev);
 
 	return 0;
 }
@@ -3754,13 +3755,13 @@ static s32 gem_get_ptp_max_adj(void)
 	return 64000000;
 }
 
-static int gem_get_ts_info(struct net_device *dev,
+static int gem_get_ts_info(struct net_device *netdev,
 			   struct kernel_ethtool_ts_info *info)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 
 	if (!macb_dma_ptp(bp)) {
-		ethtool_op_get_ts_info(dev, info);
+		ethtool_op_get_ts_info(netdev, info);
 		return 0;
 	}
 
@@ -3807,7 +3808,7 @@ static int macb_get_ts_info(struct net_device *netdev,
 
 static void gem_enable_flow_filters(struct macb *bp, bool enable)
 {
-	struct net_device *netdev = bp->dev;
+	struct net_device *netdev = bp->netdev;
 	struct ethtool_rx_fs_item *item;
 	u32 t2_scr;
 	int num_t2_scr;
@@ -4137,16 +4138,16 @@ static const struct ethtool_ops macb_ethtool_ops = {
 	.set_ringparam		= macb_set_ringparam,
 };
 
-static int macb_get_eee(struct net_device *dev, struct ethtool_keee *eee)
+static int macb_get_eee(struct net_device *netdev, struct ethtool_keee *eee)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 
 	return phylink_ethtool_get_eee(bp->phylink, eee);
 }
 
-static int macb_set_eee(struct net_device *dev, struct ethtool_keee *eee)
+static int macb_set_eee(struct net_device *netdev, struct ethtool_keee *eee)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 
 	return phylink_ethtool_set_eee(bp->phylink, eee);
 }
@@ -4177,43 +4178,43 @@ static const struct ethtool_ops gem_ethtool_ops = {
 	.set_eee		= macb_set_eee,
 };
 
-static int macb_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+static int macb_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 
-	if (!netif_running(dev))
+	if (!netif_running(netdev))
 		return -EINVAL;
 
 	return phylink_mii_ioctl(bp->phylink, rq, cmd);
 }
 
-static int macb_hwtstamp_get(struct net_device *dev,
+static int macb_hwtstamp_get(struct net_device *netdev,
 			     struct kernel_hwtstamp_config *cfg)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 
-	if (!netif_running(dev))
+	if (!netif_running(netdev))
 		return -EINVAL;
 
 	if (!bp->ptp_info)
 		return -EOPNOTSUPP;
 
-	return bp->ptp_info->get_hwtst(dev, cfg);
+	return bp->ptp_info->get_hwtst(netdev, cfg);
 }
 
-static int macb_hwtstamp_set(struct net_device *dev,
+static int macb_hwtstamp_set(struct net_device *netdev,
 			     struct kernel_hwtstamp_config *cfg,
 			     struct netlink_ext_ack *extack)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 
-	if (!netif_running(dev))
+	if (!netif_running(netdev))
 		return -EINVAL;
 
 	if (!bp->ptp_info)
 		return -EOPNOTSUPP;
 
-	return bp->ptp_info->set_hwtst(dev, cfg, extack);
+	return bp->ptp_info->set_hwtst(netdev, cfg, extack);
 }
 
 static inline void macb_set_txcsum_feature(struct macb *bp,
@@ -4236,7 +4237,7 @@ static inline void macb_set_txcsum_feature(struct macb *bp,
 static inline void macb_set_rxcsum_feature(struct macb *bp,
 					   netdev_features_t features)
 {
-	struct net_device *netdev = bp->dev;
+	struct net_device *netdev = bp->netdev;
 	u32 val;
 
 	if (!macb_is_gem(bp))
@@ -4283,7 +4284,7 @@ static int macb_set_features(struct net_device *netdev,
 
 static void macb_restore_features(struct macb *bp)
 {
-	struct net_device *netdev = bp->dev;
+	struct net_device *netdev = bp->netdev;
 	netdev_features_t features = netdev->features;
 	struct ethtool_rx_fs_item *item;
 
@@ -4300,14 +4301,14 @@ static void macb_restore_features(struct macb *bp)
 	macb_set_rxflow_feature(bp, features);
 }
 
-static int macb_taprio_setup_replace(struct net_device *ndev,
+static int macb_taprio_setup_replace(struct net_device *netdev,
 				     struct tc_taprio_qopt_offload *conf)
 {
 	u64 total_on_time = 0, start_time_sec = 0, start_time = conf->base_time;
 	u32 configured_queues = 0, speed = 0, start_time_nsec;
 	struct macb_queue_enst_config *enst_queue;
 	struct tc_taprio_sched_entry *entry;
-	struct macb *bp = netdev_priv(ndev);
+	struct macb *bp = netdev_priv(netdev);
 	struct ethtool_link_ksettings kset;
 	struct macb_queue *queue;
 	u32 queue_mask;
@@ -4316,13 +4317,13 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 	int err;
 
 	if (conf->num_entries > bp->num_queues) {
-		netdev_err(ndev, "Too many TAPRIO entries: %zu > %d queues\n",
+		netdev_err(netdev, "Too many TAPRIO entries: %zu > %d queues\n",
 			   conf->num_entries, bp->num_queues);
 		return -EINVAL;
 	}
 
 	if (conf->base_time < 0) {
-		netdev_err(ndev, "Invalid base_time: must be 0 or positive, got %lld\n",
+		netdev_err(netdev, "Invalid base_time: must be 0 or positive, got %lld\n",
 			   conf->base_time);
 		return -ERANGE;
 	}
@@ -4330,13 +4331,13 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 	/* Get the current link speed */
 	err = phylink_ethtool_ksettings_get(bp->phylink, &kset);
 	if (unlikely(err)) {
-		netdev_err(ndev, "Failed to get link settings: %d\n", err);
+		netdev_err(netdev, "Failed to get link settings: %d\n", err);
 		return err;
 	}
 
 	speed = kset.base.speed;
 	if (unlikely(speed <= 0)) {
-		netdev_err(ndev, "Invalid speed: %d\n", speed);
+		netdev_err(netdev, "Invalid speed: %d\n", speed);
 		return -EINVAL;
 	}
 
@@ -4349,7 +4350,7 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 		entry = &conf->entries[i];
 
 		if (entry->command != TC_TAPRIO_CMD_SET_GATES) {
-			netdev_err(ndev, "Entry %zu: unsupported command %d\n",
+			netdev_err(netdev, "Entry %zu: unsupported command %d\n",
 				   i, entry->command);
 			err = -EOPNOTSUPP;
 			goto cleanup;
@@ -4357,7 +4358,7 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 
 		/* Validate gate_mask: must be nonzero, single queue, and within range */
 		if (!is_power_of_2(entry->gate_mask)) {
-			netdev_err(ndev, "Entry %zu: gate_mask 0x%x is not a power of 2 (only one queue per entry allowed)\n",
+			netdev_err(netdev, "Entry %zu: gate_mask 0x%x is not a power of 2 (only one queue per entry allowed)\n",
 				   i, entry->gate_mask);
 			err = -EINVAL;
 			goto cleanup;
@@ -4366,7 +4367,7 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 		/* gate_mask must not select queues outside the valid queues */
 		queue_id = order_base_2(entry->gate_mask);
 		if (queue_id >= bp->num_queues) {
-			netdev_err(ndev, "Entry %zu: gate_mask 0x%x exceeds queue range (max_queues=%d)\n",
+			netdev_err(netdev, "Entry %zu: gate_mask 0x%x exceeds queue range (max_queues=%d)\n",
 				   i, entry->gate_mask, bp->num_queues);
 			err = -EINVAL;
 			goto cleanup;
@@ -4376,7 +4377,7 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 		start_time_sec = start_time;
 		start_time_nsec = do_div(start_time_sec, NSEC_PER_SEC);
 		if (start_time_sec > GENMASK(GEM_START_TIME_SEC_SIZE - 1, 0)) {
-			netdev_err(ndev, "Entry %zu: Start time %llu s exceeds hardware limit\n",
+			netdev_err(netdev, "Entry %zu: Start time %llu s exceeds hardware limit\n",
 				   i, start_time_sec);
 			err = -ERANGE;
 			goto cleanup;
@@ -4384,7 +4385,7 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 
 		/* Check for on time limit */
 		if (entry->interval > enst_max_hw_interval(speed)) {
-			netdev_err(ndev, "Entry %zu: interval %u ns exceeds hardware limit %llu ns\n",
+			netdev_err(netdev, "Entry %zu: interval %u ns exceeds hardware limit %llu ns\n",
 				   i, entry->interval, enst_max_hw_interval(speed));
 			err = -ERANGE;
 			goto cleanup;
@@ -4392,7 +4393,7 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 
 		/* Check for off time limit*/
 		if ((conf->cycle_time - entry->interval) > enst_max_hw_interval(speed)) {
-			netdev_err(ndev, "Entry %zu: off_time %llu ns exceeds hardware limit %llu ns\n",
+			netdev_err(netdev, "Entry %zu: off_time %llu ns exceeds hardware limit %llu ns\n",
 				   i, conf->cycle_time - entry->interval,
 				   enst_max_hw_interval(speed));
 			err = -ERANGE;
@@ -4415,13 +4416,13 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 
 	/* Check total interval doesn't exceed cycle time */
 	if (total_on_time > conf->cycle_time) {
-		netdev_err(ndev, "Total ON %llu ns exceeds cycle time %llu ns\n",
+		netdev_err(netdev, "Total ON %llu ns exceeds cycle time %llu ns\n",
 			   total_on_time, conf->cycle_time);
 		err = -EINVAL;
 		goto cleanup;
 	}
 
-	netdev_dbg(ndev, "TAPRIO setup: %zu entries, base_time=%lld ns, cycle_time=%llu ns\n",
+	netdev_dbg(netdev, "TAPRIO setup: %zu entries, base_time=%lld ns, cycle_time=%llu ns\n",
 		   conf->num_entries, conf->base_time, conf->cycle_time);
 
 	/* All validations passed - proceed with hardware configuration */
@@ -4446,7 +4447,7 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 		gem_writel(bp, ENST_CONTROL, configured_queues);
 	}
 
-	netdev_info(ndev, "TAPRIO configuration completed successfully: %zu entries, %d queues configured\n",
+	netdev_info(netdev, "TAPRIO configuration completed successfully: %zu entries, %d queues configured\n",
 		    conf->num_entries, hweight32(configured_queues));
 
 cleanup:
@@ -4454,14 +4455,14 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 	return err;
 }
 
-static void macb_taprio_destroy(struct net_device *ndev)
+static void macb_taprio_destroy(struct net_device *netdev)
 {
-	struct macb *bp = netdev_priv(ndev);
+	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue;
 	u32 queue_mask;
 	unsigned int q;
 
-	netdev_reset_tc(ndev);
+	netdev_reset_tc(netdev);
 	queue_mask = BIT_U32(bp->num_queues) - 1;
 
 	scoped_guard(spinlock_irqsave, &bp->lock) {
@@ -4476,30 +4477,30 @@ static void macb_taprio_destroy(struct net_device *ndev)
 			queue_writel(queue, ENST_OFF_TIME, 0);
 		}
 	}
-	netdev_info(ndev, "TAPRIO destroy: All gates disabled\n");
+	netdev_info(netdev, "TAPRIO destroy: All gates disabled\n");
 }
 
-static int macb_setup_taprio(struct net_device *ndev,
+static int macb_setup_taprio(struct net_device *netdev,
 			     struct tc_taprio_qopt_offload *taprio)
 {
-	struct macb *bp = netdev_priv(ndev);
+	struct macb *bp = netdev_priv(netdev);
 	int err = 0;
 
-	if (unlikely(!(ndev->hw_features & NETIF_F_HW_TC)))
+	if (unlikely(!(netdev->hw_features & NETIF_F_HW_TC)))
 		return -EOPNOTSUPP;
 
 	/* Check if Device is in runtime suspend */
 	if (unlikely(pm_runtime_suspended(&bp->pdev->dev))) {
-		netdev_err(ndev, "Device is in runtime suspend\n");
+		netdev_err(netdev, "Device is in runtime suspend\n");
 		return -EOPNOTSUPP;
 	}
 
 	switch (taprio->cmd) {
 	case TAPRIO_CMD_REPLACE:
-		err = macb_taprio_setup_replace(ndev, taprio);
+		err = macb_taprio_setup_replace(netdev, taprio);
 		break;
 	case TAPRIO_CMD_DESTROY:
-		macb_taprio_destroy(ndev);
+		macb_taprio_destroy(netdev);
 		break;
 	default:
 		err = -EOPNOTSUPP;
@@ -4508,15 +4509,15 @@ static int macb_setup_taprio(struct net_device *ndev,
 	return err;
 }
 
-static int macb_setup_tc(struct net_device *dev, enum tc_setup_type type,
+static int macb_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 			 void *type_data)
 {
-	if (!dev || !type_data)
+	if (!netdev || !type_data)
 		return -EINVAL;
 
 	switch (type) {
 	case TC_SETUP_QDISC_TAPRIO:
-		return macb_setup_taprio(dev, type_data);
+		return macb_setup_taprio(netdev, type_data);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -4724,9 +4725,9 @@ static int macb_clk_init(struct platform_device *pdev, struct clk **pclk,
 
 static int macb_init_dflt(struct platform_device *pdev)
 {
-	struct net_device *dev = platform_get_drvdata(pdev);
+	struct net_device *netdev = platform_get_drvdata(pdev);
 	unsigned int hw_q, q;
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue;
 	int err;
 	u32 val, reg;
@@ -4742,8 +4743,8 @@ static int macb_init_dflt(struct platform_device *pdev)
 		queue = &bp->queues[q];
 		queue->bp = bp;
 		spin_lock_init(&queue->tx_ptr_lock);
-		netif_napi_add(dev, &queue->napi_rx, macb_rx_poll);
-		netif_napi_add_tx(dev, &queue->napi_tx, macb_tx_poll);
+		netif_napi_add(netdev, &queue->napi_rx, macb_rx_poll);
+		netif_napi_add_tx(netdev, &queue->napi_tx, macb_tx_poll);
 		if (hw_q) {
 			queue->ISR  = GEM_ISR(hw_q - 1);
 			queue->IER  = GEM_IER(hw_q - 1);
@@ -4773,7 +4774,7 @@ static int macb_init_dflt(struct platform_device *pdev)
 		 */
 		queue->irq = platform_get_irq(pdev, q);
 		err = devm_request_irq(&pdev->dev, queue->irq, macb_interrupt,
-				       IRQF_SHARED, dev->name, queue);
+				       IRQF_SHARED, netdev->name, queue);
 		if (err) {
 			dev_err(&pdev->dev,
 				"Unable to request IRQ %d (error %d)\n",
@@ -4785,7 +4786,7 @@ static int macb_init_dflt(struct platform_device *pdev)
 		q++;
 	}
 
-	dev->netdev_ops = &macb_netdev_ops;
+	netdev->netdev_ops = &macb_netdev_ops;
 
 	/* setup appropriated routines according to adapter type */
 	if (macb_is_gem(bp)) {
@@ -4793,39 +4794,39 @@ static int macb_init_dflt(struct platform_device *pdev)
 		bp->macbgem_ops.mog_free_rx_buffers = gem_free_rx_buffers;
 		bp->macbgem_ops.mog_init_rings = gem_init_rings;
 		bp->macbgem_ops.mog_rx = gem_rx;
-		dev->ethtool_ops = &gem_ethtool_ops;
+		netdev->ethtool_ops = &gem_ethtool_ops;
 	} else {
 		bp->macbgem_ops.mog_alloc_rx_buffers = macb_alloc_rx_buffers;
 		bp->macbgem_ops.mog_free_rx_buffers = macb_free_rx_buffers;
 		bp->macbgem_ops.mog_init_rings = macb_init_rings;
 		bp->macbgem_ops.mog_rx = macb_rx;
-		dev->ethtool_ops = &macb_ethtool_ops;
+		netdev->ethtool_ops = &macb_ethtool_ops;
 	}
 
-	netdev_sw_irq_coalesce_default_on(dev);
+	netdev_sw_irq_coalesce_default_on(netdev);
 
-	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
 	/* Set features */
-	dev->hw_features = NETIF_F_SG;
+	netdev->hw_features = NETIF_F_SG;
 
 	/* Check LSO capability; runtime detection can be overridden by a cap
 	 * flag if the hardware is known to be buggy
 	 */
 	if (!(bp->caps & MACB_CAPS_NO_LSO) &&
 	    GEM_BFEXT(PBUF_LSO, gem_readl(bp, DCFG6)))
-		dev->hw_features |= MACB_NETIF_LSO;
+		netdev->hw_features |= MACB_NETIF_LSO;
 
 	/* Checksum offload is only available on gem with packet buffer */
 	if (macb_is_gem(bp) && !(bp->caps & MACB_CAPS_FIFO_MODE))
-		dev->hw_features |= NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
+		netdev->hw_features |= NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
 	if (bp->caps & MACB_CAPS_SG_DISABLED)
-		dev->hw_features &= ~NETIF_F_SG;
+		netdev->hw_features &= ~NETIF_F_SG;
 	/* Enable HW_TC if hardware supports QBV */
 	if (bp->caps & MACB_CAPS_QBV)
-		dev->hw_features |= NETIF_F_HW_TC;
+		netdev->hw_features |= NETIF_F_HW_TC;
 
-	dev->features = dev->hw_features;
+	netdev->features = netdev->hw_features;
 
 	/* Check RX Flow Filters support.
 	 * Max Rx flows set by availability of screeners & compare regs:
@@ -4843,7 +4844,7 @@ static int macb_init_dflt(struct platform_device *pdev)
 			reg = GEM_BFINS(ETHTCMP, (uint16_t)ETH_P_IP, reg);
 			gem_writel_n(bp, ETHT, SCRT2_ETHT, reg);
 			/* Filtering is supported in hw but don't enable it in kernel now */
-			dev->hw_features |= NETIF_F_NTUPLE;
+			netdev->hw_features |= NETIF_F_NTUPLE;
 			/* init Rx flow definitions */
 			bp->rx_fs_list.count = 0;
 			spin_lock_init(&bp->rx_fs_lock);
@@ -5053,9 +5054,9 @@ static void at91ether_stop(struct macb *lp)
 }
 
 /* Open the ethernet interface */
-static int at91ether_open(struct net_device *dev)
+static int at91ether_open(struct net_device *netdev)
 {
-	struct macb *lp = netdev_priv(dev);
+	struct macb *lp = netdev_priv(netdev);
 	u32 ctl;
 	int ret;
 
@@ -5077,7 +5078,7 @@ static int at91ether_open(struct net_device *dev)
 	if (ret)
 		goto stop;
 
-	netif_start_queue(dev);
+	netif_start_queue(netdev);
 
 	return 0;
 
@@ -5089,11 +5090,11 @@ static int at91ether_open(struct net_device *dev)
 }
 
 /* Close the interface */
-static int at91ether_close(struct net_device *dev)
+static int at91ether_close(struct net_device *netdev)
 {
-	struct macb *lp = netdev_priv(dev);
+	struct macb *lp = netdev_priv(netdev);
 
-	netif_stop_queue(dev);
+	netif_stop_queue(netdev);
 
 	phylink_stop(lp->phylink);
 	phylink_disconnect_phy(lp->phylink);
@@ -5107,14 +5108,14 @@ static int at91ether_close(struct net_device *dev)
 
 /* Transmit packet */
 static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
-					struct net_device *dev)
+					struct net_device *netdev)
 {
-	struct macb *lp = netdev_priv(dev);
+	struct macb *lp = netdev_priv(netdev);
 
 	if (macb_readl(lp, TSR) & MACB_BIT(RM9200_BNQ)) {
 		int desc = 0;
 
-		netif_stop_queue(dev);
+		netif_stop_queue(netdev);
 
 		/* Store packet information (to free when Tx completed) */
 		lp->rm9200_txq[desc].skb = skb;
@@ -5123,8 +5124,8 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
 							      skb->len, DMA_TO_DEVICE);
 		if (dma_mapping_error(&lp->pdev->dev, lp->rm9200_txq[desc].mapping)) {
 			dev_kfree_skb_any(skb);
-			dev->stats.tx_dropped++;
-			netdev_err(dev, "%s: DMA mapping error\n", __func__);
+			netdev->stats.tx_dropped++;
+			netdev_err(netdev, "%s: DMA mapping error\n", __func__);
 			return NETDEV_TX_OK;
 		}
 
@@ -5134,7 +5135,8 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
 		macb_writel(lp, TCR, skb->len);
 
 	} else {
-		netdev_err(dev, "%s called, but device is busy!\n", __func__);
+		netdev_err(netdev, "%s called, but device is busy!\n",
+			   __func__);
 		return NETDEV_TX_BUSY;
 	}
 
@@ -5144,9 +5146,9 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
 /* Extract received frame from buffer descriptors and sent to upper layers.
  * (Called from interrupt context)
  */
-static void at91ether_rx(struct net_device *dev)
+static void at91ether_rx(struct net_device *netdev)
 {
-	struct macb *lp = netdev_priv(dev);
+	struct macb *lp = netdev_priv(netdev);
 	struct macb_queue *q = &lp->queues[0];
 	struct macb_dma_desc *desc;
 	unsigned char *p_recv;
@@ -5157,21 +5159,21 @@ static void at91ether_rx(struct net_device *dev)
 	while (desc->addr & MACB_BIT(RX_USED)) {
 		p_recv = q->rx_buffers + q->rx_tail * AT91ETHER_MAX_RBUFF_SZ;
 		pktlen = MACB_BF(RX_FRMLEN, desc->ctrl);
-		skb = netdev_alloc_skb(dev, pktlen + 2);
+		skb = netdev_alloc_skb(netdev, pktlen + 2);
 		if (skb) {
 			skb_reserve(skb, 2);
 			skb_put_data(skb, p_recv, pktlen);
 
-			skb->protocol = eth_type_trans(skb, dev);
-			dev->stats.rx_packets++;
-			dev->stats.rx_bytes += pktlen;
+			skb->protocol = eth_type_trans(skb, netdev);
+			netdev->stats.rx_packets++;
+			netdev->stats.rx_bytes += pktlen;
 			netif_rx(skb);
 		} else {
-			dev->stats.rx_dropped++;
+			netdev->stats.rx_dropped++;
 		}
 
 		if (desc->ctrl & MACB_BIT(RX_MHASH_MATCH))
-			dev->stats.multicast++;
+			netdev->stats.multicast++;
 
 		/* reset ownership bit */
 		desc->addr &= ~MACB_BIT(RX_USED);
@@ -5189,8 +5191,8 @@ static void at91ether_rx(struct net_device *dev)
 /* MAC interrupt handler */
 static irqreturn_t at91ether_interrupt(int irq, void *dev_id)
 {
-	struct net_device *dev = dev_id;
-	struct macb *lp = netdev_priv(dev);
+	struct net_device *netdev = dev_id;
+	struct macb *lp = netdev_priv(netdev);
 	u32 intstatus, ctl;
 	unsigned int desc;
 
@@ -5201,13 +5203,13 @@ static irqreturn_t at91ether_interrupt(int irq, void *dev_id)
 
 	/* Receive complete */
 	if (intstatus & MACB_BIT(RCOMP))
-		at91ether_rx(dev);
+		at91ether_rx(netdev);
 
 	/* Transmit complete */
 	if (intstatus & MACB_BIT(TCOMP)) {
 		/* The TCOM bit is set even if the transmission failed */
 		if (intstatus & (MACB_BIT(ISR_TUND) | MACB_BIT(ISR_RLE)))
-			dev->stats.tx_errors++;
+			netdev->stats.tx_errors++;
 
 		desc = 0;
 		if (lp->rm9200_txq[desc].skb) {
@@ -5215,10 +5217,10 @@ static irqreturn_t at91ether_interrupt(int irq, void *dev_id)
 			lp->rm9200_txq[desc].skb = NULL;
 			dma_unmap_single(&lp->pdev->dev, lp->rm9200_txq[desc].mapping,
 					 lp->rm9200_txq[desc].size, DMA_TO_DEVICE);
-			dev->stats.tx_packets++;
-			dev->stats.tx_bytes += lp->rm9200_txq[desc].size;
+			netdev->stats.tx_packets++;
+			netdev->stats.tx_bytes += lp->rm9200_txq[desc].size;
 		}
-		netif_wake_queue(dev);
+		netif_wake_queue(netdev);
 	}
 
 	/* Work-around for EMAC Errata section 41.3.1 */
@@ -5230,18 +5232,18 @@ static irqreturn_t at91ether_interrupt(int irq, void *dev_id)
 	}
 
 	if (intstatus & MACB_BIT(ISR_ROVR))
-		netdev_err(dev, "ROVR error\n");
+		netdev_err(netdev, "ROVR error\n");
 
 	return IRQ_HANDLED;
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
-static void at91ether_poll_controller(struct net_device *dev)
+static void at91ether_poll_controller(struct net_device *netdev)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
-	at91ether_interrupt(dev->irq, dev);
+	at91ether_interrupt(netdev->irq, netdev);
 	local_irq_restore(flags);
 }
 #endif
@@ -5288,17 +5290,17 @@ static int at91ether_clk_init(struct platform_device *pdev, struct clk **pclk,
 
 static int at91ether_init(struct platform_device *pdev)
 {
-	struct net_device *dev = platform_get_drvdata(pdev);
-	struct macb *bp = netdev_priv(dev);
+	struct net_device *netdev = platform_get_drvdata(pdev);
+	struct macb *bp = netdev_priv(netdev);
 	int err;
 
 	bp->queues[0].bp = bp;
 
-	dev->netdev_ops = &at91ether_netdev_ops;
-	dev->ethtool_ops = &macb_ethtool_ops;
+	netdev->netdev_ops = &at91ether_netdev_ops;
+	netdev->ethtool_ops = &macb_ethtool_ops;
 
-	err = devm_request_irq(&pdev->dev, dev->irq, at91ether_interrupt,
-			       0, dev->name, dev);
+	err = devm_request_irq(&pdev->dev, netdev->irq, at91ether_interrupt,
+			       0, netdev->name, netdev);
 	if (err)
 		return err;
 
@@ -5427,8 +5429,8 @@ static int fu540_c000_init(struct platform_device *pdev)
 
 static int init_reset_optional(struct platform_device *pdev)
 {
-	struct net_device *dev = platform_get_drvdata(pdev);
-	struct macb *bp = netdev_priv(dev);
+	struct net_device *netdev = platform_get_drvdata(pdev);
+	struct macb *bp = netdev_priv(netdev);
 	int ret;
 
 	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
@@ -5736,7 +5738,7 @@ static int macb_probe(struct platform_device *pdev)
 	const struct macb_config *macb_config;
 	struct clk *tsu_clk = NULL;
 	phy_interface_t interface;
-	struct net_device *dev;
+	struct net_device *netdev;
 	struct resource *regs;
 	u32 wtrmrk_rst_val;
 	void __iomem *mem;
@@ -5771,19 +5773,19 @@ static int macb_probe(struct platform_device *pdev)
 		goto err_disable_clocks;
 	}
 
-	dev = alloc_etherdev_mq(sizeof(*bp), num_queues);
-	if (!dev) {
+	netdev = alloc_etherdev_mq(sizeof(*bp), num_queues);
+	if (!netdev) {
 		err = -ENOMEM;
 		goto err_disable_clocks;
 	}
 
-	dev->base_addr = regs->start;
+	netdev->base_addr = regs->start;
 
-	SET_NETDEV_DEV(dev, &pdev->dev);
+	SET_NETDEV_DEV(netdev, &pdev->dev);
 
-	bp = netdev_priv(dev);
+	bp = netdev_priv(netdev);
 	bp->pdev = pdev;
-	bp->dev = dev;
+	bp->netdev = netdev;
 	bp->regs = mem;
 	bp->native_io = native_io;
 	if (native_io) {
@@ -5856,21 +5858,21 @@ static int macb_probe(struct platform_device *pdev)
 		bp->caps |= MACB_CAPS_DMA_64B;
 	}
 #endif
-	platform_set_drvdata(pdev, dev);
+	platform_set_drvdata(pdev, netdev);
 
-	dev->irq = platform_get_irq(pdev, 0);
-	if (dev->irq < 0) {
-		err = dev->irq;
+	netdev->irq = platform_get_irq(pdev, 0);
+	if (netdev->irq < 0) {
+		err = netdev->irq;
 		goto err_out_free_netdev;
 	}
 
 	/* MTU range: 68 - 1518 or 10240 */
-	dev->min_mtu = GEM_MTU_MIN_SIZE;
+	netdev->min_mtu = GEM_MTU_MIN_SIZE;
 	if ((bp->caps & MACB_CAPS_JUMBO) && bp->jumbo_max_len)
-		dev->max_mtu = MIN(bp->jumbo_max_len, RX_BUFFER_MAX) -
+		netdev->max_mtu = MIN(bp->jumbo_max_len, RX_BUFFER_MAX) -
 				ETH_HLEN - ETH_FCS_LEN;
 	else
-		dev->max_mtu = 1536 - ETH_HLEN - ETH_FCS_LEN;
+		netdev->max_mtu = 1536 - ETH_HLEN - ETH_FCS_LEN;
 
 	if (bp->caps & MACB_CAPS_BD_RD_PREFETCH) {
 		val = GEM_BFEXT(RXBD_RDBUFF, gem_readl(bp, DCFG10));
@@ -5888,7 +5890,7 @@ static int macb_probe(struct platform_device *pdev)
 	if (bp->caps & MACB_CAPS_NEEDS_RSTONUBR)
 		bp->rx_intr_mask |= MACB_BIT(RXUBR);
 
-	err = of_get_ethdev_address(np, bp->dev);
+	err = of_get_ethdev_address(np, bp->netdev);
 	if (err == -EPROBE_DEFER)
 		goto err_out_free_netdev;
 	else if (err)
@@ -5910,9 +5912,9 @@ static int macb_probe(struct platform_device *pdev)
 	if (err)
 		goto err_out_phy_exit;
 
-	netif_carrier_off(dev);
+	netif_carrier_off(netdev);
 
-	err = register_netdev(dev);
+	err = register_netdev(netdev);
 	if (err) {
 		dev_err(&pdev->dev, "Cannot register net device, aborting.\n");
 		goto err_out_unregister_mdio;
@@ -5921,9 +5923,9 @@ static int macb_probe(struct platform_device *pdev)
 	INIT_WORK(&bp->hresp_err_bh_work, macb_hresp_error_task);
 	INIT_DELAYED_WORK(&bp->tx_lpi_work, macb_tx_lpi_work_fn);
 
-	netdev_info(dev, "Cadence %s rev 0x%08x at 0x%08lx irq %d (%pM)\n",
+	netdev_info(netdev, "Cadence %s rev 0x%08x at 0x%08lx irq %d (%pM)\n",
 		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
-		    dev->base_addr, dev->irq, dev->dev_addr);
+		    netdev->base_addr, netdev->irq, netdev->dev_addr);
 
 	pm_runtime_put_autosuspend(&bp->pdev->dev);
 
@@ -5937,7 +5939,7 @@ static int macb_probe(struct platform_device *pdev)
 	phy_exit(bp->phy);
 
 err_out_free_netdev:
-	free_netdev(dev);
+	free_netdev(netdev);
 
 err_disable_clocks:
 	macb_clks_disable(pclk, hclk, tx_clk, rx_clk, tsu_clk);
@@ -5950,14 +5952,14 @@ static int macb_probe(struct platform_device *pdev)
 
 static void macb_remove(struct platform_device *pdev)
 {
-	struct net_device *dev;
+	struct net_device *netdev;
 	struct macb *bp;
 
-	dev = platform_get_drvdata(pdev);
+	netdev = platform_get_drvdata(pdev);
 
-	if (dev) {
-		bp = netdev_priv(dev);
-		unregister_netdev(dev);
+	if (netdev) {
+		bp = netdev_priv(netdev);
+		unregister_netdev(netdev);
 		phy_exit(bp->phy);
 		mdiobus_unregister(bp->mii_bus);
 		mdiobus_free(bp->mii_bus);
@@ -5969,7 +5971,7 @@ static void macb_remove(struct platform_device *pdev)
 		pm_runtime_dont_use_autosuspend(&pdev->dev);
 		pm_runtime_set_suspended(&pdev->dev);
 		phylink_destroy(bp->phylink);
-		free_netdev(dev);
+		free_netdev(netdev);
 	}
 }
 
@@ -5984,7 +5986,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 	u32 tmp, ifa_local;
 	unsigned int q;
 
-	if (!device_may_wakeup(&bp->dev->dev))
+	if (!device_may_wakeup(&bp->netdev->dev))
 		phy_exit(bp->phy);
 
 	if (!netif_running(netdev))
@@ -5994,7 +5996,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 		if (bp->wolopts & WAKE_ARP) {
 			/* Check for IP address in WOL ARP mode */
 			rcu_read_lock();
-			idev = __in_dev_get_rcu(bp->dev);
+			idev = __in_dev_get_rcu(bp->netdev);
 			if (idev)
 				ifa = rcu_dereference(idev->ifa_list);
 			if (!ifa) {
@@ -6096,7 +6098,7 @@ static int __maybe_unused macb_resume(struct device *dev)
 	unsigned long flags;
 	unsigned int q;
 
-	if (!device_may_wakeup(&bp->dev->dev))
+	if (!device_may_wakeup(&bp->netdev->dev))
 		phy_init(bp->phy);
 
 	if (!netif_running(netdev))
diff --git a/drivers/net/ethernet/cadence/macb_pci.c b/drivers/net/ethernet/cadence/macb_pci.c
index b79dec17e6b0..ac009007118f 100644
--- a/drivers/net/ethernet/cadence/macb_pci.c
+++ b/drivers/net/ethernet/cadence/macb_pci.c
@@ -24,48 +24,48 @@
 #define GEM_PCLK_RATE 50000000
 #define GEM_HCLK_RATE 50000000
 
-static int macb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+static int macb_probe(struct pci_dev *pci, const struct pci_device_id *id)
 {
 	int err;
-	struct platform_device *plat_dev;
+	struct platform_device *pdev;
 	struct platform_device_info plat_info;
 	struct macb_platform_data plat_data;
 	struct resource res[2];
 
 	/* enable pci device */
-	err = pcim_enable_device(pdev);
+	err = pcim_enable_device(pci);
 	if (err < 0) {
-		dev_err(&pdev->dev, "Enabling PCI device has failed: %d", err);
+		dev_err(&pci->dev, "Enabling PCI device has failed: %d", err);
 		return err;
 	}
 
-	pci_set_master(pdev);
+	pci_set_master(pci);
 
 	/* set up resources */
 	memset(res, 0x00, sizeof(struct resource) * ARRAY_SIZE(res));
-	res[0].start = pci_resource_start(pdev, 0);
-	res[0].end = pci_resource_end(pdev, 0);
+	res[0].start = pci_resource_start(pci, 0);
+	res[0].end = pci_resource_end(pci, 0);
 	res[0].name = PCI_DRIVER_NAME;
 	res[0].flags = IORESOURCE_MEM;
-	res[1].start = pci_irq_vector(pdev, 0);
+	res[1].start = pci_irq_vector(pci, 0);
 	res[1].name = PCI_DRIVER_NAME;
 	res[1].flags = IORESOURCE_IRQ;
 
-	dev_info(&pdev->dev, "EMAC physical base addr: %pa\n",
+	dev_info(&pci->dev, "EMAC physical base addr: %pa\n",
 		 &res[0].start);
 
 	/* set up macb platform data */
 	memset(&plat_data, 0, sizeof(plat_data));
 
 	/* initialize clocks */
-	plat_data.pclk = clk_register_fixed_rate(&pdev->dev, "pclk", NULL, 0,
+	plat_data.pclk = clk_register_fixed_rate(&pci->dev, "pclk", NULL, 0,
 						 GEM_PCLK_RATE);
 	if (IS_ERR(plat_data.pclk)) {
 		err = PTR_ERR(plat_data.pclk);
 		goto err_pclk_register;
 	}
 
-	plat_data.hclk = clk_register_fixed_rate(&pdev->dev, "hclk", NULL, 0,
+	plat_data.hclk = clk_register_fixed_rate(&pci->dev, "hclk", NULL, 0,
 						 GEM_HCLK_RATE);
 	if (IS_ERR(plat_data.hclk)) {
 		err = PTR_ERR(plat_data.hclk);
@@ -74,24 +74,24 @@ static int macb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	/* set up platform device info */
 	memset(&plat_info, 0, sizeof(plat_info));
-	plat_info.parent = &pdev->dev;
-	plat_info.fwnode = pdev->dev.fwnode;
+	plat_info.parent = &pci->dev;
+	plat_info.fwnode = pci->dev.fwnode;
 	plat_info.name = PLAT_DRIVER_NAME;
-	plat_info.id = pdev->devfn;
+	plat_info.id = pci->devfn;
 	plat_info.res = res;
 	plat_info.num_res = ARRAY_SIZE(res);
 	plat_info.data = &plat_data;
 	plat_info.size_data = sizeof(plat_data);
-	plat_info.dma_mask = pdev->dma_mask;
+	plat_info.dma_mask = pci->dma_mask;
 
 	/* register platform device */
-	plat_dev = platform_device_register_full(&plat_info);
-	if (IS_ERR(plat_dev)) {
-		err = PTR_ERR(plat_dev);
+	pdev = platform_device_register_full(&plat_info);
+	if (IS_ERR(pdev)) {
+		err = PTR_ERR(pdev);
 		goto err_plat_dev_register;
 	}
 
-	pci_set_drvdata(pdev, plat_dev);
+	pci_set_drvdata(pci, pdev);
 
 	return 0;
 
@@ -105,14 +105,14 @@ static int macb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return err;
 }
 
-static void macb_remove(struct pci_dev *pdev)
+static void macb_remove(struct pci_dev *pci)
 {
-	struct platform_device *plat_dev = pci_get_drvdata(pdev);
-	struct macb_platform_data *plat_data = dev_get_platdata(&plat_dev->dev);
+	struct platform_device *pdev = pci_get_drvdata(pci);
+	struct macb_platform_data *plat_data = dev_get_platdata(&pdev->dev);
 	struct clk *pclk = plat_data->pclk;
 	struct clk *hclk = plat_data->hclk;
 
-	platform_device_unregister(plat_dev);
+	platform_device_unregister(pdev);
 	clk_unregister_fixed_rate(pclk);
 	clk_unregister_fixed_rate(hclk);
 }
diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index d91f7b1aa39c..e5195d7dac1d 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -324,9 +324,9 @@ void gem_ptp_txstamp(struct macb *bp, struct sk_buff *skb,
 	skb_tstamp_tx(skb, &shhwtstamps);
 }
 
-void gem_ptp_init(struct net_device *dev)
+void gem_ptp_init(struct net_device *netdev)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 
 	bp->ptp_clock_info = gem_ptp_caps_template;
 
@@ -334,7 +334,7 @@ void gem_ptp_init(struct net_device *dev)
 	bp->tsu_rate = bp->ptp_info->get_tsu_rate(bp);
 	bp->ptp_clock_info.max_adj = bp->ptp_info->get_ptp_max_adj();
 	gem_ptp_init_timer(bp);
-	bp->ptp_clock = ptp_clock_register(&bp->ptp_clock_info, &dev->dev);
+	bp->ptp_clock = ptp_clock_register(&bp->ptp_clock_info, &netdev->dev);
 	if (IS_ERR(bp->ptp_clock)) {
 		pr_err("ptp clock register failed: %ld\n",
 			PTR_ERR(bp->ptp_clock));
@@ -353,9 +353,9 @@ void gem_ptp_init(struct net_device *dev)
 		 GEM_PTP_TIMER_NAME);
 }
 
-void gem_ptp_remove(struct net_device *ndev)
+void gem_ptp_remove(struct net_device *netdev)
 {
-	struct macb *bp = netdev_priv(ndev);
+	struct macb *bp = netdev_priv(netdev);
 
 	if (bp->ptp_clock) {
 		ptp_clock_unregister(bp->ptp_clock);
@@ -378,10 +378,10 @@ static int gem_ptp_set_ts_mode(struct macb *bp,
 	return 0;
 }
 
-int gem_get_hwtst(struct net_device *dev,
+int gem_get_hwtst(struct net_device *netdev,
 		  struct kernel_hwtstamp_config *tstamp_config)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 
 	*tstamp_config = bp->tstamp_config;
 	if (!macb_dma_ptp(bp))
@@ -402,13 +402,13 @@ static void gem_ptp_set_one_step_sync(struct macb *bp, u8 enable)
 		macb_writel(bp, NCR, reg_val & ~MACB_BIT(OSSMODE));
 }
 
-int gem_set_hwtst(struct net_device *dev,
+int gem_set_hwtst(struct net_device *netdev,
 		  struct kernel_hwtstamp_config *tstamp_config,
 		  struct netlink_ext_ack *extack)
 {
 	enum macb_bd_control tx_bd_control = TSTAMP_DISABLED;
 	enum macb_bd_control rx_bd_control = TSTAMP_DISABLED;
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 	u32 regval;
 
 	if (!macb_dma_ptp(bp))

-- 
2.53.0


