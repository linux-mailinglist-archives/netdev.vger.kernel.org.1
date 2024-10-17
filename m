Return-Path: <netdev+bounces-136391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5414B9A194A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 05:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FFC1C21027
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 03:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC93F7E0E8;
	Thu, 17 Oct 2024 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VSlA6GYN"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3944F46434;
	Thu, 17 Oct 2024 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729135460; cv=none; b=nho6Xv8hCXcfTFaau/WZ2dGuZrLCpE/f2VN3eBr92nQQRItL6qS/AmM9ncol1dG14S2F+ovfz/ohiU4I2cbwc0fubtyAXahzN3QI5IQbd0mnmWw7D8n5+YCbokzfJ5NSUPq2BuHMp0V+O+EIrbCfrXDrEZ8cEwUyqr9iRwLunLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729135460; c=relaxed/simple;
	bh=NC0s/TO2RBn25Q9K/fc3C4XMAHBk1fPB2DVcxhQZrBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jpwqvn0wIxduoJNF7HB8hebg293cvgx5s9TI+hT3f/uJ6w+IP+tZR/HrwHm+9+0yaUEY9zl7zAYCQNZad19+4HtOURcowGeRsvOpeG6LZ+B8ULe8vx2NHLhFtAS2N5vKERsMrDX1zp1xVfSAhv4gGKvfGYcss09MQWUyaC3JtSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VSlA6GYN; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 47f8b0aa8c3711efbd192953cf12861f-20241017
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=68USvSZu77qzMKozbSicW9caulcy9M9tEmfAfhNd7F0=;
	b=VSlA6GYNP4pKdY90l4iyiN2UwX9xyWu0tYCt2BCvCw3yd8HmNyCsorbuF3P68jH1tG21sjfEpaRHg1Bu8LaLW6v1zTw+aG2+bRPlMW9jzw0A4wb5Mhqc/1J4XHicz0XuUjNuz8ZRbqwUOAFqDIEBnBJ3hc44OQjTczzYtcJjWFQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:c2da1cd9-c9ea-4fce-8682-7f49851b751d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:8481ea06-3d5c-41f6-8d90-a8be388b5b5b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 47f8b0aa8c3711efbd192953cf12861f-20241017
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 829530303; Thu, 17 Oct 2024 11:24:13 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 17 Oct 2024 11:24:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 17 Oct 2024 11:24:10 +0800
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
CC: Steven Liu <Steven.Liu@mediatek.com>, SkyLake.Huang
	<skylake.huang@mediatek.com>
Subject: [PATCH net-next v2 3/3] net: phy: mediatek-ge-soc: Propagate error code correctly in cal_cycle()
Date: Thu, 17 Oct 2024 11:22:13 +0800
Message-ID: <20241017032213.22256-4-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241017032213.22256-1-SkyLake.Huang@mediatek.com>
References: <20241017032213.22256-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.666600-8.000000
X-TMASE-MatchedRID: E1MpS5hJl2mf9SROPcS9xgPZZctd3P4B8JzVOUQUG5wKogmGusPLb4KO
	HgdS51oIrXsnC0Bkz2K9TnZXLseR1h8TzIzimOwPC24oEZ6SpSk6XEE7Yhw4FnRn8zaQo/+MPMM
	1RXgEGV0FW/CNJroz7afHryy2FmoegvZxKPAABDf8y7GIVr9A+A4GheOti5yjN6mpdfdFp0iWSi
	jrUwB5vMGQYFMiVRG5ehcPPz6UzEWlb5ogMngNpHOTEn5IiRSOUASbXCnDmH6UTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.666600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	980CD781AF41FA93E07A9F7F9A7BDAED161D100E5D645F141870E13AEF892F792000:8
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

This patch propagates error code correctly in cal_cycle()
and improve with FIELD_GET().

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
 drivers/net/phy/mediatek-ge-soc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/mediatek-ge-soc.c b/drivers/net/phy/mediatek-ge-soc.c
index 1d7719b..a931832 100644
--- a/drivers/net/phy/mediatek-ge-soc.c
+++ b/drivers/net/phy/mediatek-ge-soc.c
@@ -110,7 +110,7 @@
 #define   MTK_PHY_CR_TX_AMP_OFFSET_D_MASK	GENMASK(6, 0)
 
 #define MTK_PHY_RG_AD_CAL_COMP			0x17a
-#define   MTK_PHY_AD_CAL_COMP_OUT_SHIFT		(8)
+#define   MTK_PHY_AD_CAL_COMP_OUT_MASK		GENMASK(8, 8)
 
 #define MTK_PHY_RG_AD_CAL_CLK			0x17b
 #define   MTK_PHY_DA_CAL_CLK			BIT(0)
@@ -351,8 +351,10 @@ static int cal_cycle(struct phy_device *phydev, int devad,
 
 	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_AD_CALIN,
 			   MTK_PHY_DA_CALIN_FLAG);
-	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_AD_CAL_COMP) >>
-			   MTK_PHY_AD_CAL_COMP_OUT_SHIFT;
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_AD_CAL_COMP);
+	if (ret < 0)
+		return ret;
+	ret = FIELD_GET(MTK_PHY_AD_CAL_COMP_OUT_MASK, ret);
 	phydev_dbg(phydev, "cal_val: 0x%x, ret: %d\n", cal_val, ret);
 
 	return ret;
-- 
2.45.2


