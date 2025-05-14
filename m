Return-Path: <netdev+bounces-190377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDB1AB6952
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 12:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20B2866936
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 10:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775F627466E;
	Wed, 14 May 2025 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oZXTwHOi"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3B2272E4B;
	Wed, 14 May 2025 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747220314; cv=none; b=ntPMx04Nw67TzhXj21ya7At5a4TftIVoeAWjCpnb2prID9QwmRO+E2uHPWHXWn+guOQngf9h7JNL933y1nGOp5iVrue3x/9y7FK8QU0sQMxDcJpgwxbFbQhLAbq1RslDjrJ0KlRoboA3C/onxIBnOxmPHmdcdYylf2ElJSdcygM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747220314; c=relaxed/simple;
	bh=oyka0d9y9HhdUOdj9H3BPZec4R4L1bI/K69/w4qNGmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NN+8sgMKwHa1Av3wX+TIDKcApTM0svOHmIy+DRkEMG76d8sB/fi5/HabuRsx3hAHZlJLvxcVil3ey71Gl4GUE70Ea/8PqVr61l1VXZgS0f2yPZnjIs6UglB+hDmQodyMz9WcIJVh2GBjfg7RBHWxZoIn7omqhu1YwU8EaZgfqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oZXTwHOi; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5cbf640a30b211f0813e4fe1310efc19-20250514
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0x6BxHB21xjnTD364E1fr1Ccu8slzOfioOorNVV9gdM=;
	b=oZXTwHOiWxZyRPq4W6F95Ze30RfKGs1ChIF2HrR1fBF7dp6BnWLRVuZjAPNUDtuiWnbq1crXFqZHpWLsnzJ/z5PruG3/He8MO6ApdLNfR2DUvM8O3BlcoLcW5YbQKVr9y9UgFmMOjkQYacaUdj+t2ebJZSjMffP4/I6v5bhMrHo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:8fbf1186-0760-48e0-ae33-b27dfbea6bab,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:2523b897-7410-4084-8094-24619d975b02,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5cbf640a30b211f0813e4fe1310efc19-20250514
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 514516476; Wed, 14 May 2025 18:58:26 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 14 May 2025 18:58:24 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 14 May 2025 18:58:24 +0800
From: Sky Huang <SkyLake.Huang@mediatek.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Golle
	<daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>, SkyLake Huang
	<SkyLake.Huang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	balika011 <balika011@gmail.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
CC: Steven Liu <Steven.Liu@mediatek.com>, Sky Huang
	<skylake.huang@mediatek.com>
Subject: [PATCH net-next v3 2/2] net: phy: mediatek: add driver for built-in 2.5G ethernet PHY on MT7988
Date: Wed, 14 May 2025 18:57:38 +0800
Message-ID: <20250514105738.1438421-3-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250514105738.1438421-1-SkyLake.Huang@mediatek.com>
References: <20250514105738.1438421-1-SkyLake.Huang@mediatek.com>
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

Add support for internal 2.5Gphy on MT7988. This driver will load
necessary firmware and add appropriate time delay to make sure
that firmware works stably. The firmware loading procedure takes
about 11ms in this driver.

Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
---
 MAINTAINERS                          |   1 +
 drivers/net/phy/mediatek/Kconfig     |  11 +
 drivers/net/phy/mediatek/Makefile    |   1 +
 drivers/net/phy/mediatek/mtk-2p5ge.c | 322 +++++++++++++++++++++++++++
 4 files changed, 335 insertions(+)
 create mode 100644 drivers/net/phy/mediatek/mtk-2p5ge.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 800d23264c94..5541126b4a4c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15035,6 +15035,7 @@ M:	Qingfang Deng <dqfext@gmail.com>
 M:	SkyLake Huang <SkyLake.Huang@mediatek.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	drivers/net/phy/mediatek/mtk-2p5ge.c
 F:	drivers/net/phy/mediatek/mtk-ge-soc.c
 F:	drivers/net/phy/mediatek/mtk-phy-lib.c
 F:	drivers/net/phy/mediatek/mtk-ge.c
diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
index 3abf23e37b4b..e440caf3bd04 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -1,4 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0-only
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
+
 config MEDIATEK_GE_SOC_PHY
 	tristate "MediaTek SoC Ethernet PHYs"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/net/phy/mediatek/Makefile b/drivers/net/phy/mediatek/Makefile
index ff13205d614f..f3c534889b30 100644
--- a/drivers/net/phy/mediatek/Makefile
+++ b/drivers/net/phy/mediatek/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_MEDIATEK_2P5GE_PHY)	+= mtk-2p5ge.o
 obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)	+= mtk-ge-soc.o
 obj-$(CONFIG_MTK_NET_PHYLIB)		+= mtk-phy-lib.o
 obj-$(CONFIG_MEDIATEK_GE_PHY)		+= mtk-ge.o
