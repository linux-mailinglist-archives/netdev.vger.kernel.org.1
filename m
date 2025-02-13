Return-Path: <netdev+bounces-165880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A65CAA339A9
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382093A1420
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12AA20B1FA;
	Thu, 13 Feb 2025 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="p6mB6vqG"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0346320A5E2;
	Thu, 13 Feb 2025 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739434081; cv=none; b=uCL9qtC1WbXrjIUv5UinxX2hv15c+phGDS4ykjMEP7NikmdRcCSXDJiRO+6doX7H73miwhVADKxkAZgXHDkdJazsXXVm2/iIofXinah7E7ThK9l6mr4s9dTRESBjQXcsEi5HWmJgMuzICn10QocCPs4gWEHuJOrDwerf9ub0Jmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739434081; c=relaxed/simple;
	bh=eHYDUgn1NAfE1RXTRs/ocY/tgOAAHUvVGHMqhY1CDIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qhGFtl2b5tQfgwIbrqtAGecn9IOE0IvAAj/mRJVKekH4scNVIBoBZQ13uCPpYwEHm0y0zW5loj1uowhluvMjpV7MG6XHMxjavxZomUOSSMHIcnB7Tu7Nb3SOPTEo8k/DGU1VPHP3ZDOpHDx3DJVdHCdjAS0u+6P99+pxJUtHylA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=p6mB6vqG; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a078b4e8e9e111efbd192953cf12861f-20250213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=26YmjNwG62Ai1VoB2TZP4oBHj1k46+t5lY3/xow1ns4=;
	b=p6mB6vqGStOCTMcdSksQ3HMVF57CSOmU5UEkUdWzOnCnJGG/ZTAVhfh184SImlT/5yVQpdccHXVsCQbr2o6ZLqq9TQiPbLGift+qHjjokmmBjN2U9/LSb53CoSS+v6kGIVG2f0tSlGo215H2b648ftVDa1E+AxthY2ou01hOsf4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:b18ba03a-c3d2-4a97-986a-1a9f85d5b1e4,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:60aa074,CLOUDID:760b4f8f-637d-4112-88e4-c7792fee6ae2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:1,
	IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a078b4e8e9e111efbd192953cf12861f-20250213
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1717476209; Thu, 13 Feb 2025 16:07:54 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 13 Feb 2025 16:07:52 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 13 Feb 2025 16:07:52 +0800
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
Subject: [PATCH net-next v2 3/5] net: phy: mediatek: Add token ring set bit operation support
Date: Thu, 13 Feb 2025 16:05:51 +0800
Message-ID: <20250213080553.921434-4-SkyLake.Huang@mediatek.com>
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

Previously in mtk-ge-soc.c, we set some register bits via token
ring, which were implemented in three __phy_write().
Now we can do the same thing via __mtk_tr_set_bits() helper.

Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
---
 drivers/net/phy/mediatek/mtk-ge-soc.c  | 10 ++++++----
 drivers/net/phy/mediatek/mtk-phy-lib.c |  7 +++++++
 drivers/net/phy/mediatek/mtk.h         |  2 ++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index ee335f4..b7bd3e3 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -62,6 +62,10 @@
 /* MasDSPreadyTime */
 #define MASTER_DSP_READY_TIME_MASK		GENMASK(14, 7)
 
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x18 */
+/* EnabRandUpdTrig */
+#define ENABLE_RANDOM_UPDOWN_COUNTER_TRIGGER	BIT(8)
+
 /* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x20 */
 /* ResetSyncOffset */
 #define RESET_SYNC_OFFSET_MASK			GENMASK(11, 8)
@@ -789,10 +793,8 @@ static void mt798x_phy_common_finetune(struct phy_device *phydev)
 			FIELD_PREP(SLAVE_DSP_READY_TIME_MASK, 0x18) |
 			FIELD_PREP(MASTER_DSP_READY_TIME_MASK, 0x18));
 
-	/* EnabRandUpdTrig = 1 */
-	__phy_write(phydev, 0x11, 0x2f00);
-	__phy_write(phydev, 0x12, 0xe);
-	__phy_write(phydev, 0x10, 0x8fb0);
+	__mtk_tr_set_bits(phydev, 0x1, 0xf, 0x18,
+			  ENABLE_RANDOM_UPDOWN_COUNTER_TRIGGER);
 
 	__mtk_tr_modify(phydev, 0x0, 0x7, 0x15,
 			NORMAL_MSE_LO_THRESH_MASK,
diff --git a/drivers/net/phy/mediatek/mtk-phy-lib.c b/drivers/net/phy/mediatek/mtk-phy-lib.c
index 7275e4e..df8fdad 100644
--- a/drivers/net/phy/mediatek/mtk-phy-lib.c
+++ b/drivers/net/phy/mediatek/mtk-phy-lib.c
@@ -69,6 +69,13 @@ void mtk_tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
 }
 EXPORT_SYMBOL_GPL(mtk_tr_modify);
 
+void __mtk_tr_set_bits(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		       u8 data_addr, u32 set)
+{
+	__mtk_tr_modify(phydev, ch_addr, node_addr, data_addr, 0, set);
+}
+EXPORT_SYMBOL_GPL(__mtk_tr_set_bits);
+
 int mtk_phy_read_page(struct phy_device *phydev)
 {
 	return __phy_read(phydev, MTK_EXT_PAGE_ACCESS);
diff --git a/drivers/net/phy/mediatek/mtk.h b/drivers/net/phy/mediatek/mtk.h
index af44d1a..2d8e5b9 100644
--- a/drivers/net/phy/mediatek/mtk.h
+++ b/drivers/net/phy/mediatek/mtk.h
@@ -72,6 +72,8 @@ void __mtk_tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
 		     u8 data_addr, u32 mask, u32 set);
 void mtk_tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
 		   u8 data_addr, u32 mask, u32 set);
+void __mtk_tr_set_bits(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		       u8 data_addr, u32 set);
 
 int mtk_phy_read_page(struct phy_device *phydev);
 int mtk_phy_write_page(struct phy_device *phydev, int page);
-- 
2.18.0


