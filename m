Return-Path: <netdev+bounces-269186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCJFIbgYu2k+fAIAu9opvQ
	(envelope-from <netdev+bounces-269186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:27:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F37C02C2F7A
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4C673035A81
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7D437B3EB;
	Wed, 18 Mar 2026 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KvxF5vYJ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E31D2D1913;
	Wed, 18 Mar 2026 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773869237; cv=none; b=cbXMbMwCxZ4Nmh2C8UNFsXRnJS0xyu9TsBwxhQ10y9UeNX/BayJe8fUJU6PcaDobYMP/Ly6ivyxRgXG0RlwL1H8cW+I8g7mkQ0FdfZ1o6uPNk2HpidBhZVtqihJvYDf8hDWgqsy57oeEgEgcp7BzDnOKSjgVXstSWyuRfJXRn4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773869237; c=relaxed/simple;
	bh=dUCzhGSCyp9yBqj1ldwZzevPNGn/CjOVTpyQctiXBe4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=le3jBm4y3F+kM3kp69y2Q7QRFewx9CpfaWIlZvyI420gfuV/VsLP4OHOBFixy9FjBVRH7WD3x0xY/1SPVB07nVXLq5DChjGuNIUrf/HVGIhSajirLIzFx7Rukl26BpnAk8z+REebWXWyxIf68OLHkD17sk77c9U8RqyZRItLNrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KvxF5vYJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773869235; x=1805405235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dUCzhGSCyp9yBqj1ldwZzevPNGn/CjOVTpyQctiXBe4=;
  b=KvxF5vYJT6sayWNbD5IeECEtdLj/+v3keoHxa6ATfs9Njw/KxcGyAhxW
   P8bC0vWqpPx6uY3ISw0rLlnmTKabu23JDj0t1YbefS3g10Rye2gINZ+5j
   fyAMdeHIlJtpeWa5yGO2KSZ0rNosCQjl9ZRd3hA71s5QFxLb7pzm4gIIo
   kpi/DTqd503fSniV+iq6kWubi5q5jSGIRL5I9WV3EONIrflZLiMBzA850
   vm4SbsDs1R+IyjDOH4EHvhNZyHfcRiwOtNZ/R7cgLJwY0q948bS5QRAx2
   NYaVub5yHQQhSmLwg9nzD3HD77JesooBiqQJ/LyXPadjJ70gJlxKbtRfE
   A==;
X-CSE-ConnectionGUID: afo4+UZhS6qg5t7nkT5I3w==
X-CSE-MsgGUID: XkJSx+EfT5CgJbrWpZCJGw==
X-IronPort-AV: E=Sophos;i="6.23,128,1770620400"; 
   d="scan'208";a="55289466"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2026 14:27:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 18 Mar 2026 14:25:59 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Wed, 18 Mar 2026 14:25:57 -0700
Date: Wed, 18 Mar 2026 14:25:55 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: Charles Perry <charles.perry@microchip.com>, <netdev@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: mdio: add a driver for PIC64-HPSC/HX
 MDIO controller
Message-ID: <absYYxpgb9Ts5qtU@bby-cbu-swbuild03.eng.microchip.com>
References: <20260317184610.315852-1-charles.perry@microchip.com>
 <20260317184610.315852-3-charles.perry@microchip.com>
 <5c9eb2e9-1727-4c01-888d-56ffee6ca54a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5c9eb2e9-1727-4c01-888d-56ffee6ca54a@bootlin.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-269186-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.948];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bby-cbu-swbuild03.eng.microchip.com:mid]
