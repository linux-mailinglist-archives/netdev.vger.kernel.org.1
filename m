Return-Path: <netdev+bounces-181413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2AAA84D33
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 21:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C614447E2B
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5B8284B5A;
	Thu, 10 Apr 2025 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1pQ8c14I"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747581E5206;
	Thu, 10 Apr 2025 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744314030; cv=none; b=Hw9FBsednrTx/UKvn17vkA9xisu7/IgDUEUI9Hl6R2lACH5w2BDQT+6vAa6VPeqfFw//C9fTsMpy/OJFxFLkDQvCh/366bcONd2rzM5ZtdGyMeZ9zHiO8AwhSodCNEXxXtMkwcpMS/Q+fDntYXOAynAmpgwH0UfujhJzT/PZrwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744314030; c=relaxed/simple;
	bh=EqG6bV9uu1+OS9htLQk+Lmb3SAcKfz+RCqu+acDYM0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tptWjvdvH7NrKMrXjQKFshPJYbBCVE40UuW88YRiAKcJBFSmMxArAIt2GeRPSvl+iipOS0N5MK8AtrOLzGF+aGVFWCpxHUEu2MZRZ1BbEJjxJyAG+2tIDJl/t+yu45Vc4KzQQAnxmbLdq5vebrFArPv940RgLkSfiOoVbQGfaOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1pQ8c14I; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hXIB3Hcfuug+kNve3lPpJgg9CdyzHNxaIStHc89+43c=; b=1pQ8c14IaovuGU/AE+akUVZwWN
	wmeOAhVVxROopAX1/XwGnNjrOaWviJnSS4TrOq+rKuPL0BuDaLXmaZhUoLf81CYtHONLDW70iH8ob
	selguFVe3QclQWYh0pQc8VSbU2W+N+4gF+/M3AHce+z/dUUuM9ncUjO3aWsSjOHVqr8z3Oy8yx0lq
	mmloSqSLYjhsaCqz5ZmlddaTU3Ao6NVUcGq9PYniLhfFBromc6tHrz+bljDTAknjKJc6iR6Q7RlIu
	BqSLtFGcztXk1NZbBBk0ofYjyBZ0XpR5p+WsPeikqCOT9K84+1zHBwSIPQvFayrV0RarygA2toRAY
	Uio8g5vg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60700)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u2xl2-0002NX-1v;
	Thu, 10 Apr 2025 20:40:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u2xkz-0003qV-0C;
	Thu, 10 Apr 2025 20:40:13 +0100
Date: Thu, 10 Apr 2025 20:40:12 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add Marvell PHY PTP support
Message-ID: <Z/genHfvbvll09XT@shell.armlinux.org.uk>
References: <Z_ZlDLzvu_Y2JWM8@shell.armlinux.org.uk>
 <20250409143820.51078d31@kmaincent-XPS-13-7390>
 <Z_Z3lchknUpZS1UP@shell.armlinux.org.uk>
 <20250409180414.19e535e5@kmaincent-XPS-13-7390>
 <Z_avqyOX2bi44sO9@shell.armlinux.org.uk>
 <Z/b2yKMXNwjqTKy4@shell.armlinux.org.uk>
 <20250410111754.136a5ad1@kmaincent-XPS-13-7390>
 <Z_fmkuPhqMqWBL2M@shell.armlinux.org.uk>
 <20250410180205.455d8488@kmaincent-XPS-13-7390>
 <Z_gLD8XFlyG32D6L@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_gLD8XFlyG32D6L@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 10, 2025 at 07:16:47PM +0100, Russell King (Oracle) wrote:
> On Thu, Apr 10, 2025 at 06:02:05PM +0200, Kory Maincent wrote:
> > On Thu, 10 Apr 2025 16:41:06 +0100
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > 
> > > On Thu, Apr 10, 2025 at 11:17:54AM +0200, Kory Maincent wrote:
> > > > On Wed, 9 Apr 2025 23:38:00 +0100
> > > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:  
> > > > > On Wed, Apr 09, 2025 at 06:34:35PM +0100, Russell King (Oracle) wrote:  
> > 
> > > > > 
> > > > > With that fixed, ptp4l's output looks very similar to that with mvpp2 -
> > > > > which doesn't inspire much confidence that the ptp stack is operating
> > > > > properly with the offset and frequency varying all over the place, and
> > > > > the "delay timeout" messages spamming frequently. I'm also getting
> > > > > ptp4l going into fault mode - so PHY PTP is proving to be way more
> > > > > unreliable than mvpp2 PTP. :(  
> > > > 
> > > > That's really weird. On my board the Marvell PHY PTP is more reliable than
> > > > MACB. Even by disabling the interrupt.
> > > > What is the state of the driver you are using?   
> > > 
> > > Right, it seems that some of the problems were using linuxptp v3.0
> > > rather than v4.4, which seems to work better (in that it doesn't
> > > seem to time out and drop into fault mode.)
> > > 
> > > With v4.4, if I try:
> > > 
> > > # ./ptp4l -i eth2 -m -s -2
> > > ptp4l[322.396]: selected /dev/ptp0 as PTP clock
> > > ptp4l[322.453]: port 1 (eth2): INITIALIZING to LISTENING on INIT_COMPLETE
> > > ptp4l[322.454]: port 0 (/var/run/ptp4l): INITIALIZING to LISTENING on
> > > INIT_COMPLETE ptp4l[322.455]: port 0 (/var/run/ptp4lro): INITIALIZING to
> > > LISTENING on INIT_COMPLETE ptp4l[328.797]: selected local clock
> > > 005182.fffe.113302 as best master
> > > 
> > > that's all I see. If I drop the -2, then:
> > 
> > It seems you are still using your Marvell PHY drivers without my change.
> > PTP L2 was broken on your first patch and I fixed it.
> > I have the same result without the -2 which mean ptp4l uses UDP IPV4.
> 
> I'm not sure what you're referring to.

Okay, turns out to be nothing to do with any fixes in my code or not
(even though I still don't know what the claimed brokenness you
refer to actually was.)

It turns out to be that ptpdv2 sends PTP packets using IPv4 UDP *or*
L2, and was using IPv4 UDP. Adding "ptpengine:transport=ethernet" to
the ptpdv2 configuration allows ptp4l -2 to then work.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

