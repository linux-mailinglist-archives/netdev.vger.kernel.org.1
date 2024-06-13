Return-Path: <netdev+bounces-103171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DB8906A3D
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57305281A31
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 10:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859921428F5;
	Thu, 13 Jun 2024 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tNuTgTgj"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E091411E1;
	Thu, 13 Jun 2024 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718275359; cv=none; b=qQcBP+m2E5ddr1/8HX2cEPeCwb/kgNd0E+Sx0LYuieqsvS9fgnq27EYMQTdxR8YaVQ3PBJmrSKaX3keIq1/qAeJjl+qZ3CYcFcK08NAcjld8ixt+TOYi8qeCcF4z/qFYhG2OedkXvg1K2XBPgs4s8Jx8qzusF1t8fyKbVPyxsd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718275359; c=relaxed/simple;
	bh=mVRm9BG8yY2BwWO0u1PDoSV+ZqXjrbfYtMN7+9zfZLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4vQ8casuPoyw2nZ0exEzKleYWE0ebklACiFlY9GI1RF/8rdkqa5zjoEYNBmMzkzRFZE0e5c2dea+p4rCDRs4uLdwG0KBWkBZMgE9hGJkHzQJgkOFdc06ENijObbTj35MyAU86PzIrqNlUmUxOvxkU2QEpFEtR0FjKARKmECes4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=tNuTgTgj; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a1f5cc10297111efa22eafcdcd04c131-20240613
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ogUjqM661Wdoubr7lbovaujllUWmyZJUCVnGIZVOu8w=;
	b=tNuTgTgjqGlCR6/JN9ESs89dES6OATUShEI8OcqwQuYh89wSAFVAtwD0HMQqgEqDYw4T68TNDxHGqJJqirYNJZKN1UVpaHef4PXTSpFgVuSYL1YmkUhJ/3C0JzCfVcQr2nPnlqjwyOkvAcnuURLo3s13cDiXAp6etyFhWgKYWvQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:34baca86-7df4-4d89-91ca-fad34faf0b9a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:bcf18844-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a1f5cc10297111efa22eafcdcd04c131-20240613
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1429116146; Thu, 13 Jun 2024 18:42:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 13 Jun 2024 18:42:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 13 Jun 2024 18:42:27 +0800
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
Subject: [PATCH net-next v7 2/5] net: phy: mediatek: Move LED and read/write page helper functions into mtk phy lib
Date: Thu, 13 Jun 2024 18:40:20 +0800
Message-ID: <20240613104023.13044-3-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240613104023.13044-1-SkyLake.Huang@mediatek.com>
References: <20240613104023.13044-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.973900-8.000000
X-TMASE-MatchedRID: RwCeQYFP0x2f9SROPcS9xrMjW/sniEQKu56wFPSkMVGM2ehTV+imi/hT
	6/pHvNpJWASbhXBhlp5M8qdoCvOVvj13WcdbGR6QGVyS87Wb4lxMjQ19j30wycSiwizsgluQU8S
	+/fFbuZPO0pdSWEgFjNRrGypw1446bxp6eJGYrDWHZXNSWjgdU3JzCd85HZTQ0SxMhOhuA0SJW1
	4oA532uGA7CuFxYDWF8WNFhoH0nAMk6f2zPJ9BDQVeOjvd5xeaIZm2INWXDp7NQVzhfYY5sqeFn
	JsqgWxceZ39uEaUXUh5SvTw5gBL7Je8p4eY614fSHCU59h5KrHQpOLaYmAnSOKYpwtG+wHV8fgY
	0S21d+MSjqILHIn8ccnEj8JEWbFSXjFzd0Y4poK0sO72q2op4a6JG5H2YJq6NEJplIoT86wRRuB
	BgUeHeF4/htSNgpXftfUp3kDdFrmdtLQ02m0B1riMC5wdwKqdl2F9+KxZd8fczkKO5k4APkH8Bv
	ERi2dU4vM1YF6AJbbCCfuIMF6xLSAHAopEd76vnqg/VrSZEiM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.973900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	B3434FBD206738E6294BCA5017DE38A7B5C49D6BF3670AF8F8E732F3186E6CDF2000:8
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
 drivers/net/phy/mediatek/mtk-ge-soc.c  | 340 ++++++-------------------
 drivers/net/phy/mediatek/mtk-ge.c      | 135 ++++++++--
 drivers/net/phy/mediatek/mtk-phy-lib.c | 247 ++++++++++++++++++
 drivers/net/phy/mediatek/mtk.h         |  83 ++++++
 7 files changed, 528 insertions(+), 285 deletions(-)
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
index 47af872..fa65e61 100644
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
@@ -342,7 +295,8 @@ static int cal_cycle(struct phy_device *phydev, int devad,
 	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
 					MTK_PHY_RG_AD_CAL_CLK, reg_val,
 					reg_val & MTK_PHY_DA_CAL_CLK, 500,
-					ANALOG_INTERNAL_OPERATION_MAX_US, false);
+					ANALOG_INTERNAL_OPERATION_MAX_US,
+					false);
 	if (ret) {
 		phydev_err(phydev, "Calibration cycle timeout\n");
 		return ret;
@@ -351,7 +305,7 @@ static int cal_cycle(struct phy_device *phydev, int devad,
 	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_AD_CALIN,
 			   MTK_PHY_DA_CALIN_FLAG);
 	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_AD_CAL_COMP) >>
