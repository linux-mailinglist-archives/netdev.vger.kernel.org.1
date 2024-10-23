Return-Path: <netdev+bounces-138416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4CD9AD72F
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 00:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7082847FB
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 22:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A76200117;
	Wed, 23 Oct 2024 22:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RJQEAorj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1711E1311;
	Wed, 23 Oct 2024 22:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720929; cv=none; b=tlQCXshAQYAtMXP7Rn5RKFauzEHlO8ZZB2hvLCmrdyKpw5l2xlyPBJDfVq7m3vqtS0qiNbe2jJND5Essv3p0Kas+VGH6Hd24NG8OJnTa0OdwQysLME1BG6sbfPbezaEJLmqS64QdL6+CyrKYyGryPMlV3qGfP3saAXyQVNUNVEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720929; c=relaxed/simple;
	bh=h7HNx+7+r2YLYEnNV5Pxpm3+fCQInXzD8LqlQEeCuoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XE+05vbYRL3XjPyXcb/A87T8m9u0omiZjlsTS0IPTuchRgbw8vBIeDUwgIDisv6VvbxagzdULDItb7CiU0i9MZY/yYN7+VED8OIedfCIu040XYM6KcfDv76g6YUeR93c+LPeUWIwf9xof0dq88/mh7CYOyThbPYQz1fHizKJUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RJQEAorj; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729720927; x=1761256927;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=h7HNx+7+r2YLYEnNV5Pxpm3+fCQInXzD8LqlQEeCuoo=;
  b=RJQEAorjgvbnG7L1213Jr07Qb/uzOil1Dp8L02I5vhin1FuMYpqi31hg
   P7fX6d3cq4B4KyDVodaa2Vq2KXxz20rzeAi0UHs/ZD870y3G02DVhp3an
   CpheU6yBZKSZqu7fBISBVzWfBl3VKmWoh7qOxVYcIMtq+vpbh5SXaY6I2
   4HHsiWCtnMiBn0O7Cc4EJcpUF4jP8Y5MlF5tmo57Iz6JdI3W15zx0m7dj
   tPfvUziE0yRzRxyWuY61v7WJ4Rq2yF/AuettAbp8L2N/aKqweHX6vIcGp
   zWv5dJSQ/5gVnJdWC6CIRCMTDPYTq5ZNnUfm202a8FMnrxZP1pISMkSkq
   w==;
X-CSE-ConnectionGUID: 1Xapdzk8QAqz3uJYdYtrIg==
X-CSE-MsgGUID: sopeB3rDT5m4tF48pmQKWw==
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="33409632"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 15:02:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 23 Oct 2024 15:02:04 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 23 Oct 2024 15:02:00 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 24 Oct 2024 00:01:25 +0200
Subject: [PATCH net-next v2 06/15] net: lan969x: add match data for lan969x
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241024-sparx5-lan969x-switch-driver-2-v2-6-a0b5fae88a0f@microchip.com>
References: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
In-Reply-To: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

Add match data for lan969x, with initial fields for iomap, iomap_size
and ioranges. Add new Kconfig symbol CONFIG_LAN969X_CONFIG for compiling
the lan969x driver.

It has been decided to give lan969x its own Kconfig symbol, as a
considerable amount of code is needed, beside the Sparx5 code, to add
full chip support (and more will be added in future series). Also this
makes it possible to compile Sparx5 without lan969x.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 MAINTAINERS                                      |   7 ++
 drivers/net/ethernet/microchip/Kconfig           |   1 +
 drivers/net/ethernet/microchip/Makefile          |   1 +
 drivers/net/ethernet/microchip/lan969x/Kconfig   |   5 ++
 drivers/net/ethernet/microchip/lan969x/Makefile  |  12 +++
 drivers/net/ethernet/microchip/lan969x/lan969x.c | 104 +++++++++++++++++++++++
 drivers/net/ethernet/microchip/lan969x/lan969x.h |  15 ++++
 7 files changed, 145 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aed1fa42cfd2..c6bc8f111cf0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15188,6 +15188,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
 F:	drivers/irqchip/irq-lan966x-oic.c
 
