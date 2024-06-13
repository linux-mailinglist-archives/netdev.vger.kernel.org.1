Return-Path: <netdev+bounces-103172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE936906A3F
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A7B281808
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 10:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3101422DA;
	Thu, 13 Jun 2024 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CefDZgPn"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D741411E1;
	Thu, 13 Jun 2024 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718275400; cv=none; b=TXaiOT5KkELBMB4aRbZ1hxU8hYF4ez7j6jayEQEthD1gQ3t/l75UHx0dfF4c/vc7dKjXWYbNnhl4F7jbxS/6z4KiGJG2/XY69+W5vDKsds5YJkEG26QJLF6HgJq+q4daSKpZ85km6qsPdmGTw8VbGC0ujoZMNjAHyFcMcYYdJLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718275400; c=relaxed/simple;
	bh=lKtiTd0vIsgtLaiudup0TwEV55d823MNZ9uQ4YWf1lM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHkkZ7VXMmaMDGxYlA/XrW/loFkPEEe4cH0/aSWHdsKWPYar5X7DDRQ/NFiCNO6AQek0ds3EAgQUGboAaP89S9MhJlyvQVySmSZC6t4Mf85onxCh1WWu3kFxPCCKQz1XSZ0A4vnf0AQ6dqqz4Y4mKYZ2FB2G8MKJQXLYvbO3yVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CefDZgPn; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bb5db2c6297111efa22eafcdcd04c131-20240613
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mAiAvKo+8Rn+1ehmdL2ZDhDKcN/ufMHN9aoY0SSeOgg=;
	b=CefDZgPnur41fQ8BVFXBRkOS+HMuiEpCA4rVkUHONk6F8s+/wNC2+O+KCwynbaQxITv+Zy0WeeBEUZ4vyiW5EwBY7AacIy+VMUQM/NtZb7UnYY0/YQ9o0fQ1987jCStuLkqT2DWqxmHZXs5zkxe1kD1VazfMeMIgLB8qHDyEYgw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:97e061fc-a6a1-46d8-be1a-7d7aea39ac25,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:079d8b88-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: bb5db2c6297111efa22eafcdcd04c131-20240613
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1055135671; Thu, 13 Jun 2024 18:43:12 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 13 Jun 2024 18:43:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 13 Jun 2024 18:43:09 +0800
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
Subject: [PATCH net-next v7 3/5] net: phy: mediatek: Add token ring access helper functions in mtk-phy-lib
Date: Thu, 13 Jun 2024 18:40:21 +0800
Message-ID: <20240613104023.13044-4-SkyLake.Huang@mediatek.com>
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
X-TM-AS-Result: No-10--1.900700-8.000000
X-TMASE-MatchedRID: vBdWhMp3ixWGeTbGWdRz1lZ4U3MrW+XSbd6rGhWOAwRHZg0gWH5yURwA
	lHA73Fsg2TaDGX0BbTsqKG2uOLOgpHsQZsIG1c2HH5YQyOg71ZZUENBIMyKD0Wh2E2Cv64naztm
	/M6qqBLehpPCTjr4O49XMK0bekEoaxz6opuAAUJLbQWbwc1jeYeTWKSbLQnNI4uxAgOavdLnXvK
	BONfUNb/dSLj+k1HfD/4g/vaAOPsaITy3hkRxZnxcwlCqMM4GZJzMLCXovgMMKogmGusPLb1UnQ
	AOplXiGxNmqa55jnknWHcM2GSdXZuU6SuqUlqe6ksHaPaQQRsCYGHHzn8eYZruqk4cq52pzYCEn
	AolpChD9kKG1tPTyO/oAE4xCcIv25VtV90uxxtfCz1ymGcrCUfi4nVERfgwd6T1ArrMwNVoqVjD
	FpgPNd4Y10crKp8t+WBWV0v8HvoIfE8yM4pjsD23U7j2vVURrxEHRux+uk8ifEzJ5hPndGVn9M6
	OH0wif92Du8gpktIXJWuWWUKSEhCoeqeH4KBX1bLL7V0KlZeGt7T2G9qXGOJ3lb078ZXnLCMQwd
	GN4qdBq7dvHKxitcnmVKZusLp922v9OjYWA2uMMswg45VMfPadst5iAforfVlxr1FJij9s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.900700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 21C36BF9DCAB0822DACBFBA3C86AC8AE3B3439420921B52C72155A2B240191A92000:8
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

