Return-Path: <netdev+bounces-180664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A786A82107
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 11:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28C7E7A854E
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AFC25D21C;
	Wed,  9 Apr 2025 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HZOYGHcW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC98E25C71C;
	Wed,  9 Apr 2025 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744191003; cv=none; b=JenV8HSkYPvZ3Tj8GydqnSqnVGoMRWPcjTiPACk/EFTsyzZUW1K1gNtkeOWZiidIu+MPynl4FQGHDOMTmTC4T7MdQ5NH8RmL+VTwnksXU8fwJomsqsmJaj+ZLwfRdCOKmL9QWiZNZ/oa80iygM0H65k4VoJjoIhawyW4z0GxR6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744191003; c=relaxed/simple;
	bh=E0B8NhfvLqtNMVjkYqNvgmPWecDZJNbo5NCqpvSDuzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJDS3ZaQsAK691KGeFFtOpU2eIaplpyaGiMRravCIRDh6Jc+O45QkjKQO8wx29QDhhpV6OYMpF2L+qQ+AJrVJH0p4VJC7gpw9mfPuK9CyV88mwl82YxbNxc8jzokDR2WlGD8BfD1x8mByiO5j2I3M1FECBRARfG/3CTZEpKKqXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HZOYGHcW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2wkholla1Ti8t2pKiZhbvK6ikFjXur57L42DgenYivI=; b=HZOYGHcWwjHN+szmB2xRaw7dhn
	xr42xl10nVlN3qyC5YlUdighZeQh7Y2GVHPDNg6AEtkcx3OHPbJgGCaJ8PKdHsPUpNPBJ86cShUTd
	jFVJnjloT9CKkVwV59W95ybBLGEcTNUO4w++PZfmMKwH0TGIJ35KO8pthr34arCnrq02m3akANHmS
	4gwy9A+syKVqI2WtKbaVYgNYqgqHCGzAn9QCjC7GcPhJDpLLkca+rdvLhOdAH3Zuw+6hnkdQ3Salx
	zXPVgjMAr8xIsiVBgUyEZaxvPAhQcAQvETUMTqKdG6y/fSXVjpdJLkeymCAePP528/EOGvHogI/Yv
	dImhlXRw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47904)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u2Rko-0000Jn-1C;
	Wed, 09 Apr 2025 10:29:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u2Rkn-0002SN-0H;
	Wed, 09 Apr 2025 10:29:53 +0100
Date: Wed, 9 Apr 2025 10:29:52 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v2 0/2] Add Marvell PHY PTP support
Message-ID: <Z_Y-ENUiX_nrR7VY@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
 <Z_P3FKEhv1s0y4d7@shell.armlinux.org.uk>
 <20250407182028.75531758@kmaincent-XPS-13-7390>
 <Z_P-K7mEEH6ProlC@shell.armlinux.org.uk>
 <20250407183914.4ec135c8@kmaincent-XPS-13-7390>
 <Z_WJO9g5Al1Yr_LX@shell.armlinux.org.uk>
 <20250409103130.43ab4179@kmaincent-XPS-13-7390>
 <Z_Yxb6-qclDSWk01@shell.armlinux.org.uk>
 <20250409104637.37301e01@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409104637.37301e01@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 09, 2025 at 10:46:37AM +0200, Kory Maincent wrote:
> On Wed, 9 Apr 2025 09:35:59 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > On Wed, Apr 09, 2025 at 10:31:30AM +0200, Kory Maincent wrote:
> > > On Tue, 8 Apr 2025 21:38:19 +0100
> > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > >   
> > > > On Mon, Apr 07, 2025 at 06:39:14PM +0200, Kory Maincent wrote:  
> >  [...]  
> >  [...]  
> >  [...]  
> > > > 
> > > > Okay, so I'm pleased to report that this now works on the Macchiatobin:
> > > > 
> > > > where phc 2 is the mvpp2 clock, and phc 0 is the PHY.  
> > > 
> > > Great, thank you for the testing!
> > >   
> > > > 
> > > > # ethtool -T eth2
> > > > Time stamping parameters for eth2:
> > > > Capabilities:
> > > >         hardware-transmit
> > > >         software-transmit
> > > >         hardware-receive
> > > >         software-receive
> > > >         software-system-clock
> > > >         hardware-raw-clock
> > > > PTP Hardware Clock: 2
> > > > Hardware Transmit Timestamp Modes:
> > > >         off
> > > >         on
> > > >         onestep-sync
> > > >         onestep-p2p
> > > > Hardware Receive Filter Modes:
> > > >         none
> > > >         all
> > > > 
> > > > So I guess that means that by default it's using PHC 2, and thus using
> > > > the MVPP2 PTP implementation - which is good, it means that when we add
> > > > Marvell PHY support, this won't switch to the PHY implementation.  
> > > 
> > > Yes.
> > >   
> > > > 
> > > > Now, testing ethtool:
> > > > 
> > > > $ ./ethtool --get-hwtimestamp-cfg eth2
> > > > netlink error: Operation not supported
> > > > 
> > > > Using ynl:
> > > > 
> > > > # ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --dump
> > > > tsconfig-get --json '{"header":{"dev-name":"eth2"}}' []
> > > > 
> > > > So, It's better, something still isn't correct as there's no
> > > > configuration. Maybe mvpp2 needs updating first? If that's the case,
> > > > then we're not yet in a position to merge PHY PTP support.  
> > > 
> > > Indeed mvpp2 has not been update to support the ndo_hwtstamp_get/set NDOs.
> > > Vlad had made some work to update all net drivers to these NDOs but he never
> > > send it mainline:
> > > https://github.com/vladimiroltean/linux/commits/ndo-hwtstamp-v9
> > > 
> > > I have already try to ping him on this but without success.
> > > Vlad any idea on when you could send your series upstream?  
> > 
> > Right, and that means that the kernel is not yet ready to support
> > Marvell PHY PTP, because all the pre-requisits to avoid breaking
> > mvpp2 have not yet been merged.
> 
> Still I don't understand how this break mvpp2.
> As you just tested this won't switch to the PHY PTP implementation.

How do I know that from the output? Nothing in the output appears to
tells me which PTP implementation will be used.

Maybe you have some understanding that makes this obvious that I don't
have.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

