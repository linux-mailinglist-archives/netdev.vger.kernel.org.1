Return-Path: <netdev+bounces-165879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B315A339A3
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F235B188214D
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCA220AF7A;
	Thu, 13 Feb 2025 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LX+s5DfP"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0207120AF88;
	Thu, 13 Feb 2025 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739434037; cv=none; b=lmqRvrOpIOGK07P6l2iTB+aRNEtSWTUpdBDhQgVzg/YOjbgHs5Y019rZSfAMZbrxPBluqQwnACBeCoiMyQ+Kkz5AkFau4VfgPBHRzJrKsQ3s7v57Oz91xUgAE0Kfj4+u90arXg21Y1YyASMCuc/i5D7XYDv6YUmPPLoHLybd70Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739434037; c=relaxed/simple;
	bh=qg2AR9/BQ2ugtpiBgcpdyO+CHd1Nn2sgKSpanL00MN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mi69Sa8wJilwFJrujHCFc/YlzLZUOuw8n7W7mWkJEd3SNzKLGiQdGhicPY5RxkYkXt9vcKLobKNeuOBSqKWKMQfjs9JWBssM/mEPWe6ETsp3lXIp/fJneXLyqi/6Zl3yPPapmIvumU8V/JdrB7Y05IkcFe7Kd+WaziarUVv038k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LX+s5DfP; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 853d4680e9e111efbd192953cf12861f-20250213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=suEjxNuJtpiK8TY1+XGhydcAOvrvcHMBoDhfJQ5ma4Y=;
	b=LX+s5DfPuHU0JnkYm2XoKs259GgOt2jzw98G0D9K8kMFyC2Tihcbu68ZARzogQN6fH+VGkZi2evbl32iUrxSikkvpcISyksdWWebfl102ahY3JldOVtJ3t259wHJv7wU2kBub5bb6Fs8U+SSnNhQ1wFUSmpBVRD7ciSnaWkX/V0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:3ea96b1c-ed03-4e5f-9ef7-c83b6141c102,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:60aa074,CLOUDID:2a084f8f-637d-4112-88e4-c7792fee6ae2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:1,
	IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 853d4680e9e111efbd192953cf12861f-20250213
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1154489434; Thu, 13 Feb 2025 16:07:08 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 13 Feb 2025 16:07:07 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 13 Feb 2025 16:07:07 +0800
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
Subject: [PATCH net-next v2 2/5] net: phy: mediatek: Add token ring access helper functions in mtk-phy-lib
Date: Thu, 13 Feb 2025 16:05:50 +0800
Message-ID: <20250213080553.921434-3-SkyLake.Huang@mediatek.com>
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

This patch adds TR(token ring) manipulations and adds correct
macro names for those magic numbers. TR is a way to access
proprietary registers on page 52b5. Use these helper functions
so we can see which fields we're going to modify/set/clear.

TR functions with __* prefix mean that the operations inside
aren't wrapped by page select/restore functions.

This patch doesn't really change registers' settings but just
enhances readability and maintainability.

Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
---
 drivers/net/phy/mediatek/mtk-ge-soc.c  | 231 +++++++++++++++++--------
 drivers/net/phy/mediatek/mtk-ge.c      |  11 +-
 drivers/net/phy/mediatek/mtk-phy-lib.c |  63 +++++++
 drivers/net/phy/mediatek/mtk.h         |   5 +
 4 files changed, 230 insertions(+), 80 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index f4f40a4..ee335f4 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -25,6 +25,90 @@
 
 #define MTK_PHY_PAGE_EXTENDED_2A30		0x2a30
 
