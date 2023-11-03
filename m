Return-Path: <netdev+bounces-45896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD82F7E02FE
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 13:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0081C209E7
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 12:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5CF13AD3;
	Fri,  3 Nov 2023 12:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U81v6V1w"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4502F2F;
	Fri,  3 Nov 2023 12:35:42 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F19184;
	Fri,  3 Nov 2023 05:35:40 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso28738091fa.2;
        Fri, 03 Nov 2023 05:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699014938; x=1699619738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xOIjNHwDhIrchH75GqKOcAkPO2xPGvmXahK1witYqLQ=;
        b=U81v6V1we5SdAULZOaY/D46Gl5cc1Ci3NwvkWMrg3rpPxsfQTeVLx6PjrKQkyLBfYM
         V949jb3INmYDKvpJhvzRfdHzG+vTqBJN0fvGhSbvcSE5evXMAXcmqDfPdQ/fDqlipiMK
         CLLPsvQ0G85dpKI0EdTV7RrwG1LbDHqt6I0VuCmkJMfEC5tf/SHEOF0ukJzU1FhfjIfs
         bSeLRYadzOdp1ru7nXsKEpOH7VrTr1P0FN7TBrKUlTs6uqMuErALjRA8VxvwUMiGCm3o
         jGeWQcOxdOqcUudkpd6s21zVfhEQgqRcU4BHxifVJZqk7j4X0LGU9b6/aECKcnJS5giM
         tbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699014938; x=1699619738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xOIjNHwDhIrchH75GqKOcAkPO2xPGvmXahK1witYqLQ=;
        b=CcavNxbnoJtc1vFGg6srN9wjCASCgPmWQkAx89rEcTTJFWuzu5Yl23+U5Ltr8lbDjr
         J1EhINN98IIVxX43Mw27vuX6fYntekPJg7oBKskZSqJOrxk/+4a2mWDdQj07Tdlnj0HP
         Q4O8Fjy2roxR5u+Pm6GUIFayWI3Gktnr3CzDCdttDlvb/L/XJ6R31IPPuTp1u29osM2S
         QcC4bsVclWr+v7g4DibtrzRdu93Lj/eC/7snqkrYddMXo9RN5VuiR8Q37ylTBlX8smtB
         5zOJbnGUaaIcJdXFjDfyNXkCO4F0MVFEO2Gkm3bHRJjG69kl0b6rcRbaq/O+KzE9/qHx
         fRVQ==
X-Gm-Message-State: AOJu0YzggPuTjTo7wXy/34FeJaPPrPpdCDeqZGNExon1IWDL0KjyBGLm
	TktxeaECSbR0Qh68VP9QvYA=
X-Google-Smtp-Source: AGHT+IFk5WiiMlt6WGzF/0f1ZkmkQo56aWCN5RHiPFzNlLjffmsD/L8x3215C5tzFNC/7zm7U+g+7w==
X-Received: by 2002:a2e:be8b:0:b0:2c5:b3c4:7b17 with SMTP id a11-20020a2ebe8b000000b002c5b3c47b17mr22055378ljr.38.1699014937967;
        Fri, 03 Nov 2023 05:35:37 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id gy14-20020a05600c880e00b00403b63e87f2sm2277014wmb.32.2023.11.03.05.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 05:35:37 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v4 1/4] net: phy: aquantia: move to separate directory
Date: Fri,  3 Nov 2023 13:35:29 +0100
Message-Id: <20231103123532.687-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move aquantia PHY driver to separate driectory in preparation for
firmware loading support to keep things tidy.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v4:
- Keep order for kconfig config
Changes v3:
- Add this patch

 drivers/net/phy/Kconfig                         | 5 +----
 drivers/net/phy/Makefile                        | 6 +-----
 drivers/net/phy/aquantia/Kconfig                | 5 +++++
 drivers/net/phy/aquantia/Makefile               | 6 ++++++
 drivers/net/phy/{ => aquantia}/aquantia.h       | 0
 drivers/net/phy/{ => aquantia}/aquantia_hwmon.c | 0
 drivers/net/phy/{ => aquantia}/aquantia_main.c  | 0
 7 files changed, 13 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/phy/aquantia/Kconfig
 create mode 100644 drivers/net/phy/aquantia/Makefile
 rename drivers/net/phy/{ => aquantia}/aquantia.h (100%)
 rename drivers/net/phy/{ => aquantia}/aquantia_hwmon.c (100%)
 rename drivers/net/phy/{ => aquantia}/aquantia_main.c (100%)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 421d2b62918f..25cfc5ded1da 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -96,10 +96,7 @@ config ADIN1100_PHY
 	  Currently supports the:
 	  - ADIN1100 - Robust,Industrial, Low Power 10BASE-T1L Ethernet PHY
 
-config AQUANTIA_PHY
-	tristate "Aquantia PHYs"
-	help
-	  Currently supports the Aquantia AQ1202, AQ2104, AQR105, AQR405
+source "drivers/net/phy/aquantia/Kconfig"
 
 config AX88796B_PHY
 	tristate "Asix PHYs"
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index c945ed9bd14b..f65e85c91fc1 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -35,11 +35,7 @@ obj-y				+= $(sfp-obj-y) $(sfp-obj-m)
 obj-$(CONFIG_ADIN_PHY)		+= adin.o
 obj-$(CONFIG_ADIN1100_PHY)	+= adin1100.o
 obj-$(CONFIG_AMD_PHY)		+= amd.o
-aquantia-objs			+= aquantia_main.o
-ifdef CONFIG_HWMON
-aquantia-objs			+= aquantia_hwmon.o
-endif
-obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia.o
+obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia/
 obj-$(CONFIG_AT803X_PHY)	+= at803x.o
 obj-$(CONFIG_AX88796B_PHY)	+= ax88796b.o
 obj-$(CONFIG_BCM54140_PHY)	+= bcm54140.o
diff --git a/drivers/net/phy/aquantia/Kconfig b/drivers/net/phy/aquantia/Kconfig
new file mode 100644
index 000000000000..226146417a6a
--- /dev/null
+++ b/drivers/net/phy/aquantia/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config AQUANTIA_PHY
+	tristate "Aquantia PHYs"
+	help
+	  Currently supports the Aquantia AQ1202, AQ2104, AQR105, AQR405
diff --git a/drivers/net/phy/aquantia/Makefile b/drivers/net/phy/aquantia/Makefile
new file mode 100644
index 000000000000..346f350bc084
--- /dev/null
+++ b/drivers/net/phy/aquantia/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+aquantia-objs			+= aquantia_main.o
+ifdef CONFIG_HWMON
+aquantia-objs			+= aquantia_hwmon.o
+endif
+obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia.o
diff --git a/drivers/net/phy/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
similarity index 100%
rename from drivers/net/phy/aquantia.h
rename to drivers/net/phy/aquantia/aquantia.h
diff --git a/drivers/net/phy/aquantia_hwmon.c b/drivers/net/phy/aquantia/aquantia_hwmon.c
similarity index 100%
rename from drivers/net/phy/aquantia_hwmon.c
rename to drivers/net/phy/aquantia/aquantia_hwmon.c
diff --git a/drivers/net/phy/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
similarity index 100%
rename from drivers/net/phy/aquantia_main.c
rename to drivers/net/phy/aquantia/aquantia_main.c
-- 
2.40.1


