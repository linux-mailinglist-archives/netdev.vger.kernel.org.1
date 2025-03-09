Return-Path: <netdev+bounces-173318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F82A5856D
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 16:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202D93A0FC8
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 15:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DF41DE4CA;
	Sun,  9 Mar 2025 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KaWJLlHj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D242F2A;
	Sun,  9 Mar 2025 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741534937; cv=none; b=IpgVpnk4cXXnr67UJ6VENRpFjTpRwfBWNe9XTiRR9XVsCklhLYujocZJyA+9GZBv2oI59TkrPxLKfxMt5ea5V5t4xVvY6wVxxbWEsVdeZURUjX3Kfz8oNnzz245+Je4MwAQtYJbObLaaAlWonr+g4OabUSowiyBi26Wfs0wtXCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741534937; c=relaxed/simple;
	bh=jbTJeeexZjCf9NgxRdnyO5JuA1DQv/k912qe8bU/ZYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnrddnC6L+L9bg264nHWtMEB8dsUtG5V/yO4df7BDnQdmT9BRC0YKJ+VWHOiq5XG3ZCwdAGDSqd1hNb0iz1dwppz2W2x24gD+RAM+FgmaNTmVC2Ypz5inV8Hja7rr1mJfiMuFUBHo9fLVa4UN/UjCx5ZMOKqovCXnitUQpnkAH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KaWJLlHj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kzT4fEimiizy2hN2XSadxcNOjH99UUHO6I4bFOwXNVw=; b=KaWJLlHjL3khdssdsXGtpjx+z+
	Cz/ocJ/yxhj6RZmMD+HhTnLIiwuI+yfn4+459s+m7wmNtS1cu3+SRKd21eDG5nvYvvZQXNJkDxpRo
	v7E0cwd8onAiZ740Aq2nJkg+RFfrnpWnEIlTIEEiGEhgit0xp1Vq1zETIgioP8CU9KLY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1trImn-003kGI-UZ; Sun, 09 Mar 2025 16:41:53 +0100
Date: Sun, 9 Mar 2025 16:41:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Hanyuan Zhao <hanyuan-z@qq.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: enc28j60: support getting irq number from gpio
 phandle in the device tree
Message-ID: <2b09bea7-2a61-4697-a9c1-6a42cf8570c4@lunn.ch>
References: <tencent_0A154BBE38E000228C01BE742CB73681FE09@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0A154BBE38E000228C01BE742CB73681FE09@qq.com>

On Sun, Mar 09, 2025 at 03:47:08PM +0800, Hanyuan Zhao wrote:
> This patch allows the kernel to automatically requests the pin, configures
> it as an input, and converts it to an IRQ number, according to a GPIO
> phandle specified in device tree. This simplifies the process by
> eliminating the need to manually define pinctrl and interrupt nodes.
> Additionally, it is necessary for platforms that do not support pin
> configuration and properties via the device tree.
> 
> Signed-off-by: Hanyuan Zhao <hanyuan-z@qq.com>
> ---
>  drivers/net/ethernet/microchip/enc28j60.c | 25 ++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/enc28j60.c b/drivers/net/ethernet/microchip/enc28j60.c
> index d6c9491537e4..b3613e45c900 100644
> --- a/drivers/net/ethernet/microchip/enc28j60.c
> +++ b/drivers/net/ethernet/microchip/enc28j60.c
> @@ -24,6 +24,7 @@
>  #include <linux/skbuff.h>
>  #include <linux/delay.h>
>  #include <linux/spi/spi.h>
> +#include <linux/of_gpio.h>
>  
>  #include "enc28j60_hw.h"
>  
> @@ -1526,6 +1527,7 @@ static int enc28j60_probe(struct spi_device *spi)
>  	struct net_device *dev;
>  	struct enc28j60_net *priv;
>  	int ret = 0;
> +	unsigned long irq_flags = IRQF_ONESHOT;
>  
>  	if (netif_msg_drv(&debug))
>  		dev_info(&spi->dev, "Ethernet driver %s loaded\n", DRV_VERSION);
> @@ -1558,20 +1560,33 @@ static int enc28j60_probe(struct spi_device *spi)
>  		eth_hw_addr_random(dev);
>  	enc28j60_set_hw_macaddr(dev);
>  
> +	if (spi->irq > 0) {
> +		dev->irq = spi->irq;
> +	} else {
> +		/* Try loading device tree property irq-gpios */
> +		struct gpio_desc *irq_gpio_desc = devm_fwnode_gpiod_get_index(&spi->dev,
> +				of_fwnode_handle(spi->dev.of_node), "irq", 0, GPIOD_IN, NULL);
> +		if (IS_ERR(irq_gpio_desc)) {
> +			dev_err(&spi->dev, "unable to get a valid irq gpio\n");
> +			goto error_irq;
> +		}
> +		dev->irq = gpiod_to_irq(irq_gpio_desc);

My understanding is that you should not need most of this. The IRQ
core will handle converting a GPIO to an interrupt, if you just list
is as an interrupt source in the normal way.

> +		irq_flags |= IRQF_TRIGGER_FALLING;

You say:

> Additionally, it is necessary for platforms that do not support pin
> configuration and properties via the device tree.

Are you talking about ACPI?

	Andrew