+MICROCHIP LAN969X ETHERNET DRIVER
+M:	Daniel Machon <daniel.machon@microchip.com>
+M:	UNGLinuxDriver@microchip.com
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/microchip/lan969x/*
+
 MICROCHIP LCDFB DRIVER
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 L:	linux-fbdev@vger.kernel.org
diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index ee046468652c..73832fb2bc32 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -59,6 +59,7 @@ config LAN743X
 
 source "drivers/net/ethernet/microchip/lan865x/Kconfig"
 source "drivers/net/ethernet/microchip/lan966x/Kconfig"
+source "drivers/net/ethernet/microchip/lan969x/Kconfig"
 source "drivers/net/ethernet/microchip/sparx5/Kconfig"
 source "drivers/net/ethernet/microchip/vcap/Kconfig"
 source "drivers/net/ethernet/microchip/fdma/Kconfig"
diff --git a/drivers/net/ethernet/microchip/Makefile b/drivers/net/ethernet/microchip/Makefile
index 3c65baed9fd8..7770df82200f 100644
--- a/drivers/net/ethernet/microchip/Makefile
+++ b/drivers/net/ethernet/microchip/Makefile
@@ -11,6 +11,7 @@ lan743x-objs := lan743x_main.o lan743x_ethtool.o lan743x_ptp.o
 
 obj-$(CONFIG_LAN865X) += lan865x/
 obj-$(CONFIG_LAN966X_SWITCH) += lan966x/
+obj-$(CONFIG_LAN969X_SWITCH) += lan969x/
 obj-$(CONFIG_SPARX5_SWITCH) += sparx5/
 obj-$(CONFIG_VCAP) += vcap/
 obj-$(CONFIG_FDMA) += fdma/
diff --git a/drivers/net/ethernet/microchip/lan969x/Kconfig b/drivers/net/ethernet/microchip/lan969x/Kconfig
new file mode 100644
index 000000000000..728180d3fa33
--- /dev/null
+++ b/drivers/net/ethernet/microchip/lan969x/Kconfig
@@ -0,0 +1,5 @@
+config LAN969X_SWITCH
+	tristate "Lan969x switch driver"
+	depends on SPARX5_SWITCH
+	help
+	  This driver supports the lan969x family of network switch devices.
diff --git a/drivers/net/ethernet/microchip/lan969x/Makefile b/drivers/net/ethernet/microchip/lan969x/Makefile
new file mode 100644
index 000000000000..f3d9dfcd8c30
--- /dev/null
+++ b/drivers/net/ethernet/microchip/lan969x/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the Microchip lan969x network device drivers.
+#
+
+obj-$(CONFIG_LAN969X_SWITCH) += lan969x-switch.o
+
+lan969x-switch-y := lan969x.o
+
+# Provide include files
+ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/fdma
+ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/vcap
diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.c b/drivers/net/ethernet/microchip/lan969x/lan969x.c
new file mode 100644
index 000000000000..488af2a8ee3c
--- /dev/null
+++ b/drivers/net/ethernet/microchip/lan969x/lan969x.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Microchip lan969x Switch driver
+ *
+ * Copyright (c) 2024 Microchip Technology Inc. and its subsidiaries.
+ */
+
+#include "lan969x.h"
+
+static const struct sparx5_main_io_resource lan969x_main_iomap[] =  {
+	{ TARGET_CPU,                   0xc0000, 0 }, /* 0xe00c0000 */
+	{ TARGET_FDMA,                  0xc0400, 0 }, /* 0xe00c0400 */
+	{ TARGET_GCB,                 0x2010000, 1 }, /* 0xe2010000 */
+	{ TARGET_QS,                  0x2030000, 1 }, /* 0xe2030000 */
+	{ TARGET_PTP,                 0x2040000, 1 }, /* 0xe2040000 */
+	{ TARGET_ANA_ACL,             0x2050000, 1 }, /* 0xe2050000 */
+	{ TARGET_LRN,                 0x2060000, 1 }, /* 0xe2060000 */
+	{ TARGET_VCAP_SUPER,          0x2080000, 1 }, /* 0xe2080000 */
+	{ TARGET_QSYS,                0x20a0000, 1 }, /* 0xe20a0000 */
+	{ TARGET_QFWD,                0x20b0000, 1 }, /* 0xe20b0000 */
+	{ TARGET_XQS,                 0x20c0000, 1 }, /* 0xe20c0000 */
+	{ TARGET_VCAP_ES2,            0x20d0000, 1 }, /* 0xe20d0000 */
+	{ TARGET_VCAP_ES0,            0x20e0000, 1 }, /* 0xe20e0000 */
+	{ TARGET_ANA_AC_POL,          0x2200000, 1 }, /* 0xe2200000 */
+	{ TARGET_QRES,                0x2280000, 1 }, /* 0xe2280000 */
+	{ TARGET_EACL,                0x22c0000, 1 }, /* 0xe22c0000 */
+	{ TARGET_ANA_CL,              0x2400000, 1 }, /* 0xe2400000 */
+	{ TARGET_ANA_L3,              0x2480000, 1 }, /* 0xe2480000 */
+	{ TARGET_ANA_AC_SDLB,         0x2500000, 1 }, /* 0xe2500000 */
+	{ TARGET_HSCH,                0x2580000, 1 }, /* 0xe2580000 */
+	{ TARGET_REW,                 0x2600000, 1 }, /* 0xe2600000 */
+	{ TARGET_ANA_L2,              0x2800000, 1 }, /* 0xe2800000 */
+	{ TARGET_ANA_AC,              0x2900000, 1 }, /* 0xe2900000 */
+	{ TARGET_VOP,                 0x2a00000, 1 }, /* 0xe2a00000 */
+	{ TARGET_DEV2G5,              0x3004000, 1 }, /* 0xe3004000 */
+	{ TARGET_DEV10G,              0x3008000, 1 }, /* 0xe3008000 */
+	{ TARGET_PCS10G_BR,           0x300c000, 1 }, /* 0xe300c000 */
+	{ TARGET_DEV2G5 +  1,         0x3010000, 1 }, /* 0xe3010000 */
+	{ TARGET_DEV2G5 +  2,         0x3014000, 1 }, /* 0xe3014000 */
+	{ TARGET_DEV2G5 +  3,         0x3018000, 1 }, /* 0xe3018000 */
+	{ TARGET_DEV2G5 +  4,         0x301c000, 1 }, /* 0xe301c000 */
+	{ TARGET_DEV10G +  1,         0x3020000, 1 }, /* 0xe3020000 */
+	{ TARGET_PCS10G_BR +  1,      0x3024000, 1 }, /* 0xe3024000 */
+	{ TARGET_DEV2G5 +  5,         0x3028000, 1 }, /* 0xe3028000 */
+	{ TARGET_DEV2G5 +  6,         0x302c000, 1 }, /* 0xe302c000 */
+	{ TARGET_DEV2G5 +  7,         0x3030000, 1 }, /* 0xe3030000 */
+	{ TARGET_DEV2G5 +  8,         0x3034000, 1 }, /* 0xe3034000 */
+	{ TARGET_DEV10G +  2,         0x3038000, 1 }, /* 0xe3038000 */
+	{ TARGET_PCS10G_BR +  2,      0x303c000, 1 }, /* 0xe303c000 */
+	{ TARGET_DEV2G5 +  9,         0x3040000, 1 }, /* 0xe3040000 */
+	{ TARGET_DEV5G,               0x3044000, 1 }, /* 0xe3044000 */
+	{ TARGET_PCS5G_BR,            0x3048000, 1 }, /* 0xe3048000 */
+	{ TARGET_DEV2G5 + 10,         0x304c000, 1 }, /* 0xe304c000 */
+	{ TARGET_DEV2G5 + 11,         0x3050000, 1 }, /* 0xe3050000 */
+	{ TARGET_DEV2G5 + 12,         0x3054000, 1 }, /* 0xe3054000 */
+	{ TARGET_DEV10G +  3,         0x3058000, 1 }, /* 0xe3058000 */
+	{ TARGET_PCS10G_BR +  3,      0x305c000, 1 }, /* 0xe305c000 */
+	{ TARGET_DEV2G5 + 13,         0x3060000, 1 }, /* 0xe3060000 */
+	{ TARGET_DEV5G +  1,          0x3064000, 1 }, /* 0xe3064000 */
+	{ TARGET_PCS5G_BR +  1,       0x3068000, 1 }, /* 0xe3068000 */
+	{ TARGET_DEV2G5 + 14,         0x306c000, 1 }, /* 0xe306c000 */
+	{ TARGET_DEV2G5 + 15,         0x3070000, 1 }, /* 0xe3070000 */
+	{ TARGET_DEV2G5 + 16,         0x3074000, 1 }, /* 0xe3074000 */
+	{ TARGET_DEV10G +  4,         0x3078000, 1 }, /* 0xe3078000 */
+	{ TARGET_PCS10G_BR +  4,      0x307c000, 1 }, /* 0xe307c000 */
+	{ TARGET_DEV2G5 + 17,         0x3080000, 1 }, /* 0xe3080000 */
+	{ TARGET_DEV5G +  2,          0x3084000, 1 }, /* 0xe3084000 */
+	{ TARGET_PCS5G_BR +  2,       0x3088000, 1 }, /* 0xe3088000 */
+	{ TARGET_DEV2G5 + 18,         0x308c000, 1 }, /* 0xe308c000 */
+	{ TARGET_DEV2G5 + 19,         0x3090000, 1 }, /* 0xe3090000 */
+	{ TARGET_DEV2G5 + 20,         0x3094000, 1 }, /* 0xe3094000 */
+	{ TARGET_DEV10G +  5,         0x3098000, 1 }, /* 0xe3098000 */
+	{ TARGET_PCS10G_BR +  5,      0x309c000, 1 }, /* 0xe309c000 */
+	{ TARGET_DEV2G5 + 21,         0x30a0000, 1 }, /* 0xe30a0000 */
+	{ TARGET_DEV5G +  3,          0x30a4000, 1 }, /* 0xe30a4000 */
+	{ TARGET_PCS5G_BR +  3,       0x30a8000, 1 }, /* 0xe30a8000 */
+	{ TARGET_DEV2G5 + 22,         0x30ac000, 1 }, /* 0xe30ac000 */
+	{ TARGET_DEV2G5 + 23,         0x30b0000, 1 }, /* 0xe30b0000 */
+	{ TARGET_DEV2G5 + 24,         0x30b4000, 1 }, /* 0xe30b4000 */
+	{ TARGET_DEV10G +  6,         0x30b8000, 1 }, /* 0xe30b8000 */
+	{ TARGET_PCS10G_BR +  6,      0x30bc000, 1 }, /* 0xe30bc000 */
+	{ TARGET_DEV2G5 + 25,         0x30c0000, 1 }, /* 0xe30c0000 */
+	{ TARGET_DEV10G +  7,         0x30c4000, 1 }, /* 0xe30c4000 */
+	{ TARGET_PCS10G_BR +  7,      0x30c8000, 1 }, /* 0xe30c8000 */
+	{ TARGET_DEV2G5 + 26,         0x30cc000, 1 }, /* 0xe30cc000 */
+	{ TARGET_DEV10G +  8,         0x30d0000, 1 }, /* 0xe30d0000 */
+	{ TARGET_PCS10G_BR +  8,      0x30d4000, 1 }, /* 0xe30d4000 */
+	{ TARGET_DEV2G5 + 27,         0x30d8000, 1 }, /* 0xe30d8000 */
+	{ TARGET_DEV10G +  9,         0x30dc000, 1 }, /* 0xe30dc000 */
+	{ TARGET_PCS10G_BR +  9,      0x30e0000, 1 }, /* 0xe30e0000 */
+	{ TARGET_DSM,                 0x30ec000, 1 }, /* 0xe30ec000 */
+	{ TARGET_PORT_CONF,           0x30f0000, 1 }, /* 0xe30f0000 */
+	{ TARGET_ASM,                 0x3200000, 1 }, /* 0xe3200000 */
+};
+
+const struct sparx5_match_data lan969x_desc = {
+	.iomap      = lan969x_main_iomap,
+	.iomap_size = ARRAY_SIZE(lan969x_main_iomap),
+	.ioranges   = 2,
+};
+EXPORT_SYMBOL_GPL(lan969x_desc);
+
+MODULE_DESCRIPTION("Microchip lan969x switch driver");
+MODULE_AUTHOR("Daniel Machon <daniel.machon@microchip.com>");
+MODULE_LICENSE("Dual MIT/GPL");
diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.h b/drivers/net/ethernet/microchip/lan969x/lan969x.h
new file mode 100644
index 000000000000..0507046ab9af
--- /dev/null
+++ b/drivers/net/ethernet/microchip/lan969x/lan969x.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Microchip lan969x Switch driver
+ *
+ * Copyright (c) 2024 Microchip Technology Inc. and its subsidiaries.
+ */
+
+#ifndef __LAN969X_H__
+#define __LAN969X_H__
+
+#include "../sparx5/sparx5_main.h"
+
+/* lan969x.c */
+extern const struct sparx5_match_data lan969x_desc;
+
+#endif

-- 
2.34.1


