Return-Path: <netdev+bounces-168766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E455BA40905
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 15:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625647048B7
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 14:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4A51C84A7;
	Sat, 22 Feb 2025 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cgyYYM1H"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB34156C71;
	Sat, 22 Feb 2025 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740234465; cv=none; b=bGuTVbx5UXRM+zTQQ3gJNIfWA1Va6pUW6Xu6QFmIyvj0d5Ylnl+qmijU3QPI+6fnNm3WtuyVywebE9j6MMJs1ak7pDMmK/rLViObY1604Rc0AkTb38kuG+mXnGoqBefYiOASmbFu7rl/+7EyXP+5njO5N8ui7PglH9m0FvYNnMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740234465; c=relaxed/simple;
	bh=FlZaCEaddEMcKCleF5OSoJNRpd0P7YCLnv/oomXw5aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTaVnFiczH0oPAGyvvEj6LgHPSweiIE4gwFFugJlYk+dWec0pag71xMPUOZUmE3s7TsnMZyqErLJWV6YNbtNJSj9NLVPsE9R5KwhdSPXqhYQttmGTPpUk77JsB2bsGw/IXxE+P+kx3oRHlG4ANjPKcUyCWTPCc9E275/9HIpw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cgyYYM1H; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 504D844260;
	Sat, 22 Feb 2025 14:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740234455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Q4LelKecI5PVTu2qoO9liBc6px5H3vBgQ0FauU6NrA=;
	b=cgyYYM1H8CDwqQsga16TDthYGa8cwSFPJYpK1luyhY3UhUsfN71IDYjPnePXTsTVH5ErtA
	2HhuUazidhqpMy/2hNVcTHr8UadjMS3p4szxPizm/NgGyCrU3v/khZarYnJ+R4xd/Bv/zp
	h6+ah6kz3Xrs8qtdgn1xAPteFN4JpxmnL6Ay+UyAWX+87aNzVJGFpRvqQgzjOpVQeh6WQe
	j7UZVC3SPgQ0LvKP09kp5zMQE7h3r5O3A1tzbpdietHG/Vza0uPCVGQPZ153Fo2QEjQsNG
	4DbbCVrqVtMfdgn4w965SmsYz+sJyU0t5YhITLCy+W3nOC40QLW2eux0HQgHWg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next 02/13] net: phy: phylink: Extract the logic to get caps from interface
Date: Sat, 22 Feb 2025 15:27:14 +0100
Message-ID: <20250222142727.894124-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250222142727.894124-1-maxime.chevallier@bootlin.com>
References: <20250222142727.894124-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejfeduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgri
 igvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Any given phy_interface_t may be able to convey data at various
combinations of speed and duplex. Extract this logic out of phylink to
make it accessible for other internal computations, as preparation for
phy_port support and phy-side SFP handling.

This commit has no expected changes in behaviour.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-caps.h |  2 +
 drivers/net/phy/phy_caps.c | 91 ++++++++++++++++++++++++++++++++++++++
 drivers/net/phy/phylink.c  | 79 +--------------------------------
 3 files changed, 94 insertions(+), 78 deletions(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index 99c648f76dea..ecb63b28c5fb 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -9,4 +9,6 @@
 
 void linkmode_from_caps(unsigned long *linkmode, unsigned long caps);
 
+unsigned long phy_interface_caps(phy_interface_t interface);
+
 #endif /* __PHY_CAPS_H */
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 807be1317263..59e4505b7336 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -160,3 +160,94 @@ void linkmode_from_caps(unsigned long *linkmodes, unsigned long caps)
 	}
 }
 EXPORT_SYMBOL_GPL(linkmode_from_caps);
