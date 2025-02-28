Return-Path: <netdev+bounces-170744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B76A49C7B
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784A63B9D94
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC0327126D;
	Fri, 28 Feb 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MWm4p5Q3"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417F7183CC3;
	Fri, 28 Feb 2025 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754548; cv=none; b=XEwrQSMimRmB+4jPzbMuCljJOaQKcLaZisrS8a3WlsYQRN6U7ZvRFD7ilvLydIBfqKTfy5gzyBYTFtBBeVlk5qO2044DNP/uAE/bsGButIAe9VNMQbnW4JYshOZRFxasB+rQF0pEm0yoHxqZnhrPiyNF6jCsxxWanr89uLwYizY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754548; c=relaxed/simple;
	bh=M5X7Sv+Rw5spgUv/ENrqLytpPLVwMEeHG2a7O//bROE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfg0LrLrK6LyW3RMrbKCmDRUhzWKSzdkYWXZNqkBD39OKPqzVCVd8KpPeVE5pP4VSPk6Oxxd2mTJDD2wpmsaNIZf9EGrnFEwD7ruzOgKFLdPbcokgcSAw1MOw+DrhLtmkF/YRIpDMKLorgzpSN2DBadVzS75Xn9QOjiJ88hO1dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MWm4p5Q3; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C4FE4341A;
	Fri, 28 Feb 2025 14:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740754544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSOuv+Cq2XOdE+gyQcZoQt6plaS3Tn4srk0koyuw3xY=;
	b=MWm4p5Q3a8h34AUkYC2Gk1NnmeFay+UCwoti8uUW7CrDutzH+RjBKjk2v95cVYsyFMz28F
	c3HM95AqJVRA4jVxkNGO3PrTkVv4pnXKIBol9QtaYNkmRoakcsNXO2pSuzhCSXoupZhUwf
	AYL06iMTrifW2/uGEmltnrLmgI8bD8JnnLzyz6xCj9InNwU+IFPYFiGWn9pz/mzRqLj3PE
	6r62dTgZgYdhCzxm52ggTmihXy4Mtw/lQkOykjbfUwuOZKYIRm9DG8bMBFLWRHsSOpXQH2
	tHr219iSexfc1qMEPH2rVLNEa56cy6qikl9X+x55XnkfGLF5u9KYiQpwGx9gAQ==
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
Subject: [PATCH net-next v3 01/13] net: ethtool: Export the link_mode_params definitions
Date: Fri, 28 Feb 2025 15:55:26 +0100
Message-ID: <20250228145540.2209551-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228145540.2209551-1-maxime.chevallier@bootlin.com>
References: <20250228145540.2209551-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgri
 igvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

link_mode_params contains a lookup table of all 802.3 link modes that
are currently supported with structured data about each mode's speed,
duplex, number of lanes and mediums.

As a preparation for a port representation, export that table for the
rest of the net stack to use.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 include/linux/ethtool.h | 8 ++++++++
 net/ethtool/common.c    | 1 +
 net/ethtool/common.h    | 7 -------
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 7f222dccc7d1..8210ece94fa6 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -210,6 +210,14 @@ static inline u8 *ethtool_rxfh_context_key(struct ethtool_rxfh_context *ctx)
 
 void ethtool_rxfh_context_lost(struct net_device *dev, u32 context_id);
 
+struct link_mode_info {
+	int                             speed;
+	u8                              lanes;
+	u8                              duplex;
+};
+
+extern const struct link_mode_info link_mode_params[];
+
 /* declare a link mode bitmap */
 #define __ETHTOOL_DECLARE_LINK_MODE_MASK(name)		\
 	DECLARE_BITMAP(name, __ETHTOOL_LINK_MODE_MASK_NBITS)
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index ac8b6107863e..c9d6302e88c9 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -423,6 +423,7 @@ const struct link_mode_info link_mode_params[] = {
 	__DEFINE_LINK_MODE_PARAMS(800000, VR4, Full),
 };
 static_assert(ARRAY_SIZE(link_mode_params) == __ETHTOOL_LINK_MODE_MASK_NBITS);
+EXPORT_SYMBOL_GPL(link_mode_params);
 
 const char netif_msg_class_names[][ETH_GSTRING_LEN] = {
 	[NETIF_MSG_DRV_BIT]		= "drv",
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index a1088c2441d0..b4683d286a5a 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -15,12 +15,6 @@
 #define __SOF_TIMESTAMPING_CNT (const_ilog2(SOF_TIMESTAMPING_LAST) + 1)
 #define __HWTSTAMP_FLAG_CNT (const_ilog2(HWTSTAMP_FLAG_LAST) + 1)
 
-struct link_mode_info {
-	int				speed;
-	u8				lanes;
-	u8				duplex;
-};
-
 struct genl_info;
 struct hwtstamp_provider_desc;
 
@@ -33,7 +27,6 @@ tunable_strings[__ETHTOOL_TUNABLE_COUNT][ETH_GSTRING_LEN];
 extern const char
 phy_tunable_strings[__ETHTOOL_PHY_TUNABLE_COUNT][ETH_GSTRING_LEN];
 extern const char link_mode_names[][ETH_GSTRING_LEN];
-extern const struct link_mode_info link_mode_params[];
 extern const char netif_msg_class_names[][ETH_GSTRING_LEN];
 extern const char wol_mode_names[][ETH_GSTRING_LEN];
 extern const char sof_timestamping_names[][ETH_GSTRING_LEN];
-- 
2.48.1


