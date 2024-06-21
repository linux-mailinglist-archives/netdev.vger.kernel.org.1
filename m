Return-Path: <netdev+bounces-105698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B8591250E
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 14:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A9D1F22F31
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CB21509B9;
	Fri, 21 Jun 2024 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FHu66WA6"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670DA1509BC;
	Fri, 21 Jun 2024 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718972595; cv=none; b=YpXSo7qJ1k5N88LKgGuKieDEjCnPetP5+9PvLit2B+/Wapp94RsB6hs56kZJ3wGqCoZ/rqLnlOlCkx2nHlzGqIcdXEMOKDTgPfzjcpzcw+KqIVUJT8oBfGq9C/JWF3RuCkIPzvH+PAnB1ny6fv9Un0pBMDCr6B2itLn9+RJOTh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718972595; c=relaxed/simple;
	bh=zkUOKBR0wT+s7+L9qBHIol5fQreYS26rufESmdL2xLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLpWN+5R3fO1Mmmw8FKnLNtuv1id5wV+KT7yL7gO3M/37v3Sk3IeCJ3A0pPYrBcGdpLxWc52Z4BnxSxRo87yuIzg1Sw/RGOS4v8cAJ7THbMhiWv1af8koojh+OfW+pvcTjxlwd/931j60IKTYSmMqBg/rU5Aoyvmiwt0FnbCvbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FHu66WA6; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 047b4e342fc911ef8da6557f11777fc4-20240621
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=TAYC9NAn1Nml0XDgsktswJwLQXrUx+2v9LrRFVr6K30=;
	b=FHu66WA6WnzdvOIGw4dgTdEaNAPejdcMbEFMtWcjCuHI4SbUMqeFGrU5+F20TWOXPPDJSXlrosoi9s0Lppl8RHymkwcUbwCNaHzqcXTnk/LJiAqfYeH6XVkuZweOwKQOnsNxDGfrdebWy754y4+P79g8b3fJpkqbVOyZjWI6F8c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:cdb44bdd-a039-4b0d-898d-18fc220c31ee,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:adbf4694-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 047b4e342fc911ef8da6557f11777fc4-20240621
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 747303820; Fri, 21 Jun 2024 20:23:08 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 21 Jun 2024 20:23:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 21 Jun 2024 20:23:05 +0800
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
Subject: [PATCH net-next v8 04/13] net: phy: mediatek: Improve readability of mtk-phy-lib.c's mtk_phy_led_hw_ctrl_set()
Date: Fri, 21 Jun 2024 20:20:36 +0800
Message-ID: <20240621122045.30732-5-SkyLake.Huang@mediatek.com>
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
X-TM-AS-Result: No-10-2.917200-8.000000
X-TMASE-MatchedRID: lFGHu1HL8sRftcgeqYe5M0f49ONH0RaSTJDl9FKHbrl+YesuCgkiXJ0X
	LGnRRmXw4vM1YF6AJbbCCfuIMF6xLSrJhLSjJRVmTArf1pzVcvD+mp0N2N97YlEog00OPZ8/8Wc
	6UjNuSfZMnSCpzfaes0NePb8Y8vCZRpcL+tsSHCApvJ0CfosR9ztjsLcW1jPmgITnGkK0NFNRsk
	XKHhdfKpij9M86UwHhsKHfMTjCprxgY1U509rkKp6oP1a0mRIj
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-2.917200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	5783C1DA9FE40F24698C70AA39DF2397F00A4C23F031DA2257575B71301D99382000:8
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

This patch removes parens around TRIGGER_NETDEV_RX/TRIGGER_NETDEV_TX in
mtk_phy_led_hw_ctrl_set(), which improves readability.

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
 drivers/net/phy/mediatek/mtk-phy-lib.c | 44 ++++++++++++++------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-phy-lib.c b/drivers/net/phy/mediatek/mtk-phy-lib.c
index 16b2794..f9d05f3 100644
--- a/drivers/net/phy/mediatek/mtk-phy-lib.c
+++ b/drivers/net/phy/mediatek/mtk-phy-lib.c
@@ -127,29 +127,33 @@ int mtk_phy_led_hw_ctrl_set(struct phy_device *phydev, u8 index,
 		on |= MTK_PHY_LED_ON_LINK2500;
 
 	if (rules & BIT(TRIGGER_NETDEV_RX)) {
-		blink |= (on & on_set) ?
-			  (((on & MTK_PHY_LED_ON_LINK10) ?
-			    MTK_PHY_LED_BLINK_10RX : 0) |
-			   ((on & MTK_PHY_LED_ON_LINK100) ?
-			    MTK_PHY_LED_BLINK_100RX : 0) |
-			   ((on & MTK_PHY_LED_ON_LINK1000) ?
-			    MTK_PHY_LED_BLINK_1000RX : 0) |
-			   ((on & MTK_PHY_LED_ON_LINK2500) ?
-			    MTK_PHY_LED_BLINK_2500RX : 0)) :
-			  rx_blink_set;
+		if (on & on_set) {
+			if (on & MTK_PHY_LED_ON_LINK10)
+				blink |= MTK_PHY_LED_BLINK_10RX;
+			if (on & MTK_PHY_LED_ON_LINK100)
+				blink |= MTK_PHY_LED_BLINK_100RX;
+			if (on & MTK_PHY_LED_ON_LINK1000)
+				blink |= MTK_PHY_LED_BLINK_1000RX;
+			if (on & MTK_PHY_LED_ON_LINK2500)
+				blink |= MTK_PHY_LED_BLINK_2500RX;
+		} else {
+			blink |= rx_blink_set;
+		}
 	}
 
 	if (rules & BIT(TRIGGER_NETDEV_TX)) {
-		blink |= (on & on_set) ?
-			  (((on & MTK_PHY_LED_ON_LINK10) ?
-			    MTK_PHY_LED_BLINK_10TX : 0) |
-			   ((on & MTK_PHY_LED_ON_LINK100) ?
-			    MTK_PHY_LED_BLINK_100TX : 0) |
-			   ((on & MTK_PHY_LED_ON_LINK1000) ?
-			    MTK_PHY_LED_BLINK_1000TX : 0) |
-			   ((on & MTK_PHY_LED_ON_LINK2500) ?
-			    MTK_PHY_LED_BLINK_2500TX : 0)) :
-			  tx_blink_set;
+		if (on & on_set) {
+			if (on & MTK_PHY_LED_ON_LINK10)
+				blink |= MTK_PHY_LED_BLINK_10TX;
+			if (on & MTK_PHY_LED_ON_LINK100)
+				blink |= MTK_PHY_LED_BLINK_100TX;
+			if (on & MTK_PHY_LED_ON_LINK1000)
+				blink |= MTK_PHY_LED_BLINK_1000TX;
+			if (on & MTK_PHY_LED_ON_LINK2500)
+				blink |= MTK_PHY_LED_BLINK_2500TX;
+		} else {
+			blink |= tx_blink_set;
+		}
 	}
 
 	if (blink || on)
-- 
2.34.1


