Return-Path: <netdev+bounces-182257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E26A88578
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879731902527
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EF628BA8F;
	Mon, 14 Apr 2025 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="RCXRe0OT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="AJHsRmlB"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DD417A2EA;
	Mon, 14 Apr 2025 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640077; cv=none; b=JVJUYHpdxHOLrD0uKNBYKNtbkosnnH8FVdekY+tMZJaOZRU4i8zVJGPvvV4dBkXk18sVTPw/ElmVMtdZxMVAgFWidCa3BW2CbC4yW5RXXHvaRhPgNjDizQemSqeOU8RSL36y+sUJStIjPDsBVp81MG5ovQweysq8c4IghfS0IZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640077; c=relaxed/simple;
	bh=Jqmd77umJyoaCy5gG2yrDU0YivAchN4acEmBBoR89zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5wHnS8q/BOU8t2PKE+DfmfeykfKPC/fTy9lPPz7RVMvKjQc9/cqu1HDaqZP31Bi5njJoAeLAcdZnGQMrs22rmr4NRBg66dCxy7wbybHkIrXN+oAzTyH3WdKFLBVaqo2K0FhYmcDZesYPEWvEMLkXNmRn0AQytvHhduBHxd8i8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=RCXRe0OT; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=AJHsRmlB reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1744640074; x=1776176074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vvYyMubPA5Sl5iG0mDNEkD9ed98foiGmowuWEtiDHtg=;
  b=RCXRe0OTjxta7XbTw3RzA8NdKUKpDxost5A7+Tf9eR4L5YOobOFb70n7
   C3sXJBGqI6Dl4Z44bgyWSgh/6G5VlozRudLSG48MkNlw00d3+bBsJbzSC
   QdbdDwHlWhjKupn0TQgKKcPnnBS0XzCFnuygOHsqiq/sHlsHBFCEzoD6v
   0hj4zqIdK1PXQ6W8v+UxAjTLK4WD8UMR/tzaAtkDU9MCVVLZx7d+laxZ1
   ejcW5fUMA7NDY/SeI9Zhgk4EE0os6zYzGLvDuFIEOfuxs3xmdEg/9y81W
   yztdDJoVnH4tJX2NfBrmC/x0yC+Es1xav0Z5eXw8Q/tkKOPjPCm7omun/
   A==;
X-CSE-ConnectionGUID: S0FojUj4S/yTYFW32Yd5vw==
X-CSE-MsgGUID: Iz1Acn4QSV6UDnOY4S3vCw==
X-IronPort-AV: E=Sophos;i="6.15,212,1739833200"; 
   d="scan'208";a="43517431"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 14 Apr 2025 16:14:31 +0200
X-CheckPoint: {67FD1847-B-B1D34AC3-DEA5B19F}
X-MAIL-CPID: ADF53A2CE5B1B79FF9725C745A73F8FE_4
X-Control-Analysis: str=0001.0A006372.67FD184D.005C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 34B7B16B0FF;
	Mon, 14 Apr 2025 16:14:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1744640066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvYyMubPA5Sl5iG0mDNEkD9ed98foiGmowuWEtiDHtg=;
	b=AJHsRmlBqEOt4/kWnciuiGIdU60CkRcN8UBKfiyY4o9Dagt6UisdejQjUX3XTQQ72CleXm
	aeMr8K463CciDYRfe2zHoWqRLC9wD7hYl2EYf6myiZ/ysJIlB2XxquD3NjIbIFqjHDkkZ0
	fguoIFaAq6Da7B7y6Y3Ql3o9JUAsBIT7/JrtB+tP4IiJm25WpLKrj9Wnt/dIuZocrVCz95
	d7dnT+I1UHMr/oL5Dv6wkK4+FM5aX9XIi5Tb3RYWU3hemzt4qeuzKLSULfpL53rSUpDqMB
	Q09C8nyUfoKbF/1u6oCGhXTAsd8wHmWsS4sRHIVJFKNszSJlDwpvjdUS6px92w==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH net-next 2/2] net: phy: dp83867: use 2ns delay if not specified in DTB
Date: Mon, 14 Apr 2025 16:13:58 +0200
Message-ID: <2709a88893b7d802f4caf3bc11b5d3ebafbca606.1744639988.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <8013ae5966dd22bcb698c0c09d2fc0912ae7ac25.1744639988.git.matthias.schiffer@ew.tq-group.com>
References: <8013ae5966dd22bcb698c0c09d2fc0912ae7ac25.1744639988.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Most PHY drivers default to a 2ns delay if internal delay is requested
and no value is specified. Having a default value makes sense, as it
allows a Device Tree to only care about board design (whether there are
delays on the PCB or not), and not whether the delay is added on the MAC
or the PHY side when needed.

