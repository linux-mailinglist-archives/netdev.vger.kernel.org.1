Return-Path: <netdev+bounces-165878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5378A339A1
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C221881445
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7BC20AF88;
	Thu, 13 Feb 2025 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Qv+B58F9"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE60720AF7A;
	Thu, 13 Feb 2025 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739434027; cv=none; b=Z3M1ZF+aREloucTwunQx9SvMakb2Vpx0CnDqzR6FCKY0m8TIWGfQWaNfGaTj+1kKJvCaEMy1lOecuLOM3f5g53Tag3JGvXgdH+CLR8Q499mhaxypyf30ez7dcBZppteYNOw4zNxc0KhSdYwQSw89NZ+afFnDXtoAbNojzKyYOgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739434027; c=relaxed/simple;
	bh=kxLGNWK+pj1InvC4wloD8WJ6PctAWJRleKxFJN22GUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFBrnLw1tJJBVr2FJ7IdWk9iTCaiuvojwUJZdFhO+IbULz3tfube9N0irTezLnfFkDTu25/Fd0Py90aKV2RZNjn1rBqZnmT+YIBsagL5Q1c4oITqg69CWDRtcxIvenmt/93vJdMk3ePTmamtQRxPdEk42hPrymBIetXcoXI7VpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Qv+B58F9; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8000ee24e9e111efbd192953cf12861f-20250213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mJOuul+1ddjMXjDBDPNMYRncgensbFvRnddv684L7m0=;
	b=Qv+B58F9htecH4bMfnM6ttRCYRyBkRvQzgE5FcUKKfEyj4eRCAWqhXhB16PxaQ8U2JApr4CbMb7jTQNBwZGQb90lTKGvxA7iZmmJiVqG0M6xgMiqqt2qqtbscjwJnBXbONU+01FNfCtshpC8kpYoMRZYLefAFHj0mxvg4tpEMLs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:829d9e46-c69c-43ac-86c1-ad8b14dd6258,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:60aa074,CLOUDID:8e1b68a1-97df-4c26-9c83-d31de0c9db26,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:1,
	IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8000ee24e9e111efbd192953cf12861f-20250213
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1569708011; Thu, 13 Feb 2025 16:06:59 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 13 Feb 2025 16:06:58 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 13 Feb 2025 16:06:58 +0800
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
CC: Steven Liu <Steven.Liu@mediatek.com>, Sky Huang
	<skylake.huang@mediatek.com>
Subject: [PATCH net-next v2 1/5] net: phy: mediatek: Change to more meaningful macros
Date: Thu, 13 Feb 2025 16:05:49 +0800
Message-ID: <20250213080553.921434-2-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250213080553.921434-1-SkyLake.Huang@mediatek.com>
References: <20250213080553.921434-1-SkyLake.Huang@mediatek.com>
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

Replace magic number with more meaningful macros in mtk-ge.c.
Also, move some common macros into mtk-phy-lib.c.

Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
---
 drivers/net/phy/mediatek/mtk-ge-soc.c |  1 -
 drivers/net/phy/mediatek/mtk-ge.c     | 71 +++++++++++++++++++++------
 drivers/net/phy/mediatek/mtk.h        |  2 +
 3 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index 38dc898..f4f40a4 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -24,7 +24,6 @@
 #define MTK_PHY_SMI_DET_ON_THRESH_MASK		GENMASK(13, 8)
 
 #define MTK_PHY_PAGE_EXTENDED_2A30		0x2a30
-#define MTK_PHY_PAGE_EXTENDED_52B5		0x52b5
 
 #define ANALOG_INTERNAL_OPERATION_MAX_US	20
 #define TXRESERVE_MIN				0
diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
index ed2617b..1e4adf1 100644
--- a/drivers/net/phy/mediatek/mtk-ge.c
+++ b/drivers/net/phy/mediatek/mtk-ge.c
@@ -8,18 +8,38 @@
 #define MTK_GPHY_ID_MT7530		0x03a29412
 #define MTK_GPHY_ID_MT7531		0x03a29441
 
