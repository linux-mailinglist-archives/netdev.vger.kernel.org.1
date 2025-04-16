Return-Path: <netdev+bounces-183469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C2BA90C2C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 21:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C288B172C34
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966A722371A;
	Wed, 16 Apr 2025 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XHHe0icn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EB42040B4
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831187; cv=none; b=fg/l0Obk3U0ZbHa+CCIeoOoo5rdJBejPd2DlfmpSiQsggW8eUuj1B80TmywrEdo7gRldQ6sirK2UPyR0t8WhKOoUERxqX3ujKU23wA7ZAgNyXB6VOkOipOU/qqGq4fEqMiLfo7GOYqjC6V6QkTKcpFRSK1dGrcWf7XH+Jys2p9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831187; c=relaxed/simple;
	bh=tTM6Gb60ZS0/KmfqmFkU1bYEzMgSXltdwhVXt/20DiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gG9+D9cnsKscouFKvijiYvxc6oR1M8hoq0olIrHJH0OYG7uPSNOycKKM5A34j/GBzqq+OVjYD0yb9m3hTNh5F/38avAz7uSi15mx0KgyDiVOt1UTNzGiorS+sJOEBu2R7YrAcPPf6V52DxysGLtgXMzB4+mbdd9V9FQb8JePGWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XHHe0icn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+OdLl5cUNL2Vnd31yqTsZRdkvX0SKAs00JB7ONOqdUU=; b=XHHe0icnknIo/uGWD9xCQUTtL8
	SNOXfwV3VnKRj39gwaLu2tio1XJ9mmMF1cTurTdldOJ5MfPpP1v8z2KmnDmMG91FuLB14FPNuw8EZ
	kKk8SZ880Min51pmqWJmdPHn5nKYdXY7w2iMvaurUe35nq5aSAoCbH70SiTkikT3sFz6Dg2JpQx+/
	SE4JvB6MRJWe2lQV/qx7yXlC2juNbVRSqM/FJ0P92kQpF71ug4Wx/Rn37KxHv86uTtIZoU1VIK7VK
	GwuzlHV0PdM9NgQIHEiIBIBxfMDTP3JtGrY1A6zQrNMlfYQ03SNC42dEfBmExZF4ItNVm141dJqUv
	0g6BPcCA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55824)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u58IO-0001qd-2Y;
	Wed, 16 Apr 2025 20:19:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u58IL-0001gB-30;
	Wed, 16 Apr 2025 20:19:37 +0100
Date: Wed, 16 Apr 2025 20:19:37 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [net-next PATCH 2/2] net: phylink: Fix issues with link
 balancing w/ BMC present
Message-ID: <aAACyQ494eO4LFQD@shell.armlinux.org.uk>
References: <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
 <174481734008.986682.1350602067856870465.stgit@ahduyck-xeon-server.home.arpa>
 <Z__URcfITnra19xy@shell.armlinux.org.uk>
 <CAKgT0UcgZpE4CMDmnR2V2GTz3tyd+atU-mgMqiHesZVXN8F_+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UcgZpE4CMDmnR2V2GTz3tyd+atU-mgMqiHesZVXN8F_+g@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 16, 2025 at 12:03:05PM -0700, Alexander Duyck wrote:
> On Wed, Apr 16, 2025 at 9:01 AM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Apr 16, 2025 at 08:29:00AM -0700, Alexander Duyck wrote:
> > > From: Alexander Duyck <alexanderduyck@fb.com>
> > >
> > > This change is meant to address the fact that there are link imbalances
> > > introduced when using phylink on a system with a BMC. Specifically there
> > > are two issues.
> > >
> > > The first issue is that if we lose link after the first call to
> > > phylink_start but before it gets to the phylink_resolve we will end up with
> > > the phylink interface assuming the link was always down and not calling
> > > phylink_link_down resulting in a stuck interface.
> >
> > That is intentional.
> >
> > phylink strictly orders .mac_link_down and .mac_link_up, and starts from
> > an initial position that the link _will_ be considered to be down. So,
> > it is intentional that .mac_link_down will _never_ be called after
> > phylink_start().
> 
> Well the issue is that with a BMC present the link may be up before we
> even start using phylink. So if the link is lost while we are going
> through phylink_start we will end up in an in-between state where the
> link is physically down, but the MAC is still configured as though the
> link is up. This will be problematic as the MAC should essentially be
> discarding frames for transmit if the link is down to avoid blocking
> internal Tx FIFOs.

So, when a Linux network driver probes, it starts out in administrative
state *DOWN*. When the administrator configures the network driver,
.ndo_open is called, which is expected to configure the network adapter.

Part of that process is to call phylink_start() as one of the last
steps, which detects whether the link is up or not. If the link is up,
then phylink will call netif_carrier_on() and .mac_link_up(). This
tells the core networking layers that the network interface is now
ready to start sending packets, and it will begin queueing packets for
the network driver to process - not before.

Prior to .ndo_open being called, the networking layers do not expect
traffic from the network device no matter what physical state the
media link is in. If .ndo_open fails, the same applies - no traffic is
expected to be passed to the core network layers from the network
layers because as far as the network stack is concerned, the interface
is still administratively down.

Thus, the fact that your BMC thinks that the link is up is irrelevant.

So, start off in a state that packet activity is suspended even if the
link is up at probe time. Only start packet activity (reception and
transmission) once .mac_link_up() has been called. Stop that activity
when .mac_link_down() is subsequently called.

There have been lots of NICs out there where the physical link doesn't
follow the adminstrative state of the network interface. This is not a
problem. It may be desirable that it does, but a desire is not the same
as "it must".

> > > The second issue is that when a BMC is present we are currently forcing the
> > > link down. This results in us bouncing the link for a fraction of a second
> > > and that will result in dropped packets for the BMC.
> >
> > ... but you don't explain how that happens.
> 
> It was right there in the patch. It was the lines I removed:

... thus further breaking phylink guarantees.

Sorry, but no.

> The issue, even with your recent patch, is that it will still force
> the link down if the link was previously up. That is the piece I need
> to avoid to prevent the BMC from losing link. Ideally what I need is
> to have a check of the current link state and then sync back up rather
> than force the phylink state on the MAC and then clean things up after
> the fact.

So don't force the link, just stop packet activity. As stated above,
nothing requires that the physical link is forced down just because
.mac_link_down() has been called.

This makes me wonder what happens to your BMC with your ideas if
userspace takes down the network interface. It sounds like all hell
breaks loose because you've taken the link down, and that's seen as
a critical failure... So taking down a network interface becomes a
critical failure - yet it's a *normal* userspace operation.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

