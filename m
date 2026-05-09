Return-Path: <netdev+bounces-286216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCGrJEGg/2lH8gAAu9opvQ
	(envelope-from <netdev+bounces-286216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 22:59:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEE7501694
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 22:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92FC03009019
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 20:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96F438238A;
	Sat,  9 May 2026 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="YMNq6lpp"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC14F386571
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778360381; cv=none; b=IwC0S6hiYT5x0z3NOOUin/NMeiBfHIwXaJcW88EZfOw6mSVszBBtXpTwCQvS0UVfP6EnmgBqAIks71Lw73pvCSp2FV+HXJJHs/5LHX9nJJQyBQJSQvMOpvl0E82PXZTSr1f3alyskCyys0sC4xY8H3I4bU891K+HUVcPdZ2T9/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778360381; c=relaxed/simple;
	bh=MzIviuSn6WROBtiWfEj7lk3KXY5nGzLSMqcPdQsN8ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YGv+DAuWyQOA/Qswaxsf6jQUX5R5Wd+U+oYsRXdDrEKT+68B/9MBD1gkZu0Vfej+MZuQlsg5MWMrQEBrKh51S2A0pbN/+tHUJyfdiHhWl+0JvTbXJJbHEQzteWsvC3s0xp6L7rl1lHpap5yx60IB9OlI6fW2eBRgOHTC3YxXInY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=YMNq6lpp; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 20747 invoked from network); 9 May 2026 22:59:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1778360375; bh=fBZDCOIOyh9U7gxfxmh0aRKlRwrZ21RbZ5QvCtUKxMU=;
          h=From:To:Cc:Subject;
          b=YMNq6lppvArpU65UFSvWq+VKmHQpSf8LO2Dg5J/kX/1Stx7MUZlQIcYEyYgHWTc0d
           wGBeqnLGPDy+CLVCnsh8Nh4xFnUcd/uKTlhXoKYOQJyViB0ePpaSP6FiCkirkXp9Dl
           MzPGyMr/X9Tk/+1ec2jw4h4kze5Nx7Hteoas8RzA34uhpp4AlNRV5+FtUfIUO1pBSr
           4dDORheVwCLoeL5IiNDGYkiuMCCfD6aoS7U5H4AQVVCNYGqVEEBG1qfr5HfY3JX/aw
           +u0+3PfyegONxI+cKhtCRlsVOHl0fo5bTreCO72dls0PTxXMisCuDQ33sMB+HY+WK2
           GiOeqxvX2W0Pw==
Received: from 83.6.112.20.ipv4.supernova.orange.pl (HELO abajkowski.lan) (olek2@wp.pl@[83.6.112.20])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <andrew@lunn.ch>; 9 May 2026 22:59:35 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH] net: phy: intel-xway: add PHY-level statistics via ethtool
Date: Sat,  9 May 2026 22:59:27 +0200
Message-ID: <20260509205933.3965832-1-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: b805c9ad648ce4112a190b2abe5c63de
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [QaOU]                               
X-Rspamd-Queue-Id: ECEE7501694
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-286216-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[wp.pl];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[wp.pl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wp.pl:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wp.pl:email,wp.pl:mid,wp.pl:dkim]
X-Rspamd-Action: no action

Report PCS receive error counts for all supported PEF 7061, 7071, 7072 and
xRX200 PHYs.

Accumulate the vendor-specific PHY_ERRCNT read-clear counter
(SEL=RXERR) in .update_stats() and expose it as both IEEE 802.3
SymbolErrorDuringCarrier and generic rx_errors via
.get_phy_stats().

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/phy/intel-xway.c | 79 ++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/net/phy/intel-xway.c b/drivers/net/phy/intel-xway.c
index 12ff4c1f285d..afbcec711744 100644
--- a/drivers/net/phy/intel-xway.c
+++ b/drivers/net/phy/intel-xway.c
@@ -10,11 +10,16 @@
 #include <linux/of.h>
 #include <linux/bitfield.h>
 
