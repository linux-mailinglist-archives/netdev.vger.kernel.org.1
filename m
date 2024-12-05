Return-Path: <netdev+bounces-149408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA999E57F9
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CED287770
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265E321CA09;
	Thu,  5 Dec 2024 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sEbxZhc6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3655B219A93;
	Thu,  5 Dec 2024 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406954; cv=none; b=CD5+4/IMWfWD+ZtBPammufQXMawxqQb+X5SmkFMwUtF7NNKe6W49YlGCEflsKnWqueYC3DhAQYSq8FtxT9Al+oZ4LavG4mX7UOCs9YYBHwZC/EymyeEdprwUitA5eK1SxQ4LNp+GW6Q0ywLUlB/9gw8/j04X24Ybxk3vcrlsaBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406954; c=relaxed/simple;
	bh=c4dJ53RsJySMsz7kMEWZUjeKgAty07fq1ceZcGKda+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OI0moIjzFSMasexFFRWwZF5ehIrIlfoc+XP+l49a0X11CfMud1TqzNLthMlakxiotyieK8fT40HwGLm4Qe4AUC1sA1+TqntO9xk60S3WBvv4i+PVGpCO7kfQTTta+7gyhKBrYa8Vxg87PNeqnJYtpbqFcVHfGX/Z7ChW967LjlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sEbxZhc6; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733406952; x=1764942952;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=c4dJ53RsJySMsz7kMEWZUjeKgAty07fq1ceZcGKda+M=;
  b=sEbxZhc62R3XFd1jNxnGgJD5anz62yDsaqcjY9vCn04YdKyh+ny74yKv
   Ca/DRg+4G2zoP2O6FbpeNFvvuvlbXjP880nM6FzZcKJTCLKo2qX/fRTgC
   MEURiiU+zG6HTbNPfmsYsuuMaPM1d5dhe6sgVzME+TkZJ3Gxw3/v6Y0NQ
   Nnj2/dc0IONMZ1EQHETa+KniN1JdNtPdpnZAbA7AqtM47MkXxGloD1VUh
   7kDHrPwmfqTOuDl9dk/uD29NBeIIB8GjgKYdCmQIARMo7nafbFh6ZMaJy
   XqwjXDdQu0whzz0X6yIspfKukZXwu918jWItnZ6kGRvzVGIsQR+t/mbcx
   A==;
X-CSE-ConnectionGUID: k5kzCLZDRxuQzU38z46vlQ==
X-CSE-MsgGUID: nnMupwmrTm2jsX1ZWvZfWA==
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="266373258"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2024 06:55:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Dec 2024 06:55:22 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 5 Dec 2024 06:55:19 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Dec 2024 14:54:24 +0100
Subject: [PATCH net 1/5] net: lan969x: fix cyclic dependency reported by
 depmod
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241205-sparx5-lan969x-misc-fixes-v1-1-575ff3d0b022@microchip.com>
References: <20241205-sparx5-lan969x-misc-fixes-v1-0-575ff3d0b022@microchip.com>
In-Reply-To: <20241205-sparx5-lan969x-misc-fixes-v1-0-575ff3d0b022@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <horatiu.vultur@microchip.com>,
	<arnd@arndb.de>, <jacob.e.keller@intel.com>,
	<Parthiban.Veerasooran@microchip.com>
CC: Calvin Owens <calvin@wbinvd.org>, Muhammad Usama Anjum
	<Usama.Anjum@collabora.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14-dev

Depmod reports a cyclic dependency between modules sparx5-switch.ko and
lan969x-switch.ko:

depmod: ERROR: Cycle detected: lan969x_switch -> sparx5_switch -> lan969x_switch
depmod: ERROR: Found 2 modules in dependency cycles!
make[2]: *** [scripts/Makefile.modinst:132: depmod] Error 1
make: *** [Makefile:224: __sub-make] Error 2

This makes sense, as they both require symbols from each other.

Fix this by compiling lan969x support into the sparx5-switch.ko module.
In order to do this, in a sensible way, we move the lan969x/ dir into
the sparx5/ dir and do some code cleanup of code that is no longer
required.

After this patch, depmod will no longer complain, as lan969x support is
compiled into the sparx5-swicth.ko module, and can no longer be compiled
as a standalone module.

