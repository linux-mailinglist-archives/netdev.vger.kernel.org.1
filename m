Return-Path: <netdev+bounces-105701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAD4912523
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 14:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7F9281CCB
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C321514D3;
	Fri, 21 Jun 2024 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XbR9Rq/p"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618D21509A5;
	Fri, 21 Jun 2024 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718972759; cv=none; b=fy1SXbRRe1GGnAn3C3KV4zh4pn35h+IuHimQTciV8BsrprfBusE6KGaSW33pavy0lc2aC+th9JZMnV80Io8DZdjcf1ir8LN38k4+Ni/s7FMjhm0H24jQz82tkK1sl18Dd6JjV4+0BbQ7nLgg5EtkjBYrHnY4qcRv6UcZKmNEYOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718972759; c=relaxed/simple;
	bh=Hh8bhcL34A5b+7mcXMajvkSVil8KZQNPriIjx/BxRi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNmLGTXEdqPUUQZRvW/vHr6CVq0JzPK3rTUDmI9hUnOOS3Zgi3CFtv/yZ+dxCmedbsTB30s7LZ4u0wXIuS9ksk/9cwCe+Y2Rg/sDRE6YbvkjqrQs6iQmneX0EltPXOjeuUGSlZpxc1Ya1kT9KLCB1lQTuVG000t3l7oZ0zR9lVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XbR9Rq/p; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 655b55462fc911ef8da6557f11777fc4-20240621
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0xVw8A3Iu828ctl3QhmsUX5udsNh5ldF5dUV7kYnuaM=;
	b=XbR9Rq/pi+sDvzhHVlQacsm9/nqe1HTjtfVoAOAHhecn7FoLO+70AM2IQufaOLgNDR4WbHMRzoaOO3MXm09vU4DZi/pweq0llFQfSRdQOz44m81h9WP5a1grYW9wJycdJkqoz8V1c+XbE+nxY7VklQMuU0HNxsHrE4jNZzVyjrY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:37fdb58a-3bb2-4393-9c3a-2d87b489452e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:7ec34694-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 655b55462fc911ef8da6557f11777fc4-20240621
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 667815340; Fri, 21 Jun 2024 20:25:50 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 21 Jun 2024 20:25:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 21 Jun 2024 20:25:48 +0800
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
Subject: [PATCH net-next v8 07/13] net: phy: mediatek: add MT7530 & MT7531's PHY ID macros
Date: Fri, 21 Jun 2024 20:20:39 +0800
Message-ID: <20240621122045.30732-8-SkyLake.Huang@mediatek.com>
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
X-TM-AS-Result: No-10--4.064500-8.000000
X-TMASE-MatchedRID: xvSVK/1RoEY9d1nHWxkekHQIOMndeKgEj5hUmqusTPgKogmGusPLb29z
	j16rJNcqw1kWj7dXBL8EzzjBCQLRwdYfe9ARablSoMfp2vHck9V9LQinZ4QefPcjNeVeWlqY+gt
	Hj7OwNO1YDuIRWpqxhkX/MtL7E2oReoGcVPu/TRoqwbghaV/C/qviHX/zCpV+5zoAX1i4BRGis0
	FjiwDE/n3drw+O5mxNDFRypPRs3lJUZQbQgW2v03ZrUbEZipAEiWT09mQz7szw9kH8zAy44SIdu
	k5Jkjd3wL6SxPpr1/I=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.064500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: E3B407C5AE17354DAB7278C752E8D5D63B0F78EB3D94C836BC067D19BC7FB7992000:8
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

This patch adds MT7530 & MT7531's PHY ID macros in mtk-ge.c so that
it follows the same rule of mtk-ge-soc.c.

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
 drivers/net/phy/mediatek/mtk-ge.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
index c338bba..5fdd368 100644
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
@@ -158,7 +161,7 @@ static int mt753x_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
 
 static struct phy_driver mtk_gephy_driver[] = {
 	{
-		PHY_ID_MATCH_EXACT(0x03a29412),
+		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7530),
 		.name		= "MediaTek MT7530 PHY",
 		.config_init	= mt7530_phy_config_init,
 		/* Interrupts are handled by the switch, not the PHY
@@ -170,9 +173,10 @@ static struct phy_driver mtk_gephy_driver[] = {
 		.resume		= genphy_resume,
 		.read_page	= mtk_phy_read_page,
 		.write_page	= mtk_phy_write_page,
+		.led_hw_is_supported = mt753x_phy_led_hw_is_supported,
 	},
 	{
-		PHY_ID_MATCH_EXACT(0x03a29441),
+		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7531),
 		.name		= "MediaTek MT7531 PHY",
 		.probe		= mt7531_phy_probe,
 		.config_init	= mt7531_phy_config_init,
@@ -196,8 +200,8 @@ static struct phy_driver mtk_gephy_driver[] = {
 module_phy_driver(mtk_gephy_driver);
 
 static struct mdio_device_id __maybe_unused mtk_gephy_tbl[] = {
-	{ PHY_ID_MATCH_EXACT(0x03a29441) },
-	{ PHY_ID_MATCH_EXACT(0x03a29412) },
+	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7530) },
+	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7531) },
 	{ }
 };
 
-- 
2.34.1


