Return-Path: <netdev+bounces-131982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC06990148
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCFA11C22A08
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC381537B9;
	Fri,  4 Oct 2024 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ah8P8fbm"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3678914884D;
	Fri,  4 Oct 2024 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037864; cv=none; b=V2mw0R9/5PVATnF7Tgli38UO/jzxC3QUIGIOPECwqZPk249C4k00j5JEqAQ+amMDxP5LBfp9PGiOWWBcRJF3nnG7M1eGIbmuupO3fGxMmM1j9ErakTHldKcOZYBgNxeazjyZizV818G6p8dYvOI2e/L2mxfzQ25SDECsXdPmfM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037864; c=relaxed/simple;
	bh=FP35sBOnMRGS8jLcMDM9rt2kSeOxACXxv6L+Dh2/8wc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COm4rMcf3rh1ch/eykiPkNHrXCuImbzm7t0c8VEKGvgDLzhinh23mvcUXjFowYVKEVChHRH/QXnNOJwUxDCLlZvUikoKFmHsovToF7t2yldNYnzG3Apxa6LzLfLh8eL+wu0Yru56luJ/wUs4jzNq+K4PS9FiOq2fzBLdMbmZQe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ah8P8fbm; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bd1a5484823b11efb66947d174671e26-20241004
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Sp9RO8tHW2ftTNhS1rbLLx4vXSHE9mJadtHjsD8wnQU=;
	b=ah8P8fbmumnaEMcvepe1Sdbz4L+U/NzQwg5WptkVvQkRhGRgxRmfMf8RgfkLup79pMLWz5BQ/L50zAtsQ89xlthLDWOKyAijb+ZtXBJ7MB8l9LySZCHnjuZyFS3fzRC52j/iRW4Osl9anbqYdOkVXyc6NHfl0s7qma4xgXnpvTI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:08bb4d62-ac27-4d2e-8e5b-7135a2a8a924,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:09b5be64-444a-4b47-a99a-591ade3b04b2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bd1a5484823b11efb66947d174671e26-20241004
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 724106578; Fri, 04 Oct 2024 18:30:55 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 4 Oct 2024 18:30:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 4 Oct 2024 18:30:54 +0800
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
Subject: [PATCH net-next 7/9] net: phy: mediatek: add MT7530 & MT7531's PHY ID macros
Date: Fri, 4 Oct 2024 18:24:11 +0800
Message-ID: <20241004102413.5838-8-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241004102413.5838-1-SkyLake.Huang@mediatek.com>
References: <20241004102413.5838-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

This patch adds MT7530 & MT7531's PHY ID macros in mtk-ge.c so that
it follows the same rule of mtk-ge-soc.c.

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
 drivers/net/phy/mediatek/mtk-ge.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
index 18f6988..bf1bb61 100644
--- a/drivers/net/phy/mediatek/mtk-ge.c
+++ b/drivers/net/phy/mediatek/mtk-ge.c
@@ -5,6 +5,9 @@
 
 #include "mtk.h"
 
+#define MTK_GPHY_ID_MT7530		0x03a29412
+#define MTK_GPHY_ID_MT7531		0x03a29441
+
 #define MTK_EXT_PAGE_ACCESS		0x1f
 #define MTK_PHY_PAGE_STANDARD		0x0000
 #define MTK_PHY_PAGE_EXTENDED		0x0001
@@ -153,7 +156,7 @@ static int mt753x_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
 
 static struct phy_driver mtk_gephy_driver[] = {
 	{
-		PHY_ID_MATCH_EXACT(0x03a29412),
+		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7530),
 		.name		= "MediaTek MT7530 PHY",
 		.config_init	= mt7530_phy_config_init,
 		/* Interrupts are handled by the switch, not the PHY
@@ -167,7 +170,7 @@ static struct phy_driver mtk_gephy_driver[] = {
 		.write_page	= mtk_phy_write_page,
 	},
 	{
-		PHY_ID_MATCH_EXACT(0x03a29441),
+		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7531),
 		.name		= "MediaTek MT7531 PHY",
 		.probe		= mt7531_phy_probe,
 		.config_init	= mt7531_phy_config_init,
@@ -191,8 +194,8 @@ static struct phy_driver mtk_gephy_driver[] = {
 module_phy_driver(mtk_gephy_driver);
 
 static struct mdio_device_id __maybe_unused mtk_gephy_tbl[] = {
-	{ PHY_ID_MATCH_EXACT(0x03a29441) },
-	{ PHY_ID_MATCH_EXACT(0x03a29412) },
+	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7530) },
+	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7531) },
 	{ }
 };
 
-- 
2.45.2


