Return-Path: <netdev+bounces-179701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C25BA7E301
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7EF16641B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8B91F8AC8;
	Mon,  7 Apr 2025 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="g80uw+fM"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A511F4C95;
	Mon,  7 Apr 2025 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744037558; cv=none; b=epmhEhVTVpH41WZdTLwtxz7LgXJK5i5hJ3K4cO3L+i89RZhqfdcWO17Seark8aDx7fsZ7SLCLiiOZXsyLkGOeplZVTROOvgf+cvk50juivOwCZm/q/SgSIKKQgKjALAPZDjnS2cB0sC+13NAybDo1E/cKyQTHZQs6htW8kPimOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744037558; c=relaxed/simple;
	bh=nZc0pvIfEVXSzQ1i30nWVz8waUwNFaFopLtWHxXJSCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L61VFKGM8X4IeIzrrG4MfztkgRkRtcy90Mosz+ZNkWj1gbF/7PaJoanvdKuZeJLm2FfoTB7VyvKevqYxMDxcUutQ931vw+qbs+Knh6K3HcZAiKILhE/GE0tq7tIR94OZeL65fEHXo/5fk/iHR1G/bMMqy+uNGVyDGvonYpSL4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=g80uw+fM; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F3A8102EB908;
	Mon,  7 Apr 2025 16:52:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744037550; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ER7aG5lI4ZwZpto7WFGNm6p64AbF4LdScmsMgRS4TG0=;
	b=g80uw+fMVkSklTTwGpjDbvSf7V4zYS638OxLti7LliKxPKM6Fp8L6Vg2oB2jUgoSd/mlSb
	UBmzwjflh7MlMXQxl0yxD5lX1MutQCpNQwxGM6YTpZWLrtvtzHp0xBXMpPbxvHY5mOkjsS
	B6WY8s9ySIYLABi6W5kZBt0IcIuvoRdb5XTFsXCBzqaWW3i1ZO+ygP4fYVDn9c9ZcUq3tj
	DpJZhzeyGUZY/FmB4MXmIa62XwyGy/s/vctTiYB6P0YGgcC3dsnqVxe6VJk8IUVmJtlLlo
	JRggqONPxnpfzTdkYe0tB5lAbPjjySz4VRd0jaCQjYvp/cEcBWPYlScQ/zMC/g==
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Lukasz Majewski <lukma@denx.de>
Subject: [net-next v4 4/5] net: mtip: The L2 switch driver for imx287
Date: Mon,  7 Apr 2025 16:51:56 +0200
Message-Id: <20250407145157.3626463-5-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407145157.3626463-1-lukma@denx.de>
References: <20250407145157.3626463-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This patch series provides support for More Than IP L2 switch embedded
in the imx287 SoC.

This is a two port switch (placed between uDMA[01] and MAC-NET[01]),
which can be used for offloading the network traffic.

It can be used interchangeably with current FEC driver - to be more
specific: one can use either of it, depending on the requirements.

The biggest difference is the usage of DMA - when FEC is used, separate
DMAs are available for each ENET-MAC block.
However, with switch enabled - only the DMA0 is used to send/receive data
to/form switch (and then switch sends them to respecitive ports).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:

