Return-Path: <netdev+bounces-131974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE85199011D
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7261D1F21170
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1FF15B10A;
	Fri,  4 Oct 2024 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pGYLcZ8M"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E702155389;
	Fri,  4 Oct 2024 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037506; cv=none; b=PbDOT2qi6dXDdESgj+2dmXhYgF427HQnCUN1qUtHM2zxtc7kCADp59eoB2qintA5/PHDtNwQhvXgqR3d80Ix+JRhiFIJ6OCgwHdqO8odt2ON8DJhjqVQDZJsyaXwCarMeFBiX8FcyRbZbRDzVyDVjcaYsVq33nevhDkCkw1w0eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037506; c=relaxed/simple;
	bh=2CxmeGPH9G/BhOhv+8z2thQL9vTpjp4o2F+LaAijZ3Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kj4BvXpSxhhKEsK4lsnAYV/8HF5iaeC4aNGan5lpWKHh1GsNdcI0XEk74YpGYspvk9QBGTcjvpZRSmGZK18Qs3VgK+3/6FL3SoSwlh+U07iRltxt/1Xu+6JPTjOA+/tdwYYR6KSOFpH5Q6uL+WkoacnXkWJMYaZ4A+A5l4CC/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pGYLcZ8M; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e6efc2b8823a11efb66947d174671e26-20241004
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pK889NC+JGMnKoj8mCe5/OKH9WFMI9XbPoq5xhOMWvI=;
	b=pGYLcZ8MgxzIulym1cNGAJcLd7qDjeT0r50rAm3BvQqy4JYSgEXdmnHRcG5kbnB5nVxpc48dEPTFdqqBxl2BCMC4wb2H1YGtqbPFJyrvQjTX2U/6si3RZQcwoc99g4vkWTINYHGApfBDTeCXUQOgBsa8AL46p66vSvpA8FrG42w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:ab19938d-f550-4b97-b585-de9a8d3d3d21,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6dc6a47,CLOUDID:aae1c040-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e6efc2b8823a11efb66947d174671e26-20241004
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1862989954; Fri, 04 Oct 2024 18:24:56 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 4 Oct 2024 18:24:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 4 Oct 2024 18:24:55 +0800
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
Subject: [PATCH net-next 1/9] net: phy: mediatek: Re-organize MediaTek ethernet phy drivers
Date: Fri, 4 Oct 2024 18:24:05 +0800
Message-ID: <20241004102413.5838-2-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241004102413.5838-1-SkyLake.Huang@mediatek.com>
References: <20241004102413.5838-1-SkyLake.Huang@mediatek.com>
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
some common functions (and add new 2.5G phy driver).
mtk-ge.c: MT7530 Gphy on MT7621 & MT7531 Gphy
mtk-ge-soc.c: Built-in Gphy on MT7981 & Built-in switch Gphy on MT7988
(mtk-2p5ge.c: Planned for built-in 2.5G phy on MT7988
 --> in another patchset)

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
index 0000000..6839ea6
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
+	select NVMEM_MTK_EFUSE
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