+#define XWAY_MDIO_ERRCNT		0x15	/* error counter */
 #define XWAY_MDIO_MIICTRL		0x17	/* mii control */
 #define XWAY_MDIO_IMASK			0x19	/* interrupt mask */
 #define XWAY_MDIO_ISTAT			0x1A	/* interrupt status */
 #define XWAY_MDIO_LED			0x1B	/* led control */
 
+#define XWAY_MDIO_ERRCNT_SEL		GENMASK(11, 8)
+#define XWAY_MDIO_ERRCNT_COUNT		GENMASK(7, 0)
+#define XWAY_MDIO_ERRCNT_SEL_RXERR	0
+
 #define XWAY_MDIO_MIICTRL_RXSKEW_MASK	GENMASK(14, 12)
 #define XWAY_MDIO_MIICTRL_TXSKEW_MASK	GENMASK(10, 8)
 
@@ -169,6 +174,10 @@
 #define PHY_ID_PHY11G_VR9_1_2		0xD565A409
 #define PHY_ID_PHY22F_VR9_1_2		0xD565A419
 
+struct xway_gphy_priv {
+	u64 rx_errors;
+};
+
 static const int xway_internal_delay[] = {0, 500, 1000, 1500, 2000, 2500,
 					 3000, 3500};
 
@@ -299,6 +308,21 @@ static int xway_gphy_config_init(struct phy_device *phydev)
 	if (err)
 		return err;
 
+	/* Count MDI RX errors (SymbolErrorDuringCarrier) */
+	return phy_write(phydev, XWAY_MDIO_ERRCNT,
+			 FIELD_PREP(XWAY_MDIO_ERRCNT_SEL, XWAY_MDIO_ERRCNT_SEL_RXERR));
+}
+
+static int xway_gphy_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct xway_gphy_priv *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	phydev->priv = priv;
+
 	return 0;
 }
 
@@ -532,6 +556,31 @@ static int xway_gphy_led_polarity_set(struct phy_device *phydev, int index,
 	return -EINVAL;
 }
 