Whether the delays are actually applied is controlled by the
DP83867_RGMII_*_CLK_DELAY_EN flags, so the behavior is only changed in
configurations that would previously be rejected with -EINVAL.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/net/phy/dp83867.c | 44 ++++-----------------------------------
 1 file changed, 4 insertions(+), 40 deletions(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index e5b0c1b7be13f..deeefb9625664 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -106,10 +106,8 @@
 /* RGMIIDCTL bits */
 #define DP83867_RGMII_TX_CLK_DELAY_MAX		0xf
 #define DP83867_RGMII_TX_CLK_DELAY_SHIFT	4
-#define DP83867_RGMII_TX_CLK_DELAY_INV	(DP83867_RGMII_TX_CLK_DELAY_MAX + 1)
 #define DP83867_RGMII_RX_CLK_DELAY_MAX		0xf
 #define DP83867_RGMII_RX_CLK_DELAY_SHIFT	0
-#define DP83867_RGMII_RX_CLK_DELAY_INV	(DP83867_RGMII_RX_CLK_DELAY_MAX + 1)
 
 /* IO_MUX_CFG bits */
 #define DP83867_IO_MUX_CFG_IO_IMPEDANCE_MASK	0x1f
@@ -501,29 +499,6 @@ static int dp83867_config_port_mirroring(struct phy_device *phydev)
 	return 0;
 }
 
-static int dp83867_verify_rgmii_cfg(struct phy_device *phydev)
-{
-	struct dp83867_private *dp83867 = phydev->priv;
-
-	/* RX delay *must* be specified if internal delay of RX is used. */
-	if ((phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
-	     phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID) &&
-	     dp83867->rx_id_delay == DP83867_RGMII_RX_CLK_DELAY_INV) {
-		phydev_err(phydev, "ti,rx-internal-delay must be specified\n");
-		return -EINVAL;
-	}
-
-	/* TX delay *must* be specified if internal delay of TX is used. */
-	if ((phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
-	     phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID) &&
-	     dp83867->tx_id_delay == DP83867_RGMII_TX_CLK_DELAY_INV) {
-		phydev_err(phydev, "ti,tx-internal-delay must be specified\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 #if IS_ENABLED(CONFIG_OF_MDIO)
 static int dp83867_of_init_io_impedance(struct phy_device *phydev)
 {
@@ -607,7 +582,7 @@ static int dp83867_of_init(struct phy_device *phydev)
 	dp83867->sgmii_ref_clk_en = of_property_read_bool(of_node,
 							  "ti,sgmii-ref-clock-output-enable");
 
-	dp83867->rx_id_delay = DP83867_RGMII_RX_CLK_DELAY_INV;
+	dp83867->rx_id_delay = DP83867_RGMIIDCTL_2_00_NS;
 	ret = of_property_read_u32(of_node, "ti,rx-internal-delay",
 				   &dp83867->rx_id_delay);
 	if (!ret && dp83867->rx_id_delay > DP83867_RGMII_RX_CLK_DELAY_MAX) {
@@ -617,7 +592,7 @@ static int dp83867_of_init(struct phy_device *phydev)
 		return -EINVAL;
 	}
 
-	dp83867->tx_id_delay = DP83867_RGMII_TX_CLK_DELAY_INV;
+	dp83867->tx_id_delay = DP83867_RGMIIDCTL_2_00_NS;
 	ret = of_property_read_u32(of_node, "ti,tx-internal-delay",
 				   &dp83867->tx_id_delay);
 	if (!ret && dp83867->tx_id_delay > DP83867_RGMII_TX_CLK_DELAY_MAX) {
@@ -737,7 +712,6 @@ static int dp83867_config_init(struct phy_device *phydev)
 {
 	struct dp83867_private *dp83867 = phydev->priv;
 	int ret, val, bs;
-	u16 delay;
 
 	/* Force speed optimization for the PHY even if it strapped */
 	ret = phy_modify(phydev, DP83867_CFG2, DP83867_DOWNSHIFT_EN,
@@ -745,10 +719,6 @@ static int dp83867_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	ret = dp83867_verify_rgmii_cfg(phydev);
-	if (ret)
-		return ret;
-
 	/* RX_DV/RX_CTRL strapped in mode 1 or mode 2 workaround */
 	if (dp83867->rxctrl_strap_quirk)
 		phy_clear_bits_mmd(phydev, DP83867_DEVADDR, DP83867_CFG4,
@@ -827,15 +797,9 @@ static int dp83867_config_init(struct phy_device *phydev)
 
 		phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_RGMIICTL, val);
 
-		delay = 0;
-		if (dp83867->rx_id_delay != DP83867_RGMII_RX_CLK_DELAY_INV)
-			delay |= dp83867->rx_id_delay;
-		if (dp83867->tx_id_delay != DP83867_RGMII_TX_CLK_DELAY_INV)
-			delay |= dp83867->tx_id_delay <<
-				 DP83867_RGMII_TX_CLK_DELAY_SHIFT;
-
 		phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_RGMIIDCTL,
-			      delay);
+			      dp83867->rx_id_delay |
+			      (dp83867->tx_id_delay << DP83867_RGMII_TX_CLK_DELAY_SHIFT));
 	}
 
 	/* If specified, set io impedance */
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


