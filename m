Return-Path: <netdev+bounces-200060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE2DAE2F21
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 11:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 503007A83A3
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 09:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578F61E2606;
	Sun, 22 Jun 2025 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="fl+5Z2px"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891F71DED40;
	Sun, 22 Jun 2025 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750585117; cv=none; b=A9NVM1PYmK4lNBbm6+vueFN7v9J/sQQCKeBdhCCNCvChg2FZwFmt+RNB0n418e8lZ/8I9O9RVmTgh5qazsBHwT3ibzCDBmsEjREFV+BCoRwDB43oIWpk2jYaLtPKEZZ1lFbgixFyhcecJj3YD7NXOcu9P25akv/OqE122DMcKFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750585117; c=relaxed/simple;
	bh=THKHPQEZm6+MxI5QMSlAKGAbs6dk0IAQZwRRsIcmGAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZGYXVIvkcT6lRj9Qz1LOrdGT0TDGVFCT8XstkN+gz5A+8wmV2MCIM2unXwNdxP4yVHsWut7lfEjyqxm12EFNdfPzdI0n6HW6FAinibK94bLDADI0m9n9pwdybBdRQDxOsq4d6UMtuspUG/X02dUviEYBbEDK94rxSPCUjyZ6k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=fl+5Z2px; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF74910240A10;
	Sun, 22 Jun 2025 11:38:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750585110; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=GDYo93d/tYHPbL5mCMFb0xSMV+WRCK3Zt8h/qCKtscU=;
	b=fl+5Z2px7RISQoG3GG/b+AXTTNC1ZgW4dVLk1h7jmNYXMrwlS3DcpAh5e6CjxfgUBBrY10
	uiPcAv0RT4Tuv5Ul6rvEPHYj6XsTyWxGgwGKbN+NH6b4Rrhec8C+z2iUinGrCa95OKDu5K
	2Fk/v952IcuV0DR7gNHTAz84F5EAY+zasj04vvxFjX6f/GWFl5hbOkZtg8dfks98oGRYIV
	hftj/WhhcyI5GBIanPQNAkJK3rl+GVuRUB4LrXwaR6omYxZ5coKEY+Dwg8vh/I7uJn5y/w
	qi09vFKTmbUR9sD3V/tYsvR7VxXGqLfAO+dRfaWSNMjTaVoU0dSPi8Ar3uSRCw==
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
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukma@denx.de>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [net-next v13 04/11] net: mtip: The L2 switch driver for imx287
Date: Sun, 22 Jun 2025 11:37:49 +0200
Message-Id: <20250622093756.2895000-5-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622093756.2895000-1-lukma@denx.de>
References: <20250622093756.2895000-1-lukma@denx.de>
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
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

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

Changes for v5:
- Fix spelling in Kconfig
- Replace tmp with reg or register name
- Replace tmpaddr with mac_addr
- Use mac address assignment (from registers) code similar to fec_main.c (as it
  shall handle properly generic endianess)
- Add description for fep: in the mtip_update_atable_static() kernel doc
- Replace writel(bdp, &fep->cur_rx) with fep->cur_rx = bdp;
- Fix spelling of transmit
- Remove not needed white spaces in mtipl2sw.h
- Remove '_t' from struct mtip_addr_table_t
- Provide proper alignment in the mtipl2sw.h
- Add blank line after local header in mtipl2sw_br.c
- Use %p instead of %x (and cast) for fep in debug message
- Disable L2 switch in-HW offloading when only one
  of eligible ports is removed from the bridge
- Sort includes in the patch set alphabethically
- Introduce FEC_QUIRK_SWAP_FRAME to avoid #ifdef for imx28 proper operation
- Move 'mtip_port_info g_info' to struct switch_enet_private
- Replace some unsigned int with u32 (on data fields with 32 bit size)
- Remove not relevant comments from mtip_enet_init()
- Refactor functions definitions to be void when no other
  value than 0 is returned.
- Use capital letters in HEX constants
- Use u32 instead of unsigned int when applicable
- Add error handling code after the dma_map_single() is called
- The MCF_FEC_MSCR register can be written unconditionally
  for all supported platforms.
- Use IS_ENABLED() instead of #ifdef in mtip_timeout()
- Replace dev_info() with dev_warn_ratelimited() in mtip_switch_rx()
- Add code to handle situation when there is no memory
- Remove kfree(fep->mii_bus->irq)
- Provide more verbose output of mdio_{read|write} functions
- Handle error when clk_enable() fails in mtip_open()
- Use dev_dbg() at mtip_set_multicast_list()
- Simplify the mtip_is_switch_netdev_port() function to return condition check value
- Add dev_dbg() when of_get_mac_address() fails (as it may not be provided)
- Remove return ret; in mtip_register_notifiers()
- Replace int to bool in mtipl2sw_mgnt.c file's function definitions
- Replace unsigned int/long with u32 where applicable (where access to
  32 bit registers is performed)
- Refactor code in mtip_{read|write}_atable() to be more readable
- Remove code added for not (yet) supported IMX's vf610 SoC
- Remove do { } while(); loop from mtip_interrupt() function
- Introduce MTIP_PORT_FORWARDING_INIT to indicate intial value for
  port forwarding
- Replace 'unsigned long' to 'u32' in mtipl2sw.h
- Replace 'unsigned short' to 'u16' in mtipl2sw.h
- use %#x in dev_dbg()
- Call SET_NETDEV_DEV() macro to set network device' parent - otherwise
  phy_attach_direct() will fail.

Changes for v6:
- Use dev_name(&pdev->dev) when requesting IRQ (to be in sync with other subsystems)
- Use platform_get_irq_byname() for beter readability
- Replace ARCH_MXS with SOC_IMX28
- Replace 2048 with MTIP_ATABLE_MEM_NUM_ENTRIES
- Remove check if fep == NULL in mtip_aging_timer() as timer can be setup only
  after the fep structure is allocated and already filled durring probe()
  execution

Changes for v7:
- Change switch interrupt name from 'mtipl2sw' to 'enet_switch'

Changes for v8:
- Replace struct switch_t with set of #define(s) for MTIP L2
  switch IP block registers offsets. This helps to keep the '__iomem'
  annotation when accessing them with readl/writel() and fix warnings
  from sparse on GCC and CLANG. No functional changes, just registers'
  access coding paradigm has been updated.
