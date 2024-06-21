Return-Path: <netdev+bounces-105707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 504E291254B
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 14:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730DC1C21401
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912F2153819;
	Fri, 21 Jun 2024 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Aezo5WTP"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA7E1534FC;
	Fri, 21 Jun 2024 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718972952; cv=none; b=VOryFNFhA0OdjcgalAtDL/4pitS31s/JJnTLiEIF+DS8k363RlJMhGhcooVFHX+HooSHI168YhjA5i+oxQorvNv5+h+7mStHjrjy0WHDzTc35mTRuu6oLE6gAH8SawlrjaSKMn+Uq9Ijxh5pGVkK4pDaTf0SOVbICjZdiegHVB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718972952; c=relaxed/simple;
	bh=k7hCeb8BUHuN+IoFyvzUrvlpPhOJfUOKtoiFp/9raVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVJ4vxYtsyqHPnoEEE4hvJQDJTBHamHFy6CQJJB5HJ+1QflFISnK5/SMkIz2XFOfamoSNmrGpWfE6UVKVQfMY4XTzRngJYk4woHL9p0OMvg+17yB1IgFCTJ2pqr1Q4hVpMW8aXuLOCrgrNaqFIDX+OzpMy4G60nhjKwVZTQI8Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Aezo5WTP; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: da21c1302fc911ef99dc3f8fac2c3230-20240621
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vaRahnf6HvtLueonuL1iOLmCm5bgf+4n+aOc5u6IpV8=;
	b=Aezo5WTPC+GQxMdyo1S36Ug4yjiS2g3sobc6tn9mTpur5ctd/ZxAM4cG9CKwQtazXtUqEWb24vRKyO13k5NONH6/jWwEIhZmRGeTsXYtKGBdZE0xaD5HSKRIgE81e6VyfXYyIRy5RhF0rN0zqSjgaal0m/MuTtVPRafPL6T9/KE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:13657857-5b3d-4925-8cf0-ac050ce2e657,IP:0,U
	RL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:393d96e,CLOUDID:85c6df88-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: da21c1302fc911ef99dc3f8fac2c3230-20240621
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1826468925; Fri, 21 Jun 2024 20:29:06 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 21 Jun 2024 20:29:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 21 Jun 2024 20:29:04 +0800
From: Sky Huang <SkyLake.Huang@mediatek.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Golle
	<daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>, SkyLake Huang
	<SkyLake.Huang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
CC: Steven Liu <Steven.Liu@mediatek.com>, SkyLake.Huang
	<skylake.huang@mediatek.com>
Subject: [PATCH net-next v8 13/13] net: phy: mediatek: Remove unnecessary outer parens of "supported_triggers" var
Date: Fri, 21 Jun 2024 20:20:45 +0800
Message-ID: <20240621122045.30732-14-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240621122045.30732-1-SkyLake.Huang@mediatek.com>
References: <20240621122045.30732-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.009600-8.000000
X-TMASE-MatchedRID: BIV06Js6OJN00I3rWKbGqx+WEMjoO9WWTJDl9FKHbrkKogmGusPLbx8+
	XHETeZCzky2SP4enkne5cURAloITPh8TzIzimOwPC24oEZ6SpSmb4wHqRpnaDv2+yxuUhyIMgJA
	8qGaptLPShjii885JA4vplMkCs/9/iZH4SxuZVKyUPItSaAwao61fEoqpp7DACF9ypY+Mx5JZKM
	ggZKh680ma3zYT97IFAYfQIAUhBayZvmCbKVb49sZL6x5U/HridGByp+zdaDg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.009600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	D1749B019A7B2828F5F206AC65DCFED23103E55B87D2E39D248FA145F544E7402000:8
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

This patch removes unnecessary outer parens of "supported_triggers" vars
in mtk-ge.c & mtk-ge-soc.c to improve readability.

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
 drivers/net/phy/mediatek/mtk-ge-soc.c | 16 ++++++++--------
 drivers/net/phy/mediatek/mtk-ge.c     | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index fc33729..ff469c4 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -1229,14 +1229,14 @@ static int mt798x_phy_led_brightness_set(struct phy_device *phydev,
 }
 
 static const unsigned long supported_triggers =
-	(BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
-	 BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
-	 BIT(TRIGGER_NETDEV_LINK)        |
-	 BIT(TRIGGER_NETDEV_LINK_10)     |
-	 BIT(TRIGGER_NETDEV_LINK_100)    |
-	 BIT(TRIGGER_NETDEV_LINK_1000)   |
-	 BIT(TRIGGER_NETDEV_RX)          |
-	 BIT(TRIGGER_NETDEV_TX));
+	BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
+	BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
+	BIT(TRIGGER_NETDEV_LINK)        |
+	BIT(TRIGGER_NETDEV_LINK_10)     |
+	BIT(TRIGGER_NETDEV_LINK_100)    |
+	BIT(TRIGGER_NETDEV_LINK_1000)   |
+	BIT(TRIGGER_NETDEV_RX)          |
+	BIT(TRIGGER_NETDEV_TX);
 
 static int mt798x_phy_led_hw_is_supported(struct phy_device *phydev, u8 index,
 					  unsigned long rules)
diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
index 07b5b22..235fee5 100644
--- a/drivers/net/phy/mediatek/mtk-ge.c
+++ b/drivers/net/phy/mediatek/mtk-ge.c
@@ -157,14 +157,14 @@ static int mt753x_phy_led_brightness_set(struct phy_device *phydev,
 }
 
 static const unsigned long supported_triggers =
-	(BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
-	 BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
-	 BIT(TRIGGER_NETDEV_LINK)        |
-	 BIT(TRIGGER_NETDEV_LINK_10)     |
-	 BIT(TRIGGER_NETDEV_LINK_100)    |
-	 BIT(TRIGGER_NETDEV_LINK_1000)   |
-	 BIT(TRIGGER_NETDEV_RX)          |
-	 BIT(TRIGGER_NETDEV_TX));
+	BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
+	BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
+	BIT(TRIGGER_NETDEV_LINK)        |
+	BIT(TRIGGER_NETDEV_LINK_10)     |
+	BIT(TRIGGER_NETDEV_LINK_100)    |
+	BIT(TRIGGER_NETDEV_LINK_1000)   |
+	BIT(TRIGGER_NETDEV_RX)          |
+	BIT(TRIGGER_NETDEV_TX);
 
 static int mt753x_phy_led_hw_is_supported(struct phy_device *phydev, u8 index,
 					  unsigned long rules)
-- 
2.34.1


