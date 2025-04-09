Return-Path: <netdev+bounces-180898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7289A82DB6
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 19:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB841883DD7
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B85626B2CF;
	Wed,  9 Apr 2025 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="q1z/Ws0U"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834E21C5F39;
	Wed,  9 Apr 2025 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744220093; cv=none; b=DZOo+/CEDQ7uqsfuHx71roHDN4OLeKSNYwEFM8Kccb55QpjyxaDFHgR6MovmM0Y2YrzO8R5jIlp20tr2ie9wILRmxlbF+gD9lpHPeNlXeCYWJJLqU1Q9OJEpbf6G4wAqZW3Kv512LcUp9MZxWDT1+lsxIggQ0bRR5/3CFLi10OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744220093; c=relaxed/simple;
	bh=fet8ZDtq4y7709qBrhbHF3MVZJQgOOyKdqtHqZFuodY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBaK6Z7xpOuJjijz1DD5dgsQK0wnEKqeO3etHJdvMDRmMhDgn1DXRnLD3fIU+IYsTBYKHkSr02k6wY1M/N4GxfOHsye7rrqKfzypGn/yUqHWOM+Z55JIStDTRVoyNmq0sEhcLxoJerhCQARECgO4Ld82oI+tVl+wFptg+604E8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=q1z/Ws0U; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N4LvEMvJcaYh0O8lvXByJBpLV2ZXxaE8V3ig6rTCot4=; b=q1z/Ws0U8HQkJ8A0FVo0+SD6wW
	nCIJ7xqhEgAD3e8YQLdIWQsMS+VqgeofonnAW2zIDSCqqk4n1HVE+zoO7DrfRBmiecyvhWLeKjdXg
	fYQSDBGAPhYHyzmLwfpANsEaLccKZY1tzTohGKthR59/tCTcnTEoHheVWL2DHOzu/tX0Wpe8SN3w6
	OGjEtuwIwrRYfvRL9Ct2FhYLm+9VbQNypN6WjYJv7o+L0zL7BJgjId4DgMs7md8fdpDUd3rg/bylv
	e8wjmOlxU/UuaWoxSes6YpK5A+DW6o2VsOpeC9i8Q9wuYHjRzfiQD/fdtb2TNpciXK0uilJTpFzAE
	XLzpXu2A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52476)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u2ZJu-0000qm-1N;
	Wed, 09 Apr 2025 18:34:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u2ZJr-0002kM-1F;
	Wed, 09 Apr 2025 18:34:35 +0100
Date: Wed, 9 Apr 2025 18:34:35 +0100
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
Message-ID: <Z_avqyOX2bi44sO9@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-2-a297d3214846@bootlin.com>
 <20250408154934.GZ395307@horms.kernel.org>
 <Z_VdlGVJjdtQuIW0@shell.armlinux.org.uk>
 <20250409101808.43d5a17d@kmaincent-XPS-13-7390>
 <Z_YwxYZc7IHkTx_C@shell.armlinux.org.uk>
 <20250409104858.2758e68e@kmaincent-XPS-13-7390>
 <Z_ZlDLzvu_Y2JWM8@shell.armlinux.org.uk>
 <20250409143820.51078d31@kmaincent-XPS-13-7390>
 <Z_Z3lchknUpZS1UP@shell.armlinux.org.uk>
 <20250409180414.19e535e5@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409180414.19e535e5@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 09, 2025 at 06:04:14PM +0200, Kory Maincent wrote:
> On Wed, 9 Apr 2025 14:35:17 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > On Wed, Apr 09, 2025 at 02:38:20PM +0200, Kory Maincent wrote:
> > > Ok, thanks for the tests and these information.
> > > Did you run ptp4l with this patch applied and did you switch to Marvell PHY
> > > PTP source?  
> > 
> > This was using mvpp2, but I have my original patch as part of my kernel
> > rather than your patch.
> 
> So you are only testing the mvpp2 PTP. It seems there is something broken with
> it. I don't think it is related to my work.

Yes, and it has worked - but probably was never tested with PTPDv2 but
with linuxptp. As it was more than five years ago when I worked on this
stuff, I just can't remember the full details of the test setup I used.

I think the reason I gave up running PTP on my network is the problems
that having the NIC bound into a Linux bridge essentially means that
you can't participate in PTP on that machine. That basically means a
VM host machine using a bridge device for the guests can't use PTP
to time sync itself.

Well, it looks like the PHY based timestamping also isn't working -
ptp4l says its failing to timestamp transmitted packets, but having
added debug, the driver _is_ timestamping them, so the timestamps
are getting lost somewhere in the networking layer, or are too late
for ptp4l, which only waits 1ms, and the schedule_delayed_work(, 2) 
will be about 20ms at HZ=100. Increasing the wait in ptp4l to 100ms
still doesn't appear to get a timestamp. According to the timestamps
on the debug messages, it's only taking 10ms to return the timestamp.

So, at the moment, ptp looks entirely non-functional. Or the userspace
tools are broken.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

