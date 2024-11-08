Return-Path: <netdev+bounces-143349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA62B9C2230
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 17:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1170A1C24F92
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E64192B79;
	Fri,  8 Nov 2024 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uVB/Nlqb"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E727A191F8A;
	Fri,  8 Nov 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083725; cv=none; b=TLX/jAX10NKX+5DF4Athm8KK7j0JOKLxV3+lJPr7M+G8SNPG8ALcwWUD1UxFgVxm7immkhZtc6Qc+ByOBRLTFhwxTMTKlKvCi+NrxtTHBuvKHjJCOBxVwDuQgoIXRvv+N4sFxplX+QRdFbZ3FRp9MSoFbbZP2wB15aJLhRvw2zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083725; c=relaxed/simple;
	bh=0Jw2dZszbWMPcJeYJ/nE4x59JRD8d2NTH0bhArOh9is=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0HKPPJWBUZEr/nEAvPtxMiyMnp1Ky4c52N1skXDZrcc112UCFiN5dxh1epr0qWERVzlZyaaEZDqTsyxIYZNYb1Zw4/mnX14lj3gLhVfScy1L8Ycn1OktWhpvMIyzm+IcLMJNmwAIyT48/Ji2Hq+IkcP6u4od7hZ+3l5+dW86xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uVB/Nlqb; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6fe1f83c9def11efb88477ffae1fc7a5-20241109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jXGN3lAhTOiiDdvB/kCVtxfAmSFZnGBeXEnN6Z1wyuQ=;
	b=uVB/NlqbVaKZwgShqCqqQ3LySCETYdc5ExPEeQIykUXDHwreyuqHYQnmBQrPOxkdCX1VfUNfIpLV+tReW/0C7bqS4AVt6Up86SSol9fTrm170N2gjarTgosbVNpmbOmyLY3B3Kcj5nPcZag+x8nk+uqDeA0DDTJGbzipMJHVyoE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:aefc1c54-6fcc-4b06-9134-005fc43ee1b5,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:0792bfca-91e6-4060-9516-6ba489b4e2dc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6fe1f83c9def11efb88477ffae1fc7a5-20241109
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1520346547; Sat, 09 Nov 2024 00:35:17 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 9 Nov 2024 00:35:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 9 Nov 2024 00:35:15 +0800
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
CC: Steven Liu <Steven.Liu@mediatek.com>, SkyLake.Huang
	<skylake.huang@mediatek.com>
Subject: [PATCH net-next v3 1/5] net: phy: mediatek: Re-organize MediaTek ethernet phy drivers
Date: Sat, 9 Nov 2024 00:34:51 +0800
Message-ID: <20241108163455.885-2-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241108163455.885-1-SkyLake.Huang@mediatek.com>
References: <20241108163455.885-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

