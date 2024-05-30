Return-Path: <netdev+bounces-99277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2328D4453
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 05:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC511F24498
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C201E139580;
	Thu, 30 May 2024 03:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YTpB5u7G"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2A7142E83;
	Thu, 30 May 2024 03:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717040966; cv=none; b=RDTIbfhX2fSBBjlfld2WjHTSsFa9b7fihIGOM2H/+6rn3vgzqQ7ibakyjiHamZo3C6OUhXwDAAjwNuDA+bTkjybBsY91Y1MXVTaJ5bHHdS1UEgzdFkL9XvXUQwt0CP3cd+Xca7sNkwPG5jPgF6iDs2mhP8JKtF6JG0oRaP5U+5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717040966; c=relaxed/simple;
	bh=ixGOQHkTE2Pgsyi1Ng3fmyQ9pdVIGm0Wqq4SRvP3H/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OrpLRy/AfQLvvQp1jthpyLF+p/KWeZuyMAqwQeKm+N6Xw3zopwreAS4IYopOvetOaTBWVmj91aDi3BztqjCB3x/RFuusNKF1b6d6epebauXqT2cGOu5oMGkZsQeHYmkJgLFoEve9sP8DjwU0NY0h8R9elP7SF3vrDc2DvhskAoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YTpB5u7G; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 98152a1e1e3711efbfff99f2466cf0b4-20240530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=iawlcExwuGvKu1mJ+fUw66lXRIztS1O9c+GZPGllIDA=;
	b=YTpB5u7GH6sodcm4TpUoLF2sXiEA+v9rarj1Wt9WzMd3PEuxatY2JC9706Y3+qfXVYxZ5FfHVn1gUX5VGljWVf/DrEWqADmVraLp5tb1XQFnNXC6cASIoA2bT+b2sSfL5cFHyZ2+dnp38X69dNg8TdCuTJRXLxltah1Xd05C6Rs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:451b1ff0-bfa6-4726-9d15-a5ba8d625425,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:7da4fd87-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 98152a1e1e3711efbfff99f2466cf0b4-20240530
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 251949068; Thu, 30 May 2024 11:49:19 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 30 May 2024 11:49:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 30 May 2024 11:49:16 +0800
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
Subject: [PATCH net-next v5 2/5] net: phy: mediatek: Move LED and read/write page helper functions into mtk phy lib
Date: Thu, 30 May 2024 11:48:41 +0800
Message-ID: <20240530034844.11176-3-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240530034844.11176-1-SkyLake.Huang@mediatek.com>
References: <20240530034844.11176-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.940400-8.000000
X-TMASE-MatchedRID: 8a5GscZDmcmf9SROPcS9xrMjW/sniEQKu56wFPSkMVGM2ehTV+imi/hT
	6/pHvNpJWASbhXBhlp5M8qdoCvOVvj13WcdbGR6QGVyS87Wb4lxMjQ19j30wycSiwizsgluQU8S
	+/fFbuZPO0pdSWEgFjNRrGypw1446bxp6eJGYrDWHZXNSWjgdU3JzCd85HZTQ0SxMhOhuA0SJW1
	4oA532uGA7CuFxYDWF8WNFhoH0nAMk6f2zPJ9BDQVeOjvd5xeaIZm2INWXDp7NQVzhfYY5sivd+
	2hXReVzVb2WeXb8Tv7tJKkm5wobH0bazcUn1Xj5kDpLRKO9xhTljSRvSGpq3DRCaZSKE/OsmDUU
	4w5Ch9HNDGP7tcTEZ2fXQuD09R/dwkdUVZ4wAsS4jAucHcCqnZdhffisWXfH3M5CjuZOAD5B/Ab
	xEYtnVOLzNWBegCW2wgn7iDBesS15zdAzex5xZhTKBXUyaOVzrfZJjpkEZ33joYJEfFf4lGPVEa
	fLG6LSdN99IVUnh8yUTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.940400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	B00AE1C70000EE5F944FE2338ED9B21AE9831D77A7A0BB03886A5A198683A8B32000:8
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

This patch moves mtk-ge-soc.c's LED code into mtk phy lib. We
can use those helper functions in mtk-ge.c as well. That is to
say, we have almost the same HW LED controller design in
mt7530/mt7531/mt7981/mt7988's Giga ethernet phy.

Also integrate read/write pages into one helper function. They
are basically the same.

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
 MAINTAINERS                            |   2 +
 drivers/net/phy/mediatek/Kconfig       |   5 +
 drivers/net/phy/mediatek/Makefile      |   1 +
 drivers/net/phy/mediatek/mtk-ge-soc.c  | 267 +++----------------------
 drivers/net/phy/mediatek/mtk-ge.c      | 128 ++++++++++--
 drivers/net/phy/mediatek/mtk-phy-lib.c | 231 +++++++++++++++++++++
 drivers/net/phy/mediatek/mtk.h         |  82 ++++++++
 7 files changed, 456 insertions(+), 260 deletions(-)
 create mode 100644 drivers/net/phy/mediatek/mtk-phy-lib.c
 create mode 100644 drivers/net/phy/mediatek/mtk.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6deaf94..e58e05c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13794,7 +13794,9 @@ M:	SkyLake Huang <SkyLake.Huang@mediatek.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/phy/mediatek/mtk-ge-soc.c
+F:	drivers/net/phy/mediatek/mtk-phy-lib.c
 F:	drivers/net/phy/mediatek/mtk-ge.c
+F:	drivers/net/phy/mediatek/mtk.h
 F:	drivers/phy/mediatek/phy-mtk-xfi-tphy.c
 
 MEDIATEK I2C CONTROLLER DRIVER
diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
index 6839ea6..448bc20 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -1,6 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config MTK_NET_PHYLIB
+	tristate
+
 config MEDIATEK_GE_PHY
 	tristate "MediaTek Gigabit Ethernet PHYs"
