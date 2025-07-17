Return-Path: <netdev+bounces-207743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910A6B086D8
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947DD4A0A1E
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 07:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB9D289358;
	Thu, 17 Jul 2025 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OTbYLYO9"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B3C286D7D;
	Thu, 17 Jul 2025 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737444; cv=none; b=Ga/GfRPrTf7mqzxJNHIkoB01KNDIVaimgrZlKwbafUah3fXCDc+m9D1MHttRbFoZ57WxwJhpUoEKzx6lNYt3i0B9IBjzhr/rNrgDtnBeKTpNkZvaeRyVVdYc9FA5M7VDdnqhSIMJhoD/JlxnuAg896l1KeQJOjyfCP5Z3tYI6+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737444; c=relaxed/simple;
	bh=qZq91shlGYPDlmSK7qbYrPHQ6m3IdlXyS8a7m7S5kG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5lA2vjuOnrydsQYxPrGwuvx/PbW/NwIYVQljv7J8XnFQXU4LBesfGAML92rtlP+VSvJScuhbNc6UeQPywssQ1LWup1eFa2HCBjQT5ZiDiRRt4xVYKb/nk8r7j8IJIRe+m9KbS9RtiNSFofkfWkAKXL1sTRMeWJryvaJTlTOewk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OTbYLYO9; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E935443F3;
	Thu, 17 Jul 2025 07:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752737440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9iQH4kxfqf3NCgkxryD8jJxsQEYrTj/jEyun2UwK9nQ=;
	b=OTbYLYO9CtI7kjeztIY5G9oYjrokYq/1ztbk3utDnIG1E4tKEAJEcan4rGdEclHRA1eG7f
	ilxtnMKS74hKuRizjGVNgtSDh7bKrdDhLbv8pi1nv4fAeRSq43+hujUvdyKuXHkw51xQOk
	t6M4e+YbJepdPNDGJL107P+Q/xi05FJ9Qw7mvIDp/vmclyal+tRmMaPFO4tMAAv7+rMZfZ
	VW6AroFIm3ylha3Rcqgjt1K6QCs8wvd9sHOzWNGaZC/cvXh3/d7hOO8mYUeJBeZvSqGd3V
	2b5nC6iLCeTVumOAzIbvEz42GEJJyDohT/UU+ag0NfMQxEYztHw75WqBATm2QQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: [PATCH net-next v9 10/15] net: phy: marvell10g: Support SFP through phy_port
Date: Thu, 17 Jul 2025 09:30:14 +0200
Message-ID: <20250717073020.154010-11-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250717073020.154010-1-maxime.chevallier@bootlin.com>
References: <20250717073020.154010-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehleellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefuddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhmshhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Convert the Marvell10G driver to use the generic SFP handling, through a
dedicated .attach_port() handler to populate the port's supported
interfaces.

As the 88x3310 supports multiple MDI, the .attach_port() logic handles
both SFP attach with 10GBaseR support, and support for the "regular"
port that usually is a BaseT port.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/marvell10g.c | 47 +++++++++++++++++++-----------------
 drivers/net/phy/phy_port.c   | 20 +++++++++++++++
 include/linux/phy_port.h     |  1 +
 3 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 13e81dff42c1..7cb638804a3f 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -28,7 +28,7 @@
 #include <linux/hwmon.h>
 #include <linux/marvell_phy.h>
 #include <linux/phy.h>
-#include <linux/sfp.h>
+#include <linux/phy_port.h>
 #include <linux/netdevice.h>
 
 #define MV_PHY_ALASKA_NBT_QUIRK_MASK	0xfffffffe
@@ -463,36 +463,31 @@ static int mv3310_set_edpd(struct phy_device *phydev, u16 edpd)
 	return err;
 }
 