Re-organize MediaTek ethernet phy driver files and get ready to integrate
some common functions and add new 2.5G phy driver.
mtk-ge.c: MT7530 Gphy on MT7621 & MT7531 Gphy
mtk-ge-soc.c: Built-in Gphy on MT7981 & Built-in switch Gphy on MT7988
mtk-2p5ge.c: Planned for built-in 2.5G phy on MT7988

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
 MAINTAINERS                                   |  4 ++--
 drivers/net/phy/Kconfig                       | 17 +-------------
 drivers/net/phy/Makefile                      |  3 +--
 drivers/net/phy/mediatek/Kconfig              | 22 +++++++++++++++++++
 drivers/net/phy/mediatek/Makefile             |  3 +++
 .../mtk-ge-soc.c}                             |  0
 .../phy/{mediatek-ge.c => mediatek/mtk-ge.c}  |  0
 7 files changed, 29 insertions(+), 20 deletions(-)
 create mode 100644 drivers/net/phy/mediatek/Kconfig
 create mode 100644 drivers/net/phy/mediatek/Makefile
 rename drivers/net/phy/{mediatek-ge-soc.c => mediatek/mtk-ge-soc.c} (100%)
 rename drivers/net/phy/{mediatek-ge.c => mediatek/mtk-ge.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index e291445..6deaf94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13793,8 +13793,8 @@ M:	Qingfang Deng <dqfext@gmail.com>
 M:	SkyLake Huang <SkyLake.Huang@mediatek.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	drivers/net/phy/mediatek-ge-soc.c
-F:	drivers/net/phy/mediatek-ge.c
+F:	drivers/net/phy/mediatek/mtk-ge-soc.c
+F:	drivers/net/phy/mediatek/mtk-ge.c
 F:	drivers/phy/mediatek/phy-mtk-xfi-tphy.c
 
 MEDIATEK I2C CONTROLLER DRIVER
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 1df0595..e0e4b5e 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -251,22 +251,7 @@ config MAXLINEAR_GPHY
 	  Support for the Maxlinear GPY115, GPY211, GPY212, GPY215,
 	  GPY241, GPY245 PHYs.
 
-config MEDIATEK_GE_PHY
-	tristate "MediaTek Gigabit Ethernet PHYs"
-	help
-	  Supports the MediaTek Gigabit Ethernet PHYs.
-
-config MEDIATEK_GE_SOC_PHY
-	tristate "MediaTek SoC Ethernet PHYs"
-	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
-	depends on NVMEM_MTK_EFUSE
-	help
-	  Supports MediaTek SoC built-in Gigabit Ethernet PHYs.
-
-	  Include support for built-in Ethernet PHYs which are present in
-	  the MT7981 and MT7988 SoCs. These PHYs need calibration data
-	  present in the SoCs efuse and will dynamically calibrate VCM
-	  (common-mode voltage) during startup.
+source "drivers/net/phy/mediatek/Kconfig"
 
 config MICREL_PHY
 	tristate "Micrel PHYs"
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 197acfa..de38cbf 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -71,8 +71,7 @@ obj-$(CONFIG_MARVELL_PHY)	+= marvell.o
 obj-$(CONFIG_MARVELL_88Q2XXX_PHY)	+= marvell-88q2xxx.o
 obj-$(CONFIG_MARVELL_88X2222_PHY)	+= marvell-88x2222.o
 obj-$(CONFIG_MAXLINEAR_GPHY)	+= mxl-gpy.o
-obj-$(CONFIG_MEDIATEK_GE_PHY)	+= mediatek-ge.o
-obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)	+= mediatek-ge-soc.o
+obj-y				+= mediatek/
 obj-$(CONFIG_MESON_GXL_PHY)	+= meson-gxl.o
 obj-$(CONFIG_MICREL_KS8995MA)	+= spi_ks8995.o
 obj-$(CONFIG_MICREL_PHY)	+= micrel.o
diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
new file mode 100644
index 0000000..112d9c0
--- /dev/null
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config MEDIATEK_GE_PHY
+	tristate "MediaTek Gigabit Ethernet PHYs"
+	help
+	  Supports the MediaTek non-built-in Gigabit Ethernet PHYs.
+
+	  Non-built-in Gigabit Ethernet PHYs include mt7530/mt7531.
+	  You may find mt7530 inside mt7621. This driver shares some
+	  common operations with MediaTek SoC built-in Gigabit
+	  Ethernet PHYs.
+
+config MEDIATEK_GE_SOC_PHY
+	tristate "MediaTek SoC Ethernet PHYs"
+	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
+	depends on NVMEM_MTK_EFUSE
+	help
+	  Supports MediaTek SoC built-in Gigabit Ethernet PHYs.
+
+	  Include support for built-in Ethernet PHYs which are present in
+	  the MT7981 and MT7988 SoCs. These PHYs need calibration data
+	  present in the SoCs efuse and will dynamically calibrate VCM
+	  (common-mode voltage) during startup.
diff --git a/drivers/net/phy/mediatek/Makefile b/drivers/net/phy/mediatek/Makefile
new file mode 100644
index 0000000..005bde2
--- /dev/null
+++ b/drivers/net/phy/mediatek/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_MEDIATEK_GE_PHY)		+= mtk-ge.o
+obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)	+= mtk-ge-soc.o
diff --git a/drivers/net/phy/mediatek-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
similarity index 100%
rename from drivers/net/phy/mediatek-ge-soc.c
rename to drivers/net/phy/mediatek/mtk-ge-soc.c
diff --git a/drivers/net/phy/mediatek-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
similarity index 100%
rename from drivers/net/phy/mediatek-ge.c
rename to drivers/net/phy/mediatek/mtk-ge.c
-- 
2.45.2


