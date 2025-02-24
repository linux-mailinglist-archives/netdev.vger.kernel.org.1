Return-Path: <netdev+bounces-168948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B3BA41B41
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 11:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8009B7A39F6
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 10:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422E3250BE7;
	Mon, 24 Feb 2025 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bxix02Ya"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDF21A08C5;
	Mon, 24 Feb 2025 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393383; cv=none; b=s1X5K9GJC+9vgkw88nc2enKvcgdwskQbaVGvPA4vSRTJWmjpFs0/wGYplsoDeR4plHh1gvzzt2kaUowUrUVsxF6sLpkJd9B2UuHbAR6d79FP1Zs2siwS4AoViguaiYBUH27WP0EjeakvGRzwhaeioas2ccuWXwW45pMSSN7rUTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393383; c=relaxed/simple;
	bh=LWj+rzbXhdbUWEizLtYOJLzuzvQIQbJfgxH7xmLfWRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EY5RpGemfd0DvDGeL7CCp441FAoVgKvYmUyuFaL/5nIsZLR4kjYOPVldRijkCxWy708nsX+dzwgbXI8+xvNwWvLqxSxaFytdpWd8A0WCa5bczjwb8oFdAEC/u+6OLhWeh9lMsq/2niWN0uQlgC3o3GuGzGWHrRraSmxmCcQY2J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bxix02Ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22990C4CED6;
	Mon, 24 Feb 2025 10:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740393382;
	bh=LWj+rzbXhdbUWEizLtYOJLzuzvQIQbJfgxH7xmLfWRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bxix02YacPDlWmFsV1+Bblcqo22T/1wsSdlOB5ypmFsUZdM5t535aZ0YS6n3zeyUN
	 3dL6GLrekriU/4LvbioQMRyKHwoFq8+fPXPCKYG6gg0RF9lzogej12m8ZDKeLawbog
	 JwFtQXtjInRCgA+gOd2y/wSu/6Dl2FxsDF/RfQYPL980nmVN+HD1cPr4UCQZ8GOTa9
	 ywbB/Lg+nVr5xyHLh123FdkRAi4kvQWqX7dOvMzzpfDKi+zn4bb7yNoGnMsqsG89Ho
	 esDGUlFal9bjs1EIXBvusnDiyv6f1ZX+ndgyeMjZI1kOBG9MNtdfbNlKDBe5R9eWy5
	 Bu6V40h7k+Saw==
Date: Mon, 24 Feb 2025 11:36:16 +0100
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>, davem@davemloft.net, 
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, 
	Florian Fainelli <f.fainelli@gmail.com>, =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, 
	Simon Horman <horms@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>, 
	Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: phy: sfp: Add single-byte SMBus SFP
 access
Message-ID: <ihxsrolj75ufuhyfu4r2dalth4dzkmamh5naat5fa74iwu3mrb@5vl453qcsoj7>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
 <87r03otsmm.fsf@miraculix.mork.no>
 <20250224103814.7d60bfbd@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224103814.7d60bfbd@fedora>

