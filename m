Return-Path: <netdev+bounces-108101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA8791DD58
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 13:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73821F22234
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 11:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB781514DC;
	Mon,  1 Jul 2024 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="e8Km5lpm"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B91509BC;
	Mon,  1 Jul 2024 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831574; cv=none; b=cl5a2OnvAxicUIDZ9PWpf0aNU75wklzFbprcYy9wa1DcbskUb5QEYXfKKQg8SNEzfXKdhr+EDIHSXoCG435eIZVrOikqGrvUUuob8wyh4uXx7dyziULv/G6UVeCSxteAqey2NuI2WTL11D3UdHFqIyIG4obkAPKH84q7/4ePOj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831574; c=relaxed/simple;
	bh=J0cI1S6fHLfeoMEL4EfZVLs07ZCJ+cIzdzwNltdmlBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uz4fD2eOlxQiweCuOacQ1jtUROdImopJoSMDLpN8N2o/slwALH3RMagMAn6hA+axvhesuRnTkJeHhNOdx90JfrPx0tkIlFAa+4swlAvtlyj/UAwr0U6OeXJPIxAjKR75cNsI13oMGVezIgxACUtKhGNzfBqi1Hp6dbvdEJp/yR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=e8Km5lpm; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fcd0630e379811ef8b8f29950b90a568-20240701
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oyseyThSQKufHYgvLHAJvfNUc8vzYRdVhsvzH53kRpk=;
	b=e8Km5lpmm+KF8OzJPxfrE7CBeoiHCCOleGrieF/HcSzRqWCwkZb9m3IhwtzfYN0LLGqoGFeRkAYbWipAPrx1idtLCbXwNeW+ZOVywQDOOu2EsHMmgXJojYqkOnjOim3PkUnkZx+M4TGOG024kX3f6Ek98Q4vQpEuz9SuC18nBIU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:f6b894bc-ea7a-4767-9f95-46505c83d578,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:1a8ed0d4-0d68-4615-a20f-01d7bd41f0bb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fcd0630e379811ef8b8f29950b90a568-20240701
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 595840806; Mon, 01 Jul 2024 18:59:28 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 1 Jul 2024 18:59:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 1 Jul 2024 18:59:27 +0800
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
Subject: [PATCH net-next v10 12/13] net: phy: mediatek: Fix alignment in callback functions' hook
Date: Mon, 1 Jul 2024 18:54:16 +0800
Message-ID: <20240701105417.19941-13-SkyLake.Huang@mediatek.com>
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
index 5b2c7a0..6d95e7d 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -1394,17 +1394,17 @@ static int mt7981_phy_probe(struct phy_device *phydev)
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
@@ -1412,17 +1412,17 @@ static struct phy_driver mtk_socphy_driver[] = {
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
index 3bd8664..90f3990 100644
--- a/drivers/net/phy/mediatek/mtk-ge.c
+++ b/drivers/net/phy/mediatek/mtk-ge.c
@@ -193,34 +193,34 @@ static int mt753x_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
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
2.18.0