-#define MTK_EXT_PAGE_ACCESS		0x1f
-#define MTK_PHY_PAGE_STANDARD		0x0000
-#define MTK_PHY_PAGE_EXTENDED		0x0001
-#define MTK_PHY_PAGE_EXTENDED_2		0x0002
-#define MTK_PHY_PAGE_EXTENDED_3		0x0003
-#define MTK_PHY_PAGE_EXTENDED_2A30	0x2a30
-#define MTK_PHY_PAGE_EXTENDED_52B5	0x52b5
+#define MTK_PHY_PAGE_EXTENDED_1			0x0001
+#define MTK_PHY_AUX_CTRL_AND_STATUS		0x14
+#define   MTK_PHY_ENABLE_DOWNSHIFT		BIT(4)
+
+#define MTK_PHY_PAGE_EXTENDED_2			0x0002
+#define MTK_PHY_PAGE_EXTENDED_3			0x0003
+#define MTK_PHY_RG_LPI_PCS_DSP_CTRL_REG11	0x11
+
+#define MTK_PHY_PAGE_EXTENDED_2A30		0x2a30
+
+/* Registers on MDIO_MMD_VEND1 */
+#define MTK_PHY_GBE_MODE_TX_DELAY_SEL		0x13
+#define MTK_PHY_TEST_MODE_TX_DELAY_SEL		0x14
+#define   MTK_TX_DELAY_PAIR_B_MASK		GENMASK(10, 8)
+#define   MTK_TX_DELAY_PAIR_D_MASK		GENMASK(2, 0)
+
+#define MTK_PHY_MCC_CTRL_AND_TX_POWER_CTRL	0xa6
+#define   MTK_MCC_NEARECHO_OFFSET_MASK		GENMASK(15, 8)
+
+#define MTK_PHY_RXADC_CTRL_RG7			0xc6
+#define   MTK_PHY_DA_AD_BUF_BIAS_LP_MASK	GENMASK(9, 8)
+
+#define MTK_PHY_RG_LPI_PCS_DSP_CTRL_REG123	0x123
+#define   MTK_PHY_LPI_NORM_MSE_LO_THRESH100_MASK	GENMASK(15, 8)
+#define   MTK_PHY_LPI_NORM_MSE_HI_THRESH100_MASK	GENMASK(7, 0)
 
 static void mtk_gephy_config_init(struct phy_device *phydev)
 {
 	/* Enable HW auto downshift */
-	phy_modify_paged(phydev, MTK_PHY_PAGE_EXTENDED, 0x14, 0, BIT(4));
+	phy_modify_paged(phydev, MTK_PHY_PAGE_EXTENDED_1,
+			 MTK_PHY_AUX_CTRL_AND_STATUS,
+			 0, MTK_PHY_ENABLE_DOWNSHIFT);
 
 	/* Increase SlvDPSready time */
 	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
@@ -29,10 +49,20 @@ static void mtk_gephy_config_init(struct phy_device *phydev)
 	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
 
 	/* Adjust 100_mse_threshold */
-	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x123, 0xffff);
-
-	/* Disable mcc */
-	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0xa6, 0x300);
+	phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+		       MTK_PHY_RG_LPI_PCS_DSP_CTRL_REG123,
+		       MTK_PHY_LPI_NORM_MSE_LO_THRESH100_MASK |
+		       MTK_PHY_LPI_NORM_MSE_HI_THRESH100_MASK,
+		       FIELD_PREP(MTK_PHY_LPI_NORM_MSE_LO_THRESH100_MASK,
+				  0xff) |
+		       FIELD_PREP(MTK_PHY_LPI_NORM_MSE_HI_THRESH100_MASK,
+				  0xff));
+
+	/* If echo time is narrower than 0x3, it will be regarded as noise */
+	phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+		       MTK_PHY_MCC_CTRL_AND_TX_POWER_CTRL,
+		       MTK_MCC_NEARECHO_OFFSET_MASK,
+		       FIELD_PREP(MTK_MCC_NEARECHO_OFFSET_MASK, 0x3));
 }
 
 static int mt7530_phy_config_init(struct phy_device *phydev)
@@ -40,7 +70,8 @@ static int mt7530_phy_config_init(struct phy_device *phydev)
 	mtk_gephy_config_init(phydev);
 
 	/* Increase post_update_timer */
-	phy_write_paged(phydev, MTK_PHY_PAGE_EXTENDED_3, 0x11, 0x4b);
+	phy_write_paged(phydev, MTK_PHY_PAGE_EXTENDED_3,
+			MTK_PHY_RG_LPI_PCS_DSP_CTRL_REG11, 0x4b);
 
 	return 0;
 }
@@ -51,11 +82,19 @@ static int mt7531_phy_config_init(struct phy_device *phydev)
 
 	/* PHY link down power saving enable */
 	phy_set_bits(phydev, 0x17, BIT(4));
-	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, 0xc6, 0x300);
+	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RXADC_CTRL_RG7,
+		       MTK_PHY_DA_AD_BUF_BIAS_LP_MASK,
+		       FIELD_PREP(MTK_PHY_DA_AD_BUF_BIAS_LP_MASK, 0x3));
 
 	/* Set TX Pair delay selection */
-	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x13, 0x404);
-	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x14, 0x404);
+	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_GBE_MODE_TX_DELAY_SEL,
+		       MTK_TX_DELAY_PAIR_B_MASK | MTK_TX_DELAY_PAIR_D_MASK,
+		       FIELD_PREP(MTK_TX_DELAY_PAIR_B_MASK, 0x4) |
+		       FIELD_PREP(MTK_TX_DELAY_PAIR_D_MASK, 0x4));
+	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TEST_MODE_TX_DELAY_SEL,
+		       MTK_TX_DELAY_PAIR_B_MASK | MTK_TX_DELAY_PAIR_D_MASK,
+		       FIELD_PREP(MTK_TX_DELAY_PAIR_B_MASK, 0x4) |
+		       FIELD_PREP(MTK_TX_DELAY_PAIR_D_MASK, 0x4));
 
 	return 0;
 }
diff --git a/drivers/net/phy/mediatek/mtk.h b/drivers/net/phy/mediatek/mtk.h
index 63d9fe1..a888e2e 100644
--- a/drivers/net/phy/mediatek/mtk.h
+++ b/drivers/net/phy/mediatek/mtk.h
@@ -9,6 +9,8 @@
 #define _MTK_EPHY_H_
 
 #define MTK_EXT_PAGE_ACCESS			0x1f
+#define MTK_PHY_PAGE_STANDARD			0x0000
+#define MTK_PHY_PAGE_EXTENDED_52B5		0x52b5
 
 /* Registers on MDIO_MMD_VEND2 */
 #define MTK_PHY_LED0_ON_CTRL			0x24
-- 
2.18.0


