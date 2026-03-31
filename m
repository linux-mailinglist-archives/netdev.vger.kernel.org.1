Return-Path: <netdev+bounces-273614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLLzISvBy2mELgYAu9opvQ
	(envelope-from <netdev+bounces-273614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:42:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B883699C6
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 987453000B34
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC253E120A;
	Tue, 31 Mar 2026 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rNOABCs+"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B313DFC71;
	Tue, 31 Mar 2026 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774960842; cv=none; b=OgHH/RXb+/SFACp2DiG4v5FTGdgIxP/2Bb/fYwFH3rhV9B34fYqAl+ZGwXp+tiHF+uHrKNY82yJgL4j0ZLB6J/4utYJwmUjxSGeg8yGQaKUjBx2KIXNFyHcRtgGZoZPY0h2aRSo/21PHMYaFkBpkiW81RFXpKSxMVBEsRWHd7vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774960842; c=relaxed/simple;
	bh=OP8xrm289oBzG4JM8lcE4OIwCW8ZgdCKeR9zawcN1lI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSWZ9R1jLv01lZga0lUTa3OFvQukTcbhLuNnYAX8rnncKbaIkZsNH1j1xL5gwFNVRi2qZu9CsfJRNDckpjTa4uDFPoWfxbunmanQmVmG8zML9Bfm1QCmX1ApJEjjTD0PFhklCjJG9InhGd4tkJx1ydDhnzlJLEWQ9N/x0RzVV1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rNOABCs+; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774960841; x=1806496841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OP8xrm289oBzG4JM8lcE4OIwCW8ZgdCKeR9zawcN1lI=;
  b=rNOABCs+tpSeZqOH9Se9o5ne68fqM6JbzxvpVoavBxRrBzDpILPAOD75
   wdy8wqDtv1Jk3z/HOrz93pkY1FN5BhAbcitdK/QuVz93rFH+M1dLp6aTa
   vDUukfDdiSpDw1xHeF+fT9/5PZR/fuzwvX7wn2EnFi5O9jgOj8yrmsYN3
   BN4A0wWeGguT67WX04tHkrOgQI3rQHOdQIjcbK+ADfFj6/yl573KvPrl1
   Wtc/DpPdHLIUro+8czEWRt6yiFAuWWMvLqNRYExsErgu1HxyZ9EtgTiAt
   2acvQU20sTi3edsipTz4y7obzOWwTl2Ln0aeZQgeHU19fFYOIOFj7IHep
   A==;
X-CSE-ConnectionGUID: wckcZBG/SMGh/js/KG+EMA==
X-CSE-MsgGUID: TpZ7g4Z+QuKq/7VlT90EjQ==
X-IronPort-AV: E=Sophos;i="6.23,151,1770620400"; 
   d="scan'208";a="63246393"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Mar 2026 05:40:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 31 Mar 2026 05:39:59 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 31 Mar 2026 05:39:59 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 2/2] net: mdio: add a driver for PIC64-HPSC/HX MDIO controller
Date: Tue, 31 Mar 2026 05:38:54 -0700
Message-ID: <20260331123858.1912449-3-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331123858.1912449-1-charles.perry@microchip.com>
References: <20260331123858.1912449-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273614-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,bootlin.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[microchip.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:email,microchip.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Queue-Id: 29B883699C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This adds an MDIO driver for PIC64-HPSC/HX. The hardware supports C22
and C45 but only C22 is implemented in this commit.

This MDIO hardware is based on a Microsemi design supported in Linux by
mdio-mscc-miim.c. However, The register interface is completely
different with pic64hpsc, hence the need for a separate driver.

The documentation recommends an input clock of 156.25MHz and a prescaler
of 39, which yields an MDIO clock of 1.95MHz.

The hardware supports an interrupt pin or a "TRIGGER" bit that can be
polled to signal transaction completion. This commit uses polling.

This was tested on Microchip HB1301 evalkit with a VSC8574 and a
VSC8541.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---

Notes:
    Changes in v3:
      - Add a MAINTAINERS entry (Jakub)
    
    Changes in v2:
      - Remove #define for unused registers (Maxime)
      - Add "c22" to clause 22 read/write ops (Maxime)
      - Remove the call to platform_set_drvdata() (Andrew)
      - Make the clock mandatory (Andrew)
      - Use 2.5MHz if no clock-frequency was specified (Andrew)
      - Change the error message for bad clock-frequency (Andrew)
      - Fix a use without initialization on bus_freq (Andrew)

 MAINTAINERS                       |   6 +
 drivers/net/mdio/Kconfig          |   7 ++
 drivers/net/mdio/Makefile         |   1 +
 drivers/net/mdio/mdio-pic64hpsc.c | 192 ++++++++++++++++++++++++++++++
 4 files changed, 206 insertions(+)
 create mode 100644 drivers/net/mdio/mdio-pic64hpsc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e08767323763..9297c46dba91 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17216,6 +17216,12 @@ L:	linux-serial@vger.kernel.org
 S:	Maintained
 F:	drivers/tty/serial/8250/8250_pci1xxxx.c
 
+MICROCHIP PIC64-HPSC/HX DRIVERS
+M:	Charles Perry <charles.perry@microchip.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
+F:	drivers/net/mdio/mdio-pic64hpsc.c
+
 MICROCHIP POLARFIRE FPGA DRIVERS
 M:	Conor Dooley <conor.dooley@microchip.com>
 L:	linux-fpga@vger.kernel.org
diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index 44380378911b..7bdba8c3ddef 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -146,6 +146,13 @@ config MDIO_OCTEON
 	  buses. It is required by the Octeon and ThunderX ethernet device
 	  drivers on some systems.
 
+config MDIO_PIC64HPSC
+	tristate "PIC64-HPSC/HX MDIO interface support"
+	depends on HAS_IOMEM && OF_MDIO
+	help
+	  This driver supports the MDIO interface found on the PIC64-HPSC/HX
+	  SoCs.
+
 config MDIO_IPQ4019
 	tristate "Qualcomm IPQ4019 MDIO interface support"
 	depends on HAS_IOMEM && OF_MDIO
diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
index fbec636700e7..048586746026 100644
--- a/drivers/net/mdio/Makefile
+++ b/drivers/net/mdio/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_MDIO_MOXART)		+= mdio-moxart.o
 obj-$(CONFIG_MDIO_MSCC_MIIM)		+= mdio-mscc-miim.o
 obj-$(CONFIG_MDIO_MVUSB)		+= mdio-mvusb.o
 obj-$(CONFIG_MDIO_OCTEON)		+= mdio-octeon.o
