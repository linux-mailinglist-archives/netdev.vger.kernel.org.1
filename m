Return-Path: <netdev+bounces-106883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EEC917EEE
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F651F266FE
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CED1822F3;
	Wed, 26 Jun 2024 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="O4ojK64W"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB08D1822DC;
	Wed, 26 Jun 2024 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719399110; cv=none; b=ErLyNaXxS39UwY9rKoBr0GDdWPZJfX36yYFrKhX3d7MQCQmHTtTaxtmepGsdrWmkErPQ7vtNpAZbjhZftgrjlK3LGkTfURMnEjdbotsl/1LiSIJtiLtuBp1AlxqNSrUW9wZr2H63Ljv7reRA/Yn/yazUGF4D+gTxyU4cLN1x5fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719399110; c=relaxed/simple;
	bh=J0cI1S6fHLfeoMEL4EfZVLs07ZCJ+cIzdzwNltdmlBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+IiUNi0R+2arGVCUErG8/b97EP9BL2zRyXZChWoYdphw9vuQXf4pCN0VE2YqVfsBsOobCfwnyOtTeZ5EHHqRFZRTqz3CNx7RvZ2CkSjvUY6WjEPe8AwSKclkcDDh6ss25Fg1V74ZiixABPsche3w2kN0i7JBFz4jSKkjjTBIEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=O4ojK64W; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 13434e4633aa11ef99dc3f8fac2c3230-20240626
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oyseyThSQKufHYgvLHAJvfNUc8vzYRdVhsvzH53kRpk=;
	b=O4ojK64Wt7FkPCu23BTe6mLWzd3PJGHV8gXh0974hqVPwXJ3zT8iNEC9tAD7qCV670rG1T1hHmQljDgWy2cizhSX+TcXCbaeGq99uuoPi5lxhp0wML0vXyHAKEt8wLEFVi/Et8JdcvRDfcp2S0pLgJ3Prguqz7BGrVOO3N92HxI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:983b294f-35c1-4e58-adf7-66e528210a25,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:12178f85-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 13434e4633aa11ef99dc3f8fac2c3230-20240626
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 648177590; Wed, 26 Jun 2024 18:51:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 26 Jun 2024 03:51:42 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 26 Jun 2024 18:51:42 +0800
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
Subject: [PATCH net-next v9 12/13] net: phy: mediatek: Fix alignment in callback functions' hook
Date: Wed, 26 Jun 2024 18:43:28 +0800
Message-ID: <20240626104329.11426-13-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240626104329.11426-1-SkyLake.Huang@mediatek.com>
References: <20240626104329.11426-1-SkyLake.Huang@mediatek.com>
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


