Return-Path: <netdev+bounces-173035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F1CA56F33
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9C618993A6
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD35C24A079;
	Fri,  7 Mar 2025 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UqSaJ9Od"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6212459D0;
	Fri,  7 Mar 2025 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368988; cv=none; b=Ach8aHHtvu/qkexXnjWUoq7t+qMdFcYQdzh5u2dtb4YFpGqGuaioCDanHO4JFkdbOKwaql2jAhoIXExHxV9CIxKIKh7FMZQ/vxXWfxqxYkyFJFoUTT23JQVlhXnJfvCOX9pzgaj4AukUmXzuqfOwZKpekrdgAcSFy2T+vjLtn8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368988; c=relaxed/simple;
	bh=EtINOFWjN8cF2FjXNmwRkR6p4vBgDhoq8pjxnyvuLks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nX52x8HRhLbCVMERzoXMiviSLkoKRmZfPdhmutoNoxnF3l76fuHfTdAf8CmzQOme3jTRHxv7D/ILUnJAX2U9qCOCZTfw1ymkPBQTA1uERsAk7XnwnOZ8Iu1J4DgIDFMpdGmyXr1mnKAGJAwau3SaSBS8jMNWMNLuoosRxMO3Bx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UqSaJ9Od; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A1B520479;
	Fri,  7 Mar 2025 17:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741368985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HVd3r6xyUhzL3YyY3xmXBLCsInUdeXPR3YjTneAcH4c=;
	b=UqSaJ9Odb+/iV2DBDMwtNuqm+7hlDAHnUg7Q4RSEjoOSVdzZZ0PXkofi6IODm4uU/llrfh
	OFf2hY/lDMBnk/PFoPyaZGPr9LUtah1+OGeRhTMkpb33Fgj0XF7kdMAWQj7EcL3Hc2p/fK
	WwEYeLLXWZ7LOW0aHsl5VOV7XsTZl1XN50rkL5N9Izwlot/FdIt6WJBjSiORpA8hLZVw/x
	JonZIeJrQzQZ6zym2CuSwnHmTmmJ7pZ6bIxlXcNJDAR3xSA/HE8nzDGPiPp1V/21fzsJCz
	bLeoC4QIWXXLHJzp/cDg2mE2+0Pjl2m8qJmLye1lUvB30VuycITrpBX8DtCkTA==
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
Subject: [PATCH net-next v5 08/13] net: phy: phy_device: Use link_capabilities lookup for PHY aneg config
Date: Fri,  7 Mar 2025 18:36:05 +0100
Message-ID: <20250307173611.129125-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgepjeenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmr
 giivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

When configuring PHY advertising with autoneg disabled, we lookd for an
exact linkmode to advertise and configure for the requested Speed and
Duplex, specially at or over 1G.

Using phy_caps_lookup allows us to build a list of the supported
linkmodes at that speed that we can advertise instead of the first mode
that matches.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 4980862398d0..3f734e847e8e 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2120,7 +2120,7 @@ EXPORT_SYMBOL(genphy_check_and_restart_aneg);
 int __genphy_config_aneg(struct phy_device *phydev, bool changed)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(fixed_advert);
-	const struct phy_setting *set;
+	const struct link_capabilities *c;
 	unsigned long *advert;
 	int err;
 
@@ -2146,10 +2146,11 @@ int __genphy_config_aneg(struct phy_device *phydev, bool changed)
 	} else {
 		linkmode_zero(fixed_advert);
 
-		set = phy_lookup_setting(phydev->speed, phydev->duplex,
-					 phydev->supported, true);
-		if (set)
-			linkmode_set_bit(set->bit, fixed_advert);
+		c = phy_caps_lookup(phydev->speed, phydev->duplex,
+				    phydev->supported, true);
+		if (c)
+			linkmode_and(fixed_advert, phydev->supported,
+				     c->linkmodes);
 
 		advert = fixed_advert;
 	}
-- 
2.48.1


