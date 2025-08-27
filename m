Return-Path: <netdev+bounces-217150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A445B37943
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A3F6851E9
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 04:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897901E260A;
	Wed, 27 Aug 2025 04:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="D6Sqfv4e"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97A9285C81;
	Wed, 27 Aug 2025 04:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270088; cv=none; b=fLjgKZvOxVcb/KG9CAAjKMekCR+LG7dWFG4egPs/1sCYaLQ6R0zRhI9phFOm7PR340sEnSb1H6FT80U/HKCM6n0MofXT0HQoZOa4aNcvB0yHzkajMq74/BsoZYw4Un74lsspTZnOKRMwSn3it4NsmxNuMN+PR0Py+Qocw5JIqeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270088; c=relaxed/simple;
	bh=euhLcg2hYaVzhJLOnM3wXUYMbGQHElOOn0H88J7Xm9M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iHqBGeOXLQ3RRN+kMu/2FFz3FvrCRDWNoQnm6TAo8S+sxmZ5LV7vOHhqYCyloEeojtLdMZ/cMDyw3Ql5taj3I6k5ncMzann+PpIuS/1hdvbw6uyGFXxg7SVaKcwJIGDHrlr+YYKSRy+W4EM08eCTjwo1p5h+OeNI9E8tPFCVP50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=D6Sqfv4e; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 00bbe6b4830111f0b33aeb1e7f16c2b6-20250827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=t0Ryzl+bhnvnUoIRkn4L1iphGVUHu2m+u71p5zhRsXY=;
	b=D6Sqfv4eUCtPkOCaUFV+JqT0HnJJSWmXadix2JeSAk0T0Joih+J9DIcgib8bQMngOmsAYxlxtJMDH8QeJyeNL/aWU5lt0b3CEydpTiq9MQqr/f9RnoC5zUiGoGc9O8JY3rU5IEzmwvewTLsXBeOmyBXwX4a5l6/u+PFFHgmQ0Cs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:1a9dbdf3-a11a-4c74-b320-1d1ecf5d2476,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:40cc8c20-786d-4870-a017-e7b4f3839b3f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 00bbe6b4830111f0b33aeb1e7f16c2b6-20250827
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2146429659; Wed, 27 Aug 2025 12:47:57 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 27 Aug 2025 12:47:56 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 27 Aug 2025 12:47:56 +0800
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
CC: Sky Huang <skylake.huang@mediatek.com>
Subject: [PATCH net-next 1/1] net: phy: mtk-2p5ge: Add LED support for MT7988
Date: Wed, 27 Aug 2025 12:47:55 +0800
Message-ID: <20250827044755.3256991-1-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Sky Huang <skylake.huang@mediatek.com>

Add LED support for MT7988's built-in 2.5Gphy. LED hardware has almost
the same design with MT7981's/MT7988's built-in GbE. So hook the same
helper function here.

Before mtk_phy_leds_state_init(), set correct default values of LED0
and LED1.

Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/mediatek/mtk-2p5ge.c | 104 +++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-2p5ge.c b/drivers/net/phy/mediatek/mtk-2p5ge.c
index e147eab523ef..de8a41a1841d 100644
--- a/drivers/net/phy/mediatek/mtk-2p5ge.c
+++ b/drivers/net/phy/mediatek/mtk-2p5ge.c
@@ -249,8 +249,80 @@ static int mt798x_2p5ge_phy_get_rate_matching(struct phy_device *phydev,
 	return RATE_MATCH_PAUSE;
 }
 