-			   MTK_PHY_AD_CAL_COMP_OUT_SHIFT;
+	      MTK_PHY_AD_CAL_COMP_OUT_SHIFT;
 	phydev_dbg(phydev, "cal_val: 0x%x, ret: %d\n", cal_val, ret);
 
 	return ret;
@@ -440,38 +394,46 @@ static int tx_amp_fill_result(struct phy_device *phydev, u16 *buf)
 	}
 
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TXVLD_DA_RG,
-		       MTK_PHY_DA_TX_I2MPB_A_GBE_MASK, (buf[0] + bias[0]) << 10);
+		       MTK_PHY_DA_TX_I2MPB_A_GBE_MASK,
+		       (buf[0] + bias[0]) << 10);
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TXVLD_DA_RG,
 		       MTK_PHY_DA_TX_I2MPB_A_TBT_MASK, buf[0] + bias[1]);
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_A2,
-		       MTK_PHY_DA_TX_I2MPB_A_HBT_MASK, (buf[0] + bias[2]) << 10);
+		       MTK_PHY_DA_TX_I2MPB_A_HBT_MASK,
+		       (buf[0] + bias[2]) << 10);
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_A2,
 		       MTK_PHY_DA_TX_I2MPB_A_TST_MASK, buf[0] + bias[3]);
 
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_B1,
-		       MTK_PHY_DA_TX_I2MPB_B_GBE_MASK, (buf[1] + bias[4]) << 8);
+		       MTK_PHY_DA_TX_I2MPB_B_GBE_MASK,
+		       (buf[1] + bias[4]) << 8);
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_B1,
 		       MTK_PHY_DA_TX_I2MPB_B_TBT_MASK, buf[1] + bias[5]);
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_B2,
-		       MTK_PHY_DA_TX_I2MPB_B_HBT_MASK, (buf[1] + bias[6]) << 8);
+		       MTK_PHY_DA_TX_I2MPB_B_HBT_MASK,
+		       (buf[1] + bias[6]) << 8);
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_B2,
 		       MTK_PHY_DA_TX_I2MPB_B_TST_MASK, buf[1] + bias[7]);
 
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_C1,
-		       MTK_PHY_DA_TX_I2MPB_C_GBE_MASK, (buf[2] + bias[8]) << 8);
+		       MTK_PHY_DA_TX_I2MPB_C_GBE_MASK,
+		       (buf[2] + bias[8]) << 8);
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_C1,
 		       MTK_PHY_DA_TX_I2MPB_C_TBT_MASK, buf[2] + bias[9]);
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_C2,
-		       MTK_PHY_DA_TX_I2MPB_C_HBT_MASK, (buf[2] + bias[10]) << 8);
+		       MTK_PHY_DA_TX_I2MPB_C_HBT_MASK,
+		       (buf[2] + bias[10]) << 8);
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_C2,
 		       MTK_PHY_DA_TX_I2MPB_C_TST_MASK, buf[2] + bias[11]);
 
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_D1,
-		       MTK_PHY_DA_TX_I2MPB_D_GBE_MASK, (buf[3] + bias[12]) << 8);
+		       MTK_PHY_DA_TX_I2MPB_D_GBE_MASK,
+		       (buf[3] + bias[12]) << 8);
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_D1,
 		       MTK_PHY_DA_TX_I2MPB_D_TBT_MASK, buf[3] + bias[13]);
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_D2,
-		       MTK_PHY_DA_TX_I2MPB_D_HBT_MASK, (buf[3] + bias[14]) << 8);
+		       MTK_PHY_DA_TX_I2MPB_D_HBT_MASK,
+		       (buf[3] + bias[14]) << 8);
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TX_I2MPB_TEST_MODE_D2,
 		       MTK_PHY_DA_TX_I2MPB_D_TST_MASK, buf[3] + bias[15]);
 