+obj-$(CONFIG_MDIO_PIC64HPSC)		+= mdio-pic64hpsc.o
 obj-$(CONFIG_MDIO_REALTEK_RTL9300)	+= mdio-realtek-rtl9300.o
 obj-$(CONFIG_MDIO_REGMAP)		+= mdio-regmap.o
 obj-$(CONFIG_MDIO_SUN4I)		+= mdio-sun4i.o
diff --git a/drivers/net/mdio/mdio-pic64hpsc.c b/drivers/net/mdio/mdio-pic64hpsc.c
new file mode 100644
index 000000000000..0ca6f5af5396
--- /dev/null
+++ b/drivers/net/mdio/mdio-pic64hpsc.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Microchip PIC64-HPSC/HX MDIO controller driver
+ *
+ * Copyright (c) 2026 Microchip Technology Inc. and its subsidiaries.
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_mdio.h>
+#include <linux/platform_device.h>
+
+#define MDIO_REG_PRESCALER     0x20
+#define MDIO_CFG_PRESCALE_MASK GENMASK(7, 0)
+
+#define MDIO_REG_FRAME_CFG_1 0x24
+#define MDIO_WDATA_MASK	     GENMASK(15, 0)
+
+#define MDIO_REG_FRAME_CFG_2	 0x28
+#define MDIO_TRIGGER_BIT	 BIT(31)
+#define MDIO_REG_DEV_ADDR_MASK	 GENMASK(20, 16)
+#define MDIO_PHY_PRT_ADDR_MASK	 GENMASK(8, 4)
+#define MDIO_OPERATION_MASK	 GENMASK(3, 2)
+#define MDIO_START_OF_FRAME_MASK GENMASK(1, 0)
+
+/* Possible value of MDIO_OPERATION_MASK */
+#define MDIO_OPERATION_WRITE BIT(0)
+#define MDIO_OPERATION_READ  BIT(1)
+
+#define MDIO_REG_FRAME_STATUS 0x2C
+#define MDIO_READOK_BIT	      BIT(24)
+#define MDIO_RDATA_MASK	      GENMASK(15, 0)
+
+struct pic64hpsc_mdio_dev {
+	void __iomem *regs;
+};
+
+static int pic64hpsc_mdio_wait_trigger(struct mii_bus *bus)
+{
+	struct pic64hpsc_mdio_dev *priv = bus->priv;
+	u32 val;
+	int ret;
+
+	/* The MDIO_TRIGGER bit returns 0 when a transaction has completed. */
+	ret = readl_poll_timeout(priv->regs + MDIO_REG_FRAME_CFG_2, val,
+				 !(val & MDIO_TRIGGER_BIT), 50, 10000);
+
+	if (ret < 0)
+		dev_dbg(&bus->dev, "TRIGGER bit timeout: %x\n", val);
+
+	return ret;
+}
+
+static int pic64hpsc_mdio_c22_read(struct mii_bus *bus, int mii_id, int regnum)
+{
+	struct pic64hpsc_mdio_dev *priv = bus->priv;
+	u32 val;
+	int ret;
+
+	ret = pic64hpsc_mdio_wait_trigger(bus);
+	if (ret)
+		return ret;
+
+	writel(MDIO_TRIGGER_BIT | FIELD_PREP(MDIO_REG_DEV_ADDR_MASK, regnum) |
+		       FIELD_PREP(MDIO_PHY_PRT_ADDR_MASK, mii_id) |
+		       FIELD_PREP(MDIO_OPERATION_MASK, MDIO_OPERATION_READ) |
+		       FIELD_PREP(MDIO_START_OF_FRAME_MASK, 1),
+	       priv->regs + MDIO_REG_FRAME_CFG_2);
+
+	ret = pic64hpsc_mdio_wait_trigger(bus);
+	if (ret)
+		return ret;
+
+	val = readl(priv->regs + MDIO_REG_FRAME_STATUS);
+
+	/* The MDIO_READOK is a 1-bit value reflecting the inverse of the MDIO
+	 * bus value captured during the 2nd TA cycle. A PHY/Port should drive
+	 * the MDIO bus with a logic 0 on the 2nd TA cycle, however, the
+	 * PHY/Port could optionally drive a logic 1, to communicate a read
+	 * failure. This feature is optional, not defined by the 802.3 standard
+	 * and not supported in standard external PHYs.
+	 */
+	if (!(bus->phy_ignore_ta_mask & 1 << mii_id) &&
+	    !FIELD_GET(MDIO_READOK_BIT, val)) {
+		dev_dbg(&bus->dev, "READOK bit cleared\n");
+		return -EIO;
+	}
+
+	ret = FIELD_GET(MDIO_RDATA_MASK, val);
+
+	return ret;
+}
+
+static int pic64hpsc_mdio_c22_write(struct mii_bus *bus, int mii_id, int regnum,
+				    u16 value)
+{
+	struct pic64hpsc_mdio_dev *priv = bus->priv;
+	int ret;
+
+	ret = pic64hpsc_mdio_wait_trigger(bus);
+	if (ret < 0)
+		return ret;
+
+	writel(FIELD_PREP(MDIO_WDATA_MASK, value),
+	       priv->regs + MDIO_REG_FRAME_CFG_1);
+
+	writel(MDIO_TRIGGER_BIT | FIELD_PREP(MDIO_REG_DEV_ADDR_MASK, regnum) |
+		       FIELD_PREP(MDIO_PHY_PRT_ADDR_MASK, mii_id) |
+		       FIELD_PREP(MDIO_OPERATION_MASK, MDIO_OPERATION_WRITE) |
+		       FIELD_PREP(MDIO_START_OF_FRAME_MASK, 1),
+	       priv->regs + MDIO_REG_FRAME_CFG_2);
+
+	return 0;
+}
+
+static int pic64hpsc_mdio_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct pic64hpsc_mdio_dev *priv;
+	struct mii_bus *bus;
+	unsigned long rate;
+	struct clk *clk;
+	u32 bus_freq;
+	u32 div;
+	int ret;
+
+	bus = devm_mdiobus_alloc_size(dev, sizeof(*priv));
+	if (!bus)
+		return -ENOMEM;
+
+	priv = bus->priv;
+
+	priv->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->regs))
+		return PTR_ERR(priv->regs);
+
+	bus->name = KBUILD_MODNAME;
+	bus->read = pic64hpsc_mdio_c22_read;
+	bus->write = pic64hpsc_mdio_c22_write;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
+	bus->parent = dev;
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	if (of_property_read_u32(np, "clock-frequency", &bus_freq))
+		bus_freq = 2500000;
+
+	rate = clk_get_rate(clk);
+
+	div = DIV_ROUND_UP(rate, 2 * bus_freq) - 1;
+	if (div == 0 || div & ~MDIO_CFG_PRESCALE_MASK) {
+		dev_err(dev, "MDIO clock-frequency out of range\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "rate=%lu bus_freq=%u real_bus_freq=%lu div=%u\n", rate,
+		bus_freq, rate / (2 * (1 + div)), div);
+	writel(div, priv->regs + MDIO_REG_PRESCALER);
+
+	ret = devm_of_mdiobus_register(dev, bus, np);
+	if (ret) {
+		dev_err(dev, "Cannot register MDIO bus (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id pic64hpsc_mdio_match[] = {
+	{ .compatible = "microchip,pic64hpsc-mdio" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pic64hpsc_mdio_match);
+
+static struct platform_driver pic64hpsc_mdio_driver = {
+	.probe = pic64hpsc_mdio_probe,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = pic64hpsc_mdio_match,
+	},
+};
+module_platform_driver(pic64hpsc_mdio_driver);
+
+MODULE_AUTHOR("Charles Perry <charles.perry@microchip.com>");
+MODULE_DESCRIPTION("Microchip PIC64-HPSC/HX MDIO driver");
+MODULE_LICENSE("GPL");
-- 
2.47.3