+	select MTK_NET_PHYLIB
 	help
 	  Supports the MediaTek non-built-in Gigabit Ethernet PHYs.
 
@@ -13,6 +17,7 @@ config MEDIATEK_GE_SOC_PHY
 	tristate "MediaTek SoC Ethernet PHYs"
 	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
 	select NVMEM_MTK_EFUSE
+	select MTK_NET_PHYLIB
 	help
 	  Supports MediaTek SoC built-in Gigabit Ethernet PHYs.
 
diff --git a/drivers/net/phy/mediatek/Makefile b/drivers/net/phy/mediatek/Makefile
index 005bde2..814879d 100644
--- a/drivers/net/phy/mediatek/Makefile
+++ b/drivers/net/phy/mediatek/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_MTK_NET_PHYLIB)		+= mtk-phy-lib.o
 obj-$(CONFIG_MEDIATEK_GE_PHY)		+= mtk-ge.o
 obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)	+= mtk-ge-soc.o
diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index 47af872..ee83b27 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -8,6 +8,8 @@
 #include <linux/phy.h>
 #include <linux/regmap.h>
 
+#include "mtk.h"
+
 #define MTK_GPHY_ID_MT7981			0x03a29461
 #define MTK_GPHY_ID_MT7988			0x03a29481
 
@@ -210,41 +212,6 @@
 #define MTK_PHY_DA_TX_R50_PAIR_D		0x540
 
 /* Registers on MDIO_MMD_VEND2 */
-#define MTK_PHY_LED0_ON_CTRL			0x24
-#define MTK_PHY_LED1_ON_CTRL			0x26
-#define   MTK_PHY_LED_ON_MASK			GENMASK(6, 0)
-#define   MTK_PHY_LED_ON_LINK1000		BIT(0)
-#define   MTK_PHY_LED_ON_LINK100		BIT(1)
-#define   MTK_PHY_LED_ON_LINK10			BIT(2)
-#define   MTK_PHY_LED_ON_LINK			(MTK_PHY_LED_ON_LINK10 |\
-						 MTK_PHY_LED_ON_LINK100 |\
-						 MTK_PHY_LED_ON_LINK1000)
-#define   MTK_PHY_LED_ON_LINKDOWN		BIT(3)
-#define   MTK_PHY_LED_ON_FDX			BIT(4) /* Full duplex */
-#define   MTK_PHY_LED_ON_HDX			BIT(5) /* Half duplex */
-#define   MTK_PHY_LED_ON_FORCE_ON		BIT(6)
-#define   MTK_PHY_LED_ON_POLARITY		BIT(14)
-#define   MTK_PHY_LED_ON_ENABLE			BIT(15)
-
-#define MTK_PHY_LED0_BLINK_CTRL			0x25
-#define MTK_PHY_LED1_BLINK_CTRL			0x27
-#define   MTK_PHY_LED_BLINK_1000TX		BIT(0)
-#define   MTK_PHY_LED_BLINK_1000RX		BIT(1)
-#define   MTK_PHY_LED_BLINK_100TX		BIT(2)
-#define   MTK_PHY_LED_BLINK_100RX		BIT(3)
-#define   MTK_PHY_LED_BLINK_10TX		BIT(4)
-#define   MTK_PHY_LED_BLINK_10RX		BIT(5)
-#define   MTK_PHY_LED_BLINK_RX			(MTK_PHY_LED_BLINK_10RX |\
-						 MTK_PHY_LED_BLINK_100RX |\
-						 MTK_PHY_LED_BLINK_1000RX)
-#define   MTK_PHY_LED_BLINK_TX			(MTK_PHY_LED_BLINK_10TX |\
-						 MTK_PHY_LED_BLINK_100TX |\
-						 MTK_PHY_LED_BLINK_1000TX)
-#define   MTK_PHY_LED_BLINK_COLLISION		BIT(6)
-#define   MTK_PHY_LED_BLINK_RX_CRC_ERR		BIT(7)
-#define   MTK_PHY_LED_BLINK_RX_IDLE_ERR		BIT(8)
-#define   MTK_PHY_LED_BLINK_FORCE_BLINK		BIT(9)
-
 #define MTK_PHY_LED1_DEFAULT_POLARITIES		BIT(1)
 
 #define MTK_PHY_RG_BG_RASEL			0x115
@@ -299,10 +266,6 @@ enum CAL_MODE {
 	SW_M
 };
 
-#define MTK_PHY_LED_STATE_FORCE_ON	0
-#define MTK_PHY_LED_STATE_FORCE_BLINK	1
-#define MTK_PHY_LED_STATE_NETDEV	2
-
 struct mtk_socphy_priv {
 	unsigned long		led_state;
 };
@@ -312,16 +275,6 @@ struct mtk_socphy_shared {
 	struct mtk_socphy_priv	priv[4];
 };
 
