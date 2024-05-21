Return-Path: <netdev+bounces-97322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA438CAC20
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 12:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F2F1F22B95
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 10:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F707CF34;
	Tue, 21 May 2024 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nBr9ebk4"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFB27E0E9;
	Tue, 21 May 2024 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716286714; cv=none; b=NXXtXb/I74zduJ2lzEakxbqhEXZoVcddIDgW0aK3wZ/JicJsyDwU/MfxLmMwpoe45aTIOSxQeoddMHB3A7MFmp6TSwF9x9sXWFXjtjxipEOo5UGQWih3Ws3/usTj3z69GPlVFo6TLJvVFeINt4UXUYj89iWbQzEKjNLQL95s+zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716286714; c=relaxed/simple;
	bh=6tl+SS6FQqBJZDAlu+LbRz7V1Vuh28UmLq7/US5X5wE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcYMQE63qUWIi71P5cixH9yBzjzCw8YG1zAfbYnKfcy8yX5SUdnIcH5gUBRSuSimIlHkMqHZgzjAuIOGRTm4WwkpMHaUCz7hPHVGZFIX2wUzXSkpmbOnOXhUpomZLgvH0cJcI/mpbOQGoLzVUsWHp2qK4XBuJf3KAEBY7EP3cHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nBr9ebk4; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 757ddc9a175b11ef8065b7b53f7091ad-20240521
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9LxrSWQBPNtPfpI2SZ4WJeeha/an6fi9IziKplQHQRg=;
	b=nBr9ebk48e0tfmY/AR3ju8FPwG2SAzkRR4E9ZBrpdtUnnMcWmrDcbG6S7TqGHjCjLxn6zi8F4c4bLkptnu/zSH7RxyVeuEEVN5CjzOTxqrdvgN72jyOoB6d3lEywZFTLVqL5FZSjH70Ei6JHHCLNXPyRbfb4Boig8TJbsYcBsCM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:8dce8502-c915-4904-b483-79b16d08c361,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:82c5f88,CLOUDID:a0580793-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 757ddc9a175b11ef8065b7b53f7091ad-20240521
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 197345987; Tue, 21 May 2024 18:18:25 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 21 May 2024 18:18:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 21 May 2024 18:18:23 +0800
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
Subject: [PATCH net-next v4 5/5] net: phy: add driver for built-in 2.5G ethernet PHY on MT7988
Date: Tue, 21 May 2024 18:15:48 +0800
Message-ID: <20240521101548.9286-6-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240521101548.9286-1-SkyLake.Huang@mediatek.com>
References: <20240521101548.9286-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.488600-8.000000
X-TMASE-MatchedRID: BGB2r+YpBmuGeTbGWdRz1m3NvezwBrVmvtVce6w5+K8GW3hFnC9N1QCF
	m7CJDqde/F3GvEulhkFimbpww+i10jkdZrWTFzcx3akpBNcZ4UpQCOsAlaxN73zlhuYw8JsTdn5
	HTOCw5bgJr8h8eMM5/Z1jVGs/MT9S+8OrsOaamJ4OSj4RiINDEe+aBTJJYa54NSweOixQAJKZAn
	qxTGmm4gUY+Xt/b/3hGhVcO7HTLn8Z7tZ8rsD8M/VFR4sC8dPy54m13cMa9kdXPwnnY5XL5AaTa
	lM8C773wvUxdKBGcQz8EpYJMjL6LtvJAvCq+wLJDB+ErBr0bAOCxYB2hPS4vVa2o9UdV1eY2o/f
	8Umlfm+cp7nVX85L2pf6UHa+TFUhKc+6Aaw3ennKl4yJoI+fG2jdirk8LAsCRQ0dAChl/lyekqO
	yWjrAzn+2A2Sl/cOkM5B1AlKAOJ/ail2IXnksPo7Su3QulAZ5gsuHb8lxzt4cVJCT3tVgaiNsQN
	PysI4KktQIwDCRmc3wIQ8TEKBvAEVKjl1H9wR9ttAWxuM5sl5K0YCCYqpa5ZXin596GXnGtuQcp
	SN3DCQ58CIn96icLVRPuZuxZlp70X+0CFhNLNdNdiLNHxibl1PgO2JKQydYdEZOcW9j55YvDt41
	DffF/8zWSNF31A57uewO5rBHdH4fE8yM4pjsDwtuKBGekqUpbGVEmIfjf3sz+9u9f4o0a/Msciv
	Xpg2XcvIzjTT76oBVWrVsGQc5N5F67kArCOJV
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.488600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	93AD0279D92604EB15DF74A10FA2574A397A62429F859A2A0A99776E2F4204B52000:8
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