- Fix warings regarding access to atable - by adding '__iomem' attribute
- Remove not used struct mtip_port_statistics_status

Changes for v9:
- Adjust Makefile to properly build mtipl2sw driver as a module
  (otherwise make allmodconfig build fails).

Changes for v10:
- Remove __init attribute from mtip_switch_dma_init() to avoid clang
  modpost Warninig
  Reproduction steps:
  make LLVM_SUFFIX=-19 LLVM=1 mrproper
  cp ./arch/arm/configs/mxs_defconfig .config
  make ARCH=arm LLVM_SUFFIX=-19 LLVM=1 W=1 menuconfig
  make ARCH=arm LLVM_SUFFIX=-19 LLVM=1 W=1 -j8 LOADADDR=0x40008000 uImage dtbs

Changes for v11:
- Replace of_find_node_by_name() with of_get_child_by_name()
- Replace of_match_node() with dedicated of_device_get_match_data()
- Replace devm_err() with dev_err_probe() in the probe function
- Remove kfree(fep) from mtip_sw_remove() to fix:
  ./mtipl2sw.c:1953:1-6: WARNING: invalid free of devm_ allocated data
- the *bus pointer provided as an agument to mtip_mdiobus_reset() cannot
  be NULL itself, as then the "reset" callback couldn't be referenced.
  Considering the above - the "!bus" check can be removed.
  It fixes the following error from coccinelle
  ./mtipl2sw.c:1237:16-19: ERROR: bus is NULL but dereferenced.
- Fix smatch errors:
  mtip_atable_dynamicms_learn_migration() error: uninitialized symbol 'rx_mac_lo/hi'.
  by initializing rx_mac_lo and rx_mac_hi variables
  Replace fep->irq with ret in dev_err_probe()

Changes for v12:
- Clear fep->rx_skbuff[i] when buffers are freed

Changes for v13:
- Replace spin_lock_irqsave() with spin_lock_bh() when eligible (NAPI or softirq context)
- Increment dev->stats.tx_bytes after data is really send
- Add wmb() before descriptor is used for transmission (either RX or TX)
- Add work queue to handle bottom half of network interface timeout
- Move the network statistics update (only when packet is correctly received) just before
  finishing processing of data.
- Remove dev_kfree_skb_any(skb); and finally rely on mtip_free_buffers()
- Use mtip_set_last_buf_to_wrap() helper function
- Cleanup defines for internal routing table entries
- Use GENMASK() when applicable
- Replace extra pair of dma_map_single()/dma_unmap_single() in RX function with
  dma_sync_single_for_cpu() as there is already allocated buffer (its pointer is
  stored in bdp->cbd_bufaddr)
