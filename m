Return-Path: <netdev+bounces-97321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 938E58CAC1E
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 12:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B325281546
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 10:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC4C73183;
	Tue, 21 May 2024 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ij3MtVTp"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816F37CF34;
	Tue, 21 May 2024 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716286696; cv=none; b=tq3etrYyS3+KE3WL7dHofy6u/gtZbDgN/2iCirgBu28Jb3rs7uNjVu5MhGho/NKxtw92WnonmV9dy0vT0qfmQMcUAXxGoNbxSJEsTzVnlr2X1o+lQJARndz9L/mEJ19CO6Y/F/MC3Nce2Uq07Tq3dt1ekRk4dqw95ZNy8w+zKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716286696; c=relaxed/simple;
	bh=dyn0wnOs5ah6OzX/Bmsg49n3vC+8iuKjjPFZXueJA6I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1xkSIs8pEjzcHBYWW0mfF8hbRnv4m6XW8duY5SE63Xy529JbWyjF60BCO9GmbJaIt0STkj1Hiy4rSwPhQFc4QgCzVkQUT5jcYFmdmKUQoR0nf9SaOXcuczbSZqKu7iDONtLo+EfbLwwusu5ZleqpYSctX8QGw/rQc8oyIuidQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ij3MtVTp; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6c1af96c175b11efb92737409a0e9459-20240521
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=n6049CLmOykfsLJuEGhnBsULqwRkvRXGeSxXNY14rlc=;
	b=ij3MtVTpRkAWxtuEpUaMqnVSkjlsgOigQdgMa8Idp3lptAH43WfUOfKfGP045tqnCW38J/2UpIsMwH5+dj7OMr+G6stwn0+oK8jkGl/KRdDIgFBkHVNVzradAvOESayfLB86UvZirLEuj5ResC+zeDcJwj0uWt51kxTpLbPNTRQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:ce18e183-02bf-44ba-961a-e6ad899c057a,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:c2d65cfc-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6c1af96c175b11efb92737409a0e9459-20240521
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 573676641; Tue, 21 May 2024 18:18:09 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 21 May 2024 18:18:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 21 May 2024 18:18:08 +0800
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
Subject: [PATCH net-next v4 4/5] net: phy: mediatek: Extend 1G TX/RX link pulse time
Date: Tue, 21 May 2024 18:15:47 +0800
Message-ID: <20240521101548.9286-5-SkyLake.Huang@mediatek.com>
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

v3:
Refactor mtk_gphy_cl22_read_status() with genphy_read_status().

v4:
1. Change extend_an_new_lp_cnt_limit()'s return type and all return values
2. Refactor comments in extend_an_new_lp_cnt_limit()

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
 drivers/net/phy/mediatek/mtk-ge-soc.c  |  2 +
 drivers/net/phy/mediatek/mtk-ge.c      |  1 +
 drivers/net/phy/mediatek/mtk-phy-lib.c | 66 ++++++++++++++++++++++++++
 drivers/net/phy/mediatek/mtk.h         | 16 +++++++
 4 files changed, 85 insertions(+)

diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index 8f23137..62424d4 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -1339,6 +1339,7 @@ static struct phy_driver mtk_socphy_driver[] = {
 		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7981),
 		.name		= "MediaTek MT7981 PHY",
 		.config_init	= mt798x_phy_config_init,
+		.read_status	= mtk_gphy_cl22_read_status,
 		.config_intr	= genphy_no_config_intr,
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
 		.probe		= mt7981_phy_probe,
@@ -1356,6 +1357,7 @@ static struct phy_driver mtk_socphy_driver[] = {
 		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7988),
 		.name		= "MediaTek MT7988 PHY",
 		.config_init	= mt798x_phy_config_init,
+		.read_status	= mtk_gphy_cl22_read_status,
 		.config_intr	= genphy_no_config_intr,
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
 		.probe		= mt7988_phy_probe,
diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
index 5c0226d..c832c90 100644
--- a/drivers/net/phy/mediatek/mtk-ge.c
+++ b/drivers/net/phy/mediatek/mtk-ge.c
@@ -211,6 +211,7 @@ static struct phy_driver mtk_gephy_driver[] = {
 		.name		= "MediaTek MT7531 PHY",
 		.probe		= mt7531_phy_probe,
 		.config_init	= mt7531_phy_config_init,
+		.read_status	= mtk_gphy_cl22_read_status,
 		/* Interrupts are handled by the switch, not the PHY
 		 * itself.
 		 */
diff --git a/drivers/net/phy/mediatek/mtk-phy-lib.c b/drivers/net/phy/mediatek/mtk-phy-lib.c
index 43547f4..8ec1699 100644
--- a/drivers/net/phy/mediatek/mtk-phy-lib.c
+++ b/drivers/net/phy/mediatek/mtk-phy-lib.c
@@ -106,6 +106,72 @@ int mtk_phy_write_page(struct phy_device *phydev, int page)
 }
 EXPORT_SYMBOL_GPL(mtk_phy_write_page);
 
+static int extend_an_new_lp_cnt_limit(struct phy_device *phydev)
+{
+	int mmd_read_ret;
+	u32 reg_val;
+	int timeout;
+
+	timeout = read_poll_timeout(mmd_read_ret = phy_read_mmd, reg_val,
+			  (mmd_read_ret < 0) || reg_val & MTK_PHY_FINAL_SPEED_1000,
+			  10000, 1000000, false, phydev,
+			  MDIO_MMD_VEND1, MTK_PHY_LINK_STATUS_MISC);
+	if (mmd_read_ret < 0)
+		return mmd_read_ret;
+
+	/* [When cable is plugged in]
+	 * We expect final_speed_1000 will be set, which means this phy starts 1G link-up
+	 * training. In this case, try to extend timeout period of auto downshift.
+	 * [When cable is unplugged]
+	 * We expect that reading MTK_PHY_FINAL_SPEED_1000 will time out. Do nothing but
+	 * return.
+	 */
+	if (!timeout) {
+		tr_modify(phydev, 0x0, 0xf, 0x3c, AN_NEW_LP_CNT_LIMIT_MASK,
+			  FIELD_PREP(AN_NEW_LP_CNT_LIMIT_MASK, 0xf));
+		mdelay(1500);
+
+		timeout = read_poll_timeout(tr_read, reg_val,
+					    (reg_val & AN_STATE_MASK) !=
+					    (AN_STATE_TX_DISABLE << AN_STATE_SHIFT),
+					    10000, 1000000, false, phydev,
+					    0x0, 0xf, 0x2);
+		if (!timeout) {
+			mdelay(625);
+			tr_modify(phydev, 0x0, 0xf, 0x3c, AN_NEW_LP_CNT_LIMIT_MASK,
+				  FIELD_PREP(AN_NEW_LP_CNT_LIMIT_MASK, 0x8));
+			mdelay(500);
+			tr_modify(phydev, 0x0, 0xf, 0x3c, AN_NEW_LP_CNT_LIMIT_MASK,
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
+		ret = phy_read(phydev, MII_CTRL1000);
+		if ((ret & ADVERTISE_1000FULL) || (ret & ADVERTISE_1000HALF)) {
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
 int mtk_phy_led_hw_is_supported(struct phy_device *phydev, u8 index, unsigned long rules,
 				unsigned long supported_triggers)
 {
diff --git a/drivers/net/phy/mediatek/mtk.h b/drivers/net/phy/mediatek/mtk.h
index 10ee9be..32fa3f1 100644
--- a/drivers/net/phy/mediatek/mtk.h
+++ b/drivers/net/phy/mediatek/mtk.h
@@ -12,6 +12,20 @@
 #define MTK_PHY_PAGE_STANDARD			0x0000
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
@@ -75,6 +89,8 @@ void __tr_clr_bits(struct phy_device *phydev, u8 ch_addr, u8 node_addr, u8 data_
 int mtk_phy_read_page(struct phy_device *phydev);
 int mtk_phy_write_page(struct phy_device *phydev, int page);
 
+int mtk_gphy_cl22_read_status(struct phy_device *phydev);
+
 int mtk_phy_led_hw_is_supported(struct phy_device *phydev, u8 index, unsigned long rules,
 				unsigned long supported_triggers);
 int mtk_phy_led_hw_ctrl_set(struct phy_device *phydev, u8 index, unsigned long rules,
-- 
2.18.0


