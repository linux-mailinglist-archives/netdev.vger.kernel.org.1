Return-Path: <netdev+bounces-171132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232FBA4BA46
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED4F16D7C7
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DD81F3D56;
	Mon,  3 Mar 2025 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hZ7LUrL2"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12BD1F1911;
	Mon,  3 Mar 2025 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992624; cv=none; b=nHbgcPLl822sq6PeiGJYhjtS7WvIE2/scMqK86xhOrIASane8smHVwOw7CdJfdJDlzZ9uGS2aKyzV8q0aV6wMNZqL3mJtRWHUkpy5+U6QqRjHkYKiGXxFF/gpryCrMHs+QaGVGWb3h+8CKSsTnvgaTXp8AHC/jqoKF0Bv7JRqWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992624; c=relaxed/simple;
	bh=4o2l2/m6ECwcVOsXIRv4XW3evUKC472hxDj0NUnJcOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSk83TfFpVBhFOigN/v9NaWfyutTEJoWXUsSpFXr78Da/2+6gc9b/ighkPgBIi+uELLjONvRBc4XItrIF04hN+CKl9N8NRwt5sXz8DQJOKcXt8zHQh5/zem1ACsbrIz8yFZh8dCupda6Z+U5I0L48x+ZIroQDWnXxeCieGrqfrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hZ7LUrL2; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6C83744536;
	Mon,  3 Mar 2025 09:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740992620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QYsR2ibsJb972uOv9b0xyVcdCGgk/tt+2DbI9Bn3NdA=;
	b=hZ7LUrL2pU3+jhTvJI0tlIkKzoZUESl/oHomtFhGQnLUPqTo0sp8J9/UxknhXAelOyXXe4
	TIYony2Se/yZliHtSz/SY4RzSWrNGFN8fu3T96BZx67Vo8O58mWAA4it+MpO+Q6M0Jfy0f
	MjhHXNhKpACG+pK0Nkw+FbFAz60r/yIhH/QjAm/bLNpdvjHJUYt4eL+OUFfVyTVEYDaPoc
	H5Oh7koEnZjqvjsA2Npf0e/dS/395sFvCCtvC+TwBeWuAwsOXKoGaXoePZUFixVShO30dc
	50Fob5Svr0nobkIYYv3b15y5AiUcTls76X+lhwXv/goFWq/0mO6NYOrg7YE3mA==
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
Subject: [PATCH net-next v4 11/13] net: phylink: Add a mapping between MAC_CAPS and LINK_CAPS
Date: Mon,  3 Mar 2025 10:03:17 +0100
Message-ID: <20250303090321.805785-12-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgri
 igvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

phylink allows MAC drivers to report the capabilities in terms of speed,
duplex and pause support. This is done through a dedicated set of enum
values in the form of the MAC_ capabilities. They are very close to what
the LINK_CAPA_xxx can express, with the difference that LINK_CAPA don't
have any information about Pause/Asym Pause support.

To prepare converting phylink to using the phy_caps, add the mapping
between MAC capabilities and phy_caps. While doing so, we move the
phylink_caps_params array up a bit to simplify future commits.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V4: No changes

 drivers/net/phy/phylink.c | 49 ++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 0b9585cb508e..9cb3beec9f47 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -292,6 +292,31 @@ static int phylink_interface_max_speed(phy_interface_t interface)
 	return SPEED_UNKNOWN;
 }
 