This patch adda TR(token ring) manipulations and add correct
macro name for those magic numbers. TR is a way to access
proprietary register on page 52b5. Use these helper functions
so we can see which fields we're going to modify/set/clear.

This patch doesn't really change registers' settings but just
enhances readability and maintainability.

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
 drivers/net/phy/mediatek/mtk-ge-soc.c  | 296 ++++++++++++++++---------
 drivers/net/phy/mediatek/mtk-ge.c      |  82 +++++--
 drivers/net/phy/mediatek/mtk-phy-lib.c |  90 ++++++++
 drivers/net/phy/mediatek/mtk.h         |  12 +
 4 files changed, 355 insertions(+), 125 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index fa65e61..e0bbf99 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -24,7 +24,108 @@
 #define MTK_PHY_SMI_DET_ON_THRESH_MASK		GENMASK(13, 8)
 
 #define MTK_PHY_PAGE_EXTENDED_2A30		0x2a30
-#define MTK_PHY_PAGE_EXTENDED_52B5		0x52b5
+
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
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x18 */
+/* EnabRandUpdTrig */
+#define ENABLE_RANDOM_UPDOWN_COUNTER_TRIGGER	BIT(8)
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
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x3 */
+/* TrFreeze */
+#define TR_FREEZE_MASK				GENMASK(11, 0)
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
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x8 */
+/* clear this bit if wanna select from AFE */
+/* Regsigdet_sel_1000 */
+#define EEE1000_SELECT_SIGNEL_DETECTION_FROM_DFE	BIT(4)
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
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x25 */
+/* REGEEE_wake_slv_tr_wait_dfesigdet_en */
+#define WAKE_SLAVE_TR_WAIT_DFE_DETECTION_EN	BIT(11)
+
 
 #define ANALOG_INTERNAL_OPERATION_MAX_US	20
 #define TXRESERVE_MIN				0
@@ -678,40 +779,36 @@ static int tx_vcm_cal_sw(struct phy_device *phydev, u8 rg_txreserve_x)
 static void mt798x_phy_common_finetune(struct phy_device *phydev)
 {
 	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
-	/* SlvDSPreadyTime = 24, MasDSPreadyTime = 24 */
-	__phy_write(phydev, 0x11, 0xc71);
-	__phy_write(phydev, 0x12, 0xc);
-	__phy_write(phydev, 0x10, 0x8fae);
-
-	/* EnabRandUpdTrig = 1 */
-	__phy_write(phydev, 0x11, 0x2f00);
-	__phy_write(phydev, 0x12, 0xe);
-	__phy_write(phydev, 0x10, 0x8fb0);
-
-	/* NormMseLoThresh = 85 */
-	__phy_write(phydev, 0x11, 0x55a0);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x83aa);
-
-	/* FfeUpdGainForce = 1(Enable), FfeUpdGainForceVal = 4 */
-	__phy_write(phydev, 0x11, 0x240);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x9680);
-
-	/* TrFreeze = 0 (mt7988 default) */
-	__phy_write(phydev, 0x11, 0x0);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x9686);
-
-	/* SSTrKp100 = 5 */
-	/* SSTrKf100 = 6 */
-	/* SSTrKp1000Mas = 5 */
-	/* SSTrKf1000Mas = 6 */
-	/* SSTrKp1000Slv = 5 */
-	/* SSTrKf1000Slv = 6 */
-	__phy_write(phydev, 0x11, 0xbaef);
-	__phy_write(phydev, 0x12, 0x2e);
-	__phy_write(phydev, 0x10, 0x968c);
+	__tr_modify(phydev, 0x1, 0xf, 0x17,
+		    SLAVE_DSP_READY_TIME_MASK | MASTER_DSP_READY_TIME_MASK,
+		    FIELD_PREP(SLAVE_DSP_READY_TIME_MASK, 0x18) |
+		    FIELD_PREP(MASTER_DSP_READY_TIME_MASK, 0x18));
+
+	__tr_set_bits(phydev, 0x1, 0xf, 0x18,
+		      ENABLE_RANDOM_UPDOWN_COUNTER_TRIGGER);
+
+	__tr_modify(phydev, 0x0, 0x7, 0x15,
+		    NORMAL_MSE_LO_THRESH_MASK,
+		    FIELD_PREP(NORMAL_MSE_LO_THRESH_MASK, 0x55));
+
+	__tr_modify(phydev, 0x2, 0xd, 0x0,
+		    FFE_UPDATE_GAIN_FORCE_VAL_MASK,
+		    FIELD_PREP(FFE_UPDATE_GAIN_FORCE_VAL_MASK, 0x4) |
+			       FFE_UPDATE_GAIN_FORCE);
+
+	__tr_clr_bits(phydev, 0x2, 0xd, 0x3, TR_FREEZE_MASK);
+
+	__tr_modify(phydev, 0x2, 0xd, 0x6,
+		    SS_TR_KP100_MASK | SS_TR_KF100_MASK |
+		    SS_TR_KP1000_MASTER_MASK | SS_TR_KF1000_MASTER_MASK |
+		    SS_TR_KP1000_SLAVE_MASK | SS_TR_KF1000_SLAVE_MASK,
+		    FIELD_PREP(SS_TR_KP100_MASK, 0x5) |
+		    FIELD_PREP(SS_TR_KF100_MASK, 0x6) |
+		    FIELD_PREP(SS_TR_KP1000_MASTER_MASK, 0x5) |
+		    FIELD_PREP(SS_TR_KF1000_MASTER_MASK, 0x6) |
+		    FIELD_PREP(SS_TR_KP1000_SLAVE_MASK, 0x5) |
+		    FIELD_PREP(SS_TR_KF1000_SLAVE_MASK, 0x6));
+
 	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
 }
 
