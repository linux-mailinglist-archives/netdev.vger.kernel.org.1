Return-Path: <netdev+bounces-127841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE78A976D9A
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60AD21F26627
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 15:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1316B1B1507;
	Thu, 12 Sep 2024 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IIHhLAYh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6DD126BE2;
	Thu, 12 Sep 2024 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726154393; cv=none; b=CGwb3zCaNEtI7x75QSIYbLzJnxYCzeYVaDMa8q3Br5CzrVLXrr6ycX05IB5b97QYhNWGqzRvocnfPTQa4x+W4wAUu1F0zOuldwkpyj/HnYnQwLqmv7TyKYzczvPjY8CaSzptNmroO+zmjkkKdGfI4aLOzxIql94AfVT4eat6WPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726154393; c=relaxed/simple;
	bh=/OXhOlV9Y45rThy6liriw9VPETV5rNH9lt4zzjrFg5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRaSLiX2yF3F9kn8Iq3BSFDsFlU8zn+KAXmDH07p9SUyCLZglvbNCQ0XRjO+yD+11Ka+nhVqiHTwL+Ra9mloBF8YmqOw6HcEvFulU1dVRxIjzieDXxz0u1bdDzHvCx3oWMq4IF8E45h5hSCFudJnTA1xJFGjltg77pWJgKEqTu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IIHhLAYh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6faEgCEj/9OUXs3v+131xY7iaDYBTFMaSLrdrzCB6GE=; b=IIHhLAYh3H2EUb5pYmaSbUCWrM
	vIQ0zYl1dP8lCQmbMFJ7fqRIT4qs4k7B466OXjiz+M5J5ua7m0S6w7Xx21xz9UeYU4cQUWf0UOYqa
	WDFLahKhUZ81K9nuKNC1odxhb+TdbZq/saNzg+p+bldCGMxdTA9+KLz+G/ce2RKZqkmg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1solbd-007Jmx-Cl; Thu, 12 Sep 2024 17:19:37 +0200
Date: Thu, 12 Sep 2024 17:19:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com, rdunlap@infradead.org,
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 2/5] net: lan743x: Add support to
 software-nodes for sfp
Message-ID: <016f93bc-3177-412c-9441-d1a6cd2b466e@lunn.ch>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-3-Raju.Lakkaraju@microchip.com>
 <cb39041e-9b72-4b76-bfd7-03f825b20f23@lunn.ch>
 <ZuKMcMexEAqTLnSc@HYD-DK-UNGSW21.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuKMcMexEAqTLnSc@HYD-DK-UNGSW21.microchip.com>

On Thu, Sep 12, 2024 at 12:08:40PM +0530, Raju Lakkaraju wrote:
> Hi Andrew,
> 
> The 09/11/2024 19:17, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > > diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
> > > index 2e3eb37a45cd..9c08a4af257a 100644
> > > --- a/drivers/net/ethernet/microchip/Kconfig
> > > +++ b/drivers/net/ethernet/microchip/Kconfig
> > > @@ -50,6 +50,8 @@ config LAN743X
> > >       select CRC16
> > >       select CRC32
> > >       select PHYLINK
> > > +     select I2C_PCI1XXXX
> > > +     select GP_PCI1XXXX
> > 
> > GP_ is odd. GPIO drivers usually use GPIO_. Saying that, GPIO_PCI1XXXX
> > is not in 6.11-rc7. Is it in gpio-next?
> > 
> 
> Yes. But GPIO driver developer use this.

And the GPIO Maintainer accepted this, despite it not being the same
as every other GPIO driver?

Ah, there is no Acked-by: from anybody i recognise as a GPIO
maintainer. Was it even reviewed by GPIO people? And why is it hiding
in driver/misc? I don't see any reason it cannot be in drivers/gpio,
which is where i looked for it. There are other auxiliary_driver in
drivers/gpio.

> I have to use the same here.

Unfortunately, i have to agree, for the moment.

But it would be good to clean it up. I _think_ mchp_pci1xxxx_gpio.c
can be moved into driver/gpio, given the expected Kconfig symbol
GPIO_PCI1XXXX and depends on GP_PCI1XXXX. It would then also get
reviewed by the GPIO Maintainers, which you probably want.

	Andrew

