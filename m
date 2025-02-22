Return-Path: <netdev+bounces-168762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D64A408F6
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 15:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3234243CC
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 14:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4DA15DBBA;
	Sat, 22 Feb 2025 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ux6kvDMw"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20B414F9D6;
	Sat, 22 Feb 2025 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740234463; cv=none; b=UZJSsVzkwi41jEPT+JW0S3kdu3a+gvRhaSQxbUN9bqhH1HDwfEczDkVZ5/AQqRF2+d1JHt/+HUY0LSKKwQz5IXyz93fZusa630wTCfMPyqfZM96lMNvHEBb0CY7KzREU7P3d3Ma+8M0oNq2cQx53hXrO/69FykIl37LEZukwrMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740234463; c=relaxed/simple;
	bh=vOYDqW0HfeDL/Pz5q4HVeFsI4G6dTIulKBxNPdVP0Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3hdgjXjsmSyNLEh1lYCsD5UIoAl3WugAKpx0bI03tT/VVknE4geQgh4CxIkmv191k7wzRIjDbmaPIjZNDAc5pvA4sHptLOVSmHxCpS0IGuGWdct/cZr2seHbtj751KMJ0G0ByYuMt4E/8uYhZcKfwHFwrwnCHo5PeT591fr9cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ux6kvDMw; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0B0A744281;
	Sat, 22 Feb 2025 14:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740234459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSHuPH0rENT+1th6n9nmKUNo1W0iP2PY60TKUpIRiFg=;
	b=Ux6kvDMwD2sAXkP7gvbfJ4bCvU8z52UM3vV+mEeIxAcHeTCe3L5dlRl6kDqg0Eq4107EAv
	RqQKmk09M8GqY15xe/rm0NOrduwprmRsKim+QL/FJpGsRCg+WK169OCYECaeRLcoWROI3q
	CZLtav528jRPwXTFc9yM/3ea8+Btnqx3U2tUR9r1SU8ry+quNafgzP8MUaR0fn/PhM74df
	VDzr+n4bsAdZH55sPFq4fYXOUUkufxkVlBBGDFW2QwKqHogwZZjk3NJe5yTQCqSOj/P0we
	eB44K9NV+zDgXnyUKy7rthbcLRYsoEtL5aPqJY49ShPH8pLZSsYgitE66fx9DQ==
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
Subject: [PATCH net-next 05/13] net: phy: Use an internal, searchable storage for the linkmodes
Date: Sat, 22 Feb 2025 15:27:17 +0100
Message-ID: <20250222142727.894124-6-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejfeduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgri
 igvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

The canonical definition for all the link modes is in linux/ethtol.h,
which is complemented by the link_mode_params array stored in
net/ethtool/common.h . That array contains all the metadata about each
of these modes, including the Speed and Duplex information.

Phylib and phylink needs that information as well for internal
managmement of the link, which was done by duplicating that information
in locally-stored arrays and lookup functions. This makes it easy for
developpers adding new modes to forget modifying phylib and phylink
accordingly.

However, the link_mode_params array in net/ethtool/common.c is fairly
inefficient to search through, as it isn't sorted in any manner. Phylib
and phylink perform a lot of lookup operations, mostly to filter modes
by speed and/or duplex.

We therefore introduce the link_caps private array in phy_caps.c, that
indexes linkmodes in a more efficient manner. Each element associated a
tuple <speed, duplex> to a bitfield of all the linkmodes runs at these
speed/duplex.

We end-up with an array that's fairly short, easily addressable and that
it optimised for the typical use-cases of phylib/phylink.