@@ -734,27 +831,29 @@ static void mt7981_phy_finetune(struct phy_device *phydev)
 	}
 
 	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
-	/* ResetSyncOffset = 6 */
-	__phy_write(phydev, 0x11, 0x600);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x8fc0);
+	__tr_modify(phydev, 0x1, 0xf, 0x20,
+		    RESET_SYNC_OFFSET_MASK,
+		    FIELD_PREP(RESET_SYNC_OFFSET_MASK, 0x6));
 
-	/* VgaDecRate = 1 */
-	__phy_write(phydev, 0x11, 0x4c2a);
-	__phy_write(phydev, 0x12, 0x3e);
-	__phy_write(phydev, 0x10, 0x8fa4);
+	__tr_modify(phydev, 0x1, 0xf, 0x12,
+		    VGA_DECIMATION_RATE_MASK,
+		    FIELD_PREP(VGA_DECIMATION_RATE_MASK, 0x1));
 
 	/* MrvlTrFix100Kp = 3, MrvlTrFix100Kf = 2,
 	 * MrvlTrFix1000Kp = 3, MrvlTrFix1000Kf = 2
 	 */
-	__phy_write(phydev, 0x11, 0xd10a);
-	__phy_write(phydev, 0x12, 0x34);
-	__phy_write(phydev, 0x10, 0x8f82);
+	__tr_modify(phydev, 0x1, 0xf, 0x1,
+		    MRVL_TR_FIX_100KP_MASK | MRVL_TR_FIX_100KF_MASK |
+		    MRVL_TR_FIX_1000KP_MASK | MRVL_TR_FIX_1000KF_MASK,
+		    FIELD_PREP(MRVL_TR_FIX_100KP_MASK, 0x3) |
+		    FIELD_PREP(MRVL_TR_FIX_100KF_MASK, 0x2) |
+		    FIELD_PREP(MRVL_TR_FIX_1000KP_MASK, 0x3) |
+		    FIELD_PREP(MRVL_TR_FIX_1000KF_MASK, 0x2));
 
 	/* VcoSlicerThreshBitsHigh */
-	__phy_write(phydev, 0x11, 0x5555);
-	__phy_write(phydev, 0x12, 0x55);
-	__phy_write(phydev, 0x10, 0x8ec0);
+	__tr_modify(phydev, 0x1, 0xd, 0x20,
+		    VCO_SLICER_THRESH_HIGH_MASK,
+		    FIELD_PREP(VCO_SLICER_THRESH_HIGH_MASK, 0x555555));
 	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
 
 	/* TR_OPEN_LOOP_EN = 1, lpf_x_average = 9 */
