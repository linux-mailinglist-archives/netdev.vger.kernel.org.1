Return-Path: <netdev+bounces-143350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B4F9C2232
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 17:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FEE81C2524E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B3E192D7C;
	Fri,  8 Nov 2024 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mE0B4V+8"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56744197531;
	Fri,  8 Nov 2024 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083737; cv=none; b=a9j0tVeNskqUc9lysWRjWhiiZXoAOvUXyH08LpIbAr0kOytaSFg+tp9AA9sffH59CWKGF0ymRDT8GVP+PLiEsFUGK4do5W03/6H6qVs8g6OK5onWibQ4ZINwG3dsWdH+m8y6mmfFBKQYebmya38cpL2Bsng9HWzDt8GQaHypswI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083737; c=relaxed/simple;
	bh=OVkiFiESEFKBLHgJh8NDgeqhI6e6HCyk6RLgKZTaRyc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BmlzpPEXWXfgE1ASDz+kUIcYcn0f0NA9HrF4OcIG2bayuECy7iDDF6J7b1tDYrE/3JDG3FhnahigaiKgecGKFhXm6YesO1tmtGlApGXkhO8fOgz5weJbZ2+jtMTO9ddX/ATASou9X232ImvC1LSzmMu2+8boKyFddyfSXQHYDaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mE0B4V+8; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 75a7396c9def11efbd192953cf12861f-20241109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5DVvFlczwoXyksKJ8yyzP6hWYdTYxSGu0cjyx8REsfw=;
	b=mE0B4V+8m1Cn1zLJ75syDcf+ilshiG8AQCK7eh0liDMcQf+Ojn3Ncu5O6o8wqgqfa1omVhw+KEpOzeJmREndhvVhL0q0NZHZ+XQLP0JVy9l1Ha80P0bSgwWhbLcvxRLEsIs+0E0u5zTbNyOVVOZjBc1N4p3oZel4UOxUV6p1K8c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:618390dc-7192-40c5-a3f3-028a4107a1d3,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:b0fcdc3,CLOUDID:ebf9d91b-4f51-4e1d-bb6a-1fd98b6b19d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 75a7396c9def11efbd192953cf12861f-20241109
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1981576511; Sat, 09 Nov 2024 00:35:26 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 9 Nov 2024 00:35:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 9 Nov 2024 00:35:25 +0800
From: Sky Huang <SkyLake.Huang@mediatek.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Golle
	<daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>, SkyLake Huang
	<SkyLake.Huang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Simon
 Horman <horms@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
CC: Steven Liu <Steven.Liu@mediatek.com>, SkyLake.Huang
	<skylake.huang@mediatek.com>
Subject: [PATCH net-next v3 2/5] net: phy: mediatek: Move LED helper functions into mtk phy lib
Date: Sat, 9 Nov 2024 00:34:52 +0800
Message-ID: <20241108163455.885-3-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241108163455.885-1-SkyLake.Huang@mediatek.com>
References: <20241108163455.885-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

This patch creates mtk-phy-lib.c & mtk-phy.h and integrates mtk-ge-soc.c's
LED helper functions so that we can use those helper functions in other
MTK's ethernet phy driver.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
 MAINTAINERS                            |   2 +
 drivers/net/phy/mediatek/Kconfig       |   4 +
 drivers/net/phy/mediatek/Makefile      |   1 +
 drivers/net/phy/mediatek/mtk-ge-soc.c  | 280 +++----------------------
 drivers/net/phy/mediatek/mtk-phy-lib.c | 254 ++++++++++++++++++++++
 drivers/net/phy/mediatek/mtk.h         |  86 ++++++++
 6 files changed, 372 insertions(+), 255 deletions(-)
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
index 112d9c0..19b5d23 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config MTK_NET_PHYLIB
+	tristate
+
 config MEDIATEK_GE_PHY
 	tristate "MediaTek Gigabit Ethernet PHYs"
 	help
@@ -13,6 +16,7 @@ config MEDIATEK_GE_SOC_PHY
 	tristate "MediaTek SoC Ethernet PHYs"
 	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
 	depends on NVMEM_MTK_EFUSE
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
index a931832..d3a8b39 100644
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
@@ -299,14 +266,6 @@ enum CAL_MODE {
 	SW_M
 };
 