v1:
Add support for internal 2.5Gphy on MT7988. This driver will load
necessary firmware, add appropriate time delay and figure out LED.
Also, certain control registers will be set to fix link-up issues.

v2:
1. Move md32_en_cfg_base & pmb_addr detection in probe function.
2. Do not read PMB & MD32_EN_CFG base addresses from dts. We won't
change that from board to board. Leave them in driver code. Also,
release those addresses after firmware is triggered.
3. Remove half duplex code which leads to ambiguity. Those are for
testing & developing previously.
4. Use correct BMCR definitions.
5. Correct config_aneg / get_features / read_status functions.
6. Change mt7988_2p5ge prefix to mt798x_2p5ge in case that our next
platform uses this 2.5Gphy driver.

v3:
1. Add range check for firmware.
2. Fix c45_ids.mmds_present in probe function.
3. Still use genphy_update_link() in read_status because
genphy_c45_read_link() can't correct detect link on this phy.

v4:
1. Move firmware loading function to mt798x_2p5ge_phy_load_fw()
2. Add AN disable warning in mt798x_2p5ge_phy_config_aneg()
3. Clarify the HDX comments in mt798x_2p5ge_phy_get_features()

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
 MAINTAINERS                          |   1 +
 drivers/net/phy/mediatek/Kconfig     |  11 +
 drivers/net/phy/mediatek/Makefile    |   1 +
 drivers/net/phy/mediatek/mtk-2p5ge.c | 419 +++++++++++++++++++++++++++
 4 files changed, 432 insertions(+)
 create mode 100644 drivers/net/phy/mediatek/mtk-2p5ge.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b903235..3cfb7d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13793,6 +13793,7 @@ M:	Qingfang Deng <dqfext@gmail.com>
 M:	SkyLake Huang <SkyLake.Huang@mediatek.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	drivers/net/phy/mediatek/mtk-2p5ge.c
 F:	drivers/net/phy/mediatek/mtk-ge-soc.c
 F:	drivers/net/phy/mediatek/mtk-phy-lib.c
 F:	drivers/net/phy/mediatek/mtk-ge.c
diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
index b11b195..88ca881 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -25,3 +25,14 @@ config MEDIATEK_GE_SOC_PHY
 	  the MT7981 and MT7988 SoCs. These PHYs need calibration data
 	  present in the SoCs efuse and will dynamically calibrate VCM
 	  (common-mode voltage) during startup.
+
+config MEDIATEK_2P5GE_PHY
+	tristate "MediaTek 2.5Gb Ethernet PHYs"
+	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
+	select MTK_NET_PHYLIB
+	help
+	  Supports MediaTek SoC built-in 2.5Gb Ethernet PHYs.
+
+	  This will load necessary firmware and add appropriate time delay.
+	  Accelerate this procedure through internal pbus instead of MDIO
+	  bus. Certain link-up issues will also be fixed here.
diff --git a/drivers/net/phy/mediatek/Makefile b/drivers/net/phy/mediatek/Makefile
index 814879d..c6db8ab 100644
--- a/drivers/net/phy/mediatek/Makefile
+++ b/drivers/net/phy/mediatek/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_MTK_NET_PHYLIB)		+= mtk-phy-lib.o
 obj-$(CONFIG_MEDIATEK_GE_PHY)		+= mtk-ge.o
 obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)	+= mtk-ge-soc.o
