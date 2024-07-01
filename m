Return-Path: <netdev+bounces-108093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5048891DD3C
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 12:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 809A3B22DCC
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3805713D509;
	Mon,  1 Jul 2024 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kUbHDk12"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465AF13D24D;
	Mon,  1 Jul 2024 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831447; cv=none; b=IPVwPMm2byTdHrIg+fjDJVqcZdF8xsre9/yH/Od7dtlIK+91Fla8oFOu/1SglwVxIF3Zo2rmWzNPre612DFZAirAD8DbuJoQlbKhS0PwuAn+/c5h+0M6K12TuUE3qmoeEIdeMxGuQQtT0+McuopsuUdpcZPjXNXKvJWk1x/WGMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831447; c=relaxed/simple;
	bh=qAnWP0jhr4YvaK8motFeCjzRQtxOct4z24iSAGlVjEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OauugWiTty8Eys2gwjTi2mhmKTu2CYwpRnw5HmCM2mIBqMuHvMORijoPJL6C3fEDYnRLASM5pEPF0oGZuQBPrp9p4gAyhKms4PP6i4YAZnZIwDbkmjzq5DL4bdu331DFv5vIERbryLyyyeIEJUJkTYp7bBdXkh3z6F89ql2oK2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kUbHDk12; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b0ae44aa379811ef99dc3f8fac2c3230-20240701
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7FPKHFB7DmI7XxahmQ/sdSeFOvPkP2KuVr/PD2r+EoM=;
	b=kUbHDk12nkaq30MSsmjJkyKBTYLrgZg8z18XPE5Xc2MEspAzniTnYQEsKgq8MqWIgD8iNrHtF+VIHMLqM1CMxfbvpGx3yCGrBDvwV3vjU0wfUVxXvqTIFEHzWaPCW4FvdnKT6NXdwFYf0dw3LD2Avm1SRCzqXmo3TrDKzSClMR4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:2918d394-8fa8-4204-aefa-eca01f50f948,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:157ded0c-46b0-425a-97d3-4623fe284021,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b0ae44aa379811ef99dc3f8fac2c3230-20240701
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 560331693; Mon, 01 Jul 2024 18:57:21 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 1 Jul 2024 03:57:19 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 1 Jul 2024 18:57:19 +0800
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
Subject: [PATCH net-next v10 06/13] net: phy: mediatek: Hook LED helper functions in mtk-ge.c
Date: Mon, 1 Jul 2024 18:54:10 +0800
Message-ID: <20240701105417.19941-7-SkyLake.Huang@mediatek.com>
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

We have mtk-phy-lib.c now so that we can use LED helper functions in
mtk-ge.c(mt7531 part). It also means that mt7531/mt7981/mt7988's
Giga ethernet phys share almost the same HW LED controller design.
Also, add probe function for mt7531 so that it can initialize LED state.

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
Changes in v9:
- Led number checking & delay settings are integrated into common code, so
  just use it.
---
 drivers/net/phy/mediatek/mtk-ge.c | 100 ++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
index 9122899..161f2e8 100644
--- a/drivers/net/phy/mediatek/mtk-ge.c
+++ b/drivers/net/phy/mediatek/mtk-ge.c
@@ -13,6 +13,10 @@
 #define MTK_PHY_PAGE_EXTENDED_2A30	0x2a30
 #define MTK_PHY_PAGE_EXTENDED_52B5	0x52b5
 
