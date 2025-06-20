Return-Path: <netdev+bounces-199696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D532AE1750
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 11:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147893A8A9C
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 09:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E99D27FD70;
	Fri, 20 Jun 2025 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Nt7sXCtR"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0E7D098;
	Fri, 20 Jun 2025 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750411017; cv=none; b=OR0Z3bAgIZwCyvQeBzUdaP0wWRoirxPlu9xY21VLp+rluSg6HqUMgps8wqSE6KkkyrPMki2cxaIqSY3gEQo+c6pf5lXV4tEsbiu6A6yiy+7ZDlcuDUZ/xEe/3aXQSxV2oLsO1ddhj2fbrTSkmtwjB5kDvUuPFz/ICm/iSA2a3oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750411017; c=relaxed/simple;
	bh=BXxq6Y7DBWbFNBAXMitHhSYyF7f5Iw2lFPYWudNLVWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=COOnJxbs6qLcVQKTE91Fu4ZOUre1vsVIuS5xwiN52kX6UO9vHF4IHb8czdd6+zPBLMwMm/yICEY9xajVsvGAGMqqrtCtckcCmePd1JzWnUQdiJBKjmyjjqCdMzA1JTOg9qTolgaeKhHxBrHF79wE956H/ua107aAFEg2bvVupUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Nt7sXCtR; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E597B4397E;
	Fri, 20 Jun 2025 09:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750411013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Muc9J73484by83ECYSY5kjJOAz3Y21Yg9Vw4cxsQrm4=;
	b=Nt7sXCtRycO3W1lX1lTJOUt26BjLSRWYHVX2wonbD8AapMylGvyFpiI+udgpYioHFNeSdX
	SgfAgtZMcCrB14dBCdBIy1uhBm1diHQm2r+w69bBvn+1+7/mASt/Bhd8N20l6ixUlOQvNj
	vhpaUkK7grCXbJdC7u9jjVgbtmDJHv8DM3j/pZTs8z0fMMlxzd0OgexSIHx8nJRd6Szyes
	HPVxYD2/CEIaPk6XYzaTDGnx5c3Os22MAh0cDJ0VW0Xt8DBkbm+DqG2DYYJUEoLwfbvo2u
	t3ymrfhElrQpcQao0AvqVqzdjUsb0IHoym/K+K7511ikP9A3UEjwDRbPdOOPfw==
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel test robot <lkp@intel.com>,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: pse-pd: Fix ethnl_pse_send_ntf() stub parameter type
Date: Fri, 20 Jun 2025 11:16:41 +0200
Message-ID: <20250620091641.2098028-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdektddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheplefhhefhgeevtedutdekudegjedvhffffefhhfdtgfefteduvdehgeetgedtvdelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddrrddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrg
 hdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
X-GND-Sasl: kory.maincent@bootlin.com

The ethnl_pse_send_ntf() stub function has incorrect parameter type when
CONFIG_ETHTOOL_NETLINK is disabled. The function should take a net_device
pointer instead of phy_device pointer to match the actual implementation.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506200355.TqFiYUbN-lkp@intel.com/
Fixes: fc0e6db30941 ("net: pse-pd: Add support for reporting events")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 include/linux/ethtool_netlink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ethtool_netlink.h b/include/linux/ethtool_netlink.h
index 1dcc4059b5ab..39254b2726c0 100644
--- a/include/linux/ethtool_netlink.h
+++ b/include/linux/ethtool_netlink.h
@@ -122,7 +122,7 @@ static inline bool ethtool_dev_mm_supported(struct net_device *dev)
 	return false;
 }
 
-static inline void ethnl_pse_send_ntf(struct phy_device *phydev,
+static inline void ethnl_pse_send_ntf(struct net_device *netdev,
 				      unsigned long notif)
 {
 }
-- 
2.43.0