+/* Registers on Token Ring debug nodes */
+/* ch_addr = 0x0, node_addr = 0x7, data_addr = 0x15 */
+/* NormMseLoThresh */
+#define NORMAL_MSE_LO_THRESH_MASK		GENMASK(15, 8)
+
+/* ch_addr = 0x0, node_addr = 0xf, data_addr = 0x3c */
+/* RemAckCntLimitCtrl */
+#define REMOTE_ACK_COUNT_LIMIT_CTRL_MASK	GENMASK(2, 1)
+
+/* ch_addr = 0x1, node_addr = 0xd, data_addr = 0x20 */
+/* VcoSlicerThreshBitsHigh */
+#define VCO_SLICER_THRESH_HIGH_MASK		GENMASK(23, 0)
+
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x0 */
+/* DfeTailEnableVgaThresh1000 */
+#define DFE_TAIL_EANBLE_VGA_TRHESH_1000		GENMASK(5, 1)
+
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x1 */
+/* MrvlTrFix100Kp */
+#define MRVL_TR_FIX_100KP_MASK			GENMASK(22, 20)
+/* MrvlTrFix100Kf */
+#define MRVL_TR_FIX_100KF_MASK			GENMASK(19, 17)
+/* MrvlTrFix1000Kp */
+#define MRVL_TR_FIX_1000KP_MASK			GENMASK(16, 14)
+/* MrvlTrFix1000Kf */
+#define MRVL_TR_FIX_1000KF_MASK			GENMASK(13, 11)
+
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x12 */
+/* VgaDecRate */
+#define VGA_DECIMATION_RATE_MASK		GENMASK(8, 5)
+
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x17 */
+/* SlvDSPreadyTime */
+#define SLAVE_DSP_READY_TIME_MASK		GENMASK(22, 15)
+/* MasDSPreadyTime */
+#define MASTER_DSP_READY_TIME_MASK		GENMASK(14, 7)
+
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x20 */
+/* ResetSyncOffset */
+#define RESET_SYNC_OFFSET_MASK			GENMASK(11, 8)
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x0 */
+/* FfeUpdGainForceVal */
+#define FFE_UPDATE_GAIN_FORCE_VAL_MASK		GENMASK(9, 7)
+/* FfeUpdGainForce */
+#define FFE_UPDATE_GAIN_FORCE			BIT(6)
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x6 */
+/* SS: Steady-state, KP: Proportional Gain */
+/* SSTrKp100 */
+#define SS_TR_KP100_MASK			GENMASK(21, 19)
+/* SSTrKf100 */
+#define SS_TR_KF100_MASK			GENMASK(18, 16)
+/* SSTrKp1000Mas */
+#define SS_TR_KP1000_MASTER_MASK		GENMASK(15, 13)
+/* SSTrKf1000Mas */
+#define SS_TR_KF1000_MASTER_MASK		GENMASK(12, 10)
+/* SSTrKp1000Slv */
+#define SS_TR_KP1000_SLAVE_MASK			GENMASK(9, 7)
+/* SSTrKf1000Slv */
+#define SS_TR_KF1000_SLAVE_MASK			GENMASK(6, 4)
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0xd */
+/* RegEEE_st2TrKf1000 */
+#define EEE1000_STAGE2_TR_KF_MASK		GENMASK(13, 11)
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0xf */
+/* RegEEE_slv_waketr_timer_tar */
+#define SLAVE_WAKETR_TIMER_MASK			GENMASK(20, 11)
+/* RegEEE_slv_remtx_timer_tar */
+#define SLAVE_REMTX_TIMER_MASK			GENMASK(10, 1)
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x10 */
+/* RegEEE_slv_wake_int_timer_tar */
+#define SLAVE_WAKEINT_TIMER_MASK		GENMASK(10, 1)
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x14 */
+/* RegEEE_trfreeze_timer2 */
+#define TR_FREEZE_TIMER2_MASK			GENMASK(9, 0)
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x1c */
+/* RegEEE100Stg1_tar */
+#define EEE100_LPSYNC_STAGE1_UPDATE_TIMER_MASK	GENMASK(8, 0)
+
 #define ANALOG_INTERNAL_OPERATION_MAX_US	20
 #define TXRESERVE_MIN				0
 #define TXRESERVE_MAX				7
