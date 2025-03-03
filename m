Return-Path: <netdev+bounces-171121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFE2A4BA2F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E751884229
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2E91EFFB0;
	Mon,  3 Mar 2025 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Xth63yyV"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC921EF099;
	Mon,  3 Mar 2025 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992618; cv=none; b=Eng/JlSCfC2UvGaLmMTfv8J9XJneEOCbtO2gQw6vgde77NKw+PjFoLq8S7JwoDw4cGpsyCSNThDZlH5EWzlOmkJv6IykehvT07s2wkuW8P22avx+Q9+Flnlnlcvr+0AQA1uaoYBoaUj0NXsTsjZVDzY7IpydYwmW+ukutdHCTdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992618; c=relaxed/simple;
	bh=Atf+N797ReonutHfaP/NEiyZsTvsa7qMERZI0s74rlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omQRzKYsUCo3kfYBIqbWEfBxBdoBM1XXZPpdlHL61jRyndyldSTf2tE+Bt/7txfiaRU9565w1fzbvsSHRRNYtBvP1SK3B9ZZbsCwpNrXPzcnSaN07VjtxIlRE9BMs3nTm1BXsTI622pEd+HcZ04ABMIHrZ/gVA5rVga2iOpT5CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Xth63yyV; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB4FF433D6;
	Mon,  3 Mar 2025 09:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740992613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srKaH+dUPNcj7myLBF3rWvtWswbd4aKF0FGqhtNPS/A=;
	b=Xth63yyVKef/3QCJn/XXggPX9L2ePfszv42r5rzFuDUcWBvJtzlCnfsrHYL5Pdv650CCjx
	E4I7BsxEhNCdBHSzAGiUwVm9QNILcyE8XBvDwsNH809XDY5xewyGQFCmgtvqzBWcLNqRtm
	x8wKmQ6N1CGA7vYceLZ7GrJbVfzVWyqzvZLg6b0QIdqqDpc9f5pA2bUNxvnVizHy4qrXdU
	+41Zt+fgTBIXyyYsJY2IEY9Ez57niUgCwxc1aAXzSVtZy8eDoIkHwKFDsgjsE12Gi5VdwJ
	GFpRRQFVoE19X7lKYZohG3TLKNYezvYflrz7VmdcTnN4CkNn/Dzmd+Kqfe739g==
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
Subject: [PATCH net-next v4 05/13] net: phy: phy_caps: Introduce phy_caps_valid
Date: Mon,  3 Mar 2025 10:03:11 +0100
Message-ID: <20250303090321.805785-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
References: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgri
 igvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

With the link_capabilities array, it's trivial to validate a given mask
againts a <speed, duplex> tuple. Create a helper for that purpose, and
use it to replace a phy_settings lookup in phy_check_valid();

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V4: No changes

 drivers/net/phy/phy-caps.h |  1 +
 drivers/net/phy/phy.c      |  2 +-
 drivers/net/phy/phy_caps.c | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index a44d983eaed8..f35ede4e557d 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -43,6 +43,7 @@ void phy_caps_init(void);
 size_t phy_caps_speeds(unsigned int *speeds, size_t size,
 		       unsigned long *linkmodes);
 void phy_caps_linkmode_max_speed(u32 max_speed, unsigned long *linkmodes);
+bool phy_caps_valid(int speed, int duplex, const unsigned long *linkmodes);
 
 
 #endif /* __PHY_CAPS_H */
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 3128df03feda..8df37d221fba 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -260,7 +260,7 @@ unsigned int phy_supported_speeds(struct phy_device *phy,
  */
 bool phy_check_valid(int speed, int duplex, unsigned long *features)
 {
-	return !!phy_lookup_setting(speed, duplex, features, true);
+	return phy_caps_valid(speed, duplex, features);
 }
 EXPORT_SYMBOL(phy_check_valid);
 
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 132758d2eb8d..8ce7dca1acd0 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -128,3 +128,22 @@ void phy_caps_linkmode_max_speed(u32 max_speed, unsigned long *linkmodes)
 		else
 			break;
 }
+
+/**
+ * phy_caps_valid() - Validate a linkmodes set agains given speed and duplex
+ * @speed: input speed to validate
+ * @duplex: input duplex to validate. Passing DUPLEX_UNKNOWN is always not valid
+ * @linkmodes: The linkmodes to validate
+ *
+ * Returns: True if at least one of the linkmodes in @linkmodes can function at
+ *          the given speed and duplex, false otherwise.
+ */
+bool phy_caps_valid(int speed, int duplex, const unsigned long *linkmodes)
+{
+	int capa = speed_duplex_to_capa(speed, duplex);
+
+	if (capa < 0)
+		return false;
+
+	return linkmode_intersects(link_caps[capa].linkmodes, linkmodes);
+}
-- 
2.48.1


