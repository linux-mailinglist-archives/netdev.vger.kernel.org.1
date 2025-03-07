Return-Path: <netdev+bounces-173032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C79A56F2E
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05403A0457
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE55243387;
	Fri,  7 Mar 2025 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OMnhGE17"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22012417F2;
	Fri,  7 Mar 2025 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368984; cv=none; b=JuS1BqjKpcZ7W3ZstOL3rPli1SJs9JuPrtJUlgURDe4IQhdrl9s73wBmh2HGALtJsjD9Zobr28fRzW+DmbMr35BE+H/fSN6woTK1sNX2Uvs6ATWLTcupTpUq3u7aB5aZ/HFOdtWxycuBQiUZp4skea1JosoibQOt4u2TVw8FaWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368984; c=relaxed/simple;
	bh=lLb5IGm1xxzQfUic7GrdjTOe1g+8+RSwHIv2X7uAuKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fM6kwisp8zzHXj0Kce/nmlGEkWksnNAeZwmeo34DgPTdJcjfNs7gpzYLZhF9i5lYKYyUXemHXcuds2BYhqAooAtjwwGlo3SnG+9V9HPlqkKf7uAzd5EMClHj7kKgpPnK/PiENRmA6/wVke/qMY4F7YMDMUZ1s5r1JuRoUl3FdyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OMnhGE17; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7534F204D1;
	Fri,  7 Mar 2025 17:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741368981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXWh6+CcSwa+U0HiDCFi6L9hXXLtCi64vWuyjdAWeM8=;
	b=OMnhGE17/TK7PWwjKBerzzsal3wkgj7g//pNNh5mAinjUxQ/m4e066LNAxyPrDw4JN4x7i
	TE+QzgLT16aCLoebt3O6S+JU5nBTN5XbXjZlZlBwGKUvhI+RMj+hgHC0qF10zakoK1umOO
	1ESHFR44P+00kx2k6gGTvkI/d95pSFeh7oQoGigcK+NAHQ387PJuB5r1JFDHDcarU+FdRg
	Cotj7koQ9515TqogwXFNcS5DJs1VlXxK0fgk8Ck9fnZXImSobtYBVVoVzTXgLDdvYoZcTo
	9m/YtCa4vqdf5v34c8wW0DSWqByPPGkhfmeeCefCCcJy5V7QjTqbS0e8xKpMfA==
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
Subject: [PATCH net-next v5 05/13] net: phy: phy_caps: Introduce phy_caps_valid
Date: Fri,  7 Mar 2025 18:36:02 +0100
Message-ID: <20250307173611.129125-6-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmr
 giivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

With the link_capabilities array, it's trivial to validate a given mask
againts a <speed, duplex> tuple. Create a helper for that purpose, and
use it to replace a phy_settings lookup in phy_check_valid();

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-caps.h |  1 +
 drivers/net/phy/phy.c      |  2 +-
 drivers/net/phy/phy_caps.c | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index 1bef9cca62c5..1217686f1f91 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -43,6 +43,7 @@ int phy_caps_init(void);
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
index d43493884ff7..4ee8c25c8521 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -140,3 +140,22 @@ void phy_caps_linkmode_max_speed(u32 max_speed, unsigned long *linkmodes)
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


