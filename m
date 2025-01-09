Return-Path: <netdev+bounces-156838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FF3A07F95
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22E73A175A
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7392619309C;
	Thu,  9 Jan 2025 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="b0TOEao3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ED918C337;
	Thu,  9 Jan 2025 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736446230; cv=none; b=tvV7tr1BkiDP8fYB9JVzgyj8cOVcpXlovspVCQmkbTPqr4pZ1JT5iOt+kDJzKIO+1eeVyVHDPf7BJYWHPKkGAbLwFbCd909gF+IIHhshwNaohyhWa2ym5G1LP5kDlh+QOkJyP4aXMP3VOB4HqxXp3ZE3DeC/53unKHzpRgvLFw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736446230; c=relaxed/simple;
	bh=iI9tt6JBYCgWvTB+IcgKQ3igxL0q6621z0vlZwGQH7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdyKls5LRle5rDNSMHOGSiOPGQosz7wcxz4+oY/QllYPLMmRX1nv2zQ/EbK8Xab9e/EiNHmEdrDmB2ovRu7QcddUc+pR0p0hJp/9Yy/hF4wYiXagm7BMlyA+VYWYfhsOaF9W7h9iYICjDdKAzCr3H8AuJ+YyP70TieqnEdYMXJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=b0TOEao3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YpQkiHQ2sjEnpvd4lOD/PiqTnBVWFIrlRwfSfuXjXMk=; b=b0TOEao31FFbX5jGyDao+1q5fU
	3qqvpKJ4xPGtHbHoHdpbNSAi/oYdlxylcv/5lrVzHhhs1KgSJaw5Tzza0/hr93IbVEr4MvoJaV088
	/sCW6PfbX/etQlyfdto6Wrq29FVk/OSQ7CotuFv8Dsl6+a7jt7+11Pl1ebffaCZMCcpOclwFxydFY
	K8y+Of1ldU2J9tlAAkwMsn0V1RHcsTetkLV8gz+xur06FwD5a3P+Kkn5GgHToyO/+qncYkmVbKyjB
	oAmuk1huNRnz3nxGFKjv/Yj7aXzb53oh+z+6pnbuEXBo1bud5b0+v7/NQknXWHypGSDLAGo6DHL+J
	CqLODJYw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36670)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tVwz3-0002Ts-2E;
	Thu, 09 Jan 2025 18:10:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tVwz1-0007WK-20;
	Thu, 09 Jan 2025 18:10:15 +0000
Date: Thu, 9 Jan 2025 18:10:15 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 7/7] net: usb: lan78xx: Enable EEE support
 with phylink integration
Message-ID: <Z4ARB96M6KDuPvv8@shell.armlinux.org.uk>
References: <20250108121341.2689130-1-o.rempel@pengutronix.de>
 <20250108121341.2689130-8-o.rempel@pengutronix.de>
 <Z35z6ZHspfSZK4U7@shell.armlinux.org.uk>
 <Z36KacKBd2WaOxfW@pengutronix.de>
 <Z36WqNGpWWkHTjUE@shell.armlinux.org.uk>
 <Z4ADpj0DlqBRUEK-@pengutronix.de>
 <Z4AG7zvIvQDv3GTn@shell.armlinux.org.uk>
 <Z4AJ4bxLePBbbR2u@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4AJ4bxLePBbbR2u@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 09, 2025 at 06:39:45PM +0100, Oleksij Rempel wrote:
