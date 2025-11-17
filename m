Return-Path: <netdev+bounces-239131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E61CC647BD
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DA8E4E78E1
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC35333426;
	Mon, 17 Nov 2025 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UbNgo0ta"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489843321A5;
	Mon, 17 Nov 2025 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763387343; cv=none; b=iZNAVw3Wy+Opov/tnKDTeuXW46xABbQqpnVWWPWkFYri6Lzl3NVDAusqTwzXKKPyOWu+1zrwp0kTq8GRJmpKErw/e7BqedktfJxmPgdqPyFB0fuStCwnw04yVCaZyZjNWkMToUwZx+BFbS4HENCBiAAg8JunphT+p1n9GmJiLpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763387343; c=relaxed/simple;
	bh=t6+3GOM1YMPt8OZwJMU/2addfT/xFPCJ/6vStK4x5Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbBx/0V/4uxBJ/a5Wj3EZPPggFN5JGGpU8sczjPtzVuBecTTAFH8RVlfnd3kEcH+U4M/XsJguWVJmeFb5kELHZnl1YXchJ1hmUhAD+6+/yHvq/Hz9L3vU6joS+U5ghBeMpL0wKQ54qw1b7SlAbJOsngGCV82R5n8jE2qXMQAzv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UbNgo0ta; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KCrygGFUf67MEoF7VtSA8dFibWtqKiTuqzUznJbVVXk=; b=UbNgo0taKfIBpaoyPIl4RK+iAe
	7psmuu1Qxv36/oKUtdeXXjvXcsTdqj0YZ2id/rw9OYTAove5GR6yc2Jw3m69ND3YMQvq2+IuYU2lk
	d7Y9nBfuBCBGcdmnF1UCcq71cbO8dp+kp9IzN6RP+h6dtjlVhjDQkGkCOt1mG/1PrLU8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vKzb6-00EFJ6-Tm; Mon, 17 Nov 2025 14:48:48 +0100
Date: Mon, 17 Nov 2025 14:48:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: mdio: move device reset functions
 to mdio_device.c
Message-ID: <5ab955f0-f005-4fe9-b3ed-b2d99f7bae03@lunn.ch>
References: <cover.1763371003.git.buday.csaba@prolan.hu>
 <d81e9c2f26c4af4f18403d0b2c6139f12c98f7b3.1763371003.git.buday.csaba@prolan.hu>
 <aRrsOfJv6kUPCxNd@shell.armlinux.org.uk>
 <aRsTiBZBqc-cx38W@debianbuilder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRsTiBZBqc-cx38W@debianbuilder>

On Mon, Nov 17, 2025 at 01:22:32PM +0100, Buday Csaba wrote:
> On Mon, Nov 17, 2025 at 09:34:49AM +0000, Russell King (Oracle) wrote:
> > On Mon, Nov 17, 2025 at 10:28:51AM +0100, Buday Csaba wrote:
> > > diff --git a/include/linux/mdio.h b/include/linux/mdio.h
> > > index 42d6d47e4..1322d2623 100644
> > > --- a/include/linux/mdio.h
> > > +++ b/include/linux/mdio.h
> > > @@ -92,6 +92,8 @@ void mdio_device_free(struct mdio_device *mdiodev);
> > >  struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr);
> > >  int mdio_device_register(struct mdio_device *mdiodev);
> > >  void mdio_device_remove(struct mdio_device *mdiodev);
> > > +int mdio_device_register_gpiod(struct mdio_device *mdiodev);
> > > +int mdio_device_register_reset(struct mdio_device *mdiodev);
> > 
> > These are private functions to the mdio code living in drivers/net/phy,
> > so I wonder whether we want to have drivers/net/phy/mdio.h for these to
> > discourage other code calling these?
> 
> I completely agree with that, but that file does not exist yet.
> Is it worth creating just for the sake of these two functions?

The effort of creating such a file is much smaller than cleaning up
the mess when somebody uses them inappropriately.

Maybe drivers/net/phy/mdio.h is too open,
drivers/net/phy/mdio-private.h would be better, since these are
supposed to only be used by the core, not PHY drivers.

	Andrew

