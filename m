Return-Path: <netdev+bounces-108091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC58891DD35
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 12:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD4428139B
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6960C12EBD3;
	Mon,  1 Jul 2024 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HI8XMkz6"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D10B47F60;
	Mon,  1 Jul 2024 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831429; cv=none; b=oHtCG8wz12iIjtlW6MYsnIxzKNf431narGGevCz3fwZrjVTPqfg+9I5ZYGqGn3fq/cWSVkLOaNN18asLlBzwuTibyJroJMdXYEXL+f8bzb3UKe9ZHGpWih3M91bG4PPZz016gM/5P1barx/+5L22i1wS1udp+JtzSp9iQg97twE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831429; c=relaxed/simple;
	bh=wEx2+H8luSgiVDKSwitW+t2X93jcCLvcetCHbAkBuHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWsNIsPYihinZ579AfbJSi0uP41tqYOGz1aRzRh5UOKT2ibp4y4c4KHlE4Vk1Ks540zwoG9VdKqs8r1lLV7ZIFgJAJH9d3nhb0oZyCgSZSh/vNHTzv5ArI4cfJy4B8DF9t/+U0GiwncadP1pLpOLs5FiU+IYL9GH3bWifPBKrfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HI8XMkz6; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a6629a78379811ef99dc3f8fac2c3230-20240701
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Y6nWayEm5MHkjBJY49kDWoN3tVruxwuy2vR8wvEeAhE=;
	b=HI8XMkz6fC0+Svg5qWll7OkB9QTBTztiL+E+HYCrjiIt1hZ+7y+eXrFxU9fj4bjeXsRMlOPT+nB0RxOS7cCmFeI7tmXcOR2QJH1Mmyy101bqm7oXjMWKca7B9c7KqJkNNeMZL5gD+4ayrruwKp71+OHE0ejgkVN0uTcDjF7DVSc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:27994ff7-dfb3-45b4-b74f-cffc6c4a0c74,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:9cfbc444-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a6629a78379811ef99dc3f8fac2c3230-20240701
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1174912553; Mon, 01 Jul 2024 18:57:03 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 1 Jul 2024 18:57:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 1 Jul 2024 18:57:01 +0800
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
Subject: [PATCH net-next v10 04/13] net: phy: mediatek: Improve readability of mtk-phy-lib.c's mtk_phy_led_hw_ctrl_set()
Date: Mon, 1 Jul 2024 18:54:08 +0800
Message-ID: <20240701105417.19941-5-SkyLake.Huang@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-2.917200-8.000000
X-TMASE-MatchedRID: lFGHu1HL8sRftcgeqYe5M0f49ONH0RaSTJDl9FKHbrl+YesuCgkiXJ0X
	LGnRRmXw4vM1YF6AJbbCCfuIMF6xLSrJhLSjJRVm05AREaZhDIMS6jVSYD2V257XHLBstWmQ6L+
	m0W7ZqN2320oBml6qCeCClafePKc/XRusb+7lbXPtDMQhhBRVTjqx4DgFGewtgITnGkK0NFNRsk
	XKHhdfKpij9M86UwHhsKHfMTjCprxgY1U509rkKp6oP1a0mRIj
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-2.917200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4961440D0E49AAE103C1D6B5FE04B0E2F52166034960A1038167ACBDFAEB1D682000:8
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

This patch removes parens around TRIGGER_NETDEV_RX/TRIGGER_NETDEV_TX in
mtk_phy_led_hw_ctrl_set(), which improves readability.

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
 drivers/net/phy/mediatek/mtk-phy-lib.c | 44 ++++++++++++++------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-phy-lib.c b/drivers/net/phy/mediatek/mtk-phy-lib.c
index e1fbeff..20796ae 100644
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
2.18.0