-static int mv3310_sfp_insert(void *upstream, const struct sfp_eeprom_id *id)
+static int mv3310_attach_port(struct phy_device *phydev, struct phy_port *port)
 {
-	struct phy_device *phydev = upstream;
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(support) = { 0, };
-	DECLARE_PHY_INTERFACE_MASK(interfaces);
-	phy_interface_t iface;
-
-	sfp_parse_support(phydev->sfp_bus, id, support, interfaces);
-	iface = sfp_select_interface(phydev->sfp_bus, support);
-
-	if (iface != PHY_INTERFACE_MODE_10GBASER) {
-		dev_err(&phydev->mdio.dev, "incompatible SFP module inserted\n");
-		return -EINVAL;
+	if (port->is_mii) {
+		__set_bit(PHY_INTERFACE_MODE_10GBASER, port->interfaces);
+	} else if (port->not_described) {
+		/* This PHY can do combo-ports, i.e. 2 MDI outputs, usually one
+		 * of them going to an SFP and the other one to a RJ45
+		 * connector. If we don't have any representation for the port
+		 * in DT, and we are dealing with a non-SFP port, then we
+		 * mask the port's capabilities to report BaseT-only modes
+		 */
+		port->mediums = BIT(ETHTOOL_LINK_MEDIUM_BASET);
+
+		phy_port_filter_supported(port);
 	}
+
 	return 0;
 }
 
-static const struct sfp_upstream_ops mv3310_sfp_ops = {
-	.attach = phy_sfp_attach,
-	.detach = phy_sfp_detach,
-	.connect_phy = phy_sfp_connect_phy,
-	.disconnect_phy = phy_sfp_disconnect_phy,
-	.module_insert = mv3310_sfp_insert,
-};
-
 static int mv3310_probe(struct phy_device *phydev)
 {
 	const struct mv3310_chip *chip = to_mv3310_chip(phydev);
 	struct mv3310_priv *priv;
 	u32 mmd_mask = MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
+	DECLARE_PHY_INTERFACE_MASK(interfaces);
 	int ret;
 
 	if (!phydev->is_c45 ||
@@ -543,9 +538,13 @@ static int mv3310_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	__set_bit(PHY_INTERFACE_MODE_10GBASER, interfaces);
+
 	chip->init_supported_interfaces(priv->supported_interfaces);
 
-	return phy_sfp_probe(phydev, &mv3310_sfp_ops);
+	phydev->max_n_ports = 2;
+
+	return 0;
 }
 
 static void mv3310_remove(struct phy_device *phydev)
@@ -1406,6 +1405,7 @@ static struct phy_driver mv3310_drivers[] = {
 		.set_loopback	= genphy_c45_loopback,
 		.get_wol	= mv3110_get_wol,
 		.set_wol	= mv3110_set_wol,
+		.attach_port	= mv3310_attach_port,
 	},
 	{
 		.phy_id		= MARVELL_PHY_ID_88X3310,
@@ -1425,6 +1425,7 @@ static struct phy_driver mv3310_drivers[] = {
 		.set_tunable	= mv3310_set_tunable,
 		.remove		= mv3310_remove,
 		.set_loopback	= genphy_c45_loopback,
+		.attach_port	= mv3310_attach_port,
 	},
 	{
 		.phy_id		= MARVELL_PHY_ID_88E2110,
@@ -1445,6 +1446,7 @@ static struct phy_driver mv3310_drivers[] = {
 		.set_loopback	= genphy_c45_loopback,
 		.get_wol	= mv3110_get_wol,
 		.set_wol	= mv3110_set_wol,
+		.attach_port	= mv3310_attach_port,
 	},
 	{
 		.phy_id		= MARVELL_PHY_ID_88E2110,
@@ -1463,6 +1465,7 @@ static struct phy_driver mv3310_drivers[] = {
 		.set_tunable	= mv3310_set_tunable,
 		.remove		= mv3310_remove,
 		.set_loopback	= genphy_c45_loopback,
+		.attach_port	= mv3310_attach_port,
 	},
 };
 
diff --git a/drivers/net/phy/phy_port.c b/drivers/net/phy/phy_port.c
index 36de8c5c9ad5..cd7ace64ed4b 100644
--- a/drivers/net/phy/phy_port.c
+++ b/drivers/net/phy/phy_port.c
@@ -131,6 +131,26 @@ void phy_port_update_supported(struct phy_port *port)
 }
 EXPORT_SYMBOL_GPL(phy_port_update_supported);
 
+/**
+ * phy_port_filter_supported() - Make sure that port->supported match port->mediums
+ * @port: The port to filter
+ *
+ * After updating a port's mediums to a more restricted subset, this helper will
+ * make sure that port->supported only contains linkmodes that are compatible
+ * with port->mediums.
+ */
+void phy_port_filter_supported(struct phy_port *port)
+{
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0 };
+	int i;
+
+	for_each_set_bit(i, &port->mediums, __ETHTOOL_LINK_MEDIUM_LAST)
+		phy_caps_medium_get_supported(supported, i, port->lanes);
+
+	linkmode_and(port->supported, port->supported, supported);
+}
+EXPORT_SYMBOL_GPL(phy_port_filter_supported);
+
 /**
  * phy_port_get_type() - get the PORT_* attribut for that port.
  * @port: The port we want the information from
diff --git a/include/linux/phy_port.h b/include/linux/phy_port.h
index f47ac5f5ef9e..ce735d81bcd0 100644
--- a/include/linux/phy_port.h
+++ b/include/linux/phy_port.h
@@ -90,6 +90,7 @@ static inline bool phy_port_is_fiber(struct phy_port *port)
 }
 
 void phy_port_update_supported(struct phy_port *port);
+void phy_port_filter_supported(struct phy_port *port);
 
 int phy_port_get_type(struct phy_port *port);
 
-- 
2.49.0