@@ -700,40 +784,41 @@ static int tx_vcm_cal_sw(struct phy_device *phydev, u8 rg_txreserve_x)
 static void mt798x_phy_common_finetune(struct phy_device *phydev)
 {
 	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
-	/* SlvDSPreadyTime = 24, MasDSPreadyTime = 24 */
-	__phy_write(phydev, 0x11, 0xc71);
-	__phy_write(phydev, 0x12, 0xc);
-	__phy_write(phydev, 0x10, 0x8fae);
+	__mtk_tr_modify(phydev, 0x1, 0xf, 0x17,
+			SLAVE_DSP_READY_TIME_MASK | MASTER_DSP_READY_TIME_MASK,
+			FIELD_PREP(SLAVE_DSP_READY_TIME_MASK, 0x18) |
+			FIELD_PREP(MASTER_DSP_READY_TIME_MASK, 0x18));
 
 	/* EnabRandUpdTrig = 1 */
 	__phy_write(phydev, 0x11, 0x2f00);
 	__phy_write(phydev, 0x12, 0xe);
 	__phy_write(phydev, 0x10, 0x8fb0);
 
-	/* NormMseLoThresh = 85 */
-	__phy_write(phydev, 0x11, 0x55a0);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x83aa);
+	__mtk_tr_modify(phydev, 0x0, 0x7, 0x15,
+			NORMAL_MSE_LO_THRESH_MASK,
+			FIELD_PREP(NORMAL_MSE_LO_THRESH_MASK, 0x55));
 
-	/* FfeUpdGainForce = 1(Enable), FfeUpdGainForceVal = 4 */
-	__phy_write(phydev, 0x11, 0x240);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x9680);
+	__mtk_tr_modify(phydev, 0x2, 0xd, 0x0,
+			FFE_UPDATE_GAIN_FORCE_VAL_MASK,
+			FIELD_PREP(FFE_UPDATE_GAIN_FORCE_VAL_MASK, 0x4) |
+				   FFE_UPDATE_GAIN_FORCE);
 
 	/* TrFreeze = 0 (mt7988 default) */
 	__phy_write(phydev, 0x11, 0x0);
 	__phy_write(phydev, 0x12, 0x0);
 	__phy_write(phydev, 0x10, 0x9686);
 
-	/* SSTrKp100 = 5 */
-	/* SSTrKf100 = 6 */
-	/* SSTrKp1000Mas = 5 */
-	/* SSTrKf1000Mas = 6 */
-	/* SSTrKp1000Slv = 5 */
-	/* SSTrKf1000Slv = 6 */
-	__phy_write(phydev, 0x11, 0xbaef);
-	__phy_write(phydev, 0x12, 0x2e);
-	__phy_write(phydev, 0x10, 0x968c);
+	__mtk_tr_modify(phydev, 0x2, 0xd, 0x6,
+			SS_TR_KP100_MASK | SS_TR_KF100_MASK |
+			SS_TR_KP1000_MASTER_MASK | SS_TR_KF1000_MASTER_MASK |
+			SS_TR_KP1000_SLAVE_MASK | SS_TR_KF1000_SLAVE_MASK,
+			FIELD_PREP(SS_TR_KP100_MASK, 0x5) |
+			FIELD_PREP(SS_TR_KF100_MASK, 0x6) |
+			FIELD_PREP(SS_TR_KP1000_MASTER_MASK, 0x5) |
+			FIELD_PREP(SS_TR_KF1000_MASTER_MASK, 0x6) |
+			FIELD_PREP(SS_TR_KP1000_SLAVE_MASK, 0x5) |
+			FIELD_PREP(SS_TR_KF1000_SLAVE_MASK, 0x6));
+
 	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
 }
 
@@ -756,27 +841,29 @@ static void mt7981_phy_finetune(struct phy_device *phydev)
 	}
 
 	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
-	/* ResetSyncOffset = 6 */
-	__phy_write(phydev, 0x11, 0x600);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x8fc0);
+	__mtk_tr_modify(phydev, 0x1, 0xf, 0x20,
+			RESET_SYNC_OFFSET_MASK,
+			FIELD_PREP(RESET_SYNC_OFFSET_MASK, 0x6));
 
-	/* VgaDecRate = 1 */
-	__phy_write(phydev, 0x11, 0x4c2a);
-	__phy_write(phydev, 0x12, 0x3e);
-	__phy_write(phydev, 0x10, 0x8fa4);
+	__mtk_tr_modify(phydev, 0x1, 0xf, 0x12,
+			VGA_DECIMATION_RATE_MASK,
+			FIELD_PREP(VGA_DECIMATION_RATE_MASK, 0x1));
 
 	/* MrvlTrFix100Kp = 3, MrvlTrFix100Kf = 2,
 	 * MrvlTrFix1000Kp = 3, MrvlTrFix1000Kf = 2
 	 */
