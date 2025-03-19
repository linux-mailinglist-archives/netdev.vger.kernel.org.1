Return-Path: <netdev+bounces-176276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB061A6996F
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 20:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E451894E30
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 19:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8710214A82;
	Wed, 19 Mar 2025 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Jf4gLVoQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AE22144BB;
	Wed, 19 Mar 2025 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412686; cv=none; b=cjwOK+r6OdzMYh9D0p/Ggmn+BkCnqmEcSVSZhBFXiQ0lMM70mnA7xLYPnZ1imeRJ+jZoBbKnhUWH/l9VnyNAlM4strUCBzBLkDRFwy5kvVFK+BhTNlCuERRBjTJ14ehXxlVoPhC8uNsVSQWQ+msoBCb2pfTwCadjsvUQ+DLPn3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412686; c=relaxed/simple;
	bh=U9Z9nqMs1mNcvZFHIrTtDglCMqXwEuCOH+K/k1hK9Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fudGGmf55SL4It7Uu86sx7IX99efv0QGr6mDkxogQ0Q/erAGUsRNy/VLI4wtt9KgjX+bFYaesCh4EvyrugjaMosURTGE1wFpuFhv0zRR51W6ra4KSLWZmG3XZxM3Lnp9/R7vc4CgBgyrALM2ZCLzcCQb5e8k2hYleFxuy8JI+b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Jf4gLVoQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gviRwqOkbCCWp6GvORH9MMNKYz38Gpuudg4E4hN2jFE=; b=Jf4gLVoQoEZ/tl1KZVOeMcd9jN
	TeI0Tsq6QbU1zFfJeYxDH1hjjF0oDHKBc6fDJtPNZSwtztE/qIz659ZB2h6H7ZDrmV9hhkXY0zlhT
	OyzfXhYt3jhh8sHoUL+XDOROzzEkzAXs2FByxyUdoDZLGNLf7is/HTUYXzqi+Zr6M7nMEIyrATh3F
	3QByBl/qcEa8iTyAsDOdTCZSPAJCBkIUyOyf4y8ONsZl3JAXYQpPO3JN3OedE1QsEd7jCvZB7V9Rs
	FVfd8Ct8lcKMFwT5Rtc/323JMy+Lv8ahPurqEEWoQuviRJvpG0bkoML7gsNkhsDL5NPHFpYURKsx1
	nxg0575w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58974)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tuz89-0006qu-15;
	Wed, 19 Mar 2025 19:31:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tuz84-0005rx-0t;
	Wed, 19 Mar 2025 19:31:04 +0000
Date: Wed, 19 Mar 2025 19:31:04 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH 3/6] net: phylink: Correctly handle PCS probe
 defer from PCS provider
Message-ID: <Z9sbeNTNy0dYhCgu@shell.armlinux.org.uk>
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
 <20250318235850.6411-4-ansuelsmth@gmail.com>
 <Z9rplhTelXb-oZdC@shell.armlinux.org.uk>
 <67daee6c.050a0220.31556f.dd73@mx.google.com>
 <Z9r4unqsYJkLl4fn@shell.armlinux.org.uk>
 <67db005c.df0a0220.f7398.ba6b@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67db005c.df0a0220.f7398.ba6b@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 19, 2025 at 06:35:21PM +0100, Christian Marangi wrote:
> On Wed, Mar 19, 2025 at 05:02:50PM +0000, Russell King (Oracle) wrote:
> > My thoughts are that if a PCS goes away after a MAC driver has "got"
> > it, then:
> > 
> > 1. we need to recognise that those PHY interfaces and/or link modes
> >    are no longer available.
> > 2. if the PCS was in-use, then the link needs to be taken down at
> >    minimum and the .pcs_disable() method needs to be called to
> >    release any resources that .pcs_enable() enabled (e.g. irq masks,
> >    power enables, etc.)
> > 3. the MAC driver needs to be notified that the PCS pointer it
> >    stashed is no longer valid, so it doesn't return it for
> >    mac_select_pcs().
> 
> But why we need all these indirect handling and checks if we can
> make use of .remove and shutdown the interface. A removal of a PCS
> should cause the entire link to go down, isn't a dev_close enough to
> propagate this? If and when the interface will came up checks are done
> again and it will fail to go UP if PCS can't be found.
> 
> I know it's a drastic approach to call dev_close but link is down anyway
> so lets reinit everything from scratch. It should handle point 2 and 3
> right?

Let's look at what dev_close() does. This is how it's documented:

 * dev_close() - shutdown an interface
 * @dev: device to shutdown
 *
 * This function moves an active device into down state. A
 * %NETDEV_GOING_DOWN is sent to the netdev notifier chain. The device
 * is then deactivated and finally a %NETDEV_DOWN is sent to the notifier
 * chain.

So, this is equivalent to userspace doing:

# ip li set dev ethX down

and nothing prevents userspace doing:

# ip li set dev ethX up

after that call to dev_close() has returned.

If this happens, then the netdev driver's .ndo_open will be called,
which will then call phylink_start(), and that will attempt to bring
the link back up. That will call .mac_select_pcs(), which _if_ the
PCS is still "published" means it is _still_ accessible.

So your call that results in dev_close() with the PCS still being
published is ineffectual.

It's *no* different from this crap in the stmmac driver:

        stmmac_stop_all_dma(priv);
        stmmac_mac_set(priv, priv->ioaddr, false);
        unregister_netdev(ndev);

because *until* that unregister_netdev() call has completed, _userspace_
still has control over the netdev, and can do whatever it damn well
pleases.

Look, this is very very very simple.

If something is published to another part of the code, it is
discoverable, and it can be used or manipulated by new users.

If we wish to take something away, then first, it must be
unpublished to prevent new users discovering the resource. Then
existing users need to be dealt with in a safe way. Only at that
point can we be certain that there are no users, and thus the
underlying device begin to be torn down.

It's entirely logical!

> For point 1, additional entry like available_interface? And gets updated
> once a PCS gets removed??? Or if we don't like the parsing hell we map
> every interface to a PCS pointer? (not worth the wasted space IMHO)

At the moment, MAC drivers that I've updated will do things like:

                phy_interface_or(priv->phylink_config.supported_interfaces,
                                 priv->phylink_config.supported_interfaces,
                                 pcs->supported_interfaces);

phylink_config.supported_interfaces is the set of interface modes that
the MAC _and_ PCS subsystem supports. It's not just the MAC, it's both
together.

So, if a PCS is going away, then clearing the interface modes that the
PCS was providing would make sense - but there's a problem here. What
if the PCS is a bought-in bit of IP where the driver supports many modes
but the MAC doesn't use it for all those modes. So... which interface
modes get cleared is up to the MAC driver to decide.

> > There's probably a bunch more that needs to happen, and maybe need
> > to consider how to deal with "pcs came back".. but I haven't thought
> > that through yet.
> 
> Current approach supports PCS came back as we check the global provider
> list and the PCS is reachable again there.
> (we tasted various scenario with unbind/bind while the interface was
> up/down)

... because you look up the PCS in the mac_select_pcs() callback which
leads to a different race to what we have today, this time inside the
phylink code which thankfully phylink prints an error which is *NEVER*
supposed to happen.

Just trading one problem for another problem.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

