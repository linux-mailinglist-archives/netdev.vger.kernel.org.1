Return-Path: <netdev+bounces-158712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90223A130B9
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 02:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299773A10E8
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 01:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCA128E37;
	Thu, 16 Jan 2025 01:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oPD2+WS8"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA93CA4E;
	Thu, 16 Jan 2025 01:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990625; cv=none; b=ItwvKGOTOI3O5oSaWBiNVH4mOf3yRvANl5RZM6abqT/XAM9KAXTWtl5IGJdXlb08LtpyVanmK1DkHbsTcSXnH1vvfdR37xexDyIji0VDetfy3rcBMZ5+JMtrg2Aei9QVhD6zUOUADa/e03wFl8aRvqYjbHl5afCaYy6RYqVBYWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990625; c=relaxed/simple;
	bh=xSNS1uo5h9DRDbF0AUYX6nSzaqTx996ryRncYkeWbv0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFLprol6KdrKiQsvt/uMNRJBNtyD/SGmwxpcP2NwwDwDzdZ6Uz4Bx/6FrGUOOeUbF8oCXgxGUzEZvZ+w4zE/odINeE18drNVwW0DyhJaFbK1uIW12EZ5mbMStH3Iww58DV2gb2ZQjcPCS90KVZVur8sSLYHQafNaprTBSaILLH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oPD2+WS8; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8332c2c4d3a811ef99858b75a2457dd9-20250116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nUP9M3THZVRCyFSTWbq2674BwZ0HRnKBLtpplxQWnRg=;
	b=oPD2+WS88eyrLXgjEIMxqok9Mh+2vuggQaCoQy5bh9JElm24DRG/WiwNpqP9gdyKgJGH9KBxMqy/9KTXZdu8h5EkEkNn/xoj4xNjyYFgj1mPtyPkqHfoN5GZor+Ak54h17icDly0I1akvUoCTN8W6UNrPRPuRdNEaX6Qa5S29eI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:3c008cb1-6a5b-4b7e-9544-5ebb742cdfc5,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:60aa074,CLOUDID:ef96f337-e11c-4c1a-89f7-e7a032832c40,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:1,
	IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8332c2c4d3a811ef99858b75a2457dd9-20250116
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 876127488; Thu, 16 Jan 2025 09:23:38 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 16 Jan 2025 09:23:36 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 16 Jan 2025 09:23:36 +0800
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
Subject: [PATCH net-next 2/3] net: phy: mediatek: Move some macros to phy-lib for later use
Date: Thu, 16 Jan 2025 09:21:57 +0800
Message-ID: <20250116012159.3816135-3-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250116012159.3816135-1-SkyLake.Huang@mediatek.com>
References: <20250116012159.3816135-1-SkyLake.Huang@mediatek.com>
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

Move some macros to phy-lib because MediaTek's 2.5G built-in
ethernet PHY will also use them.

Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
---
 drivers/net/phy/mediatek/mtk-ge.c | 4 ----
 drivers/net/phy/mediatek/mtk.h    | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
index 79663da..937254a 100644
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
diff --git a/drivers/net/phy/mediatek/mtk.h b/drivers/net/phy/mediatek/mtk.h
index 712a9f0..cda1dc8 100644
--- a/drivers/net/phy/mediatek/mtk.h
+++ b/drivers/net/phy/mediatek/mtk.h
@@ -8,7 +8,11 @@
 #ifndef _MTK_EPHY_H_
 #define _MTK_EPHY_H_
 
+#define MTK_PHY_AUX_CTRL_AND_STATUS		0x14
+#define   MTK_PHY_ENABLE_DOWNSHIFT		BIT(4)
+
 #define MTK_EXT_PAGE_ACCESS			0x1f
+#define MTK_PHY_PAGE_EXTENDED_1			0x0001
 #define MTK_PHY_PAGE_STANDARD			0x0000
 #define MTK_PHY_PAGE_EXTENDED_52B5		0x52b5
 
-- 
2.45.2