-	__phy_write(phydev, 0x11, 0xd10a);
-	__phy_write(phydev, 0x12, 0x34);
-	__phy_write(phydev, 0x10, 0x8f82);
+	__mtk_tr_modify(phydev, 0x1, 0xf, 0x1,
+			MRVL_TR_FIX_100KP_MASK | MRVL_TR_FIX_100KF_MASK |
+			MRVL_TR_FIX_1000KP_MASK | MRVL_TR_FIX_1000KF_MASK,
+			FIELD_PREP(MRVL_TR_FIX_100KP_MASK, 0x3) |
+			FIELD_PREP(MRVL_TR_FIX_100KF_MASK, 0x2) |
+			FIELD_PREP(MRVL_TR_FIX_1000KP_MASK, 0x3) |
+			FIELD_PREP(MRVL_TR_FIX_1000KF_MASK, 0x2));
 
 	/* VcoSlicerThreshBitsHigh */
-	__phy_write(phydev, 0x11, 0x5555);
-	__phy_write(phydev, 0x12, 0x55);
-	__phy_write(phydev, 0x10, 0x8ec0);
+	__mtk_tr_modify(phydev, 0x1, 0xd, 0x20,
+			VCO_SLICER_THRESH_HIGH_MASK,
+			FIELD_PREP(VCO_SLICER_THRESH_HIGH_MASK, 0x555555));
 	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
 
 	/* TR_OPEN_LOOP_EN = 1, lpf_x_average = 9 */
@@ -828,25 +915,23 @@ static void mt7988_phy_finetune(struct phy_device *phydev)
 	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_TX_FILTER, 0x5);
 
 	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
-	/* ResetSyncOffset = 5 */
-	__phy_write(phydev, 0x11, 0x500);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x8fc0);
+	__mtk_tr_modify(phydev, 0x1, 0xf, 0x20,
+			RESET_SYNC_OFFSET_MASK,
+			FIELD_PREP(RESET_SYNC_OFFSET_MASK, 0x5));
 
 	/* VgaDecRate is 1 at default on mt7988 */
 
-	/* MrvlTrFix100Kp = 6, MrvlTrFix100Kf = 7,
-	 * MrvlTrFix1000Kp = 6, MrvlTrFix1000Kf = 7
-	 */
-	__phy_write(phydev, 0x11, 0xb90a);
-	__phy_write(phydev, 0x12, 0x6f);
-	__phy_write(phydev, 0x10, 0x8f82);
-
-	/* RemAckCntLimitCtrl = 1 */
-	__phy_write(phydev, 0x11, 0xfbba);
-	__phy_write(phydev, 0x12, 0xc3);
-	__phy_write(phydev, 0x10, 0x87f8);
-
+	__mtk_tr_modify(phydev, 0x1, 0xf, 0x1,
+			MRVL_TR_FIX_100KP_MASK | MRVL_TR_FIX_100KF_MASK |
+			MRVL_TR_FIX_1000KP_MASK | MRVL_TR_FIX_1000KF_MASK,
+			FIELD_PREP(MRVL_TR_FIX_100KP_MASK, 0x6) |
+			FIELD_PREP(MRVL_TR_FIX_100KF_MASK, 0x7) |
+			FIELD_PREP(MRVL_TR_FIX_1000KP_MASK, 0x6) |
+			FIELD_PREP(MRVL_TR_FIX_1000KF_MASK, 0x7));
+
+	__mtk_tr_modify(phydev, 0x0, 0xf, 0x3c,
+			REMOTE_ACK_COUNT_LIMIT_CTRL_MASK,
+			FIELD_PREP(REMOTE_ACK_COUNT_LIMIT_CTRL_MASK, 0x1));
 	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
 
 	/* TR_OPEN_LOOP_EN = 1, lpf_x_average = 10 */
@@ -927,40 +1012,36 @@ static void mt798x_phy_eee(struct phy_device *phydev)
 	__phy_write(phydev, 0x12, 0x0);
 	__phy_write(phydev, 0x10, 0x9690);
 