X-Rspamd-Queue-Id: F37C02C2F7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 10:52:46AM +0100, Maxime Chevallier wrote:
> Hi Charles,
> 
> On 17/03/2026 19:46, Charles Perry wrote:
> > This adds an MDIO driver for PIC64-HPSC/HX. The hardware supports C22
> > and C45 but only C22 is implemented in this commit.
> > 
> > This MDIO hardware is based on a Microsemi design supported in Linux by
> > mdio-mscc-miim.c. However, The register interface is completely
> > different with pic64hpsc, hence the need for a separate driver.
> > 
> > The documentation recommends an input clock of 156.25MHz and a prescaler
> > of 39, which yields an MDIO clock of 1.95MHz.
> > 
> > The hardware supports an interrupt pin or a "TRIGGER" bit that can be
> > polled to signal transaction completion. This commit uses polling.
> > 
> > This was tested on Microchip HB1301 evalkit with a VSC8574 and a
> > VSC8541.
> > 
> > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > ---
> >  drivers/net/mdio/Kconfig          |   7 +
> >  drivers/net/mdio/Makefile         |   1 +
> >  drivers/net/mdio/mdio-pic64hpsc.c | 207 ++++++++++++++++++++++++++++++
> >  3 files changed, 215 insertions(+)
> >  create mode 100644 drivers/net/mdio/mdio-pic64hpsc.c
> > 
> > diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
> > index 44380378911b..7bdba8c3ddef 100644
> > --- a/drivers/net/mdio/Kconfig
> > +++ b/drivers/net/mdio/Kconfig
> > @@ -146,6 +146,13 @@ config MDIO_OCTEON
> >  	  buses. It is required by the Octeon and ThunderX ethernet device
> >  	  drivers on some systems.
> >  
> > +config MDIO_PIC64HPSC
> > +	tristate "PIC64-HPSC/HX MDIO interface support"
> > +	depends on HAS_IOMEM && OF_MDIO
> > +	help
> > +	  This driver supports the MDIO interface found on the PIC64-HPSC/HX
> > +	  SoCs.
> > +
> >  config MDIO_IPQ4019
> >  	tristate "Qualcomm IPQ4019 MDIO interface support"
> >  	depends on HAS_IOMEM && OF_MDIO
> > diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
> > index fbec636700e7..048586746026 100644
> > --- a/drivers/net/mdio/Makefile
> > +++ b/drivers/net/mdio/Makefile
> > @@ -20,6 +20,7 @@ obj-$(CONFIG_MDIO_MOXART)		+= mdio-moxart.o
> >  obj-$(CONFIG_MDIO_MSCC_MIIM)		+= mdio-mscc-miim.o
> >  obj-$(CONFIG_MDIO_MVUSB)		+= mdio-mvusb.o
> >  obj-$(CONFIG_MDIO_OCTEON)		+= mdio-octeon.o
> > +obj-$(CONFIG_MDIO_PIC64HPSC)		+= mdio-pic64hpsc.o
> >  obj-$(CONFIG_MDIO_REALTEK_RTL9300)	+= mdio-realtek-rtl9300.o
> >  obj-$(CONFIG_MDIO_REGMAP)		+= mdio-regmap.o
> >  obj-$(CONFIG_MDIO_SUN4I)		+= mdio-sun4i.o
> > diff --git a/drivers/net/mdio/mdio-pic64hpsc.c b/drivers/net/mdio/mdio-pic64hpsc.c
> > new file mode 100644
> > index 000000000000..1128b3a86804
> > --- /dev/null
> > +++ b/drivers/net/mdio/mdio-pic64hpsc.c
> > @@ -0,0 +1,207 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Microchip PIC64-HPSC/HX MDIO controller driver
> > + *
> > + * Copyright (c) 2026 Microchip Technology Inc. and its subsidiaries.
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of_mdio.h>
> > +#include <linux/platform_device.h>
> > +
> > +#define MDIO_REG_PRESCALER     0x20
> > +#define MDIO_CFG_PRESCALE_MASK GENMASK(7, 0)
> > +
> > +#define MDIO_REG_FRAME_CFG_1 0x24
> > +#define MDIO_WDATA_MASK	     GENMASK(15, 0)
> > +
> > +#define MDIO_REG_FRAME_CFG_2	 0x28
> > +#define MDIO_TRIGGER_BIT	 BIT(31)
> > +#define MDIO_REG_DEV_ADDR_MASK	 GENMASK(20, 16)
> > +#define MDIO_PHY_PRT_ADDR_MASK	 GENMASK(8, 4)
> > +#define MDIO_OPERATION_MASK	 GENMASK(3, 2)
> > +#define MDIO_START_OF_FRAME_MASK GENMASK(1, 0)
> > +
> > +/* Possible value of MDIO_OPERATION_MASK */
> > +#define MDIO_OPERATION_WRITE BIT(0)
> > +#define MDIO_OPERATION_READ  BIT(1)
> > +
> > +#define MDIO_REG_FRAME_STATUS 0x2C
> > +#define MDIO_READOK_BIT	      BIT(24)
> > +#define MDIO_RDATA_MASK	      GENMASK(15, 0)
> > +
> > +#define MDIO_INT_I_ADDR 0x30
> > +#define MDIO_INT_I_BIT	BIT(0)
> > +
> > +#define MDIO_INT_E_ADDR 0x34
> > +#define MDIO_INT_E_BIT	BIT(0)
> 
> Thes INT_I/E don't seem to be used, you can drop them

Ok

