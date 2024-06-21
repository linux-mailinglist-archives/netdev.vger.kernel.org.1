Return-Path: <netdev+bounces-105706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 281D0912547
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 14:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6CA1F233D8
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DBE15251C;
	Fri, 21 Jun 2024 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="u8Xj0vQz"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710971514FF;
	Fri, 21 Jun 2024 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718972933; cv=none; b=ZPQA5i7fhNXqOJuYwPcDx2/ebfi8WY7/ZfaUbrbC0MblOCveZwLXKZIefjU58cdMDeOuOQbNhnstob98yBPoz24OOdkVqtFK8kruHz1A7uLUU+Zh1/Mu5JKmPScKu+6BPYZZitMNSHX1IBUxmiB3V59+l79CUs5l487x0gMGxpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718972933; c=relaxed/simple;
	bh=pRTnPfU2ZZqwQaCqokA7pCcVBDUQuWEXpMhVelb16LE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvuytCjoQJAFg99diZdAYw7RT9BvGKOXDvDKeeRCR6W0Y5MCG0gRJ+UxsGje3ON7ChCsrT8OmnMEAPj5tDmWlK3hg6uPYTlyrlxMro5EVy/QyZBAQQCKyylUJ1vD9bfB1tKrs3YBG42HDwL0TWz60xgwtoFVOcWyERH+35IxM1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=u8Xj0vQz; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cf8aa1c42fc911ef8da6557f11777fc4-20240621
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BArojeuc6ZABXT8GU1gmnCESjUrYq5AJBYqSnPQMpiU=;
	b=u8Xj0vQze0+7w0pbGRU4ArMwwVMyM358Zuf2I678yoCw5VugpC/GxLgOksybCpYYc/w4QSN6llQdzW9WXD+9rvm/Hz+CpW7ow7EQ6SltzWrYAgBRmHbN4ZlUMMYMP4jUiT1NyTwZEV3MP4+F/D4r7SmREFBebaqPefUVp7/nVNg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:6e394170-58eb-4eb8-81af-cf2746bd7e0f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:14c6df88-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cf8aa1c42fc911ef8da6557f11777fc4-20240621
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1651283591; Fri, 21 Jun 2024 20:28:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 21 Jun 2024 20:28:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 21 Jun 2024 20:28:46 +0800
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
Subject: [PATCH net-next v8 12/13] net: phy: mediatek: Fix alignment in callback functions' hook
Date: Fri, 21 Jun 2024 20:20:44 +0800
Message-ID: <20240621122045.30732-13-SkyLake.Huang@mediatek.com>
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
X-TM-AS-Result: No-10--4.513200-8.000000
X-TMASE-MatchedRID: SboKb0hq3KSfB+yEZJpNeG3NvezwBrVm9QWksVxouuavloAnGr4qhimL
	DHOqINZ3GqTtGcghBlUSn72ENNjlb3rAhMQyuycqA9lly13c/gHt/okBLaEo+H5h6y4KCSJcmDU
	U4w5Ch9Hpu8xihWWE0fRfF4y0FsYkCNWeV68n9OieAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8ifEz
	J5hPndGcgvr6cKs+ZUzYvO7ppst7zlWKhjQXUfw49NbtbzzqIBRCrET9ptiJdg/VpGjlIE0HVP2
	nJe0qPuUKzouUUgHsABCcd6HX1EVXmVKZusLp922v9OjYWA2uMMswg45VMfPadst5iAforfVlxr
	1FJij9s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.513200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	527E7227CF591BD178886F3154AA1E9D2B2E5AF2556E1342B673C971633338322000:8
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

Align declarations in mtk_gephy_driver(mtk-ge.c) and
mtk_socphy_driver(mtk-ge-soc.c). At first, some of them are
".foo<tab>= method_foo", and others are ".bar<space>= method_bar".
Use space instead for all of them here in case line is longer than
80 chars.

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
 drivers/net/phy/mediatek/mtk-ge-soc.c | 40 +++++++++++++--------------
 drivers/net/phy/mediatek/mtk-ge.c     | 34 +++++++++++------------
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index 59c815e..fc33729 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -1399,17 +1399,17 @@ static int mt7981_phy_probe(struct phy_device *phydev)
 static struct phy_driver mtk_socphy_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7981),