> On Thu, Jan 09, 2025 at 05:27:11PM +0000, Russell King (Oracle) wrote:
> > On Thu, Jan 09, 2025 at 06:13:10PM +0100, Oleksij Rempel wrote:
> > > On Wed, Jan 08, 2025 at 03:15:52PM +0000, Russell King (Oracle) wrote:
> > > > On Wed, Jan 08, 2025 at 03:23:37PM +0100, Oleksij Rempel wrote:
> > > > > Yes, otherwise every MAC driver will need to do it in the
> > > > > ethtool_set_eee() function.
> > > > 
> > > > I've had several solutions, and my latest patch set actually has a
> > > > mixture of them in there (which is why I'm eager to try and find a way
> > > > forward on this, so I can fix the patch set):
> > > > 
> > > > 1. the original idea to address this in Marvell platforms was to limit
> > > >    the LPI timer to the maximum representable value in the hardware,
> > > >    which would be 255us. This ignores that the hardware uses a 1us
> > > >    tick rate for the timer at 1G speeds, and 10us for 100M speeds.
> > > >    (So it limits it to 260us, even though the hardware can do 2550us
> > > >    at 100M speed). This limit was applied by clamping the value passed
> > > >    in from userspace without erroring out.
> > > > 
> > > > 2. another solution was added the mac_validate_tx_lpi() method, and
> > > >    implementations added _in addition_ to the above, with the idea
> > > >    of erroring out for values > 255us on Marvell hardware.
> > > > 
> > > > 3. another idea was to have mac_enable_tx_lpi() error out if it wasn't
> > > >    possible to allow e.g. falling back to a software timer (see stmmac
> > > >    comments below.) Another reason for erroring out applies to Marvell
> > > >    hardware, where PP2 hardware supports LPI on the GMAC but not the
> > > >    XGMAC - so it only works at speeds at or below 2.5G. However, that
> > > >    can be handled via the lpi_capabilities, so I don't think needs to
> > > >    be a concern.
> > > > 
> > > > > The other question is, should we allow absolute maximum values, or sane
> > > > > maximum? At some point will come the question, why the EEE is even
> > > > > enabled?
> > > > 
> > > > As referenced above, stmmac uses the hardware timer for LPI timeouts up
> > > > to and including 1048575us (STMMAC_ET_MAX). Beyond that, it uses a
> > > > normal kernel timer which is:
> > > > 
> > > > - disabled (and EEE mode reset) when we have a packet to transmit, or
> > > >   EEE is disabled
> > > > - is re-armed when cleaning up from packet transmission (although
> > > >   it looks like we attempt to immediately enter LPI mode, and would
> > > >   only wait for the timer if there are more packets to queue... maybe
> > > >   this is a bug in stmmac's implementation?) or when EEE mode is first
> > > >   enabled with a LPI timer longer than the above value.
> > > > 
> > > > So, should phylink have the capability to switch to a software LPI timer
> > > > implementation when the LPI timeout value exceeds what the hardware
> > > > supports?
> > > 
> > > No, i'll list my arguments later down.
> > > 
> > > > To put it another way, should the stmmac solution to this be
> > > > made generic?
> > > 
> > > May be partially?
> > > 
> > > > Note that stmmac has this software timer implementation because not
> > > > only for the reason I've given above, but also because cores other than
> > > > GMAC4 that support LPI do not have support for the hardware timer.
> > > 
> > > There seems to be a samsung ethernet driver which implements software
> > > based timer too.
> > > 
> > > > > The same is about minimal value, too low value will cause strong speed
> > > > > degradation. Should we allow set insane minimum, but use sane default
> > > > > value?
> > > > 
> > > > We currently allow zero, and the behaviour of that depends on the
> > > > hardware. For example, in the last couple of days, it's been reported
> > > > that stmmac will never enter LPI with a value of zero.
> > > > 
> > > > Note that phylib defaults to zero, so imposing a minimum would cause
> > > > a read-modify-write of the EEE settings without setting the timer to
> > > > fail.
> > > >
> > > > > > Should set_eee() error out?
> > > > > 
> > > > > Yes, please.
> > > > 
> > > > If we are to convert stmmac, then we need to consider what it's doing
> > > > (as per the above) and whether that should be generic - and if it isn't
> > > > what we want in generic code, then how do we allow drivers to do this if
> > > > they wish.
> > > 
> > >    - EEE Advertisement:  
> > > 
> > >      Advertising EEE capabilities is entirely dependent on the PHY. Without a
> > > PHY, these settings cannot be determined or validated, as the PHY defines the
> > > supported capabilities. Any attempt to configure EEE advertisement without an
> > > attached PHY should fail immediately with an appropriate error, such as:  "EEE
> > > advertisement configuration not applied: no PHY available to validate
> > > capabilities."
> > 
> > Sorry, at this point, I give up with phylink managed EEE. What you
> > detail above is way too much for me to get involved with, and goes
> > well beyond simply:
> > 
> > 1) Fixing the cockup with the phylib-managed EEE that has caused *user*
> >    *regressions* that we need to resolve.
> > 
> > 2) Providing core functionality so that newer implementations can have
> >    a consistency of behaviour.
> > 
> > I have *no* interest in doing a total rewrite of kernel EEE
> > functionality - that goes well beyond my aims here.
> >
> > So I'm afraid that I really lost interest in reading your email, sorry.
>  
> Sorry for killing your motivation. I can feel your pain...

I just don't think it's right to throw a whole new load of problems
to be solved into the mix when we already have issues in the kernel
caused by inappropriately merged previous patches.

Andrew had a large patch set, which added the phylib core code, and
fixed up many drivers. This was taken by someone else, and only
Andrew's core phylib code was merged along with the code for their
driver, thus breaking a heck of a lot of other drivers.

Either this needs to be fixed, or why don't we just declare that we've
broken EEE in the kernel, declare that we don't support EEE at all, and
rip the whole sorry damn thing out and start again from scratch -
because what you're suggesting is basically changing *everything*
about EEE support.

Yes, what we currently do may be sub-optimal, but it's the API that
we've presented to userspace for a long time.

I just don't think it's right to decide to pile all these new issues
on top of the utter crap situation we currently have.

Oh, lookie... I just looked back in the git history to find the person
who submitted the subset of Andrew's code was... YOU. YOU broke lots of
drivers by doing so. Now you're torpedoing attempts to fix them by
trying to make it more complicated. Sorry, but your opinion has just
lost all credibility with me given the mess you previously created
and haven't been bothered to try to fix up. At least *I've* been
trying to fix you crap.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