- Remove not needed comments
- Restore udelay(10) for switch reset (such delay is explicitly specifed
  in the documentation
- Add COMPILE_TEST
- replace pr_* with dev_*
- Use for_each_available_child_of_node_scoped()
- Use devm_* function for memory allocation
- Remove printing information about the HW and SW revision of the driver
- Use devm_regulator_get_optional()
- Change compatible prefix from 'fsl' to more up to date 'nxp'
- Remove .owner = THIS_MODULE
- Use devm_platform_ioremap_resource(pdev, 0);
- Use devm_request_irq()
- Use devm_regulator_get_enable_optional()
- Replace clk_prepare_enable() and devm_clk_get() with single
  call to devm_clk_get_optional_enabled()
- Cleanup error patch when function calls in probe fail
- Refactor the mtip_reset_phy() to serve as mdio bus reset callback
- Add myself as the MTIP L2 switch maintainer (squashed the separated
  commit)
- More descriptive help paragraphs (> 4 lines)

Changes for v3:
- Remove 'bridge_offloading' module parameter (to bridge ports just after probe)
- Remove forward references
- Fix reverse christmas tree formatting in functions
- Convert eligible comments to kernel doc format
- Remove extra MAC address validation check at esw_mac_addr_static()
- Remove mtip_print_link_status() and replace it with phy_print_status()
- Avoid changing phy device state in the driver (instead use functions
  exported by the phy API)
- Do not print extra information regarding PHY (which is printed by phylib) -
  e.g. net lan0: lan0: MTIP eth L2 switch 1e:ce:a5:0b:4c:12
- Remove VERSION from the driver - now we rely on the SHA1 in Linux
  mainline tree
- Remove zeroing of the net device private area (shall be already done
  during allocation)
- Refactor the code to remove mtip_ndev_setup()
- Use -ENOMEM instead of -1 return code when allocation fails
- Replace dev_info() with dev_dbg() to reduce number of information print
  on normal operation
- Return ret instead of 0 from mtip_ndev_init()
- Remove fep->mii_timeout flag from the driver
- Remove not used stop_gpr_* fields in mtip_devinfo struct
- Remove platform_device_id description for mtipl2sw driver
- Add MODULE_DEVICE_TABLE() for mtip_of_match
- Remove MODULE_ALIAS()

Changes for v4:
- Rename imx287 with imx28 (as the former is not used in kernel anymore)
- Reorder the place where ENET interface is initialized - without this
  change the enet_out clock has default (25 MHz) value, which causes
  issues during reset (RMII's 50 MHz is required for proper PHY reset).
- Use PAUR instead of PAUR register to program MAC address
- Replace eth_mac_addr() with eth_hw_addr_set()
- Write to HW the randomly generated MAC address (if required)
- Adjust the reset code
- s/read_atable/mtip_read_atable/g and s/write_atable/mtip_write_atable/g
- Add clk_disable() and netif_napi_del() when errors occur during
  mtip_open() - refactor the error handling path.
- Refactor the mtip_set_multicast_list() to write (now) correct values to
  ENET-FEC registers.
- Replace dev_warn() with dev_err()
- Use GPIO_ACTIVE_LOW to indicate polarity in DTS
- Refactor code to check if network device is the switch device
- Remove mtip_port_dev_check()
- Refactor mtip_ndev_port_link() avoid starting HW offloading for bridge
  when MTIP ports are parts of two distinct bridges
- Replace del_timer() with timer_delete_sync()
---
 MAINTAINERS                                   |    7 +
 drivers/net/ethernet/freescale/Kconfig        |    1 +
 drivers/net/ethernet/freescale/Makefile       |    1 +
 drivers/net/ethernet/freescale/mtipsw/Kconfig |   13 +
 .../net/ethernet/freescale/mtipsw/Makefile    |    3 +
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 1970 +++++++++++++++++
 .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |  782 +++++++
 .../ethernet/freescale/mtipsw/mtipl2sw_br.c   |  122 +
 .../ethernet/freescale/mtipsw/mtipl2sw_mgnt.c |  449 ++++
 9 files changed, 3348 insertions(+)
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/Kconfig
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/Makefile
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c5c2e2c1278..9c5626c2b3b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9455,6 +9455,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-mpc.yaml
 F:	drivers/i2c/busses/i2c-mpc.c
 
+FREESCALE MTIP ETHERNET SWITCH DRIVER
+M:	Lukasz Majewski <lukma@denx.de>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
+F:	drivers/net/ethernet/freescale/mtipsw/*
+
 FREESCALE QORIQ DPAA ETHERNET DRIVER
 M:	Madalin Bucur <madalin.bucur@nxp.com>
 L:	netdev@vger.kernel.org
diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
index a2d7300925a8..056a11c3a74e 100644
--- a/drivers/net/ethernet/freescale/Kconfig
+++ b/drivers/net/ethernet/freescale/Kconfig
@@ -60,6 +60,7 @@ config FEC_MPC52xx_MDIO
 
 source "drivers/net/ethernet/freescale/fs_enet/Kconfig"
 source "drivers/net/ethernet/freescale/fman/Kconfig"
+source "drivers/net/ethernet/freescale/mtipsw/Kconfig"
 
 config FSL_PQ_MDIO
 	tristate "Freescale PQ MDIO"
diff --git a/drivers/net/ethernet/freescale/Makefile b/drivers/net/ethernet/freescale/Makefile
index de7b31842233..0e6cacb0948a 100644
--- a/drivers/net/ethernet/freescale/Makefile
+++ b/drivers/net/ethernet/freescale/Makefile
@@ -25,3 +25,4 @@ obj-$(CONFIG_FSL_DPAA_ETH) += dpaa/
 obj-$(CONFIG_FSL_DPAA2_ETH) += dpaa2/
 
 obj-y += enetc/
+obj-y += mtipsw/
diff --git a/drivers/net/ethernet/freescale/mtipsw/Kconfig b/drivers/net/ethernet/freescale/mtipsw/Kconfig
new file mode 100644
index 000000000000..450ff734a321
--- /dev/null
+++ b/drivers/net/ethernet/freescale/mtipsw/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config FEC_MTIP_L2SW
+	tristate "MoreThanIP L2 switch support to FEC driver"
+	depends on OF
+	depends on NET_SWITCHDEV
+	depends on BRIDGE
+	depends on ARCH_MXS || ARCH_MXC || COMPILE_TEST
+	help
+	  This enables support for the MoreThan IP L2 switch on i.MX
+	  SoCs (e.g. iMX28, vf610). It offloads bridging to this IP block's
+	  hardware and allows switch management with standard Linux tools.
+	  This switch driver can be used interchangeable with the already
+	  available FEC driver, depending on the use case's requirments.
diff --git a/drivers/net/ethernet/freescale/mtipsw/Makefile b/drivers/net/ethernet/freescale/mtipsw/Makefile
new file mode 100644
index 000000000000..4d69db2226a6
--- /dev/null
+++ b/drivers/net/ethernet/freescale/mtipsw/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_FEC_MTIP_L2SW) += mtipl2sw.o mtipl2sw_mgnt.o mtipl2sw_br.o
diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
new file mode 100644
index 000000000000..08681ecff97a
--- /dev/null
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
@@ -0,0 +1,1970 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  L2 switch Controller (Ethernet L2 switch) driver for MTIP block.
+ *
+ *  Copyright (C) 2025 DENX Software Engineering GmbH
+ *  Lukasz Majewski <lukma@denx.de>
+ *
+ *  Based on a previous work by:
+ *
+ *  Copyright 2010-2012 Freescale Semiconductor, Inc.
+ *  Alison Wang (b18965@freescale.com)
+ *  Jason Jin (Jason.jin@freescale.com)
+ *
+ *  Copyright (C) 2010-2013 Freescale Semiconductor, Inc. All Rights Reserved.
+ *  Shrek Wu (B16972@freescale.com)
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/iopoll.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/phy.h>
+#include <linux/of_mdio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of_net.h>
+#include <linux/of_platform.h>
+#include <linux/rtnetlink.h>
+#include <linux/regulator/consumer.h>
+#include <linux/io.h>
+
+#include "mtipl2sw.h"
+
+#ifdef CONFIG_ARCH_MXS
+static void *swap_buffer(void *bufaddr, int len)
+{
+	unsigned int *buf = bufaddr;
+	int i;
+
+	for (i = 0; i < (len + 3) / 4; i++, buf++)
+		*buf = __swab32(*buf);
+
+	return bufaddr;
+}
+#else
+static void *swap_buffer(void *bufaddr, int len) { return NULL; }
+#endif
+
+struct mtip_devinfo {
+	u32 quirks;
+};
+
+/* Last read entry from learning interface */
+struct mtip_port_info g_info;
+
+static void mtip_enet_init(struct switch_enet_private *fep, int port)
+{
+	void __iomem *enet_addr = fep->enet_addr;
+	u32 mii_speed, holdtime, tmp;
+
+	if (port == 2)
+		enet_addr += MCF_ESW_ENET_PORT_OFFSET;
+
+	tmp = MCF_FEC_RCR_PROM | MCF_FEC_RCR_MII_MODE |
+		MCF_FEC_RCR_MAX_FL(1522);
+
+	if (fep->phy_interface[port - 1]  == PHY_INTERFACE_MODE_RMII)
+		tmp |= MCF_FEC_RCR_RMII_MODE;
+
+	writel(tmp, enet_addr + MCF_FEC_RCR);
+
+	/* TCR */
+	writel(MCF_FEC_TCR_FDEN, enet_addr + MCF_FEC_TCR);
+
+	/* ECR */
+	writel(MCF_FEC_ECR_ETHER_EN, enet_addr + MCF_FEC_ECR);
+
+	/* Set MII speed to 2.5 MHz
+	 */
+	mii_speed = DIV_ROUND_UP(clk_get_rate(fep->clk_ipg), 5000000);
+	mii_speed--;
+
+	/* The i.MX28 and i.MX6 types have another filed in the MSCR (aka
+	 * MII_SPEED) register that defines the MDIO output hold time. Earlier
+	 * versions are RAZ there, so just ignore the difference and write the
+	 * register always.
+	 * The minimal hold time according to IEE802.3 (clause 22) is 10 ns.
+	 * HOLDTIME + 1 is the number of clk cycles the fec is holding the
+	 * output.
+	 * The HOLDTIME bitfield takes values between 0 and 7 (inclusive).
+	 * Given that ceil(clkrate / 5000000) <= 64, the calculation for
+	 * holdtime cannot result in a value greater than 3.
+	 */
+	holdtime = DIV_ROUND_UP(clk_get_rate(fep->clk_ipg), 100000000) - 1;
+
+	fep->phy_speed = mii_speed << 1 | holdtime << 8;
+
+	writel(fep->phy_speed, enet_addr + MCF_FEC_MSCR);
+}
+
+static int mtip_setup_mac(struct net_device *dev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	unsigned char *iap, tmpaddr[ETH_ALEN];
+
+	/* Use MAC address from DTS */
+	iap = &fep->mac[priv->portnum - 1][0];
+
+	/* Use MAC address set by bootloader */
+	if (!is_valid_ether_addr(iap)) {
+		*((unsigned long *)&tmpaddr[0]) =
+			be32_to_cpu(readl(fep->enet_addr + MCF_FEC_PALR));
+		*((unsigned short *)&tmpaddr[4]) =
+			be16_to_cpu(readl(fep->enet_addr +
+					  MCF_FEC_PAUR) >> 16);
+		iap = &tmpaddr[0];
+	}
+
+	/* Use random MAC address */
+	if (!is_valid_ether_addr(iap)) {
+		eth_hw_addr_random(dev);
+		dev_info(&fep->pdev->dev, "Using random MAC address: %pM\n",
+			 dev->dev_addr);
+		iap = (unsigned char *)dev->dev_addr;
+	}
+
+	/* Adjust MAC if using macaddr (and increment if needed) */
+	eth_hw_addr_gen(dev, iap, priv->portnum - 1);
+
+	return 0;
+}
+
+/**
+ * crc8_calc - calculate CRC for MAC storage
+ *
+ * @pmacaddress: A 6-byte array with the MAC address. The first byte is
+ *               the first byte transmitted.
+ *
+ * Calculate Galois Field Arithmetic CRC for Polynom x^8+x^2+x+1.
+ * It omits the final shift in of 8 zeroes a "normal" CRC would do
+ * (getting the remainder).
+ *
+ *  Examples (hexadecimal values):<br>
+ *   10-11-12-13-14-15  => CRC=0xc2
+ *   10-11-cc-dd-ee-00  => CRC=0xe6
+ *
+ * Return: The 8-bit CRC in bits 7:0
+ */
+static int crc8_calc(unsigned char *pmacaddress)
+{
+	int byt; /* byte index */
+	int bit; /* bit index */
+	int crc = 0x12;
+	int inval;
+
+	for (byt = 0; byt < 6; byt++) {
+		inval = (((int)pmacaddress[byt]) & 0xff);
+		/* shift bit 0 to bit 8 so all our bits
+		 * travel through bit 8
+		 * (simplifies below calc)
+		 */
+		inval <<= 8;
+
+		for (bit = 0; bit < 8; bit++) {
+			/* next input bit comes into d7 after shift */
+			crc |= inval & 0x100;
+			if (crc & 0x01)
+				/* before shift  */
+				crc ^= 0x1c0;
+
+			crc >>= 1;
+			inval >>= 1;
+		}
+	}
+	/* upper bits are clean as we shifted in zeroes! */
+	return crc;
+}
+
+static void mtip_read_atable(struct switch_enet_private *fep, int index,
+			     unsigned long *read_lo, unsigned long *read_hi)
+{
+	unsigned long atable_base = (unsigned long)fep->hwentry;
+
+	*read_lo = readl((const void *)atable_base + (index << 3));
+	*read_hi = readl((const void *)atable_base + (index << 3) + 4);
+}
+
+static void mtip_write_atable(struct switch_enet_private *fep, int index,
+			      unsigned long write_lo, unsigned long write_hi)
+{
+	unsigned long atable_base = (unsigned long)fep->hwentry;
+
+	writel(write_lo, (void *)atable_base + (index << 3));
+	writel(write_hi, (void *)atable_base + (index << 3) + 4);
+}
+
+/**
+ * mtip_portinfofifo_read - Read element from receive FIFO
+ *
+ * @fep: Structure describing switch
+ *
+ * Read one element from the HW receive FIFO (Queue)
+ * if available and return it.
+ *
+ * Return: mtip_port_info or NULL if no data is available.
+ */
+static
+struct mtip_port_info *mtip_portinfofifo_read(struct switch_enet_private *fep)
+{
+	struct switch_t *fecp = fep->hwp;
+	u32 tmp;
+
+	tmp = readl(&fecp->ESW_LSR);
+	if (tmp == 0) {
+		dev_dbg(&fep->pdev->dev, "%s: ESW_LSR = 0x%x\n", __func__, tmp);
+		return NULL;
+	}
+
+	/* read word from FIFO */
+	g_info.maclo = readl(&fecp->ESW_LREC0);
+	if (g_info.maclo == 0) {
+		dev_dbg(&fep->pdev->dev, "%s: mac lo 0x%x\n", __func__,
+			g_info.maclo);
+		return NULL;
+	}
+
+	/* read 2nd word from FIFO */
+	tmp = readl(&fecp->ESW_LREC1);
+	g_info.machi = tmp & 0xffff;
+	g_info.hash  = (tmp >> 16) & 0xff;
+	g_info.port  = (tmp >> 24) & 0xf;
+
+	return &g_info;
+}
+
+static int mtip_atable_get_entry_port_number(struct switch_enet_private *fep,
+					     unsigned char *mac_addr, u8 *port)
+{
+	int block_index, block_index_end, entry;
+	unsigned long mac_addr_lo, mac_addr_hi;
+	unsigned long read_lo, read_hi;
+
+	mac_addr_lo = (unsigned long)((mac_addr[3] << 24) |
+				      (mac_addr[2] << 16) |
+				      (mac_addr[1] << 8) | mac_addr[0]);
+	mac_addr_hi = (unsigned long)((mac_addr[5] << 8) | (mac_addr[4]));
+
+	block_index = GET_BLOCK_PTR(crc8_calc(mac_addr));
+	block_index_end = block_index + ATABLE_ENTRY_PER_SLOT;
+
+	/* now search all the entries in the selected block */
+	for (entry = block_index; entry < block_index_end; entry++) {
+		mtip_read_atable(fep, entry, &read_lo, &read_hi);
+		*port = 0xff;
+
+		if (read_lo == mac_addr_lo &&
+		    ((read_hi & 0x0000ffff) ==
+		     (mac_addr_hi & 0x0000ffff))) {
+			/* found the correct address */
+			if ((read_hi & (1 << 16)) && (!(read_hi & (1 << 17))))
+				*port = AT_EXTRACT_PORT(read_hi);
+			break;
+		}
+	}
+
+	dev_dbg(&fep->pdev->dev, "%s: MAC: %pM PORT: 0x%x\n", __func__,
+		mac_addr, *port);
+
+	return 0;
+}
+
+/* Clear complete MAC Look Up Table */
+void mtip_clear_atable(struct switch_enet_private *fep)
+{
+	int index;
+
+	for (index = 0; index < 2048; index++)
+		mtip_write_atable(fep, index, 0, 0);
+}
+
+/**
+ * mtip_update_atable_static - Update switch static address table
+ *
+ * @mac_addr: Pointer to the array containing MAC address to
+ *            be put as static entry
+ * @port:     Port bitmask numbers to be added in static entry,
+ *            valid values are 1-7
+ * @priority: The priority for the static entry in table
+ *
+ * Updates MAC address lookup table with a static entry.
+ *
+ * Searches if the MAC address is already there in the block and replaces
+ * the older entry with the new one. If MAC address is not there then puts
+ * a new entry in the first empty slot available in the block.
+ *
+ * Return: 0 for a successful update else -ENOSPC when no slot available
+ */
+static int mtip_update_atable_static(unsigned char *mac_addr, unsigned int port,
+				     unsigned int priority,
+				     struct switch_enet_private *fep)
+{
+	unsigned long block_index, entry, index_end;
+	unsigned long write_lo, write_hi;
+	unsigned long read_lo, read_hi;
+
+	write_lo = (unsigned long)((mac_addr[3] << 24) |
+				   (mac_addr[2] << 16) |
+				   (mac_addr[1] << 8) |
+				   mac_addr[0]);
+	write_hi = (unsigned long)(0 | (port << AT_SENTRY_PORTMASK_shift) |
+				   (priority << AT_SENTRY_PRIO_shift) |
+				   (AT_ENTRY_TYPE_STATIC <<
+				    AT_ENTRY_TYPE_shift) |
+				   (AT_ENTRY_RECORD_VALID <<
+				    AT_ENTRY_VALID_shift) |
+				   (mac_addr[5] << 8) | (mac_addr[4]));
+
+	block_index = GET_BLOCK_PTR(crc8_calc(mac_addr));
+	index_end = block_index + ATABLE_ENTRY_PER_SLOT;
+	/* Now search all the entries in the selected block */
+	for (entry = block_index; entry < index_end; entry++) {
+		mtip_read_atable(fep, entry, &read_lo, &read_hi);
+		/* MAC address matched, so update the
+		 * existing entry
+		 * even if its a dynamic one
+		 */
+		if (read_lo == write_lo &&
+		    ((read_hi & 0x0000ffff) ==
+		     (write_hi & 0x0000ffff))) {
+			mtip_write_atable(fep, entry, write_lo, write_hi);
+			return 0;
+		} else if (!(read_hi & (1 << 16))) {
+			/* Fill this empty slot (valid bit zero),
+			 * assuming no holes in the block
+			 */
+			mtip_write_atable(fep, entry, write_lo, write_hi);
+			fep->at_curr_entries++;
+			return 0;
+		}
+	}
+
+	/* No space available for this static entry */
+	return -ENOSPC;
+}
+
+static int mtip_update_atable_dynamic1(unsigned long write_lo,
+				       unsigned long write_hi, int block_index,
+				       unsigned int port,
+				       unsigned int curr_time,
+				       struct switch_enet_private *fep)
+{
+	unsigned long entry, index_end;
+	unsigned long read_lo, read_hi;
+	int time, timeold, indexold;
+	unsigned long tmp;
+
+	/* prepare update port and timestamp */
+	tmp = AT_ENTRY_RECORD_VALID << AT_ENTRY_VALID_shift;
+	tmp |= AT_ENTRY_TYPE_DYNAMIC << AT_ENTRY_TYPE_shift;
+	tmp |= curr_time << AT_DENTRY_TIME_shift;
+	tmp |= port << AT_DENTRY_PORT_shift;
+	tmp |= write_hi;
+
+	/* linear search through all slot
+	 * entries and update if found
+	 */
+	index_end = block_index + ATABLE_ENTRY_PER_SLOT;
+	/* Now search all the entries in the selected block */
+	for (entry = block_index; entry < index_end; entry++) {
+		mtip_read_atable(fep, entry, &read_lo, &read_hi);
+		if (read_lo == write_lo &&
+		    ((read_hi & 0x0000ffff) ==
+		     (write_hi & 0x0000ffff))) {
+			/* found correct address,
+			 * update timestamp.
+			 */
+			mtip_write_atable(fep, entry, write_lo, tmp);
+
+			return 0;
+		} else if (!(read_hi & (1 << 16))) {
+			/* slot is empty, then use it
+			 * for new entry
+			 * Note: There are no holes,
+			 * therefore cannot be any
+			 * more that need to be compared.
+			 */
+			mtip_write_atable(fep, entry, write_lo, tmp);
+			/* statistics (we do it between writing
+			 *  .hi an .lo due to
+			 * hardware limitation...
+			 */
+			fep->at_curr_entries++;
+			/* newly inserted */
+
+			return 1;
+		}
+	}
+
+	/* No more entry available in block overwrite oldest */
+	timeold = 0;
+	indexold = 0;
+	for (entry = block_index; entry < index_end; entry++) {
+		mtip_read_atable(fep, entry, &read_lo, &read_hi);
+		time = AT_EXTRACT_TIMESTAMP(read_hi);
+		dev_err(&fep->pdev->dev, "%s : time %x currtime %x\n",
+			__func__, time, curr_time);
+		time = TIMEDELTA(curr_time, time);
+		if (time > timeold) {
+			/* is it older ? */
+			timeold = time;
+			indexold = entry;
+		}
+	}
+
+	mtip_write_atable(fep, indexold, write_lo, tmp);
+
+	/* Statistics (do it inbetween writing to .lo and .hi */
+	fep->at_block_overflows++;
+	dev_err(&fep->pdev->dev, "%s update time, at_block_overflows %x\n",
+		__func__, fep->at_block_overflows);
+	/* newly inserted */
+	return 1;
+}
+
+/* dynamicms MAC address table learn and migration */
+static int
+mtip_atable_dynamicms_learn_migration(struct switch_enet_private *fep,
+				      int curr_time, unsigned char *mac,
+				      u8 *rx_port)
+{
+	unsigned long rx_mac_lo, rx_mac_hi;
+	struct mtip_port_info *port_info;
+	int index, inserted = 0;
+	unsigned long flags;
+	u8 port = 0xFF;
+
+	spin_lock_irqsave(&fep->learn_lock, flags);
+
+	if (mac && is_valid_ether_addr(mac)) {
+		rx_mac_lo = (unsigned long)((mac[3] << 24) | (mac[2] << 16) |
+					    (mac[1] << 8) | mac[0]);
+		rx_mac_hi = (unsigned long)((mac[5] << 8) | (mac[4]));
+	}
+
+	port_info = mtip_portinfofifo_read(fep);
+	while (port_info) {
+		/* get block index from lookup table */
+		index = GET_BLOCK_PTR(port_info->hash);
+		inserted = mtip_update_atable_dynamic1(port_info->maclo,
+						       port_info->machi,
+						       index,
+						       port_info->port,
+						       curr_time, fep);
+
+		if (mac && is_valid_ether_addr(mac) && port == 0xFF) {
+			if (rx_mac_lo == port_info->maclo &&
+			    rx_mac_hi == port_info->machi) {
+				/* The newly learned MAC is the source of
+				 * our filtered frame.
+				 */
+				port = (u8)port_info->port;
+			}
+		}
+		port_info = mtip_portinfofifo_read(fep);
+	}
+
+	if (rx_port)
+		*rx_port = port;
+
+	spin_unlock_irqrestore(&fep->learn_lock, flags);
+	return 0;
+}
+
+/* The timer should create an interrupt every 4 seconds*/
+static void mtip_aging_timer(struct timer_list *t)
+{
+	struct switch_enet_private *fep = from_timer(fep, t, timer_aging);
+
+	if (fep)
+		fep->curr_time = mtip_timeincrement(fep->curr_time);
+
+	mod_timer(&fep->timer_aging,
+		  jiffies + msecs_to_jiffies(LEARNING_AGING_INTERVAL));
+}
+
+static void esw_mac_addr_static(struct switch_enet_private *fep)
+{
+	int i;
+
+	for (i = 0; i < SWITCH_EPORT_NUMBER; i++)
+		mtip_update_atable_static((unsigned char *)
+					  fep->ndev[i]->dev_addr, 7, 7, fep);
+}
+
+static void mtip_config_switch(struct switch_enet_private *fep)
+{
+	struct switch_t *fecp = fep->hwp;
+
+	esw_mac_addr_static(fep);
+
+	writel(0, &fecp->ESW_BKLR);
+
+	/* Do NOT disable learning */
+	mtip_port_learning_config(fep, 0, 0, 0);
+	mtip_port_learning_config(fep, 1, 0, 0);
+	mtip_port_learning_config(fep, 2, 0, 0);
+
+	/* Disable blocking */
+	mtip_port_blocking_config(fep, 0, 0);
+	mtip_port_blocking_config(fep, 1, 0);
+	mtip_port_blocking_config(fep, 2, 0);
+
+	writel(MCF_ESW_IMR_TXF | MCF_ESW_IMR_RXF,
+	       &fecp->ESW_IMR);
+
+	mtip_port_enable_config(fep, 0, 1, 1);
+	mtip_port_enable_config(fep, 1, 1, 1);
+	mtip_port_enable_config(fep, 2, 1, 1);
+
+	mtip_port_broadcast_config(fep, 0, 1);
+	mtip_port_broadcast_config(fep, 1, 1);
+	mtip_port_broadcast_config(fep, 2, 1);
+
+	/* Disable multicast receive on port 0 (MGNT) */
+	mtip_port_multicast_config(fep, 0, 0);
+	mtip_port_multicast_config(fep, 1, 1);
+	mtip_port_multicast_config(fep, 2, 1);
+
+	/* Setup VLANs to provide port separation */
+	if (!fep->br_offload)
+		mtip_switch_en_port_separation(fep);
+}
+
+static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
+					struct net_device *dev, int port)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	struct switch_t *fecp = fep->hwp;
+	unsigned short	status;
+	unsigned long flags;
+	struct cbd_t *bdp;
+	void *bufaddr;
+
+	spin_lock_irqsave(&fep->hw_lock, flags);
+
+	if (!fep->link[0] && !fep->link[1]) {
+		/* Link is down or autonegotiation is in progress. */
+		netif_stop_queue(dev);
+		spin_unlock_irqrestore(&fep->hw_lock, flags);
+		return NETDEV_TX_BUSY;
+	}
+
+	/* Fill in a Tx ring entry */
+	bdp = fep->cur_tx;
+
+	status = bdp->cbd_sc;
+
+	if (status & BD_ENET_TX_READY) {
+		/* All transmit buffers are full. Bail out.
+		 * This should not happen, since dev->tbusy should be set.
+		 */
+		dev_err(&fep->pdev->dev, "%s: tx queue full!.\n", dev->name);
+		spin_unlock_irqrestore(&fep->hw_lock, flags);
+		return NETDEV_TX_BUSY;
+	}
+
+	/* Clear all of the status flags */
+	status &= ~BD_ENET_TX_STATS;
+
+	/* Set buffer length and buffer pointer */
+	bufaddr = skb->data;
+	bdp->cbd_datlen = skb->len;
+
+	/* On some FEC implementations data must be aligned on
+	 * 4-byte boundaries. Use bounce buffers to copy data
+	 * and get it aligned.
+	 */
+	if ((unsigned long)bufaddr & MTIP_ALIGNMENT) {
+		unsigned int index;
+
+		index = bdp - fep->tx_bd_base;
+		memcpy(fep->tx_bounce[index],
+		       (void *)skb->data, skb->len);
+		bufaddr = fep->tx_bounce[index];
+	}
+
+	swap_buffer(bufaddr, skb->len);
+
+	/* Save skb pointer. */
+	fep->tx_skbuff[fep->skb_cur] = skb;
+
+	dev->stats.tx_bytes += skb->len;
+	fep->skb_cur = (fep->skb_cur + 1) & TX_RING_MOD_MASK;
+
+	/* Push the data cache so the CPM does not get stale memory
+	 * data.
+	 */
+	bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, bufaddr,
+					  MTIP_SWITCH_TX_FRSIZE,
+					  DMA_TO_DEVICE);
+
+	/* Send it on its way.  Tell FEC it's ready, interrupt when done,
+	 * it's the last BD of the frame, and to put the CRC on the end.
+	 */
+
+	status |= (BD_ENET_TX_READY | BD_ENET_TX_INTR
+			| BD_ENET_TX_LAST | BD_ENET_TX_TC);
+	bdp->cbd_sc = status;
+
+	netif_trans_update(dev);
+	skb_tx_timestamp(skb);
+
+	/* For port separation - force sending via specified port */
+	if (!fep->br_offload && port != 0)
+		mtip_forced_forward(fep, port, 1);
+
+	/* Trigger transmission start */
+	writel(MCF_ESW_TDAR_X_DES_ACTIVE, &fecp->ESW_TDAR);
+
+	/* If this was the last BD in the ring,
+	 * start at the beginning again.
+	 */
+	if (status & BD_ENET_TX_WRAP)
+		bdp = fep->tx_bd_base;
+	else
+		bdp++;
+
+	if (bdp == fep->dirty_tx) {
+		fep->tx_full = 1;
+		netif_stop_queue(dev);
+	}
+
+	fep->cur_tx = bdp;
+	spin_unlock_irqrestore(&fep->hw_lock, flags);
+
+	return NETDEV_TX_OK;
+}
+
+static netdev_tx_t mtip_start_xmit(struct sk_buff *skb,
+				   struct net_device *dev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+
+	return mtip_start_xmit_port(skb, dev, priv->portnum);
+}
+
+static void mtip_configure_enet_mii(struct switch_enet_private *fep, int port)
+{
+	struct phy_device *phydev = fep->phy_dev[port - 1];
+	struct net_device *dev = fep->ndev[port - 1];
+	void __iomem *enet_addr = fep->enet_addr;
+	int duplex = fep->full_duplex[port - 1];
+	u32 tmp;
+
+	if (port == 2)
+		enet_addr += MCF_ESW_ENET_PORT_OFFSET;
+
+	/* ECR */
+	writel(MCF_FEC_ECR_MAGIC_ENA, enet_addr + MCF_FEC_ECR);
+
+	/* EMRBR */
+	writel(PKT_MAXBLR_SIZE, enet_addr + MCF_FEC_EMRBR);
+
+	/* set the receive and transmit BDs ring base to
+	 * hardware registers(ERDSR & ETDSR)
+	 */
+	writel(fep->bd_dma, enet_addr + MCF_FEC_ERDSR);
+	writel((unsigned long)fep->bd_dma + sizeof(struct cbd_t) * RX_RING_SIZE,
+	       enet_addr + MCF_FEC_ETDSR);
+
+#ifdef CONFIG_ARCH_MXS
+	writel(fep->phy_speed, enet_addr + MCF_FEC_MSCR);
+#endif
+	/* EIR */
+	writel(0, enet_addr + MCF_FEC_EIR);
+
+	/* IAUR */
+	writel(0, enet_addr + MCF_FEC_IAUR);
+
+	/* IALR */
+	writel(0, enet_addr + MCF_FEC_IALR);
+
+	/* GAUR */
+	writel(0, enet_addr + MCF_FEC_GAUR);
+
+	/* GALR */
+	writel(0, enet_addr + MCF_FEC_GALR);
+
+	/* EMRBR */
+	writel(PKT_MAXBLR_SIZE, enet_addr + MCF_FEC_EMRBR);
+
+	/* EIMR */
+	writel(0, enet_addr + MCF_FEC_EIMR);
+
+	/* PALR PAUR */
+	/* Set the station address for the ENET Adapter */
+	writel(dev->dev_addr[3] |
+	       dev->dev_addr[2] << 8 |
+	       dev->dev_addr[1] << 16 |
+	       dev->dev_addr[0] << 24, enet_addr + MCF_FEC_PALR);
+	writel(dev->dev_addr[5] << 16 |
+	       (dev->dev_addr[4] + (unsigned char)(0)) << 24,
+	       enet_addr + MCF_FEC_PAUR);
+
+	/* RCR */
+	tmp = readl(enet_addr + MCF_FEC_RCR);
+	if (phydev && phydev->speed == SPEED_100)
+		tmp &= ~MCF_FEC_RCR_RMII_10BASET;
+	else
+		tmp |= MCF_FEC_RCR_RMII_10BASET;
+
+	if (duplex == DUPLEX_FULL)
+		tmp &= ~MCF_FEC_RCR_DRT;
+	else
+		tmp |= MCF_FEC_RCR_DRT;
+
+	writel(tmp, enet_addr + MCF_FEC_RCR);
+
+	/* TCR */
+	if (duplex == DUPLEX_FULL)
+		writel(0x1c, enet_addr + MCF_FEC_TCR);
+	else
+		writel(0x18, enet_addr + MCF_FEC_TCR);
+
+	/* ECR */
+	writel(readl(enet_addr + MCF_FEC_ECR) | MCF_FEC_ECR_ETHER_EN,
+	       enet_addr + MCF_FEC_ECR);
+}
+
+/* This function is called to start or restart the FEC during a link
+ * change. This only happens when switching between half and full
+ * duplex.
+ */
+static void mtip_switch_restart(struct net_device *dev, int duplex0,
+				int duplex1)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	struct switch_t *fecp = fep->hwp;
+	int i;
+
+	 /* Perform a reset. We should wait for this. */
+	writel(MCF_ESW_MODE_SW_RST, &fecp->ESW_MODE);
+
+	/* Delay of 10us specified in the documentation to perform
+	 * SW reset by the switch internally.
+	 */
+	udelay(10);
+	writel(MCF_ESW_MODE_STATRST, &fecp->ESW_MODE);
+	writel(MCF_ESW_MODE_SW_EN, &fecp->ESW_MODE);
+
+	/* Management port configuration,
+	 * make port 0 as management port
+	 */
+	writel(0, &fecp->ESW_BMPC);
+
+	/* Clear any outstanding interrupt */
+	writel(0xffffffff, &fecp->ESW_ISR);
+
+	/* Set backpressure threshold to minimize discarded frames
+	 * during due to congestion.
+	 */
+	writel(P0BC_THRESHOLD, &fecp->ESW_P0BCT);
+
+	/* Set maximum receive buffer size */
+	writel(PKT_MAXBLR_SIZE, &fecp->ESW_MRBR);
+
+	/* Set receive and transmit descriptor base */
+	writel(fep->bd_dma, &fecp->ESW_RDSR);
+	writel((unsigned long)fep->bd_dma
+		+ sizeof(struct cbd_t) * RX_RING_SIZE,
+		&fecp->ESW_TDSR);
+
+	fep->cur_tx = fep->tx_bd_base;
+	fep->cur_rx = fep->rx_bd_base;
+	fep->dirty_tx = fep->cur_tx;
+
+	/* Reset SKB transmit buffers */
+	fep->skb_cur = 0;
+	fep->skb_dirty = 0;
+	for (i = 0; i <= TX_RING_MOD_MASK; i++) {
+		if (fep->tx_skbuff[i]) {
+			dev_kfree_skb_any(fep->tx_skbuff[i]);
+			fep->tx_skbuff[i] = NULL;
+		}
+	}
+
+	fep->full_duplex[0] = duplex0;
+	fep->full_duplex[1] = duplex1;
+
+	mtip_configure_enet_mii(fep, 1);
+	mtip_configure_enet_mii(fep, 2);
+	mtip_clear_atable(fep);
+
+	/* And last, enable the transmit and receive processing */
+	writel(MCF_ESW_RDAR_R_DES_ACTIVE, &fecp->ESW_RDAR);
+
+	/* Enable interrupts we wish to service */
+	writel(0xffffffff, &fecp->ESW_ISR);
+	writel(MCF_ESW_IMR_TXF | MCF_ESW_IMR_RXF,
+	       &fecp->ESW_IMR);
+
+	mtip_config_switch(fep);
+}
+
+static void mtip_timeout(struct net_device *dev, unsigned int txqueue)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+#ifdef SWITCH_DEBUG
+	struct cbd_t	*bdp;
+	int	i;
+#endif
+	dev->stats.tx_errors++;
+#ifdef SWITCH_DEBUG
+	dev_info(&dev->dev, "%s: transmit timed out.\n", dev->name);
+	dev_info(&dev->dev,
+		 "Ring data dump: cur_tx %lx%s, dirty_tx %lx cur_rx: %lx\n",
+		 (unsigned long)fep->cur_tx, fep->tx_full ? " (full)" : "",
+		 (unsigned long)fep->dirty_tx,
+		 (unsigned long)fep->cur_rx);
+
+	bdp = fep->tx_bd_base;
+	dev_info(&dev->dev, " tx: %u buffers\n", TX_RING_SIZE);
+	for (i = 0 ; i < TX_RING_SIZE; i++) {
+		dev_info(&dev->dev, "  %08x: %04x %04x %08x\n",
+			 (uint)bdp, bdp->cbd_sc, bdp->cbd_datlen,
+			 (int)bdp->cbd_bufaddr);
+		bdp++;
+	}
+
+	bdp = fep->rx_bd_base;
+	dev_info(&dev->dev, " rx: %lu buffers\n",
+		 (unsigned long)RX_RING_SIZE);
+	for (i = 0 ; i < RX_RING_SIZE; i++) {
+		dev_info(&dev->dev, "  %08x: %04x %04x %08x\n", (uint)bdp,
+			 bdp->cbd_sc, bdp->cbd_datlen,
+			 (int)bdp->cbd_bufaddr);
+		bdp++;
+	}
+#endif
+
+	rtnl_lock();
+	if (netif_device_present(dev) || netif_running(dev)) {
+		napi_disable(&fep->napi);
+		netif_tx_lock_bh(dev);
+		mtip_switch_restart(dev, fep->full_duplex[0],
+				    fep->full_duplex[1]);
+		netif_tx_wake_all_queues(dev);
+		netif_tx_unlock_bh(dev);
+		napi_enable(&fep->napi);
+	}
+	rtnl_unlock();
+}
+
+static irqreturn_t mtip_interrupt(int irq, void *ptr_fep)
+{
+	struct switch_enet_private *fep = ptr_fep;
+	struct switch_t *fecp = fep->hwp;
+	irqreturn_t ret = IRQ_NONE;
+	u32 int_events, int_imask;
+
+	/* Get the interrupt events that caused us to be here */
+	do {
+		int_events = readl(&fecp->ESW_ISR);
+		writel(int_events, &fecp->ESW_ISR);
+
+		if (int_events & (MCF_ESW_ISR_RXF | MCF_ESW_ISR_TXF)) {
+			ret = IRQ_HANDLED;
+			/* Disable the RX interrupt */
+			if (napi_schedule_prep(&fep->napi)) {
+				int_imask = readl(&fecp->ESW_IMR);
+				int_imask &= ~MCF_ESW_IMR_RXF;
+				writel(int_imask, &fecp->ESW_IMR);
+				__napi_schedule(&fep->napi);
+			}
+		}
+	} while (int_events);
+
+	return ret;
+}
+
+static void mtip_switch_tx(struct net_device *dev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	unsigned short status;
+	struct sk_buff *skb;
+	unsigned long flags;
+	struct cbd_t *bdp;
+
+	spin_lock_irqsave(&fep->hw_lock, flags);
+	bdp = fep->dirty_tx;
+
+	while (((status = bdp->cbd_sc) & BD_ENET_TX_READY) == 0) {
+		if (bdp == fep->cur_tx && fep->tx_full == 0)
+			break;
+
+		dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr,
+				 MTIP_SWITCH_TX_FRSIZE, DMA_TO_DEVICE);
+		bdp->cbd_bufaddr = 0;
+		skb = fep->tx_skbuff[fep->skb_dirty];
+		/* Check for errors */
+		if (status & (BD_ENET_TX_HB | BD_ENET_TX_LC |
+				   BD_ENET_TX_RL | BD_ENET_TX_UN |
+				   BD_ENET_TX_CSL)) {
+			dev->stats.tx_errors++;
+			if (status & BD_ENET_TX_HB)  /* No heartbeat */
+				dev->stats.tx_heartbeat_errors++;
+			if (status & BD_ENET_TX_LC)  /* Late collision */
+				dev->stats.tx_window_errors++;
+			if (status & BD_ENET_TX_RL)  /* Retrans limit */
+				dev->stats.tx_aborted_errors++;
+			if (status & BD_ENET_TX_UN)  /* Underrun */
+				dev->stats.tx_fifo_errors++;
+			if (status & BD_ENET_TX_CSL) /* Carrier lost */
+				dev->stats.tx_carrier_errors++;
+		} else {
+			dev->stats.tx_packets++;
+		}
+
+		if (status & BD_ENET_TX_READY)
+			dev_err(&fep->pdev->dev,
+				"Enet xmit interrupt and TX_READY.\n");
+
+		/* Deferred means some collisions occurred during transmit,
+		 * but we eventually sent the packet OK.
+		 */
+		if (status & BD_ENET_TX_DEF)
+			dev->stats.collisions++;
+
+		/* Free the sk buffer associated with this last transmit */
+		dev_consume_skb_irq(skb);
+		fep->tx_skbuff[fep->skb_dirty] = NULL;
+		fep->skb_dirty = (fep->skb_dirty + 1) & TX_RING_MOD_MASK;
+
+		/* Update pointer to next buffer descriptor to be transmitted */
+		if (status & BD_ENET_TX_WRAP)
+			bdp = fep->tx_bd_base;
+		else
+			bdp++;
+
+		/* Since we have freed up a buffer, the ring is no longer
+		 * full.
+		 */
+		if (fep->tx_full) {
+			fep->tx_full = 0;
+			if (netif_queue_stopped(dev))
+				netif_wake_queue(dev);
+		}
+	}
+	fep->dirty_tx = bdp;
+	spin_unlock_irqrestore(&fep->hw_lock, flags);
+}
+
+/* During a receive, the cur_rx points to the current incoming buffer.
+ * When we update through the ring, if the next incoming buffer has
+ * not been given to the system, we just set the empty indicator,
+ * effectively tossing the packet.
+ */
+static int mtip_switch_rx(struct net_device *dev, int budget, int *port)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	struct switch_t *fecp = fep->hwp;
+	unsigned short status, pkt_len;
+	struct net_device *pndev;
+	u8 *data, rx_port = 0xFF;
+	struct ethhdr *eth_hdr;
+	int pkt_received = 0;
+	struct sk_buff *skb;
+	unsigned long flags;
+	struct cbd_t *bdp;
+
+	spin_lock_irqsave(&fep->hw_lock, flags);
+
+	/* First, grab all of the stats for the incoming packet.
+	 * These get messed up if we get called due to a busy condition.
+	 */
+	bdp = fep->cur_rx;
+
+	while (!((status = bdp->cbd_sc) & BD_ENET_RX_EMPTY)) {
+		if (pkt_received >= budget)
+			break;
+
+		pkt_received++;
+		/* Since we have allocated space to hold a complete frame,
+		 * the last indicator should be set.
+		 */
+		if ((status & BD_ENET_RX_LAST) == 0)
+			dev_info(&dev->dev, "SWITCH ENET: rcv is not +last\n");
+
+		if (!fep->usage_count)
+			goto rx_processing_done;
+
+		/* Check for errors. */
+		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
+			      BD_ENET_RX_CR | BD_ENET_RX_OV)) {
+			dev->stats.rx_errors++;
+			if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH)) {
+				/* Frame too long or too short. */
+				dev->stats.rx_length_errors++;
+			}
+			if (status & BD_ENET_RX_NO)	/* Frame alignment */
+				dev->stats.rx_frame_errors++;
+			if (status & BD_ENET_RX_CR)	/* CRC Error */
+				dev->stats.rx_crc_errors++;
+			if (status & BD_ENET_RX_OV)	/* FIFO overrun */
+				dev->stats.rx_fifo_errors++;
+		}
+
+		/* Report late collisions as a frame error.
+		 * On this error, the BD is closed, but we don't know what we
+		 * have in the buffer.  So, just drop this frame on the floor.
+		 */
+		if (status & BD_ENET_RX_CL) {
+			dev->stats.rx_errors++;
+			dev->stats.rx_frame_errors++;
+			goto rx_processing_done;
+		}
+
+		/* Process the incoming frame */
+		pkt_len = bdp->cbd_datlen;
+		data = (__u8 *)__va(bdp->cbd_bufaddr);
+
+		dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr,
+				 bdp->cbd_datlen, DMA_FROM_DEVICE);
+
+		swap_buffer(data, pkt_len);
+		if (data) {
+			eth_hdr = (struct ethhdr *)data;
+			mtip_atable_get_entry_port_number(fep,
+							  eth_hdr->h_source,
+							  &rx_port);
+			if (rx_port == 0xFF)
+				mtip_atable_dynamicms_learn_migration(fep,
+								      fep->curr_time,
+								      eth_hdr->h_source,
+								      &rx_port);
+		}
+
+		if (!fep->br_offload && (rx_port == 1 || rx_port == 2))
+			pndev = fep->ndev[rx_port - 1];
+		else
+			pndev = dev;
+
+		*port = rx_port;
+		pndev->stats.rx_packets++;
+		pndev->stats.rx_bytes += pkt_len;
+
+		/* This does 16 byte alignment, exactly what we need.
+		 * The packet length includes FCS, but we don't want to
+		 * include that when passing upstream as it messes up
+		 * bridging applications.
+		 */
+		skb = netdev_alloc_skb(pndev, pkt_len + NET_IP_ALIGN);
+		if (unlikely(!skb)) {
+			dev_dbg(&fep->pdev->dev,
+				"%s: Memory squeeze, dropping packet.\n",
+				pndev->name);
+			pndev->stats.rx_dropped++;
+		} else {
+			skb_reserve(skb, NET_IP_ALIGN);
+			skb_put(skb, pkt_len);      /* Make room */
+			skb_copy_to_linear_data(skb, data, pkt_len);
+			skb->protocol = eth_type_trans(skb, pndev);
+			napi_gro_receive(&fep->napi, skb);
+		}
+
+		bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, data,
+						  bdp->cbd_datlen,
+						  DMA_FROM_DEVICE);
+
+ rx_processing_done:
+		/* Clear the status flags for this buffer */
+		status &= ~BD_ENET_RX_STATS;
+
+		/* Mark the buffer empty */
+		status |= BD_ENET_RX_EMPTY;
+		bdp->cbd_sc = status;
+
+		/* Update BD pointer to next entry */
+		if (status & BD_ENET_RX_WRAP)
+			bdp = fep->rx_bd_base;
+		else
+			bdp++;
+
+		/* Doing this here will keep the FEC running while we process
+		 * incoming frames.  On a heavily loaded network, we should be
+		 * able to keep up at the expense of system resources.
+		 */
+		writel(MCF_ESW_RDAR_R_DES_ACTIVE, &fecp->ESW_RDAR);
+	} /* while (!((status = bdp->cbd_sc) & BD_ENET_RX_EMPTY)) */
+
+	writel(bdp, &fep->cur_rx);
+	spin_unlock_irqrestore(&fep->hw_lock, flags);
+
+	return pkt_received;
+}
+
+static void mtip_adjust_link(struct net_device *dev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	struct phy_device *phy_dev;
+	int status_change = 0, idx;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fep->hw_lock, flags);
+
+	idx = priv->portnum - 1;
+	phy_dev = fep->phy_dev[idx];
+
+	/* Duplex link change */
+	if (phy_dev->link && fep->full_duplex[idx] != phy_dev->duplex) {
+		if (idx == 0)
+			mtip_switch_restart(dev, phy_dev->duplex,
+					    fep->full_duplex[!idx]);
+		else
+			mtip_switch_restart(dev, fep->full_duplex[!idx],
+					    phy_dev->duplex);
+		status_change = 1;
+	}
+
+	/* Link on or off change */
+	if (phy_dev->link != fep->link[idx]) {
+		fep->link[idx] = phy_dev->link;
+		if (phy_dev->link) {
+			if (idx == 0)
+				mtip_switch_restart(dev, phy_dev->duplex,
+						    fep->full_duplex[!idx]);
+			else
+				mtip_switch_restart(dev, fep->full_duplex[!idx],
+						    phy_dev->duplex);
+			/* if link becomes up and tx be stopped, start it */
+			if (netif_queue_stopped(dev)) {
+				netif_start_queue(dev);
+				netif_wake_queue(dev);
+			}
+		}
+		status_change = 1;
+	}
+
+	spin_unlock_irqrestore(&fep->hw_lock, flags);
+
+	if (status_change)
+		phy_print_status(phy_dev);
+}
+
+static int mtip_mdio_wait(struct switch_enet_private *fep)
+{
+	uint ievent = 0;
+	int ret;
+
+	ret = readl_poll_timeout_atomic(fep->enet_addr + MCF_FEC_EIR, ievent,
+					ievent & MCF_ENET_MII, 2, 30000);
+	if (!ret)
+		writel(MCF_ENET_MII, fep->enet_addr + MCF_FEC_EIR);
+
+	return ret;
+}
+
+static int mtip_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
+{
+	struct switch_enet_private *fep = bus->priv;
+	int ret;
+
+	/* start a read op */
+	writel(FEC_MMFR_ST | FEC_MMFR_OP_READ |
+		FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(regnum) |
+		FEC_MMFR_TA, fep->enet_addr + MCF_FEC_MII_DATA);
+
+	/* wait for end of transfer */
+	ret = mtip_mdio_wait(fep);
+	if (ret) {
+		dev_err(&fep->pdev->dev, "MTIP: MDIO read timeout\n");
+		return ret;
+	}
+
+	/* return value */
+	return FEC_MMFR_DATA(readl(fep->enet_addr + MCF_FEC_MII_DATA));
+}
+
+static int mtip_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
+			   u16 value)
+{
+	struct switch_enet_private *fep = bus->priv;
+	int ret;
+
+	/* start a write op */
+	writel(FEC_MMFR_ST | FEC_MMFR_OP_WRITE |
+	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(regnum) |
+	       FEC_MMFR_TA | FEC_MMFR_DATA(value),
+	       fep->enet_addr + MCF_FEC_MII_DATA);
+
+	/* wait for end of transfer */
+	ret = mtip_mdio_wait(fep);
+	if (ret) {
+		dev_err(&fep->pdev->dev, "MTIP: MDIO write timeout\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mtip_mii_probe(struct net_device *dev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	struct phy_device *phy_dev = NULL;
+	int port_idx = priv->portnum - 1;
+
+	if (fep->phy_np[port_idx]) {
+		phy_dev = of_phy_connect(dev, fep->phy_np[port_idx],
+					 &mtip_adjust_link, 0,
+					 fep->phy_interface[port_idx]);
+		if (!phy_dev) {
+			netdev_err(dev, "Unable to connect to phy\n");
+			return -ENODEV;
+		}
+	}
+
+	phy_set_max_speed(phy_dev, 100);
+	fep->phy_dev[port_idx] = phy_dev;
+	fep->link[port_idx] = 0;
+	fep->full_duplex[port_idx] = 0;
+
+	dev_dbg(&dev->dev,
+		"MTIP PHY driver [%s] (mii_bus:phy_addr=%s, irq=%d)\n",
+		fep->phy_dev[port_idx]->drv->name,
+		phydev_name(fep->phy_dev[port_idx]),
+		fep->phy_dev[port_idx]->irq);
+
+	return 0;
+}
+
+static int mtip_mdiobus_reset(struct mii_bus *bus)
+{
+	if (!bus || !bus->reset_gpiod) {
+		dev_err(&bus->dev, "Reset GPIO pin not provided!\n");
+		return -EINVAL;
+	}
+
+	gpiod_set_value_cansleep(bus->reset_gpiod, 0);
+
+	/* Extra time to allow:
+	 * 1. GPIO RESET pin go high to prevent situation where its value is
+	 *    "LOW" as it is NOT configured.
+	 * 2. The ENET CLK to stabilize before GPIO RESET is asserted
+	 */
+	usleep_range(200, 300);
+
+	gpiod_set_value_cansleep(bus->reset_gpiod, 1);
+	usleep_range(bus->reset_delay_us, bus->reset_delay_us + 1000);
+	gpiod_set_value_cansleep(bus->reset_gpiod, 0);
+
+	if (bus->reset_post_delay_us > 0)
+		usleep_range(bus->reset_post_delay_us,
+			     bus->reset_post_delay_us + 1000);
+
+	return 0;
+}
+
+static int mtip_mii_init(struct switch_enet_private *fep,
+			 struct platform_device *pdev)
+{
+	struct device_node *node;
+	int err = -ENXIO;
+
+	/* Clear MMFR to avoid to generate MII event by writing MSCR.
+	 * MII event generation condition:
+	 * - writing MSCR:
+	 *      - mmfr[31:0]_not_zero & mscr[7:0]_is_zero &
+	 *        mscr_reg_data_in[7:0] != 0
+	 * - writing MMFR:
+	 *      - mscr[7:0]_not_zero
+	 */
+	writel(0, fep->hwp + MCF_FEC_MII_DATA);
+	/* Clear any pending transaction complete indication */
+	writel(MCF_ENET_MII, fep->enet_addr + MCF_FEC_EIR);
+
+	fep->mii_bus = mdiobus_alloc();
+	if (!fep->mii_bus) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	fep->mii_bus->name = "mtip_mii_bus";
+	fep->mii_bus->read = mtip_mdio_read;
+	fep->mii_bus->write = mtip_mdio_write;
+	fep->mii_bus->reset = mtip_mdiobus_reset;
+	snprintf(fep->mii_bus->id, MII_BUS_ID_SIZE, "%x", 0);
+	fep->mii_bus->priv = fep;
+	fep->mii_bus->parent = &pdev->dev;
+
+	node = of_get_child_by_name(pdev->dev.of_node, "mdio");
+	if (node)
+		dev_err(&fep->pdev->dev, "%s: PHY name: %s\n",
+			__func__, node->name);
+
+	err = of_mdiobus_register(fep->mii_bus, node);
+	if (node)
+		of_node_put(node);
+	if (err)
+		goto err_out_free_mdiobus;
+
+	return 0;
+
+err_out_free_mdiobus:
+	mdiobus_free(fep->mii_bus);
+err_out:
+	return err;
+}
+
+static void mtip_mii_remove(struct switch_enet_private *fep)
+{
+	int i;
+
+	for (i = 0; i < SWITCH_EPORT_NUMBER; i++) {
+		if (fep->phy_np[i])
+			of_node_put(fep->phy_np[i]);
+
+		if (fep->phy_dev[i])
+			phy_disconnect(fep->phy_dev[i]);
+	}
+
+	mdiobus_unregister(fep->mii_bus);
+	kfree(fep->mii_bus->irq);
+	mdiobus_free(fep->mii_bus);
+}
+
+static void mtip_get_drvinfo(struct net_device *dev,
+			     struct ethtool_drvinfo *info)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+
+	strscpy(info->driver, fep->pdev->dev.driver->name,
+		sizeof(info->driver));
+	strscpy(info->bus_info, dev_name(&dev->dev),
+		sizeof(info->bus_info));
+}
+
+static void mtip_free_buffers(struct net_device *dev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	struct sk_buff *skb;
+	struct cbd_t *bdp;
+	int i;
+
+	bdp = fep->rx_bd_base;
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		skb = fep->rx_skbuff[i];
+
+		if (bdp->cbd_bufaddr)
+			dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr,
+					 MTIP_SWITCH_RX_FRSIZE,
+					 DMA_FROM_DEVICE);
+		if (skb)
+			dev_kfree_skb(skb);
+		bdp++;
+	}
+
+	bdp = fep->tx_bd_base;
+	for (i = 0; i < TX_RING_SIZE; i++)
+		kfree(fep->tx_bounce[i]);
+}
+
+static int mtip_alloc_buffers(struct net_device *dev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	struct sk_buff *skb;
+	struct cbd_t *bdp;
+	int i;
+
+	bdp = fep->rx_bd_base;
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		skb = netdev_alloc_skb(dev, MTIP_SWITCH_RX_FRSIZE);
+		if (!skb) {
+			mtip_free_buffers(dev);
+			return -ENOMEM;
+		}
+		fep->rx_skbuff[i] = skb;
+
+		bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, skb->data,
+						  MTIP_SWITCH_RX_FRSIZE,
+						  DMA_FROM_DEVICE);
+		bdp->cbd_sc = BD_ENET_RX_EMPTY;
+		bdp++;
+	}
+
+	/* Set the last buffer to wrap. */
+	bdp--;
+	bdp->cbd_sc |= BD_SC_WRAP;
+
+	bdp = fep->tx_bd_base;
+	for (i = 0; i < TX_RING_SIZE; i++) {
+		fep->tx_bounce[i] = kmalloc(MTIP_SWITCH_TX_FRSIZE, GFP_KERNEL);
+
+		bdp->cbd_sc = 0;
+		bdp->cbd_bufaddr = 0;
+		bdp++;
+	}
+
+	/* Set the last buffer to wrap. */
+	bdp--;
+	bdp->cbd_sc |= BD_SC_WRAP;
+
+	return 0;
+}
+
+static int mtip_rx_napi(struct napi_struct *napi, int budget)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(napi->dev);
+	struct switch_enet_private *fep = priv->fep;
+	struct switch_t *fecp = fep->hwp;
+	int pkts, port;
+
+	pkts = mtip_switch_rx(napi->dev, budget, &port);
+	if (!fep->br_offload &&
+	    (port == 1 || port == 2) && fep->ndev[port - 1])
+		mtip_switch_tx(fep->ndev[port - 1]);
+	else
+		mtip_switch_tx(napi->dev);
+
+	if (pkts < budget) {
+		napi_complete_done(napi, pkts);
+		/* Set default interrupt mask for L2 switch */
+		writel(MCF_ESW_IMR_RXF | MCF_ESW_IMR_TXF,
+		       &fecp->ESW_IMR);
+	}
+	return pkts;
+}
+
+static int mtip_open(struct net_device *dev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	int ret, port_idx = priv->portnum - 1;
+
+	if (fep->usage_count == 0) {
+		clk_enable(fep->clk_ipg);
+		netif_napi_add(dev, &fep->napi, mtip_rx_napi);
+
+		ret = mtip_alloc_buffers(dev);
+		if (ret)
+			goto mtip_alloc_buffers_err;
+	}
+
+	fep->link[port_idx] = 0;
+
+	/* Probe and connect to PHY when open the interface, if already
+	 * NOT done in the switch driver probe (or when the device is
+	 * re-opened).
+	 */
+	ret = mtip_mii_probe(dev);
+	if (ret)
+		goto mtip_mii_probe_err;
+
+	phy_start(fep->phy_dev[port_idx]);
+
+	if (fep->usage_count == 0) {
+		napi_enable(&fep->napi);
+		mtip_switch_restart(dev, 1, 1);
+
+		fep->curr_time = 0;
+		netif_start_queue(dev);
+	}
+
+	fep->usage_count++;
+	return 0;
+
+ mtip_mii_probe_err:
+	mtip_free_buffers(dev);
+ mtip_alloc_buffers_err:
+	if (fep->usage_count == 0) {
+		netif_napi_del(&fep->napi);
+		clk_disable(fep->clk_ipg);
+	}
+	return ret;
+};
+
+static int mtip_close(struct net_device *dev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	int idx = priv->portnum - 1;
+
+	fep->link[idx] = 0;
+
+	if (fep->phy_dev[idx]) {
+		phy_stop(fep->phy_dev[idx]);
+		netif_stop_queue(dev);
+		phy_disconnect(fep->phy_dev[idx]);
+		fep->phy_dev[idx] = NULL;
+	}
+
+	if (fep->usage_count == 1) {
+		napi_disable(&fep->napi);
+		netif_napi_del(&fep->napi);
+		mtip_free_buffers(dev);
+		clk_disable(fep->clk_ipg);
+	}
+
+	fep->usage_count--;
+
+	return 0;
+}
+
+#define FEC_HASH_BITS	6		/* #bits in hash */
+static void mtip_set_multicast_list(struct net_device *dev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	unsigned int hash_high = 0, hash_low = 0, crc;
+	struct switch_enet_private *fep = priv->fep;
+	void __iomem *enet_addr = fep->enet_addr;
+	struct netdev_hw_addr *ha;
+	unsigned char hash;
+
+	if (priv->portnum == 2)
+		enet_addr += MCF_ESW_ENET_PORT_OFFSET;
+
+	if (dev->flags & IFF_PROMISC) {
+		/* Promisc mode is required for switch */
+		dev_info(&dev->dev, "%s: IFF_PROMISC\n", __func__);
+		return;
+	}
+
+	if (dev->flags & IFF_ALLMULTI) {
+		dev_info(&dev->dev, "%s: IFF_ALLMULTI\n", __func__);
+
+		/* Allow all multicast addresses */
+		writel(0xffffffff, enet_addr + MCF_FEC_GRP_HASH_TABLE_HIGH);
+		writel(0xffffffff, enet_addr + MCF_FEC_GRP_HASH_TABLE_LOW);
+
+		return;
+	}
+
+	netdev_for_each_mc_addr(ha, dev) {
+		/* calculate crc32 value of mac address */
+		crc = ether_crc_le(dev->addr_len, ha->addr);
+
+		/* only upper 6 bits (FEC_HASH_BITS) are used
+		 * which point to specific bit in the hash registers
+		 */
+		hash = (crc >> (32 - FEC_HASH_BITS)) & 0x3f;
+
+		if (hash > 31)
+			hash_high |= 1 << (hash - 32);
+		else
+			hash_low |= 1 << hash;
+	}
+
+	writel(hash_high, enet_addr + MCF_FEC_GRP_HASH_TABLE_HIGH);
+	writel(hash_low, enet_addr + MCF_FEC_GRP_HASH_TABLE_LOW);
+}
+
+static int mtip_set_mac_address(struct net_device *dev, void *p)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	void __iomem *enet_addr = fep->enet_addr;
+	struct sockaddr *addr = p;
+
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+	eth_hw_addr_set(dev, addr->sa_data);
+
+	if (priv->portnum == 2)
+		enet_addr += MCF_ESW_ENET_PORT_OFFSET;
+
+	writel(dev->dev_addr[3] | (dev->dev_addr[2] << 8) |
+	       (dev->dev_addr[1] << 16) | (dev->dev_addr[0] << 24),
+	       enet_addr + MCF_FEC_PALR);
+	writel((dev->dev_addr[5] << 16) | (dev->dev_addr[4] << 24),
+	       enet_addr + MCF_FEC_PAUR);
+
+	return mtip_update_atable_static((unsigned char *)dev->dev_addr,
+					 7, 7, fep);
+}
+
+static const struct ethtool_ops mtip_ethtool_ops = {
+	.get_link_ksettings     = phy_ethtool_get_link_ksettings,
+	.set_link_ksettings     = phy_ethtool_set_link_ksettings,
+	.get_drvinfo            = mtip_get_drvinfo,
+	.get_link               = ethtool_op_get_link,
+	.get_ts_info		= ethtool_op_get_ts_info,
+};
+
+static const struct net_device_ops mtip_netdev_ops = {
+	.ndo_open		= mtip_open,
+	.ndo_stop		= mtip_close,
+	.ndo_start_xmit	= mtip_start_xmit,
+	.ndo_set_rx_mode	= mtip_set_multicast_list,
+	.ndo_tx_timeout	= mtip_timeout,
+	.ndo_set_mac_address	= mtip_set_mac_address,
+};
+
+bool mtip_is_switch_netdev_port(const struct net_device *ndev)
+{
+	if (ndev->netdev_ops == &mtip_netdev_ops)
+		return true;
+
+	return false;
+}
+
+static int __init mtip_switch_dma_init(struct switch_enet_private *fep)
+{
+	struct cbd_t *bdp, *cbd_base;
+	int ret, i;
+
+	/* Check mask of the streaming and coherent API */
+	ret = dma_set_mask_and_coherent(&fep->pdev->dev, DMA_BIT_MASK(32));
+	if (ret < 0) {
+		dev_err(&fep->pdev->dev, "No suitable DMA available\n");
+		return ret;
+	}
+
+	/* Allocate memory for buffer descriptors */
+	cbd_base = dma_alloc_coherent(&fep->pdev->dev, PAGE_SIZE, &fep->bd_dma,
+				      GFP_KERNEL);
+	if (!cbd_base)
+		return -ENOMEM;
+
+	/* Set receive and transmit descriptor base */
+	fep->rx_bd_base = cbd_base;
+	fep->tx_bd_base = cbd_base + RX_RING_SIZE;
+
+	/* Initialize the receive buffer descriptors */
+	bdp = fep->rx_bd_base;
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		bdp->cbd_sc = 0;
+		bdp++;
+	}
+
+	/* Set the last buffer to wrap */
+	bdp--;
+	bdp->cbd_sc |= BD_SC_WRAP;
+
+	/* ...and the same for transmmit */
+	bdp = fep->tx_bd_base;
+	for (i = 0; i < TX_RING_SIZE; i++) {
+		/* Initialize the BD for every fragment in the page */
+		bdp->cbd_sc = 0;
+		bdp->cbd_bufaddr = 0;
+		bdp++;
+	}
+
+	/* Set the last buffer to wrap */
+	bdp--;
+	bdp->cbd_sc |= BD_SC_WRAP;
+
+	return 0;
+}
+
+static void mtip_ndev_cleanup(struct switch_enet_private *fep)
+{
+	int i;
+
+	for (i = 0; i < SWITCH_EPORT_NUMBER; i++) {
+		if (fep->ndev[i]) {
+			unregister_netdev(fep->ndev[i]);
+			free_netdev(fep->ndev[i]);
+		}
+	}
+}
+
+static int mtip_ndev_init(struct switch_enet_private *fep)
+{
+	struct mtip_ndev_priv *priv;
+	int i, ret = 0;
+
+	for (i = 0; i < SWITCH_EPORT_NUMBER; i++) {
+		fep->ndev[i] = alloc_netdev(sizeof(struct mtip_ndev_priv),
+					    fep->ndev_name[i], NET_NAME_USER,
+					    ether_setup);
+		if (!fep->ndev[i]) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		fep->ndev[i]->ethtool_ops = &mtip_ethtool_ops;
+		fep->ndev[i]->netdev_ops = &mtip_netdev_ops;
+
+		priv = netdev_priv(fep->ndev[i]);
+		priv->dev = fep->ndev[i];
+		priv->fep = fep;
+		priv->portnum = i + 1;
+		fep->ndev[i]->irq = fep->irq;
+
+		ret = mtip_setup_mac(fep->ndev[i]);
+		if (ret) {
+			dev_err(&fep->ndev[i]->dev,
+				"%s: ndev %s MAC setup err: %d\n",
+				__func__, fep->ndev[i]->name, ret);
+			break;
+		}
+
+		ret = register_netdev(fep->ndev[i]);
+		if (ret) {
+			dev_err(&fep->ndev[i]->dev,
+				"%s: ndev %s register err: %d\n", __func__,
+				fep->ndev[i]->name, ret);
+			break;
+		}
+		dev_dbg(&fep->ndev[i]->dev, "%s: MTIP eth L2 switch %pM\n",
+			fep->ndev[i]->name, fep->ndev[i]->dev_addr);
+	}
+
+	if (ret)
+		mtip_ndev_cleanup(fep);
+
+	return ret;
+}
+
+static int mtip_parse_of(struct switch_enet_private *fep,
+			 struct device_node *np)
+{
+	struct device_node *p;
+	unsigned int port_num;
+	int ret;
+
+	p = of_find_node_by_name(np, "ethernet-ports");
+
+	for_each_available_child_of_node_scoped(p, port) {
+		if (of_property_read_u32(port, "reg", &port_num))
+			continue;
+
+		fep->n_ports = port_num;
+		of_get_mac_address(port, &fep->mac[port_num - 1][0]);
+
+		ret = of_property_read_string(port, "label",
+					      &fep->ndev_name[port_num - 1]);
+		if (ret < 0) {
+			dev_err(&fep->pdev->dev,
+				"%s: Cannot get ethernet port name (%d)!\n",
+				__func__, ret);
+			goto of_get_err;
+		}
+
+		ret = of_get_phy_mode(port, &fep->phy_interface[port_num - 1]);
+		if (ret < 0) {
+			dev_err(&fep->pdev->dev,
+				"%s: Cannot get PHY mode (%d)!\n", __func__,
+				ret);
+			goto of_get_err;
+		}
+
+		fep->phy_np[port_num - 1] = of_parse_phandle(port,
+							     "phy-handle", 0);
+	}
+
+ of_get_err:
+	of_node_put(p);
+
+	return 0;
+}
+
+static int mtip_sw_learning(void *arg)
+{
+	struct switch_enet_private *fep = arg;
+
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		/* check learning record valid */
+		mtip_atable_dynamicms_learn_migration(fep, fep->curr_time,
+						      NULL, NULL);
+		schedule_timeout(HZ / 100);
+	}
+
+	return 0;
+}
+
+static void mtip_mii_unregister(struct switch_enet_private *fep)
+{
+	mdiobus_unregister(fep->mii_bus);
+	mdiobus_free(fep->mii_bus);
+}
+
+static const struct mtip_devinfo mtip_imx28_l2switch_info = {
+	.quirks = FEC_QUIRK_BUG_CAPTURE | FEC_QUIRK_SINGLE_MDIO,
+};
+
+static const struct of_device_id mtipl2_of_match[] = {
+	{ .compatible = "nxp,imx28-mtip-switch",
+	  .data = &mtip_imx28_l2switch_info},
+	{ /* sentinel */ }
+}
+MODULE_DEVICE_TABLE(of, mtipl2_of_match);
+
+static int mtip_sw_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *of_id;
+	struct switch_enet_private *fep;
+	struct mtip_devinfo *dev_info;
+	struct switch_t *fecp;
+	int ret;
+
+	fep = devm_kzalloc(&pdev->dev, sizeof(*fep), GFP_KERNEL);
+	if (!fep)
+		return -ENOMEM;
+
+	of_id = of_match_node(mtipl2_of_match, pdev->dev.of_node);
+	if (of_id) {
+		dev_info = (struct mtip_devinfo *)of_id->data;
+		if (dev_info)
+			fep->quirks = dev_info->quirks;
+	}
+
+	fep->pdev = pdev;
+	platform_set_drvdata(pdev, fep);
+
+	fep->enet_addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(fep->enet_addr))
+		return PTR_ERR(fep->enet_addr);
+
+	fep->irq = platform_get_irq(pdev, 0);
+	if (fep->irq < 0)
+		return fep->irq;
+
+	ret = mtip_parse_of(fep, np);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "%s: OF parse error (%d)!\n", __func__,
+			ret);
+		return ret;
+	}
+
+	/* Create an Ethernet device instance.
+	 * The switch lookup address memory starts at 0x800FC000
+	 */
+	fep->hwp_enet = fep->enet_addr;
+	fecp = (struct switch_t *)(fep->enet_addr + ENET_SWI_PHYS_ADDR_OFFSET);
+
+	fep->hwp = fecp;
+	fep->hwentry = (struct mtip_addr_table_t *)
+		((unsigned long)fecp + MCF_ESW_LOOKUP_MEM_OFFSET);
+
+	ret = devm_regulator_get_enable_optional(&pdev->dev, "phy");
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Unable to get and enable 'phy'\n");
+
+	fep->clk_ipg = devm_clk_get_enabled(&pdev->dev, "ipg");
+	if (IS_ERR(fep->clk_ipg))
+		return dev_err_probe(&pdev->dev, PTR_ERR(fep->clk_ipg),
+				     "Unable to acquire 'ipg' clock\n");
+
+	fep->clk_ahb = devm_clk_get_enabled(&pdev->dev, "ahb");
+	if (IS_ERR(fep->clk_ahb))
+		return dev_err_probe(&pdev->dev, PTR_ERR(fep->clk_ahb),
+				     "Unable to acquire 'ahb' clock\n");
+
+	fep->clk_enet_out = devm_clk_get_optional_enabled(&pdev->dev,
+							  "enet_out");
+	if (IS_ERR(fep->clk_enet_out))
+		return dev_err_probe(&pdev->dev, PTR_ERR(fep->clk_enet_out),
+				     "Unable to acquire 'enet_out' clock\n");
+
+	/* setup MII interface for external switch ports */
+	mtip_enet_init(fep, 1);
+	mtip_enet_init(fep, 2);
+
+	spin_lock_init(&fep->learn_lock);
+	spin_lock_init(&fep->hw_lock);
+	spin_lock_init(&fep->mii_lock);
+
+	ret = devm_request_irq(&pdev->dev, fep->irq, mtip_interrupt, 0,
+			       "mtip_l2sw", fep);
+	if (ret)
+		return dev_err_probe(&pdev->dev, fep->irq,
+				     "Could not alloc IRQ\n");
+
+	ret = mtip_register_notifiers(fep);
+	if (ret)
+		return ret;
+
+	ret = mtip_ndev_init(fep);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: Failed to create virtual ndev (%d)\n",
+			__func__, ret);
+		goto ndev_init_err;
+	}
+
+	ret = mtip_switch_dma_init(fep);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: ethernet switch init fail (%d)!\n",
+			__func__, ret);
+		goto dma_init_err;
+	}
+
+	ret = mtip_mii_init(fep, pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: Cannot init phy bus (%d)!\n", __func__,
+			ret);
+		goto mii_init_err;
+	}
+	/* setup timer for learning aging function */
+	timer_setup(&fep->timer_aging, mtip_aging_timer, 0);
+	mod_timer(&fep->timer_aging,
+		  jiffies + msecs_to_jiffies(LEARNING_AGING_INTERVAL));
+
+	fep->task = kthread_run(mtip_sw_learning, fep, "mtip_l2sw_learning");
+	if (IS_ERR(fep->task)) {
+		ret = PTR_ERR(fep->task);
+		dev_err(&pdev->dev, "%s: learning kthread_run error (%d)!\n",
+			__func__, ret);
+		goto task_learning_err;
+	}
+
+	return 0;
+
+ task_learning_err:
+	timer_delete_sync(&fep->timer_aging);
+	mtip_mii_unregister(fep);
+ mii_init_err:
+ dma_init_err:
+	mtip_ndev_cleanup(fep);
+ ndev_init_err:
+	mtip_unregister_notifiers(fep);
+
+	return ret;
+}
+
+static void mtip_sw_remove(struct platform_device *pdev)
+{
+	struct switch_enet_private *fep = platform_get_drvdata(pdev);
+
+	mtip_unregister_notifiers(fep);
+	mtip_ndev_cleanup(fep);
+
+	mtip_mii_remove(fep);
+
+	kthread_stop(fep->task);
+	timer_delete_sync(&fep->timer_aging);
+	platform_set_drvdata(pdev, NULL);
+
+	kfree(fep);
+}
+
+static struct platform_driver mtipl2plat_driver = {
+	.driver         = {
+		.name   = "mtipl2sw",
+		.of_match_table = mtipl2_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe          = mtip_sw_probe,
+	.remove         = mtip_sw_remove,
+};
+
+module_platform_driver(mtipl2plat_driver);
+
+MODULE_AUTHOR("Lukasz Majewski <lukma@denx.de>");
+MODULE_DESCRIPTION("Driver for MTIP L2 on SOC switch");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
new file mode 100644
index 000000000000..e9c8655676fd
--- /dev/null
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
@@ -0,0 +1,782 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 DENX Software Engineering GmbH
+ * Lukasz Majewski <lukma@denx.de>
+ */
+
+#ifndef __MTIP_L2SWITCH_H_
+#define __MTIP_L2SWITCH_H_
+
+#include <linux/clocksource.h>
+#include <linux/net_tstamp.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/timecounter.h>
+#include <linux/netdevice.h>
+#include <linux/phy.h>
+
+#define PKT_MAXBUF_SIZE         1518
+#define PKT_MINBUF_SIZE         64
+#define PKT_MAXBLR_SIZE         1520
+
+/* The number of Tx and Rx buffers. These are allocated from the page
+ * pool. The code may assume these are power of two, so it is best
+ * to keep them that size.
+ * We don't need to allocate pages for the transmitter.  We just use
+ * the skbuffer directly.
+ */
+#define MTIP_SWITCH_RX_PAGES       8
+#define MTIP_SWITCH_RX_FRSIZE      2048
+#define MTIP_SWITCH_RX_FRPPG       (PAGE_SIZE / MTIP_SWITCH_RX_FRSIZE)
+#define RX_RING_SIZE            (MTIP_SWITCH_RX_FRPPG * MTIP_SWITCH_RX_PAGES)
+#define MTIP_SWITCH_TX_FRSIZE      2048
+#define MTIP_SWITCH_TX_FRPPG       (PAGE_SIZE / MTIP_SWITCH_TX_FRSIZE)
+
+#define TX_RING_SIZE            16      /* Must be power of two */
+#define TX_RING_MOD_MASK        15      /*   for this to work */
+
+#define SWITCH_EPORT_NUMBER	2
+
+#if (((RX_RING_SIZE + TX_RING_SIZE) * 8) > PAGE_SIZE)
+#error "L2SWITCH: descriptor ring size constants too large"
+#endif
+struct mtip_port_statistics_status {
+	/*outgoing frames discarded due to transmit queue congestion*/
+	unsigned long MCF_ESW_POQC;
+	/*incoming frames discarded due to VLAN domain mismatch*/
+	unsigned long MCF_ESW_PMVID;
+	/*incoming frames discarded due to untagged discard*/
+	unsigned long MCF_ESW_PMVTAG;
+	/*incoming frames discarded due port is in blocking state*/
+	unsigned long MCF_ESW_PBL;
+};
+
+struct switch_t {
+	unsigned long ESW_REVISION;
+	unsigned long ESW_SCRATCH;
+	unsigned long ESW_PER;
+	unsigned long reserved0[1];
+	unsigned long ESW_VLANV;
+	unsigned long ESW_DBCR;
+	unsigned long ESW_DMCR;
+	unsigned long ESW_BKLR;
+	unsigned long ESW_BMPC;
+	unsigned long ESW_MODE;
+	unsigned long ESW_VIMSEL;
+	unsigned long ESW_VOMSEL;
+	unsigned long ESW_VIMEN;
+	unsigned long ESW_VID;/*0x34*/
+	/*from 0x38 0x3C*/
+	unsigned long esw_reserved0[2];
+	unsigned long ESW_MCR;/*0x40*/
+	unsigned long ESW_EGMAP;
+	unsigned long ESW_INGMAP;
+	unsigned long ESW_INGSAL;
+	unsigned long ESW_INGSAH;
+	unsigned long ESW_INGDAL;
+	unsigned long ESW_INGDAH;
+	unsigned long ESW_ENGSAL;
+	unsigned long ESW_ENGSAH;
+	unsigned long ESW_ENGDAL;
+	unsigned long ESW_ENGDAH;
+	unsigned long ESW_MCVAL;/*0x6C*/
+	/*from 0x70--0x7C*/
+	unsigned long esw_reserved1[4];
+	unsigned long ESW_MMSR;/*0x80*/
+	unsigned long ESW_LMT;
+	unsigned long ESW_LFC;
+	unsigned long ESW_PCSR;
+	unsigned long ESW_IOSR;
+	unsigned long ESW_QWT;/*0x94*/
+	unsigned long esw_reserved2[1];/*0x98*/
+	unsigned long ESW_P0BCT;/*0x9C*/
+	/*from 0xA0-0xB8*/
+	unsigned long esw_reserved3[7];
+	unsigned long ESW_P0FFEN;/*0xBC*/
+	unsigned long ESW_PSNP[8];
+	unsigned long ESW_IPSNP[8];
+	unsigned long ESW_PVRES[3];
+	/*from 0x10C-0x13C*/
+	unsigned long esw_reserved4[13];
+	unsigned long ESW_IPRES;/*0x140*/
+	/*from 0x144-0x17C*/
+	unsigned long esw_reserved5[15];
+	unsigned long ESW_PRES[3];
+	/*from 0x18C-0x1FC*/
+	unsigned long esw_reserved6[29];
+	unsigned long ESW_PID[3];
+	/*from 0x20C-0x27C*/
+	unsigned long esw_reserved7[29];
+	unsigned long ESW_VRES[32];
+	unsigned long ESW_DISCN;/*0x300*/
+	unsigned long ESW_DISCB;
+	unsigned long ESW_NDISCN;
+	unsigned long ESW_NDISCB;/*0xFC0DC30C*/
+	struct mtip_port_statistics_status port_statistics_status[3];
+	/*from 0x340-0x400*/
+	unsigned long esw_reserved8[48];
+	/*0xFC0DC400---0xFC0DC418*/
+	unsigned long ESW_ISR;
+	unsigned long ESW_IMR;
+	unsigned long ESW_RDSR;
+	unsigned long ESW_TDSR;
+	unsigned long ESW_MRBR;
+	unsigned long ESW_RDAR;
+	unsigned long ESW_TDAR;
+	/*from 0x420-0x4FC*/
+	unsigned long esw_reserved9[57];
+	/*0xFC0DC500---0xFC0DC508*/
+	unsigned long ESW_LREC0;
+	unsigned long ESW_LREC1;
+	unsigned long ESW_LSR;
+};
+
+struct  addr_table64b_entry {
+	unsigned int lo;  /* lower 32 bits */
+	unsigned int hi;  /* upper 32 bits */
+};
+
+struct  mtip_addr_table_t {
+	struct addr_table64b_entry  mtip_table64b_entry[2048];
+};
+
+#define MCF_ESW_LOOKUP_MEM_OFFSET      0x4000
+#define MCF_ESW_ENET_PORT_OFFSET      0x4000
+#define ENET_SWI_PHYS_ADDR_OFFSET	0x8000
+#define MCF_ESW_PER	(0x08)
+#define MCF_ESW_DBCR	(0x14)
+#define MCF_ESW_IMR	(0x404)
+
+#define MCF_FEC_BASE_ADDR	(fep->enet_addr)
+#define MCF_FEC_EIR		(0x04)
+#define MCF_FEC_EIMR		(0x08)
+#define MCF_FEC_MMFR		(0x40)
+#define MCF_FEC_MSCR		(0x44)
+
+#define MCF_FEC_RCR		(0x84)
+#define MCF_FEC_TCR		(0xC4)
+#define MCF_FEC_ECR		(0x24)
+
+#define MCF_FEC_PALR          (0xE4)
+#define MCF_FEC_PAUR          (0xE8)
+
+#define MCF_FEC_ERDSR         (0x180)
+#define MCF_FEC_ETDSR         (0x184)
+
+#define MCF_FEC_IAUR          (0x118)
+#define MCF_FEC_IALR          (0x11C)
+
+#define MCF_FEC_GAUR          (0x120)
+#define MCF_FEC_GALR          (0x124)
+
+#define MCF_FEC_EMRBR         (0x188)
+
+#define MCF_FEC_RCR_DRT	  BIT(1)
+#define MCF_FEC_RCR_MII_MODE      BIT(2)
+#define MCF_FEC_RCR_PROM          BIT(3)
+#define MCF_FEC_RCR_FCE	  BIT(5)
+#define MCF_FEC_RCR_RMII_MODE     BIT(8)
+#define MCF_FEC_RCR_RMII_10BASET  BIT(9)
+#define MCF_FEC_RCR_MAX_FL(x)     (((x) & 0x00003FFF) << 16)
+#define MCF_FEC_RCR_CRC_FWD       BIT(14)
+#define MCF_FEC_RCR_NO_LGTH_CHECK BIT(30)
+#define MCF_FEC_TCR_FDEN          BIT(2)
+
+#define MCF_FEC_ECR_RESET      BIT(0)
+#define MCF_FEC_ECR_ETHER_EN   BIT(1)
+#define MCF_FEC_ECR_MAGIC_ENA  BIT(2)
+#define MCF_FEC_ECR_ENA_1588   BIT(4)
+
+#define MTIP_ALIGNMENT   0xf
+#define MCF_ENET_MII	BIT(23)
+
+/* FEC MII MMFR bits definition */
+#define FEC_MMFR_ST             BIT(30)
+#define FEC_MMFR_OP_READ        BIT(29)
+#define FEC_MMFR_OP_WRITE       BIT(28)
+#define FEC_MMFR_PA(v)          (((v) & 0x1F) << 23)
+#define FEC_MMFR_RA(v)          (((v) & 0x1F) << 18)
+#define FEC_MMFR_TA             (2 << 16)
+#define FEC_MMFR_DATA(v)        ((v) & 0xffff)
+
+/* Port 0 backpressure congestion threshold */
+#define P0BC_THRESHOLD		0x40
+#define LEARNING_AGING_INTERVAL 100
+/* Info received from Hardware Learning FIFO,
+ * holding MAC address and corresponding Hash Value and
+ * port number where the frame was received (disassembled).
+ */
+struct mtip_port_info {
+	/* MAC lower 32 bits (first byte is 7:0). */
+	unsigned int   maclo;
+	/* MAC upper 16 bits (47:32). */
+	unsigned int   machi;
+	/* the hash value for this MAC address. */
+	unsigned int   hash;
+	/* the port number this MAC address is associated with. */
+	unsigned int   port;
+};
+
+/* Define the buffer descriptor structure. */
+struct cbd_t {
+	unsigned short	cbd_datlen;		/* Data length */
+	unsigned short	cbd_sc;			/* Control and status info */
+	unsigned long	cbd_bufaddr;		/* Buffer address */
+};
+
+/* The switch buffer descriptors track the ring buffers. The rx_bd_base and
+ * tx_bd_base always point to the base of the buffer descriptors.  The
+ * cur_rx and cur_tx point to the currently available buffer.
+ * The dirty_tx tracks the current buffer that is being sent by the
+ * controller. The cur_tx and dirty_tx are equal under both completely
+ * empty and completely full conditions.  The empty/ready indicator in
+ * the buffer descriptor determines the actual condition.
+ */
+struct switch_enet_private {
+	/* Base addresses for HW registers of the switch device */
+	void __iomem *hwp_enet;
+	struct switch_t  *hwp;
+	struct mtip_addr_table_t  *hwentry;
+	void __iomem *enet_addr;
+
+	struct platform_device *pdev;
+
+	/* Clocks */
+	struct clk *clk_ipg;
+	struct clk *clk_ahb;
+	struct clk *clk_enet_out;
+
+	/* skbuff */
+	unsigned char *tx_bounce[TX_RING_SIZE];
+	struct sk_buff *tx_skbuff[TX_RING_SIZE];
+	struct sk_buff *rx_skbuff[RX_RING_SIZE];
+	ushort skb_cur;
+	ushort skb_dirty;
+
+	/* DMA */
+	dma_addr_t bd_dma;
+	struct cbd_t *rx_bd_base;	/* Address of Rx and Tx buffers. */
+	struct cbd_t *tx_bd_base;
+	struct cbd_t *cur_rx, *cur_tx;	/* The next free ring entry */
+	struct cbd_t *dirty_tx;      /* The ring entries to be free()ed. */
+	uint tx_full;
+
+	/* Locking */
+	spinlock_t hw_lock; /* Lock for HW configuration */
+	spinlock_t mii_lock; /* Lock for MII operation */
+	spinlock_t learn_lock; /* Lock for learning DB adjustments */
+
+	/* NAPI support */
+	struct napi_struct napi;
+
+	/* Timer for Aging */
+	struct timer_list timer_aging;
+	struct task_struct *task;
+	int at_block_overflows;
+	int at_curr_entries;
+	int curr_time;
+
+	/* PHY and MDIO */
+	struct mii_bus *mii_bus;
+	struct phy_device *phy_dev[SWITCH_EPORT_NUMBER];
+	uint phy_speed;
+	int link[SWITCH_EPORT_NUMBER];
+	int full_duplex[SWITCH_EPORT_NUMBER];
+	phy_interface_t phy_interface[SWITCH_EPORT_NUMBER];
+	struct device_node *phy_np[SWITCH_EPORT_NUMBER];
+
+	/* IRQ number */
+	int irq;
+
+	/* lan[01] ports */
+	int n_ports;
+	const char *ndev_name[SWITCH_EPORT_NUMBER];
+	struct net_device *ndev[SWITCH_EPORT_NUMBER];
+	unsigned char mac[SWITCH_EPORT_NUMBER][ETH_ALEN];
+
+	/* Switch state */
+	u8 br_members; /* Bit field with active members */
+	u8 br_offload; /* Bridge in-HW offloading flag */
+	int usage_count; /* Number of configured ports */
+
+	/* Driver related */
+	u32 quirks;
+};
+
+struct mtip_ndev_priv {
+	int portnum;
+	struct net_device *dev;
+	struct net_device_stats stats;
+	struct net_device *master_dev;
+	struct switch_enet_private *fep;
+};
+
+#define MCF_FEC_MII_DATA	0x040 /* MII manage frame reg */
+#define MCF_FEC_GRP_HASH_TABLE_HIGH	0x120 /* High 32bits hash table */
+#define MCF_FEC_GRP_HASH_TABLE_LOW	0x124 /* Low 32bits hash table */
+
+#define BD_SC_EMPTY     ((ushort)0x8000) /* Receive is empty */
+#define BD_SC_READY     ((ushort)0x8000) /* Transmit is ready */
+#define BD_SC_WRAP      ((ushort)0x2000) /* Last buffer descriptor */
+#define BD_SC_INTRPT    ((ushort)0x1000) /* Interrupt on change */
+#define BD_SC_CM        ((ushort)0x0200) /* Continuous mode */
+#define BD_SC_ID        ((ushort)0x0100) /* Rec'd too many idles */
+#define BD_SC_P         ((ushort)0x0100) /* xmt preamble */
+#define BD_SC_BR        ((ushort)0x0020) /* Break received */
+#define BD_SC_FR        ((ushort)0x0010) /* Framing error */
+#define BD_SC_PR        ((ushort)0x0008) /* Parity error */
+#define BD_SC_OV        ((ushort)0x0002) /* Overrun */
+#define BD_SC_CD        ((ushort)0x0001)
+
+/* Buffer descriptor control/status used by Ethernet receive. */
+#define BD_ENET_RX_EMPTY        ((ushort)0x8000)
+#define BD_ENET_RX_WRAP         ((ushort)0x2000)
+#define BD_ENET_RX_INTR         ((ushort)0x1000)
+#define BD_ENET_RX_LAST         ((ushort)0x0800)
+#define BD_ENET_RX_FIRST        ((ushort)0x0400)
+#define BD_ENET_RX_MISS         ((ushort)0x0100)
+#define BD_ENET_RX_LG           ((ushort)0x0020)
+#define BD_ENET_RX_NO           ((ushort)0x0010)
+#define BD_ENET_RX_SH           ((ushort)0x0008)
+#define BD_ENET_RX_CR           ((ushort)0x0004)
+#define BD_ENET_RX_OV           ((ushort)0x0002)
+#define BD_ENET_RX_CL           ((ushort)0x0001)
+/* All status bits */
+#define BD_ENET_RX_STATS        ((ushort)0x013f)
+
+/* Buffer descriptor control/status used by Ethernet transmit.*/
+#define BD_ENET_TX_READY        ((ushort)0x8000)
+#define BD_ENET_TX_PAD          ((ushort)0x4000)
+#define BD_ENET_TX_WRAP         ((ushort)0x2000)
+#define BD_ENET_TX_INTR         ((ushort)0x1000)
+#define BD_ENET_TX_LAST         ((ushort)0x0800)
+#define BD_ENET_TX_TC           ((ushort)0x0400)
+#define BD_ENET_TX_DEF          ((ushort)0x0200)
+#define BD_ENET_TX_HB           ((ushort)0x0100)
+#define BD_ENET_TX_LC           ((ushort)0x0080)
+#define BD_ENET_TX_RL           ((ushort)0x0040)
+#define BD_ENET_TX_RCMASK       ((ushort)0x003c)
+#define BD_ENET_TX_UN           ((ushort)0x0002)
+#define BD_ENET_TX_CSL          ((ushort)0x0001)
+/* All status bits */
+#define BD_ENET_TX_STATS        ((ushort)0x03ff)
+
+/* Copy from validation code */
+#define RX_BUFFER_SIZE 256
+#define TX_BUFFER_SIZE 256
+
+#define TX_BD_R                 BIT(15)
+#define TX_BD_TO1               BIT(14)
+#define TX_BD_W                 BIT(13)
+#define TX_BD_TO2               BIT(12)
+#define TX_BD_L                 BIT(11)
+#define TX_BD_TC                BIT(10)
+
+#define TX_BD_INT       BIT(30)
+#define TX_BD_TS        BIT(29)
+#define TX_BD_PINS      BIT(28)
+#define TX_BD_IINS      BIT(27)
+#define TX_BD_TXE       BIT(15)
+#define TX_BD_UE        BIT(13)
+#define TX_BD_EE        BIT(12)
+#define TX_BD_FE        BIT(11)
+#define TX_BD_LCE       BIT(10)
+#define TX_BD_OE        BIT(9)
+#define TX_BD_TSE       BIT(8)
+#define TX_BD_BDU       BIT(31)
+
+#define RX_BD_E                 BIT(15)
+#define RX_BD_R01               BIT(14)
+#define RX_BD_W                 BIT(13)
+#define RX_BD_R02               BIT(12)
+#define RX_BD_L                 BIT(11)
+#define RX_BD_M                 BIT(8)
+#define RX_BD_BC                BIT(7)
+#define RX_BD_MC                BIT(6)
+#define RX_BD_LG                BIT(5)
+#define RX_BD_NO                BIT(4)
+#define RX_BD_CR                BIT(2)
+#define RX_BD_OV                BIT(1)
+#define RX_BD_TR                BIT(0)
+
+#define RX_BD_ME               BIT(31)
+#define RX_BD_PE               0x04000000
+#define RX_BD_CE               0x02000000
+#define RX_BD_UC               0x01000000
+#define RX_BD_INT              0x00800000
+#define RX_BD_ICE              BIT(5)
+#define RX_BD_PCR              BIT(4)
+#define RX_BD_VLAN             BIT(2)
+#define RX_BD_IPV6             BIT(1)
+#define RX_BD_FRAG             BIT(0)
+#define RX_BD_BDU              BIT(31)
+/****************************************************************************/
+
+/* Address Table size in bytes(2048 64bit entry ) */
+#define MTIP_ATABLE_MEM_SIZE         (2048 * 8)
+/* How many 64-bit elements fit in the address table */
+#define MTIP_ATABLE_MEM_NUM_ENTRIES  (2048)
+/* Address Table Maximum number of entries in each Slot */
+#define ATABLE_ENTRY_PER_SLOT 8
+/* log2(ATABLE_ENTRY_PER_SLOT)*/
+#define ATABLE_ENTRY_PER_SLOT_bits 3
+/* entry size in byte */
+#define ATABLE_ENTRY_SIZE     8
+/*  slot size in byte */
+#define ATABLE_SLOT_SIZE    (ATABLE_ENTRY_PER_SLOT * ATABLE_ENTRY_SIZE)
+/* width of timestamp variable (bits) within address table entry */
+#define AT_DENTRY_TIMESTAMP_WIDTH    10
+/* number of bits for port number storage */
+#define AT_DENTRY_PORT_WIDTH     4
+/* number of bits for port bitmask number storage */
+#define AT_SENTRY_PORT_WIDTH     11
+/* address table static entry port bitmask start address bit */
+#define AT_SENTRY_PORTMASK_shift     21
+/* address table static entry priority start address bit */
+#define AT_SENTRY_PRIO_shift     18
+/* address table dynamic entry port start address bit */
+#define AT_DENTRY_PORT_shift     28
+/* address table dynamic entry timestamp start address bit */
+#define AT_DENTRY_TIME_shift     18
+/* address table entry record type start address bit */
+#define AT_ENTRY_TYPE_shift     17
+/* address table entry record type bit: 1 static, 0 dynamic */
+#define AT_ENTRY_TYPE_STATIC      1
+#define AT_ENTRY_TYPE_DYNAMIC     0
+/* address table entry record valid start address bit */
+#define AT_ENTRY_VALID_shift     16
+#define AT_ENTRY_RECORD_VALID     1
+
+/* return block corresponding to the 8 bit hash value calculated */
+#define GET_BLOCK_PTR(hash)  ((hash) << 3)
+#define AT_EXTRACT_TIMESTAMP(x) \
+	(((x) >> AT_DENTRY_TIME_shift) & ((1 << AT_DENTRY_TIMESTAMP_WIDTH) - 1))
+#define AT_EXTRACT_PORT(x)   \
+	(((x) >> AT_DENTRY_PORT_shift) & ((1 << AT_DENTRY_PORT_WIDTH) - 1))
+#define TIMEDELTA(newtime, oldtime) \
+	(((newtime) - (oldtime)) & \
+	  ((1 << AT_DENTRY_TIMESTAMP_WIDTH) - 1))
+
+/* increment time value respecting modulo. */
+static inline int mtip_timeincrement(int time)
+{
+	return (time + 1) & ((1 << AT_DENTRY_TIMESTAMP_WIDTH) - 1);
+}
+
+/* ------------------------------------------------------------------------- */
+/* Bit definitions and macros for MCF_ESW_REVISION */
+#define MCF_MTIP_REVISION_CORE_REVISION(x)      ((x) & 0x0000FFFF)
+#define MCF_MTIP_REVISION_CUSTOMER_REVISION(x)  (((x) & 0xFFFF0000) >> 16)
+
+/* Bit definitions and macros for MCF_ESW_PER */
+#define MCF_ESW_PER_TE0                        BIT(0)
+#define MCF_ESW_PER_TE1                        BIT(1)
+#define MCF_ESW_PER_TE2                        BIT(2)
+#define MCF_ESW_PER_RE0                        BIT(16)
+#define MCF_ESW_PER_RE1                        BIT(17)
+#define MCF_ESW_PER_RE2                        BIT(18)
+
+/* Bit definitions and macros for MCF_ESW_VLANV */
+#define MCF_ESW_VLANV_VV0                      BIT(0)
+#define MCF_ESW_VLANV_VV1                      BIT(1)
+#define MCF_ESW_VLANV_VV2                      BIT(2)
+#define MCF_ESW_VLANV_DU0                      BIT(16)
+#define MCF_ESW_VLANV_DU1                      BIT(17)
+#define MCF_ESW_VLANV_DU2                      BIT(18)
+
+/* Bit definitions and macros for MCF_ESW_DBCR */
+#define MCF_ESW_DBCR_P0                        BIT(0)
+#define MCF_ESW_DBCR_P1                        BIT(1)
+#define MCF_ESW_DBCR_P2                        BIT(2)
+
+/* Bit definitions and macros for MCF_ESW_DMCR */
+#define MCF_ESW_DMCR_P0                        BIT(0)
+#define MCF_ESW_DMCR_P1                        BIT(1)
+#define MCF_ESW_DMCR_P2                        BIT(2)
+
+/* Bit definitions and macros for MCF_ESW_BKLR */
+#define MCF_ESW_BKLR_BE0                       BIT(0)
+#define MCF_ESW_BKLR_BE1                       BIT(1)
+#define MCF_ESW_BKLR_BE2                       BIT(2)
+#define MCF_ESW_BKLR_LD0                       BIT(16)
+#define MCF_ESW_BKLR_LD1                       BIT(17)
+#define MCF_ESW_BKLR_LD2                       BIT(18)
+
+/* Bit definitions and macros for MCF_ESW_BMPC */
+#define MCF_ESW_BMPC_PORT(x)                   (((x) & 0x0000000F) << 0)
+#define MCF_ESW_BMPC_MSG_TX                    BIT(5)
+#define MCF_ESW_BMPC_EN                        BIT(6)
+#define MCF_ESW_BMPC_DIS                       BIT(7)
+#define MCF_ESW_BMPC_PRIORITY(x)               (((x) & 0x00000007) << 13)
+#define MCF_ESW_BMPC_PORTMASK(x)               (((x) & 0x00000007) << 16)
+
+/* Bit definitions and macros for MCF_ESW_MODE */
+#define MCF_ESW_MODE_SW_RST                    BIT(0)
+#define MCF_ESW_MODE_SW_EN                     BIT(1)
+#define MCF_ESW_MODE_STOP                      BIT(7)
+#define MCF_ESW_MODE_CRC_TRAN                  BIT(8)
+#define MCF_ESW_MODE_P0CT                      BIT(9)
+#define MCF_ESW_MODE_STATRST                   BIT(31)
+
+/* Bit definitions and macros for MCF_ESW_VIMSEL */
+#define MCF_ESW_VIMSEL_IM0(x)                  (((x) & 0x00000003) << 0)
+#define MCF_ESW_VIMSEL_IM1(x)                  (((x) & 0x00000003) << 2)
+#define MCF_ESW_VIMSEL_IM2(x)                  (((x) & 0x00000003) << 4)
+
+/* Bit definitions and macros for MCF_ESW_VOMSEL */
+#define MCF_ESW_VOMSEL_OM0(x)                  (((x) & 0x00000003) << 0)
+#define MCF_ESW_VOMSEL_OM1(x)                  (((x) & 0x00000003) << 2)
+#define MCF_ESW_VOMSEL_OM2(x)                  (((x) & 0x00000003) << 4)
+
+/* Bit definitions and macros for MCF_ESW_VIMEN */
+#define MCF_ESW_VIMEN_EN0                      BIT(0)
+#define MCF_ESW_VIMEN_EN1                      BIT(1)
+#define MCF_ESW_VIMEN_EN2                      BIT(2)
+
+/* Bit definitions and macros for MCF_ESW_VID */
+#define MCF_ESW_VID_TAG(x)                     (((x) & 0xFFFFFFFF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_MCR */
+#define MCF_ESW_MCR_PORT(x)                    (((x) & 0x0000000F) << 0)
+#define MCF_ESW_MCR_MEN                        BIT(4)
+#define MCF_ESW_MCR_INGMAP                     BIT(5)
+#define MCF_ESW_MCR_EGMAP                      BIT(6)
+#define MCF_ESW_MCR_INGSA                      BIT(7)
+#define MCF_ESW_MCR_INGDA                      BIT(8)
+#define MCF_ESW_MCR_EGSA                       BIT(9)
+#define MCF_ESW_MCR_EGDA                       BIT(10)
+
+/* Bit definitions and macros for MCF_ESW_EGMAP */
+#define MCF_ESW_EGMAP_EG0                      BIT(0)
+#define MCF_ESW_EGMAP_EG1                      BIT(1)
+#define MCF_ESW_EGMAP_EG2                      BIT(2)
+
+/* Bit definitions and macros for MCF_ESW_INGMAP */
+#define MCF_ESW_INGMAP_ING0                    BIT(0)
+#define MCF_ESW_INGMAP_ING1                    BIT(1)
+#define MCF_ESW_INGMAP_ING2                    BIT(2)
+
+/* Bit definitions and macros for MCF_ESW_INGSAL */
+#define MCF_ESW_INGSAL_ADDLOW(x)               (((x) & 0xFFFFFFFF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_INGSAH */
+#define MCF_ESW_INGSAH_ADDHIGH(x)              (((x) & 0x0000FFFF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_INGDAL */
+#define MCF_ESW_INGDAL_ADDLOW(x)               (((x) & 0xFFFFFFFF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_INGDAH */
+#define MCF_ESW_INGDAH_ADDHIGH(x)              (((x) & 0x0000FFFF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_ENGSAL */
+#define MCF_ESW_ENGSAL_ADDLOW(x)               (((x) & 0xFFFFFFFF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_ENGSAH */
+#define MCF_ESW_ENGSAH_ADDHIGH(x)              (((x) & 0x0000FFFF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_ENGDAL */
+#define MCF_ESW_ENGDAL_ADDLOW(x)               (((x) & 0xFFFFFFFF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_ENGDAH */
+#define MCF_ESW_ENGDAH_ADDHIGH(x)              (((x) & 0x0000FFFF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_MCVAL */
+#define MCF_ESW_MCVAL_COUNT(x)                 (((x) & 0x000000FF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_MMSR */
+#define MCF_ESW_MMSR_BUSY                      BIT(0)
+#define MCF_ESW_MMSR_NOCELL                    BIT(1)
+#define MCF_ESW_MMSR_MEMFULL                   BIT(2)
+#define MCF_ESW_MMSR_MFLATCH                   BIT(3)
+#define MCF_ESW_MMSR_DQ_GRNT                   BIT(6)
+#define MCF_ESW_MMSR_CELLS_AVAIL(x)            (((x) & 0x000000FF) << 16)
+
+/* Bit definitions and macros for MCF_ESW_LMT */
+#define MCF_ESW_LMT_THRESH(x)                  (((x) & 0x000000FF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_LFC */
+#define MCF_ESW_LFC_COUNT(x)                   (((x) & 0xFFFFFFFF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_PCSR */
+#define MCF_ESW_PCSR_PC0                       BIT(0)
+#define MCF_ESW_PCSR_PC1                       BIT(1)
+#define MCF_ESW_PCSR_PC2                       BIT(2)
+
+/* Bit definitions and macros for MCF_ESW_IOSR */
+#define MCF_ESW_IOSR_OR0                       BIT(0)
+#define MCF_ESW_IOSR_OR1                       BIT(1)
+#define MCF_ESW_IOSR_OR2                       BIT(2)
+
+/* Bit definitions and macros for MCF_ESW_QWT */
+#define MCF_ESW_QWT_Q0WT(x)                    (((x) & 0x0000001F) << 0)
+#define MCF_ESW_QWT_Q1WT(x)                    (((x) & 0x0000001F) << 8)
+#define MCF_ESW_QWT_Q2WT(x)                    (((x) & 0x0000001F) << 16)
+#define MCF_ESW_QWT_Q3WT(x)                    (((x) & 0x0000001F) << 24)
+
+/* Bit definitions and macros for MCF_ESW_P0BCT */
+#define MCF_ESW_P0BCT_THRESH(x)                (((x) & 0x000000FF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_P0FFEN */
+#define MCF_ESW_P0FFEN_FEN                     BIT(0)
+#define MCF_ESW_P0FFEN_FD(x)                   (((x) & 0x00000003) << 2)
+
+/* Bit definitions and macros for MCF_ESW_PSNP */
+#define MCF_ESW_PSNP_EN                        BIT(0)
+#define MCF_ESW_PSNP_MODE(x)                   (((x) & 0x00000003) << 1)
+#define MCF_ESW_PSNP_CD                        BIT(3)
+#define MCF_ESW_PSNP_CS                        BIT(4)
+#define MCF_ESW_PSNP_PORT_COMPARE(x)           (((x) & 0x0000FFFF) << 16)
+
+/* Bit definitions and macros for MCF_ESW_IPSNP */
+#define MCF_ESW_IPSNP_EN                       BIT(0)
+#define MCF_ESW_IPSNP_MODE(x)                  (((x) & 0x00000003) << 1)
+#define MCF_ESW_IPSNP_PROTOCOL(x)              (((x) & 0x000000FF) << 8)
+
+/* Bit definitions and macros for MCF_ESW_PVRES */
+#define MCF_ESW_PVRES_PRI0(x)                  (((x) & 0x00000007) << 0)
+#define MCF_ESW_PVRES_PRI1(x)                  (((x) & 0x00000007) << 3)
+#define MCF_ESW_PVRES_PRI2(x)                  (((x) & 0x00000007) << 6)
+#define MCF_ESW_PVRES_PRI3(x)                  (((x) & 0x00000007) << 9)
+#define MCF_ESW_PVRES_PRI4(x)                  (((x) & 0x00000007) << 12)
+#define MCF_ESW_PVRES_PRI5(x)                  (((x) & 0x00000007) << 15)
+#define MCF_ESW_PVRES_PRI6(x)                  (((x) & 0x00000007) << 18)
+#define MCF_ESW_PVRES_PRI7(x)                  (((x) & 0x00000007) << 21)
+
+/* Bit definitions and macros for MCF_ESW_IPRES */
+#define MCF_ESW_IPRES_ADDRESS(x)               (((x) & 0x000000FF) << 0)
+#define MCF_ESW_IPRES_IPV4SEL                  BIT(8)
+#define MCF_ESW_IPRES_PRI0(x)                  (((x) & 0x00000003) << 9)
+#define MCF_ESW_IPRES_PRI1(x)                  (((x) & 0x00000003) << 11)
+#define MCF_ESW_IPRES_PRI2(x)                   (((x) & 0x00000003) << 13)
+#define MCF_ESW_IPRES_READ                     BIT(31)
+
+/* Bit definitions and macros for MCF_ESW_PRES */
+#define MCF_ESW_PRES_VLAN                      BIT(0)
+#define MCF_ESW_PRES_IP                        BIT(1)
+#define MCF_ESW_PRES_MAC                       BIT(2)
+#define MCF_ESW_PRES_DFLT_PRI(x)               (((x) & 0x00000007) << 4)
+
+/* Bit definitions and macros for MCF_ESW_PID */
+#define MCF_ESW_PID_VLANID(x)                  (((x) & 0x0000FFFF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_VRES */
+#define MCF_ESW_VRES_P0                        BIT(0)
+#define MCF_ESW_VRES_P1                        BIT(1)
+#define MCF_ESW_VRES_P2                        BIT(2)
+#define MCF_ESW_VRES_VLANID(x)                 (((x) & 0x00000FFF) << 3)
+
+/* Bit definitions and macros for MCF_ESW_DISCN */
+#define MCF_ESW_DISCN_COUNT(x)                 (((x) & 0xFFFFFFFF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_DISCB */
+#define MCF_ESW_DISCB_COUNT(x)                 (((x) & 0xFFFFFFFF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_NDISCN */
+#define MCF_ESW_NDISCN_COUNT(x)                (((x) & 0xFFFFFFFF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_NDISCB */
+#define MCF_ESW_NDISCB_COUNT(x)                (((x) & 0xFFFFFFFF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_POQC */
+#define MCF_ESW_POQC_COUNT(x)                  (((x) & 0xFFFFFFFF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_PMVID */
+#define MCF_ESW_PMVID_COUNT(x)                 (((x) & 0xFFFFFFFF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_PMVTAG */
+#define MCF_ESW_PMVTAG_COUNT(x)                (((x) & 0xFFFFFFFF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_PBL */
+#define MCF_ESW_PBL_COUNT(x)                   (((x) & 0xFFFFFFFF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_ISR */
+#define MCF_ESW_ISR_EBERR                      BIT(0)
+#define MCF_ESW_ISR_RXB                        BIT(1)
+#define MCF_ESW_ISR_RXF                        BIT(2)
+#define MCF_ESW_ISR_TXB                        BIT(3)
+#define MCF_ESW_ISR_TXF                        BIT(4)
+#define MCF_ESW_ISR_QM                         BIT(5)
+#define MCF_ESW_ISR_OD0                        BIT(6)
+#define MCF_ESW_ISR_OD1                        BIT(7)
+#define MCF_ESW_ISR_OD2                        BIT(8)
+#define MCF_ESW_ISR_LRN                        BIT(9)
+
+/* Bit definitions and macros for MCF_ESW_IMR */
+#define MCF_ESW_IMR_EBERR                      BIT(0)
+#define MCF_ESW_IMR_RXB                        BIT(1)
+#define MCF_ESW_IMR_RXF                        BIT(2)
+#define MCF_ESW_IMR_TXB                        BIT(3)
+#define MCF_ESW_IMR_TXF                        BIT(4)
+#define MCF_ESW_IMR_QM                         BIT(5)
+#define MCF_ESW_IMR_OD0                        BIT(6)
+#define MCF_ESW_IMR_OD1                        BIT(7)
+#define MCF_ESW_IMR_OD2                        BIT(8)
+#define MCF_ESW_IMR_LRN                        BIT(9)
+
+/* Bit definitions and macros for MCF_ESW_RDSR */
+#define MCF_ESW_RDSR_ADDRESS(x)                (((x) & 0x3FFFFFFF) << 2)
+
+/* Bit definitions and macros for MCF_ESW_TDSR */
+#define MCF_ESW_TDSR_ADDRESS(x)                (((x) & 0x3FFFFFFF) << 2)
+
+/* Bit definitions and macros for MCF_ESW_MRBR */
+#define MCF_ESW_MRBR_SIZE(x)                   (((x) & 0x000003FF) << 4)
+
+/* Bit definitions and macros for MCF_ESW_RDAR */
+#define MCF_ESW_RDAR_R_DES_ACTIVE              BIT(24)
+
+/* Bit definitions and macros for MCF_ESW_TDAR */
+#define MCF_ESW_TDAR_X_DES_ACTIVE              BIT(24)
+
+/* Bit definitions and macros for MCF_ESW_LREC0 */
+#define MCF_ESW_LREC0_MACADDR0(x)              (((x) & 0xFFFFFFFF) << 0)
+
+/* Bit definitions and macros for MCF_ESW_LREC1 */
+#define MCF_ESW_LREC1_MACADDR1(x)              (((x) & 0x0000FFFF) << 0)
+#define MCF_ESW_LREC1_HASH(x)                  (((x) & 0x000000FF) << 16)
+#define MCF_ESW_LREC1_SWPORT(x)                (((x) & 0x00000003) << 24)
+
+/* Bit definitions and macros for MCF_ESW_LSR */
+#define MCF_ESW_LSR_DA                         BIT(0)
+
+/* ENET Block Guide/ Chapter for the iMX6SX (PELE) address one issue:
+ * After set ENET_ATCR[Capture], there need some time cycles before the counter
+ * value is capture in the register clock domain.
+ * The wait-time-cycles is at least 6 clock cycles of the slower clock between
+ * the register clock and the 1588 clock. The 1588 ts_clk is fixed to 25Mhz,
+ * register clock is 66Mhz, so the wait-time-cycles must be greater than 240ns
+ * (40ns * 6).
+ */
+#define FEC_QUIRK_BUG_CAPTURE		BIT(10)
+/* Controller has only one MDIO bus */
+#define FEC_QUIRK_SINGLE_MDIO		BIT(11)
+
+/* Switch Management functions */
+int mtip_vlan_input_process(struct switch_enet_private *fep,
+			    int port, int mode, unsigned short port_vlanid,
+			    int vlan_verify_en, int vlan_domain_num,
+			    int vlan_domain_port);
+int mtip_set_vlan_verification(struct switch_enet_private *fep, int port,
+			       int vlan_domain_verify_en,
+			       int vlan_discard_unknown_en);
+int mtip_port_multicast_config(struct switch_enet_private *fep, int port,
+			       int enable);
+int mtip_vlan_output_process(struct switch_enet_private *fep, int port,
+			     int mode);
+int mtip_port_multicast_config(struct switch_enet_private *fep,
+			       int port, int enable);
+void mtip_switch_en_port_separation(struct switch_enet_private *fep);
+void mtip_switch_dis_port_separation(struct switch_enet_private *fep);
+int mtip_port_broadcast_config(struct switch_enet_private *fep,
+			       int port, int enable);
+int mtip_forced_forward(struct switch_enet_private *fep, int port, int enable);
+int mtip_port_learning_config(struct switch_enet_private *fep, int port,
+			      int disable, int irq_adj);
+int mtip_port_blocking_config(struct switch_enet_private *fep, int port,
+			      int enable);
+bool mtip_is_switch_netdev_port(const struct net_device *ndev);
+int mtip_register_notifiers(struct switch_enet_private *fep);
+void mtip_unregister_notifiers(struct switch_enet_private *fep);
+int mtip_port_enable_config(struct switch_enet_private *fep, int port,
+			    int tx_en, int rx_en);
+void mtip_clear_atable(struct switch_enet_private *fep);
+#endif /* __MTIP_L2SWITCH_H_ */
diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
new file mode 100644
index 000000000000..0b76a60858a5
--- /dev/null
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  L2 switch Controller driver for MTIP block - bridge network interface
+ *
+ *  Copyright (C) 2025 DENX Software Engineering GmbH
+ *  Lukasz Majewski <lukma@denx.de>
+ */
+
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/platform_device.h>
+
+#include "mtipl2sw.h"
+static int mtip_ndev_port_link(struct net_device *ndev,
+			       struct net_device *br_ndev,
+			       struct netlink_ext_ack *extack)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(ndev), *other_priv;
+	struct switch_enet_private *fep = priv->fep;
+	struct net_device *other_ndev;
+
+	/* Check if one port of MTIP switch is already bridged */
+	if (fep->br_members && !fep->br_offload) {
+		/* Get the second bridge ndev */
+		other_ndev = fep->ndev[fep->br_members - 1];
+		other_priv = netdev_priv(other_ndev);
+		if (other_priv->master_dev != br_ndev) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "L2 offloading only possible for the same bridge!");
+			return notifier_from_errno(-EOPNOTSUPP);
+		}
+
+		fep->br_offload = 1;
+		mtip_switch_dis_port_separation(fep);
+		mtip_clear_atable(fep);
+	}
+
+	if (!priv->master_dev)
+		priv->master_dev = br_ndev;
+
+	fep->br_members |= BIT(priv->portnum - 1);
+
+	dev_dbg(&ndev->dev,
+		"%s: ndev: %s br: %s fep: 0x%x members: 0x%x offload: %d\n",
+		__func__, ndev->name,  br_ndev->name, (unsigned int)fep,
+		fep->br_members, fep->br_offload);
+
+	return NOTIFY_DONE;
+}
+
+static void mtip_netdevice_port_unlink(struct net_device *ndev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(ndev);
+	struct switch_enet_private *fep = priv->fep;
+
+	dev_dbg(&ndev->dev, "%s: ndev: %s members: 0x%x\n", __func__,
+		ndev->name, fep->br_members);
+
+	fep->br_members &= ~BIT(priv->portnum - 1);
+	priv->master_dev = NULL;
+
+	if (!fep->br_members) {
+		fep->br_offload = 0;
+		mtip_switch_en_port_separation(fep);
+		mtip_clear_atable(fep);
+	}
+}
+
+/* netdev notifier */
+static int mtip_netdevice_event(struct notifier_block *unused,
+				unsigned long event, void *ptr)
+{
+	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_notifier_changeupper_info *info = ptr;
+	struct netlink_ext_ack *extack;
+	int ret = NOTIFY_DONE;
+
+	if (!mtip_is_switch_netdev_port(ndev))
+		return NOTIFY_DONE;
+
+	extack = netdev_notifier_info_to_extack(&info->info);
+
+	switch (event) {
+	case NETDEV_CHANGEUPPER:
+		if (!netif_is_bridge_master(info->upper_dev))
+			break;
+
+		if (info->linking)
+			ret = mtip_ndev_port_link(ndev, info->upper_dev,
+						  extack);
+		else
+			mtip_netdevice_port_unlink(ndev);
+
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return notifier_from_errno(ret);
+}
+
+static struct notifier_block mtip_netdevice_nb __read_mostly = {
+	.notifier_call = mtip_netdevice_event,
+};
+
+int mtip_register_notifiers(struct switch_enet_private *fep)
+{
+	int ret = 0;
+
+	ret = register_netdevice_notifier(&mtip_netdevice_nb);
+	if (ret) {
+		dev_err(&fep->pdev->dev, "can't register netdevice notifier\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+void mtip_unregister_notifiers(struct switch_enet_private *fep)
+{
+	unregister_netdevice_notifier(&mtip_netdevice_nb);
+}
diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c
new file mode 100644
index 000000000000..bd40522a9b53
--- /dev/null
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c
@@ -0,0 +1,449 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  L2 switch Controller driver for MTIP block - switch MGNT
+ *
+ *  Copyright (C) 2025 DENX Software Engineering GmbH
+ *  Lukasz Majewski <lukma@denx.de>
+ *
+ *  Based on a previous work by:
+ *
+ *  Copyright 2010-2012 Freescale Semiconductor, Inc.
+ *  Alison Wang (b18965@freescale.com)
+ *  Jason Jin (Jason.jin@freescale.com)
+ *
+ *  Copyright (C) 2010-2013 Freescale Semiconductor, Inc. All Rights Reserved.
+ *  Shrek Wu (B16972@freescale.com)
+ */
+
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/platform_device.h>
+
+#include "mtipl2sw.h"
+
+int mtip_vlan_input_process(struct switch_enet_private *fep,
+			    int port, int mode, unsigned short port_vlanid,
+			    int vlan_verify_en, int vlan_domain_num,
+			    int vlan_domain_port)
+{
+	struct switch_t *fecp = fep->hwp;
+
+	/* Only modes from 1 to 4 are valid*/
+	if (mode < 0 || mode > 4) {
+		dev_err(&fep->pdev->dev,
+			"%s: VLAN input processing mode (%d) not supported\n",
+			__func__, mode);
+		return -EINVAL;
+	}
+
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported!\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	if (vlan_verify_en == 1 &&
+	    (vlan_domain_num < 0 || vlan_domain_num > 32)) {
+		dev_err(&fep->pdev->dev, "%s: Domain out of range\n", __func__);
+		return -EINVAL;
+	}
+
+	fecp->ESW_PID[port] = MCF_ESW_PID_VLANID(port_vlanid);
+	if (port == 0) {
+		if (vlan_verify_en == 1)
+			writel(MCF_ESW_VRES_VLANID(port_vlanid) |
+			       MCF_ESW_VRES_P0,
+			       &fecp->ESW_VRES[vlan_domain_num]);
+
+		writel(readl(&fecp->ESW_VIMEN) | MCF_ESW_VIMEN_EN0,
+		       &fecp->ESW_VIMEN);
+		writel(readl(&fecp->ESW_VIMSEL) | MCF_ESW_VIMSEL_IM0(mode),
+		       &fecp->ESW_VIMSEL);
+	} else if (port == 1) {
+		if (vlan_verify_en == 1)
+			writel(MCF_ESW_VRES_VLANID(port_vlanid) |
+			       MCF_ESW_VRES_P1,
+			       &fecp->ESW_VRES[vlan_domain_num]);
+
+		writel(readl(&fecp->ESW_VIMEN) | MCF_ESW_VIMEN_EN1,
+		       &fecp->ESW_VIMEN);
+		writel(readl(&fecp->ESW_VIMSEL) | MCF_ESW_VIMSEL_IM1(mode),
+		       &fecp->ESW_VIMSEL);
+	} else if (port == 2) {
+		if (vlan_verify_en == 1)
+			writel(MCF_ESW_VRES_VLANID(port_vlanid) |
+			       MCF_ESW_VRES_P2,
+			       &fecp->ESW_VRES[vlan_domain_num]);
+
+		writel(readl(&fecp->ESW_VIMEN) | MCF_ESW_VIMEN_EN2,
+		       &fecp->ESW_VIMEN);
+		writel(readl(&fecp->ESW_VIMSEL) | MCF_ESW_VIMSEL_IM2(mode),
+		       &fecp->ESW_VIMSEL);
+	}
+
+	return 0;
+}
+
+int mtip_vlan_output_process(struct switch_enet_private *fep, int port,
+			     int mode)
+{
+	struct switch_t *fecp = fep->hwp;
+
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported!\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	if (port == 0) {
+		writel(readl(&fecp->ESW_VOMSEL) | MCF_ESW_VOMSEL_OM0(mode),
+		       &fecp->ESW_VOMSEL);
+	} else if (port == 1) {
+		writel(readl(&fecp->ESW_VOMSEL) | MCF_ESW_VOMSEL_OM1(mode),
+		       &fecp->ESW_VOMSEL);
+	} else if (port == 2) {
+		writel(readl(&fecp->ESW_VOMSEL) | MCF_ESW_VOMSEL_OM2(mode),
+		       &fecp->ESW_VOMSEL);
+	}
+
+	return 0;
+}
+
+int mtip_set_vlan_verification(struct switch_enet_private *fep, int port,
+			       int vlan_domain_verify_en,
+			       int vlan_discard_unknown_en)
+{
+	struct switch_t *fecp = fep->hwp;
+
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported!\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	if (vlan_domain_verify_en == 1) {
+		if (port == 0)
+			writel(readl(&fecp->ESW_VLANV) | MCF_ESW_VLANV_VV0,
+			       &fecp->ESW_VLANV);
+		else if (port == 1)
+			writel(readl(&fecp->ESW_VLANV) | MCF_ESW_VLANV_VV1,
+			       &fecp->ESW_VLANV);
+		else if (port == 2)
+			writel(readl(&fecp->ESW_VLANV) | MCF_ESW_VLANV_VV2,
+			       &fecp->ESW_VLANV);
+	} else if (vlan_domain_verify_en == 0) {
+		if (port == 0)
+			writel(readl(&fecp->ESW_VLANV) & ~MCF_ESW_VLANV_VV0,
+			       &fecp->ESW_VLANV);
+		else if (port == 1)
+			writel(readl(&fecp->ESW_VLANV) & ~MCF_ESW_VLANV_VV1,
+			       &fecp->ESW_VLANV);
+		else if (port == 2)
+			writel(readl(&fecp->ESW_VLANV) & ~MCF_ESW_VLANV_VV2,
+			       &fecp->ESW_VLANV);
+	}
+
+	if (vlan_discard_unknown_en == 1) {
+		if (port == 0)
+			writel(readl(&fecp->ESW_VLANV) | MCF_ESW_VLANV_DU0,
+			       &fecp->ESW_VLANV);
+		else if (port == 1)
+			writel(readl(&fecp->ESW_VLANV) | MCF_ESW_VLANV_DU1,
+			       &fecp->ESW_VLANV);
+		else if (port == 2)
+			writel(readl(&fecp->ESW_VLANV) | MCF_ESW_VLANV_DU2,
+			       &fecp->ESW_VLANV);
+	} else if (vlan_discard_unknown_en == 0) {
+		if (port == 0)
+			writel(readl(&fecp->ESW_VLANV) & ~MCF_ESW_VLANV_DU0,
+			       &fecp->ESW_VLANV);
+		else if (port == 1)
+			writel(readl(&fecp->ESW_VLANV) & ~MCF_ESW_VLANV_DU1,
+			       &fecp->ESW_VLANV);
+		else if (port == 2)
+			writel(readl(&fecp->ESW_VLANV) & ~MCF_ESW_VLANV_DU2,
+			       &fecp->ESW_VLANV);
+	}
+
+	dev_dbg(&fep->pdev->dev, "%s: ESW_VLANV %#lx\n", __func__,
+		fecp->ESW_VLANV);
+
+	return 0;
+}
+
+int mtip_port_multicast_config(struct switch_enet_private *fep,
+			       int port, int enable)
+{
+	struct switch_t *fecp = fep->hwp;
+	u32 tmp = 0;
+
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	tmp = readl(&fecp->ESW_DMCR);
+	if (enable == 1) {
+		if (port == 0)
+			tmp |= MCF_ESW_DMCR_P0;
+		else if (port == 1)
+			tmp |= MCF_ESW_DMCR_P1;
+		else if (port == 2)
+			tmp |= MCF_ESW_DMCR_P2;
+	} else if (enable == 0) {
+		if (port == 0)
+			tmp &= ~MCF_ESW_DMCR_P0;
+		else if (port == 1)
+			tmp &= ~MCF_ESW_DMCR_P1;
+		else if (port == 2)
+			tmp &= ~MCF_ESW_DMCR_P2;
+	}
+
+	writel(tmp, &fecp->ESW_DMCR);
+	return 0;
+}
+
+/* enable or disable port n tx or rx
+ * tx_en 0 disable port n tx
+ * tx_en 1 enable  port n tx
+ * rx_en 0 disable port n rx
+ * rx_en 1 enable  port n rx
+ */
+int mtip_port_enable_config(struct switch_enet_private *fep, int port,
+			    int tx_en, int rx_en)
+{
+	struct switch_t *fecp = fep->hwp;
+	u32 tmp = 0;
+
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	tmp = readl(&fecp->ESW_PER);
+	if (tx_en == 1) {
+		if (port == 0)
+			tmp |= MCF_ESW_PER_TE0;
+		else if (port == 1)
+			tmp |= MCF_ESW_PER_TE1;
+		else if (port == 2)
+			tmp |= MCF_ESW_PER_TE2;
+	} else if (tx_en == 0) {
+		if (port == 0)
+			tmp &= (~MCF_ESW_PER_TE0);
+		else if (port == 1)
+			tmp &= (~MCF_ESW_PER_TE1);
+		else if (port == 2)
+			tmp &= (~MCF_ESW_PER_TE2);
+	}
+
+	if (rx_en == 1) {
+		if (port == 0)
+			tmp |= MCF_ESW_PER_RE0;
+		else if (port == 1)
+			tmp |= MCF_ESW_PER_RE1;
+		else if (port == 2)
+			tmp |= MCF_ESW_PER_RE2;
+	} else if (rx_en == 0) {
+		if (port == 0)
+			tmp &= (~MCF_ESW_PER_RE0);
+		else if (port == 1)
+			tmp &= (~MCF_ESW_PER_RE1);
+		else if (port == 2)
+			tmp &= (~MCF_ESW_PER_RE2);
+	}
+
+	writel(tmp, &fecp->ESW_PER);
+	return 0;
+}
+
+void mtip_switch_en_port_separation(struct switch_enet_private *fep)
+{
+	struct switch_t *fecp = fep->hwp;
+	u32 tmp;
+
+	mtip_vlan_input_process(fep, 0, 3, 0x10, 1, 0, 0);
+	mtip_vlan_input_process(fep, 1, 3, 0x11, 1, 1, 0);
+	mtip_vlan_input_process(fep, 2, 3, 0x12, 1, 2, 0);
+
+	tmp = readl(&fecp->ESW_VRES[0]);
+	writel(tmp | MCF_ESW_VRES_P1 | MCF_ESW_VRES_P2,
+	       &fecp->ESW_VRES[0]);
+
+	tmp = readl(&fecp->ESW_VRES[1]);
+	writel(tmp | MCF_ESW_VRES_P0, &fecp->ESW_VRES[1]);
+
+	tmp = readl(&fecp->ESW_VRES[2]);
+	writel(tmp | MCF_ESW_VRES_P0, &fecp->ESW_VRES[2]);
+
+	dev_dbg(&fep->pdev->dev, "%s: VRES0: 0x%x\n",
+		__func__, readl(&fecp->ESW_VRES[0]));
+	dev_dbg(&fep->pdev->dev, "%s: VRES1: 0x%x\n", __func__,
+		readl(&fecp->ESW_VRES[1]));
+	dev_dbg(&fep->pdev->dev, "%s: VRES2: 0x%x\n", __func__,
+		readl(&fecp->ESW_VRES[2]));
+
+	mtip_set_vlan_verification(fep, 0, 1, 0);
+	mtip_set_vlan_verification(fep, 1, 1, 0);
+	mtip_set_vlan_verification(fep, 2, 1, 0);
+
+	mtip_vlan_output_process(fep, 0, 2);
+	mtip_vlan_output_process(fep, 1, 2);
+	mtip_vlan_output_process(fep, 2, 2);
+}
+
+void mtip_switch_dis_port_separation(struct switch_enet_private *fep)
+{
+	struct switch_t *fecp = fep->hwp;
+
+	writel(0, &fecp->ESW_PID[0]);
+	writel(0, &fecp->ESW_PID[1]);
+	writel(0, &fecp->ESW_PID[2]);
+
+	writel(0, &fecp->ESW_VRES[0]);
+	writel(0, &fecp->ESW_VRES[1]);
+	writel(0, &fecp->ESW_VRES[2]);
+
+	writel(0, &fecp->ESW_VIMEN);
+	writel(0, &fecp->ESW_VIMSEL);
+	writel(0, &fecp->ESW_VLANV);
+	writel(0, &fecp->ESW_VOMSEL);
+}
+
+int mtip_port_broadcast_config(struct switch_enet_private *fep,
+			       int port, int enable)
+{
+	struct switch_t *fecp = fep->hwp;
+	u32 tmp = 0;
+
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	tmp = readl(&fecp->ESW_DBCR);
+	if (enable == 1) {
+		if (port == 0)
+			tmp |= MCF_ESW_DBCR_P0;
+		else if (port == 1)
+			tmp |= MCF_ESW_DBCR_P1;
+		else if (port == 2)
+			tmp |= MCF_ESW_DBCR_P2;
+	} else if (enable == 0) {
+		if (port == 0)
+			tmp &= ~MCF_ESW_DBCR_P0;
+		else if (port == 1)
+			tmp &= ~MCF_ESW_DBCR_P1;
+		else if (port == 2)
+			tmp &= ~MCF_ESW_DBCR_P2;
+	}
+
+	writel(tmp, &fecp->ESW_DBCR);
+	return 0;
+}
+
+/* The frame is forwarded to the forced destination ports.
+ * It only replace the MAC lookup function,
+ * all other filtering(eg.VLAN verification) act as normal
+ */
+int mtip_forced_forward(struct switch_enet_private *fep, int port, int enable)
+{
+	struct switch_t *fecp = fep->hwp;
+	u32 tmp = 0;
+
+	if (port & ~GENMASK(1, 0)) {
+		dev_err(&fep->pdev->dev,
+			"%s: Forced forward for port(s): 0x%x not supported!\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	/* Enable Forced forwarding for port(s) */
+	tmp |= MCF_ESW_P0FFEN_FD(port & GENMASK(1, 0));
+
+	if (enable == 1)
+		tmp |= MCF_ESW_P0FFEN_FEN;
+	else
+		tmp &= ~MCF_ESW_P0FFEN_FEN;
+
+	writel(tmp, &fecp->ESW_P0FFEN);
+	return 0;
+}
+
+int mtip_port_learning_config(struct switch_enet_private *fep, int port,
+			      int disable, int irq_adj)
+{
+	struct switch_t *fecp = fep->hwp;
+	u32 tmp = 0;
+
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	tmp = readl(&fecp->ESW_BKLR);
+	if (disable == 1) {
+		if (irq_adj)
+			fecp->ESW_IMR &= ~MCF_ESW_IMR_LRN;
+
+		if (port == 0)
+			tmp |= MCF_ESW_BKLR_LD0;
+		else if (port == 1)
+			tmp |= MCF_ESW_BKLR_LD1;
+		else if (port == 2)
+			tmp |= MCF_ESW_BKLR_LD2;
+	} else if (disable == 0) {
+		if (irq_adj)
+			fecp->ESW_IMR |= MCF_ESW_IMR_LRN;
+
+		if (port == 0)
+			tmp &= ~MCF_ESW_BKLR_LD0;
+		else if (port == 1)
+			tmp &= ~MCF_ESW_BKLR_LD1;
+		else if (port == 2)
+			tmp &= ~MCF_ESW_BKLR_LD2;
+	}
+
+	writel(tmp, &fecp->ESW_BKLR);
+	dev_dbg(&fep->pdev->dev, "%s ESW_BKLR %#x, ESW_IMR %#x\n", __func__,
+		readl(&fecp->ESW_BKLR), readl(&fecp->ESW_IMR));
+
+	return 0;
+}
+
+int mtip_port_blocking_config(struct switch_enet_private *fep, int port,
+			      int enable)
+{
+	struct switch_t *fecp = fep->hwp;
+	u32 tmp = 0;
+
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	tmp = readl(&fecp->ESW_BKLR);
+	if (enable == 1) {
+		if (port == 0)
+			tmp |= MCF_ESW_BKLR_BE0;
+		else if (port == 1)
+			tmp |= MCF_ESW_BKLR_BE1;
+		else if (port == 2)
+			tmp |= MCF_ESW_BKLR_BE2;
+	} else if (enable == 0) {
+		if (port == 0)
+			tmp &= ~MCF_ESW_BKLR_BE0;
+		else if (port == 1)
+			tmp &= ~MCF_ESW_BKLR_BE1;
+		else if (port == 2)
+			tmp &= ~MCF_ESW_BKLR_BE2;
+	}
+
+	writel(tmp, &fecp->ESW_BKLR);
+	return 0;
+}
-- 
2.39.5