-static int mtk_socphy_read_page(struct phy_device *phydev)
-{
-	return __phy_read(phydev, MTK_EXT_PAGE_ACCESS);
-}
-
-static int mtk_socphy_write_page(struct phy_device *phydev, int page)
-{
-	return __phy_write(phydev, MTK_EXT_PAGE_ACCESS, page);
-}
-
 /* One calibration cycle consists of:
  * 1.Set DA_CALIN_FLAG high to start calibration. Keep it high
  *   until AD_CAL_COMP is ready to output calibration result.
@@ -1130,57 +1083,13 @@ static int mt798x_phy_config_init(struct phy_device *phydev)
 	return mt798x_phy_calibration(phydev);
 }
 
-static int mt798x_phy_hw_led_on_set(struct phy_device *phydev, u8 index,
-				    bool on)
-{
-	unsigned int bit_on = MTK_PHY_LED_STATE_FORCE_ON + (index ? 16 : 0);
-	struct mtk_socphy_priv *priv = phydev->priv;
-	bool changed;
-
-	if (on)
-		changed = !test_and_set_bit(bit_on, &priv->led_state);
-	else
-		changed = !!test_and_clear_bit(bit_on, &priv->led_state);
-
-	changed |= !!test_and_clear_bit(MTK_PHY_LED_STATE_NETDEV +
-					(index ? 16 : 0), &priv->led_state);
-	if (changed)
-		return phy_modify_mmd(phydev, MDIO_MMD_VEND2, index ?
-				      MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL,
-				      MTK_PHY_LED_ON_MASK,
-				      on ? MTK_PHY_LED_ON_FORCE_ON : 0);
-	else
-		return 0;
-}
-
-static int mt798x_phy_hw_led_blink_set(struct phy_device *phydev, u8 index,
-				       bool blinking)
-{
-	unsigned int bit_blink = MTK_PHY_LED_STATE_FORCE_BLINK + (index ? 16 : 0);
-	struct mtk_socphy_priv *priv = phydev->priv;
-	bool changed;
-
-	if (blinking)
-		changed = !test_and_set_bit(bit_blink, &priv->led_state);
-	else
-		changed = !!test_and_clear_bit(bit_blink, &priv->led_state);
-
-	changed |= !!test_bit(MTK_PHY_LED_STATE_NETDEV +
-			      (index ? 16 : 0), &priv->led_state);
-	if (changed)
-		return phy_write_mmd(phydev, MDIO_MMD_VEND2, index ?
-				     MTK_PHY_LED1_BLINK_CTRL : MTK_PHY_LED0_BLINK_CTRL,
-				     blinking ? MTK_PHY_LED_BLINK_FORCE_BLINK : 0);
-	else
-		return 0;
-}
-
 static int mt798x_phy_led_blink_set(struct phy_device *phydev, u8 index,
 				    unsigned long *delay_on,
 				    unsigned long *delay_off)
 {
 	bool blinking = false;
 	int err = 0;
+	struct mtk_socphy_priv *priv = phydev->priv;
 
 	if (index > 1)
 		return -EINVAL;
@@ -1191,23 +1100,25 @@ static int mt798x_phy_led_blink_set(struct phy_device *phydev, u8 index,
 		*delay_off = 50;
 	}
 
-	err = mt798x_phy_hw_led_blink_set(phydev, index, blinking);
+	err = mtk_phy_hw_led_blink_set(phydev, index, &priv->led_state, blinking);
 	if (err)
 		return err;
 
-	return mt798x_phy_hw_led_on_set(phydev, index, false);
+	return mtk_phy_hw_led_on_set(phydev, index, &priv->led_state, MTK_GPHY_LED_ON_MASK, false);
 }
 
 static int mt798x_phy_led_brightness_set(struct phy_device *phydev,
 					 u8 index, enum led_brightness value)
 {
 	int err;
+	struct mtk_socphy_priv *priv = phydev->priv;
 
-	err = mt798x_phy_hw_led_blink_set(phydev, index, false);
+	err = mtk_phy_hw_led_blink_set(phydev, index, &priv->led_state, false);
 	if (err)
 		return err;
 
-	return mt798x_phy_hw_led_on_set(phydev, index, (value != LED_OFF));
+	return mtk_phy_hw_led_on_set(phydev, index, &priv->led_state,
+				     MTK_GPHY_LED_ON_MASK, (value != LED_OFF));
 }
 
 static const unsigned long supported_triggers = (BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
@@ -1219,151 +1130,29 @@ static const unsigned long supported_triggers = (BIT(TRIGGER_NETDEV_FULL_DUPLEX)
 						 BIT(TRIGGER_NETDEV_RX)          |
 						 BIT(TRIGGER_NETDEV_TX));
 
-static int mt798x_phy_led_hw_is_supported(struct phy_device *phydev, u8 index,
-					  unsigned long rules)
+static int mt798x_phy_led_hw_is_supported(struct phy_device *phydev, u8 index, unsigned long rules)
 {
-	if (index > 1)
-		return -EINVAL;
-
-	/* All combinations of the supported triggers are allowed */
-	if (rules & ~supported_triggers)
-		return -EOPNOTSUPP;
-
-	return 0;
-};
+	return mtk_phy_led_hw_is_supported(phydev, index, rules, supported_triggers);
+}
 
 static int mt798x_phy_led_hw_control_get(struct phy_device *phydev, u8 index,
 					 unsigned long *rules)
 {
-	unsigned int bit_blink = MTK_PHY_LED_STATE_FORCE_BLINK + (index ? 16 : 0);
-	unsigned int bit_netdev = MTK_PHY_LED_STATE_NETDEV + (index ? 16 : 0);
-	unsigned int bit_on = MTK_PHY_LED_STATE_FORCE_ON + (index ? 16 : 0);
 	struct mtk_socphy_priv *priv = phydev->priv;
-	int on, blink;
-
-	if (index > 1)
-		return -EINVAL;
-
-	on = phy_read_mmd(phydev, MDIO_MMD_VEND2,
-			  index ? MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL);
-
-	if (on < 0)
-		return -EIO;
-
-	blink = phy_read_mmd(phydev, MDIO_MMD_VEND2,
-			     index ? MTK_PHY_LED1_BLINK_CTRL :
-				     MTK_PHY_LED0_BLINK_CTRL);
-	if (blink < 0)
-		return -EIO;
 
-	if ((on & (MTK_PHY_LED_ON_LINK | MTK_PHY_LED_ON_FDX | MTK_PHY_LED_ON_HDX |
-		   MTK_PHY_LED_ON_LINKDOWN)) ||
-	    (blink & (MTK_PHY_LED_BLINK_RX | MTK_PHY_LED_BLINK_TX)))
-		set_bit(bit_netdev, &priv->led_state);
-	else
-		clear_bit(bit_netdev, &priv->led_state);
-
-	if (on & MTK_PHY_LED_ON_FORCE_ON)
-		set_bit(bit_on, &priv->led_state);
-	else
-		clear_bit(bit_on, &priv->led_state);
-
-	if (blink & MTK_PHY_LED_BLINK_FORCE_BLINK)
-		set_bit(bit_blink, &priv->led_state);
-	else
-		clear_bit(bit_blink, &priv->led_state);
-
-	if (!rules)
-		return 0;
-
-	if (on & MTK_PHY_LED_ON_LINK)
-		*rules |= BIT(TRIGGER_NETDEV_LINK);
-
-	if (on & MTK_PHY_LED_ON_LINK10)
-		*rules |= BIT(TRIGGER_NETDEV_LINK_10);
-
-	if (on & MTK_PHY_LED_ON_LINK100)
-		*rules |= BIT(TRIGGER_NETDEV_LINK_100);
-
-	if (on & MTK_PHY_LED_ON_LINK1000)
-		*rules |= BIT(TRIGGER_NETDEV_LINK_1000);
-
-	if (on & MTK_PHY_LED_ON_FDX)
-		*rules |= BIT(TRIGGER_NETDEV_FULL_DUPLEX);
-
-	if (on & MTK_PHY_LED_ON_HDX)
-		*rules |= BIT(TRIGGER_NETDEV_HALF_DUPLEX);
-
-	if (blink & MTK_PHY_LED_BLINK_RX)
-		*rules |= BIT(TRIGGER_NETDEV_RX);
-
-	if (blink & MTK_PHY_LED_BLINK_TX)
-		*rules |= BIT(TRIGGER_NETDEV_TX);
-
-	return 0;
+	return mtk_phy_led_hw_ctrl_get(phydev, index, rules, &priv->led_state,
+					MTK_GPHY_LED_ON_SET,
+					MTK_GPHY_LED_RX_BLINK_SET, MTK_GPHY_LED_TX_BLINK_SET);
 };
 
 static int mt798x_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
 					 unsigned long rules)
 {
-	unsigned int bit_netdev = MTK_PHY_LED_STATE_NETDEV + (index ? 16 : 0);
 	struct mtk_socphy_priv *priv = phydev->priv;
-	u16 on = 0, blink = 0;
-	int ret;
-
-	if (index > 1)
-		return -EINVAL;
 
-	if (rules & BIT(TRIGGER_NETDEV_FULL_DUPLEX))
-		on |= MTK_PHY_LED_ON_FDX;
-
-	if (rules & BIT(TRIGGER_NETDEV_HALF_DUPLEX))
-		on |= MTK_PHY_LED_ON_HDX;
-
-	if (rules & (BIT(TRIGGER_NETDEV_LINK_10) | BIT(TRIGGER_NETDEV_LINK)))
-		on |= MTK_PHY_LED_ON_LINK10;
-
-	if (rules & (BIT(TRIGGER_NETDEV_LINK_100) | BIT(TRIGGER_NETDEV_LINK)))
-		on |= MTK_PHY_LED_ON_LINK100;
-
-	if (rules & (BIT(TRIGGER_NETDEV_LINK_1000) | BIT(TRIGGER_NETDEV_LINK)))
-		on |= MTK_PHY_LED_ON_LINK1000;
-
-	if (rules & BIT(TRIGGER_NETDEV_RX)) {
-		blink |= (on & MTK_PHY_LED_ON_LINK) ?
-			  (((on & MTK_PHY_LED_ON_LINK10) ? MTK_PHY_LED_BLINK_10RX : 0) |
-			   ((on & MTK_PHY_LED_ON_LINK100) ? MTK_PHY_LED_BLINK_100RX : 0) |
-			   ((on & MTK_PHY_LED_ON_LINK1000) ? MTK_PHY_LED_BLINK_1000RX : 0)) :
-			  MTK_PHY_LED_BLINK_RX;
-	}
-
-	if (rules & BIT(TRIGGER_NETDEV_TX)) {
-		blink |= (on & MTK_PHY_LED_ON_LINK) ?
-			  (((on & MTK_PHY_LED_ON_LINK10) ? MTK_PHY_LED_BLINK_10TX : 0) |
-			   ((on & MTK_PHY_LED_ON_LINK100) ? MTK_PHY_LED_BLINK_100TX : 0) |
-			   ((on & MTK_PHY_LED_ON_LINK1000) ? MTK_PHY_LED_BLINK_1000TX : 0)) :
-			  MTK_PHY_LED_BLINK_TX;
-	}
-
-	if (blink || on)
-		set_bit(bit_netdev, &priv->led_state);
-	else
-		clear_bit(bit_netdev, &priv->led_state);
-
-	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, index ?
-				MTK_PHY_LED1_ON_CTRL :
-				MTK_PHY_LED0_ON_CTRL,
-			     MTK_PHY_LED_ON_FDX     |
-			     MTK_PHY_LED_ON_HDX     |
-			     MTK_PHY_LED_ON_LINK,
-			     on);
-
-	if (ret)
-		return ret;
-
-	return phy_write_mmd(phydev, MDIO_MMD_VEND2, index ?
-				MTK_PHY_LED1_BLINK_CTRL :
-				MTK_PHY_LED0_BLINK_CTRL, blink);
+	return mtk_phy_led_hw_ctrl_set(phydev, index, rules, &priv->led_state,
+					MTK_GPHY_LED_ON_SET,
+					MTK_GPHY_LED_RX_BLINK_SET, MTK_GPHY_LED_TX_BLINK_SET);
 };
 
 static bool mt7988_phy_led_get_polarity(struct phy_device *phydev, int led_num)