@@ -662,7 +624,8 @@ static int tx_vcm_cal_sw(struct phy_device *phydev, u8 rg_txreserve_x)
 		goto restore;
 
 	/* We calibrate TX-VCM in different logic. Check upper index and then
-	 * lower index. If this calibration is valid, apply lower index's result.
+	 * lower index. If this calibration is valid, apply lower index's
+	 * result.
 	 */
 	ret = upper_ret - lower_ret;
 	if (ret == 1) {
@@ -691,7 +654,8 @@ static int tx_vcm_cal_sw(struct phy_device *phydev, u8 rg_txreserve_x)
 	} else if (upper_idx == TXRESERVE_MAX && upper_ret == 0 &&
 		   lower_ret == 0) {
 		ret = 0;
-		phydev_warn(phydev, "TX-VCM SW cal result at high margin 0x%x\n",
+		phydev_warn(phydev,
+			    "TX-VCM SW cal result at high margin 0x%x\n",
 			    upper_idx);
 	} else {
 		ret = -EINVAL;
@@ -795,7 +759,8 @@ static void mt7981_phy_finetune(struct phy_device *phydev)
 
 	/* TR_OPEN_LOOP_EN = 1, lpf_x_average = 9 */
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DEV1E_REG234,
-		       MTK_PHY_TR_OPEN_LOOP_EN_MASK | MTK_PHY_LPF_X_AVERAGE_MASK,
+		       MTK_PHY_TR_OPEN_LOOP_EN_MASK |
+		       MTK_PHY_LPF_X_AVERAGE_MASK,
 		       BIT(0) | FIELD_PREP(MTK_PHY_LPF_X_AVERAGE_MASK, 0x9));
 
 	/* rg_tr_lpf_cnt_val = 512 */
@@ -864,7 +829,8 @@ static void mt7988_phy_finetune(struct phy_device *phydev)
 
 	/* TR_OPEN_LOOP_EN = 1, lpf_x_average = 10 */
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DEV1E_REG234,
-		       MTK_PHY_TR_OPEN_LOOP_EN_MASK | MTK_PHY_LPF_X_AVERAGE_MASK,
+		       MTK_PHY_TR_OPEN_LOOP_EN_MASK |
+		       MTK_PHY_LPF_X_AVERAGE_MASK,
 		       BIT(0) | FIELD_PREP(MTK_PHY_LPF_X_AVERAGE_MASK, 0xa));
 
 	/* rg_tr_lpf_cnt_val = 1023 */
@@ -976,7 +942,8 @@ static void mt798x_phy_eee(struct phy_device *phydev)
 	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
 
 	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_3);