- Use proper network devices when offloading is enabled
- Use FIELD_PREP() and FIELD_GET() macros
- Replace preprocessor macros with FIELD_PREP()
- Remove not used defines
- Replace AT_EXTRACT* macros with FIELD_PREP()
- Introduce mtip_timedelta() static inline function instead of macro
- Add missing error check in mtip_alloc_buffers()
- Use page pool to allocate and sync space for incoming data (instead
  of using page map and unmap.
- Replace from_timer() with timer_container_of()
- Move mtipl2sw_br.c related code to a separate commit
- Move mtipl2sw_mgnt.c related code to a separate commit
- Exclude struct net_device_ops callback function to a separate commit
---
 MAINTAINERS                                   |    7 +
 drivers/net/ethernet/freescale/Kconfig        |    1 +
 drivers/net/ethernet/freescale/Makefile       |    1 +
 drivers/net/ethernet/freescale/mtipsw/Kconfig |   13 +
 .../net/ethernet/freescale/mtipsw/Makefile    |    4 +
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 1437 +++++++++++++++++
 .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |  630 ++++++++
 7 files changed, 2093 insertions(+)
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/Kconfig
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/Makefile
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e54731af45d7..f5c81b98caa9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9630,6 +9630,13 @@ S:	Maintained
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
index bbef47c3480c..f2442e26606b 100644
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
index 000000000000..a6fbdb59854f
--- /dev/null
+++ b/drivers/net/ethernet/freescale/mtipsw/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config FEC_MTIP_L2SW
+	tristate "MoreThanIP L2 switch support to FEC driver"
+	depends on OF
+	depends on NET_SWITCHDEV
+	depends on BRIDGE
+	depends on SOC_IMX28 || COMPILE_TEST
+	help
+	  This enables support for the MoreThan IP L2 switch on i.MX
+	  SoCs (e.g. iMX287). It offloads bridging to this IP block's
+	  hardware and allows switch management with standard Linux tools.
+	  This switch driver can be used interchangeable with the already
+	  available FEC driver, depending on the use case's requirements.
diff --git a/drivers/net/ethernet/freescale/mtipsw/Makefile b/drivers/net/ethernet/freescale/mtipsw/Makefile
new file mode 100644
index 000000000000..bd8ffb30939a
--- /dev/null
+++ b/drivers/net/ethernet/freescale/mtipsw/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_FEC_MTIP_L2SW) += nxp-mtipl2sw.o
+nxp-mtipl2sw-objs := mtipl2sw.o
diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
new file mode 100644
index 000000000000..5142f647d939
--- /dev/null
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
@@ -0,0 +1,1437 @@
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
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/etherdevice.h>
+#include <linux/gpio/consumer.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/of_mdio.h>
+#include <linux/of_net.h>
+#include <linux/of_platform.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/rtnetlink.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <net/page_pool/helpers.h>
+
+#include "mtipl2sw.h"
+
+/* Set the last buffer to wrap */
+static void mtip_set_last_buf_to_wrap(struct cbd_t *bdp)
+{
+	bdp--;
+	bdp->cbd_sc |= BD_SC_WRAP;
+}
+
+struct mtip_devinfo {
+	u32 quirks;
+};
+
+static void mtip_enet_init(struct switch_enet_private *fep, int port)
+{
+	void __iomem *enet_addr = fep->enet_addr;
+	u32 mii_speed, holdtime, reg;
+
+	if (port == 2)
+		enet_addr += MCF_ESW_ENET_PORT_OFFSET;
+
+	reg = MCF_FEC_RCR_PROM | MCF_FEC_RCR_MII_MODE |
+		FIELD_PREP(MCF_FEC_RCR_MAX_FL_MASK, 1522);
+
+	if (fep->phy_interface[port - 1]  == PHY_INTERFACE_MODE_RMII)
+		reg |= MCF_FEC_RCR_RMII_MODE;
+
+	writel(reg, enet_addr + MCF_FEC_RCR);
+
+	writel(MCF_FEC_TCR_FDEN, enet_addr + MCF_FEC_TCR);
+	writel(MCF_FEC_ECR_ETHER_EN, enet_addr + MCF_FEC_ECR);
+
+	mii_speed = DIV_ROUND_UP(clk_get_rate(fep->clk_ipg), 5000000);
+	mii_speed--;
+
+	holdtime = DIV_ROUND_UP(clk_get_rate(fep->clk_ipg), 100000000) - 1;
+
+	fep->phy_speed = mii_speed << 1 | holdtime << 8;
+
+	writel(fep->phy_speed, enet_addr + MCF_FEC_MSCR);
+}
+
+static void mtip_setup_mac(struct net_device *dev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	unsigned char *iap, mac_addr[ETH_ALEN];
+
+	/* Use MAC address from DTS */
+	iap = &fep->mac[priv->portnum - 1][0];
+
+	/* Use MAC address set by bootloader */
+	if (!is_valid_ether_addr(iap)) {
+		*((__be32 *)&mac_addr[0]) =
+			cpu_to_be32(readl(fep->enet_addr + MCF_FEC_PALR));
+		*((__be16 *)&mac_addr[4]) =
+			cpu_to_be16(readl(fep->enet_addr +
+					  MCF_FEC_PAUR) >> 16);
+		iap = &mac_addr[0];
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
+	for (byt = 0; byt < ETH_ALEN; byt++) {
+		inval = (((int)pmacaddress[byt]) & 0xFF);
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
+				crc ^= 0x1C0;
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
+			     u32 *read_lo, u32 *read_hi)
+{
+	struct addr_table64b_entry __iomem *atable_base =
+		fep->hwentry->mtip_table64b_entry;
+
+	*read_lo = readl(&atable_base[index].lo);
+	*read_hi = readl(&atable_base[index].hi);
+}
+
+static void mtip_write_atable(struct switch_enet_private *fep, int index,
+			      u32 write_lo, u32 write_hi)
+{
+	struct addr_table64b_entry __iomem *atable_base =
+		fep->hwentry->mtip_table64b_entry;
+
+	writel(write_lo, &atable_base[index].lo);
+	writel(write_hi, &atable_base[index].hi);
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
+	struct mtip_port_info *info = &fep->g_info;
+	u32 reg;
+
+	reg = readl(fep->hwp + ESW_LSR);
+	if (reg == 0) {
+		dev_dbg(&fep->pdev->dev, "%s: ESW_LSR = 0x%x\n", __func__, reg);
+		return NULL;
+	}
+
+	/* read word from FIFO */
+	info->maclo = readl(fep->hwp + ESW_LREC0);
+	if (info->maclo == 0) {
+		dev_dbg(&fep->pdev->dev, "%s: mac lo 0x%x\n", __func__,
+			info->maclo);
+		return NULL;
+	}
+
+	/* read 2nd word from FIFO */
+	reg = readl(fep->hwp + ESW_LREC1);
+	info->machi = reg & 0xFFFF;
+	info->hash  = (reg >> 16) & 0xFF;
+	info->port  = (reg >> 24) & 0xF;
+
+	return info;
+}
+
+/* Clear complete MAC Look Up Table */
+void mtip_clear_atable(struct switch_enet_private *fep)
+{
+	int index;
+
+	for (index = 0; index < MTIP_ATABLE_MEM_NUM_ENTRIES; index++)
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
+ * @fep:      Pointer to the structure describing the switch
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
+	u32 write_lo, write_hi, read_lo, read_hi;
+
+	write_lo = (u32)((mac_addr[3] << 24) | (mac_addr[2] << 16) |
+			 (mac_addr[1] << 8) | mac_addr[0]);
+	write_hi = (u32)(0 | (port << AT_SENTRY_PORTMASK_shift) |
+			 (priority << AT_SENTRY_PRIO_shift) |
+			 (AT_ENTRY_TYPE_STATIC << AT_ENTRY_TYPE_shift) |
+			 (AT_ENTRY_RECORD_VALID << AT_ENTRY_VALID_shift) |
+			 (mac_addr[5] << 8) | (mac_addr[4]));
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
+		    ((read_hi & 0x0000FFFF) ==
+		     (write_hi & 0x0000FFFF))) {
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
+static bool mtip_update_atable_dynamic1(u32 write_lo, u32 write_hi,
+					int block_index, unsigned int port,
+					unsigned int curr_time,
+					struct switch_enet_private *fep)
+{
+	unsigned long entry, index_end;
+	int time, timeold, indexold;
+	u32 read_lo, read_hi;
+	unsigned long conf;
+
+	/* prepare update port and timestamp */
+	conf = AT_ENTRY_RECORD_VALID << AT_ENTRY_VALID_shift;
+	conf |= AT_ENTRY_TYPE_DYNAMIC << AT_ENTRY_TYPE_shift;
+	conf |= curr_time << AT_DENTRY_TIME_shift;
+	conf |= port << AT_DENTRY_PORT_shift;
+	conf |= write_hi;
+
+	/* linear search through all slot
+	 * entries and update if found
+	 */
+	index_end = block_index + ATABLE_ENTRY_PER_SLOT;
+	/* Now search all the entries in the selected block */
+	for (entry = block_index; entry < index_end; entry++) {
+		mtip_read_atable(fep, entry, &read_lo, &read_hi);
+		if (read_lo == write_lo &&
+		    ((read_hi & 0x0000FFFF) ==
+		     (write_hi & 0x0000FFFF))) {
+			/* found correct address,
+			 * update timestamp.
+			 */
+			mtip_write_atable(fep, entry, write_lo, conf);
+
+			return false;
+		} else if (!(read_hi & (1 << 16))) {
+			/* slot is empty, then use it
+			 * for new entry
+			 * Note: There are no holes,
+			 * therefore cannot be any
+			 * more that need to be compared.
+			 */
+			mtip_write_atable(fep, entry, write_lo, conf);
+			/* statistics (we do it between writing
+			 *  .hi an .lo due to
+			 * hardware limitation...
+			 */
+			fep->at_curr_entries++;
+			/* newly inserted */
+
+			return true;
+		}
+	}
+
+	/* No more entry available in block overwrite oldest */
+	timeold = 0;
+	indexold = 0;
+	for (entry = block_index; entry < index_end; entry++) {
+		mtip_read_atable(fep, entry, &read_lo, &read_hi);
+		time = FIELD_GET(AT_TIMESTAMP_MASK, read_hi);
+		dev_dbg(&fep->pdev->dev, "%s : time %x currtime %x\n",
+			__func__, time, curr_time);
+		time = mtip_timedelta(curr_time, time);
+		if (time > timeold) {
+			/* is it older ? */
+			timeold = time;
+			indexold = entry;
+		}
+	}
+
+	mtip_write_atable(fep, indexold, write_lo, conf);
+
+	/* Statistics (do it inbetween writing to .lo and .hi */
+	fep->at_block_overflows++;
+	dev_err(&fep->pdev->dev, "%s update time, at_block_overflows %x\n",
+		__func__, fep->at_block_overflows);
+	/* newly inserted */
+	return true;
+}
+
+/* dynamicms MAC address table learn and migration */
+static void
+mtip_atable_dynamicms_learn_migration(struct switch_enet_private *fep,
+				      int curr_time, unsigned char *mac,
+				      u8 *rx_port)
+{
+	u8 port = MTIP_PORT_FORWARDING_INIT;
+	struct mtip_port_info *port_info;
+	u32 rx_mac_lo = 0, rx_mac_hi = 0;
+	int index;
+
+	spin_lock_bh(&fep->learn_lock);
+
+	if (mac && is_valid_ether_addr(mac)) {
+		rx_mac_lo = (u32)((mac[3] << 24) | (mac[2] << 16) |
+				  (mac[1] << 8) | mac[0]);
+		rx_mac_hi = (u32)((mac[5] << 8) | (mac[4]));
+	}
+
+	port_info = mtip_portinfofifo_read(fep);
+	while (port_info) {
+		/* get block index from lookup table */
+		index = GET_BLOCK_PTR(port_info->hash);
+		mtip_update_atable_dynamic1(port_info->maclo, port_info->machi,
+					    index, port_info->port,
+					    curr_time, fep);
+
+		if (mac && is_valid_ether_addr(mac) &&
+		    port == MTIP_PORT_FORWARDING_INIT) {
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
+	spin_unlock_bh(&fep->learn_lock);
+}
+
+static void mtip_aging_timer(struct timer_list *t)
+{
+	struct switch_enet_private *fep = timer_container_of(fep, t,
+							     timer_aging);
+
+	fep->curr_time = mtip_timeincrement(fep->curr_time);
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
+	esw_mac_addr_static(fep);
+
+	writel(0, fep->hwp + ESW_BKLR);
+
+	writel(MCF_ESW_IMR_TXF | MCF_ESW_IMR_RXF,
+	       fep->hwp + ESW_IMR);
+}
+
+static void mtip_configure_enet_mii(struct switch_enet_private *fep, int port)
+{
+	struct phy_device *phydev = fep->phy_dev[port - 1];
+	struct net_device *dev = fep->ndev[port - 1];
+	void __iomem *enet_addr = fep->enet_addr;
+	int duplex = fep->full_duplex[port - 1];
+	u32 rcr;
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
+	writel(fep->phy_speed, enet_addr + MCF_FEC_MSCR);
+
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
+	rcr = readl(enet_addr + MCF_FEC_RCR);
+	if (phydev && phydev->speed == SPEED_100)
+		rcr &= ~MCF_FEC_RCR_RMII_10BASET;
+	else
+		rcr |= MCF_FEC_RCR_RMII_10BASET;
+
+	if (duplex == DUPLEX_FULL)
+		rcr &= ~MCF_FEC_RCR_DRT;
+	else
+		rcr |= MCF_FEC_RCR_DRT;
+
+	writel(rcr, enet_addr + MCF_FEC_RCR);
+
+	/* TCR */
+	if (duplex == DUPLEX_FULL)
+		writel(0x1C, enet_addr + MCF_FEC_TCR);
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
+	int i;
+
+	 /* Perform a reset. We should wait for this. */
+	writel(MCF_ESW_MODE_SW_RST, fep->hwp + ESW_MODE);
+
+	/* Delay of 10us specified in the documentation to perform
+	 * SW reset by the switch internally.
+	 */
+	udelay(10);
+	writel(MCF_ESW_MODE_STATRST, fep->hwp + ESW_MODE);
+	writel(MCF_ESW_MODE_SW_EN, fep->hwp + ESW_MODE);
+
+	/* Management port configuration,
+	 * make port 0 as management port
+	 */
+	writel(0, fep->hwp + ESW_BMPC);
+
+	/* Clear any outstanding interrupt */
+	writel(0xFFFFFFFF, fep->hwp + ESW_ISR);
+
+	/* Set backpressure threshold to minimize discarded frames
+	 * during due to congestion.
+	 */
+	writel(P0BC_THRESHOLD, fep->hwp + ESW_P0BCT);
+
+	/* Set maximum receive buffer size */
+	writel(PKT_MAXBLR_SIZE, fep->hwp + ESW_MRBR);
+
+	/* Set receive and transmit descriptor base */
+	writel(fep->bd_dma, fep->hwp + ESW_RDSR);
+	writel((unsigned long)fep->bd_dma
+		+ sizeof(struct cbd_t) * RX_RING_SIZE,
+		fep->hwp + ESW_TDSR);
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
+	writel(MCF_ESW_RDAR_R_DES_ACTIVE, fep->hwp + ESW_RDAR);
+
+	/* Enable interrupts we wish to service */
+	writel(0xFFFFFFFF, fep->hwp + ESW_ISR);
+	writel(MCF_ESW_IMR_TXF | MCF_ESW_IMR_RXF,
+	       fep->hwp + ESW_IMR);
+
+	mtip_config_switch(fep);
+}
+
+static irqreturn_t mtip_interrupt(int irq, void *ptr_fep)
+{
+	struct switch_enet_private *fep = ptr_fep;
+	irqreturn_t ret = IRQ_NONE;
+	u32 int_events, int_imask;
+
+	/* Get the interrupt events that caused us to be here */
+	int_events = readl(fep->hwp + ESW_ISR);
+	writel(int_events, fep->hwp + ESW_ISR);
+
+	if (int_events & (MCF_ESW_ISR_RXF | MCF_ESW_ISR_TXF)) {
+		ret = IRQ_HANDLED;
+		/* Disable the RX interrupt */
+		if (napi_schedule_prep(&fep->napi)) {
+			int_imask = readl(fep->hwp + ESW_IMR);
+			int_imask &= ~MCF_ESW_IMR_RXF;
+			writel(int_imask, fep->hwp + ESW_IMR);
+			__napi_schedule(&fep->napi);
+		}
+	}
+
+	return ret;
+}
+
+static void mtip_switch_tx(struct net_device *dev)
+{
+}
+
+static int mtip_switch_rx(struct net_device *dev, int budget, int *port)
+{
+	return -ENOMEM;
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
+	       FIELD_PREP(FEC_MMFR_PA_MASK, mii_id) |
+	       FIELD_PREP(FEC_MMFR_RA_MASK, regnum) |
+	       FEC_MMFR_TA, fep->enet_addr + MCF_FEC_MII_DATA);
+
+	/* wait for end of transfer */
+	ret = mtip_mdio_wait(fep);
+	if (ret) {
+		dev_err(&fep->pdev->dev, "MTIP: MDIO (%s:%d) read timeout\n",
+			bus->id, mii_id);
+		return ret;
+	}
+
+	/* return value */
+	return FIELD_GET(FEC_MMFR_DATA_MASK,
+			 readl(fep->enet_addr + MCF_FEC_MII_DATA));
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
+	       FIELD_PREP(FEC_MMFR_PA_MASK, mii_id) |
+	       FIELD_PREP(FEC_MMFR_RA_MASK, regnum) |
+	       FEC_MMFR_TA | FIELD_PREP(FEC_MMFR_DATA_MASK, value),
+	       fep->enet_addr + MCF_FEC_MII_DATA);
+
+	/* wait for end of transfer */
+	ret = mtip_mdio_wait(fep);
+	if (ret)
+		dev_err(&fep->pdev->dev, "MTIP: MDIO (%s:%d) write timeout\n",
+			bus->id, mii_id);
+
+	return ret;
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
+	if (!bus->reset_gpiod) {
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
+	int i;
+
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		page_pool_put_full_page(fep->page_pool,
+					fep->page[i], false);
+		fep->page[i] = NULL;
+	}
+
+	page_pool_destroy(fep->page_pool);
+	fep->page_pool = NULL;
+
+	for (i = 0; i < TX_RING_SIZE; i++)
+		kfree(fep->tx_bounce[i]);
+}
+
+static int mtip_create_page_pool(struct switch_enet_private *fep, int size)
+{
+	struct page_pool_params pp_params = {
+		.order = 0,
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.pool_size = size,
+		.nid = dev_to_node(&fep->pdev->dev),
+		.dev = &fep->pdev->dev,
+		.dma_dir = DMA_FROM_DEVICE,
+		.offset = 0,
+		.max_len = MTIP_SWITCH_RX_FRSIZE,
+	};
+	int ret = 0;
+
+	fep->page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(fep->page_pool)) {
+		ret = PTR_ERR(fep->page_pool);
+		fep->page_pool = NULL;
+	}
+
+	return ret;
+}
+
+static int mtip_alloc_buffers(struct net_device *dev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	struct cbd_t *bdp;
+	struct page *page;
+	int i, ret;
+
+	ret = mtip_create_page_pool(fep, RX_RING_SIZE);
+	if (ret < 0) {
+		dev_err(&fep->pdev->dev, "Failed to create page pool\n");
+		return ret;
+	}
+
+	bdp = fep->rx_bd_base;
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		page = page_pool_dev_alloc_pages(fep->page_pool);
+		if (!page) {
+			dev_err(&fep->pdev->dev,
+				"Failed to allocate page for rx buffer\n");
+			goto err;
+		}
+
+		bdp->cbd_bufaddr = page_pool_get_dma_addr(page);
+		fep->page[i] = page;
+
+		bdp->cbd_sc = BD_ENET_RX_EMPTY;
+		bdp++;
+	}
+
+	mtip_set_last_buf_to_wrap(bdp);
+
+	bdp = fep->tx_bd_base;
+	for (i = 0; i < TX_RING_SIZE; i++) {
+		fep->tx_bounce[i] = kmalloc(MTIP_SWITCH_TX_FRSIZE, GFP_KERNEL);
+		if (!fep->tx_bounce[i])
+			goto err;
+
+		bdp->cbd_sc = 0;
+		bdp->cbd_bufaddr = 0;
+		bdp++;
+	}
+
+	mtip_set_last_buf_to_wrap(bdp);
+
+	return 0;
+
+ err:
+	mtip_free_buffers(dev);
+	return -ENOMEM;
+}
+
+static int mtip_rx_napi(struct napi_struct *napi, int budget)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(napi->dev);
+	struct switch_enet_private *fep = priv->fep;
+	int pkts, port;
+
+	pkts = mtip_switch_rx(napi->dev, budget, &port);
+	if (pkts == -ENOMEM) {
+		napi_complete(napi);
+		return 0;
+	}
+
+	if ((port == 1 || port == 2) && fep->ndev[port - 1])
+		mtip_switch_tx(fep->ndev[port - 1]);
+	else
+		mtip_switch_tx(napi->dev);
+
+	if (pkts < budget) {
+		napi_complete_done(napi, pkts);
+		/* Set default interrupt mask for L2 switch */
+		writel(MCF_ESW_IMR_RXF | MCF_ESW_IMR_TXF,
+		       fep->hwp + ESW_IMR);
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
+		ret = clk_enable(fep->clk_ipg);
+		if (ret) {
+			dev_err(&fep->pdev->dev,
+				"Cannot enable switch IPG clock\n");
+			return ret;
+		}
+
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
+};
+
+bool mtip_is_switch_netdev_port(const struct net_device *ndev)
+{
+	return ndev->netdev_ops == &mtip_netdev_ops;
+}
+
+static int mtip_switch_dma_init(struct switch_enet_private *fep)
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
+	mtip_set_last_buf_to_wrap(bdp);
+	/* ...and the same for transmit */
+	bdp = fep->tx_bd_base;
+	for (i = 0; i < TX_RING_SIZE; i++) {
+		/* Initialize the BD for every fragment in the page */
+		bdp->cbd_sc = 0;
+		bdp->cbd_bufaddr = 0;
+		bdp++;
+	}
+
+	mtip_set_last_buf_to_wrap(bdp);
+	return 0;
+}
+
+static void mtip_ndev_cleanup(struct switch_enet_private *fep)
+{
+	struct mtip_ndev_priv *priv;
+	int i;
+
+	for (i = 0; i < SWITCH_EPORT_NUMBER; i++) {
+		if (fep->ndev[i]) {
+			priv = netdev_priv(fep->ndev[i]);
+			cancel_work_sync(&priv->tx_timeout_work);
+
+			unregister_netdev(fep->ndev[i]);
+			free_netdev(fep->ndev[i]);
+		}
+	}
+}
+
+static int mtip_ndev_init(struct switch_enet_private *fep,
+			  struct platform_device *pdev)
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
+		SET_NETDEV_DEV(fep->ndev[i], &pdev->dev);
+
+		priv = netdev_priv(fep->ndev[i]);
+		priv->dev = fep->ndev[i];
+		priv->fep = fep;
+		priv->portnum = i + 1;
+		fep->ndev[i]->irq = fep->irq;
+
+		mtip_setup_mac(fep->ndev[i]);
+
+		ret = register_netdev(fep->ndev[i]);
+		if (ret) {
+			dev_err(&fep->ndev[i]->dev,
+				"%s: ndev %s register err: %d\n", __func__,
+				fep->ndev[i]->name, ret);
+			break;
+		}
+
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
+	int ret = 0;
+
+	p = of_get_child_by_name(np, "ethernet-ports");
+
+	for_each_available_child_of_node_scoped(p, port) {
+		if (of_property_read_u32(port, "reg", &port_num))
+			continue;
+
+		if (port_num > SWITCH_EPORT_NUMBER) {
+			dev_err(&fep->pdev->dev,
+				"%s: The switch supports up to %d ports!\n",
+				__func__, SWITCH_EPORT_NUMBER);
+			goto of_get_err;
+		}
+
+		fep->n_ports = port_num;
+		ret = of_get_mac_address(port, &fep->mac[port_num - 1][0]);
+		if (ret)
+			dev_dbg(&fep->pdev->dev,
+				"of_get_mac_address(%pOF) failed (%d)!\n",
+				port, ret);
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
+	return ret;
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
+	.quirks = FEC_QUIRK_BUG_CAPTURE | FEC_QUIRK_SINGLE_MDIO |
+		  FEC_QUIRK_SWAP_FRAME,
+};
+
+static const struct of_device_id mtipl2_of_match[] = {
+	{ .compatible = "nxp,imx28-mtip-switch",
+	  .data = &mtip_imx28_l2switch_info},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mtipl2_of_match);
+
+static int mtip_sw_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const struct mtip_devinfo *dev_info;
+	struct switch_enet_private *fep;
+	int ret;
+
+	fep = devm_kzalloc(&pdev->dev, sizeof(*fep), GFP_KERNEL);
+	if (!fep)
+		return -ENOMEM;
+
+	dev_info = of_device_get_match_data(&pdev->dev);
+	if (dev_info)
+		fep->quirks = dev_info->quirks;
+
+	fep->pdev = pdev;
+	platform_set_drvdata(pdev, fep);
+
+	fep->enet_addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(fep->enet_addr))
+		return PTR_ERR(fep->enet_addr);
+
+	fep->irq = platform_get_irq_byname(pdev, "enet_switch");
+	if (fep->irq < 0)
+		return fep->irq;
+
+	ret = mtip_parse_of(fep, np);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "OF parse error\n");
+
+	/* Create an Ethernet device instance.
+	 * The switch lookup address memory starts at 0x800FC000
+	 */
+	fep->hwp_enet = fep->enet_addr;
+	fep->hwp = fep->enet_addr + ENET_SWI_PHYS_ADDR_OFFSET;
+	fep->hwentry = (struct mtip_addr_table __iomem *)
+		(fep->hwp + MCF_ESW_LOOKUP_MEM_OFFSET);
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
+			       dev_name(&pdev->dev), fep);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Could not alloc IRQ\n");
+
+	ret = mtip_ndev_init(fep, pdev);
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
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(fep->task),
+				    "learning kthread_run error\n");
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
+
+	return ret;
+}
+
+static void mtip_sw_remove(struct platform_device *pdev)
+{
+	struct switch_enet_private *fep = platform_get_drvdata(pdev);
+
+	mtip_ndev_cleanup(fep);
+
+	mtip_mii_remove(fep);
+
+	kthread_stop(fep->task);
+	timer_delete_sync(&fep->timer_aging);
+	platform_set_drvdata(pdev, NULL);
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
index 000000000000..ad81ef11e458
--- /dev/null
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
@@ -0,0 +1,630 @@
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
+#include <linux/netdevice.h>
+#include <linux/phy.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/timecounter.h>
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
+
+#define ESW_REVISION        (0x000)
+#define ESW_SCRATCH         (0x004)
+#define ESW_PER             (0x008)
+#define ESW_VLANV           (0x010)
+#define ESW_DBCR            (0x014)
+#define ESW_DMCR            (0x018)
+#define ESW_BKLR            (0x01C)
+#define ESW_BMPC            (0x020)
+#define ESW_MODE            (0x024)
+#define ESW_VIMSEL          (0x028)
+#define ESW_VOMSEL          (0x02C)
+#define ESW_VIMEN           (0x030)
+#define ESW_VID             (0x034)
+
+#define ESW_MCR             (0x040)
+#define ESW_EGMAP           (0x044)
+#define ESW_INGMAP          (0x048)
+#define ESW_INGSAL          (0x04C)
+#define ESW_INGSAH          (0x050)
+#define ESW_INGDAL          (0x054)
+#define ESW_INGDAH          (0x058)
+#define ESW_ENGSAL          (0x05C)
+#define ESW_ENGSAH          (0x060)
+#define ESW_ENGDAL          (0x064)
+#define ESW_ENGDAH          (0x068)
+#define ESW_MCVAL           (0x06C)
+
+#define ESW_MMSR            (0x080)
+#define ESW_LMT             (0x084)
+#define ESW_LFC             (0x088)
+#define ESW_PCSR            (0x08C)
+#define ESW_IOSR            (0x090)
+#define ESW_QWT             (0x094)
+
+#define ESW_P0BCT           (0x09C)
+
+#define ESW_P0FFEN          (0x0BC)
+
+#define ESW_PSNP_BASE       (0x0C0)
+#define ESW_PSNP(x)         (ESW_PSNP_BASE + (4 * (x)))
+
+#define ESW_IPSNP_BASE      (0x0EC)
+#define ESW_IPSNP(x)        (ESW_IPSNP_BASE + (4 * (x)))
+
+#define ESW_PVRES_BASE      (0x100)
+#define ESW_PVRES(x)        (ESW_PVRES_BASE + (4 * (x)))
+
+#define ESW_IPRES           (0x140)
+
+#define ESW_PRES_BASE       (0x180)
+#define ESW_PRES(x)         (ESW_PRES_BASE + (4 * (x)))
+
+#define ESW_PID_BASE        (0x200)
+#define ESW_PID(x)          (ESW_PID_BASE + (4 * (x)))
+
+#define ESW_VRES_BASE       (0x280)
+#define ESW_VRES(x)         (ESW_VRES_BASE + (4 * (x)))
+
+#define ESW_DISCN           (0x300)
+#define ESW_DISCB           (0x304)
+#define ESW_NDISCN          (0x308)
+#define ESW_NDISCB          (0x30C)
+
+#define ESW_ISR             (0x400)
+#define ESW_IMR             (0x404)
+#define ESW_RDSR            (0x408)
+#define ESW_TDSR            (0x40C)
+#define ESW_MRBR            (0x410)
+#define ESW_RDAR            (0x414)
+#define ESW_TDAR            (0x418)
+
+#define ESW_LREC0           (0x500)
+#define ESW_LREC1           (0x504)
+#define ESW_LSR             (0x508)
+
+struct addr_table64b_entry {
+	u32 lo;  /* lower 32 bits */
+	u32 hi;  /* upper 32 bits */
+};
+
+struct mtip_addr_table {
+	struct addr_table64b_entry  mtip_table64b_entry[2048];
+};
+
+#define MCF_ESW_LOOKUP_MEM_OFFSET     0x4000
+#define MCF_ESW_ENET_PORT_OFFSET      0x4000
+#define ENET_SWI_PHYS_ADDR_OFFSET     0x8000
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
+#define MCF_FEC_RCR_MAX_FL_MASK   GENMASK(29, 16)
+#define MCF_FEC_RCR_CRC_FWD       BIT(14)
+#define MCF_FEC_RCR_NO_LGTH_CHECK BIT(30)
+#define MCF_FEC_TCR_FDEN          BIT(2)
+
+#define MCF_FEC_ECR_RESET      BIT(0)
+#define MCF_FEC_ECR_ETHER_EN   BIT(1)
+#define MCF_FEC_ECR_MAGIC_ENA  BIT(2)
+#define MCF_FEC_ECR_ENA_1588   BIT(4)
+
+#define MTIP_ALIGNMENT  GENMASK(3, 0)
+#define MCF_ENET_MII	BIT(23)
+
+/* FEC MII MMFR bits definition */
+#define FEC_MMFR_ST             BIT(30)
+#define FEC_MMFR_OP_READ        BIT(29)
+#define FEC_MMFR_OP_WRITE       BIT(28)
+#define FEC_MMFR_PA_MASK        GENMASK(27, 23)
+#define FEC_MMFR_RA_MASK        GENMASK(22, 18)
+#define FEC_MMFR_TA             BIT(17)
+#define FEC_MMFR_DATA_MASK      GENMASK(15, 0)
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
+	u32 maclo;
+	/* MAC upper 16 bits (47:32). */
+	u32 machi;
+	/* the hash value for this MAC address. */
+	u32 hash;
+	/* the port number this MAC address is associated with. */
+	u32 port;
+};
+
+/* Define the buffer descriptor structure. */
+struct cbd_t {
+	u16 cbd_datlen;		/* Data length */
+	u16 cbd_sc;			/* Control and status info */
+	u32 cbd_bufaddr;		/* Buffer address */
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
+	void __iomem *hwp_enet, *hwp, *enet_addr;
+	struct mtip_addr_table __iomem *hwentry;
+
+	struct platform_device *pdev;
+
+	/* Switch internals */
+	struct mtip_port_info g_info;
+
+	/* Clocks */
+	struct clk *clk_ipg;
+	struct clk *clk_ahb;
+	struct clk *clk_enet_out;
+
+	/* skbuff */
+	unsigned char *tx_bounce[TX_RING_SIZE];
+	struct sk_buff *tx_skbuff[TX_RING_SIZE];
+	ushort skb_cur;
+	ushort skb_dirty;
+
+	/* page_pool */
+	struct page_pool *page_pool;
+	struct page *page[RX_RING_SIZE];
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
+	struct work_struct tx_timeout_work;
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
+#define RX_BD_PE               BIT(26)
+#define RX_BD_CE               BIT(25)
+#define RX_BD_UC               BIT(24)
+#define RX_BD_INT              BIT(23)
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
+#define ATABLE_ENTRY_SIZE 8
+/*  slot size in byte */
+#define ATABLE_SLOT_SIZE (ATABLE_ENTRY_PER_SLOT * ATABLE_ENTRY_SIZE)
+/* timestamp variable mask within address table entry */
+#define AT_DENTRY_TIMESTAMP_MASK GENMASK(9, 0)
+
+/* number of bits for port bitmask number storage */
+#define AT_SENTRY_PORT_WIDTH 11
+/* address table static entry port bitmask start address bit */
+#define AT_SENTRY_PORTMASK_shift 21
+/* address table static entry priority start address bit */
+#define AT_SENTRY_PRIO_shift 18
+/* address table dynamic entry port start address bit */
+#define AT_DENTRY_PORT_shift 28
+/* address table dynamic entry timestamp start address bit */
+#define AT_DENTRY_TIME_shift 18
+/* address table entry record type start address bit */
+#define AT_ENTRY_TYPE_shift 17
+/* address table entry record type bit: 1 static, 0 dynamic */
+#define AT_ENTRY_TYPE_STATIC 1
+#define AT_ENTRY_TYPE_DYNAMIC 0
+/* address table entry record valid start address bit */
+#define AT_ENTRY_VALID_shift 16
+#define AT_ENTRY_RECORD_VALID 1
+
+/* return block corresponding to the 8 bit hash value calculated */
+#define GET_BLOCK_PTR(hash) ((hash) << 3)
+
+/* time stamp storage mask */
+#define AT_TIMESTAMP_MASK GENMASK(27, 18)
+/* port number storage mask */
+#define AT_PORT_MASK GENMASK(31, 28)
+
+static inline int mtip_timedelta(unsigned int curr_time, int time)
+{
+	return (curr_time - time) & AT_DENTRY_TIMESTAMP_MASK;
+}
+
+/* increment time value respecting modulo. */
+static inline int mtip_timeincrement(int time)
+{
+	return (time + 1) & AT_DENTRY_TIMESTAMP_MASK;
+}
+
+/* ------------------------------------------------------------------------- */
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
+/* Bit definitions and macros for MCF_ESW_MODE */
+#define MCF_ESW_MODE_SW_RST                    BIT(0)
+#define MCF_ESW_MODE_SW_EN                     BIT(1)
+#define MCF_ESW_MODE_STOP                      BIT(7)
+#define MCF_ESW_MODE_CRC_TRAN                  BIT(8)
+#define MCF_ESW_MODE_P0CT                      BIT(9)
+#define MCF_ESW_MODE_STATRST                   BIT(31)
+
+/* Bit definitions and macros for MCF_ESW_VIMSEL */
+#define MCF_ESW_VIMSEL_IM0_MASK                GENMASK(1, 0)
+#define MCF_ESW_VIMSEL_IM1_MASK                GENMASK(3, 2)
+#define MCF_ESW_VIMSEL_IM2_MASK                GENMASK(5, 4)
+
+/* Bit definitions and macros for MCF_ESW_VOMSEL */
+#define MCF_ESW_VOMSEL_OM0_MASK                GENMASK(1, 0)
+#define MCF_ESW_VOMSEL_OM1_MASK                GENMASK(3, 2)
+#define MCF_ESW_VOMSEL_OM2_MASK                GENMASK(5, 4)
+
+/* Bit definitions and macros for MCF_ESW_VIMEN */
+#define MCF_ESW_VIMEN_EN0                      BIT(0)
+#define MCF_ESW_VIMEN_EN1                      BIT(1)
+#define MCF_ESW_VIMEN_EN2                      BIT(2)
+
+/* Bit definitions and macros for MCF_ESW_MCR */
+#define MCF_ESW_MCR_PORT_MASK                  GENMASK(3, 0)
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
+/* Bit definitions and macros for MCF_ESW_MMSR */
+#define MCF_ESW_MMSR_BUSY                      BIT(0)
+#define MCF_ESW_MMSR_NOCELL                    BIT(1)
+#define MCF_ESW_MMSR_MEMFULL                   BIT(2)
+#define MCF_ESW_MMSR_MFLATCH                   BIT(3)
+#define MCF_ESW_MMSR_DQ_GRNT                   BIT(6)
+#define MCF_ESW_MMSR_CELLS_AVAIL_MASK          GENMASK(23, 16)
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
+/* Bit definitions and macros for MCF_ESW_P0BCT */
+#define MCF_ESW_P0BCT_THRESH_MASK              GENMASK(7, 0)
+
+/* Bit definitions and macros for MCF_ESW_P0FFEN */
+#define MCF_ESW_P0FFEN_FEN                     BIT(0)
+#define MCF_ESW_P0FFEN_FD_MASK                 GENMASK(3, 2)
+
+/* Bit definitions and macros for MCF_ESW_PID */
+#define MCF_ESW_PID_VLANID_MASK                GENMASK(15, 0)
+
+/* Bit definitions and macros for MCF_ESW_VRES */
+#define MCF_ESW_VRES_P0                        BIT(0)
+#define MCF_ESW_VRES_P1                        BIT(1)
+#define MCF_ESW_VRES_P2                        BIT(2)
+#define MCF_ESW_VRES_VLANID_MASK               GENMASK(14, 3)
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
+#define MCF_ESW_RDSR_ADDRESS_MASK              GENMASK(31, 2)
+
+/* Bit definitions and macros for MCF_ESW_TDSR */
+#define MCF_ESW_TDSR_ADDRESS_MASK              GENMASK(31, 2)
+
+/* Bit definitions and macros for MCF_ESW_MRBR */
+#define MCF_ESW_MRBR_SIZE_MASK                 GENMASK(13, 4)
+
+/* Bit definitions and macros for MCF_ESW_RDAR */
+#define MCF_ESW_RDAR_R_DES_ACTIVE              BIT(24)
+
+/* Bit definitions and macros for MCF_ESW_TDAR */
+#define MCF_ESW_TDAR_X_DES_ACTIVE              BIT(24)
+
+/* Bit definitions and macros for MCF_ESW_LSR */
+#define MCF_ESW_LSR_DA                         BIT(0)
+
+/* QUIRKS */
+/* Controller needs driver to swap frame */
+#define FEC_QUIRK_SWAP_FRAME		BIT(1)
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
+#define MTIP_PORT_FORWARDING_INIT 0xFF
+
+bool mtip_is_switch_netdev_port(const struct net_device *ndev);
+void mtip_clear_atable(struct switch_enet_private *fep);
+#endif /* __MTIP_L2SWITCH_H_ */
-- 
2.39.5