On Mon, Feb 24, 2025 at 10:38:14AM +0100, Maxime Chevallier wrote:
> Hi Bjørn,
> 
> On Sun, 23 Feb 2025 19:37:05 +0100
> Bjørn Mork <bjorn@mork.no> wrote:
> 
> > Maxime Chevallier <maxime.chevallier@bootlin.com> writes:
> > 
> > > Hi everyone,
> > >
> > > Some PHYs such as the VSC8552 have embedded "Two-wire Interfaces" designed to
> > > access SFP modules downstream. These controllers are actually SMBus controllers
> > > that can only perform single-byte accesses for read and write.
> > >
> > > This series adds support for accessing SFP modules through single-byte SMBus,
> > > which could be relevant for other setups.
> > >
> > > The first patch deals with the SFP module access by itself, for addresses 0x50
> > > and 0x51.
> > >
> > > The second patch allows accessing embedded PHYs within the module with single-byte
> > > SMBus, adding this in the mdio-i2c driver.
> > >
> > > As raw i2c transfers are always more efficient, we make sure that the smbus accesses
> > > are only used if we really have no other choices.
> > >
> > > This has been tested with the following modules (as reported upon module insertion)
> > >
> > > Fiber modules :
> > >
> > > 	UBNT             UF-MM-1G         rev      sn FT20051201212    dc 200512
> > > 	PROLABS          SFP-1GSXLC-T-C   rev A1   sn PR2109CA1080     dc 220607
> > > 	CISCOSOLIDOPTICS CWDM-SFP-1490    rev 1.0  sn SOSC49U0891      dc 181008
> > > 	CISCOSOLIDOPTICS CWDM-SFP-1470    rev 1.0  sn SOSC47U1175      dc 190620
> > > 	OEM              SFP-10G-SR       rev 02   sn CSSSRIC3174      dc 181201
> > > 	FINISAR CORP.    FTLF1217P2BTL-HA rev A    sn PA3A0L6          dc 230716
> > > 	OEM              ES8512-3LCD05    rev 10   sn ESC22SX296055    dc 220722
> > > 	SOURCEPHOTONICS  SPP10ESRCDFF     rev 10   sn E8G2017450       dc 140715
> > > 	CXR              SFP-STM1-MM-850  rev 0000 sn K719017031       dc 200720
> > >
> > >  Copper modules
> > >
> > > 	OEM              SFT-7000-RJ45-AL rev 11.0 sn EB1902240862     dc 190313
> > > 	FINISAR CORP.    FCLF8521P2BTL    rev A    sn P1KBAPD          dc 190508
> > > 	CHAMPION ONE     1000SFPT         rev -    sn     GBC59750     dc 19110401
> > >
> > > DAC :
> > >
> > > 	OEM              SFP-H10GB-CU1M   rev R    sn CSC200803140115  dc 200827
> > >
> > > In all cases, read/write operations happened without errors, and the internal
> > > PHY (if any) was always properly detected and accessible
> > >
> > > I haven't tested with any RollBall SFPs though, as I don't have any, and I don't
> > > have Copper modules with anything else than a Marvell 88e1111 inside. The support
> > > for the VSC8552 SMBus may follow at some point.
> > >
> > > Thanks,
> > >
> > > Maxime
> > >
> > > Maxime Chevallier (2):
> > >   net: phy: sfp: Add support for SMBus module access
> > >   net: mdio: mdio-i2c: Add support for single-byte SMBus operations
> > >
> > >  drivers/net/mdio/mdio-i2c.c | 79 ++++++++++++++++++++++++++++++++++++-
> > >  drivers/net/phy/sfp.c       | 65 +++++++++++++++++++++++++++---
> > >  2 files changed, 138 insertions(+), 6 deletions(-)  
> > 
> > Nice!  Don't know if you're aware, but OpenWrt have had patches for
> > SMBus access to SFPs for some time:
> > 
> > https://github.com/openwrt/openwrt/blob/main/target/linux/realtek/patches-6.6/714-net-phy-sfp-add-support-for-SMBus.patch
> > https://github.com/openwrt/openwrt/blob/main/target/linux/realtek/patches-6.6/712-net-phy-add-an-MDIO-SMBus-library.patch
> > 
> > The reason they carry these is that they support Realtek rtl930x based
> > switches.  The rtl930x SoCs include an 8 channel SMBus host which is
> > typically connected to any SFP+ slots on the switch.
> > 
> > There has been work going on for a while to bring the support for these
> > SoCs to mainline, and the SMBus host driver is already here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/i2c/busses/i2c-rtl9300.c?id=c366be720235301fdadf67e6f1ea6ff32669c074
> > 
> > I assume DSA and ethernet eventually will follow, making SMBus SFP
> > support necessary for this platform too.
> > 
> > So thanks for doing this!
> 
> Good to know this is useful to you ! So there's at least 2 different
> classes of products out there with SMBus that advertise that it's
> "designed for SFP" ._.
> 
> > FWIW, I don't think the OpenWrt mdio patch works at all.  I've recently
> > been playing with an 8 SFP+ port switch based on rtl9303, and have tried
> > to fixup both the clause 22 support and add RollBall and clause 45.
> > This is still a somewhat untested hack, and I was not planning on
> > presenting it here as such, but since this discussion is open:
> > https://github.com/openwrt/openwrt/pull/17950/commits/c40387104af62a065797bc3e23dfb9f36e03851b
> > 
> > Sorry for the format.  This is a patch for the patch already present in
> > OpenWrt. Let me know if you want me to post the complete patched
> > mdio-smbus.c for easier reading.
> > 
> > The main point I wanted to make is that we also need RollBall and clause
> > 45 over SMBus.  Maybe not today, but at some point.  Ideally, the code
> > should be shared with the i2c implementation, but I found that very hard
> > to do as it is.
> 
> I don't have anything to test that, and yeah that can be considered as
> a second step, however I don't even know if this can work at all with
> single byte accesses :(

I will send you some RollBall modules, Maxime.

Marek