+obj-$(CONFIG_MEDIATEK_2P5GE_PHY)	+= mtk-2p5ge.o
diff --git a/drivers/net/phy/mediatek/mtk-2p5ge.c b/drivers/net/phy/mediatek/mtk-2p5ge.c
new file mode 100644
index 0000000..b2c4234
--- /dev/null
+++ b/drivers/net/phy/mediatek/mtk-2p5ge.c
@@ -0,0 +1,419 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <linux/bitfield.h>
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/phy.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+
+#include "mtk.h"
+
+#define MTK_2P5GPHY_ID_MT7988	(0x00339c11)
+
+#define MT7988_2P5GE_PMB "mediatek/mt7988/i2p5ge-phy-pmb.bin"
+#define MT7988_2P5GE_PMB_SIZE	(0x20000)
+#define MT7988_2P5GE_PMB_BASE	(0x0f100000)
+#define MT7988_2P5GE_PMB_LEN	(0x20000)
+#define MT7988_2P5GE_MD32_EN_CFG_BASE	(0x0f0f0018)
+#define MT7988_2P5GE_MD32_EN_CFG_LEN	(0x20)
+#define   MD32_EN			BIT(0)
+
+#define BASE100T_STATUS_EXTEND		(0x10)
+#define BASE1000T_STATUS_EXTEND		(0x11)
+#define EXTEND_CTRL_AND_STATUS		(0x16)
+
+#define PHY_AUX_CTRL_STATUS		(0x1d)
+#define   PHY_AUX_DPX_MASK		GENMASK(5, 5)
+#define   PHY_AUX_SPEED_MASK		GENMASK(4, 2)
+
+#define MTK_PHY_LPI_PCS_DSP_CTRL		(0x121)
+#define   MTK_PHY_LPI_SIG_EN_LO_THRESH100_MASK	GENMASK(12, 8)
+
+/* Registers on MTK phy page 1*/
+#define MTK_PHY_PAGE_EXTENDED_1			0x0001
+#define MTK_PHY_AUX_CTRL_AND_STATUS		(0x14)
+#define   MTK_PHY_ENABLE_DOWNSHIFT		BIT(4)
+
+/* Registers on Token Ring debug nodes */
+/* ch_addr = 0x0, node_addr = 0xf, data_addr = 0x3c */
+#define AUTO_NP_10XEN				BIT(6)
+
+struct mtk_i2p5ge_phy_priv {
+	bool fw_loaded;
+	void __iomem *pmb_addr;
+	void __iomem *md32_en_cfg_base;
+	unsigned long led_state;
+};
+
+enum {
+	PHY_AUX_SPD_10 = 0,
+	PHY_AUX_SPD_100,
+	PHY_AUX_SPD_1000,
+	PHY_AUX_SPD_2500,
+};
+
+static int mt798x_2p5ge_phy_load_fw(struct phy_device *phydev)
+{
+	struct mtk_i2p5ge_phy_priv *priv = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+	const struct firmware *fw;
+	int ret, i;
+	u16 reg;
+
+	if (priv->fw_loaded)
+		return 0;
+
+	if (!priv->md32_en_cfg_base || !priv->pmb_addr) {
+		dev_err(dev, "MD32_EN_CFG base & PMB addresses aren't valid\n");
+		return -EINVAL;
+	}
+
+	ret = request_firmware(&fw, MT7988_2P5GE_PMB, dev);
+	if (ret) {
+		dev_err(dev, "failed to load firmware: %s, ret: %d\n",
+			MT7988_2P5GE_PMB, ret);
+		return ret;
+	}
+
+	if (fw->size != MT7988_2P5GE_PMB_SIZE) {
+		dev_err(dev, "Firmware size 0x%zx != 0x%x\n",
+			fw->size, MT7988_2P5GE_PMB_SIZE);
+		return -EINVAL;
+	}
+
+	reg = readw(priv->md32_en_cfg_base);
+	if (reg & MD32_EN) {
+		phy_set_bits(phydev, MII_BMCR, BMCR_RESET);
+		usleep_range(10000, 11000);
+	}
+	phy_set_bits(phydev, MII_BMCR, BMCR_PDOWN);
+
+	/* Write magic number to safely stall MCU */
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x800e, 0x1100);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x800f, 0x00df);
+
+	for (i = 0; i < MT7988_2P5GE_PMB_SIZE - 1; i += 4)
+		writel(*((uint32_t *)(fw->data + i)), priv->pmb_addr + i);
+	release_firmware(fw);
+
+	writew(reg & ~MD32_EN, priv->md32_en_cfg_base);
+	writew(reg | MD32_EN, priv->md32_en_cfg_base);
+	phy_set_bits(phydev, MII_BMCR, BMCR_RESET);
+	/* We need a delay here to stabilize initialization of MCU */
+	usleep_range(7000, 8000);
+	dev_info(dev, "Firmware loading/trigger ok.\n");
+
+	priv->fw_loaded = true;
+	iounmap(priv->md32_en_cfg_base);
+	iounmap(priv->pmb_addr);
+
+	return 0;
+}
+
+static int mt798x_2p5ge_phy_config_init(struct phy_device *phydev)
+{
+	struct pinctrl *pinctrl;
+	int ret;
+
+	ret = mt798x_2p5ge_phy_load_fw(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* Setup LED */
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED0_ON_CTRL,
+			 MTK_PHY_LED_ON_POLARITY | MTK_PHY_LED_ON_LINK10 |
+			 MTK_PHY_LED_ON_LINK100 | MTK_PHY_LED_ON_LINK1000 |
+			 MTK_PHY_LED_ON_LINK2500);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED1_ON_CTRL,
+			 MTK_PHY_LED_ON_FDX | MTK_PHY_LED_ON_HDX);
+
+	pinctrl = devm_pinctrl_get_select(&phydev->mdio.dev, "i2p5gbe-led");
+	if (IS_ERR(pinctrl)) {
+		dev_err(&phydev->mdio.dev, "Fail to set LED pins!\n");
+		return PTR_ERR(pinctrl);
+	}
+
+	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_LPI_PCS_DSP_CTRL,
+		       MTK_PHY_LPI_SIG_EN_LO_THRESH100_MASK, 0);
+
+	/* Enable 16-bit next page exchange bit if 1000-BT isn't advertizing */
+	tr_modify(phydev, 0x0, 0xf, 0x3c, AUTO_NP_10XEN,
+		  FIELD_PREP(AUTO_NP_10XEN, 0x1));
+
+	/* Enable HW auto downshift */
+	phy_modify_paged(phydev, MTK_PHY_PAGE_EXTENDED_1, MTK_PHY_AUX_CTRL_AND_STATUS,
+			 0, MTK_PHY_ENABLE_DOWNSHIFT);
+
+	return 0;
+}
+
+static int mt798x_2p5ge_phy_config_aneg(struct phy_device *phydev)
+{
+	bool changed = false;
+	u32 adv;
+	int ret;
+
+	if (phydev->autoneg == AUTONEG_DISABLE) {
+		/* In fact, if we disable antuneg, we can't link up correctly:
+		 *  2.5G/1G: Need AN to exchange master/slave information.
+		 *  100M: Without AN, link starts at half duplex, which this phy doesn't support.
+		 *  10M: Deprecated in this ethernet phy.
+		 */
+		dev_warn(&phydev->mdio.dev, "Once AN off is set, this phy can't link.\n");
+		return genphy_c45_pma_setup_forced(phydev);
+	}
+
+	ret = genphy_c45_an_config_aneg(phydev);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	/* Clause 45 doesn't define 1000BaseT support. Use Clause 22 instead in our design.
+	 */
+	adv = linkmode_adv_to_mii_ctrl1000_t(phydev->advertising);
+	ret = phy_modify_changed(phydev, MII_CTRL1000, ADVERTISE_1000FULL, adv);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	return genphy_c45_check_and_restart_aneg(phydev, changed);
+}
+
+static int mt798x_2p5ge_phy_get_features(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_c45_pma_read_abilities(phydev);
+	if (ret)
+		return ret;
+
+	/* This phy can't handle collision, and neither can (XFI)MAC it's connected to.
+	 * Although it can do HDX handshake, it doesn't support CSMA/CD that HDX requires.
+	 */
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, phydev->supported);
+
+	return 0;
+}
+
+static int mt798x_2p5ge_phy_read_status(struct phy_device *phydev)
+{
+	int ret;
+
+	/* When MDIO_STAT1_LSTATUS is raised genphy_c45_read_link(), this phy actually
+	 * hasn't finished AN. So use CL22's link update function instead.
+	 */
+	ret = genphy_update_link(phydev);
+	if (ret)
+		return ret;
+
+	phydev->speed = SPEED_UNKNOWN;
+	phydev->duplex = DUPLEX_UNKNOWN;
+	phydev->pause = 0;
+	phydev->asym_pause = 0;
+
+	/* We'll read link speed through vendor specific registers down below. So remove
+	 * phy_resolve_aneg_linkmode (AN on) & genphy_c45_read_pma (AN off).
+	 */
+	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete) {
+		ret = genphy_c45_read_lpa(phydev);
+		if (ret < 0)
+			return ret;
+
+		/* Clause 45 doesn't define 1000BaseT support. Read the link partner's 1G
+		 * advertisement via Clause 22
+		 */
+		ret = phy_read(phydev, MII_STAT1000);
+		if (ret < 0)
+			return ret;
+		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, ret);
+	} else if (phydev->autoneg == AUTONEG_DISABLE) {
+		linkmode_zero(phydev->lp_advertising);
+	}
+
+	if (phydev->link) {
+		ret = phy_read(phydev, PHY_AUX_CTRL_STATUS);
+		if (ret < 0)
+			return ret;
+
+		switch (FIELD_GET(PHY_AUX_SPEED_MASK, ret)) {
+		case PHY_AUX_SPD_10:
+			phydev->speed = SPEED_10;
+			break;
+		case PHY_AUX_SPD_100:
+			phydev->speed = SPEED_100;
+			break;
+		case PHY_AUX_SPD_1000:
+			phydev->speed = SPEED_1000;
+			break;
+		case PHY_AUX_SPD_2500:
+			phydev->speed = SPEED_2500;
+			break;
+		}
+
+		phydev->duplex = DUPLEX_FULL;
+		/* FIXME: The current firmware always enables rate adaptation mode. */
+		phydev->rate_matching = RATE_MATCH_PAUSE;
+	}
+
+	return 0;
+}
+
+static int mt798x_2p5ge_phy_get_rate_matching(struct phy_device *phydev,
+					      phy_interface_t iface)
+{
+	if (iface == PHY_INTERFACE_MODE_XGMII)
+		return RATE_MATCH_PAUSE;
+	return RATE_MATCH_NONE;
+}
+
+static const unsigned long supported_triggers = (BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
+						 BIT(TRIGGER_NETDEV_LINK)        |
+						 BIT(TRIGGER_NETDEV_LINK_10)     |
+						 BIT(TRIGGER_NETDEV_LINK_100)    |
+						 BIT(TRIGGER_NETDEV_LINK_1000)   |
+						 BIT(TRIGGER_NETDEV_LINK_2500)   |
+						 BIT(TRIGGER_NETDEV_RX)          |
+						 BIT(TRIGGER_NETDEV_TX));
+
+static int mt798x_2p5ge_phy_led_blink_set(struct phy_device *phydev, u8 index,
+					  unsigned long *delay_on,
+					  unsigned long *delay_off)
+{
+	bool blinking = false;
+	int err = 0;
+	struct mtk_i2p5ge_phy_priv *priv = phydev->priv;
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
+	return mtk_phy_hw_led_on_set(phydev, index, &priv->led_state,
+				     MTK_2P5GPHY_LED_ON_MASK, false);
+}
+
+static int mt798x_2p5ge_phy_led_brightness_set(struct phy_device *phydev,
+					       u8 index, enum led_brightness value)
+{
+	int err;
+	struct mtk_i2p5ge_phy_priv *priv = phydev->priv;
+
+	err = mtk_phy_hw_led_blink_set(phydev, index, &priv->led_state, false);
+	if (err)
+		return err;
+
+	return mtk_phy_hw_led_on_set(phydev, index, &priv->led_state,
+				     MTK_2P5GPHY_LED_ON_MASK, (value != LED_OFF));
+}
+
+static int mt798x_2p5ge_phy_led_hw_is_supported(struct phy_device *phydev, u8 index,
+						unsigned long rules)
+{
+	return mtk_phy_led_hw_is_supported(phydev, index, rules, supported_triggers);
+}
+
+static int mt798x_2p5ge_phy_led_hw_control_get(struct phy_device *phydev, u8 index,
+					       unsigned long *rules)
+{
+	struct mtk_i2p5ge_phy_priv *priv = phydev->priv;
+
+	return mtk_phy_led_hw_ctrl_get(phydev, index, rules, &priv->led_state,
+				       MTK_2P5GPHY_LED_ON_SET,
+				       MTK_2P5GPHY_LED_RX_BLINK_SET,
+				       MTK_2P5GPHY_LED_TX_BLINK_SET);
+};
+
+static int mt798x_2p5ge_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
+					       unsigned long rules)
+{
+	struct mtk_i2p5ge_phy_priv *priv = phydev->priv;
+
+	return mtk_phy_led_hw_ctrl_set(phydev, index, rules, &priv->led_state,
+				       MTK_2P5GPHY_LED_ON_SET,
+				       MTK_2P5GPHY_LED_RX_BLINK_SET,
+				       MTK_2P5GPHY_LED_TX_BLINK_SET);
+};
+
+static int mt798x_2p5ge_phy_probe(struct phy_device *phydev)
+{
+	struct mtk_i2p5ge_phy_priv *priv;
+
+	priv = devm_kzalloc(&phydev->mdio.dev,
+			    sizeof(struct mtk_i2p5ge_phy_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	switch (phydev->drv->phy_id) {
+	case MTK_2P5GPHY_ID_MT7988:
+		priv->pmb_addr = ioremap(MT7988_2P5GE_PMB_BASE, MT7988_2P5GE_PMB_LEN);
+		if (!priv->pmb_addr)
+			return -ENOMEM;
+		priv->md32_en_cfg_base = ioremap(MT7988_2P5GE_MD32_EN_CFG_BASE,
+						 MT7988_2P5GE_MD32_EN_CFG_LEN);
+		if (!priv->md32_en_cfg_base)
+			return -ENOMEM;
+
+		/* The original hardware only sets MDIO_DEVS_PMAPMD */
+		phydev->c45_ids.mmds_present |= (MDIO_DEVS_PCS | MDIO_DEVS_AN |
+						 MDIO_DEVS_VEND1 | MDIO_DEVS_VEND2);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	priv->fw_loaded = false;
+	phydev->priv = priv;
+
+	mtk_phy_leds_state_init(phydev);
+
+	return 0;
+}
+
+static struct phy_driver mtk_gephy_driver[] = {
+	{
+		PHY_ID_MATCH_MODEL(MTK_2P5GPHY_ID_MT7988),
+		.name		= "MediaTek MT798x 2.5GbE PHY",
+		.probe		= mt798x_2p5ge_phy_probe,
+		.config_init	= mt798x_2p5ge_phy_config_init,
+		.config_aneg    = mt798x_2p5ge_phy_config_aneg,
+		.get_features	= mt798x_2p5ge_phy_get_features,
+		.read_status	= mt798x_2p5ge_phy_read_status,
+		.get_rate_matching	= mt798x_2p5ge_phy_get_rate_matching,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+		.read_page	= mtk_phy_read_page,
+		.write_page	= mtk_phy_write_page,
+		.led_blink_set	= mt798x_2p5ge_phy_led_blink_set,
+		.led_brightness_set = mt798x_2p5ge_phy_led_brightness_set,
+		.led_hw_is_supported = mt798x_2p5ge_phy_led_hw_is_supported,
+		.led_hw_control_get = mt798x_2p5ge_phy_led_hw_control_get,
+		.led_hw_control_set = mt798x_2p5ge_phy_led_hw_control_set,
+	},
+};
+
+module_phy_driver(mtk_gephy_driver);
+
+static struct mdio_device_id __maybe_unused mtk_2p5ge_phy_tbl[] = {
+	{ PHY_ID_MATCH_VENDOR(0x00339c00) },
+	{ }
+};
+
+MODULE_DESCRIPTION("MediaTek 2.5Gb Ethernet PHY driver");
+MODULE_AUTHOR("SkyLake Huang <SkyLake.Huang@mediatek.com>");
+MODULE_LICENSE("GPL");
+
+MODULE_DEVICE_TABLE(mdio, mtk_2p5ge_phy_tbl);
-- 
2.18.0


