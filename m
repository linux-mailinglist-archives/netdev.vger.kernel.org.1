Return-Path: <netdev+bounces-196373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE367AD46C2
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A163A7FC3
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C0F2980A5;
	Tue, 10 Jun 2025 23:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qCM9nYlc"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9C8295DA6
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749598322; cv=none; b=Ktd6CYjcZi8dlD4ti8vEBwc+5sbtYwh2W0J6ycC0Ta69FUXAtfhjIa1susQzUAO7BGSe10inSyo+O2elPjQL2plWPDVdr7KB1w12ph7B8r1fXPubK7niwUtlozVAQwyMmXes2fXSKcuyp00UqYciuVr1F4HVP1njPq0V+rvhcfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749598322; c=relaxed/simple;
	bh=pbBEAQauvBDw8Zncd5b0u6d6ThnP5hqKH6VSiHygDNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eBt1079Ou8V+G2tcptFpC7kdAfXsXGjt2FGkwuEDpu/z+RQyheF2FehfmFG3pCdyduMiW/v41fDMSK5UVEAoQ3Vn8MdGHv8aUcWiKIYh5Ni4FNE26fYreBe3U/V+xtrsVV12BPFXM/kvfDQcfPdO6gO9HIu7jHioze5FP7ismDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qCM9nYlc; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749598317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+00f+Skjpmc2z6cK1VPn2Zg9n3p6UU6X8+NHOUCm0Uc=;
	b=qCM9nYlcACd6+zZ2xJRvohTJI+8W11vh0LGnq/rtMOsV69YKuTTPGYdok8tb2YDxZWEcrr
	gG2fyrHv3eGkkJ5l/tdjB5eVN4LP60t3RKF5/VK3MfgxVYc21Q9l8+Z2TO6PIoDxB/96N0
	3DUuV+7vR9r8lad0noPXrji1CwTLzZw=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lei Wei <quic_leiwei@quicinc.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Michal Simek <michal.simek@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Robert Hancock <robert.hancock@calian.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [net-next PATCH v6 06/10] net: pcs: Add Xilinx PCS driver
Date: Tue, 10 Jun 2025 19:31:30 -0400
Message-Id: <20250610233134.3588011-7-sean.anderson@linux.dev>
In-Reply-To: <20250610233134.3588011-1-sean.anderson@linux.dev>
References: <20250610233134.3588011-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This adds support for the Xilinx 1G/2.5G Ethernet PCS/PMA or SGMII device.
This is a soft device which converts between GMII and either SGMII,
1000Base-X, or 2500Base-X. If configured correctly, it can also switch
between SGMII and 1000BASE-X at runtime. Thoretically this is also possible
for 2500Base-X, but that requires reconfiguring the serdes. The exact
capabilities depend on synthesis parameters, so they are read from the
devicetree.

This device has a c22-compliant PHY interface, so for the most part we can
just use the phylink helpers. This device supports an interrupt which is
triggered on autonegotiation completion. I'm not sure how useful this is,
since we can never detect a link down (in the PCS).

This device supports sharing some logic between different implementations
of the device. In this case, one device contains the "shared logic" and the
clocks are connected to other devices. To coordinate this, one device
registers a clock that the other devices can request.  The clock is enabled
in the probe function by releasing the device from reset. There are no othe
software controls, so the clock ops are empty.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v6:
- Move axienet_pcs_fixup to AXI Ethernet commit
- Use an empty statement for next label

Changes in v5:
- Export get_phy_c22_id when it is used
- Expose bind attributes, since there is no issue in doing so
- Use MDIO_BUS instead of MDIO_DEVICE

Changes in v4:
- Re-add documentation for axienet_xilinx_pcs_get that was accidentally
  removed

Changes in v3:
- Adjust axienet_xilinx_pcs_get for changes to pcs_find_fwnode API
- Call devm_pcs_register instead of devm_pcs_register_provider

