Return-Path: <netdev+bounces-235408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D11C30190
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 09:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25CD74FB557
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 08:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEC23115A5;
	Tue,  4 Nov 2025 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gg/WWhIB"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CD82BE7B1
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246248; cv=none; b=Cbmpnod12PZB+xHZzIcOCTYN5dzmmjryxDOmm2U1KkRkRaJrH/TZbSLtOPx2SOoUeI871jUGNUxhZjxsn9r3L/3CF5zSJv51HS4FOJsGYscITasj1Vnj1Us5ZgkDy9o3xsYryM/KMkXBQN0rHXULD8EbVFC/UErHHxd5vDKT+nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246248; c=relaxed/simple;
	bh=VsMekIp98vCsMiV20GkQ9+nywxpuuf9mCQCixX4hlWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QEzUIjzNE7hAXdgzdJFjTWp5Bd5e+yNxIH6dBxotPl/xO5MDDU5DKnv7OKGcFiBjrPELAQ2KcnSVQ8DsKyPgL2vfzLsK2mYOjtitmqNy/zE0QU9XT48Jp35966GWlE2eHr4tfL0JUYEscrHoPiKUDc1/4/s5UrpG4nL6k+Jvdr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gg/WWhIB; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8AF2D1A1863;
	Tue,  4 Nov 2025 08:50:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5B104606EF;
	Tue,  4 Nov 2025 08:50:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBF1710B500FA;
	Tue,  4 Nov 2025 09:50:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762246243; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LQza/ohL7XLXBUYk10k1jYrBUK3FWCcC2YEo0ej5nGA=;
	b=Gg/WWhIBCrWbO/WL+eZ2jnaHsswWzcAeGc5yq2RivmUbc6u6Jn1E1tT5nGnC3TjtvLNHvY
	vzDnmLpp2KUgCTSz1xJC3x7NusQhYX5T+mHFRPY8jvQt+BjvMG3j8hcZRj8+Trax9Rzdya
	7n5uI2gfewteVnDGPjBWrvYBDcESqvhlCZrJfOrbgLI0GhQ9dJ/lTfbYk3eRlqeF35oTfh
	gmKRSVl/Vukdndwyhv+lVzqOeVzMAs7op+tj7CUMyeZIO7Wsb8ShHIsS5xD6jguOHBBJie
	bAtRTCzqigMKVRr4dVS9KhRJ7M1wea1l7KmKBI1G/+yddWhORuqPQQAcgXRRvQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 04 Nov 2025 09:50:36 +0100
Subject: [PATCH net-next 3/3] net: phy: dp83869: Support 1000Base-X SFP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-sfp-1000basex-v1-3-f461f170c74e@bootlin.com>
References: <20251104-sfp-1000basex-v1-0-f461f170c74e@bootlin.com>
In-Reply-To: <20251104-sfp-1000basex-v1-0-f461f170c74e@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Associate with an SFP cage described in the device tree and provide the
module_insert() callback that will set the appropriate DP83869 operation
mode when an SFP module is inserted.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/phy/dp83869.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index adcd899472f2..e279dfa268a4 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/phy.h>
+#include <linux/sfp.h>
 #include <linux/delay.h>
 #include <linux/bitfield.h>
 
@@ -875,6 +876,77 @@ static int dp83869_config_init(struct phy_device *phydev)
 	return ret;
 }
 
+static void dp83869_module_remove(void *upstream)
+{
+	struct phy_device *phydev = upstream;
+
+	phydev_info(phydev, "SFP module removed\n");
+
+	/* Set speed and duplex to unknown to avoid downshifting warning. */
+	phydev->speed = SPEED_UNKNOWN;
+	phydev->duplex = DUPLEX_UNKNOWN;
+}
+
+static int dp83869_module_insert(void *upstream, const struct sfp_eeprom_id *id)
+{
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_support);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
+	struct phy_device *phydev = upstream;
+	const struct sfp_module_caps *caps;
+	struct dp83869_private *dp83869;
+	phy_interface_t interface;
+	int ret;
+
+	linkmode_zero(phy_support);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT, phy_support);
+
+	caps = sfp_get_module_caps(phydev->sfp_bus);
+
+	linkmode_and(sfp_support, phy_support, caps->link_modes);
+
+	if (linkmode_empty(sfp_support)) {
+		phydev_err(phydev, "incompatible SFP module inserted\n");
+		return -EINVAL;
+	}
+
+	interface = sfp_select_interface(phydev->sfp_bus, sfp_support);
+
+	phydev_info(phydev, "%s SFP compatible link mode: %s\n", __func__,
+		    phy_modes(interface));
+
+	dp83869 = phydev->priv;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_1000BASEX:
+		dp83869->mode = DP83869_RGMII_1000_BASE;
+		phydev->port = PORT_FIBRE;
+		break;
+	default:
+		phydev_err(phydev, "incompatible PHY-to-SFP module link mode %s!\n",
+			   phy_modes(interface));
+		return -EINVAL;
+	}
+
+	ret = dp83869_configure_mode(phydev, dp83869);
+	if (ret)
+		return ret;
+
+	/* Reconfigure advertisement */
+	if (mutex_trylock(&phydev->lock)) {
+		ret = dp83869_config_aneg(phydev);
+		mutex_unlock(&phydev->lock);
+	}
+
+	return ret;
+}
+
+static const struct sfp_upstream_ops dp83869_sfp_ops = {
+	.attach = phy_sfp_attach,
+	.detach = phy_sfp_detach,
+	.module_insert = dp83869_module_insert,
+	.module_remove = dp83869_module_remove,
+};
+
 static int dp83869_probe(struct phy_device *phydev)
 {
 	struct dp83869_private *dp83869;
@@ -891,6 +963,12 @@ static int dp83869_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	if (of_property_read_bool(phydev->mdio.dev.of_node, "sfp")) {
+		ret = phy_sfp_probe(phydev, &dp83869_sfp_ops);
+		if (ret)
+			return ret;
+	}
+
 	if (dp83869->mode == DP83869_RGMII_100_BASE ||
 	    dp83869->mode == DP83869_RGMII_1000_BASE)
 		phydev->port = PORT_FIBRE;

-- 
2.51.2


