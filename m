Return-Path: <netdev+bounces-165881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49599A339AB
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0045D3A99EA
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0786E20B209;
	Thu, 13 Feb 2025 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MYMcrcHZ"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017DE20AF78;
	Thu, 13 Feb 2025 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739434099; cv=none; b=pQJjliOqz2662Q4un1v8iETtMEctwTwCX2VdyIMZBvt2vazlx6JuhSp4KRWZIIBCGX4AUHztK0GMa0M+8DXYZlemxu6JZo+4hlza1F7m/bGapKCVNyytEf0M3k/DK+R6E3V1NgivAt9ZuuHxyp2FqhVvsK6u/K6dM0EsxMyfmtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739434099; c=relaxed/simple;
	bh=A+GakrkYCeio4AYShDmbeSqhFCD5I00uj2Hb3kKTyUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCUdukquxaHUUfHvO6rVdkRMFMCFvL8Vz8jhvJqcGECGKrq+dMQbMaNPw/R1gKAOr0Gju9nH5Tov99ezc3wYGyGKkq/469DvPo13xcqQvEzWSzLfnb64VVB6UsAacwfLR0g0b6H2ovs9L6gc5Hvv4Hzm7PACZ/6Mx7uRAUxPqVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MYMcrcHZ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: aa464c74e9e111efb8f9918b5fc74e19-20250213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3LBg5K2ayD03vvfcfNmPl2D8Cz1d3B7W7uuos2fbXzc=;
	b=MYMcrcHZGm6qs0rReeW6ZUxG4r1nDQEOuOA9A4FdKHbSdDYBkXbuaV8A9nq2P3baA4iMI4yr2OClXNTZUbC4q4qWpMI1It21uY4dEDQUYR/zI/x1bU76g2PsGlnozjVxGlzXzD28uHQ/HYTIIEHqQqDG0IrTSmR/QxqJLJpE1WA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:a3b8ad73-925b-4564-90da-22b88fb6df7d,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:60aa074,CLOUDID:86358227-6332-4494-ac76-ecdca2a41930,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:1,
	IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: aa464c74e9e111efb8f9918b5fc74e19-20250213
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 44140218; Thu, 13 Feb 2025 16:08:10 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 13 Feb 2025 16:08:09 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 13 Feb 2025 16:08:09 +0800
From: Sky Huang <SkyLake.Huang@mediatek.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Golle
	<daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>, SkyLake Huang
	<SkyLake.Huang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Simon
 Horman" <horms@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
CC: Steven Liu <Steven.Liu@mediatek.com>, Sky Huang
	<skylake.huang@mediatek.com>
Subject: [PATCH net-next v2 4/5] net: phy: mediatek: Add token ring clear bit operation support
Date: Thu, 13 Feb 2025 16:05:52 +0800
Message-ID: <20250213080553.921434-5-SkyLake.Huang@mediatek.com>
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

Similar to __mtk_tr_set_bits() support. Previously in mtk-ge-soc.c,
we clear some register bits via token ring, which were also implemented
in three __phy_write(). Now we can do the same thing via
__mtk_tr_clr_bits() helper.

Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
---
 drivers/net/phy/mediatek/mtk-ge-soc.c  | 30 +++++++++++++++-----------
 drivers/net/phy/mediatek/mtk-phy-lib.c |  7 ++++++
 drivers/net/phy/mediatek/mtk.h         |  2 ++
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index b7bd3e3..56962aa 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -76,6 +76,10 @@
 /* FfeUpdGainForce */
 #define FFE_UPDATE_GAIN_FORCE			BIT(6)
 
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x3 */
+/* TrFreeze */
+#define TR_FREEZE_MASK				GENMASK(11, 0)
+
 /* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x6 */
 /* SS: Steady-state, KP: Proportional Gain */
 /* SSTrKp100 */
@@ -91,6 +95,11 @@
 /* SSTrKf1000Slv */
 #define SS_TR_KF1000_SLAVE_MASK			GENMASK(6, 4)
 
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x8 */
+/* clear this bit if wanna select from AFE */
+/* Regsigdet_sel_1000 */
+#define EEE1000_SELECT_SIGNAL_DETECTION_FROM_DFE	BIT(4)
+
 /* ch_addr = 0x2, node_addr = 0xd, data_addr = 0xd */
 /* RegEEE_st2TrKf1000 */
 #define EEE1000_STAGE2_TR_KF_MASK		GENMASK(13, 11)