That array is initialized at the same time as phylib. As the
link_mode_params array is part of the net stack, which phylink depends
on, it should always be accessible from phylib.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-caps.h   |   9 ++
 drivers/net/phy/phy_caps.c   | 260 +++++++++++++++++++----------------
 drivers/net/phy/phy_device.c |   3 +
 3 files changed, 154 insertions(+), 118 deletions(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index 9580754fff1f..0c7543280fa3 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -7,6 +7,15 @@
 #ifndef __PHY_CAPS_H
 #define __PHY_CAPS_H
 
+#include <linux/ethtool.h>
+
+struct link_capabilities {
+	int speed;
+	unsigned int duplex;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(linkmodes);
+};
+
+void phy_caps_init(void);
 void linkmode_from_caps(unsigned long *linkmode, unsigned long caps);
 
 unsigned long phy_interface_caps(phy_interface_t interface);
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index cf68a2829bde..55ac08edf151 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -7,6 +7,101 @@
 
 #include "phy-caps.h"
 
+enum {
+	LINK_CAPA_10HD = 0,
+	LINK_CAPA_10FD,
+	LINK_CAPA_100HD,
+	LINK_CAPA_100FD,
+	LINK_CAPA_1000HD,
+	LINK_CAPA_1000FD,
+	LINK_CAPA_2500FD,
+	LINK_CAPA_5000FD,
+	LINK_CAPA_10000FD,
+	LINK_CAPA_20000FD,
+	LINK_CAPA_25000FD,
+	LINK_CAPA_40000FD,
+	LINK_CAPA_50000FD,
+	LINK_CAPA_56000FD,
+	LINK_CAPA_100000FD,
+	LINK_CAPA_200000FD,
+	LINK_CAPA_400000FD,
+	LINK_CAPA_800000FD,
+
+	__LINK_CAPA_LAST = LINK_CAPA_800000FD,
+	__LINK_CAPA_MAX,
+};
+
+static struct link_capabilities link_caps[__LINK_CAPA_MAX] __ro_after_init = {
+	{ SPEED_10, DUPLEX_HALF, {0} }, /* LINK_CAPA_10HD */
+	{ SPEED_10, DUPLEX_FULL, {0} }, /* LINK_CAPA_10FD */
+	{ SPEED_100, DUPLEX_HALF, {0} }, /* LINK_CAPA_100HD */
+	{ SPEED_100, DUPLEX_FULL, {0} }, /* LINK_CAPA_100FD */
+	{ SPEED_1000, DUPLEX_HALF, {0} }, /* LINK_CAPA_1000HD */
+	{ SPEED_1000, DUPLEX_FULL, {0} }, /* LINK_CAPA_1000FD */
+	{ SPEED_2500, DUPLEX_FULL, {0} }, /* LINK_CAPA_2500FD */
+	{ SPEED_5000, DUPLEX_FULL, {0} }, /* LINK_CAPA_5000FD */
+	{ SPEED_10000, DUPLEX_FULL, {0} }, /* LINK_CAPA_10000FD */
+	{ SPEED_20000, DUPLEX_FULL, {0} }, /* LINK_CAPA_20000FD */
+	{ SPEED_25000, DUPLEX_FULL, {0} }, /* LINK_CAPA_25000FD */
+	{ SPEED_40000, DUPLEX_FULL, {0} }, /* LINK_CAPA_40000FD */
+	{ SPEED_50000, DUPLEX_FULL, {0} }, /* LINK_CAPA_50000FD */
+	{ SPEED_56000, DUPLEX_FULL, {0} }, /* LINK_CAPA_56000FD */
+	{ SPEED_100000, DUPLEX_FULL, {0} }, /* LINK_CAPA_100000FD */
+	{ SPEED_200000, DUPLEX_FULL, {0} }, /* LINK_CAPA_200000FD */
+	{ SPEED_400000, DUPLEX_FULL, {0} }, /* LINK_CAPA_400000FD */
+	{ SPEED_800000, DUPLEX_FULL, {0} }, /* LINK_CAPA_800000FD */
+};
+
+static int speed_duplex_to_capa(int speed, unsigned int duplex)
+{
+	if (duplex == DUPLEX_UNKNOWN ||
+	    (speed > SPEED_1000 && duplex != DUPLEX_FULL))
+		return -EINVAL;
+
+	switch (speed) {
+	case SPEED_10: return duplex == DUPLEX_FULL ?
+			      LINK_CAPA_10FD : LINK_CAPA_10HD;
+	case SPEED_100: return duplex == DUPLEX_FULL ?
+			       LINK_CAPA_100FD : LINK_CAPA_100HD;
+	case SPEED_1000: return duplex == DUPLEX_FULL ?
+				LINK_CAPA_1000FD : LINK_CAPA_1000HD;
+	case SPEED_2500: return LINK_CAPA_2500FD;
+	case SPEED_5000: return LINK_CAPA_5000FD;
+	case SPEED_10000: return LINK_CAPA_10000FD;
+	case SPEED_20000: return LINK_CAPA_20000FD;
+	case SPEED_25000: return LINK_CAPA_25000FD;
+	case SPEED_40000: return LINK_CAPA_40000FD;
+	case SPEED_50000: return LINK_CAPA_50000FD;
+	case SPEED_56000: return LINK_CAPA_56000FD;
+	case SPEED_100000: return LINK_CAPA_100000FD;
+	case SPEED_200000: return LINK_CAPA_200000FD;
+	case SPEED_400000: return LINK_CAPA_400000FD;
+	case SPEED_800000: return LINK_CAPA_800000FD;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * phy_caps_init() - Initializes the link_caps array from the link_mode_params.
+ */
+void phy_caps_init(void)
+{
+	const struct link_mode_info *linkmode;
+	int i, capa;
+
+	/* Fill the caps array from net/ethtool/common.c */
+	for (i = 0; i < __ETHTOOL_LINK_MODE_MASK_NBITS; i++) {
+		linkmode = &link_mode_params[i];
+		capa = speed_duplex_to_capa(linkmode->speed, linkmode->duplex);
+
+		if (capa < 0)
+			continue;
+
+		__set_bit(i, link_caps[capa].linkmodes);
+	}
+}
+
 /**
  * linkmode_from_caps() - Convert capabilities to ethtool link modes
  * @linkmodes: ethtool linkmode mask (must be already initialised)
@@ -24,140 +119,69 @@ void linkmode_from_caps(unsigned long *linkmodes, unsigned long caps)
 	if (caps & MAC_ASYM_PAUSE)
 		__set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, linkmodes);
 
-	if (caps & MAC_10HD) {
-		__set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10baseT1S_Half_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT, linkmodes);
-	}
+	if (caps & MAC_10HD)
+		linkmode_or(linkmodes, linkmodes,
+			    link_caps[LINK_CAPA_10HD].linkmodes);
 
-	if (caps & MAC_10FD) {
-		__set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10baseT1L_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10baseT1S_Full_BIT, linkmodes);
-	}
+	if (caps & MAC_10FD)
+		linkmode_or(linkmodes, linkmodes,
+			    link_caps[LINK_CAPA_10FD].linkmodes);
 
-	if (caps & MAC_100HD) {
-		__set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100baseFX_Half_BIT, linkmodes);
-	}
+	if (caps & MAC_100HD)
+		linkmode_or(linkmodes, linkmodes,
+			    link_caps[LINK_CAPA_100HD].linkmodes);
 
-	if (caps & MAC_100FD) {
-		__set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100baseFX_Full_BIT, linkmodes);
-	}
+	if (caps & MAC_100FD)
+		linkmode_or(linkmodes, linkmodes,
+			    link_caps[LINK_CAPA_100FD].linkmodes);
 
 	if (caps & MAC_1000HD)
-		__set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, linkmodes);
+		linkmode_or(linkmodes, linkmodes,
+			    link_caps[LINK_CAPA_1000HD].linkmodes);
 
-	if (caps & MAC_1000FD) {
-		__set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_1000baseKX_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_1000baseT1_Full_BIT, linkmodes);
-	}
+	if (caps & MAC_1000FD)
+		linkmode_or(linkmodes, linkmodes,
+			    link_caps[LINK_CAPA_1000FD].linkmodes);
 
-	if (caps & MAC_2500FD) {
-		__set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, linkmodes);
-	}
+	if (caps & MAC_2500FD)
+		linkmode_or(linkmodes, linkmodes,
+			    link_caps[LINK_CAPA_2500FD].linkmodes);
 
 	if (caps & MAC_5000FD)
-		__set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, linkmodes);
-
-	if (caps & MAC_10000FD) {
-		__set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10000baseR_FEC_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10000baseCR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10000baseSR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10000baseLR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10000baseLRM_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10000baseER_Full_BIT, linkmodes);
-	}
+		linkmode_or(linkmodes, linkmodes,
+			    link_caps[LINK_CAPA_5000FD].linkmodes);
 
-	if (caps & MAC_25000FD) {
-		__set_bit(ETHTOOL_LINK_MODE_25000baseCR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_25000baseKR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_25000baseSR_Full_BIT, linkmodes);
-	}
+	if (caps & MAC_10000FD)
+		linkmode_or(linkmodes, linkmodes,
+			    link_caps[LINK_CAPA_10000FD].linkmodes);
 
-	if (caps & MAC_40000FD) {
-		__set_bit(ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT, linkmodes);
-	}
+	if (caps & MAC_25000FD)
+		linkmode_or(linkmodes, linkmodes,
+			    link_caps[LINK_CAPA_25000FD].linkmodes);
 
-	if (caps & MAC_50000FD) {
-		__set_bit(ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_50000baseKR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_50000baseSR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_50000baseCR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_50000baseLR_ER_FR_Full_BIT,
-			  linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_50000baseDR_Full_BIT, linkmodes);
-	}
+	if (caps & MAC_40000FD)
+		linkmode_or(linkmodes, linkmodes,
+			    link_caps[LINK_CAPA_40000FD].linkmodes);
 
-	if (caps & MAC_56000FD) {
-		__set_bit(ETHTOOL_LINK_MODE_56000baseKR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_56000baseCR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_56000baseSR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_56000baseLR4_Full_BIT, linkmodes);
-	}
+	if (caps & MAC_50000FD)
+		linkmode_or(linkmodes, linkmodes,
+			    link_caps[LINK_CAPA_50000FD].linkmodes);
 
-	if (caps & MAC_100000FD) {
-		__set_bit(ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
-			  linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseSR2_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseLR2_ER2_FR2_Full_BIT,
-			  linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseDR2_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseKR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseSR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseLR_ER_FR_Full_BIT,
-			  linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseCR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseDR_Full_BIT, linkmodes);
-	}
+	if (caps & MAC_56000FD)
+		linkmode_or(linkmodes, linkmodes,
+			    link_caps[LINK_CAPA_56000FD].linkmodes);
 
-	if (caps & MAC_200000FD) {
-		__set_bit(ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_200000baseSR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT,
-			  linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_200000baseDR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_200000baseKR2_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_200000baseSR2_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_200000baseLR2_ER2_FR2_Full_BIT,
-			  linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_200000baseDR2_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_200000baseCR2_Full_BIT, linkmodes);
-	}
+	if (caps & MAC_100000FD)
+		linkmode_or(linkmodes, linkmodes,
+			    link_caps[LINK_CAPA_100000FD].linkmodes);
 
-	if (caps & MAC_400000FD) {
-		__set_bit(ETHTOOL_LINK_MODE_400000baseKR8_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_400000baseSR8_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_400000baseLR8_ER8_FR8_Full_BIT,
-			  linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_400000baseDR8_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_400000baseCR8_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_400000baseKR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_400000baseSR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_400000baseLR4_ER4_FR4_Full_BIT,
-			  linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_400000baseDR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_400000baseCR4_Full_BIT, linkmodes);
-	}
+	if (caps & MAC_200000FD)
+		linkmode_or(linkmodes, linkmodes,
+			    link_caps[LINK_CAPA_200000FD].linkmodes);
+
+	if (caps & MAC_400000FD)
+		linkmode_or(linkmodes, linkmodes,
+			    link_caps[LINK_CAPA_400000FD].linkmodes);
 }
 EXPORT_SYMBOL_GPL(linkmode_from_caps);
 
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 7c4e1ad1864c..be54dc9612dd 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -41,6 +41,8 @@
 #include <linux/uaccess.h>
 #include <linux/unistd.h>
 
+#include "phy-caps.h"
+
 MODULE_DESCRIPTION("PHY library");
 MODULE_AUTHOR("Andy Fleming");
 MODULE_LICENSE("GPL");
@@ -3793,6 +3795,7 @@ static int __init phy_init(void)
 	if (rc)
 		goto err_ethtool_phy_ops;
 
+	phy_caps_init();
 	features_init();
 
 	rc = phy_driver_register(&genphy_c45_driver, THIS_MODULE);
-- 
2.48.1


