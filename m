Return-Path: <netdev+bounces-268948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKzCEgJ3ummTWwIAu9opvQ
	(envelope-from <netdev+bounces-268948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:57:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E91392B98A0
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 304513058B9F
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F723B8D42;
	Wed, 18 Mar 2026 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nM+sEIVm"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06433A9D9E;
	Wed, 18 Mar 2026 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773827584; cv=none; b=fCopCAOsO7MWFAYtbkWkQHxf+D5LomaeunBhO3AT4Jw4RkhyuIrGwncU1bd0xO103dB8GPC2DYgB5Ir6mxBRnwJjVEudisNCWem/5xCZb/6SvjAPFkcAqhA1dJMacHnpefNI3uZdgyckaGMwv2LXAESlTiWzTzANmuSrsSSAwwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773827584; c=relaxed/simple;
	bh=2Ux1TemWLvp+sIjI92wc40eoAdpnH+THH49uRMeftWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFuzVmxLKAFy7NqYUhA3yjwx4ExqGNlNlfSCn3DSiHNlc/bdC+FZ7aQTr3+1XdeBQ30lJhBPsDRNE3mieaCpYr6pGj6+YzElrJ4AUvn7EMkaeEeu2YIiQYVFb8QWgSnhrBz+9khjRVoh8Mrb7fUyd5qFDyWlPA5W6EumAdTQdLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nM+sEIVm; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 539DA4E426E5;
	Wed, 18 Mar 2026 09:52:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1DFDF6004F;
	Wed, 18 Mar 2026 09:52:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5646B10450753;
	Wed, 18 Mar 2026 10:52:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773827572; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=o1M9oXawm4eFa6tGNX2lOJuF+q+Hyfy5yyclVec63Vg=;
	b=nM+sEIVm649wRcqk6fF4OFfpwwcKltTHgLFbZJiPgFcxQWt0krzhS2bYy2gmw1CZM9GdeF
	lwrwqkfhoFYa8rCJk9CSqe8tiX2eXedn+4c3O4U5zSuNGw8k7tdGSfEVMoMoN+8KQlJLZu
	IzePprWrdMfiwkCTBpFeUOPX+UojFkybeWz3sK0J69EuivBEoQsVUv/wNHwV4H/VDp00Qy
	kdtM2TWqXShnjwtTlbrnLFMAf7XrxxF9A3X7+viX6Z3H9MbSrVeLOOAFMG/YW2mOzAOPck
	LtdYTty+x5OgYtXZf93vjVvk3P3NBueHfktOzKntCDkvwjy0n4X2wVkpgqg2lw==
Message-ID: <5c9eb2e9-1727-4c01-888d-56ffee6ca54a@bootlin.com>
Date: Wed, 18 Mar 2026 10:52:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: mdio: add a driver for PIC64-HPSC/HX
 MDIO controller
To: Charles Perry <charles.perry@microchip.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260317184610.315852-1-charles.perry@microchip.com>
 <20260317184610.315852-3-charles.perry@microchip.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260317184610.315852-3-charles.perry@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268948-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: E91392B98A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Charles,

On 17/03/2026 19:46, Charles Perry wrote:
> This adds an MDIO driver for PIC64-HPSC/HX. The hardware supports C22
> and C45 but only C22 is implemented in this commit.
> 
> This MDIO hardware is based on a Microsemi design supported in Linux by
> mdio-mscc-miim.c. However, The register interface is completely
> different with pic64hpsc, hence the need for a separate driver.
> 
> The documentation recommends an input clock of 156.25MHz and a prescaler
> of 39, which yields an MDIO clock of 1.95MHz.
> 
> The hardware supports an interrupt pin or a "TRIGGER" bit that can be
> polled to signal transaction completion. This commit uses polling.
> 
> This was tested on Microchip HB1301 evalkit with a VSC8574 and a
> VSC8541.
> 
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
>  drivers/net/mdio/Kconfig          |   7 +
>  drivers/net/mdio/Makefile         |   1 +
>  drivers/net/mdio/mdio-pic64hpsc.c | 207 ++++++++++++++++++++++++++++++
>  3 files changed, 215 insertions(+)
>  create mode 100644 drivers/net/mdio/mdio-pic64hpsc.c
> 
> diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
> index 44380378911b..7bdba8c3ddef 100644
> --- a/drivers/net/mdio/Kconfig
> +++ b/drivers/net/mdio/Kconfig
> @@ -146,6 +146,13 @@ config MDIO_OCTEON
>  	  buses. It is required by the Octeon and ThunderX ethernet device
>  	  drivers on some systems.
>  
> +config MDIO_PIC64HPSC
> +	tristate "PIC64-HPSC/HX MDIO interface support"
> +	depends on HAS_IOMEM && OF_MDIO
> +	help
> +	  This driver supports the MDIO interface found on the PIC64-HPSC/HX
> +	  SoCs.
> +
>  config MDIO_IPQ4019
>  	tristate "Qualcomm IPQ4019 MDIO interface support"
>  	depends on HAS_IOMEM && OF_MDIO
> diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
> index fbec636700e7..048586746026 100644
> --- a/drivers/net/mdio/Makefile
> +++ b/drivers/net/mdio/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_MDIO_MOXART)		+= mdio-moxart.o
>  obj-$(CONFIG_MDIO_MSCC_MIIM)		+= mdio-mscc-miim.o
>  obj-$(CONFIG_MDIO_MVUSB)		+= mdio-mvusb.o
>  obj-$(CONFIG_MDIO_OCTEON)		+= mdio-octeon.o
> +obj-$(CONFIG_MDIO_PIC64HPSC)		+= mdio-pic64hpsc.o
>  obj-$(CONFIG_MDIO_REALTEK_RTL9300)	+= mdio-realtek-rtl9300.o
>  obj-$(CONFIG_MDIO_REGMAP)		+= mdio-regmap.o
>  obj-$(CONFIG_MDIO_SUN4I)		+= mdio-sun4i.o
> diff --git a/drivers/net/mdio/mdio-pic64hpsc.c b/drivers/net/mdio/mdio-pic64hpsc.c
> new file mode 100644
> index 000000000000..1128b3a86804
> --- /dev/null
> +++ b/drivers/net/mdio/mdio-pic64hpsc.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Microchip PIC64-HPSC/HX MDIO controller driver
> + *
> + * Copyright (c) 2026 Microchip Technology Inc. and its subsidiaries.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_mdio.h>
> +#include <linux/platform_device.h>
> +
> +#define MDIO_REG_PRESCALER     0x20
> +#define MDIO_CFG_PRESCALE_MASK GENMASK(7, 0)
> +
> +#define MDIO_REG_FRAME_CFG_1 0x24
> +#define MDIO_WDATA_MASK	     GENMASK(15, 0)
> +
> +#define MDIO_REG_FRAME_CFG_2	 0x28
> +#define MDIO_TRIGGER_BIT	 BIT(31)
> +#define MDIO_REG_DEV_ADDR_MASK	 GENMASK(20, 16)
> +#define MDIO_PHY_PRT_ADDR_MASK	 GENMASK(8, 4)
> +#define MDIO_OPERATION_MASK	 GENMASK(3, 2)
> +#define MDIO_START_OF_FRAME_MASK GENMASK(1, 0)
> +
> +/* Possible value of MDIO_OPERATION_MASK */
> +#define MDIO_OPERATION_WRITE BIT(0)
> +#define MDIO_OPERATION_READ  BIT(1)
> +
> +#define MDIO_REG_FRAME_STATUS 0x2C
> +#define MDIO_READOK_BIT	      BIT(24)
> +#define MDIO_RDATA_MASK	      GENMASK(15, 0)
> +
> +#define MDIO_INT_I_ADDR 0x30
> +#define MDIO_INT_I_BIT	BIT(0)
> +
> +#define MDIO_INT_E_ADDR 0x34
> +#define MDIO_INT_E_BIT	BIT(0)

