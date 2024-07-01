Return-Path: <netdev+bounces-108102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F5D91DD5B
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 13:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713B61C21A75
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 11:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6132E13C68A;
	Mon,  1 Jul 2024 11:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dtCSGZkB"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EEC142E67;
	Mon,  1 Jul 2024 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831647; cv=none; b=IkSw0YqocNQFMlSeXEz1pzVsvVDe9YrN55dHNfOa/8PlIDazBohpmA7dj0D5thCZ12i/anUnr7eSP7jsaZifQAPn4Jmr1DgunyreHTh0I23Q0znlx7/MDWie+nW10s1wJQtWZQaonCHo3uLTdg6fzRXwexTDp7vIDosgkoVSaMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831647; c=relaxed/simple;
	bh=nQwajZYy8XJCa7tJ3Rjisd87KIIHBRFjPNXN4odLpcA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDklZurCo0IJr8uX87abGsIeQrg3rzLOeGZoCG6jNeDH4sAx+iDq2m91825AkObel/el06KshGfG/kQw+zvWZ/wzeQh5pFbyVW8TlH8Ll+RVwAqxuACFV4OU/rtA/Cp/RF/Ybs+2t3/fRIlUcUhe4zl7RiSbyYDFD549hFfFIj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dtCSGZkB; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 269315ba379911ef99dc3f8fac2c3230-20240701
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YDAYvV/XFqqbwzkucvvhD6M3ybBfweUzERktggMsxRA=;
	b=dtCSGZkBqLKB72sfkUL/kWzMjRW6iZefrLocvjTeA29GQUAvyRAeaAEuhXPFcANW8DFAjBuIWOtii/j/hur3K4dhPzs7rcabOJ7Vc5OStmqc5pQhlLC7njfKXRsUWBYc+ZDJC9SHmil6WbphO47mQW1saQ5kl1lsQ0ylOfm+dkU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:78c63dcb-7d02-4351-a087-39a85a52ecb1,IP:0,U
	RL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:ba885a6,CLOUDID:fd02c544-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 269315ba379911ef99dc3f8fac2c3230-20240701
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1580474420; Mon, 01 Jul 2024 19:00:38 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 1 Jul 2024 19:00:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 1 Jul 2024 19:00:37 +0800
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
Subject: [PATCH net-next v10 13/13] net: phy: mediatek: Remove unnecessary outer parens of "supported_triggers" var
Date: Mon, 1 Jul 2024 18:54:17 +0800
Message-ID: <20240701105417.19941-14-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240701105417.19941-1-SkyLake.Huang@mediatek.com>
References: <20240701105417.19941-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
index 6d95e7d..6fc989d 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -1224,14 +1224,14 @@ static int mt798x_phy_led_brightness_set(struct phy_device *phydev,
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
index 90f3990..050a4f7 100644
--- a/drivers/net/phy/mediatek/mtk-ge.c
+++ b/drivers/net/phy/mediatek/mtk-ge.c
@@ -152,14 +152,14 @@ static int mt753x_phy_led_brightness_set(struct phy_device *phydev,
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
2.18.0