@@ -113,6 +122,10 @@
 /* RegEEE100Stg1_tar */
 #define EEE100_LPSYNC_STAGE1_UPDATE_TIMER_MASK	GENMASK(8, 0)
 
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x25 */
+/* REGEEE_wake_slv_tr_wait_dfesigdet_en */
+#define WAKE_SLAVE_TR_WAIT_DFE_DETECTION_EN	BIT(11)
+
 #define ANALOG_INTERNAL_OPERATION_MAX_US	20
 #define TXRESERVE_MIN				0
 #define TXRESERVE_MAX				7
@@ -805,10 +818,7 @@ static void mt798x_phy_common_finetune(struct phy_device *phydev)
 			FIELD_PREP(FFE_UPDATE_GAIN_FORCE_VAL_MASK, 0x4) |
 				   FFE_UPDATE_GAIN_FORCE);
 
-	/* TrFreeze = 0 (mt7988 default) */
-	__phy_write(phydev, 0x11, 0x0);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x9686);
+	__mtk_tr_clr_bits(phydev, 0x2, 0xd, 0x3, TR_FREEZE_MASK);
 
 	__mtk_tr_modify(phydev, 0x2, 0xd, 0x6,
 			SS_TR_KP100_MASK | SS_TR_KF100_MASK |
@@ -1009,10 +1019,8 @@ static void mt798x_phy_eee(struct phy_device *phydev)
 			 MTK_PHY_TR_READY_SKIP_AFE_WAKEUP);
 
 	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
-	/* Regsigdet_sel_1000 = 0 */
-	__phy_write(phydev, 0x11, 0xb);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x9690);
+	__mtk_tr_clr_bits(phydev, 0x2, 0xd, 0x8,
+			  EEE1000_SELECT_SIGNAL_DETECTION_FROM_DFE);
 
 	__mtk_tr_modify(phydev, 0x2, 0xd, 0xd,
 			EEE1000_STAGE2_TR_KF_MASK,
@@ -1036,10 +1044,8 @@ static void mt798x_phy_eee(struct phy_device *phydev)
 			FIELD_PREP(EEE100_LPSYNC_STAGE1_UPDATE_TIMER_MASK,
 				   0x10));
 
-	/* REGEEE_wake_slv_tr_wait_dfesigdet_en = 0 */
-	__phy_write(phydev, 0x11, 0x1463);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x96ca);
+	__mtk_tr_clr_bits(phydev, 0x2, 0xd, 0x25,
+			  WAKE_SLAVE_TR_WAIT_DFE_DETECTION_EN);
 
 	__mtk_tr_modify(phydev, 0x1, 0xf, 0x0,
 			DFE_TAIL_EANBLE_VGA_TRHESH_1000,
diff --git a/drivers/net/phy/mediatek/mtk-phy-lib.c b/drivers/net/phy/mediatek/mtk-phy-lib.c
index df8fdad..dfd0f4e 100644
--- a/drivers/net/phy/mediatek/mtk-phy-lib.c
+++ b/drivers/net/phy/mediatek/mtk-phy-lib.c
@@ -76,6 +76,13 @@ void __mtk_tr_set_bits(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
 }
 EXPORT_SYMBOL_GPL(__mtk_tr_set_bits);
 
+void __mtk_tr_clr_bits(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		       u8 data_addr, u32 clr)
+{
+	__mtk_tr_modify(phydev, ch_addr, node_addr, data_addr, clr, 0);
+}
+EXPORT_SYMBOL_GPL(__mtk_tr_clr_bits);
+
 int mtk_phy_read_page(struct phy_device *phydev)
 {
 	return __phy_read(phydev, MTK_EXT_PAGE_ACCESS);
diff --git a/drivers/net/phy/mediatek/mtk.h b/drivers/net/phy/mediatek/mtk.h
index 2d8e5b9..4e4468d 100644
--- a/drivers/net/phy/mediatek/mtk.h
+++ b/drivers/net/phy/mediatek/mtk.h
@@ -74,6 +74,8 @@ void mtk_tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
 		   u8 data_addr, u32 mask, u32 set);
 void __mtk_tr_set_bits(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
 		       u8 data_addr, u32 set);
+void __mtk_tr_clr_bits(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		       u8 data_addr, u32 clr);
 
 int mtk_phy_read_page(struct phy_device *phydev);
 int mtk_phy_write_page(struct phy_device *phydev, int page);
-- 
2.18.0