-#define MTK_PHY_LED_STATE_FORCE_ON	0
-#define MTK_PHY_LED_STATE_FORCE_BLINK	1
-#define MTK_PHY_LED_STATE_NETDEV	2
-
-struct mtk_socphy_priv {
-	unsigned long		led_state;
-};
-
 struct mtk_socphy_shared {
 	u32			boottrap;
 	struct mtk_socphy_priv	priv[4];
@@ -1172,76 +1131,23 @@ static int mt798x_phy_config_init(struct phy_device *phydev)
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
-				      MTK_PHY_LED1_ON_CTRL :
-				      MTK_PHY_LED0_ON_CTRL,
-				      MTK_PHY_LED_ON_MASK,
-				      on ? MTK_PHY_LED_ON_FORCE_ON : 0);
-	else
-		return 0;
-}
-
-static int mt798x_phy_hw_led_blink_set(struct phy_device *phydev, u8 index,
-				       bool blinking)
-{
-	unsigned int bit_blink = MTK_PHY_LED_STATE_FORCE_BLINK +
-				 (index ? 16 : 0);
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
-				     MTK_PHY_LED1_BLINK_CTRL :
-				     MTK_PHY_LED0_BLINK_CTRL,
-				     blinking ?
-				     MTK_PHY_LED_BLINK_FORCE_BLINK : 0);
-	else
-		return 0;
-}
-
 static int mt798x_phy_led_blink_set(struct phy_device *phydev, u8 index,
 				    unsigned long *delay_on,
 				    unsigned long *delay_off)
 {
 	bool blinking = false;
-	int err = 0;
-
-	if (index > 1)
-		return -EINVAL;
+	int err;
 
-	if (delay_on && delay_off && (*delay_on > 0) && (*delay_off > 0)) {
-		blinking = true;
-		*delay_on = 50;
-		*delay_off = 50;
-	}
+	err = mtk_phy_led_num_dly_cfg(index, delay_on, delay_off, &blinking);
+	if (err < 0)
+		return err;
 
-	err = mt798x_phy_hw_led_blink_set(phydev, index, blinking);
+	err = mtk_phy_hw_led_blink_set(phydev, index, blinking);
 	if (err)
 		return err;
 
-	return mt798x_phy_hw_led_on_set(phydev, index, false);
+	return mtk_phy_hw_led_on_set(phydev, index, MTK_GPHY_LED_ON_MASK,
+				     false);
 }
 
 static int mt798x_phy_led_brightness_set(struct phy_device *phydev,
@@ -1249,11 +1155,12 @@ static int mt798x_phy_led_brightness_set(struct phy_device *phydev,
 {
 	int err;
 
-	err = mt798x_phy_hw_led_blink_set(phydev, index, false);
+	err = mtk_phy_hw_led_blink_set(phydev, index, false);
 	if (err)
 		return err;
 
-	return mt798x_phy_hw_led_on_set(phydev, index, (value != LED_OFF));
+	return mtk_phy_hw_led_on_set(phydev, index, MTK_GPHY_LED_ON_MASK,
+				     (value != LED_OFF));
 }
 
 static const unsigned long supported_triggers =
@@ -1269,155 +1176,26 @@ static const unsigned long supported_triggers =
 static int mt798x_phy_led_hw_is_supported(struct phy_device *phydev, u8 index,
 					  unsigned long rules)
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
+	return mtk_phy_led_hw_is_supported(phydev, index, rules,
+					   supported_triggers);
+}
 
 static int mt798x_phy_led_hw_control_get(struct phy_device *phydev, u8 index,
 					 unsigned long *rules)
 {
-	unsigned int bit_blink = MTK_PHY_LED_STATE_FORCE_BLINK +
-				 (index ? 16 : 0);
-	unsigned int bit_netdev = MTK_PHY_LED_STATE_NETDEV + (index ? 16 : 0);
-	unsigned int bit_on = MTK_PHY_LED_STATE_FORCE_ON + (index ? 16 : 0);
-	struct mtk_socphy_priv *priv = phydev->priv;
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
-
-	if ((on & (MTK_PHY_LED_ON_LINK | MTK_PHY_LED_ON_FDX |
-		   MTK_PHY_LED_ON_HDX | MTK_PHY_LED_ON_LINKDOWN)) ||
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
+	return mtk_phy_led_hw_ctrl_get(phydev, index, rules,
+				       MTK_GPHY_LED_ON_SET,
+				       MTK_GPHY_LED_RX_BLINK_SET,
+				       MTK_GPHY_LED_TX_BLINK_SET);
 };
 
 static int mt798x_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
 					 unsigned long rules)
 {
-	unsigned int bit_netdev = MTK_PHY_LED_STATE_NETDEV + (index ? 16 : 0);
-	struct mtk_socphy_priv *priv = phydev->priv;
-	u16 on = 0, blink = 0;
-	int ret;
-
-	if (index > 1)
-		return -EINVAL;
-
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
-			  (((on & MTK_PHY_LED_ON_LINK10) ?
-			    MTK_PHY_LED_BLINK_10RX : 0) |
-			   ((on & MTK_PHY_LED_ON_LINK100) ?
-			    MTK_PHY_LED_BLINK_100RX : 0) |
-			   ((on & MTK_PHY_LED_ON_LINK1000) ?
-			    MTK_PHY_LED_BLINK_1000RX : 0)) :
-			  MTK_PHY_LED_BLINK_RX;
-	}
-
-	if (rules & BIT(TRIGGER_NETDEV_TX)) {
-		blink |= (on & MTK_PHY_LED_ON_LINK) ?
-			  (((on & MTK_PHY_LED_ON_LINK10) ?
-			    MTK_PHY_LED_BLINK_10TX : 0) |
-			   ((on & MTK_PHY_LED_ON_LINK100) ?
-			    MTK_PHY_LED_BLINK_100TX : 0) |
-			   ((on & MTK_PHY_LED_ON_LINK1000) ?
-			    MTK_PHY_LED_BLINK_1000TX : 0)) :
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
+	return mtk_phy_led_hw_ctrl_set(phydev, index, rules,
+				       MTK_GPHY_LED_ON_SET,
+				       MTK_GPHY_LED_RX_BLINK_SET,
+				       MTK_GPHY_LED_TX_BLINK_SET);
 };
 
 static bool mt7988_phy_led_get_polarity(struct phy_device *phydev, int led_num)
@@ -1492,14 +1270,6 @@ static int mt7988_phy_probe_shared(struct phy_device *phydev)
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
@@ -1525,7 +1295,7 @@ static int mt7988_phy_probe(struct phy_device *phydev)
 
 	phydev->priv = priv;
 
-	mt798x_phy_leds_state_init(phydev);
+	mtk_phy_leds_state_init(phydev);
 
 	err = mt7988_phy_fix_leds_polarities(phydev);
 	if (err)
@@ -1552,7 +1322,7 @@ static int mt7981_phy_probe(struct phy_device *phydev)
 
 	phydev->priv = priv;
 
-	mt798x_phy_leds_state_init(phydev);
+	mtk_phy_leds_state_init(phydev);
 
 	return mt798x_phy_calibration(phydev);
 }
