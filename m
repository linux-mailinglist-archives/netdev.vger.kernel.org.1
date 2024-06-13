Return-Path: <netdev+bounces-103173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DC9906A41
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9283E1F21C4C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 10:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3042514262B;
	Thu, 13 Jun 2024 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GmdpTa3o"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E0F1420A6;
	Thu, 13 Jun 2024 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718275456; cv=none; b=LKEbrpNQoGp/1jyrt+f+xYzPvFLiZGvWPhR8hnwzCr8AV/5mSAmOZf2aGOkd8yfr/6+qUFXDxuxhKGIGpn8mA2CWwwluIJLaW0mhrL27fPBaYioF6VgKCYPjmcs3LZU4oW/2Piq2ayHeq2NltnwO8HxQaSuyl2p+4b2FJGR3b4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718275456; c=relaxed/simple;
	bh=84iEcZ52tQUukF3rDn2UTCLaiXoTfLD9xPTzFUW2YkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5hxqAWgnmrZSFOvo0uzwUpXAbBBYggQ4/UZwvFOLSf/+vgPCnYRj21ilfkS/ALwA06hKu27Tq0XHNQUHhMLYar+EhXHU/FmXoS7S/TohPKvJCpkw+vTi813n08U3/QypmUC8RTsV4G90j2mXr4WyGPgJU2+OlMqWgjnVlVCcG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GmdpTa3o; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ddd26aa4297111efa54bbfbb386b949c-20240613
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CWEuK378UoLTET8k9bkN/1H5AbHGEEsWn+HznY6sPTY=;
	b=GmdpTa3oegxNFrYntjOv5s3LimiSWC6qNW69zmembSj2nAO1s3C7p2wspdFFaYZWJDXAdevoAYMs5pLhNq8ZGr6++7MblSm3BAYLT6Ds3+5FAmFjaJ2prx4gKVUz02IS4t8gLMloXQMyb7GwBZqVkW3ugXE/AYfEVpMwCa68KCg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:c2235e03-810a-456e-8c45-f0e8319dc587,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:7ff48844-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ddd26aa4297111efa54bbfbb386b949c-20240613
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1557564856; Thu, 13 Jun 2024 18:44:10 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 13 Jun 2024 03:44:08 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 13 Jun 2024 18:44:08 +0800
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
Subject: [PATCH net-next v7 4/5] net: phy: mediatek: Extend 1G TX/RX link pulse time
Date: Thu, 13 Jun 2024 18:40:22 +0800
Message-ID: <20240613104023.13044-5-SkyLake.Huang@mediatek.com>
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
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

We observe that some 10G devices' (mostly Marvell's chips inside) 1G
training time violates specification, which may last 2230ms and affect
later TX/RX link pulse time. This will invalidate MediaTek series
gigabit Ethernet PHYs' hardware auto downshift mechanism.

Without this patch, if someone is trying to use "4-wire" cable to
connect above devices, MediaTek' gigabit Ethernet PHYs may fail
to downshift to 100Mbps. (If partner 10G devices' downshift mechanism
stops at 1G)

This patch extends our 1G TX/RX link pulse time so that we can still
link up with those 10G devices.

Tested device:
- Netgear GS110EMX's 10G port (Marvell 88X3340P)
- QNAP QSW-M408-4C

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
Changes in v3:
- Refactor mtk_gphy_cl22_read_status() with genphy_read_status().

Changes in v4:
1. Change extend_an_new_lp_cnt_limit()'s return type and all return values
2. Refactor comments in extend_an_new_lp_cnt_limit()

Changes in v6:
1. Add LP_DETECTED so extend_an_new_lp_cnt_limit() won't be called every
time we poll the PHY for its status. It'll be called only when cable is
plugged in and 1G training starts.
2. Call phy_read_paged() instead of calling phy_select_page() &
phy_restore_page() pair.
---
 drivers/net/phy/mediatek/mtk-ge-soc.c  |  2 +
 drivers/net/phy/mediatek/mtk-ge.c      |  5 +-
 drivers/net/phy/mediatek/mtk-phy-lib.c | 90 ++++++++++++++++++++++++++
 drivers/net/phy/mediatek/mtk.h         | 21 ++++++
 4 files changed, 114 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index e0bbf99..fac6121 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -1399,6 +1399,7 @@ static struct phy_driver mtk_socphy_driver[] = {
 		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7981),
 		.name		= "MediaTek MT7981 PHY",
 		.config_init	= mt798x_phy_config_init,