-	__phy_modify(phydev, MTK_PHY_LPI_REG_14, MTK_PHY_LPI_WAKE_TIMER_1000_MASK,
+	__phy_modify(phydev, MTK_PHY_LPI_REG_14,
+		     MTK_PHY_LPI_WAKE_TIMER_1000_MASK,
 		     FIELD_PREP(MTK_PHY_LPI_WAKE_TIMER_1000_MASK, 0x19c));
 
 	__phy_modify(phydev, MTK_PHY_LPI_REG_1c, MTK_PHY_SMI_DET_ON_THRESH_MASK,
@@ -986,7 +953,8 @@ static void mt798x_phy_eee(struct phy_device *phydev)
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1,
 		       MTK_PHY_RG_LPI_PCS_DSP_CTRL_REG122,
 		       MTK_PHY_LPI_NORM_MSE_HI_THRESH1000_MASK,
-		       FIELD_PREP(MTK_PHY_LPI_NORM_MSE_HI_THRESH1000_MASK, 0xff));
+		       FIELD_PREP(MTK_PHY_LPI_NORM_MSE_HI_THRESH1000_MASK,
+				  0xff));
 }
 
 static int cal_sw(struct phy_device *phydev, enum CAL_ITEM cal_item,
@@ -1130,57 +1098,13 @@ static int mt798x_phy_config_init(struct phy_device *phydev)
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
@@ -1191,179 +1115,66 @@ static int mt798x_phy_led_blink_set(struct phy_device *phydev, u8 index,
 		*delay_off = 50;
 	}
 
-	err = mt798x_phy_hw_led_blink_set(phydev, index, blinking);
+	err = mtk_phy_hw_led_blink_set(phydev, index, &priv->led_state,
+				       blinking);
 	if (err)
 		return err;
 
-	return mt798x_phy_hw_led_on_set(phydev, index, false);
+	return mtk_phy_hw_led_on_set(phydev, index, &priv->led_state,
+				     MTK_GPHY_LED_ON_MASK, false);
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
 
-static const unsigned long supported_triggers = (BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
-						 BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
-						 BIT(TRIGGER_NETDEV_LINK)        |
-						 BIT(TRIGGER_NETDEV_LINK_10)     |
-						 BIT(TRIGGER_NETDEV_LINK_100)    |
-						 BIT(TRIGGER_NETDEV_LINK_1000)   |
-						 BIT(TRIGGER_NETDEV_RX)          |
-						 BIT(TRIGGER_NETDEV_TX));
+static const unsigned long supported_triggers =
+	(BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
+	 BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
+	 BIT(TRIGGER_NETDEV_LINK)        |
+	 BIT(TRIGGER_NETDEV_LINK_10)     |
+	 BIT(TRIGGER_NETDEV_LINK_100)    |
+	 BIT(TRIGGER_NETDEV_LINK_1000)   |
+	 BIT(TRIGGER_NETDEV_RX)          |
+	 BIT(TRIGGER_NETDEV_TX));
 
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
 
-	if (on < 0)
-		return -EIO;
-
-	blink = phy_read_mmd(phydev, MDIO_MMD_VEND2,
-			     index ? MTK_PHY_LED1_BLINK_CTRL :
-				     MTK_PHY_LED0_BLINK_CTRL);
-	if (blink < 0)
-		return -EIO;
-
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
+				       MTK_GPHY_LED_ON_SET,
+				       MTK_GPHY_LED_RX_BLINK_SET,
+				       MTK_GPHY_LED_TX_BLINK_SET);
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
+				       MTK_GPHY_LED_ON_SET,
+				       MTK_GPHY_LED_RX_BLINK_SET,
+				       MTK_GPHY_LED_TX_BLINK_SET);
 };
 
 static bool mt7988_phy_led_get_polarity(struct phy_device *phydev, int led_num)
@@ -1390,15 +1201,16 @@ static int mt7988_phy_fix_leds_polarities(struct phy_device *phydev)
 	/* Setup LED polarity according to bootstrap use of LED pins */
 	for (index = 0; index < 2; ++index)
 		phy_modify_mmd(phydev, MDIO_MMD_VEND2, index ?
-				MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL,
+			       MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL,
 			       MTK_PHY_LED_ON_POLARITY,
 			       mt7988_phy_led_get_polarity(phydev, index) ?
-				MTK_PHY_LED_ON_POLARITY : 0);
+			       MTK_PHY_LED_ON_POLARITY : 0);
 
 	/* Only now setup pinctrl to avoid bogus blinking */
 	pinctrl = devm_pinctrl_get_select(&phydev->mdio.dev, "gbe-led");
 	if (IS_ERR(pinctrl))
-		dev_err(&phydev->mdio.bus->dev, "Failed to setup PHY LED pinctrl\n");
+		dev_err(&phydev->mdio.bus->dev,
+			"Failed to setup PHY LED pinctrl\n");
 
 	return 0;
 }
@@ -1437,14 +1249,6 @@ static int mt7988_phy_probe_shared(struct phy_device *phydev)
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
@@ -1470,7 +1274,7 @@ static int mt7988_phy_probe(struct phy_device *phydev)
 
 	phydev->priv = priv;
 