+static const unsigned long supported_triggers =
+	BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
+	BIT(TRIGGER_NETDEV_LINK)        |
+	BIT(TRIGGER_NETDEV_LINK_10)     |
+	BIT(TRIGGER_NETDEV_LINK_100)    |
+	BIT(TRIGGER_NETDEV_LINK_1000)   |
+	BIT(TRIGGER_NETDEV_LINK_2500)   |
+	BIT(TRIGGER_NETDEV_RX)          |
+	BIT(TRIGGER_NETDEV_TX);
+
+static int mt798x_2p5ge_phy_led_blink_set(struct phy_device *phydev, u8 index,
+					  unsigned long *delay_on,
+					  unsigned long *delay_off)
+{
+	bool blinking = false;
+	int err = 0;
+
+	err = mtk_phy_led_num_dly_cfg(index, delay_on, delay_off, &blinking);
+	if (err < 0)
+		return err;
+
+	err = mtk_phy_hw_led_blink_set(phydev, index, blinking);
+	if (err)
+		return err;
+
+	if (blinking)
+		mtk_phy_hw_led_on_set(phydev, index, MTK_2P5GPHY_LED_ON_MASK,
+				      false);
+
+	return 0;
+}
+
+static int mt798x_2p5ge_phy_led_brightness_set(struct phy_device *phydev,
+					       u8 index,
+					       enum led_brightness value)
+{
+	int err;
+
+	err = mtk_phy_hw_led_blink_set(phydev, index, false);
+	if (err)
+		return err;
+
+	return mtk_phy_hw_led_on_set(phydev, index, MTK_2P5GPHY_LED_ON_MASK,
+				     (value != LED_OFF));
+}
+
+static int mt798x_2p5ge_phy_led_hw_is_supported(struct phy_device *phydev,
+						u8 index, unsigned long rules)
+{
+	return mtk_phy_led_hw_is_supported(phydev, index, rules,
+					   supported_triggers);
+}
+
+static int mt798x_2p5ge_phy_led_hw_control_get(struct phy_device *phydev,
+					       u8 index, unsigned long *rules)
+{
+	return mtk_phy_led_hw_ctrl_get(phydev, index, rules,
+				       MTK_2P5GPHY_LED_ON_SET,
+				       MTK_2P5GPHY_LED_RX_BLINK_SET,
+				       MTK_2P5GPHY_LED_TX_BLINK_SET);
+};
+
+static int mt798x_2p5ge_phy_led_hw_control_set(struct phy_device *phydev,
+					       u8 index, unsigned long rules)
+{
+	return mtk_phy_led_hw_ctrl_set(phydev, index, rules,
+				       MTK_2P5GPHY_LED_ON_SET,
+				       MTK_2P5GPHY_LED_RX_BLINK_SET,
+				       MTK_2P5GPHY_LED_TX_BLINK_SET);
+};
+
 static int mt798x_2p5ge_phy_probe(struct phy_device *phydev)
 {
+	struct mtk_socphy_priv *priv;
 	struct pinctrl *pinctrl;
 	int ret;
 
@@ -273,19 +345,34 @@ static int mt798x_2p5ge_phy_probe(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	/* Setup LED */
+	/* Setup LED. On default, LED0 is on/off when link is up/down. As for
+	 * LED1, it blinks as tx/rx transmission takes place.
+	 */
 	phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED0_ON_CTRL,
-			 MTK_PHY_LED_ON_POLARITY | MTK_PHY_LED_ON_LINK10 |
-			 MTK_PHY_LED_ON_LINK100 | MTK_PHY_LED_ON_LINK1000 |
-			 MTK_PHY_LED_ON_LINK2500);
-	phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED1_ON_CTRL,
-			 MTK_PHY_LED_ON_FDX | MTK_PHY_LED_ON_HDX);
+			 MTK_PHY_LED_ON_POLARITY | MTK_2P5GPHY_LED_ON_SET);
+	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED0_BLINK_CTRL,
+			   MTK_2P5GPHY_LED_TX_BLINK_SET |
+			   MTK_2P5GPHY_LED_RX_BLINK_SET);
+	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED1_ON_CTRL,
+			   MTK_PHY_LED_ON_FDX | MTK_PHY_LED_ON_HDX |
+			   MTK_2P5GPHY_LED_ON_SET);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED1_BLINK_CTRL,
+			 MTK_2P5GPHY_LED_TX_BLINK_SET |
+			 MTK_2P5GPHY_LED_RX_BLINK_SET);
 
 	/* Switch pinctrl after setting polarity to avoid bogus blinking */
 	pinctrl = devm_pinctrl_get_select(&phydev->mdio.dev, "i2p5gbe-led");
 	if (IS_ERR(pinctrl))
 		dev_err(&phydev->mdio.dev, "Fail to set LED pins!\n");
 
+	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(struct mtk_socphy_priv),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	phydev->priv = priv;
+
+	mtk_phy_leds_state_init(phydev);
+
 	return 0;
 }
 
@@ -303,6 +390,11 @@ static struct phy_driver mtk_2p5gephy_driver[] = {
 		.resume = genphy_resume,
 		.read_page = mtk_phy_read_page,
 		.write_page = mtk_phy_write_page,
+		.led_blink_set = mt798x_2p5ge_phy_led_blink_set,
+		.led_brightness_set = mt798x_2p5ge_phy_led_brightness_set,
+		.led_hw_is_supported = mt798x_2p5ge_phy_led_hw_is_supported,
+		.led_hw_control_get = mt798x_2p5ge_phy_led_hw_control_get,
+		.led_hw_control_set = mt798x_2p5ge_phy_led_hw_control_set,
 	},
 };
 
-- 
2.45.2