+static int xway_gphy_update_stats(struct phy_device *phydev)
+{
+	struct xway_gphy_priv *priv = phydev->priv;
+	int ret;
+
+	/* XWAY_MDIO_ERRCNT: 8-bit read-clear counter, SEL set to RXERR */
+	ret = phy_read(phydev, XWAY_MDIO_ERRCNT);
+	if (ret < 0)
+		return ret;
+
+	priv->rx_errors += FIELD_GET(XWAY_MDIO_ERRCNT_COUNT, ret);
+
+	return 0;
+}
+
+static void xway_gphy_get_phy_stats(struct phy_device *phydev,
+				    struct ethtool_eth_phy_stats *eth_stats,
+				    struct ethtool_phy_stats *stats)
+{
+	struct xway_gphy_priv *priv = phydev->priv;
+
+	eth_stats->SymbolErrorDuringCarrier = priv->rx_errors;
+	stats->rx_errors = priv->rx_errors;
+}
+
 static struct phy_driver xway_gphy[] = {
 	{
 		.phy_id		= PHY_ID_PHY11G_1_3,
@@ -539,6 +588,7 @@ static struct phy_driver xway_gphy[] = {
 		.name		= "Intel XWAY PHY11G (PEF 7071/PEF 7072) v1.3",
 		/* PHY_GBIT_FEATURES */
 		.config_init	= xway_gphy_config_init,
+		.probe		= xway_gphy_probe,
 		.config_aneg	= xway_gphy14_config_aneg,
 		.handle_interrupt = xway_gphy_handle_interrupt,
 		.config_intr	= xway_gphy_config_intr,
@@ -549,12 +599,15 @@ static struct phy_driver xway_gphy[] = {
 		.led_hw_control_get = xway_gphy_led_hw_control_get,
 		.led_hw_control_set = xway_gphy_led_hw_control_set,
 		.led_polarity_set = xway_gphy_led_polarity_set,
+		.update_stats	= xway_gphy_update_stats,
+		.get_phy_stats	= xway_gphy_get_phy_stats,
 	}, {
 		.phy_id		= PHY_ID_PHY22F_1_3,
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY22F (PEF 7061) v1.3",
 		/* PHY_BASIC_FEATURES */
 		.config_init	= xway_gphy_config_init,
+		.probe		= xway_gphy_probe,
 		.config_aneg	= xway_gphy14_config_aneg,
 		.handle_interrupt = xway_gphy_handle_interrupt,
 		.config_intr	= xway_gphy_config_intr,
@@ -565,12 +618,15 @@ static struct phy_driver xway_gphy[] = {
 		.led_hw_control_get = xway_gphy_led_hw_control_get,
 		.led_hw_control_set = xway_gphy_led_hw_control_set,
 		.led_polarity_set = xway_gphy_led_polarity_set,
+		.update_stats	= xway_gphy_update_stats,
+		.get_phy_stats	= xway_gphy_get_phy_stats,
 	}, {
 		.phy_id		= PHY_ID_PHY11G_1_4,
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY11G (PEF 7071/PEF 7072) v1.4",
 		/* PHY_GBIT_FEATURES */
 		.config_init	= xway_gphy_config_init,
+		.probe		= xway_gphy_probe,
 		.config_aneg	= xway_gphy14_config_aneg,
 		.handle_interrupt = xway_gphy_handle_interrupt,
 		.config_intr	= xway_gphy_config_intr,
@@ -581,12 +637,15 @@ static struct phy_driver xway_gphy[] = {
 		.led_hw_control_get = xway_gphy_led_hw_control_get,
 		.led_hw_control_set = xway_gphy_led_hw_control_set,
 		.led_polarity_set = xway_gphy_led_polarity_set,
+		.update_stats	= xway_gphy_update_stats,
+		.get_phy_stats	= xway_gphy_get_phy_stats,
 	}, {
 		.phy_id		= PHY_ID_PHY22F_1_4,
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY22F (PEF 7061) v1.4",
 		/* PHY_BASIC_FEATURES */
 		.config_init	= xway_gphy_config_init,
+		.probe		= xway_gphy_probe,
 		.config_aneg	= xway_gphy14_config_aneg,
 		.handle_interrupt = xway_gphy_handle_interrupt,
 		.config_intr	= xway_gphy_config_intr,
@@ -597,12 +656,15 @@ static struct phy_driver xway_gphy[] = {
 		.led_hw_control_get = xway_gphy_led_hw_control_get,
 		.led_hw_control_set = xway_gphy_led_hw_control_set,
 		.led_polarity_set = xway_gphy_led_polarity_set,
+		.update_stats	= xway_gphy_update_stats,
+		.get_phy_stats	= xway_gphy_get_phy_stats,
 	}, {
 		.phy_id		= PHY_ID_PHY11G_1_5,
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY11G (PEF 7071/PEF 7072) v1.5 / v1.6",
 		/* PHY_GBIT_FEATURES */
 		.config_init	= xway_gphy_config_init,
+		.probe		= xway_gphy_probe,
 		.handle_interrupt = xway_gphy_handle_interrupt,
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
@@ -612,12 +674,15 @@ static struct phy_driver xway_gphy[] = {
 		.led_hw_control_get = xway_gphy_led_hw_control_get,
 		.led_hw_control_set = xway_gphy_led_hw_control_set,
 		.led_polarity_set = xway_gphy_led_polarity_set,
+		.update_stats	= xway_gphy_update_stats,
+		.get_phy_stats	= xway_gphy_get_phy_stats,
 	}, {
 		.phy_id		= PHY_ID_PHY22F_1_5,
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY22F (PEF 7061) v1.5 / v1.6",
 		/* PHY_BASIC_FEATURES */
 		.config_init	= xway_gphy_config_init,
+		.probe		= xway_gphy_probe,
 		.handle_interrupt = xway_gphy_handle_interrupt,
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
@@ -627,12 +692,15 @@ static struct phy_driver xway_gphy[] = {
 		.led_hw_control_get = xway_gphy_led_hw_control_get,
 		.led_hw_control_set = xway_gphy_led_hw_control_set,
 		.led_polarity_set = xway_gphy_led_polarity_set,
+		.update_stats	= xway_gphy_update_stats,
+		.get_phy_stats	= xway_gphy_get_phy_stats,
 	}, {
 		.phy_id		= PHY_ID_PHY11G_VR9_1_1,
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY11G (xRX v1.1 integrated)",
 		/* PHY_GBIT_FEATURES */
 		.config_init	= xway_gphy_config_init,
+		.probe		= xway_gphy_probe,
 		.handle_interrupt = xway_gphy_handle_interrupt,
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
@@ -642,12 +710,15 @@ static struct phy_driver xway_gphy[] = {
 		.led_hw_control_get = xway_gphy_led_hw_control_get,
 		.led_hw_control_set = xway_gphy_led_hw_control_set,
 		.led_polarity_set = xway_gphy_led_polarity_set,
+		.update_stats	= xway_gphy_update_stats,
+		.get_phy_stats	= xway_gphy_get_phy_stats,
 	}, {
 		.phy_id		= PHY_ID_PHY22F_VR9_1_1,
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY22F (xRX v1.1 integrated)",
 		/* PHY_BASIC_FEATURES */
 		.config_init	= xway_gphy_config_init,
+		.probe		= xway_gphy_probe,
 		.handle_interrupt = xway_gphy_handle_interrupt,
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
@@ -657,12 +728,15 @@ static struct phy_driver xway_gphy[] = {
 		.led_hw_control_get = xway_gphy_led_hw_control_get,
 		.led_hw_control_set = xway_gphy_led_hw_control_set,
 		.led_polarity_set = xway_gphy_led_polarity_set,
+		.update_stats	= xway_gphy_update_stats,
+		.get_phy_stats	= xway_gphy_get_phy_stats,
 	}, {
 		.phy_id		= PHY_ID_PHY11G_VR9_1_2,
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY11G (xRX v1.2 integrated)",
 		/* PHY_GBIT_FEATURES */
 		.config_init	= xway_gphy_config_init,
+		.probe		= xway_gphy_probe,
 		.handle_interrupt = xway_gphy_handle_interrupt,
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
@@ -672,12 +746,15 @@ static struct phy_driver xway_gphy[] = {
 		.led_hw_control_get = xway_gphy_led_hw_control_get,
 		.led_hw_control_set = xway_gphy_led_hw_control_set,
 		.led_polarity_set = xway_gphy_led_polarity_set,
+		.update_stats	= xway_gphy_update_stats,
+		.get_phy_stats	= xway_gphy_get_phy_stats,
 	}, {
 		.phy_id		= PHY_ID_PHY22F_VR9_1_2,
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY22F (xRX v1.2 integrated)",
 		/* PHY_BASIC_FEATURES */
 		.config_init	= xway_gphy_config_init,
+		.probe		= xway_gphy_probe,
 		.handle_interrupt = xway_gphy_handle_interrupt,
 		.config_intr	= xway_gphy_config_intr,
 		.suspend	= genphy_suspend,
@@ -687,6 +764,8 @@ static struct phy_driver xway_gphy[] = {
 		.led_hw_control_get = xway_gphy_led_hw_control_get,
 		.led_hw_control_set = xway_gphy_led_hw_control_set,
 		.led_polarity_set = xway_gphy_led_polarity_set,
+		.update_stats	= xway_gphy_update_stats,
+		.get_phy_stats	= xway_gphy_get_phy_stats,
 	},
 };
 module_phy_driver(xway_gphy);
-- 
2.53.0