> 
> > +
> > +struct pic64hpsc_mdio_dev {
> > +	void __iomem *regs;
> > +};
> > +
> > +static int pic64hpsc_mdio_wait_trigger(struct mii_bus *bus)
> > +{
> > +	struct pic64hpsc_mdio_dev *priv = bus->priv;
> > +	u32 val;
> > +	int ret;
> > +
> > +	/* The MDIO_TRIGGER bit returns 0 when a transaction has completed. */
> > +	ret = readl_poll_timeout(priv->regs + MDIO_REG_FRAME_CFG_2, val,
> > +				 !(val & MDIO_TRIGGER_BIT), 50, 10000);
> > +
> > +	if (ret < 0)
> > +		dev_dbg(&bus->dev, "TRIGGER bit timeout: %x\n", val);
> > +
> > +	return ret;
> > +}
> > +
> > +static int pic64hpsc_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
> > +{
> > +	struct pic64hpsc_mdio_dev *priv = bus->priv;
> > +	u32 val;
> > +	int ret;
> > +
> > +	ret = pic64hpsc_mdio_wait_trigger(bus);
> > +	if (ret)
> > +		return ret;
> > +
> > +	writel(MDIO_TRIGGER_BIT | FIELD_PREP(MDIO_REG_DEV_ADDR_MASK, regnum) |
> > +		       FIELD_PREP(MDIO_PHY_PRT_ADDR_MASK, mii_id) |
> > +		       FIELD_PREP(MDIO_OPERATION_MASK, MDIO_OPERATION_READ) |
> > +		       FIELD_PREP(MDIO_START_OF_FRAME_MASK, 1),
> > +	       priv->regs + MDIO_REG_FRAME_CFG_2);
> > +
> > +	ret = pic64hpsc_mdio_wait_trigger(bus);
> > +	if (ret)
> > +		return ret;
> > +
> > +	val = readl(priv->regs + MDIO_REG_FRAME_STATUS);
> > +
> > +	/* The MDIO_READOK is a 1-bit value reflecting the inverse of the MDIO
> > +	 * bus value captured during the 2nd TA cycle. A PHY/Port should drive
> > +	 * the MDIO bus with a logic 0 on the 2nd TA cycle, however, the
> > +	 * PHY/Port could optionally drive a logic 1, to communicate a read
> > +	 * failure. This feature is optional, not defined by the 802.3 standard
> > +	 * and not supported in standard external PHYs.
> > +	 */
> > +	if (!(bus->phy_ignore_ta_mask & 1 << mii_id) &&
> > +	    !FIELD_GET(MDIO_READOK_BIT, val)) {
> > +		dev_dbg(&bus->dev, "READOK bit cleared\n");
> > +		return -EIO;
> > +	}
> > +
> > +	ret = FIELD_GET(MDIO_RDATA_MASK, val);
> > +
> > +	return ret;
> > +}
> > +
> > +static int pic64hpsc_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
> > +				u16 value)
> > +{
> > +	struct pic64hpsc_mdio_dev *priv = bus->priv;
> > +	int ret;
> > +
> > +	ret = pic64hpsc_mdio_wait_trigger(bus);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	writel(FIELD_PREP(MDIO_WDATA_MASK, value),
> > +	       priv->regs + MDIO_REG_FRAME_CFG_1);
> > +
> > +	writel(MDIO_TRIGGER_BIT | FIELD_PREP(MDIO_REG_DEV_ADDR_MASK, regnum) |
> > +		       FIELD_PREP(MDIO_PHY_PRT_ADDR_MASK, mii_id) |
> > +		       FIELD_PREP(MDIO_OPERATION_MASK, MDIO_OPERATION_WRITE) |
> > +		       FIELD_PREP(MDIO_START_OF_FRAME_MASK, 1),
> > +	       priv->regs + MDIO_REG_FRAME_CFG_2);
> > +
> > +	return 0;
> > +}
> > +
> > +static int pic64hpsc_mdio_probe(struct platform_device *pdev)
> > +{
> > +	struct device_node *np = pdev->dev.of_node;
> > +	struct device *dev = &pdev->dev;
> > +	struct pic64hpsc_mdio_dev *priv;
> > +	struct mii_bus *bus;
> > +	unsigned long rate;
> > +	struct clk *clk;
> > +	u32 bus_freq;
> > +	u32 div;
> > +	int ret;
> > +
> > +	bus = devm_mdiobus_alloc_size(dev, sizeof(*priv));
> > +	if (!bus)
> > +		return -ENOMEM;
> > +
> > +	priv = bus->priv;
> > +
> > +	priv->regs = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(priv->regs))
> > +		return PTR_ERR(priv->regs);
> > +
> > +	bus->name = KBUILD_MODNAME;
> > +	bus->read = pic64hpsc_mdio_read;
> > +	bus->write = pic64hpsc_mdio_write;
> 
> Is there a plan to eventually add C45 ? if so, I'd put 'c22' somewhere
> in the names here.

Yes. Ok, will do.

> 
> The rest seems OK to me, so with the extra macros removed,
> 
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thank you Maxime,
Charles

> 
> Maxime
> 

