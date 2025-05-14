Return-Path: <netdev+bounces-190376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91335AB6948
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 12:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53014A6353
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 10:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77607274668;
	Wed, 14 May 2025 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OUjQoCVK"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A60272E65;
	Wed, 14 May 2025 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747220275; cv=none; b=sfWp60OJcTTd6ggSKypq0Q9GoVJv25BvWf9Wn5GGtO4LBZ+pwYin03hb091Qj0Ee+vsHW9ma3W8lxqy1wQTrgvZRIdr1Hgj7eYxwRG+xSpHvHBXBj0jcMxPBEwPeIPKr/Z9Acg83HdreG5VlMP/LQ9hTlp7T8uSd4qi+qd8Hp3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747220275; c=relaxed/simple;
	bh=EtTDuzZtRgjnMS6W217d5y+YKypcFEPFOMPh6xeQARU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEMszpHzfOKoYes1X1lEMhrgIex2zCqswrAM+Tc1E00BrXdXo/KezF259V9dYPGQ4TgWoZQgHQ6cZujn/1JEO/xnyJwW96QqchsiaWDXHXLfw0qobqZ2jqB0BwT6Y7B+9kZDa0v7zT022r4m0nwTpf6KwYsZZAYlWNfHtFFRGIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OUjQoCVK; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 44b1027e30b211f0813e4fe1310efc19-20250514
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+cKQ+3lzotKN4mEFBqwaY+q0XUCpuo5fqL038dEMJqM=;
	b=OUjQoCVKVhCGzCLhJcgL7BRZRTKpH4nTi2seRUJ7nssgmT4h21mE+ua6IrolWoH0qBoSxrprtqwmNH85IDyXy9DLE4w/F/7jD60Wp/9fuvNKixpvEZqvFzDUhOItGZuNHfH57TzD/mxHhu8NX6vzFcXRNM40IlARW0EPT7qPT6Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:7adaa7a9-e7ca-494a-a1f3-46aa2919e144,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:ea73fabf-eade-4d5b-9f81-31d7b5452436,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 44b1027e30b211f0813e4fe1310efc19-20250514
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 8711607; Wed, 14 May 2025 18:57:46 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 14 May 2025 18:57:43 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 14 May 2025 18:57:43 +0800
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
Subject: [PATCH net-next v3 1/2] net: phy: mediatek: Sort config and file names in Kconfig and Makefile
Date: Wed, 14 May 2025 18:57:37 +0800
Message-ID: <20250514105738.1438421-2-SkyLake.Huang@mediatek.com>
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

Sort config and file names in Kconfig and Makefile in
drivers/net/phy/mediatek/ according to sequence in MAINTAINERS.

Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
---
 drivers/net/phy/mediatek/Kconfig  | 28 ++++++++++++++--------------
 drivers/net/phy/mediatek/Makefile |  2 +-
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
index 4308002bb82c..3abf23e37b4b 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -1,18 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config MTK_NET_PHYLIB
-	tristate
-
-config MEDIATEK_GE_PHY
-	tristate "MediaTek Gigabit Ethernet PHYs"
-	select MTK_NET_PHYLIB
-	help
-	  Supports the MediaTek non-built-in Gigabit Ethernet PHYs.
-
-	  Non-built-in Gigabit Ethernet PHYs include mt7530/mt7531.
-	  You may find mt7530 inside mt7621. This driver shares some
-	  common operations with MediaTek SoC built-in Gigabit
-	  Ethernet PHYs.
-
 config MEDIATEK_GE_SOC_PHY
 	tristate "MediaTek SoC Ethernet PHYs"
 	depends on ARM64 || COMPILE_TEST
@@ -26,3 +12,17 @@ config MEDIATEK_GE_SOC_PHY
 	  the MT7981 and MT7988 SoCs. These PHYs need calibration data
 	  present in the SoCs efuse and will dynamically calibrate VCM
 	  (common-mode voltage) during startup.
+
+config MTK_NET_PHYLIB
+	tristate
+
+config MEDIATEK_GE_PHY
+	tristate "MediaTek Gigabit Ethernet PHYs"
+	select MTK_NET_PHYLIB
+	help
+	  Supports the MediaTek non-built-in Gigabit Ethernet PHYs.
+
+	  Non-built-in Gigabit Ethernet PHYs include mt7530/mt7531.
+	  You may find mt7530 inside mt7621. This driver shares some
+	  common operations with MediaTek SoC built-in Gigabit
+	  Ethernet PHYs.
diff --git a/drivers/net/phy/mediatek/Makefile b/drivers/net/phy/mediatek/Makefile
index 814879d0abe5..ff13205d614f 100644
--- a/drivers/net/phy/mediatek/Makefile
+++ b/drivers/net/phy/mediatek/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)	+= mtk-ge-soc.o
 obj-$(CONFIG_MTK_NET_PHYLIB)		+= mtk-phy-lib.o
 obj-$(CONFIG_MEDIATEK_GE_PHY)		+= mtk-ge.o
-obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)	+= mtk-ge-soc.o
-- 
2.45.2