Changes in v2:
- Add support for #pcs-cells
- Change compatible to just xlnx,pcs
- Drop PCS_ALTERA_TSE which was accidentally added while rebasing
- Rework xilinx_pcs_validate to just clear out half-duplex modes instead
  of constraining modes based on the interface.

 MAINTAINERS                  |   6 +
 drivers/net/pcs/Kconfig      |  22 ++
 drivers/net/pcs/Makefile     |   2 +
 drivers/net/pcs/pcs-xilinx.c | 427 +++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c |   3 +-
 include/linux/phy.h          |   1 +
 6 files changed, 460 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/pcs/pcs-xilinx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0ac6ba5c40cb..496513837921 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27060,6 +27060,12 @@ L:	netdev@vger.kernel.org
 S:	Orphan
 F:	drivers/net/ethernet/xilinx/ll_temac*
 
+XILINX PCS DRIVER
+M:	Sean Anderson <sean.anderson@linux.dev>
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/xilinx,pcs.yaml
+F:	drivers/net/pcs/pcs-xilinx.c
+
 XILINX PWM DRIVER
 M:	Sean Anderson <sean.anderson@seco.com>
 S:	Maintained
diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index f42839a0c332..e0223914362b 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -52,4 +52,26 @@ config PCS_RZN1_MIIC
 	  on RZ/N1 SoCs. This PCS converts MII to RMII/RGMII or can be set in
 	  pass-through mode for MII.
 
+config PCS_XILINX
+	tristate "Xilinx PCS driver"
+	default XILINX_AXI_EMAC
+	select COMMON_CLK
+	select GPIOLIB
+	select MDIO_BUS
+	select OF
+	select PCS
+	select PHYLINK
+	help
+	  PCS driver for the Xilinx 1G/2.5G Ethernet PCS/PMA or SGMII device.
+	  This device can either act as a PCS+PMA for 1000BASE-X or 2500BASE-X,
+	  or as a GMII-to-SGMII bridge. It can also switch between 1000BASE-X
+	  and SGMII dynamically if configured correctly when synthesized.
+	  Typical applications use this device on an FPGA connected to a GEM or
+	  TEMAC on the GMII side. The other side is typically connected to
+	  on-device gigabit transceivers, off-device SERDES devices using TBI,
+	  or LVDS IO resources directly.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pcs-xilinx.
+
 endmenu
diff --git a/drivers/net/pcs/Makefile b/drivers/net/pcs/Makefile
index 35e3324fc26e..347afd91f034 100644
--- a/drivers/net/pcs/Makefile
+++ b/drivers/net/pcs/Makefile
@@ -10,3 +10,5 @@ obj-$(CONFIG_PCS_XPCS)		+= pcs_xpcs.o
 obj-$(CONFIG_PCS_LYNX)		+= pcs-lynx.o
 obj-$(CONFIG_PCS_MTK_LYNXI)	+= pcs-mtk-lynxi.o
 obj-$(CONFIG_PCS_RZN1_MIIC)	+= pcs-rzn1-miic.o