-	mt798x_phy_leds_state_init(phydev);
+	mtk_phy_leds_state_init(phydev);
 
 	err = mt7988_phy_fix_leds_polarities(phydev);
 	if (err)
@@ -1497,7 +1301,7 @@ static int mt7981_phy_probe(struct phy_device *phydev)
 
 	phydev->priv = priv;
 
-	mt798x_phy_leds_state_init(phydev);
+	mtk_phy_leds_state_init(phydev);
 
 	return mt798x_phy_calibration(phydev);
 }
@@ -1512,8 +1316,8 @@ static struct phy_driver mtk_socphy_driver[] = {
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
@@ -1529,8 +1333,8 @@ static struct phy_driver mtk_socphy_driver[] = {
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
index 54ea64a..4022f98 100644
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
@@ -65,9 +64,104 @@ static int mt7531_phy_config_init(struct phy_device *phydev)
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
-		PHY_ID_MATCH_EXACT(0x03a29412),
+		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7530),
 		.name		= "MediaTek MT7530 PHY",
 		.config_init	= mt7530_phy_config_init,
 		/* Interrupts are handled by the switch, not the PHY
@@ -77,12 +171,14 @@ static struct phy_driver mtk_gephy_driver[] = {
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
@@ -91,16 +187,21 @@ static struct phy_driver mtk_gephy_driver[] = {
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
index 0000000..d892f94
--- /dev/null
+++ b/drivers/net/phy/mediatek/mtk-phy-lib.c
@@ -0,0 +1,247 @@
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
+			    unsigned long *rules, unsigned long *led_state,
+			    u16 on_set, u16 rx_blink_set, u16 tx_blink_set)
+{
+	unsigned int bit_blink = MTK_PHY_LED_STATE_FORCE_BLINK +
+				 (index ? 16 : 0);
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
+	if ((on & (on_set | MTK_PHY_LED_ON_FDX |
+		   MTK_PHY_LED_ON_HDX | MTK_PHY_LED_ON_LINKDOWN)) ||
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
+int mtk_phy_led_hw_ctrl_set(struct phy_device *phydev, u8 index,
+			    unsigned long rules, unsigned long *led_state,
+			    u16 on_set, u16 rx_blink_set, u16 tx_blink_set)
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
+		set_bit(bit_netdev, led_state);
+	else
+		clear_bit(bit_netdev, led_state);
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
+int mtk_phy_hw_led_on_set(struct phy_device *phydev, u8 index,
+			  unsigned long *led_state, u16 led_on_mask, bool on)
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
+				      MTK_PHY_LED1_ON_CTRL :
+				      MTK_PHY_LED0_ON_CTRL,
+				      led_on_mask,
+				      on ? MTK_PHY_LED_ON_FORCE_ON : 0);
+	else
+		return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_phy_hw_led_on_set);
+
+int mtk_phy_hw_led_blink_set(struct phy_device *phydev, u8 index,
+			     unsigned long *led_state, bool blinking)
+{
+	unsigned int bit_blink = MTK_PHY_LED_STATE_FORCE_BLINK +
+				 (index ? 16 : 0);
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
index 0000000..9cc9577
--- /dev/null
+++ b/drivers/net/phy/mediatek/mtk.h
@@ -0,0 +1,83 @@
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
+int mtk_phy_led_hw_is_supported(struct phy_device *phydev, u8 index,
+				unsigned long rules,
+				unsigned long supported_triggers);
+int mtk_phy_led_hw_ctrl_set(struct phy_device *phydev, u8 index,
+			    unsigned long rules, unsigned long *led_state,
+			    u16 on_set, u16 rx_blink_set, u16 tx_blink_set);
+int mtk_phy_led_hw_ctrl_get(struct phy_device *phydev, u8 index,
+			    unsigned long *rules, unsigned long *led_state,
+			    u16 on_set, u16 rx_blink_set, u16 tx_blink_set);
+int mtk_phy_hw_led_on_set(struct phy_device *phydev, u8 index,
+			  unsigned long *led_state, u16 led_on_mask, bool on);
+int mtk_phy_hw_led_blink_set(struct phy_device *phydev, u8 index,
+			     unsigned long *led_state, bool blinking);
+void mtk_phy_leds_state_init(struct phy_device *phydev);
+
+#endif /* _MTK_EPHY_H_ */
-- 
2.18.0