+
+/**
+ * phy_interface_caps() - Retrieve the speed/duplex capablities of an interface
+ * @interface: phy_interface_t to get the capabilities from
+ *
+ * Returns: A bitmask of MAC_* capablities for a given interface.
+ */
+unsigned long phy_interface_caps(phy_interface_t interface)
+{
+	unsigned long caps = MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_USXGMII:
+		caps |= MAC_10000FD | MAC_5000FD;
+		fallthrough;
+
+	case PHY_INTERFACE_MODE_10G_QXGMII:
+		caps |= MAC_2500FD;
+		fallthrough;
+
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_PSGMII:
+	case PHY_INTERFACE_MODE_QSGMII:
+	case PHY_INTERFACE_MODE_QUSGMII:
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_GMII:
+		caps |= MAC_1000HD | MAC_1000FD;
+		fallthrough;
+
+	case PHY_INTERFACE_MODE_REVRMII:
+	case PHY_INTERFACE_MODE_RMII:
+	case PHY_INTERFACE_MODE_SMII:
+	case PHY_INTERFACE_MODE_REVMII:
+	case PHY_INTERFACE_MODE_MII:
+		caps |= MAC_10HD | MAC_10FD;
+		fallthrough;
+
+	case PHY_INTERFACE_MODE_100BASEX:
+		caps |= MAC_100HD | MAC_100FD;
+		break;
+
+	case PHY_INTERFACE_MODE_TBI:
+	case PHY_INTERFACE_MODE_MOCA:
+	case PHY_INTERFACE_MODE_RTBI:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		caps |= MAC_1000HD;
+		fallthrough;
+	case PHY_INTERFACE_MODE_1000BASEKX:
+	case PHY_INTERFACE_MODE_TRGMII:
+		caps |= MAC_1000FD;
+		break;
+
+	case PHY_INTERFACE_MODE_2500BASEX:
+		caps |= MAC_2500FD;
+		break;
+
+	case PHY_INTERFACE_MODE_5GBASER:
+		caps |= MAC_5000FD;
+		break;
+
+	case PHY_INTERFACE_MODE_XGMII:
+	case PHY_INTERFACE_MODE_RXAUI:
+	case PHY_INTERFACE_MODE_XAUI:
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_10GKR:
+		caps |= MAC_10000FD;
+		break;
+
+	case PHY_INTERFACE_MODE_25GBASER:
+		caps |= MAC_25000FD;
+		break;
+
+	case PHY_INTERFACE_MODE_XLGMII:
+		caps |= MAC_40000FD;
+		break;
+
+	case PHY_INTERFACE_MODE_INTERNAL:
+		caps |= ~0;
+		break;
+
+	case PHY_INTERFACE_MODE_NA:
+	case PHY_INTERFACE_MODE_MAX:
+		break;
+	}
+
+	return caps;
+}
+EXPORT_SYMBOL_GPL(phy_interface_caps);
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 3b32be40073e..c05c0921c5d0 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -372,86 +372,9 @@ static unsigned long phylink_get_capabilities(phy_interface_t interface,
 					      int rate_matching)
 {
 	int max_speed = phylink_interface_max_speed(interface);
-	unsigned long caps = MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
+	unsigned long caps = phy_interface_caps(interface);
 	unsigned long matched_caps = 0;
 
-	switch (interface) {
-	case PHY_INTERFACE_MODE_USXGMII:
-		caps |= MAC_10000FD | MAC_5000FD;
-		fallthrough;
-
-	case PHY_INTERFACE_MODE_10G_QXGMII:
-		caps |= MAC_2500FD;
-		fallthrough;
-
-	case PHY_INTERFACE_MODE_RGMII_TXID:
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-	case PHY_INTERFACE_MODE_RGMII_ID:
-	case PHY_INTERFACE_MODE_RGMII:
-	case PHY_INTERFACE_MODE_PSGMII:
-	case PHY_INTERFACE_MODE_QSGMII:
-	case PHY_INTERFACE_MODE_QUSGMII:
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_GMII:
-		caps |= MAC_1000HD | MAC_1000FD;
-		fallthrough;
-
-	case PHY_INTERFACE_MODE_REVRMII:
-	case PHY_INTERFACE_MODE_RMII:
-	case PHY_INTERFACE_MODE_SMII:
-	case PHY_INTERFACE_MODE_REVMII:
-	case PHY_INTERFACE_MODE_MII:
-		caps |= MAC_10HD | MAC_10FD;
-		fallthrough;
-
-	case PHY_INTERFACE_MODE_100BASEX:
-		caps |= MAC_100HD | MAC_100FD;
-		break;
-
-	case PHY_INTERFACE_MODE_TBI:
-	case PHY_INTERFACE_MODE_MOCA:
-	case PHY_INTERFACE_MODE_RTBI:
-	case PHY_INTERFACE_MODE_1000BASEX:
-		caps |= MAC_1000HD;
-		fallthrough;
-	case PHY_INTERFACE_MODE_1000BASEKX:
-	case PHY_INTERFACE_MODE_TRGMII:
-		caps |= MAC_1000FD;
-		break;
-
-	case PHY_INTERFACE_MODE_2500BASEX:
-		caps |= MAC_2500FD;
-		break;
-
-	case PHY_INTERFACE_MODE_5GBASER:
-		caps |= MAC_5000FD;
-		break;
-
-	case PHY_INTERFACE_MODE_XGMII:
-	case PHY_INTERFACE_MODE_RXAUI:
-	case PHY_INTERFACE_MODE_XAUI:
-	case PHY_INTERFACE_MODE_10GBASER:
-	case PHY_INTERFACE_MODE_10GKR:
-		caps |= MAC_10000FD;
-		break;
-
-	case PHY_INTERFACE_MODE_25GBASER:
-		caps |= MAC_25000FD;
-		break;
-
-	case PHY_INTERFACE_MODE_XLGMII:
-		caps |= MAC_40000FD;
-		break;
-
-	case PHY_INTERFACE_MODE_INTERNAL:
-		caps |= ~0;
-		break;
-
-	case PHY_INTERFACE_MODE_NA:
-	case PHY_INTERFACE_MODE_MAX:
-		break;
-	}
-
 	switch (rate_matching) {
 	case RATE_MATCH_OPEN_LOOP:
 		/* TODO */
-- 
2.48.1