diff --git a/drivers/net/phy/mediatek/mtk-phy-lib.c b/drivers/net/phy/mediatek/mtk-phy-lib.c
new file mode 100644
index 0000000..34b0957
--- /dev/null
+++ b/drivers/net/phy/mediatek/mtk-phy-lib.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/phy.h>
+#include <linux/module.h>
+
+#include <linux/netdevice.h>
+
+#include "mtk.h"
+
+int mtk_phy_led_hw_is_supported(struct phy_device *phydev, u8 index,
+				unsigned long rules,
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
+int mtk_phy_led_hw_ctrl_get(struct phy_device *phydev, u8 index,
+			    unsigned long *rules, u16 on_set,
+			    u16 rx_blink_set, u16 tx_blink_set)
+{
+	unsigned int bit_blink = MTK_PHY_LED_STATE_FORCE_BLINK +
+				 (index ? 16 : 0);
+	unsigned int bit_netdev = MTK_PHY_LED_STATE_NETDEV + (index ? 16 : 0);
+	unsigned int bit_on = MTK_PHY_LED_STATE_FORCE_ON + (index ? 16 : 0);
+	struct mtk_socphy_priv *priv = phydev->priv;
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
+	if ((on & (on_set | MTK_PHY_LED_ON_FDX |
+		   MTK_PHY_LED_ON_HDX | MTK_PHY_LED_ON_LINKDOWN)) ||
+	    (blink & (rx_blink_set | tx_blink_set)))
+		set_bit(bit_netdev, &priv->led_state);
+	else
+		clear_bit(bit_netdev, &priv->led_state);
+
+	if (on & MTK_PHY_LED_ON_FORCE_ON)
+		set_bit(bit_on, &priv->led_state);
+	else
+		clear_bit(bit_on, &priv->led_state);
+
+	if (blink & MTK_PHY_LED_BLINK_FORCE_BLINK)
+		set_bit(bit_blink, &priv->led_state);
+	else
+		clear_bit(bit_blink, &priv->led_state);
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
+int mtk_phy_led_hw_ctrl_set(struct phy_device *phydev, u8 index,
+			    unsigned long rules, u16 on_set,
+			    u16 rx_blink_set, u16 tx_blink_set)
+{
+	unsigned int bit_netdev = MTK_PHY_LED_STATE_NETDEV + (index ? 16 : 0);
+	struct mtk_socphy_priv *priv = phydev->priv;
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
+			  (((on & MTK_PHY_LED_ON_LINK10) ?
+			    MTK_PHY_LED_BLINK_10RX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK100) ?
+			    MTK_PHY_LED_BLINK_100RX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK1000) ?
+			    MTK_PHY_LED_BLINK_1000RX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK2500) ?
+			    MTK_PHY_LED_BLINK_2500RX : 0)) :
+			  rx_blink_set;
+	}
+
+	if (rules & BIT(TRIGGER_NETDEV_TX)) {
+		blink |= (on & on_set) ?
+			  (((on & MTK_PHY_LED_ON_LINK10) ?
+			    MTK_PHY_LED_BLINK_10TX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK100) ?
+			    MTK_PHY_LED_BLINK_100TX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK1000) ?
+			    MTK_PHY_LED_BLINK_1000TX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK2500) ?
+			    MTK_PHY_LED_BLINK_2500TX : 0)) :
+			  tx_blink_set;
+	}
+
+	if (blink || on)
+		set_bit(bit_netdev, &priv->led_state);
+	else
+		clear_bit(bit_netdev, &priv->led_state);
+
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, index ?
+			     MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL,
+			     MTK_PHY_LED_ON_FDX | MTK_PHY_LED_ON_HDX | on_set,
+			     on);
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
+int mtk_phy_led_num_dly_cfg(u8 index, unsigned long *delay_on,
+			    unsigned long *delay_off, bool *blinking)
+{
+	if (index > 1)
+		return -EINVAL;
+
+	if (delay_on && delay_off && (*delay_on > 0) && (*delay_off > 0)) {
+		*blinking = true;
+		*delay_on = 50;
+		*delay_off = 50;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_phy_led_num_dly_cfg);
+
+int mtk_phy_hw_led_on_set(struct phy_device *phydev, u8 index,
+			  u16 led_on_mask, bool on)
+{
+	unsigned int bit_on = MTK_PHY_LED_STATE_FORCE_ON + (index ? 16 : 0);
+	struct mtk_socphy_priv *priv = phydev->priv;
+	bool changed;
+
+	if (on)
+		changed = !test_and_set_bit(bit_on, &priv->led_state);
+	else
+		changed = !!test_and_clear_bit(bit_on, &priv->led_state);
+
+	changed |= !!test_and_clear_bit(MTK_PHY_LED_STATE_NETDEV +
+					(index ? 16 : 0), &priv->led_state);
+	if (changed)
+		return phy_modify_mmd(phydev, MDIO_MMD_VEND2, index ?
+				      MTK_PHY_LED1_ON_CTRL :
+				      MTK_PHY_LED0_ON_CTRL,
+				      led_on_mask,
+				      on ? MTK_PHY_LED_ON_FORCE_ON : 0);
+	else
+		return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_phy_hw_led_on_set);
+
+int mtk_phy_hw_led_blink_set(struct phy_device *phydev, u8 index, bool blinking)
+{
+	unsigned int bit_blink = MTK_PHY_LED_STATE_FORCE_BLINK +
+				 (index ? 16 : 0);
+	struct mtk_socphy_priv *priv = phydev->priv;
+	bool changed;
+
+	if (blinking)
+		changed = !test_and_set_bit(bit_blink, &priv->led_state);
+	else
+		changed = !!test_and_clear_bit(bit_blink, &priv->led_state);
+
+	changed |= !!test_bit(MTK_PHY_LED_STATE_NETDEV +
+			      (index ? 16 : 0), &priv->led_state);
+	if (changed)
+		return phy_write_mmd(phydev, MDIO_MMD_VEND2, index ?
+				     MTK_PHY_LED1_BLINK_CTRL :
+				     MTK_PHY_LED0_BLINK_CTRL,
+				     blinking ?
+				     MTK_PHY_LED_BLINK_FORCE_BLINK : 0);
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
index 0000000..9aaff2c
--- /dev/null
+++ b/drivers/net/phy/mediatek/mtk.h
@@ -0,0 +1,86 @@
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
+struct mtk_socphy_priv {
+	unsigned long		led_state;
+};
+
+int mtk_phy_led_hw_is_supported(struct phy_device *phydev, u8 index,
+				unsigned long rules,
+				unsigned long supported_triggers);
+int mtk_phy_led_hw_ctrl_set(struct phy_device *phydev, u8 index,
+			    unsigned long rules, u16 on_set,
+			    u16 rx_blink_set, u16 tx_blink_set);
+int mtk_phy_led_hw_ctrl_get(struct phy_device *phydev, u8 index,
+			    unsigned long *rules, u16 on_set,
+			    u16 rx_blink_set, u16 tx_blink_set);
+int mtk_phy_led_num_dly_cfg(u8 index, unsigned long *delay_on,
+			    unsigned long *delay_off, bool *blinking);
+int mtk_phy_hw_led_on_set(struct phy_device *phydev, u8 index,
+			  u16 led_on_mask, bool on);
+int mtk_phy_hw_led_blink_set(struct phy_device *phydev, u8 index,
+			     bool blinking);
+void mtk_phy_leds_state_init(struct phy_device *phydev);
+
+#endif /* _MTK_EPHY_H_ */
-- 
2.45.2