-	/* REG_EEE_st2TrKf1000 = 2 */
-	__phy_write(phydev, 0x11, 0x114f);
-	__phy_write(phydev, 0x12, 0x2);
-	__phy_write(phydev, 0x10, 0x969a);
+	__mtk_tr_modify(phydev, 0x2, 0xd, 0xd,
+			EEE1000_STAGE2_TR_KF_MASK,
+			FIELD_PREP(EEE1000_STAGE2_TR_KF_MASK, 0x2));
 
-	/* RegEEE_slv_wake_tr_timer_tar = 6, RegEEE_slv_remtx_timer_tar = 20 */
-	__phy_write(phydev, 0x11, 0x3028);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x969e);
+	__mtk_tr_modify(phydev, 0x2, 0xd, 0xf,
+			SLAVE_WAKETR_TIMER_MASK | SLAVE_REMTX_TIMER_MASK,
+			FIELD_PREP(SLAVE_WAKETR_TIMER_MASK, 0x6) |
+			FIELD_PREP(SLAVE_REMTX_TIMER_MASK, 0x14));
 
-	/* RegEEE_slv_wake_int_timer_tar = 8 */
-	__phy_write(phydev, 0x11, 0x5010);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x96a0);
+	__mtk_tr_modify(phydev, 0x2, 0xd, 0x10,
+			SLAVE_WAKEINT_TIMER_MASK,
+			FIELD_PREP(SLAVE_WAKEINT_TIMER_MASK, 0x8));
 
-	/* RegEEE_trfreeze_timer2 = 586 */
-	__phy_write(phydev, 0x11, 0x24a);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x96a8);
+	__mtk_tr_modify(phydev, 0x2, 0xd, 0x14,
+			TR_FREEZE_TIMER2_MASK,
+			FIELD_PREP(TR_FREEZE_TIMER2_MASK, 0x24a));
 
-	/* RegEEE100Stg1_tar = 16 */
-	__phy_write(phydev, 0x11, 0x3210);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x96b8);
+	__mtk_tr_modify(phydev, 0x2, 0xd, 0x1c,
+			EEE100_LPSYNC_STAGE1_UPDATE_TIMER_MASK,
+			FIELD_PREP(EEE100_LPSYNC_STAGE1_UPDATE_TIMER_MASK,
+				   0x10));
 
 	/* REGEEE_wake_slv_tr_wait_dfesigdet_en = 0 */
 	__phy_write(phydev, 0x11, 0x1463);
 	__phy_write(phydev, 0x12, 0x0);
 	__phy_write(phydev, 0x10, 0x96ca);
 
-	/* DfeTailEnableVgaThresh1000 = 27 */
-	__phy_write(phydev, 0x11, 0x36);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x8f80);
+	__mtk_tr_modify(phydev, 0x1, 0xf, 0x0,
+			DFE_TAIL_EANBLE_VGA_TRHESH_1000,
+			FIELD_PREP(DFE_TAIL_EANBLE_VGA_TRHESH_1000, 0x1b));
 	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
 
 	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_3);
diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
index 1e4adf1..79663da 100644
--- a/drivers/net/phy/mediatek/mtk-ge.c
+++ b/drivers/net/phy/mediatek/mtk-ge.c
@@ -18,6 +18,10 @@
 
 #define MTK_PHY_PAGE_EXTENDED_2A30		0x2a30
 
+/* Registers on Token Ring debug nodes */
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x17 */
+#define SLAVE_DSP_READY_TIME_MASK		GENMASK(22, 15)
+
 /* Registers on MDIO_MMD_VEND1 */
 #define MTK_PHY_GBE_MODE_TX_DELAY_SEL		0x13
 #define MTK_PHY_TEST_MODE_TX_DELAY_SEL		0x14
@@ -42,11 +46,8 @@ static void mtk_gephy_config_init(struct phy_device *phydev)
 			 0, MTK_PHY_ENABLE_DOWNSHIFT);
 
 	/* Increase SlvDPSready time */