+obj-$(CONFIG_PCS_ALTERA_TSE)	+= pcs-altera-tse.o
+obj-$(CONFIG_PCS_XILINX)	+= pcs-xilinx.o
diff --git a/drivers/net/pcs/pcs-xilinx.c b/drivers/net/pcs/pcs-xilinx.c
new file mode 100644
index 000000000000..217178fbefb2
--- /dev/null
+++ b/drivers/net/pcs/pcs-xilinx.c
@@ -0,0 +1,427 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021-25 Sean Anderson <sean.anderson@seco.com>
+ *
+ * This is the driver for the Xilinx 1G/2.5G Ethernet PCS/PMA or SGMII LogiCORE
+ * IP. A typical setup will look something like
+ *
+ * MAC <--GMII--> PCS/PMA <--1000BASE-X--> SFP module (PMD)
+ *
+ * The IEEE model mostly describes this device, but the PCS layer has a
+ * separate sublayer for 8b/10b en/decoding:
+ *
+ * - When using a device-specific transceiver (serdes), the serdes handles 8b/10b
+ *   en/decoding and PMA functions. The IP implements other PCS functions.
+ * - When using LVDS IO resources, the IP implements PCS and PMA functions,
+ *   including 8b/10b en/decoding and (de)serialization.
+ * - When using an external serdes (accessed via TBI), the IP implements all
+ *   PCS functions, including 8b/10b en/decoding.
+ *
+ * The link to the PMD is not modeled by this driver, except for refclk. It is
+ * assumed that the serdes (if present) needs no configuration, though it
+ * should be fairly easy to add support. It is also possible to go from SGMII
+ * to GMII (PHY mode), but this is not supported.
+ *
+ * This driver was written with reference to PG047:
+ * https://docs.amd.com/r/en-US/pg047-gig-eth-pcs-pma
+ */
+
+#include <linux/bitmap.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iopoll.h>
+#include <linux/mdio.h>
+#include <linux/of.h>
+#include <linux/pcs.h>
+#include <linux/phylink.h>
+#include <linux/property.h>
+
+#include "../phy/phy-caps.h"
+
+/* Vendor-specific MDIO registers */
+#define XILINX_PCS_ANICR 16 /* Auto-Negotiation Interrupt Control Register */
+#define XILINX_PCS_SSR   17 /* Standard Selection Register */
+
+#define XILINX_PCS_ANICR_IE BIT(0) /* Interrupt Enable */
+#define XILINX_PCS_ANICR_IS BIT(1) /* Interrupt Status */
+
+#define XILINX_PCS_SSR_SGMII BIT(0) /* Select SGMII standard */
+
+/**
+ * struct xilinx_pcs - Private data for Xilinx PCS devices
+ * @pcs: The phylink PCS
+ * @mdiodev: The mdiodevice used to access the PCS
+ * @refclk: The reference clock for the PMD
+ * @refclk_out: Optional reference clock for other PCSs using this PCS's shared
+ *              logic
+ * @reset: The reset line for the PCS
+ * @done: Optional GPIO for reset_done
+ * @irq: IRQ, or -EINVAL if polling
+ * @enabled: Set if @pcs.link_change is valid and we can call phylink_pcs_change()
+ */
+struct xilinx_pcs {
+	struct phylink_pcs pcs;
+	struct clk_hw refclk_out;
+	struct clk *refclk;
+	struct gpio_desc *reset, *done;
+	struct mdio_device *mdiodev;
+	int irq;
+	bool enabled;
+};
+
+static inline struct xilinx_pcs *pcs_to_xilinx(struct phylink_pcs *pcs)
+{
+	return container_of(pcs, struct xilinx_pcs, pcs);
+}
+
+static irqreturn_t xilinx_pcs_an_irq(int irq, void *dev_id)
+{
+	struct xilinx_pcs *xp = dev_id;
+
+	if (mdiodev_modify_changed(xp->mdiodev, XILINX_PCS_ANICR,
+				   XILINX_PCS_ANICR_IS, 0) <= 0)
+		return IRQ_NONE;
+
+	/* paired with xilinx_pcs_enable/disable; protects xp->pcs->link_change */
+	if (smp_load_acquire(&xp->enabled))
+		phylink_pcs_change(&xp->pcs, true);
+	return IRQ_HANDLED;
+}
+
+static int xilinx_pcs_enable(struct phylink_pcs *pcs)
+{
+	struct xilinx_pcs *xp = pcs_to_xilinx(pcs);
+	struct device *dev = &xp->mdiodev->dev;
+	int ret;
+
+	if (xp->irq < 0)
+		return 0;
+
+	ret = mdiodev_modify(xp->mdiodev, XILINX_PCS_ANICR, 0,
+			     XILINX_PCS_ANICR_IE);
+	if (ret)
+		dev_err(dev, "could not clear IRQ enable: %d\n", ret);
+	else
+		/* paired with xilinx_pcs_an_irq */
+		smp_store_release(&xp->enabled, true);
+	return ret;
+}
+
+static void xilinx_pcs_disable(struct phylink_pcs *pcs)
+{
+	struct xilinx_pcs *xp = pcs_to_xilinx(pcs);
+	struct device *dev = &xp->mdiodev->dev;
+	int err;
+
+	if (xp->irq < 0)
+		return;
+
+	WRITE_ONCE(xp->enabled, false);
+	/* paired with xilinx_pcs_an_irq */
+	smp_wmb();
+
+	err = mdiodev_modify(xp->mdiodev, XILINX_PCS_ANICR,
+			     XILINX_PCS_ANICR_IE, 0);
+	if (err)
+		dev_err(dev, "could not clear IRQ enable: %d\n", err);
+}
+
+static __ETHTOOL_DECLARE_LINK_MODE_MASK(half_duplex) __ro_after_init;
+
+static int xilinx_pcs_validate(struct phylink_pcs *pcs,
+			       unsigned long *supported,
+			       const struct phylink_link_state *state)
+{
+	linkmode_andnot(supported, supported, half_duplex);
+	return 0;
+}
+
+static void xilinx_pcs_get_state(struct phylink_pcs *pcs,
+				 unsigned int neg_mode,
+				 struct phylink_link_state *state)
+{
+	struct xilinx_pcs *xp = pcs_to_xilinx(pcs);
+
+	phylink_mii_c22_pcs_get_state(xp->mdiodev, neg_mode, state);
+}
+
+static int xilinx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+			     phy_interface_t interface,
+			     const unsigned long *advertising,
+			     bool permit_pause_to_mac)
+{
+	int ret, changed = 0;
+	struct xilinx_pcs *xp = pcs_to_xilinx(pcs);
+
+	if (test_bit(PHY_INTERFACE_MODE_SGMII, pcs->supported_interfaces) &&
+	    test_bit(PHY_INTERFACE_MODE_1000BASEX, pcs->supported_interfaces)) {
+		u16 ssr;
+
+		if (interface == PHY_INTERFACE_MODE_SGMII)
+			ssr = XILINX_PCS_SSR_SGMII;
+		else
+			ssr = 0;
+
+		changed = mdiodev_modify_changed(xp->mdiodev, XILINX_PCS_SSR,
+						 XILINX_PCS_SSR_SGMII, ssr);
+		if (changed < 0)
+			return changed;
+	}
+
+	ret = phylink_mii_c22_pcs_config(xp->mdiodev, interface, advertising,
+					 neg_mode);
+	return ret ?: changed;
+}
+
+static void xilinx_pcs_an_restart(struct phylink_pcs *pcs)
+{
+	struct xilinx_pcs *xp = pcs_to_xilinx(pcs);
+
+	phylink_mii_c22_pcs_an_restart(xp->mdiodev);
+}
+
+static void xilinx_pcs_link_up(struct phylink_pcs *pcs, unsigned int mode,
+			       phy_interface_t interface, int speed, int duplex)
+{
+	int bmcr;
+	struct xilinx_pcs *xp = pcs_to_xilinx(pcs);
+
+	if (phylink_autoneg_inband(mode))
+		return;
+
+	bmcr = mdiodev_read(xp->mdiodev, MII_BMCR);
+	if (bmcr < 0) {
+		dev_err(&xp->mdiodev->dev, "could not read BMCR (err=%d)\n",
+			bmcr);
+		return;
+	}
+
+	bmcr &= ~(BMCR_SPEED1000 | BMCR_SPEED100);
+	switch (speed) {
+	case SPEED_2500:
+	case SPEED_1000:
+		bmcr |= BMCR_SPEED1000;
+		break;
+	case SPEED_100:
+		bmcr |= BMCR_SPEED100;
+		break;
+	case SPEED_10:
+		bmcr |= BMCR_SPEED10;
+		break;
+	default:
+		dev_err(&xp->mdiodev->dev, "invalid speed %d\n", speed);
+	}
+
+	bmcr = mdiodev_write(xp->mdiodev, MII_BMCR, bmcr);
+	if (bmcr < 0)
+		dev_err(&xp->mdiodev->dev, "could not write BMCR (err=%d)\n",
+			bmcr);
+}
+
+static const struct phylink_pcs_ops xilinx_pcs_ops = {
+	.pcs_validate = xilinx_pcs_validate,
+	.pcs_enable = xilinx_pcs_enable,
+	.pcs_disable = xilinx_pcs_disable,
+	.pcs_get_state = xilinx_pcs_get_state,
+	.pcs_config = xilinx_pcs_config,
+	.pcs_an_restart = xilinx_pcs_an_restart,
+	.pcs_link_up = xilinx_pcs_link_up,
+};
+
+static const struct clk_ops xilinx_pcs_clk_ops = { };
+
+static const phy_interface_t xilinx_pcs_interfaces[] = {
+	PHY_INTERFACE_MODE_SGMII,
+	PHY_INTERFACE_MODE_1000BASEX,
+	PHY_INTERFACE_MODE_2500BASEX,
+};
+
+static int xilinx_pcs_probe(struct mdio_device *mdiodev)
+{
+	struct device *dev = &mdiodev->dev;
+	struct fwnode_handle *fwnode = dev->fwnode;
+	int ret, i, j, mode_count;
+	struct xilinx_pcs *xp;
+	const char **modes;
+	u32 phy_id;
+
+	xp = devm_kzalloc(dev, sizeof(*xp), GFP_KERNEL);
+	if (!xp)
+		return -ENOMEM;
+	xp->mdiodev = mdiodev;
+	dev_set_drvdata(dev, xp);
+
+	xp->irq = fwnode_irq_get_byname(fwnode, "an");
+	/* There's no _optional variant, so this is the best we've got */
+	if (xp->irq < 0 && xp->irq != -EINVAL)
+		return dev_err_probe(dev, xp->irq, "could not get IRQ\n");
+
+	mode_count = fwnode_property_string_array_count(fwnode,
+							"xlnx,pcs-modes");
+	if (!mode_count)
+		mode_count = -ENODATA;
+	if (mode_count < 0) {
+		dev_err(dev, "could not read xlnx,pcs-modes: %d", mode_count);
+		return mode_count;
+	}
+
+	modes = kcalloc(mode_count, sizeof(*modes), GFP_KERNEL);
+	if (!modes)
+		return -ENOMEM;
+
+	ret = fwnode_property_read_string_array(fwnode, "xlnx,pcs-modes",
+						modes, mode_count);
+	if (ret < 0) {
+		dev_err(dev, "could not read xlnx,pcs-modes: %d\n", ret);
+		kfree(modes);
+		return ret;
+	}
+
+	for (i = 0; i < mode_count; i++) {
+		for (j = 0; j < ARRAY_SIZE(xilinx_pcs_interfaces); j++) {
+			if (!strcmp(phy_modes(xilinx_pcs_interfaces[j]), modes[i])) {
+				__set_bit(xilinx_pcs_interfaces[j],
+					  xp->pcs.supported_interfaces);
+				goto next;
+			}
+		}
+
+		dev_err(dev, "invalid pcs-mode \"%s\"\n", modes[i]);
+		kfree(modes);
+		return -EINVAL;
+next:
+		;
+	}
+
+	kfree(modes);
+	if ((test_bit(PHY_INTERFACE_MODE_SGMII, xp->pcs.supported_interfaces) ||
+	     test_bit(PHY_INTERFACE_MODE_1000BASEX, xp->pcs.supported_interfaces)) &&
+	    test_bit(PHY_INTERFACE_MODE_2500BASEX, xp->pcs.supported_interfaces)) {
+		dev_err(dev,
+			"Switching from SGMII or 1000Base-X to 2500Base-X not supported\n");
+		return -EINVAL;
+	}
+
+	xp->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(xp->reset))
+		return dev_err_probe(dev, PTR_ERR(xp->reset),
+				     "could not get reset gpio\n");
+
+	xp->done = devm_gpiod_get_optional(dev, "done", GPIOD_IN);
+	if (IS_ERR(xp->done))
+		return dev_err_probe(dev, PTR_ERR(xp->done),
+				     "could not get done gpio\n");
+
+	xp->refclk = devm_clk_get_optional_enabled(dev, "refclk");
+	if (IS_ERR(xp->refclk))
+		return dev_err_probe(dev, PTR_ERR(xp->refclk),
+				     "could not get/enable reference clock\n");
+
+	gpiod_set_value_cansleep(xp->reset, 0);
+	if (xp->done) {
+		if (read_poll_timeout(gpiod_get_value_cansleep, ret, ret, 1000,
+				      100000, true, xp->done))
+			return dev_err_probe(dev, -ETIMEDOUT,
+					     "timed out waiting for reset\n");
+	} else {
+		/* Just wait for a while and hope we're done */
+		usleep_range(50000, 100000);
+	}
+
+	if (fwnode_property_present(fwnode, "#clock-cells")) {
+		const char *parent = "refclk";
+		struct clk_init_data init = {
+			.name = fwnode_get_name(fwnode),
+			.ops = &xilinx_pcs_clk_ops,
+			.parent_names = &parent,
+			.num_parents = 1,
+			.flags = 0,
+		};
+
+		xp->refclk_out.init = &init;
+		ret = devm_clk_hw_register(dev, &xp->refclk_out);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "could not register refclk\n");
+
+		ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+						  &xp->refclk_out);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "could not register refclk\n");
+	}
+
+	/* Sanity check */
+	ret = get_phy_c22_id(mdiodev->bus, mdiodev->addr, &phy_id);
+	if (ret)
+		return dev_err_probe(dev, ret, "could not read id\n");
+	if ((phy_id & 0xfffffff0) != 0x01740c00)
+		dev_warn(dev, "unknown phy id %x\n", phy_id);
+
+	if (xp->irq < 0) {
+		xp->pcs.poll = true;
+	} else {
+		/* The IRQ is enabled by default; turn it off */
+		ret = mdiodev_write(xp->mdiodev, XILINX_PCS_ANICR, 0);
+		if (ret) {
+			dev_err(dev, "could not disable IRQ: %d\n", ret);
+			return ret;
+		}
+
+		/* Some PCSs have a bad habit of re-enabling their IRQ!
+		 * Request the IRQ in probe so we don't end up triggering the
+		 * spurious IRQ logic.
+		 */
+		ret = devm_request_threaded_irq(dev, xp->irq, NULL, xilinx_pcs_an_irq,
+						IRQF_SHARED | IRQF_ONESHOT,
+						dev_name(dev), xp);
+		if (ret) {
+			dev_err(dev, "could not request IRQ: %d\n", ret);
+			return ret;
+		}
+	}
+
+	xp->pcs.ops = &xilinx_pcs_ops;
+	ret = devm_pcs_register(dev, &xp->pcs);
+	if (ret)
+		return dev_err_probe(dev, ret, "could not register PCS\n");
+
+	if (xp->irq < 0)
+		dev_info(dev, "probed with irq=poll\n");
+	else
+		dev_info(dev, "probed with irq=%d\n", xp->irq);
+	return 0;
+}
+
+static const struct of_device_id xilinx_pcs_of_match[] = {
+	{ .compatible = "xlnx,pcs", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xilinx_pcs_of_match);
+
+static struct mdio_driver xilinx_pcs_driver = {
+	.probe = xilinx_pcs_probe,
+	.mdiodrv.driver = {
+		.name = "xilinx-pcs",
+		.of_match_table = of_match_ptr(xilinx_pcs_of_match),
+	},
+};
+
+static int __init xilinx_pcs_init(void)
+{
+	phy_caps_linkmodes(LINK_CAPA_10HD | LINK_CAPA_100HD | LINK_CAPA_1000HD,
+			   half_duplex);
+	return mdio_driver_register(&xilinx_pcs_driver);
+}
+module_init(xilinx_pcs_init);
+
+static void __exit xilinx_pcs_exit(void)
+{
+	mdio_driver_unregister(&xilinx_pcs_driver);
+}
+module_exit(xilinx_pcs_exit)
+
+MODULE_ALIAS("platform:xilinx-pcs");
+MODULE_DESCRIPTION("Xilinx PCS driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 73f9cb2e2844..ee8fb3806312 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -921,7 +921,7 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr,
  * valid, %-EIO on bus access error, or %-ENODEV if no device responds
  * or invalid ID.
  */
-static int get_phy_c22_id(struct mii_bus *bus, int addr, u32 *phy_id)
+int get_phy_c22_id(struct mii_bus *bus, int addr, u32 *phy_id)
 {
 	int phy_reg;
 
@@ -949,6 +949,7 @@ static int get_phy_c22_id(struct mii_bus *bus, int addr, u32 *phy_id)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(get_phy_c22_id);
 
 /* Extract the phy ID from the compatible string of the form
  * ethernet-phy-idAAAA.BBBB.
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e194dad1623d..71c066a718c3 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1751,6 +1751,7 @@ int phy_modify_paged(struct phy_device *phydev, int page, u32 regnum,
 struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 				     bool is_c45,
 				     struct phy_c45_device_ids *c45_ids);
+int get_phy_c22_id(struct mii_bus *bus, int addr, u32 *phy_id);
 int fwnode_get_phy_id(struct fwnode_handle *fwnode, u32 *phy_id);
 struct mdio_device *fwnode_mdio_find_device(struct fwnode_handle *fwnode);
 struct phy_device *fwnode_phy_find_device(struct fwnode_handle *phy_fwnode);
-- 
2.35.1.1320.gc452695387.dirty