+		.read_status	= mtk_gphy_cl22_read_status,
 		.config_intr	= genphy_no_config_intr,
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
 		.probe		= mt7981_phy_probe,
@@ -1416,6 +1417,7 @@ static struct phy_driver mtk_socphy_driver[] = {
 		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7988),
 		.name		= "MediaTek MT7988 PHY",
 		.config_init	= mt798x_phy_config_init,
+		.read_status	= mtk_gphy_cl22_read_status,
 		.config_intr	= genphy_no_config_intr,
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
 		.probe		= mt7988_phy_probe,
diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
index bd907c1..ce5786d 100644
--- a/drivers/net/phy/mediatek/mtk-ge.c
+++ b/drivers/net/phy/mediatek/mtk-ge.c
@@ -8,10 +8,6 @@
 #define MTK_GPHY_ID_MT7530		0x03a29412
 #define MTK_GPHY_ID_MT7531		0x03a29441
 
-#define MTK_PHY_PAGE_EXTENDED_1			0x0001
-#define MTK_PHY_AUX_CTRL_AND_STATUS		0x14
-#define   MTK_PHY_ENABLE_DOWNSHIFT		BIT(4)
-
 #define MTK_PHY_PAGE_EXTENDED_2			0x0002
 #define MTK_PHY_PAGE_EXTENDED_3			0x0003
 #define MTK_PHY_RG_LPI_PCS_DSP_CTRL_REG11	0x11
@@ -220,6 +216,7 @@ static struct phy_driver mtk_gephy_driver[] = {
 		.name		= "MediaTek MT7531 PHY",
 		.probe		= mt7531_phy_probe,
 		.config_init	= mt7531_phy_config_init,
+		.read_status	= mtk_gphy_cl22_read_status,
 		/* Interrupts are handled by the switch, not the PHY
 		 * itself.
 		 */
diff --git a/drivers/net/phy/mediatek/mtk-phy-lib.c b/drivers/net/phy/mediatek/mtk-phy-lib.c
index c51c9d8..e92102b 100644
--- a/drivers/net/phy/mediatek/mtk-phy-lib.c
+++ b/drivers/net/phy/mediatek/mtk-phy-lib.c
@@ -108,6 +108,96 @@ int mtk_phy_write_page(struct phy_device *phydev, int page)
 }
 EXPORT_SYMBOL_GPL(mtk_phy_write_page);
 
