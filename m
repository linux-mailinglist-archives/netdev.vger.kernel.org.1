Return-Path: <netdev+bounces-117491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B99494E1D7
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 17:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2B62814F7
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 15:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085BB14A619;
	Sun, 11 Aug 2024 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bLpp2FWy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788851CA85;
	Sun, 11 Aug 2024 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723390419; cv=none; b=agBX70jFEH0zpL4cdet/ap5tAkWY3BwZw/Lnuvmee/7m9oegKzXs6ox1059dB9UG4puQsdNWHxX1I32pVztWS0F9gNr4snzWwCO6CjEcHLo/ZCTNyX5B3h6F2knGxRu29FRKceKekKNeyVsIJbI3LxoSvPPQ0ejkAFxgduzcmpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723390419; c=relaxed/simple;
	bh=qQcCdPWu4bO+9XCE84Ma/+tt5R9lWSSuhnVXfx7O8PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLSUkrDl5Dcekh2yGe1lc426bXmZvFy0jWTupvGpOo27nGcZLGOSRkzt6jfWtwVFeNzuEd9aWWkUT3vbeoRxI8IDihQDY+5cX7ij+Cni2C6OZ2NV7XqlV63bZm/bH3tupMR95vch32sFE4dZEd+32NgSWTkToNjBjiMtk8D6yXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bLpp2FWy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=S68YD01sy23UP/lg2QB8XF58LaEnhYs0kKxJBbDKQkA=; b=bLpp2FWyUdBu9OmNrYMaCnAu91
	p1iXVxLyxEgEbkXLbGE3j8da8SVHofQyOz7xSkb206qXGr11MqwJkAqXcNqkJJ+Ai0RxtjC2cLEac
	iXHmrARqefHFdRKm6XBB6uSGkkkt+vK9HtlMjnO89aV4SxmhQ6zbOH1ewjgGWURAoVBo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdAZW-004VMx-AH; Sun, 11 Aug 2024 17:33:30 +0200
Date: Sun, 11 Aug 2024 17:33:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/3] phy: Add Open Alliance helpers for the
 PHY framework
Message-ID: <ec9f6d52-b035-47f8-8ea5-afb50030406a@lunn.ch>
References: <20240811052005.1013512-1-o.rempel@pengutronix.de>
 <20240811052005.1013512-2-o.rempel@pengutronix.de>
 <ZriCqClUc/Yd0uMK@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZriCqClUc/Yd0uMK@shell.armlinux.org.uk>

On Sun, Aug 11, 2024 at 10:21:44AM +0100, Russell King (Oracle) wrote:
> On Sun, Aug 11, 2024 at 07:20:04AM +0200, Oleksij Rempel wrote:
> > diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> > index 202ed7f450da6..e93dfec881c5d 100644
> > --- a/drivers/net/phy/Makefile
> > +++ b/drivers/net/phy/Makefile
> > @@ -23,6 +23,7 @@ obj-$(CONFIG_MDIO_DEVRES)	+= mdio_devres.o
> >  libphy-$(CONFIG_SWPHY)		+= swphy.o
> >  libphy-$(CONFIG_LED_TRIGGER_PHY)	+= phy_led_triggers.o
> >  
> > +obj-$(CONFIG_OPEN_ALLIANCE_HELPERS) += open_alliance_helpers.o
> 
> I was thinking more
> libphy-$(CONFIG_OPEN_ALLIANCE_HELPERS) += open_alliance_helpers.o
> 
> rather than a potentially separate module.
> 
> If it is going to end up a separate module, then it needs its own
> MODULE_LICENSE, MODULE_DESCRIPTION, etc.

I'm happy either way.

	Andrew