@@ -806,25 +905,23 @@ static void mt7988_phy_finetune(struct phy_device *phydev)
 	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_TX_FILTER, 0x5);
 
 	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
-	/* ResetSyncOffset = 5 */
-	__phy_write(phydev, 0x11, 0x500);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x8fc0);
+	__tr_modify(phydev, 0x1, 0xf, 0x20,
+		    RESET_SYNC_OFFSET_MASK,
+		    FIELD_PREP(RESET_SYNC_OFFSET_MASK, 0x5));
 
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
+	__tr_modify(phydev, 0x1, 0xf, 0x1,
+		    MRVL_TR_FIX_100KP_MASK | MRVL_TR_FIX_100KF_MASK |
+		    MRVL_TR_FIX_1000KP_MASK | MRVL_TR_FIX_1000KF_MASK,
+		    FIELD_PREP(MRVL_TR_FIX_100KP_MASK, 0x6) |
+		    FIELD_PREP(MRVL_TR_FIX_100KF_MASK, 0x7) |
+		    FIELD_PREP(MRVL_TR_FIX_1000KP_MASK, 0x6) |
+		    FIELD_PREP(MRVL_TR_FIX_1000KF_MASK, 0x7));
+
+	__tr_modify(phydev, 0x0, 0xf, 0x3c,
+		    REMOTE_ACK_COUNT_LIMIT_CTRL_MASK,
+		    FIELD_PREP(REMOTE_ACK_COUNT_LIMIT_CTRL_MASK, 0x1));
 	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
 
 	/* TR_OPEN_LOOP_EN = 1, lpf_x_average = 10 */
@@ -900,45 +997,36 @@ static void mt798x_phy_eee(struct phy_device *phydev)
 			 MTK_PHY_TR_READY_SKIP_AFE_WAKEUP);
 
 	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
-	/* Regsigdet_sel_1000 = 0 */
-	__phy_write(phydev, 0x11, 0xb);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x9690);
-
-	/* REG_EEE_st2TrKf1000 = 2 */
-	__phy_write(phydev, 0x11, 0x114f);
-	__phy_write(phydev, 0x12, 0x2);
-	__phy_write(phydev, 0x10, 0x969a);
-
-	/* RegEEE_slv_wake_tr_timer_tar = 6, RegEEE_slv_remtx_timer_tar = 20 */
-	__phy_write(phydev, 0x11, 0x3028);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x969e);
-
-	/* RegEEE_slv_wake_int_timer_tar = 8 */
-	__phy_write(phydev, 0x11, 0x5010);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x96a0);
-
-	/* RegEEE_trfreeze_timer2 = 586 */
-	__phy_write(phydev, 0x11, 0x24a);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x96a8);
-
-	/* RegEEE100Stg1_tar = 16 */
-	__phy_write(phydev, 0x11, 0x3210);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x96b8);
-
-	/* REGEEE_wake_slv_tr_wait_dfesigdet_en = 0 */
-	__phy_write(phydev, 0x11, 0x1463);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x96ca);
-
-	/* DfeTailEnableVgaThresh1000 = 27 */
-	__phy_write(phydev, 0x11, 0x36);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x8f80);
+	__tr_clr_bits(phydev, 0x2, 0xd, 0x8,
+		      EEE1000_SELECT_SIGNEL_DETECTION_FROM_DFE);
+
+	__tr_modify(phydev, 0x2, 0xd, 0xd,
+		    EEE1000_STAGE2_TR_KF_MASK,
+		    FIELD_PREP(EEE1000_STAGE2_TR_KF_MASK, 0x2));
+
+	__tr_modify(phydev, 0x2, 0xd, 0xf,
+		    SLAVE_WAKETR_TIMER_MASK | SLAVE_REMTX_TIMER_MASK,
+		    FIELD_PREP(SLAVE_WAKETR_TIMER_MASK, 0x6) |
+		    FIELD_PREP(SLAVE_REMTX_TIMER_MASK, 0x14));
+
+	__tr_modify(phydev, 0x2, 0xd, 0x10,
+		    SLAVE_WAKEINT_TIMER_MASK,
+		    FIELD_PREP(SLAVE_WAKEINT_TIMER_MASK, 0x8));
+
+	__tr_modify(phydev, 0x2, 0xd, 0x14,
+		    TR_FREEZE_TIMER2_MASK,
+		    FIELD_PREP(TR_FREEZE_TIMER2_MASK, 0x24a));
+
+	__tr_modify(phydev, 0x2, 0xd, 0x1c,
+		    EEE100_LPSYNC_STAGE1_UPDATE_TIMER_MASK,
+		    FIELD_PREP(EEE100_LPSYNC_STAGE1_UPDATE_TIMER_MASK, 0x10));
+
+	__tr_clr_bits(phydev, 0x2, 0xd, 0x25,
+		      WAKE_SLAVE_TR_WAIT_DFE_DETECTION_EN);
+
+	__tr_modify(phydev, 0x1, 0xf, 0x0,
+		    DFE_TAIL_EANBLE_VGA_TRHESH_1000,
+		    FIELD_PREP(DFE_TAIL_EANBLE_VGA_TRHESH_1000, 0x1b));
 	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
 
 	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_3);
diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
index 4022f98..bd907c1 100644
--- a/drivers/net/phy/mediatek/mtk-ge.c
+++ b/drivers/net/phy/mediatek/mtk-ge.c
@@ -8,13 +8,35 @@
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
+/* Registers on Token Ring debug nodes */
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x17 */
+#define SLAVE_DSP_READY_TIME_MASK		GENMASK(22, 15)
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
 
 struct mtk_gephy_priv {
 	unsigned long		led_state;
@@ -23,20 +45,29 @@ struct mtk_gephy_priv {
 static void mtk_gephy_config_init(struct phy_device *phydev)
 {
 	/* Enable HW auto downshift */
-	phy_modify_paged(phydev, MTK_PHY_PAGE_EXTENDED, 0x14, 0, BIT(4));
+	phy_modify_paged(phydev, MTK_PHY_PAGE_EXTENDED_1,
+			 MTK_PHY_AUX_CTRL_AND_STATUS,
+			 0, MTK_PHY_ENABLE_DOWNSHIFT);
 
 	/* Increase SlvDPSready time */
-	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
-	__phy_write(phydev, 0x10, 0xafae);
-	__phy_write(phydev, 0x12, 0x2f);
-	__phy_write(phydev, 0x10, 0x8fae);
-	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
+	tr_modify(phydev, 0x1, 0xf, 0x17, SLAVE_DSP_READY_TIME_MASK,
+		  FIELD_PREP(SLAVE_DSP_READY_TIME_MASK, 0x5e));
 
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
@@ -44,7 +75,8 @@ static int mt7530_phy_config_init(struct phy_device *phydev)
 	mtk_gephy_config_init(phydev);
 
 	/* Increase post_update_timer */
-	phy_write_paged(phydev, MTK_PHY_PAGE_EXTENDED_3, 0x11, 0x4b);
+	phy_write_paged(phydev, MTK_PHY_PAGE_EXTENDED_3,
+			MTK_PHY_RG_LPI_PCS_DSP_CTRL_REG11, 0x4b);
 
 	return 0;
 }
@@ -55,11 +87,19 @@ static int mt7531_phy_config_init(struct phy_device *phydev)
 
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
diff --git a/drivers/net/phy/mediatek/mtk-phy-lib.c b/drivers/net/phy/mediatek/mtk-phy-lib.c
index d892f94..c51c9d8 100644
--- a/drivers/net/phy/mediatek/mtk-phy-lib.c
+++ b/drivers/net/phy/mediatek/mtk-phy-lib.c
@@ -6,6 +6,96 @@
 
 #include "mtk.h"
 
+/* Difference between functions with tr* and __tr* prefixes is
+ *   tr* functions: wrapped by page switching operations
+ * __tr* functions: no page switching operations
+ */
+
+static void __tr_access(struct phy_device *phydev, bool read, u8 ch_addr,
+			u8 node_addr, u8 data_addr)
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
+static void __tr_read(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		      u8 data_addr, u16 *tr_high, u16 *tr_low)
+{
+	__tr_access(phydev, true, ch_addr, node_addr, data_addr);
+	*tr_low = __phy_read(phydev, 0x11);
+	*tr_high = __phy_read(phydev, 0x12);
+	dev_dbg(&phydev->mdio.dev, "tr_high read: 0x%x, tr_low read: 0x%x\n",
+		*tr_high, *tr_low);
+}
+
+u32 tr_read(struct phy_device *phydev, u8 ch_addr, u8 node_addr, u8 data_addr)
+{
+	u16 tr_high;
+	u16 tr_low;
+
+	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
+	__tr_read(phydev, ch_addr, node_addr, data_addr, &tr_high, &tr_low);
+	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
+
+	return (tr_high << 16) | tr_low;
+}
+EXPORT_SYMBOL_GPL(tr_read);
+
+static void __tr_write(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		       u8 data_addr, u32 tr_data)
+{
+	__phy_write(phydev, 0x11, tr_data & 0xffff);
+	__phy_write(phydev, 0x12, tr_data >> 16);
+	dev_dbg(&phydev->mdio.dev, "tr_high write: 0x%x, tr_low write: 0x%x\n",
+		tr_data >> 16, tr_data & 0xffff);
+	__tr_access(phydev, false, ch_addr, node_addr, data_addr);
+}
+
+void __tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		 u8 data_addr, u32 mask, u32 set)
+{
+	u32 tr_data;
+	u16 tr_high;
+	u16 tr_low;
+
+	__tr_read(phydev, ch_addr, node_addr, data_addr, &tr_high, &tr_low);
+	tr_data = (tr_high << 16) | tr_low;
+	tr_data = (tr_data & ~mask) | set;
+	__tr_write(phydev, ch_addr, node_addr, data_addr, tr_data);
+}
+EXPORT_SYMBOL_GPL(__tr_modify);
+
+void tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+	       u8 data_addr, u32 mask, u32 set)
+{
+	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
+	__tr_modify(phydev, ch_addr, node_addr, data_addr, mask, set);
+	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
+}
+EXPORT_SYMBOL_GPL(tr_modify);
+
+void __tr_set_bits(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		   u8 data_addr, u32 set)
+{
+	__tr_modify(phydev, ch_addr, node_addr, data_addr, 0, set);
+}
+EXPORT_SYMBOL_GPL(__tr_set_bits);
+
+void __tr_clr_bits(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		   u8 data_addr, u32 clr)
+{
+	__tr_modify(phydev, ch_addr, node_addr, data_addr, clr, 0);
+}
+EXPORT_SYMBOL_GPL(__tr_clr_bits);
+
 int mtk_phy_read_page(struct phy_device *phydev)
 {
 	return __phy_read(phydev, MTK_EXT_PAGE_ACCESS);
diff --git a/drivers/net/phy/mediatek/mtk.h b/drivers/net/phy/mediatek/mtk.h
index 9cc9577..d27226d 100644
--- a/drivers/net/phy/mediatek/mtk.h
+++ b/drivers/net/phy/mediatek/mtk.h
@@ -9,6 +9,8 @@
 #define _MTK_EPHY_H_
 
 #define MTK_EXT_PAGE_ACCESS			0x1f
+#define MTK_PHY_PAGE_STANDARD			0x0000
+#define MTK_PHY_PAGE_EXTENDED_52B5		0x52b5
 
 /* Registers on MDIO_MMD_VEND2 */
 #define MTK_PHY_LED0_ON_CTRL			0x24
@@ -62,6 +64,16 @@
 #define MTK_PHY_LED_STATE_FORCE_BLINK	1
 #define MTK_PHY_LED_STATE_NETDEV	2
 
+u32 tr_read(struct phy_device *phydev, u8 ch_addr, u8 node_addr, u8 data_addr);
+void __tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		 u8 data_addr, u32 mask, u32 set);
+void tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+	       u8 data_addr, u32 mask, u32 set);
+void __tr_set_bits(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		   u8 data_addr, u32 set);
+void __tr_clr_bits(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		   u8 data_addr, u32 clr);
+
 int mtk_phy_read_page(struct phy_device *phydev);
 int mtk_phy_write_page(struct phy_device *phydev, int page);
 
-- 
2.18.0