+/* This function deals with the case that 1G AN starts but isn't completed. We
+ * set AN_NEW_LP_CNT_LIMIT with different values time after time to let our
+ * 1G->100Mbps hardware automatic downshift to fit more partner devices.
+ */
+static int extend_an_new_lp_cnt_limit(struct phy_device *phydev)
+{
+	int mmd_read_ret;
+	u32 reg_val;
+	int timeout;
+
+	/* According to table 28-9 & Figure 28-18 in IEEE 802.3,
+	 * link_fail_inhibit_timer of 10/100/1000 Mbps devices ranges from 750
+	 * to "1000ms". Once MTK_PHY_FINAL_SPEED_1000 is set, it means that we
+	 * enter "FLP LINK GOOD CHECK" state, link_fail_inhibit_timer starts and
+	 * this PHY's 1G training starts. If 1G training never starts, we do
+	 * nothing but leave.
+	 */
+	timeout = read_poll_timeout(mmd_read_ret = phy_read_mmd, reg_val,
+				    (mmd_read_ret < 0) ||
+				    reg_val & MTK_PHY_FINAL_SPEED_1000,
+				    10000, 1000000, false, phydev,
+				    MDIO_MMD_VEND1, MTK_PHY_LINK_STATUS_MISC);
+	if (mmd_read_ret < 0)
+		return mmd_read_ret;
+
+	if (!timeout) {
+		/* Once we found MTK_PHY_FINAL_SPEED_1000 is set, no matter 1G
+		 * AN is completed or not, we'll set AN_NEW_LP_CNT_LIMIT again
+		 * and again.
+		 */
+		tr_modify(phydev, 0x0, 0xf, 0x3c, AN_NEW_LP_CNT_LIMIT_MASK,
+			  FIELD_PREP(AN_NEW_LP_CNT_LIMIT_MASK, 0xf));
+		mdelay(1500);
+
+		timeout = read_poll_timeout(tr_read, reg_val,
+					    (reg_val & AN_STATE_MASK) !=
+					    (AN_STATE_TX_DISABLE <<
+					     AN_STATE_SHIFT),
+					    10000, 1000000, false, phydev,
+					    0x0, 0xf, 0x2);
+		if (!timeout) {
+			mdelay(625);
+			tr_modify(phydev, 0x0, 0xf, 0x3c,
+				  AN_NEW_LP_CNT_LIMIT_MASK,
+				  FIELD_PREP(AN_NEW_LP_CNT_LIMIT_MASK, 0x8));
+			mdelay(500);
+			tr_modify(phydev, 0x0, 0xf, 0x3c,
+				  AN_NEW_LP_CNT_LIMIT_MASK,
+				  FIELD_PREP(AN_NEW_LP_CNT_LIMIT_MASK, 0xf));
+		} else {
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
+int mtk_gphy_cl22_read_status(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_read_status(phydev);
+	if (ret)
+		return ret;
+
+	if (phydev->autoneg == AUTONEG_ENABLE && !phydev->autoneg_complete) {
+		ret = phy_read_paged(phydev, MTK_PHY_PAGE_EXTENDED_1,
+				     MTK_PHY_AUX_CTRL_AND_STATUS);
+		if (ret < 0)
+			return ret;
+
+		/* Once LP_DETECTED is set, it means that"ability_match" in
+		 * IEEE 802.3 Figure 28-18 is set. This happens after we plug in
+		 * cable. Also, LP_DETECTED will be cleared after AN complete.
+		 */
+		if (!FIELD_GET(MTK_PHY_LP_DETECTED_MASK, ret))
+			return 0;
+
+		ret = phy_read(phydev, MII_CTRL1000);
+		if (ret & (ADVERTISE_1000FULL | ADVERTISE_1000HALF)) {
+			ret = extend_an_new_lp_cnt_limit(phydev);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_gphy_cl22_read_status);
+
 int mtk_phy_led_hw_is_supported(struct phy_device *phydev, u8 index,
 				unsigned long rules,
 				unsigned long supported_triggers)
diff --git a/drivers/net/phy/mediatek/mtk.h b/drivers/net/phy/mediatek/mtk.h
index d27226d..2bec3b1 100644
--- a/drivers/net/phy/mediatek/mtk.h
+++ b/drivers/net/phy/mediatek/mtk.h
@@ -10,8 +10,28 @@
 
 #define MTK_EXT_PAGE_ACCESS			0x1f
 #define MTK_PHY_PAGE_STANDARD			0x0000
+#define MTK_PHY_PAGE_EXTENDED_1			0x0001
+#define MTK_PHY_AUX_CTRL_AND_STATUS		0x14
+/* suprv_media_select_RefClk */
+#define   MTK_PHY_LP_DETECTED_MASK		GENMASK(7, 6)
+#define   MTK_PHY_ENABLE_DOWNSHIFT		BIT(4)
+
 #define MTK_PHY_PAGE_EXTENDED_52B5		0x52b5
 
+/* Registers on Token Ring debug nodes */
+/* ch_addr = 0x0, node_addr = 0xf, data_addr = 0x2 */
+#define   AN_STATE_MASK			GENMASK(22, 19)
+#define   AN_STATE_SHIFT		19
+#define   AN_STATE_TX_DISABLE		1
+
+/* ch_addr = 0x0, node_addr = 0xf, data_addr = 0x3c */
+#define AN_NEW_LP_CNT_LIMIT_MASK		GENMASK(23, 20)
+#define AUTO_NP_10XEN				BIT(6)
+
+/* Registers on MDIO_MMD_VEND1 */
+#define MTK_PHY_LINK_STATUS_MISC	(0xa2)
+#define   MTK_PHY_FINAL_SPEED_1000	BIT(3)
+
 /* Registers on MDIO_MMD_VEND2 */
 #define MTK_PHY_LED0_ON_CTRL			0x24
 #define MTK_PHY_LED1_ON_CTRL			0x26
@@ -77,6 +97,7 @@ void __tr_clr_bits(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
 int mtk_phy_read_page(struct phy_device *phydev);
 int mtk_phy_write_page(struct phy_device *phydev, int page);
 
+int mtk_gphy_cl22_read_status(struct phy_device *phydev);
 int mtk_phy_led_hw_is_supported(struct phy_device *phydev, u8 index,
 				unsigned long rules,
 				unsigned long supported_triggers);
-- 
2.18.0