Thes INT_I/E don't seem to be used, you can drop them

> +
> +struct pic64hpsc_mdio_dev {
> +	void __iomem *regs;
> +};
> +
> +static int pic64hpsc_mdio_wait_trigger(struct mii_bus *bus)
> +{
> +	struct pic64hpsc_mdio_dev *priv = bus->priv;
> +	u32 val;
> +	int ret;
> +
> +	/* The MDIO_TRIGGER bit returns 0 when a transaction has completed. */
> +	ret = readl_poll_timeout(priv->regs + MDIO_REG_FRAME_CFG_2, val,
> +				 !(val & MDIO_TRIGGER_BIT), 50, 10000);
> +
> +	if (ret < 0)
> +		dev_dbg(&bus->dev, "TRIGGER bit timeout: %x\n", val);
> +
> +	return ret;
> +}
> +
> +static int pic64hpsc_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
> +{
> +	struct pic64hpsc_mdio_dev *priv = bus->priv;
> +	u32 val;
> +	int ret;
> +
> +	ret = pic64hpsc_mdio_wait_trigger(bus);
> +	if (ret)
> +		return ret;
> +
> +	writel(MDIO_TRIGGER_BIT | FIELD_PREP(MDIO_REG_DEV_ADDR_MASK, regnum) |
> +		       FIELD_PREP(MDIO_PHY_PRT_ADDR_MASK, mii_id) |
> +		       FIELD_PREP(MDIO_OPERATION_MASK, MDIO_OPERATION_READ) |
> +		       FIELD_PREP(MDIO_START_OF_FRAME_MASK, 1),
> +	       priv->regs + MDIO_REG_FRAME_CFG_2);
> +
> +	ret = pic64hpsc_mdio_wait_trigger(bus);
> +	if (ret)
> +		return ret;
> +
> +	val = readl(priv->regs + MDIO_REG_FRAME_STATUS);
> +
> +	/* The MDIO_READOK is a 1-bit value reflecting the inverse of the MDIO
> +	 * bus value captured during the 2nd TA cycle. A PHY/Port should drive
> +	 * the MDIO bus with a logic 0 on the 2nd TA cycle, however, the
> +	 * PHY/Port could optionally drive a logic 1, to communicate a read
> +	 * failure. This feature is optional, not defined by the 802.3 standard
> +	 * and not supported in standard external PHYs.
> +	 */
> +	if (!(bus->phy_ignore_ta_mask & 1 << mii_id) &&
> +	    !FIELD_GET(MDIO_READOK_BIT, val)) {
> +		dev_dbg(&bus->dev, "READOK bit cleared\n");
> +		return -EIO;
> +	}
> +
> +	ret = FIELD_GET(MDIO_RDATA_MASK, val);
> +
> +	return ret;
> +}
> +
> +static int pic64hpsc_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
> +				u16 value)
> +{
> +	struct pic64hpsc_mdio_dev *priv = bus->priv;
> +	int ret;
> +
> +	ret = pic64hpsc_mdio_wait_trigger(bus);
> +	if (ret < 0)
> +		return ret;
> +
> +	writel(FIELD_PREP(MDIO_WDATA_MASK, value),
> +	       priv->regs + MDIO_REG_FRAME_CFG_1);
> +
> +	writel(MDIO_TRIGGER_BIT | FIELD_PREP(MDIO_REG_DEV_ADDR_MASK, regnum) |
> +		       FIELD_PREP(MDIO_PHY_PRT_ADDR_MASK, mii_id) |
> +		       FIELD_PREP(MDIO_OPERATION_MASK, MDIO_OPERATION_WRITE) |
> +		       FIELD_PREP(MDIO_START_OF_FRAME_MASK, 1),
> +	       priv->regs + MDIO_REG_FRAME_CFG_2);
> +
> +	return 0;
> +}
> +
> +static int pic64hpsc_mdio_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	struct pic64hpsc_mdio_dev *priv;
> +	struct mii_bus *bus;
> +	unsigned long rate;
> +	struct clk *clk;
> +	u32 bus_freq;
> +	u32 div;
> +	int ret;
> +
> +	bus = devm_mdiobus_alloc_size(dev, sizeof(*priv));
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	priv = bus->priv;
> +
> +	priv->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->regs))
> +		return PTR_ERR(priv->regs);
> +
> +	bus->name = KBUILD_MODNAME;
> +	bus->read = pic64hpsc_mdio_read;
> +	bus->write = pic64hpsc_mdio_write;

Is there a plan to eventually add C45 ? if so, I'd put 'c22' somewhere
in the names here.

The rest seems OK to me, so with the extra macros removed,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