diff --git a/drivers/net/phy/mediatek/mtk-2p5ge.c b/drivers/net/phy/mediatek/mtk-2p5ge.c
new file mode 100644
index 000000000000..2386360dd77e
--- /dev/null
+++ b/drivers/net/phy/mediatek/mtk-2p5ge.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <linux/bitfield.h>
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/phy.h>
+
+#include "mtk.h"
+
+#define MTK_2P5GPHY_ID_MT7988		(0x00339c11)
+
+#define MT7988_2P5GE_PMB_FW		"mediatek/mt7988/i2p5ge-phy-pmb.bin"
+#define MT7988_2P5GE_PMB_FW_SIZE	(0x20000)
+#define MT7988_2P5GE_PMB_FW_BASE	(0x0f100000)
+#define MT7988_2P5GE_PMB_FW_LEN		(0x20000)
+#define MTK_2P5GPHY_MCU_CSR_BASE	(0x0f0f0000)
+#define MTK_2P5GPHY_MCU_CSR_LEN		(0x20)
+#define MD32_EN_CFG			(0x18)
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
+/* Registers on MDIO_MMD_VEND1 */
+#define MTK_PHY_LPI_PCS_DSP_CTRL		(0x121)
+#define   MTK_PHY_LPI_SIG_EN_LO_THRESH100_MASK	GENMASK(12, 8)
+
+#define MTK_PHY_HOST_CMD1		0x800e
+#define MTK_PHY_HOST_CMD2		0x800f
+/* Registers on Token Ring debug nodes */
+/* ch_addr = 0x0, node_addr = 0xf, data_addr = 0x3c */
+#define AUTO_NP_10XEN				BIT(6)
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
+	void __iomem *mcu_csr_base, *pmb_addr;
+	struct device *dev = &phydev->mdio.dev;
+	const struct firmware *fw;
+	int ret, i;
+	u32 reg;
+
+	pmb_addr = ioremap(MT7988_2P5GE_PMB_FW_BASE, MT7988_2P5GE_PMB_FW_LEN);
+	if (!pmb_addr)
+		return -ENOMEM;
+	mcu_csr_base = ioremap(MTK_2P5GPHY_MCU_CSR_BASE,
+			       MTK_2P5GPHY_MCU_CSR_LEN);
+	if (!mcu_csr_base) {
+		ret = -ENOMEM;
+		goto free_pmb;
+	}
+
+	ret = request_firmware_direct(&fw, MT7988_2P5GE_PMB_FW, dev);
+	if (ret) {
+		dev_err(dev, "failed to load firmware: %s, ret: %d\n",
+			MT7988_2P5GE_PMB_FW, ret);
+		goto free;
+	}
+
+	if (fw->size != MT7988_2P5GE_PMB_FW_SIZE) {
+		dev_err(dev, "Firmware size 0x%zx != 0x%x\n",
+			fw->size, MT7988_2P5GE_PMB_FW_SIZE);
+		ret = -EINVAL;
+		goto release_fw;
+	}
+
+	reg = readw(mcu_csr_base + MD32_EN_CFG);
+	if (reg & MD32_EN) {
+		phy_set_bits(phydev, MII_BMCR, BMCR_RESET);
+		usleep_range(10000, 11000);
+	}
+	phy_set_bits(phydev, MII_BMCR, BMCR_PDOWN);
+
+	/* Write magic number to safely stall MCU */
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_HOST_CMD1, 0x1100);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_HOST_CMD2, 0x00df);
+
+	for (i = 0; i < MT7988_2P5GE_PMB_FW_SIZE - 1; i += 4)
+		writel(*((uint32_t *)(fw->data + i)), pmb_addr + i);
+
+	writew(reg & ~MD32_EN, mcu_csr_base + MD32_EN_CFG);
+	writew(reg | MD32_EN, mcu_csr_base + MD32_EN_CFG);
+	phy_set_bits(phydev, MII_BMCR, BMCR_RESET);
+	/* We need a delay here to stabilize initialization of MCU */
+	usleep_range(7000, 8000);
+
+	dev_info(dev, "Firmware date code: %x/%x/%x, version: %x.%x\n",
+		 be16_to_cpu(*((__be16 *)(fw->data +
+					  MT7988_2P5GE_PMB_FW_SIZE - 8))),
+		 *(fw->data + MT7988_2P5GE_PMB_FW_SIZE - 6),
+		 *(fw->data + MT7988_2P5GE_PMB_FW_SIZE - 5),
+		 *(fw->data + MT7988_2P5GE_PMB_FW_SIZE - 2),
+		 *(fw->data + MT7988_2P5GE_PMB_FW_SIZE - 1));
+
+release_fw:
+	release_firmware(fw);
+free:
+	iounmap(mcu_csr_base);
+free_pmb:
+	iounmap(pmb_addr);
+
+	return ret;
+}
+
+static int mt798x_2p5ge_phy_config_init(struct phy_device *phydev)
+{
+	struct pinctrl *pinctrl;
+
+	/* Check if PHY interface type is compatible */
+	if (phydev->interface != PHY_INTERFACE_MODE_INTERNAL)
+		return -ENODEV;
+
+	/* Setup LED */
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED0_ON_CTRL,
+			 MTK_PHY_LED_ON_POLARITY | MTK_PHY_LED_ON_LINK10 |
+			 MTK_PHY_LED_ON_LINK100 | MTK_PHY_LED_ON_LINK1000 |
+			 MTK_PHY_LED_ON_LINK2500);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED1_ON_CTRL,
+			 MTK_PHY_LED_ON_FDX | MTK_PHY_LED_ON_HDX);
+
+	/* Switch pinctrl after setting polarity to avoid bogus blinking */
+	pinctrl = devm_pinctrl_get_select(&phydev->mdio.dev, "i2p5gbe-led");
+	if (IS_ERR(pinctrl))
+		dev_err(&phydev->mdio.dev, "Fail to set LED pins!\n");
+
+	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_LPI_PCS_DSP_CTRL,
+		       MTK_PHY_LPI_SIG_EN_LO_THRESH100_MASK, 0);
+
+	/* Enable 16-bit next page exchange bit if 1000-BT isn't advertising */
+	mtk_tr_modify(phydev, 0x0, 0xf, 0x3c, AUTO_NP_10XEN,
+		      FIELD_PREP(AUTO_NP_10XEN, 0x1));
+
+	/* Enable HW auto downshift */
+	phy_modify_paged(phydev, MTK_PHY_PAGE_EXTENDED_1,
+			 MTK_PHY_AUX_CTRL_AND_STATUS,
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
+	ret = genphy_c45_an_config_aneg(phydev);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	/* Clause 45 doesn't define 1000BaseT support. Use Clause 22 instead in
+	 * our design.
+	 */
+	adv = linkmode_adv_to_mii_ctrl1000_t(phydev->advertising);
+	ret = phy_modify_changed(phydev, MII_CTRL1000, ADVERTISE_1000FULL, adv);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	return __genphy_config_aneg(phydev, changed);
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
+	/* This phy can't handle collision, and neither can (XFI)MAC it's
+	 * connected to. Although it can do HDX handshake, it doesn't support
+	 * CSMA/CD that HDX requires.
+	 */
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
+			   phydev->supported);
+
+	return 0;
+}
+
+static int mt798x_2p5ge_phy_read_status(struct phy_device *phydev)
+{
+	int ret;
+
+	/* When MDIO_STAT1_LSTATUS is raised genphy_c45_read_link(), this phy
+	 * actually hasn't finished AN. So use CL22's link update function
+	 * instead.
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
+	/* We'll read link speed through vendor specific registers down below.
+	 * So remove phy_resolve_aneg_linkmode (AN on) & genphy_c45_read_pma
+	 * (AN off).
+	 */
+	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete) {
+		ret = genphy_c45_read_lpa(phydev);
+		if (ret < 0)
+			return ret;
+
+		/* Clause 45 doesn't define 1000BaseT support. Read the link
+		 * partner's 1G advertisement via Clause 22.
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
+		phydev->rate_matching = RATE_MATCH_PAUSE;
+	}
+
+	return 0;
+}
+
+static int mt798x_2p5ge_phy_get_rate_matching(struct phy_device *phydev,
+					      phy_interface_t iface)
+{
+	return RATE_MATCH_PAUSE;
+}
+
+static int mt798x_2p5ge_phy_probe(struct phy_device *phydev)
+{
+	int ret;
+
+	switch (phydev->drv->phy_id) {
+	case MTK_2P5GPHY_ID_MT7988:
+		/* This built-in 2.5GbE hardware only sets MDIO_DEVS_PMAPMD.
+		 * Set the rest by this driver since PCS/AN/VEND1/VEND2 MDIO
+		 * manageable devices actually exist.
+		 */
+		phydev->c45_ids.mmds_present |= MDIO_DEVS_PCS |
+						MDIO_DEVS_AN |
+						MDIO_DEVS_VEND1 |
+						MDIO_DEVS_VEND2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = mt798x_2p5ge_phy_load_fw(phydev);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct phy_driver mtk_2p5gephy_driver[] = {
+	{
+		PHY_ID_MATCH_MODEL(MTK_2P5GPHY_ID_MT7988),
+		.name = "MediaTek MT7988 2.5GbE PHY",
+		.probe = mt798x_2p5ge_phy_probe,
+		.config_init = mt798x_2p5ge_phy_config_init,
+		.config_aneg = mt798x_2p5ge_phy_config_aneg,
+		.get_features = mt798x_2p5ge_phy_get_features,
+		.read_status = mt798x_2p5ge_phy_read_status,
+		.get_rate_matching = mt798x_2p5ge_phy_get_rate_matching,
+		.suspend = genphy_suspend,
+		.resume = genphy_resume,
+		.read_page = mtk_phy_read_page,
+		.write_page = mtk_phy_write_page,
+	},
+};
+
+module_phy_driver(mtk_2p5gephy_driver);
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
+MODULE_FIRMWARE(MT7988_2P5GE_PMB_FW);
-- 
2.45.2