+struct mtk_gephy_priv {
+	unsigned long		led_state;
+};
+
 static void mtk_gephy_config_init(struct phy_device *phydev)
 {
 	/* Enable HW auto downshift */
@@ -57,6 +61,96 @@ static int mt7531_phy_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int mt7531_phy_probe(struct phy_device *phydev)
+{
+	struct mtk_gephy_priv *priv;
+
+	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(struct mtk_gephy_priv),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv = priv;
+
+	mtk_phy_leds_state_init(phydev);
+
+	return 0;
+}
+
+static int mt753x_phy_led_blink_set(struct phy_device *phydev, u8 index,
+				    unsigned long *delay_on,
+				    unsigned long *delay_off)
+{
+	struct mtk_gephy_priv *priv = phydev->priv;
+	bool blinking = false;
+	int err = 0;
+
+	err = mtk_phy_led_num_dly_cfg(index, delay_on, delay_off, &blinking);
+	if (err < 0)
+		return err;
+
+	err = mtk_phy_hw_led_blink_set(phydev, index, &priv->led_state,
+				       blinking);
+	if (err)
+		return err;
+
+	return mtk_phy_hw_led_on_set(phydev, index, &priv->led_state,
+				     MTK_GPHY_LED_ON_MASK, false);
+}
+
+static int mt753x_phy_led_brightness_set(struct phy_device *phydev,
+					 u8 index, enum led_brightness value)
+{
+	struct mtk_gephy_priv *priv = phydev->priv;
+	int err;
+
+	err = mtk_phy_hw_led_blink_set(phydev, index, &priv->led_state, false);
+	if (err)
+		return err;
+
+	return mtk_phy_hw_led_on_set(phydev, index, &priv->led_state,
+				     MTK_GPHY_LED_ON_MASK, (value != LED_OFF));
+}
+
+static const unsigned long supported_triggers =
+	(BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
+	 BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
+	 BIT(TRIGGER_NETDEV_LINK)        |
+	 BIT(TRIGGER_NETDEV_LINK_10)     |
+	 BIT(TRIGGER_NETDEV_LINK_100)    |
+	 BIT(TRIGGER_NETDEV_LINK_1000)   |
+	 BIT(TRIGGER_NETDEV_RX)          |
+	 BIT(TRIGGER_NETDEV_TX));
+
+static int mt753x_phy_led_hw_is_supported(struct phy_device *phydev, u8 index,
+					  unsigned long rules)
+{
+	return mtk_phy_led_hw_is_supported(phydev, index, rules,
+					   supported_triggers);
+}
+
+static int mt753x_phy_led_hw_control_get(struct phy_device *phydev, u8 index,
+					 unsigned long *rules)
+{
+	struct mtk_gephy_priv *priv = phydev->priv;
+
+	return mtk_phy_led_hw_ctrl_get(phydev, index, rules, &priv->led_state,
+				       MTK_GPHY_LED_ON_SET,
+				       MTK_GPHY_LED_RX_BLINK_SET,
+				       MTK_GPHY_LED_TX_BLINK_SET);
+};
+
+static int mt753x_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
+					 unsigned long rules)
+{
+	struct mtk_gephy_priv *priv = phydev->priv;
+
+	return mtk_phy_led_hw_ctrl_set(phydev, index, rules, &priv->led_state,
+				       MTK_GPHY_LED_ON_SET,
+				       MTK_GPHY_LED_RX_BLINK_SET,
+				       MTK_GPHY_LED_TX_BLINK_SET);
+};
+
 static struct phy_driver mtk_gephy_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(0x03a29412),
@@ -75,6 +169,7 @@ static struct phy_driver mtk_gephy_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(0x03a29441),
 		.name		= "MediaTek MT7531 PHY",
+		.probe		= mt7531_phy_probe,
 		.config_init	= mt7531_phy_config_init,
 		/* Interrupts are handled by the switch, not the PHY
 		 * itself.
@@ -85,6 +180,11 @@ static struct phy_driver mtk_gephy_driver[] = {
 		.resume		= genphy_resume,
 		.read_page	= mtk_phy_read_page,
 		.write_page	= mtk_phy_write_page,
+		.led_blink_set	= mt753x_phy_led_blink_set,
+		.led_brightness_set = mt753x_phy_led_brightness_set,
+		.led_hw_is_supported = mt753x_phy_led_hw_is_supported,
+		.led_hw_control_set = mt753x_phy_led_hw_control_set,
+		.led_hw_control_get = mt753x_phy_led_hw_control_get,
 	},
 };
 
-- 
2.18.0


