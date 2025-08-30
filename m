Return-Path: <netdev+bounces-218445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE47B3C76E
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 04:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EF25A2962
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A30255222;
	Sat, 30 Aug 2025 02:32:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EA5253958;
	Sat, 30 Aug 2025 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756521172; cv=none; b=nrqMllY5njIxmOwmj22AjYLVeUbBaGG45kaa6k6ajvNQiPOfq/H0G187dUaM8xelOTFWNh9RUJRjuLEGcSZ6PNiyqhB+uGQceDVFSrLh1hwm4Au32JK+lzNTT5X5XdtWj24RiewSADbkbzQlYlL4N1dSK5ilYgI21F5D+jYN8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756521172; c=relaxed/simple;
	bh=iEz7Vc2XCirHyftWHmLWnI9sQAeNWjQtdYaPpZyOH4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvtsQNUN+1VqA8+pucPdhUEpC5qFrPXviE/B6WoJyCTur2IqD6ygwNquUod87r9fR3QYxMiI2C+q7pENgrfCHCgIex2WlA9AMh02UGxsW5hKNuibk+NwZDxE2ahWWwbxbhuo9X3cfHs127xq0FlATzdCIE3E+53mFexZku+7Wis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1usBOX-000000005vA-44Bz;
	Sat, 30 Aug 2025 02:32:46 +0000
Date: Sat, 30 Aug 2025 03:32:42 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v4 1/6] net: dsa: lantiq_gswip: move to dedicated
 folder
Message-ID: <a5923dee9a174501b284dc473bdec9dd89c68de1.1756520811.git.daniel@makrotopia.org>
References: <cover.1756520811.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756520811.git.daniel@makrotopia.org>

Move the lantiq_gswip driver to its own folder and update
MAINTAINERS file accordingly.
This is done ahead of extending the driver to support the MaxLinear
GSW1xx series of standalone switch ICs, which includes adding a bunch
of files.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Hauke Mehrtens <hauke@hauke-m.de>
---
v4: no changes
v3: no changes
v2: move driver to its own folder

 MAINTAINERS                                 | 3 +--
 drivers/net/dsa/Kconfig                     | 8 +-------
 drivers/net/dsa/Makefile                    | 2 +-
 drivers/net/dsa/lantiq/Kconfig              | 7 +++++++
 drivers/net/dsa/lantiq/Makefile             | 1 +
 drivers/net/dsa/{ => lantiq}/lantiq_gswip.c | 0
 drivers/net/dsa/{ => lantiq}/lantiq_gswip.h | 0
 drivers/net/dsa/{ => lantiq}/lantiq_pce.h   | 0
 8 files changed, 11 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/dsa/lantiq/Kconfig
 create mode 100644 drivers/net/dsa/lantiq/Makefile
 rename drivers/net/dsa/{ => lantiq}/lantiq_gswip.c (100%)
 rename drivers/net/dsa/{ => lantiq}/lantiq_gswip.h (100%)
 rename drivers/net/dsa/{ => lantiq}/lantiq_pce.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index bce96dd254b8..e86bdad15919 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13801,8 +13801,7 @@ M:	Hauke Mehrtens <hauke@hauke-m.de>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
-F:	drivers/net/dsa/lantiq_gswip.c
-F:	drivers/net/dsa/lantiq_pce.h
+F:	drivers/net/dsa/lantiq/*
 F:	drivers/net/ethernet/lantiq_xrx200.c
 F:	net/dsa/tag_gswip.c
 
diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 202a35d8d061..4d9af691b989 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -26,13 +26,7 @@ config NET_DSA_LOOP
 
 source "drivers/net/dsa/hirschmann/Kconfig"
 
-config NET_DSA_LANTIQ_GSWIP
-	tristate "Lantiq / Intel GSWIP"
-	depends on HAS_IOMEM
-	select NET_DSA_TAG_GSWIP
-	help
-	  This enables support for the Lantiq / Intel GSWIP 2.1 found in
-	  the xrx200 / VR9 SoC.
+source "drivers/net/dsa/lantiq/Kconfig"
 
 config NET_DSA_MT7530
 	tristate "MediaTek MT7530 and MT7531 Ethernet switch support"
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index 23dbdf1a36a8..c0a534fe6eaf 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -6,7 +6,6 @@ ifdef CONFIG_NET_DSA_LOOP
 obj-$(CONFIG_FIXED_PHY)		+= dsa_loop_bdinfo.o
 endif
 obj-$(CONFIG_NET_DSA_KS8995) 	+= ks8995.o
-obj-$(CONFIG_NET_DSA_LANTIQ_GSWIP) += lantiq_gswip.o
 obj-$(CONFIG_NET_DSA_MT7530)	+= mt7530.o
 obj-$(CONFIG_NET_DSA_MT7530_MDIO) += mt7530-mdio.o
 obj-$(CONFIG_NET_DSA_MT7530_MMIO) += mt7530-mmio.o
@@ -20,6 +19,7 @@ obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM) += vitesse-vsc73xx-platform.o
 obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX_SPI) += vitesse-vsc73xx-spi.o
 obj-y				+= b53/
 obj-y				+= hirschmann/
+obj-y				+= lantiq/
 obj-y				+= microchip/
 obj-y				+= mv88e6xxx/
 obj-y				+= ocelot/
diff --git a/drivers/net/dsa/lantiq/Kconfig b/drivers/net/dsa/lantiq/Kconfig
new file mode 100644
index 000000000000..1cb053c823f7
--- /dev/null
+++ b/drivers/net/dsa/lantiq/Kconfig
@@ -0,0 +1,7 @@
+config NET_DSA_LANTIQ_GSWIP
+	tristate "Lantiq / Intel GSWIP"
+	depends on HAS_IOMEM
+	select NET_DSA_TAG_GSWIP
+	help
+	  This enables support for the Lantiq / Intel GSWIP 2.1 found in
+	  the xrx200 / VR9 SoC.
diff --git a/drivers/net/dsa/lantiq/Makefile b/drivers/net/dsa/lantiq/Makefile
new file mode 100644
index 000000000000..849f85ebebd6
--- /dev/null
+++ b/drivers/net/dsa/lantiq/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_NET_DSA_LANTIQ_GSWIP) += lantiq_gswip.o
diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
similarity index 100%
rename from drivers/net/dsa/lantiq_gswip.c
rename to drivers/net/dsa/lantiq/lantiq_gswip.c
diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
similarity index 100%
rename from drivers/net/dsa/lantiq_gswip.h
rename to drivers/net/dsa/lantiq/lantiq_gswip.h
diff --git a/drivers/net/dsa/lantiq_pce.h b/drivers/net/dsa/lantiq/lantiq_pce.h
similarity index 100%
rename from drivers/net/dsa/lantiq_pce.h
rename to drivers/net/dsa/lantiq/lantiq_pce.h
-- 
2.51.0