+static struct {
+	unsigned long mask;
+	int speed;
+	unsigned int duplex;
+	unsigned int caps_bit;
+} phylink_caps_params[] = {
+	{ MAC_400000FD, SPEED_400000, DUPLEX_FULL, BIT(LINK_CAPA_400000FD) },
+	{ MAC_200000FD, SPEED_200000, DUPLEX_FULL, BIT(LINK_CAPA_200000FD) },
+	{ MAC_100000FD, SPEED_100000, DUPLEX_FULL, BIT(LINK_CAPA_100000FD) },
+	{ MAC_56000FD,  SPEED_56000,  DUPLEX_FULL, BIT(LINK_CAPA_56000FD) },
+	{ MAC_50000FD,  SPEED_50000,  DUPLEX_FULL, BIT(LINK_CAPA_50000FD) },
+	{ MAC_40000FD,  SPEED_40000,  DUPLEX_FULL, BIT(LINK_CAPA_40000FD) },
+	{ MAC_25000FD,  SPEED_25000,  DUPLEX_FULL, BIT(LINK_CAPA_25000FD) },
+	{ MAC_20000FD,  SPEED_20000,  DUPLEX_FULL, BIT(LINK_CAPA_20000FD) },
+	{ MAC_10000FD,  SPEED_10000,  DUPLEX_FULL, BIT(LINK_CAPA_10000FD) },
+	{ MAC_5000FD,   SPEED_5000,   DUPLEX_FULL, BIT(LINK_CAPA_5000FD) },
+	{ MAC_2500FD,   SPEED_2500,   DUPLEX_FULL, BIT(LINK_CAPA_2500FD) },
+	{ MAC_1000FD,   SPEED_1000,   DUPLEX_FULL, BIT(LINK_CAPA_1000FD) },
+	{ MAC_1000HD,   SPEED_1000,   DUPLEX_HALF, BIT(LINK_CAPA_1000HD) },
+	{ MAC_100FD,    SPEED_100,    DUPLEX_FULL, BIT(LINK_CAPA_100FD) },
+	{ MAC_100HD,    SPEED_100,    DUPLEX_HALF, BIT(LINK_CAPA_100HD) },
+	{ MAC_10FD,     SPEED_10,     DUPLEX_FULL, BIT(LINK_CAPA_10FD) },
+	{ MAC_10HD,     SPEED_10,     DUPLEX_HALF, BIT(LINK_CAPA_10HD) },
+};
+
 /**
  * phylink_caps_to_linkmodes() - Convert capabilities to ethtool link modes
  * @linkmodes: ethtool linkmode mask (must be already initialised)
@@ -445,30 +470,6 @@ static void phylink_caps_to_linkmodes(unsigned long *linkmodes,
 	}
 }
 
-static struct {
-	unsigned long mask;
-	int speed;
-	unsigned int duplex;
-} phylink_caps_params[] = {
-	{ MAC_400000FD, SPEED_400000, DUPLEX_FULL },
-	{ MAC_200000FD, SPEED_200000, DUPLEX_FULL },
-	{ MAC_100000FD, SPEED_100000, DUPLEX_FULL },
-	{ MAC_56000FD,  SPEED_56000,  DUPLEX_FULL },
-	{ MAC_50000FD,  SPEED_50000,  DUPLEX_FULL },
-	{ MAC_40000FD,  SPEED_40000,  DUPLEX_FULL },
-	{ MAC_25000FD,  SPEED_25000,  DUPLEX_FULL },
-	{ MAC_20000FD,  SPEED_20000,  DUPLEX_FULL },
-	{ MAC_10000FD,  SPEED_10000,  DUPLEX_FULL },
-	{ MAC_5000FD,   SPEED_5000,   DUPLEX_FULL },
-	{ MAC_2500FD,   SPEED_2500,   DUPLEX_FULL },
-	{ MAC_1000FD,   SPEED_1000,   DUPLEX_FULL },
-	{ MAC_1000HD,   SPEED_1000,   DUPLEX_HALF },
-	{ MAC_100FD,    SPEED_100,    DUPLEX_FULL },
-	{ MAC_100HD,    SPEED_100,    DUPLEX_HALF },
-	{ MAC_10FD,     SPEED_10,     DUPLEX_FULL },
-	{ MAC_10HD,     SPEED_10,     DUPLEX_HALF },
-};
-
 /**
  * phylink_limit_mac_speed - limit the phylink_config to a maximum speed
  * @config: pointer to a &struct phylink_config
-- 
2.48.1


