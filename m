Return-Path: <netdev+bounces-58280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A374815B6E
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 20:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5C41C21626
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 19:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2893321B9;
	Sat, 16 Dec 2023 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHQIfkGs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C395321AE;
	Sat, 16 Dec 2023 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c517d0de5so19467665e9.0;
        Sat, 16 Dec 2023 11:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702755918; x=1703360718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cHMPrnFOlq0XLVRgjNwCFvZveNz+6sw2atDyT/zQp0=;
        b=mHQIfkGse2wixlyr3fR8d7TWG3Os1Rb1xF59n3L7xb4AVBysm6Zx3aK28ekWxtH2V6
         z9LWa9/difev4CpCT38gLqVqsPiSCtddAMV63W34w+x0iZoZQM77/ktyffsYBXf3wkT6
         Sw5M0n87gPKmfp/RhPJ3Ru4o2odYb6R7UbcIBtOszl5HeMySSFILsjfxGbJZXpY9tVLA
         ieHMdi00emrpkzDBvAnz30rOQo7ZwgzpL9/a9yhToCvvyxQ+lU06ovS+0TmryqShCzjS
         x2NZWDMDMJyOYzPQieMj3hZLnQ0vHrzAoiLgWC9YdPNUr4SLsUH8YL+4Im3iQot/4OPP
         6XEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702755918; x=1703360718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cHMPrnFOlq0XLVRgjNwCFvZveNz+6sw2atDyT/zQp0=;
        b=Lz6uXThnOavDKJJIGMh4hrKC0DP0DRW6IKulUp7nh9V9lUJTDbsB6c2qx6myw+Xajz
         R9WvhkRsXh6X6oxuwgZJUlYjufF/FTnQ5OQkbqdyJWFnkOn2u4kWxe1VUeqtenlT9ZGQ
         VCoL/aWR1dshQPaxY67wt6KE8JFIq/80YIY2/vikMT/v5AHFDsn06S8Y3lQ3+vcO/gTl
         vNA1L4aD3qLVrMfwfDv0hkEbJc+0YkHbxoDaLKRrpD5cWjhP+ooV+xrvPMjh7APjACvY
         8XSrIHFtT6MM9Hr3lKHYZ3r8KC3nQbG0LHtD5gccp27V282QVHNDZ0Cce48J2y08ih6v
         Cpaw==
X-Gm-Message-State: AOJu0YxqSaxrz393JMhWZIwuQNvhx+Hc+Ubm4M07PYfBrNX/MmL5tA+J
	Oo2qM6RZbHWjlB0kZ7bEVd4=
X-Google-Smtp-Source: AGHT+IHdiP+NKCevG+8oftaaMSAB73pfMu+kVghxLDHcXRfI+SgUiW6mfbdbazPN36Fsbv/gx90cyQ==
X-Received: by 2002:a7b:ce8a:0:b0:40c:6204:d593 with SMTP id q10-20020a7bce8a000000b0040c6204d593mr2653887wmj.185.1702755917951;
        Sat, 16 Dec 2023 11:45:17 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id rg14-20020a1709076b8e00b00a23002c8059sm5211196ejc.70.2023.12.16.11.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 11:45:17 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
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
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng  <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH RFC net-next 2/2] Add the Airoha EN8811H PHY driver
Date: Sat, 16 Dec 2023 20:44:30 +0100
Message-ID: <20231216194432.18963-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231216194432.18963-2-ericwouds@gmail.com>
References: <20231216194432.18963-2-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 * Source originated from airoha's en8811h v1.2.1 driver
 * Moved air_en8811h.h to air_en8811h.c
 * Removed air_pbus_reg_write() as it writes to another device on mdio-bus
 * Load firmware from /lib/firmware/airoha/ instead of /lib/firmware/
 * Moved firmware loading and setup to config_init()
 * Added .get_rate_matching()
 * Use generic phy_read/write() and phy_read/write_mmd()
 * Edited .get_features() to use generic C45 functions
 * Edited .config_aneg() and .read_status() to use a mix of generic C22/C45
 * Use led handling functions from mediatek-ge-soc.c
 * Simplified led handling by storing led rules
 * Cleanup macro definitions
 * Cleanup code to pass checkpatch.pl
 * General code cleanup

 Changes to be committed:
	modified:   drivers/net/phy/Kconfig
	modified:   drivers/net/phy/Makefile
	new file:   drivers/net/phy/air_en8811h.c

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/phy/Kconfig       |    5 +
 drivers/net/phy/Makefile      |    1 +
 drivers/net/phy/air_en8811h.c | 1044 +++++++++++++++++++++++++++++++++
 3 files changed, 1050 insertions(+)
 create mode 100644 drivers/net/phy/air_en8811h.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 107880d13d21..bb89cf57de25 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -409,6 +409,11 @@ config XILINX_GMII2RGMII
 	  the Reduced Gigabit Media Independent Interface(RGMII) between
 	  Ethernet physical media devices and the Gigabit Ethernet controller.
 
+config AIR_EN8811H_PHY
+	tristate "Drivers for Airoha EN8811H 2.5 Gigabit PHY"
+	help
+	  Currently supports the Airoha EN8811H PHY.
+
 endif # PHYLIB
 
 config MICREL_KS8995MA
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index c945ed9bd14b..024a12859e83 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -95,3 +95,4 @@ obj-$(CONFIG_STE10XP)		+= ste10Xp.o
 obj-$(CONFIG_TERANETICS_PHY)	+= teranetics.o
 obj-$(CONFIG_VITESSE_PHY)	+= vitesse.o
 obj-$(CONFIG_XILINX_GMII2RGMII) += xilinx_gmii2rgmii.o