-		.name		= "MediaTek MT7981 PHY",
-		.config_init	= mt798x_phy_config_init,
-		.read_status	= mtk_gphy_cl22_read_status,
-		.config_intr	= genphy_no_config_intr,
+		.name = "MediaTek MT7981 PHY",
+		.config_init = mt798x_phy_config_init,
+		.read_status = mtk_gphy_cl22_read_status,
+		.config_intr = genphy_no_config_intr,
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
-		.probe		= mt7981_phy_probe,
-		.suspend	= genphy_suspend,
-		.resume		= genphy_resume,
-		.read_page	= mtk_phy_read_page,
-		.write_page	= mtk_phy_write_page,
-		.led_blink_set	= mt798x_phy_led_blink_set,
+		.probe = mt7981_phy_probe,
+		.suspend = genphy_suspend,
+		.resume = genphy_resume,
+		.read_page = mtk_phy_read_page,
+		.write_page = mtk_phy_write_page,
+		.led_blink_set = mt798x_phy_led_blink_set,
 		.led_brightness_set = mt798x_phy_led_brightness_set,
 		.led_hw_is_supported = mt798x_phy_led_hw_is_supported,
 		.led_hw_control_set = mt798x_phy_led_hw_control_set,
@@ -1417,17 +1417,17 @@ static struct phy_driver mtk_socphy_driver[] = {
 	},
 	{
 		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7988),
-		.name		= "MediaTek MT7988 PHY",
-		.config_init	= mt798x_phy_config_init,
-		.read_status	= mtk_gphy_cl22_read_status,
-		.config_intr	= genphy_no_config_intr,
+		.name = "MediaTek MT7988 PHY",
+		.config_init = mt798x_phy_config_init,
+		.read_status = mtk_gphy_cl22_read_status,
+		.config_intr = genphy_no_config_intr,
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
-		.probe		= mt7988_phy_probe,
-		.suspend	= genphy_suspend,
-		.resume		= genphy_resume,
-		.read_page	= mtk_phy_read_page,
-		.write_page	= mtk_phy_write_page,
-		.led_blink_set	= mt798x_phy_led_blink_set,
+		.probe = mt7988_phy_probe,
+		.suspend = genphy_suspend,
+		.resume = genphy_resume,
+		.read_page = mtk_phy_read_page,
+		.write_page = mtk_phy_write_page,
+		.led_blink_set = mt798x_phy_led_blink_set,
 		.led_brightness_set = mt798x_phy_led_brightness_set,
 		.led_hw_is_supported = mt798x_phy_led_hw_is_supported,
 		.led_hw_control_set = mt798x_phy_led_hw_control_set,
diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
index ea85c94..07b5b22 100644
--- a/drivers/net/phy/mediatek/mtk-ge.c
+++ b/drivers/net/phy/mediatek/mtk-ge.c
@@ -198,35 +198,35 @@ static int mt753x_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
 static struct phy_driver mtk_gephy_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7530),
-		.name		= "MediaTek MT7530 PHY",
-		.config_init	= mt7530_phy_config_init,
+		.name = "MediaTek MT7530 PHY",
+		.config_init = mt7530_phy_config_init,
 		/* Interrupts are handled by the switch, not the PHY
 		 * itself.
 		 */
-		.config_intr	= genphy_no_config_intr,
+		.config_intr = genphy_no_config_intr,
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
-		.suspend	= genphy_suspend,
-		.resume		= genphy_resume,
-		.read_page	= mtk_phy_read_page,
-		.write_page	= mtk_phy_write_page,
+		.suspend = genphy_suspend,
+		.resume = genphy_resume,
+		.read_page = mtk_phy_read_page,
+		.write_page = mtk_phy_write_page,
 		.led_hw_is_supported = mt753x_phy_led_hw_is_supported,
 	},
 	{
 		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7531),
-		.name		= "MediaTek MT7531 PHY",
-		.probe		= mt7531_phy_probe,
-		.config_init	= mt7531_phy_config_init,
-		.read_status	= mtk_gphy_cl22_read_status,
+		.name = "MediaTek MT7531 PHY",
+		.probe = mt7531_phy_probe,
+		.config_init = mt7531_phy_config_init,
+		.read_status = mtk_gphy_cl22_read_status,
 		/* Interrupts are handled by the switch, not the PHY
 		 * itself.
 		 */
-		.config_intr	= genphy_no_config_intr,
+		.config_intr = genphy_no_config_intr,
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
-		.suspend	= genphy_suspend,
-		.resume		= genphy_resume,
-		.read_page	= mtk_phy_read_page,
-		.write_page	= mtk_phy_write_page,
-		.led_blink_set	= mt753x_phy_led_blink_set,
+		.suspend = genphy_suspend,
+		.resume = genphy_resume,
+		.read_page = mtk_phy_read_page,
+		.write_page = mtk_phy_write_page,
+		.led_blink_set = mt753x_phy_led_blink_set,
 		.led_brightness_set = mt753x_phy_led_brightness_set,
 		.led_hw_is_supported = mt753x_phy_led_hw_is_supported,
 		.led_hw_control_set = mt753x_phy_led_hw_control_set,
-- 
2.34.1