@@ -1437,14 +1226,6 @@ static int mt7988_phy_probe_shared(struct phy_device *phydev)
 	return 0;
 }
 
-static void mt798x_phy_leds_state_init(struct phy_device *phydev)
-{
-	int i;
-
-	for (i = 0; i < 2; ++i)
-		mt798x_phy_led_hw_control_get(phydev, i, NULL);
-}
-
 static int mt7988_phy_probe(struct phy_device *phydev)
 {
 	struct mtk_socphy_shared *shared;
@@ -1470,7 +1251,7 @@ static int mt7988_phy_probe(struct phy_device *phydev)
 
 	phydev->priv = priv;
 
-	mt798x_phy_leds_state_init(phydev);
+	mtk_phy_leds_state_init(phydev);
 
 	err = mt7988_phy_fix_leds_polarities(phydev);
 	if (err)
@@ -1497,7 +1278,7 @@ static int mt7981_phy_probe(struct phy_device *phydev)
 
 	phydev->priv = priv;
 
-	mt798x_phy_leds_state_init(phydev);
+	mtk_phy_leds_state_init(phydev);
 
 	return mt798x_phy_calibration(phydev);
 }
@@ -1512,8 +1293,8 @@ static struct phy_driver mtk_socphy_driver[] = {
 		.probe		= mt7981_phy_probe,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
-		.read_page	= mtk_socphy_read_page,
-		.write_page	= mtk_socphy_write_page,
+		.read_page	= mtk_phy_read_page,
+		.write_page	= mtk_phy_write_page,
 		.led_blink_set	= mt798x_phy_led_blink_set,
 		.led_brightness_set = mt798x_phy_led_brightness_set,
 		.led_hw_is_supported = mt798x_phy_led_hw_is_supported,
@@ -1529,8 +1310,8 @@ static struct phy_driver mtk_socphy_driver[] = {
 		.probe		= mt7988_phy_probe,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
-		.read_page	= mtk_socphy_read_page,
-		.write_page	= mtk_socphy_write_page,
+		.read_page	= mtk_phy_read_page,
+		.write_page	= mtk_phy_write_page,
 		.led_blink_set	= mt798x_phy_led_blink_set,
 		.led_brightness_set = mt798x_phy_led_brightness_set,
 		.led_hw_is_supported = mt798x_phy_led_hw_is_supported,
diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
index 54ea64a..80425d6 100644
--- a/drivers/net/phy/mediatek/mtk-ge.c
+++ b/drivers/net/phy/mediatek/mtk-ge.c
@@ -3,6 +3,11 @@
 #include <linux/module.h>
 #include <linux/phy.h>
 
+#include "mtk.h"
+
+#define MTK_GPHY_ID_MT7530		0x03a29412
+#define MTK_GPHY_ID_MT7531		0x03a29441
+
 #define MTK_EXT_PAGE_ACCESS		0x1f
 #define MTK_PHY_PAGE_STANDARD		0x0000
 #define MTK_PHY_PAGE_EXTENDED		0x0001
@@ -11,15 +16,9 @@
 #define MTK_PHY_PAGE_EXTENDED_2A30	0x2a30
 #define MTK_PHY_PAGE_EXTENDED_52B5	0x52b5
 
-static int mtk_gephy_read_page(struct phy_device *phydev)
-{
-	return __phy_read(phydev, MTK_EXT_PAGE_ACCESS);
-}
-
-static int mtk_gephy_write_page(struct phy_device *phydev, int page)
-{
-	return __phy_write(phydev, MTK_EXT_PAGE_ACCESS, page);
-}
+struct mtk_gephy_priv {
+	unsigned long		led_state;
+};
 
 static void mtk_gephy_config_init(struct phy_device *phydev)
 {
@@ -65,9 +64,97 @@ static int mt7531_phy_config_init(struct phy_device *phydev)
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
+	bool blinking = false;
+	int err = 0;
+	struct mtk_gephy_priv *priv = phydev->priv;
+
+	if (index > 1)
+		return -EINVAL;
+
+	if (delay_on && delay_off && (*delay_on > 0) && (*delay_off > 0)) {
+		blinking = true;
+		*delay_on = 50;
+		*delay_off = 50;
+	}
+
+	err = mtk_phy_hw_led_blink_set(phydev, index, &priv->led_state, blinking);
+	if (err)
+		return err;
+
+	return mtk_phy_hw_led_on_set(phydev, index, &priv->led_state, MTK_GPHY_LED_ON_MASK, false);
+}
+
+static int mt753x_phy_led_brightness_set(struct phy_device *phydev,
+					 u8 index, enum led_brightness value)
+{
+	int err;
+	struct mtk_gephy_priv *priv = phydev->priv;
+
+	err = mtk_phy_hw_led_blink_set(phydev, index, &priv->led_state, false);
+	if (err)
+		return err;
+
+	return mtk_phy_hw_led_on_set(phydev, index, &priv->led_state,
+				     MTK_GPHY_LED_ON_MASK, (value != LED_OFF));
+}
+
+static const unsigned long supported_triggers = (BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
+						 BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
+						 BIT(TRIGGER_NETDEV_LINK)        |
+						 BIT(TRIGGER_NETDEV_LINK_10)     |
+						 BIT(TRIGGER_NETDEV_LINK_100)    |
+						 BIT(TRIGGER_NETDEV_LINK_1000)   |
+						 BIT(TRIGGER_NETDEV_RX)          |
+						 BIT(TRIGGER_NETDEV_TX));
+
+static int mt753x_phy_led_hw_is_supported(struct phy_device *phydev, u8 index, unsigned long rules)
+{
+	return mtk_phy_led_hw_is_supported(phydev, index, rules, supported_triggers);
+}
+
+static int mt753x_phy_led_hw_control_get(struct phy_device *phydev, u8 index,
+					 unsigned long *rules)
+{
+	struct mtk_gephy_priv *priv = phydev->priv;
+
+	return mtk_phy_led_hw_ctrl_get(phydev, index, rules, &priv->led_state,
+					MTK_GPHY_LED_ON_SET,
+					MTK_GPHY_LED_RX_BLINK_SET, MTK_GPHY_LED_TX_BLINK_SET);
+};
+
+static int mt753x_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
+					 unsigned long rules)
+{
+	struct mtk_gephy_priv *priv = phydev->priv;
+
+	return mtk_phy_led_hw_ctrl_set(phydev, index, rules, &priv->led_state,
+					MTK_GPHY_LED_ON_SET,
+					MTK_GPHY_LED_RX_BLINK_SET, MTK_GPHY_LED_TX_BLINK_SET);
+};
+
 static struct phy_driver mtk_gephy_driver[] = {
 	{
-		PHY_ID_MATCH_EXACT(0x03a29412),
+		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7530),
 		.name		= "MediaTek MT7530 PHY",
 		.config_init	= mt7530_phy_config_init,
 		/* Interrupts are handled by the switch, not the PHY
@@ -77,12 +164,14 @@ static struct phy_driver mtk_gephy_driver[] = {
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
-		.read_page	= mtk_gephy_read_page,
-		.write_page	= mtk_gephy_write_page,
+		.read_page	= mtk_phy_read_page,
+		.write_page	= mtk_phy_write_page,
+		.led_hw_is_supported = mt753x_phy_led_hw_is_supported,
 	},
 	{
-		PHY_ID_MATCH_EXACT(0x03a29441),
+		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7531),
 		.name		= "MediaTek MT7531 PHY",
+		.probe		= mt7531_phy_probe,
 		.config_init	= mt7531_phy_config_init,
 		/* Interrupts are handled by the switch, not the PHY
 		 * itself.
@@ -91,16 +180,21 @@ static struct phy_driver mtk_gephy_driver[] = {
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
-		.read_page	= mtk_gephy_read_page,
-		.write_page	= mtk_gephy_write_page,
+		.read_page	= mtk_phy_read_page,
+		.write_page	= mtk_phy_write_page,
+		.led_blink_set	= mt753x_phy_led_blink_set,
+		.led_brightness_set = mt753x_phy_led_brightness_set,
+		.led_hw_is_supported = mt753x_phy_led_hw_is_supported,
+		.led_hw_control_set = mt753x_phy_led_hw_control_set,
+		.led_hw_control_get = mt753x_phy_led_hw_control_get,
 	},
 };
 
 module_phy_driver(mtk_gephy_driver);
 
 static struct mdio_device_id __maybe_unused mtk_gephy_tbl[] = {
-	{ PHY_ID_MATCH_EXACT(0x03a29441) },
-	{ PHY_ID_MATCH_EXACT(0x03a29412) },
+	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7530) },
+	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7531) },
 	{ }
 };
 
diff --git a/drivers/net/phy/mediatek/mtk-phy-lib.c b/drivers/net/phy/mediatek/mtk-phy-lib.c
new file mode 100644
index 0000000..4608837
--- /dev/null
+++ b/drivers/net/phy/mediatek/mtk-phy-lib.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/phy.h>
+#include <linux/module.h>
+
+#include <linux/netdevice.h>
+
+#include "mtk.h"
+
+int mtk_phy_read_page(struct phy_device *phydev)
+{
+	return __phy_read(phydev, MTK_EXT_PAGE_ACCESS);
+}
+EXPORT_SYMBOL_GPL(mtk_phy_read_page);
+
+int mtk_phy_write_page(struct phy_device *phydev, int page)
+{
+	return __phy_write(phydev, MTK_EXT_PAGE_ACCESS, page);
+}
+EXPORT_SYMBOL_GPL(mtk_phy_write_page);
+
+int mtk_phy_led_hw_is_supported(struct phy_device *phydev, u8 index, unsigned long rules,
+				unsigned long supported_triggers)
+{
+	if (index > 1)
+		return -EINVAL;
+
+	/* All combinations of the supported triggers are allowed */
+	if (rules & ~supported_triggers)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_phy_led_hw_is_supported);
+
+int mtk_phy_led_hw_ctrl_get(struct phy_device *phydev, u8 index, unsigned long *rules,
+			    unsigned long *led_state, u16 on_set,
+			    u16 rx_blink_set, u16 tx_blink_set)
+{
+	unsigned int bit_blink = MTK_PHY_LED_STATE_FORCE_BLINK + (index ? 16 : 0);
+	unsigned int bit_netdev = MTK_PHY_LED_STATE_NETDEV + (index ? 16 : 0);
+	unsigned int bit_on = MTK_PHY_LED_STATE_FORCE_ON + (index ? 16 : 0);
+	int on, blink;
+
+	if (index > 1)
+		return -EINVAL;
+
+	on = phy_read_mmd(phydev, MDIO_MMD_VEND2,
+			  index ? MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL);
+
+	if (on < 0)
+		return -EIO;
+
+	blink = phy_read_mmd(phydev, MDIO_MMD_VEND2,
+			     index ? MTK_PHY_LED1_BLINK_CTRL :
+				     MTK_PHY_LED0_BLINK_CTRL);
+	if (blink < 0)
+		return -EIO;
+
+	if ((on & (on_set | MTK_PHY_LED_ON_FDX | MTK_PHY_LED_ON_HDX | MTK_PHY_LED_ON_LINKDOWN)) ||
+	    (blink & (rx_blink_set | tx_blink_set)))
+		set_bit(bit_netdev, led_state);
+	else
+		clear_bit(bit_netdev, led_state);
+
+	if (on & MTK_PHY_LED_ON_FORCE_ON)
+		set_bit(bit_on, led_state);
+	else
+		clear_bit(bit_on, led_state);
+
+	if (blink & MTK_PHY_LED_BLINK_FORCE_BLINK)
+		set_bit(bit_blink, led_state);
+	else
+		clear_bit(bit_blink, led_state);
+
+	if (!rules)
+		return 0;
+
+	if (on & on_set)
+		*rules |= BIT(TRIGGER_NETDEV_LINK);
+
+	if (on & MTK_PHY_LED_ON_LINK10)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_10);
+
+	if (on & MTK_PHY_LED_ON_LINK100)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_100);
+
+	if (on & MTK_PHY_LED_ON_LINK1000)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_1000);
+
+	if (on & MTK_PHY_LED_ON_LINK2500)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_2500);
+
+	if (on & MTK_PHY_LED_ON_FDX)
+		*rules |= BIT(TRIGGER_NETDEV_FULL_DUPLEX);
+
+	if (on & MTK_PHY_LED_ON_HDX)
+		*rules |= BIT(TRIGGER_NETDEV_HALF_DUPLEX);
+
+	if (blink & rx_blink_set)
+		*rules |= BIT(TRIGGER_NETDEV_RX);
+
+	if (blink & tx_blink_set)
+		*rules |= BIT(TRIGGER_NETDEV_TX);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_phy_led_hw_ctrl_get);
+
+int mtk_phy_led_hw_ctrl_set(struct phy_device *phydev, u8 index, unsigned long rules,
+			    unsigned long *led_state, u16 on_set,
+			    u16 rx_blink_set, u16 tx_blink_set)
+{
+	unsigned int bit_netdev = MTK_PHY_LED_STATE_NETDEV + (index ? 16 : 0);
+	u16 on = 0, blink = 0;
+	int ret;
+
+	if (index > 1)
+		return -EINVAL;
+
+	if (rules & BIT(TRIGGER_NETDEV_FULL_DUPLEX))
+		on |= MTK_PHY_LED_ON_FDX;
+
+	if (rules & BIT(TRIGGER_NETDEV_HALF_DUPLEX))
+		on |= MTK_PHY_LED_ON_HDX;
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_10) | BIT(TRIGGER_NETDEV_LINK)))
+		on |= MTK_PHY_LED_ON_LINK10;
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_100) | BIT(TRIGGER_NETDEV_LINK)))
+		on |= MTK_PHY_LED_ON_LINK100;
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_1000) | BIT(TRIGGER_NETDEV_LINK)))
+		on |= MTK_PHY_LED_ON_LINK1000;
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_2500) | BIT(TRIGGER_NETDEV_LINK)))
+		on |= MTK_PHY_LED_ON_LINK2500;
+
+	if (rules & BIT(TRIGGER_NETDEV_RX)) {
+		blink |= (on & on_set) ?
+			  (((on & MTK_PHY_LED_ON_LINK10) ? MTK_PHY_LED_BLINK_10RX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK100) ? MTK_PHY_LED_BLINK_100RX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK1000) ? MTK_PHY_LED_BLINK_1000RX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK2500) ? MTK_PHY_LED_BLINK_2500RX : 0)) :
+			  rx_blink_set;
+	}
+
+	if (rules & BIT(TRIGGER_NETDEV_TX)) {
+		blink |= (on & on_set) ?
+			  (((on & MTK_PHY_LED_ON_LINK10) ? MTK_PHY_LED_BLINK_10TX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK100) ? MTK_PHY_LED_BLINK_100TX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK1000) ? MTK_PHY_LED_BLINK_1000TX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK2500) ? MTK_PHY_LED_BLINK_2500TX : 0)) :
+			  tx_blink_set;
+	}
+
+	if (blink || on)
+		set_bit(bit_netdev, led_state);
+	else
+		clear_bit(bit_netdev, led_state);
+
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, index ?
+			     MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL,
+			     MTK_PHY_LED_ON_FDX | MTK_PHY_LED_ON_HDX | on_set, on);
+
+	if (ret)
+		return ret;
+
+	return phy_write_mmd(phydev, MDIO_MMD_VEND2, index ?
+			     MTK_PHY_LED1_BLINK_CTRL :
+			     MTK_PHY_LED0_BLINK_CTRL, blink);
+}
+EXPORT_SYMBOL_GPL(mtk_phy_led_hw_ctrl_set);
+
+int mtk_phy_hw_led_on_set(struct phy_device *phydev, u8 index, unsigned long *led_state,
+			  u16 led_on_mask, bool on)
+{
+	unsigned int bit_on = MTK_PHY_LED_STATE_FORCE_ON + (index ? 16 : 0);
+	bool changed;
+
+	if (on)
+		changed = !test_and_set_bit(bit_on, led_state);
+	else
+		changed = !!test_and_clear_bit(bit_on, led_state);
+
+	changed |= !!test_and_clear_bit(MTK_PHY_LED_STATE_NETDEV +
+					(index ? 16 : 0), led_state);
+	if (changed)
+		return phy_modify_mmd(phydev, MDIO_MMD_VEND2, index ?
+				      MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL,
+				      led_on_mask,
+				      on ? MTK_PHY_LED_ON_FORCE_ON : 0);
+	else
+		return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_phy_hw_led_on_set);
+
+int mtk_phy_hw_led_blink_set(struct phy_device *phydev, u8 index, unsigned long *led_state,
+			     bool blinking)
+{
+	unsigned int bit_blink = MTK_PHY_LED_STATE_FORCE_BLINK + (index ? 16 : 0);
+	bool changed;
+
+	if (blinking)
+		changed = !test_and_set_bit(bit_blink, led_state);
+	else
+		changed = !!test_and_clear_bit(bit_blink, led_state);
+
+	changed |= !!test_bit(MTK_PHY_LED_STATE_NETDEV +
+			      (index ? 16 : 0), led_state);
+	if (changed)
+		return phy_write_mmd(phydev, MDIO_MMD_VEND2, index ?
+				     MTK_PHY_LED1_BLINK_CTRL : MTK_PHY_LED0_BLINK_CTRL,
+				     blinking ? MTK_PHY_LED_BLINK_FORCE_BLINK : 0);
+	else
+		return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_phy_hw_led_blink_set);
+
+void mtk_phy_leds_state_init(struct phy_device *phydev)
+{
+	int i;
+
+	for (i = 0; i < 2; ++i)
+		phydev->drv->led_hw_control_get(phydev, i, NULL);
+}
+EXPORT_SYMBOL_GPL(mtk_phy_leds_state_init);
+
+MODULE_DESCRIPTION("MediaTek Ethernet PHY driver common");
+MODULE_AUTHOR("Sky Huang <SkyLake.Huang@mediatek.com>");
+MODULE_AUTHOR("Daniel Golle <daniel@makrotopia.org>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/phy/mediatek/mtk.h b/drivers/net/phy/mediatek/mtk.h
new file mode 100644
index 0000000..c392c38
--- /dev/null
+++ b/drivers/net/phy/mediatek/mtk.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Common definition for Mediatek Ethernet PHYs
+ * Author: SkyLake Huang <SkyLake.Huang@mediatek.com>
+ * Copyright (c) 2024 MediaTek Inc.
+ */
+
+#ifndef _MTK_EPHY_H_
+#define _MTK_EPHY_H_
+
+#define MTK_EXT_PAGE_ACCESS			0x1f
+
+/* Registers on MDIO_MMD_VEND2 */
+#define MTK_PHY_LED0_ON_CTRL			0x24
+#define MTK_PHY_LED1_ON_CTRL			0x26
+#define   MTK_GPHY_LED_ON_MASK			GENMASK(6, 0)
+#define   MTK_2P5GPHY_LED_ON_MASK		GENMASK(7, 0)
+#define   MTK_PHY_LED_ON_LINK1000		BIT(0)
+#define   MTK_PHY_LED_ON_LINK100		BIT(1)
+#define   MTK_PHY_LED_ON_LINK10			BIT(2)
+#define   MTK_PHY_LED_ON_LINKDOWN		BIT(3)
+#define   MTK_PHY_LED_ON_FDX			BIT(4) /* Full duplex */
+#define   MTK_PHY_LED_ON_HDX			BIT(5) /* Half duplex */
+#define   MTK_PHY_LED_ON_FORCE_ON		BIT(6)
+#define   MTK_PHY_LED_ON_LINK2500		BIT(7)
+#define   MTK_PHY_LED_ON_POLARITY		BIT(14)
+#define   MTK_PHY_LED_ON_ENABLE			BIT(15)
+
+#define MTK_PHY_LED0_BLINK_CTRL			0x25
+#define MTK_PHY_LED1_BLINK_CTRL			0x27
+#define   MTK_PHY_LED_BLINK_1000TX		BIT(0)
+#define   MTK_PHY_LED_BLINK_1000RX		BIT(1)
+#define   MTK_PHY_LED_BLINK_100TX		BIT(2)
+#define   MTK_PHY_LED_BLINK_100RX		BIT(3)
+#define   MTK_PHY_LED_BLINK_10TX		BIT(4)
+#define   MTK_PHY_LED_BLINK_10RX		BIT(5)
+#define   MTK_PHY_LED_BLINK_COLLISION		BIT(6)
+#define   MTK_PHY_LED_BLINK_RX_CRC_ERR		BIT(7)
+#define   MTK_PHY_LED_BLINK_RX_IDLE_ERR		BIT(8)
+#define   MTK_PHY_LED_BLINK_FORCE_BLINK		BIT(9)
+#define   MTK_PHY_LED_BLINK_2500TX		BIT(10)
+#define   MTK_PHY_LED_BLINK_2500RX		BIT(11)
+
+#define MTK_GPHY_LED_ON_SET			(MTK_PHY_LED_ON_LINK1000 | \
+						 MTK_PHY_LED_ON_LINK100 | \
+						 MTK_PHY_LED_ON_LINK10)
+#define MTK_GPHY_LED_RX_BLINK_SET		(MTK_PHY_LED_BLINK_1000RX | \
+						 MTK_PHY_LED_BLINK_100RX | \
+						 MTK_PHY_LED_BLINK_10RX)
+#define MTK_GPHY_LED_TX_BLINK_SET		(MTK_PHY_LED_BLINK_1000RX | \
+						 MTK_PHY_LED_BLINK_100RX | \
+						 MTK_PHY_LED_BLINK_10RX)
+
+#define MTK_2P5GPHY_LED_ON_SET			(MTK_PHY_LED_ON_LINK2500 | \
+						 MTK_GPHY_LED_ON_SET)
+#define MTK_2P5GPHY_LED_RX_BLINK_SET		(MTK_PHY_LED_BLINK_2500RX | \
+						 MTK_GPHY_LED_RX_BLINK_SET)
+#define MTK_2P5GPHY_LED_TX_BLINK_SET		(MTK_PHY_LED_BLINK_2500RX | \
+						 MTK_GPHY_LED_TX_BLINK_SET)
+
+#define MTK_PHY_LED_STATE_FORCE_ON	0
+#define MTK_PHY_LED_STATE_FORCE_BLINK	1
+#define MTK_PHY_LED_STATE_NETDEV	2
+
+int mtk_phy_read_page(struct phy_device *phydev);
+int mtk_phy_write_page(struct phy_device *phydev, int page);
+
+int mtk_phy_led_hw_is_supported(struct phy_device *phydev, u8 index, unsigned long rules,
+				unsigned long supported_triggers);
+int mtk_phy_led_hw_ctrl_set(struct phy_device *phydev, u8 index, unsigned long rules,
+			    unsigned long *led_state, u16 on_set,
+			    u16 rx_blink_set, u16 tx_blink_set);
+int mtk_phy_led_hw_ctrl_get(struct phy_device *phydev, u8 index, unsigned long *rules,
+			    unsigned long *led_state, u16 on_set,
+			    u16 rx_blink_set, u16 tx_blink_set);
+int mtk_phy_hw_led_on_set(struct phy_device *phydev, u8 index, unsigned long *led_state,
+			  u16 led_on_mask, bool on);
+int mtk_phy_hw_led_blink_set(struct phy_device *phydev, u8 index, unsigned long *led_state,
+			     bool blinking);
+void mtk_phy_leds_state_init(struct phy_device *phydev);
+
+#endif /* _MTK_EPHY_H_ */
-- 
2.18.0


