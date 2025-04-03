Return-Path: <netdev+bounces-179213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F740A7B25B
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 01:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582A93B9009
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D8216CD33;
	Thu,  3 Apr 2025 23:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VNnoKNQS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B91188A3A
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 23:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743722355; cv=none; b=CwH3QzIwBzMmR0ztVXCIYNAPkAjup9kUA1pRzxu7FdQTMMpKp7Xi7jhqhLxTN6+hggM2SFNnC9iR1GkDukevVD11ap0OkbOHqeHiEi9doc914OdW+fAHuIiHohVrK9mbW8PQ6rBsUnE+Wt4vroLW9ViWXzIz7YVdxafiG+ZXUz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743722355; c=relaxed/simple;
	bh=fPxkG50YWNSm2Xt+KkwuqJZQ3GsufaMKWL1dAcVK5ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbDbzYzEqQgDl6F4oUvQ2SSNUWP5rDB6DjvbiV8oMcgfTyAcOui/JLnaKTKnbceRt0Z8jvqKKjIcgVc9laxgNVJxPdwBgOSGWBpmKVQSB8HDfVvKP6pG1JnRFNjz0Du5zPRIE+4gLOopZJWkhKk/DcYKRERTzQ2+asD+V2sdboY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VNnoKNQS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Uj9qAcQUMmqt5W/hOAe26pjSK8R1YQxV/yh3l9NsKEI=; b=VNnoKNQSDLmxBcunUjG97zs2PW
	vBNjEQk53mo+uTOkSxb9+B/biW7KdXVgEpfx7xGz83MmLuZc87hGtPK9HpdR6T9Fj176lztON4EtW
	WupjfI+x8Mgjx7ZcX+Pu1EzV0f7RZD1WvK/coXEvDIVxBN4PaHNUoIvLkMnUJViqQDObwzPAf+uFB
	PxNyLBPWJ1lGXrzte16DEXyydmSi/Jxc7RNmd+Jdwct24CJvXvEYFAVWukixVdUz4Jc1fv9iW5t6X
	uFd4wGb4f68pNYz2+8st+mJNlLVDiVOOjOrq2uCpMCixZVx+SNrMt9XT+B9sA60IdR77d5jOCzAmX
	0ItR2bJw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57192)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u0Tpy-00012K-1P;
	Fri, 04 Apr 2025 00:19:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u0Tpu-0005Ah-28;
	Fri, 04 Apr 2025 00:19:02 +0100
Date: Fri, 4 Apr 2025 00:19:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to
 phy_lookup_setting
Message-ID: <Z-8XZiNHDoEawqww@shell.armlinux.org.uk>
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
 <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
 <Z-6hcQGI8tgshtMP@shell.armlinux.org.uk>
 <20250403172953.5da50762@fedora.home>
 <de19e9f1-4ae3-4193-981c-e366c243352d@lunn.ch>
 <CAKgT0UdhTT=g+ODpzR5uoTEOkC8u+cfCp7H-8718Zphd=24buw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UdhTT=g+ODpzR5uoTEOkC8u+cfCp7H-8718Zphd=24buw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 03, 2025 at 02:53:22PM -0700, Alexander Duyck wrote:
> On Thu, Apr 3, 2025 at 9:34 AM Andrew Lunn <andrew@lunn.ch> wrote:
> > Maybe go back to why fixed-link exists? It is basically a hack to make
> > MAC configuration easier. It was originally used for MAC to MAC
> > connections, e.g. a NIC connected to a switch, without PHYs in the
> > middle. By faking a PHY, there was no need to add any special
> > configuration API to the MAC, the phylib adjust_link callback would be
> > sufficient to tell the MAC to speed and duplex to use. For {R}{G}MII,
> > or SGMII, that is all you need to know. The phy-mode told you to
> > configure the MAC to MII, GMII, SGMII.
> 
> Another issue is that how you would define the connection between the
> two endpoints is changing. Maxime is basing his data off of
> speed/duplex however to source that he is pulling data from
> link_mode_params that is starting to broaden including things like
> lanes.

Just a quick correction - this is not entirely correct. It's speed,
duplex and "lanes" is defined by interface mode.

For example, 10GBASER is a single lane, as is SGMII, 1000BASE-X,
2500BASE-X. XLGMII and CGMII are defined by 802.3 as 8 lanes (clause
81.)

speed and duplex just define the speed operated over the link defined
by the PHY interface mode.

(I've previously described why we don't go to that depth with fixed
links, but to briefly state it, it's what we've done in the past and
it's visible to the user, and we try to avoid breaking userspace.)

> I really think going forward lanes is going to start playing a
> role as we get into the higher speeds and it is already becoming a
> standard config item to use to strip out unsupported modes when
> configuring the interface via autoneg.

Don't vendors already implement downshift for cases where there are
problems with lanes/cabling?

> I am wondering about that. I know I specified we were XLGMII for fbnic
> but that has proven problematic since we aren't actually 40G.

If you aren't actually 40G, then you aren't actually XLGMII as
defined by 802.3... so that begs the question - what are you!

> So we
> are still essentially just reporting link up/down using that. That is
> why I was looking at going with a fixed mode as I can at least specify
> the correct speed duplex for the one speed I am using if I want to use
> ethtool_ksettings_get.
> 
> I have a patch to add the correct phy_interface_t modes for 50, and
> 100G links. However one thing I am seeing is that after I set the
> initial interface type I cannot change the interface type without the
> SFP code added. One thing I was wondering. Should I just ignore the
> phy_interface_t on the pcs_config call and use the link mode mask
> flags in autoneg and the speed/duplex/lanes in non-autoneg to
> configure the link? It seems like that is what the SFP code itself is
> doing based on my patch 2 in the set.

That is most certainly *not* what the SFP code is doing. As things stand
today, everything respects the PHY interface mode, if it says SGMII then
we get SGMII. If it says 1000BASE-X, we get 1000BASE-X. If it says
2500BASE-X, then that's what we get... and so on.

The SFP code has added support to switch between 2500BASE-X and
1000BASE-X because this is a use case with optical SFPs that can operate
at either speed. That's why this happens for the SFP case.

For PHYs, modern PHYs switch their host facing interface, so we support
the interface mode changing there - under the control of the PHY and
most certainly not under user control (the user doesn't know how the
PHY has been configured and whether the PHY does switch or rate
adapt.)

For everything else, we're in fixed host interface mode, because that
is how we've been - and to do anything else is new development.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

