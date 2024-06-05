Return-Path: <netdev+bounces-101140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 452B68FD753
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 22:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F8F1C2099F
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4D0158862;
	Wed,  5 Jun 2024 20:14:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F8614D449
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717618465; cv=none; b=H5QAJoNuBSTiNBVW1MSKVSuuU/2f2CK0Yyl8rTYBS6kH/5ZUaX1fSxSqAmv7LFjzT8g/k6ZJGtyAxzCjKbNCwYozW9AcVCtucZP8OHPzj+bczordJ7WMI/L/GteGXqSEQGOFkNkp3inAEmYakK0Oh9KmBWGyTAjNJ9z2Y+YqnDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717618465; c=relaxed/simple;
	bh=5ikd2Wl8Mt4PURlz0CKwt6V4jaq9p2pUPjHsY9KDFlw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGHrh0WR7a8X1lBANwpiLIzJDz05sPYRKJ7RqGe0AGLlxJOWSumahxsdKxGmVLfyLrN/2cBGXtRSbIAZzywXfEWtqgsszOsbbfpiLrEbH6mh9x7oaURqM9Dsaa0JBpFcUmAsOLyo48u1BwFz8NHCYXzYEHT4BJHILyHCaXudyRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 31968b91-2378-11ef-80de-005056bdfda7;
	Wed, 05 Jun 2024 23:14:20 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 5 Jun 2024 23:14:20 +0300
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Sai Krishna Gajula <saikrishnag@marvell.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 11/19] irqchip: Add support for LAN966x OIC
Message-ID: <ZmDHHFF-qD2UBkMT@surfacebook.localdomain>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
 <20240527161450.326615-12-herve.codina@bootlin.com>
 <87frtr4goe.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frtr4goe.ffs@tglx>

Wed, Jun 05, 2024 at 04:17:53PM +0200, Thomas Gleixner kirjoitti:
> On Mon, May 27 2024 at 18:14, Herve Codina wrote:

...

> > +	irq_reg_writel(gc, ~0, gc->chip_types[0].regs.disable);
> 
> ~0U
>   
> > +	irq_reg_writel(gc, ~0, gc->chip_types[0].regs.ack);

...

Below just to annoy people a bit :)

(Yes, I understand that this is a prototype, it's just a pre-review in case one
want to blindly copy'n'paste it).

Other than that, I like the result!

> I just did a quick conversion to the template approach. Unsurprisingly
> it removes 30 lines of boiler plate code:
> 
> +static void lan966x_oic_chip_init(struct irq_chip_generic *gc)
> +{
> +	struct lan966x_oic_data *lan966x_oic = gc->domain->host_data;
> +	struct lan966x_oic_chip_regs *chip_regs;
> +
> +	gc->reg_base = lan966x_oic->regs;
> +
> +	chip_regs = lan966x_oic_chip_regs + gc->irq_base / 32;
> +	gc->chip_types[0].regs.enable = chip_regs->reg_off_ena_set;
> +	gc->chip_types[0].regs.disable = chip_regs->reg_off_ena_clr;
> +	gc->chip_types[0].regs.ack = chip_regs->reg_off_sticky;
> +
> +	gc->chip_types[0].chip.irq_startup = lan966x_oic_irq_startup;
> +	gc->chip_types[0].chip.irq_shutdown = lan966x_oic_irq_shutdown;
> +	gc->chip_types[0].chip.irq_set_type = lan966x_oic_irq_set_type;
> +	gc->chip_types[0].chip.irq_mask = irq_gc_mask_disable_reg;
> +	gc->chip_types[0].chip.irq_unmask = irq_gc_unmask_enable_reg;
> +	gc->chip_types[0].chip.irq_ack = irq_gc_ack_set_bit;
> +	gc->private = chip_regs;
> +
> +	/* Disable all interrupts handled by this chip */
> +	irq_reg_writel(gc, ~0, chip_regs->reg_off_ena_clr);
> +}
> +
> +static void lan966x_oic_chip_exit(struct irq_chip_generic *gc)
> +{
> +	/* Disable and ack all interrupts handled by this chip */
> +	irq_reg_writel(gc, ~0, gc->chip_types[0].regs.disable);
> +	irq_reg_writel(gc, ~0, gc->chip_types[0].regs.ack);

~0U :-)

But I, for example, think that GENMASK() even better as it shows exactly what
bits we set for the HW writes.

> +}
> +
> +static void lan966x_oic_domain_init(struct irq_domain *d)
> +{
> +	struct lan966x_oic_data *lan966x_oic = d->host_data;
> +
> +	irq_set_chained_handler_and_data(lan966x_oic->irq, lan966x_oic_irq_handler, d);
> +}
> +
> +static int lan966x_oic_probe(struct platform_device *pdev)
> +{
> +	struct irq_domain_chip_generic_info gc_info = {
> +		.irqs_per_chip		= 32,
> +		.num_chips		= 1,
> +		.name			= "lan966x-oic"
> +		.handler		= handle_level_irq,
> +		.init			= lan966x_oic_chip_init,
> +		.destroy		= lan966x_oic_chip_exit,
> +	};
> +
> +	struct irq_domain_info info = {

> +		.fwnode			= of_node_to_fwnode(pdev->dev.of_node),

It's as simple as dev_fwnode()

> +		.size			= LAN966X_OIC_NR_IRQ,
> +		.hwirq_max		= LAN966X_OIC_NR_IRQ,
> +		.ops			= &irq_generic_chip_ops,
> +		.gc_info		= &gc_info,
> +		.init			= lan966x_oic_domain_init,
> +	};
> +	struct lan966x_oic_data *lan966x_oic;
> +	struct device *dev = &pdev->dev;
> +
> +	lan966x_oic = devm_kmalloc(dev, sizeof(*lan966x_oic), GFP_KERNEL);
> +	if (!lan966x_oic)
> +		return -ENOMEM;
> +
> +	lan966x_oic->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(lan966x_oic->regs))
> +		return dev_err_probe(dev, PTR_ERR(lan966x_oic->regs), "failed to map resource\n");
> +
> +	lan966x_oic->irq = platform_get_irq(pdev, 0);
> +	if (lan966x_oic->irq < 0)
> +		return dev_err_probe(dev, lan966x_oic->irq, "failed to get the IRQ\n");
> +
> +	lan966x_oic->domain = irq_domain_instantiate(&info);
> +	if (!lan966x_oic->domain)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, lan966x_oic);
> +	return 0;
> +}
> +
> +static void lan966x_oic_remove(struct platform_device *pdev)
> +{
> +	struct lan966x_oic_data *lan966x_oic = platform_get_drvdata(pdev);
> +
> +	irq_set_chained_handler_and_data(lan966x_oic->irq, NULL, NULL);
> +	irq_domain_remove(lan966x_oic->domain);
> +}

-- 
With Best Regards,
Andy Shevchenko