-	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
-	__phy_write(phydev, 0x10, 0xafae);
-	__phy_write(phydev, 0x12, 0x2f);
-	__phy_write(phydev, 0x10, 0x8fae);
-	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
+	mtk_tr_modify(phydev, 0x1, 0xf, 0x17, SLAVE_DSP_READY_TIME_MASK,
+		      FIELD_PREP(SLAVE_DSP_READY_TIME_MASK, 0x5e));
 
 	/* Adjust 100_mse_threshold */
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1,
diff --git a/drivers/net/phy/mediatek/mtk-phy-lib.c b/drivers/net/phy/mediatek/mtk-phy-lib.c
index 98a09d6..7275e4e 100644
--- a/drivers/net/phy/mediatek/mtk-phy-lib.c
+++ b/drivers/net/phy/mediatek/mtk-phy-lib.c
@@ -6,6 +6,69 @@
 
 #include "mtk.h"
 
+/* Difference between functions with mtk_tr* and __mtk_tr* prefixes is
+ * mtk_tr* functions: wrapped by page switching operations
+ * __mtk_tr* functions: no page switching operations
+ */
+
+static void __mtk_tr_access(struct phy_device *phydev, bool read, u8 ch_addr,
+			    u8 node_addr, u8 data_addr)
+{
+	u16 tr_cmd = BIT(15); /* bit 14 & 0 are reserved */
+
+	if (read)
+		tr_cmd |= BIT(13);
+
+	tr_cmd |= (((ch_addr & 0x3) << 11) |
+		   ((node_addr & 0xf) << 7) |
+		   ((data_addr & 0x3f) << 1));
+	dev_dbg(&phydev->mdio.dev, "tr_cmd: 0x%x\n", tr_cmd);
+	__phy_write(phydev, 0x10, tr_cmd);
+}
+
+static void __mtk_tr_read(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+			  u8 data_addr, u16 *tr_high, u16 *tr_low)
+{
+	__mtk_tr_access(phydev, true, ch_addr, node_addr, data_addr);
+	*tr_low = __phy_read(phydev, 0x11);
+	*tr_high = __phy_read(phydev, 0x12);
+	dev_dbg(&phydev->mdio.dev, "tr_high read: 0x%x, tr_low read: 0x%x\n",
+		*tr_high, *tr_low);
+}
+
+static void __mtk_tr_write(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+			   u8 data_addr, u32 tr_data)
+{
+	__phy_write(phydev, 0x11, tr_data & 0xffff);
+	__phy_write(phydev, 0x12, tr_data >> 16);
+	dev_dbg(&phydev->mdio.dev, "tr_high write: 0x%x, tr_low write: 0x%x\n",
+		tr_data >> 16, tr_data & 0xffff);
+	__mtk_tr_access(phydev, false, ch_addr, node_addr, data_addr);
+}
+
+void __mtk_tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		     u8 data_addr, u32 mask, u32 set)
+{
+	u32 tr_data;
+	u16 tr_high;
+	u16 tr_low;
+
+	__mtk_tr_read(phydev, ch_addr, node_addr, data_addr, &tr_high, &tr_low);
+	tr_data = (tr_high << 16) | tr_low;
+	tr_data = (tr_data & ~mask) | set;
+	__mtk_tr_write(phydev, ch_addr, node_addr, data_addr, tr_data);
+}
+EXPORT_SYMBOL_GPL(__mtk_tr_modify);
+
+void mtk_tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		   u8 data_addr, u32 mask, u32 set)
+{
+	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
+	__mtk_tr_modify(phydev, ch_addr, node_addr, data_addr, mask, set);
+	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
+}
+EXPORT_SYMBOL_GPL(mtk_tr_modify);
+
 int mtk_phy_read_page(struct phy_device *phydev)
 {
 	return __phy_read(phydev, MTK_EXT_PAGE_ACCESS);
diff --git a/drivers/net/phy/mediatek/mtk.h b/drivers/net/phy/mediatek/mtk.h
index a888e2e..af44d1a 100644
--- a/drivers/net/phy/mediatek/mtk.h
+++ b/drivers/net/phy/mediatek/mtk.h
@@ -68,6 +68,11 @@ struct mtk_socphy_priv {
 	unsigned long		led_state;
 };
 
+void __mtk_tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		     u8 data_addr, u32 mask, u32 set);
+void mtk_tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		   u8 data_addr, u32 mask, u32 set);
+
 int mtk_phy_read_page(struct phy_device *phydev);
 int mtk_phy_write_page(struct phy_device *phydev, int page);
 
-- 
2.18.0