+obj-$(CONFIG_AIR_EN8811H_PHY)   += air_en8811h.o
diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
new file mode 100644
index 000000000000..8f9105aa2c89
--- /dev/null
+++ b/drivers/net/phy/air_en8811h.c
@@ -0,0 +1,1044 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for Airoha Ethernet PHYs
+ *
+ * Currently supporting the EN8811H.
+ *
+ * Limitations of the EN8811H:
+ * - Forced speed (AN off) is not supported by hardware (!00Mbps)
+ * - Hardware does not report link-partner 2500Base-T advertisement
+ *
+ * Source originated from airoha's en8811h.c and en8811h.h v1.2.1
+ *
+ * Copyright (C) 2023 Airoha Technology Corp.
+ */
+
+#include <linux/phy.h>
+#include <linux/firmware.h>
+#include <linux/property.h>
+
+#define EN8811H_PHY_ID		0x03a2a411
+
+#define EN8811H_MD32_DM		"airoha/EthMD32.dm.bin"
+#define EN8811H_MD32_DSP	"airoha/EthMD32.DSP.bin"
+
+#define AIR_FW_ADDR_DM	0x00000000
+#define AIR_FW_ADDR_DSP	0x00100000
+
+/* u16 (WORD) component macros */
+#define MAKEWORD(lo, hi) ((u16)((u8)(lo) | ((u16)(u8)(hi) << 8)))
+
+/* u32 (DWORD) component macros */
+#define LOWORD(d) ((u16)(u32)(d))
+#define HIWORD(d) ((u16)(((u32)(d)) >> 16))
+#define MAKEDWORD(lo, hi) ((u32)((u16)(lo) | ((u32)(u16)(hi) << 16)))
+
+/* MII Registers */
+#define AIR_EXT_PAGE_ACCESS		0x1f
+#define   AIR_PHY_PAGE_STANDARD			0x0000
+#define   AIR_PHY_PAGE_EXTENDED_4		0x0004
+
+/* MII Registers Page 4*/
+#define AIR_PBUS_MODE			0x10
+#define   AIR_PBUS_MODE_ADDR_KEEP		0x0000
+#define   AIR_PBUS_MODE_ADDR_INCR		BIT(15)
+#define AIR_PBUS_WR_ADDR_HIGH		0x11
+#define AIR_PBUS_WR_ADDR_LOW		0x12
+#define AIR_PBUS_WR_DATA_HIGH		0x13
+#define AIR_PBUS_WR_DATA_LOW		0x14
+#define AIR_PBUS_RD_ADDR_HIGH		0x15
+#define AIR_PBUS_RD_ADDR_LOW		0x16
+#define AIR_PBUS_RD_DATA_HIGH		0x17
+#define AIR_PBUS_RD_DATA_LOW		0x18
+
+/* Registers on MDIO_MMD_VEND1 */
+#define EN8811H_PHY_FW_STATUS		0x8009
+#define   EN8811H_PHY_READY			0x02
+
+#define AIR_PHY_VENDORCTL1		0x800c
+#define AIR_PHY_VENDORCTL1_MODE1		0x0
+#define AIR_PHY_VENDORCTL2		0x800d
+#define AIR_PHY_VENDORCTL2_MODE1		0x0
+#define AIR_PHY_VENDORCTL3		0x800e
+#define AIR_PHY_VENDORCTL3_MODE1		0x1101
+#define AIR_PHY_VENDORCTL3_INTCLR		0x1100
+#define AIR_PHY_VENDORCTL4		0x800f
+#define AIR_PHY_VENDORCTL4_MODE1		0x0002
+#define AIR_PHY_VENDORCTL4_INTCLR		0x00e4
+
+/* Registers on MDIO_MMD_VEND2 */
+#define AIR_PHY_LED_BCR			0x021
+#define   AIR_PHY_LED_BCR_MODE_MASK		GENMASK(1, 0)
+#define   AIR_PHY_LED_BCR_TIME_TEST		BIT(2)
+#define   AIR_PHY_LED_BCR_CLK_EN		BIT(3)
+#define   AIR_PHY_LED_BCR_EXT_CTRL		BIT(15)
+
+#define AIR_PHY_LED_DUR_ON		0x022
+
+#define AIR_PHY_LED_DUR_BLINK		0x023
+
+#define AIR_PHY_LED_ON(i)	       (0x024 + ((i) * 2))
+#define   AIR_PHY_LED_ON_MASK			(GENMASK(6, 0) | BIT(8))
+#define   AIR_PHY_LED_ON_LINK1000		BIT(0)
+#define   AIR_PHY_LED_ON_LINK100		BIT(1)
+#define   AIR_PHY_LED_ON_LINK10			BIT(2)
+#define   AIR_PHY_LED_ON_LINKDOWN		BIT(3)
+#define   AIR_PHY_LED_ON_FDX			BIT(4) /* Full duplex */
+#define   AIR_PHY_LED_ON_HDX			BIT(5) /* Half duplex */
+#define   AIR_PHY_LED_ON_FORCE_ON		BIT(6)
+#define   AIR_PHY_LED_ON_LINK2500		BIT(8)
+#define   AIR_PHY_LED_ON_POLARITY		BIT(14)
+#define   AIR_PHY_LED_ON_ENABLE			BIT(15)
+
+#define AIR_PHY_LED_BLINK(i)	       (0x025 + ((i) * 2))
+#define   AIR_PHY_LED_BLINK_1000TX		BIT(0)
+#define   AIR_PHY_LED_BLINK_1000RX		BIT(1)
+#define   AIR_PHY_LED_BLINK_100TX		BIT(2)
+#define   AIR_PHY_LED_BLINK_100RX		BIT(3)
+#define   AIR_PHY_LED_BLINK_10TX		BIT(4)
+#define   AIR_PHY_LED_BLINK_10RX		BIT(5)
+#define   AIR_PHY_LED_BLINK_COLLISION		BIT(6)
+#define   AIR_PHY_LED_BLINK_RX_CRC_ERR		BIT(7)
+#define   AIR_PHY_LED_BLINK_RX_IDLE_ERR		BIT(8)
+#define   AIR_PHY_LED_BLINK_FORCE_BLINK		BIT(9)
+#define   AIR_PHY_LED_BLINK_2500TX		BIT(10)
+#define   AIR_PHY_LED_BLINK_2500RX		BIT(11)
+
+/* Registers on BUCKPBUS */
+
+#define EN8811H_FW_VERSION		0x3b3c
+
+#define EN8811H_SPEED			0x109d4
+#define   EN8811H_SPEED_100			BIT(2)
+#define   EN8811H_SPEED_1000			BIT(3)
+#define   EN8811H_SPEED_2500			BIT(4)
+#define   EN8811H_SPEED_MASK			GENMASK(4, 2)
+
+#define EN8811H_POLARITY		0xca0f8
+#define   EN8811H_POLARITY_TX_NORMAL		BIT(0)
+#define   EN8811H_POLARITY_RX_REVERSE		BIT(1)
+
+#define EN8811H_GPIO_MODE		0xcf8b8
+#define   EN8811H_GPIO_MODE_345			(BIT(3) | BIT(4) | BIT(5))
+
+#define EN8811H_FW_CTRL_1		0x0f0018
+#define   EN8811H_FW_CTRL_1_START		0x0
+#define   EN8811H_FW_CTRL_1_FINISH		0x1
+#define EN8811H_FW_CTRL_2		0x800000
+#define EN8811H_FW_CTRL_2_LOADING		BIT(11)
+
+#define EN8811H_LED_COUNT	3
+
+/* GPIO5  <-> BASE_T_LED0
+ * GPIO4  <-> BASE_T_LED1
+ * GPIO3  <-> BASE_T_LED2
+ *
+ * Default setup suitable for 2 leds connected:
+ *    100M link up triggers led0, only led0 blinking on traffic
+ *   1000M link up triggers led1, only led1 blinking on traffic
+ *   2500M link up triggers led0 and led1, both blinking on traffic
+ * Also suitable for 1 led connected:
+ *     any link up triggers led2
+ */
+#define AIR_DEFAULT_TRIGGER_LED0 (BIT(TRIGGER_NETDEV_LINK_2500) | \
+				  BIT(TRIGGER_NETDEV_LINK_100)  | \
+				  BIT(TRIGGER_NETDEV_RX)        | \
+				  BIT(TRIGGER_NETDEV_TX))
+#define AIR_DEFAULT_TRIGGER_LED1 (BIT(TRIGGER_NETDEV_LINK_2500) | \
+				  BIT(TRIGGER_NETDEV_LINK_1000) | \
+				  BIT(TRIGGER_NETDEV_RX)        | \
+				  BIT(TRIGGER_NETDEV_TX))
+#define AIR_DEFAULT_TRIGGER_LED2  BIT(TRIGGER_NETDEV_LINK)
+
+struct led {
+	unsigned long rules;
+	unsigned long state;
+};
+
+struct en8811h_priv {
+	struct led led[EN8811H_LED_COUNT];
+};
+
+enum {
+	AIR_PHY_LED_STATE_FORCE_ON,
+	AIR_PHY_LED_STATE_FORCE_BLINK,
+};
+
+enum {
+	AIR_PHY_LED_DUR_BLINK_32M,
+	AIR_PHY_LED_DUR_BLINK_64M,
+	AIR_PHY_LED_DUR_BLINK_128M,
+	AIR_PHY_LED_DUR_BLINK_256M,
+	AIR_PHY_LED_DUR_BLINK_512M,
+	AIR_PHY_LED_DUR_BLINK_1024M,
+};
+
+enum {
+	AIR_LED_DISABLE,
+	AIR_LED_ENABLE,
+};
+
+enum {
+	AIR_ACTIVE_LOW,
+	AIR_ACTIVE_HIGH,
+};
+
+enum {
+	AIR_LED_MODE_DISABLE,
+	AIR_LED_MODE_USER_DEFINE,
+};
+
+#define AIR_PHY_LED_DUR_UNIT	1024
+#define AIR_PHY_LED_DUR (AIR_PHY_LED_DUR_UNIT << AIR_PHY_LED_DUR_BLINK_64M)
+
+static const unsigned long en8811h_led_trig = (BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
+					       BIT(TRIGGER_NETDEV_LINK)        |
+					       BIT(TRIGGER_NETDEV_LINK_10)     |
+					       BIT(TRIGGER_NETDEV_LINK_100)    |
+					       BIT(TRIGGER_NETDEV_LINK_1000)   |
+					       BIT(TRIGGER_NETDEV_LINK_2500)   |
+					       BIT(TRIGGER_NETDEV_RX)          |
+					       BIT(TRIGGER_NETDEV_TX));
+
+static int __air_buckpbus_reg_write(struct phy_device *phydev,
+				    u32 pbus_address, u32 pbus_data)
+{
+	int ret;
+
+	ret = __phy_write(phydev, AIR_EXT_PAGE_ACCESS, AIR_PHY_PAGE_EXTENDED_4);
+	if (ret < 0)
+		return ret;
+
+	ret = __phy_write(phydev, AIR_PBUS_MODE, AIR_PBUS_MODE_ADDR_KEEP);
+	if (ret < 0)
+		return ret;
+
+	ret = __phy_write(phydev, AIR_PBUS_WR_ADDR_HIGH, HIWORD(pbus_address));
+	if (ret < 0)
+		return ret;
+
+	ret = __phy_write(phydev, AIR_PBUS_WR_ADDR_LOW,  LOWORD(pbus_address));
+	if (ret < 0)
+		return ret;
+
+	ret = __phy_write(phydev, AIR_PBUS_WR_DATA_HIGH, HIWORD(pbus_data));
+	if (ret < 0)
+		return ret;
+
+	ret = __phy_write(phydev, AIR_PBUS_WR_DATA_LOW,  LOWORD(pbus_data));
+	if (ret < 0)
+		return ret;
+
+	ret = __phy_write(phydev, AIR_EXT_PAGE_ACCESS, AIR_PHY_PAGE_STANDARD);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int air_buckpbus_reg_write(struct phy_device *phydev,
+				  u32 pbus_address, u32 pbus_data)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+	ret = __air_buckpbus_reg_write(phydev, pbus_address, pbus_data);
+	phy_unlock_mdio_bus(phydev);
+
+	if (ret < 0)
+		phydev_err(phydev, "%s 0x%08x failed: %d\n", __func__,
+			   pbus_address, ret);
+
+	return ret;
+}
+
+static int __air_buckpbus_reg_read(struct phy_device *phydev,
+				   u32 pbus_address, u32 *pbus_data)
+{
+	int pbus_data_low, pbus_data_high;
+	int ret;
+
+	ret = __phy_write(phydev, AIR_EXT_PAGE_ACCESS, AIR_PHY_PAGE_EXTENDED_4);
+	if (ret < 0)
+		return ret;
+
+	ret = __phy_write(phydev, AIR_PBUS_MODE, AIR_PBUS_MODE_ADDR_KEEP);
+	if (ret < 0)
+		return ret;
+
+	ret = __phy_write(phydev, AIR_PBUS_RD_ADDR_HIGH, HIWORD(pbus_address));
+	if (ret < 0)
+		return ret;
+
+	ret = __phy_write(phydev, AIR_PBUS_RD_ADDR_LOW,  LOWORD(pbus_address));
+	if (ret < 0)
+		return ret;
+
+	pbus_data_high = __phy_read(phydev, AIR_PBUS_RD_DATA_HIGH);
+	if (pbus_data_high < 0)
+		return ret;
+
+	pbus_data_low = __phy_read(phydev, AIR_PBUS_RD_DATA_LOW);
+	if (pbus_data_low < 0)
+		return ret;
+
+	ret = __phy_write(phydev, AIR_EXT_PAGE_ACCESS, AIR_PHY_PAGE_STANDARD);
+	if (ret < 0)
+		return ret;
+
+	*pbus_data = MAKEDWORD(pbus_data_low, pbus_data_high);
+	return 0;
+}
+
+static int air_buckpbus_reg_read(struct phy_device *phydev,
+				 u32 pbus_address, u32 *pbus_data)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+	ret = __air_buckpbus_reg_read(phydev, pbus_address, pbus_data);
+	phy_unlock_mdio_bus(phydev);
+
+	if (ret < 0)
+		phydev_err(phydev, "%s 0x%08x failed: %d\n", __func__,
+			   pbus_address, ret);
+
+	return ret;
+}
+
+static int __air_write_buf(struct phy_device *phydev, u32 address,
+			   const struct firmware *fw)
+{
+	unsigned int offset;
+	int ret;
+	u16 val;
+
+	ret = __phy_write(phydev, AIR_EXT_PAGE_ACCESS, AIR_PHY_PAGE_EXTENDED_4);
+	if (ret < 0)
+		return ret;
+
+	ret = __phy_write(phydev, AIR_PBUS_MODE, AIR_PBUS_MODE_ADDR_INCR);
+	if (ret < 0)
+		return ret;
+
+	ret = __phy_write(phydev, AIR_PBUS_WR_ADDR_HIGH, HIWORD(address));
+	if (ret < 0)
+		return ret;
+
+	ret = __phy_write(phydev, AIR_PBUS_WR_ADDR_LOW,  LOWORD(address));
+	if (ret < 0)
+		return ret;
+
+	for (offset = 0; offset < fw->size; offset += 4) {
+		val = MAKEWORD(fw->data[offset + 2], fw->data[offset + 3]);
+		ret = __phy_write(phydev, AIR_PBUS_WR_DATA_HIGH, val);
+		if (ret < 0)
+			return ret;
+
+		val = MAKEWORD(fw->data[offset],    fw->data[offset + 1]);
+		ret = __phy_write(phydev, AIR_PBUS_WR_DATA_LOW,  val);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = __phy_write(phydev, AIR_EXT_PAGE_ACCESS, AIR_PHY_PAGE_STANDARD);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int air_write_buf(struct phy_device *phydev, u32 address,
+			 const struct firmware *fw)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+	ret = __air_write_buf(phydev, address, fw);
+	phy_unlock_mdio_bus(phydev);
+
+	if (ret < 0)
+		phydev_err(phydev, "%s 0x%08x failed: %d\n", __func__,
+			   address, ret);
+
+	return ret;
+}
+
+static int en8811h_load_firmware(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	const struct firmware *fw1, *fw2;
+	int ret;
+	unsigned int pbus_value;
+
+	ret = request_firmware_direct(&fw1, EN8811H_MD32_DM, dev);
+	if (ret < 0)
+		return ret;
+
+	ret = request_firmware_direct(&fw2, EN8811H_MD32_DSP, dev);
+	if (ret < 0)
+		goto en8811h_load_firmware_rel1;
+
+	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
+				     EN8811H_FW_CTRL_1_START);
+	if (ret < 0)
+		goto en8811h_load_firmware_out;
+
+	ret = air_buckpbus_reg_read(phydev, EN8811H_FW_CTRL_2, &pbus_value);
+	if (ret < 0)
+		goto en8811h_load_firmware_out;
+	pbus_value |= EN8811H_FW_CTRL_2_LOADING;
+	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_2, pbus_value);
+	if (ret < 0)
+		goto en8811h_load_firmware_out;
+
+	ret = air_write_buf(phydev, AIR_FW_ADDR_DM,  fw1);
+	if (ret < 0)
+		goto en8811h_load_firmware_out;
+
+	ret = air_write_buf(phydev, AIR_FW_ADDR_DSP, fw2);
+	if (ret < 0)
+		goto en8811h_load_firmware_out;
+
+	ret = air_buckpbus_reg_read(phydev, EN8811H_FW_CTRL_2, &pbus_value);
+	if (ret < 0)
+		goto en8811h_load_firmware_out;
+	pbus_value &= ~EN8811H_FW_CTRL_2_LOADING;
+	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_2, pbus_value);
+	if (ret < 0)
+		goto en8811h_load_firmware_out;
+
+	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
+				     EN8811H_FW_CTRL_1_FINISH);
+	if (ret < 0)
+		goto en8811h_load_firmware_out;
+
+	ret = 0;
+
+en8811h_load_firmware_out:
+	release_firmware(fw2);
+
+en8811h_load_firmware_rel1:
+	release_firmware(fw1);
+
+	return ret;
+}
+
+static int air_hw_led_on_set(struct phy_device *phydev, u8 index, bool on)
+{
+	struct en8811h_priv *priv = phydev->priv;
+	bool changed;
+
+	if (index >= EN8811H_LED_COUNT)
+		return -EINVAL;
+
+	if (on)
+		changed = !test_and_set_bit(AIR_PHY_LED_STATE_FORCE_ON,
+					    &priv->led[index].state);
+	else
+		changed = !!test_and_clear_bit(AIR_PHY_LED_STATE_FORCE_ON,
+					       &priv->led[index].state);
+
+	changed |= (priv->led[index].rules != 0);
+
+	if (changed)
+		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
+				      AIR_PHY_LED_ON(index),
+				      AIR_PHY_LED_ON_MASK,
+				      on ? AIR_PHY_LED_ON_FORCE_ON : 0);
+
+	return 0;
+}
+
+static int air_hw_led_blink_set(struct phy_device *phydev, u8 index,
+				bool blinking)
+{
+	struct en8811h_priv *priv = phydev->priv;
+	bool changed;
+
+	if (index >= EN8811H_LED_COUNT)
+		return -EINVAL;
+
+	if (blinking)
+		changed = !test_and_set_bit(AIR_PHY_LED_STATE_FORCE_BLINK,
+					    &priv->led[index].state);
+	else
+		changed = !!test_and_clear_bit(AIR_PHY_LED_STATE_FORCE_BLINK,
+					       &priv->led[index].state);
+
+	changed |= (priv->led[index].rules != 0);
+
+	if (changed)
+		return phy_write_mmd(phydev, MDIO_MMD_VEND2,
+				     AIR_PHY_LED_BLINK(index),
+				     blinking ?
+				     AIR_PHY_LED_BLINK_FORCE_BLINK : 0);
+	else
+		return 0;
+}
+
+static int air_led_blink_set(struct phy_device *phydev, u8 index,
+			     unsigned long *delay_on,
+			     unsigned long *delay_off)
+{
+	struct en8811h_priv *priv = phydev->priv;
+	bool blinking = false;
+	int err;
+
+	if (index >= EN8811H_LED_COUNT)
+		return -EINVAL;
+
+	if (delay_on && delay_off && (*delay_on > 0) && (*delay_off > 0)) {
+		blinking = true;
+		*delay_on = 50;
+		*delay_off = 50;
+	}
+
+	err = air_hw_led_blink_set(phydev, index, blinking);
+	if (err)
+		return err;
+
+	/* led-blink set, so switch led-on off */
+	err = air_hw_led_on_set(phydev, index, false);
+	if (err)
+		return err;
+
+	/* hw-control is off*/
+	if (!!test_bit(AIR_PHY_LED_STATE_FORCE_BLINK, &priv->led[index].state))
+		priv->led[index].rules = 0;
+
+	return 0;
+}
+
+static int air_led_brightness_set(struct phy_device *phydev, u8 index,
+				  enum led_brightness value)
+{
+	struct en8811h_priv *priv = phydev->priv;
+	int err;
+
+	if (index >= EN8811H_LED_COUNT)
+		return -EINVAL;
+
+	/* led-on set, so switch led-blink off */
+	err = air_hw_led_blink_set(phydev, index, false);
+	if (err)
+		return err;
+
+	err = air_hw_led_on_set(phydev, index, (value != LED_OFF));
+	if (err)
+		return err;
+
+	/* hw-control is off */
+	if (!!test_bit(AIR_PHY_LED_STATE_FORCE_ON, &priv->led[index].state))
+		priv->led[index].rules = 0;
+
+	return 0;
+}
+
+static int air_led_hw_control_get(struct phy_device *phydev, u8 index,
+				  unsigned long *rules)
+{
+	struct en8811h_priv *priv = phydev->priv;
+
+	if (index >= EN8811H_LED_COUNT)
+		return -EINVAL;
+
+	*rules = priv->led[index].rules;
+
+	return 0;
+};
+
+static int air_led_hw_control_set(struct phy_device *phydev, u8 index,
+				  unsigned long rules)
+{
+	struct en8811h_priv *priv = phydev->priv;
+	u16 on = 0, blink = 0;
+	int ret;
+
+	priv->led[index].rules = rules;
+
+	if (index >= EN8811H_LED_COUNT)
+		return -EINVAL;
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_10)   | BIT(TRIGGER_NETDEV_LINK))) {
+		on |= AIR_PHY_LED_ON_LINK10;
+		if (rules & BIT(TRIGGER_NETDEV_RX))
+			blink |= AIR_PHY_LED_BLINK_10RX;
+		if (rules & BIT(TRIGGER_NETDEV_TX))
+			blink |= AIR_PHY_LED_BLINK_10TX;
+	}
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_100)  | BIT(TRIGGER_NETDEV_LINK))) {
+		on |= AIR_PHY_LED_ON_LINK100;
+		if (rules & BIT(TRIGGER_NETDEV_RX))
+			blink |= AIR_PHY_LED_BLINK_100RX;
+		if (rules & BIT(TRIGGER_NETDEV_TX))
+			blink |= AIR_PHY_LED_BLINK_100TX;
+	}
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_1000) | BIT(TRIGGER_NETDEV_LINK))) {
+		on |= AIR_PHY_LED_ON_LINK1000;
+		if (rules & BIT(TRIGGER_NETDEV_RX))
+			blink |= AIR_PHY_LED_BLINK_1000RX;
+		if (rules & BIT(TRIGGER_NETDEV_TX))
+			blink |= AIR_PHY_LED_BLINK_1000TX;
+	}
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_2500) | BIT(TRIGGER_NETDEV_LINK))) {
+		on |= AIR_PHY_LED_ON_LINK2500;
+		if (rules & BIT(TRIGGER_NETDEV_RX))
+			blink |= AIR_PHY_LED_BLINK_2500RX;
+		if (rules & BIT(TRIGGER_NETDEV_TX))
+			blink |= AIR_PHY_LED_BLINK_2500TX;
+	}
+
+	if (on == 0) {
+		if (rules & BIT(TRIGGER_NETDEV_RX)) {
+			blink |= AIR_PHY_LED_BLINK_10RX   |
+				 AIR_PHY_LED_BLINK_100RX  |
+				 AIR_PHY_LED_BLINK_1000RX |
+				 AIR_PHY_LED_BLINK_2500RX;
+		}
+		if (rules & BIT(TRIGGER_NETDEV_TX)) {
+			blink |= AIR_PHY_LED_BLINK_10TX   |
+				 AIR_PHY_LED_BLINK_100TX  |
+				 AIR_PHY_LED_BLINK_1000TX |
+				 AIR_PHY_LED_BLINK_2500TX;
+		}
+	}
+
+	if (rules & BIT(TRIGGER_NETDEV_FULL_DUPLEX))
+		on |= AIR_PHY_LED_ON_FDX;
+
+	if (rules & BIT(TRIGGER_NETDEV_HALF_DUPLEX))
+		on |= AIR_PHY_LED_ON_HDX;
+
+	if (blink || on) {
+		/* switch hw-control on, so led-on and led-blink are off */
+		clear_bit(AIR_PHY_LED_STATE_FORCE_ON, &priv->led[index].state);
+		clear_bit(AIR_PHY_LED_STATE_FORCE_BLINK, &priv->led[index].state);
+	} else {
+		priv->led[index].rules = 0;
+	}
+
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_ON(index),
+			     AIR_PHY_LED_ON_MASK, on);
+
+	if (ret < 0)
+		return ret;
+
+	return phy_write_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_BLINK(index),
+			     blink);
+};
+
+static int air_led_init(struct phy_device *phydev, u8 index, u8 state, u8 pol)
+{
+	int cl45_data;
+	int err;
+
+	if (index >= EN8811H_LED_COUNT)
+		return -EINVAL;
+
+	cl45_data = phy_read_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_ON(index));
+	if (cl45_data < 0)
+		return cl45_data;
+
+	if (state == AIR_LED_ENABLE)
+		cl45_data |= AIR_PHY_LED_ON_ENABLE;
+	else
+		cl45_data &= ~AIR_PHY_LED_ON_ENABLE;
+
+	if (pol == AIR_ACTIVE_HIGH)
+		cl45_data |= AIR_PHY_LED_ON_POLARITY;
+	else
+		cl45_data &= ~AIR_PHY_LED_ON_POLARITY;
+
+	err = phy_write_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_ON(index),
+			    cl45_data);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int air_leds_init(struct phy_device *phydev, int num, int dur, int mode)
+{
+	struct en8811h_priv *priv = phydev->priv;
+	int ret, i;
+	int cl45_data = dur;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_DUR_BLINK,
+			    cl45_data);
+	if (ret < 0)
+		return ret;
+
+	cl45_data >>= 1;
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_DUR_ON,
+			    cl45_data);
+	if (ret < 0)
+		return ret;
+
+	cl45_data = phy_read_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_BCR);
+	if (cl45_data < 0)
+		return cl45_data;
+
+	switch (mode) {
+	case AIR_LED_MODE_DISABLE:
+		cl45_data &= ~AIR_PHY_LED_BCR_EXT_CTRL;
+		cl45_data &= ~AIR_PHY_LED_BCR_MODE_MASK;
+		break;
+	case AIR_LED_MODE_USER_DEFINE:
+		cl45_data |= AIR_PHY_LED_BCR_EXT_CTRL;
+		cl45_data |= AIR_PHY_LED_BCR_CLK_EN;
+		break;
+	default:
+		phydev_err(phydev, "LED mode %d is not supported\n", mode);
+		return -EINVAL;
+	}
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_BCR, cl45_data);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < num; ++i) {
+		ret = air_led_init(phydev, i, AIR_LED_ENABLE, AIR_ACTIVE_HIGH);
+		if (ret < 0) {
+			phydev_err(phydev, "LED%d init failed: %d\n", i, ret);
+			return ret;
+		}
+		air_led_hw_control_set(phydev, i, priv->led[i].rules);
+	}
+
+	return 0;
+}
+
+static int en8811h_led_hw_is_supported(struct phy_device *phydev, u8 index,
+				       unsigned long rules)
+{
+	if (index >= EN8811H_LED_COUNT)
+		return -EINVAL;
+
+	/* All combinations of the supported triggers are allowed */
+	if (rules & ~en8811h_led_trig)
+		return -EOPNOTSUPP;
+
+	return 0;
+};
+
+static int en8811h_probe(struct phy_device *phydev)
+{
+	struct en8811h_priv *priv;
+
+	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(struct en8811h_priv),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->led[0].rules = AIR_DEFAULT_TRIGGER_LED0;
+	priv->led[1].rules = AIR_DEFAULT_TRIGGER_LED1;
+	priv->led[2].rules = AIR_DEFAULT_TRIGGER_LED2;
+
+	phydev->priv = priv;
+
+	/* MDIO_DEVS1/2 empty, so set mmds_present bits here */
+	phydev->c45_ids.mmds_present |= MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
+
+	return 0;
+}
+
+static int en8811h_config_init(struct phy_device *phydev)
+{
+	int ret, pollret, reg_value;
+	unsigned int pbus_value;
+	struct device *dev = &phydev->mdio.dev;
+
+	ret = en8811h_load_firmware(phydev);
+	if (ret) {
+		phydev_err(phydev, "Load firmware failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Because of mdio-lock, may have to wait for multiple loads */
+	pollret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
+					    EN8811H_PHY_FW_STATUS, reg_value,
+					    reg_value == EN8811H_PHY_READY,
+					    20000, 7500000, true);
+
+	ret = air_buckpbus_reg_read(phydev, EN8811H_FW_VERSION, &pbus_value);
+	if (ret < 0)
+		return ret;
+	phydev_info(phydev, "MD32 firmware version: %08x\n", pbus_value);
+
+	if (pollret) {
+		phydev_err(phydev, "Firmware not ready: 0x%x\n", reg_value);
+		return -ENODEV;
+	}
+
+	/* Select mode 1, the only mode supported */
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AIR_PHY_VENDORCTL1,
+			    AIR_PHY_VENDORCTL1_MODE1);
+	if (ret < 0)
+		return ret;
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AIR_PHY_VENDORCTL2,
+			    AIR_PHY_VENDORCTL2_MODE1);
+	if (ret < 0)
+		return ret;
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AIR_PHY_VENDORCTL3,
+			    AIR_PHY_VENDORCTL3_MODE1);
+	if (ret < 0)
+		return ret;
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AIR_PHY_VENDORCTL4,
+			    AIR_PHY_VENDORCTL4_MODE1);
+	if (ret < 0)
+		return ret;
+
+	/* Serdes polarity */
+	ret = air_buckpbus_reg_read(phydev, EN8811H_POLARITY, &pbus_value);
+	if (ret < 0)
+		return ret;
+	if (device_property_read_bool(dev, "airoha,rx-pol-reverse"))
+		pbus_value |=  EN8811H_POLARITY_RX_REVERSE;
+	else
+		pbus_value &= ~EN8811H_POLARITY_RX_REVERSE;
+	if (device_property_read_bool(dev, "airoha,tx-pol-reverse"))
+		pbus_value &= ~EN8811H_POLARITY_TX_NORMAL;
+	else
+		pbus_value |=  EN8811H_POLARITY_TX_NORMAL;
+	ret = air_buckpbus_reg_write(phydev, EN8811H_POLARITY, pbus_value);
+	if (ret < 0)
+		return ret;
+
+	ret = air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
+			    AIR_LED_MODE_USER_DEFINE);
+	if (ret < 0) {
+		phydev_err(phydev, "Failed to initialize leds: %d\n", ret);
+		return ret;
+	}
+
+	ret = air_buckpbus_reg_read(phydev, EN8811H_GPIO_MODE, &pbus_value);
+	if (ret < 0)
+		return ret;
+	pbus_value |= EN8811H_GPIO_MODE_345;
+	ret = air_buckpbus_reg_write(phydev, EN8811H_GPIO_MODE, pbus_value);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int en8811h_get_features(struct phy_device *phydev)
+{
+	linkmode_set_bit_array(phy_basic_ports_array,
+			       ARRAY_SIZE(phy_basic_ports_array),
+			       phydev->supported);
+
+	return  genphy_c45_pma_read_abilities(phydev);
+}
+
+static int en8811h_get_rate_matching(struct phy_device *phydev,
+				     phy_interface_t iface)
+{
+	return RATE_MATCH_PAUSE;
+}
+
+static int en8811h_config_aneg(struct phy_device *phydev)
+{
+	u32 adv;
+	bool changed = false;
+	int ret;
+
+	phydev_dbg(phydev, "%s: advertising=%*pb\n", __func__,
+		   __ETHTOOL_LINK_MODE_MASK_NBITS, phydev->advertising);
+
+	if (phydev->autoneg == AUTONEG_DISABLE)
+		return genphy_c45_pma_setup_forced(phydev);
+
+	ret = genphy_c45_an_config_aneg(phydev);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	/* Clause 45 has no standardized support for 1000BaseT, therefore
+	 * use Clause 22 registers for this mode.
+	 */
+	adv = linkmode_adv_to_mii_ctrl1000_t(phydev->advertising);
+	ret = phy_modify_changed(phydev, MII_CTRL1000, ADVERTISE_1000FULL, adv);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	return genphy_c45_check_and_restart_aneg(phydev, changed);
+}
+
+int en8811h_c45_read_link(struct phy_device *phydev)
+{
+	int val;
+
+	/* Read link state from known reliable register (latched) */
+
+	if (!phy_polling_mode(phydev) || !phydev->link) {
+		val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1);
+		if (val < 0)
+			return val;
+		phydev->link = !!(val & MDIO_STAT1_LSTATUS);
+
+		if (phydev->link)
+			return 0;
+	}
+
+	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1);
+	if (val < 0)
+		return val;
+	phydev->link = !!(val & MDIO_STAT1_LSTATUS);
+
+	return 0;
+}
+
+static int en8811h_read_status(struct phy_device *phydev)
+{
+	int ret, lpagb;
+	unsigned int pbus_value;
+
+	ret = en8811h_c45_read_link(phydev);
+	if (ret)
+		return ret;
+
+	phydev->speed = SPEED_UNKNOWN;
+	phydev->duplex = DUPLEX_UNKNOWN;
+	phydev->pause = 0;
+	phydev->asym_pause = 0;
+
+	if (phydev->autoneg == AUTONEG_ENABLE) {
+		ret = genphy_c45_read_lpa(phydev);
+		if (ret)
+			return ret;
+
+		/* Clause 45 has no standardized support for 1000BaseT,
+		 * therefore use Clause 22 registers for this mode.
+		 */
+		lpagb = phy_read(phydev, MII_STAT1000);
+		if (lpagb < 0)
+			return lpagb;
+		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, lpagb);
+
+		phy_resolve_aneg_pause(phydev);
+	} else {
+		linkmode_zero(phydev->lp_advertising);
+	}
+
+	if (!phydev->link)
+		return 0;
+
+	/* Get real speed from vendor register */
+	ret = air_buckpbus_reg_read(phydev, EN8811H_SPEED, &pbus_value);
+	if (ret < 0)
+		return ret;
+	switch (pbus_value & EN8811H_SPEED_MASK) {
+	case EN8811H_SPEED_2500:
+		phydev->speed = SPEED_2500;
+		/* BUG in PHY: MDIO_AN_10GBT_STAT_LP2_5G does not get set
+		 * Assume link partner advertised it
+		 */
+		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+				 phydev->lp_advertising);
+		break;
+	case EN8811H_SPEED_1000:
+		phydev->speed = SPEED_1000;
+		break;
+	case EN8811H_SPEED_100:
+		phydev->speed = SPEED_100;
+		break;
+	}
+
+	/* Only supports full duplex */
+	phydev->duplex = DUPLEX_FULL;
+
+	return 0;
+}
+
+static int en8811h_clear_intr(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AIR_PHY_VENDORCTL3,
+			    AIR_PHY_VENDORCTL3_INTCLR);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AIR_PHY_VENDORCTL4,
+			    AIR_PHY_VENDORCTL4_INTCLR);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static irqreturn_t en8811h_handle_interrupt(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = en8811h_clear_intr(phydev);
+	if (ret < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	phy_trigger_machine(phydev);
+
+	return IRQ_HANDLED;
+}
+
+static struct phy_driver en8811h_driver[] = {
+{
+	PHY_ID_MATCH_MODEL(EN8811H_PHY_ID),
+	.name			= "Airoha EN8811H",
+	.probe			= en8811h_probe,
+	.get_features		= en8811h_get_features,
+	.config_init		= en8811h_config_init,
+	.get_rate_matching	= en8811h_get_rate_matching,
+	.config_aneg		= en8811h_config_aneg,
+	.read_status		= en8811h_read_status,
+	.config_intr		= en8811h_clear_intr,
+	.handle_interrupt	= en8811h_handle_interrupt,
+	.led_hw_is_supported	= en8811h_led_hw_is_supported,
+	.led_blink_set		= air_led_blink_set,
+	.led_brightness_set	= air_led_brightness_set,
+	.led_hw_control_set	= air_led_hw_control_set,
+	.led_hw_control_get	= air_led_hw_control_get,
+} };
+
+int __init en8811h_phy_driver_register(void)
+{
+	int ret;
+
+	ret = phy_driver_register(en8811h_driver, THIS_MODULE);
+	if (!ret)
+		return 0;
+
+	phy_driver_unregister(en8811h_driver);
+	return ret;
+}
+
+void __exit en8811h_phy_driver_unregister(void)
+{
+	phy_driver_unregister(en8811h_driver);
+}
+
+module_init(en8811h_phy_driver_register);
+module_exit(en8811h_phy_driver_unregister);
+
+static struct mdio_device_id __maybe_unused en8811h_tbl[] = {
+	{ PHY_ID_MATCH_MODEL(EN8811H_PHY_ID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(mdio, en8811h_tbl);
+MODULE_FIRMWARE(EN8811H_MD32_DM);
+MODULE_FIRMWARE(EN8811H_MD32_DSP);
+
+MODULE_DESCRIPTION("Airoha EN8811H PHY drivers");
+MODULE_AUTHOR("Airoha");
+MODULE_AUTHOR("Eric Woudstra <ericwouds@gmail.com>");
+MODULE_LICENSE("GPL");
+
-- 
2.42.1