Fixes: 98a01119608d ("net: sparx5: add compatible string for lan969x")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 MAINTAINERS                                                 |  2 +-
 drivers/net/ethernet/microchip/Kconfig                      |  1 -
 drivers/net/ethernet/microchip/Makefile                     |  1 -
 drivers/net/ethernet/microchip/lan969x/Kconfig              |  5 -----
 drivers/net/ethernet/microchip/lan969x/Makefile             | 13 -------------
 drivers/net/ethernet/microchip/sparx5/Kconfig               |  6 ++++++
 drivers/net/ethernet/microchip/sparx5/Makefile              |  6 ++++++
 .../net/ethernet/microchip/{ => sparx5}/lan969x/lan969x.c   |  5 -----
 .../net/ethernet/microchip/{ => sparx5}/lan969x/lan969x.h   |  0
 .../microchip/{ => sparx5}/lan969x/lan969x_calendar.c       |  0
 .../ethernet/microchip/{ => sparx5}/lan969x/lan969x_regs.c  |  0
 .../microchip/{ => sparx5}/lan969x/lan969x_vcap_ag_api.c    |  0
 .../microchip/{ => sparx5}/lan969x/lan969x_vcap_impl.c      |  0
 drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c     |  2 --
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c         |  4 ++--
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c          |  1 -
 16 files changed, 15 insertions(+), 31 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0456a33ef657..991a3c8f2e77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15270,7 +15270,7 @@ M:	Daniel Machon <daniel.machon@microchip.com>
 M:	UNGLinuxDriver@microchip.com
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	drivers/net/ethernet/microchip/lan969x/*
+F:	drivers/net/ethernet/microchip/sparx5/lan969x/*
 
 MICROCHIP LCDFB DRIVER
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index 73832fb2bc32..ee046468652c 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -59,7 +59,6 @@ config LAN743X
 
 source "drivers/net/ethernet/microchip/lan865x/Kconfig"
 source "drivers/net/ethernet/microchip/lan966x/Kconfig"
-source "drivers/net/ethernet/microchip/lan969x/Kconfig"
 source "drivers/net/ethernet/microchip/sparx5/Kconfig"
 source "drivers/net/ethernet/microchip/vcap/Kconfig"
 source "drivers/net/ethernet/microchip/fdma/Kconfig"
diff --git a/drivers/net/ethernet/microchip/Makefile b/drivers/net/ethernet/microchip/Makefile
index 7770df82200f..3c65baed9fd8 100644
--- a/drivers/net/ethernet/microchip/Makefile
+++ b/drivers/net/ethernet/microchip/Makefile
@@ -11,7 +11,6 @@ lan743x-objs := lan743x_main.o lan743x_ethtool.o lan743x_ptp.o
 
 obj-$(CONFIG_LAN865X) += lan865x/
 obj-$(CONFIG_LAN966X_SWITCH) += lan966x/
-obj-$(CONFIG_LAN969X_SWITCH) += lan969x/
 obj-$(CONFIG_SPARX5_SWITCH) += sparx5/
 obj-$(CONFIG_VCAP) += vcap/
 obj-$(CONFIG_FDMA) += fdma/
diff --git a/drivers/net/ethernet/microchip/lan969x/Kconfig b/drivers/net/ethernet/microchip/lan969x/Kconfig
deleted file mode 100644
index c5c6122ae2ec..000000000000
--- a/drivers/net/ethernet/microchip/lan969x/Kconfig
+++ /dev/null
@@ -1,5 +0,0 @@
-config LAN969X_SWITCH
-	bool "Lan969x switch driver"
-	depends on SPARX5_SWITCH
-	help
-	  This driver supports the lan969x family of network switch devices.
diff --git a/drivers/net/ethernet/microchip/lan969x/Makefile b/drivers/net/ethernet/microchip/lan969x/Makefile
deleted file mode 100644
index 316405cbbc71..000000000000
--- a/drivers/net/ethernet/microchip/lan969x/Makefile
+++ /dev/null
@@ -1,13 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for the Microchip lan969x network device drivers.
-#
-
-obj-$(CONFIG_SPARX5_SWITCH) += lan969x-switch.o
-
-lan969x-switch-y := lan969x_regs.o lan969x.o lan969x_calendar.o \
- lan969x_vcap_ag_api.o lan969x_vcap_impl.o
-
-# Provide include files
-ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/fdma
-ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/vcap
diff --git a/drivers/net/ethernet/microchip/sparx5/Kconfig b/drivers/net/ethernet/microchip/sparx5/Kconfig
index 3f04992eace6..35b057c9d0cb 100644
--- a/drivers/net/ethernet/microchip/sparx5/Kconfig
+++ b/drivers/net/ethernet/microchip/sparx5/Kconfig
@@ -24,3 +24,9 @@ config SPARX5_DCB
 	  DSCP and PCP.
 
 	  If unsure, set to Y.
+
+config LAN969X_SWITCH
+	bool "Lan969x switch driver"
+	depends on SPARX5_SWITCH
+	help
+	  This driver supports the lan969x family of network switch devices.
diff --git a/drivers/net/ethernet/microchip/sparx5/Makefile b/drivers/net/ethernet/microchip/sparx5/Makefile
index 3435ca86dd70..4bf2a885a9da 100644
--- a/drivers/net/ethernet/microchip/sparx5/Makefile
+++ b/drivers/net/ethernet/microchip/sparx5/Makefile
@@ -16,6 +16,12 @@ sparx5-switch-y  := sparx5_main.o sparx5_packet.o \
 sparx5-switch-$(CONFIG_SPARX5_DCB) += sparx5_dcb.o
 sparx5-switch-$(CONFIG_DEBUG_FS) += sparx5_vcap_debugfs.o
 
+sparx5-switch-$(CONFIG_LAN969X_SWITCH) += lan969x/lan969x_regs.o \
+					  lan969x/lan969x.o \
+					  lan969x/lan969x_calendar.o \
+					  lan969x/lan969x_vcap_ag_api.o \
+					  lan969x/lan969x_vcap_impl.o
+
 # Provide include files
 ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/vcap
 ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/fdma
diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
similarity index 98%
rename from drivers/net/ethernet/microchip/lan969x/lan969x.c
rename to drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
index ac37d0f74ee3..67463d41d10e 100644
--- a/drivers/net/ethernet/microchip/lan969x/lan969x.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
@@ -346,8 +346,3 @@ const struct sparx5_match_data lan969x_desc = {
 	.consts     = &lan969x_consts,
 	.ops        = &lan969x_ops,
 };
-EXPORT_SYMBOL_GPL(lan969x_desc);
-
-MODULE_DESCRIPTION("Microchip lan969x switch driver");
-MODULE_AUTHOR("Daniel Machon <daniel.machon@microchip.com>");
-MODULE_LICENSE("Dual MIT/GPL");
diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.h b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.h
similarity index 100%
rename from drivers/net/ethernet/microchip/lan969x/lan969x.h
rename to drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.h
diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x_calendar.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_calendar.c
similarity index 100%
rename from drivers/net/ethernet/microchip/lan969x/lan969x_calendar.c
rename to drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_calendar.c
diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x_regs.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c
similarity index 100%
rename from drivers/net/ethernet/microchip/lan969x/lan969x_regs.c
rename to drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c
diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x_vcap_ag_api.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_vcap_ag_api.c
similarity index 100%
rename from drivers/net/ethernet/microchip/lan969x/lan969x_vcap_ag_api.c
rename to drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_vcap_ag_api.c
diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x_vcap_impl.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_vcap_impl.c
similarity index 100%
rename from drivers/net/ethernet/microchip/lan969x/lan969x_vcap_impl.c
rename to drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_vcap_impl.c
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
index 5fe941c66c17..5c46d81de530 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
@@ -98,7 +98,6 @@ u32 sparx5_cal_speed_to_value(enum sparx5_cal_bw speed)
 	default: return 0;
 	}
 }
-EXPORT_SYMBOL_GPL(sparx5_cal_speed_to_value);
 
 static u32 sparx5_bandwidth_to_calendar(u32 bw)
 {
@@ -150,7 +149,6 @@ enum sparx5_cal_bw sparx5_get_port_cal_speed(struct sparx5 *sparx5, u32 portno)
 		return SPX5_CAL_SPEED_NONE;
 	return sparx5_bandwidth_to_calendar(port->conf.bandwidth);
 }
-EXPORT_SYMBOL_GPL(sparx5_get_port_cal_speed);
 
 /* Auto configure the QSYS calendar based on port configuration */
 int sparx5_config_auto_calendar(struct sparx5 *sparx5)
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 2f1013f870fb..2b58fcb9422e 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -24,7 +24,7 @@
 #include <linux/types.h>
 #include <linux/reset.h>
 
-#include "../lan969x/lan969x.h" /* for lan969x match data */
+#include "lan969x/lan969x.h" /* for lan969x match data */
 
 #include "sparx5_main_regs.h"
 #include "sparx5_main.h"
@@ -1093,7 +1093,7 @@ static const struct sparx5_match_data sparx5_desc = {
 
 static const struct of_device_id mchp_sparx5_match[] = {
 	{ .compatible = "microchip,sparx5-switch", .data = &sparx5_desc },
-#if IS_ENABLED(CONFIG_LAN969X_SWITCH)
+#ifdef CONFIG_LAN969X_SWITCH
 	{ .compatible = "microchip,lan9691-switch", .data = &lan969x_desc },
 #endif
 	{ }
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
index 1c2903700a9c..2f168700f63c 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
@@ -303,7 +303,6 @@ void sparx5_get_hwtimestamp(struct sparx5 *sparx5,
 
 	spin_unlock_irqrestore(&sparx5->ptp_clock_lock, flags);
 }
-EXPORT_SYMBOL_GPL(sparx5_get_hwtimestamp);
 
 irqreturn_t sparx5_ptp_irq_handler(int irq, void *args)
 {

-- 
2.34.1


