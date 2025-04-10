Return-Path: <netdev+bounces-181385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6395A84BF4
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 20:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B88257AF8DC
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985951EDA28;
	Thu, 10 Apr 2025 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pIx3VK+e"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910941A2C3A;
	Thu, 10 Apr 2025 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744309025; cv=none; b=KY6wDX/kXw22bP5x4Pyt42DJEW53mD95fOxPQudKGIFZniBAFpl4nlgqjO0gpnSjBUt3BXK6kj9QPJPVF7Fvdqs6oH8F75X1GoaDfiqVwCsHRZDEF+xnDgmnGaQsGpoxp2mDuRHxzmRDpJYh037ze6/GiJJARyt8/dZoLbtigDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744309025; c=relaxed/simple;
	bh=9SByiyaYxXpZokL6k39yR9LfBSwxLqEDNTv8k59bHI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IC+khvHBPduaF3ZMq65Li/6euQ5kSxUCwJtyhl3lWAb2t3boX1nrBKhQ9QFPj9BFsguZTqRxTUEUoxQNn5ALfNoe5ebRqTNNGsrjxCZZWyoKhsKxQCDd5ex0IwIJv7RdhXfHnWBzR9Jj2uWu5jsALPmj5+PhuXxpdPSRD5h2Y30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pIx3VK+e; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G6ruIFczxachWDr7+JzOQRvYE6FMWu+QlZPZ9ThvFAc=; b=pIx3VK+e+SowejgxO12A3Jz1I+
	p1unV5g1g56T4GHDw0zTiOOH5BUfHWqATRNuzPUxofQ6eGYptmCoULOV3Okj3WORNPs9siL6FPwqn
	6GUkos07oR1fDzU0o2GoqGlKpuCqMxA2sLaCyY1dMYveDjCpF1wnNEgqcOwbPXXymaarmisMafZxE
	or+hQ4Kf5hn505i/r2lYO1QYH9q/tEgTlO7Cy378Vziq5DktICOOwdBRCk1LLHXqi1psNGGs1lh+H
	rbwpyasg7UanEcqSjGVoQ6D3bVOoRK9MmuaWyph/Qo9ZNgmRgJS8Fu0/aAIzwE1z2goO/ipAiKJKr
	w4zZA1ZQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49084)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u2wSI-0002Ib-2r;
	Thu, 10 Apr 2025 19:16:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u2wSF-0003nJ-13;
	Thu, 10 Apr 2025 19:16:47 +0100
Date: Thu, 10 Apr 2025 19:16:47 +0100
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
Message-ID: <Z_gLD8XFlyG32D6L@shell.armlinux.org.uk>
References: <20250409104858.2758e68e@kmaincent-XPS-13-7390>
 <Z_ZlDLzvu_Y2JWM8@shell.armlinux.org.uk>
 <20250409143820.51078d31@kmaincent-XPS-13-7390>
 <Z_Z3lchknUpZS1UP@shell.armlinux.org.uk>
 <20250409180414.19e535e5@kmaincent-XPS-13-7390>
 <Z_avqyOX2bi44sO9@shell.armlinux.org.uk>
 <Z/b2yKMXNwjqTKy4@shell.armlinux.org.uk>
 <20250410111754.136a5ad1@kmaincent-XPS-13-7390>
 <Z_fmkuPhqMqWBL2M@shell.armlinux.org.uk>
 <20250410180205.455d8488@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410180205.455d8488@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 10, 2025 at 06:02:05PM +0200, Kory Maincent wrote:
> On Thu, 10 Apr 2025 16:41:06 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > On Thu, Apr 10, 2025 at 11:17:54AM +0200, Kory Maincent wrote:
> > > On Wed, 9 Apr 2025 23:38:00 +0100
> > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:  
> > > > On Wed, Apr 09, 2025 at 06:34:35PM +0100, Russell King (Oracle) wrote:  
> 
> > > > 
> > > > With that fixed, ptp4l's output looks very similar to that with mvpp2 -
> > > > which doesn't inspire much confidence that the ptp stack is operating
> > > > properly with the offset and frequency varying all over the place, and
> > > > the "delay timeout" messages spamming frequently. I'm also getting
> > > > ptp4l going into fault mode - so PHY PTP is proving to be way more
> > > > unreliable than mvpp2 PTP. :(  
> > > 
> > > That's really weird. On my board the Marvell PHY PTP is more reliable than
> > > MACB. Even by disabling the interrupt.
> > > What is the state of the driver you are using?   
> > 
> > Right, it seems that some of the problems were using linuxptp v3.0
> > rather than v4.4, which seems to work better (in that it doesn't
> > seem to time out and drop into fault mode.)
> > 
> > With v4.4, if I try:
> > 
> > # ./ptp4l -i eth2 -m -s -2
> > ptp4l[322.396]: selected /dev/ptp0 as PTP clock
> > ptp4l[322.453]: port 1 (eth2): INITIALIZING to LISTENING on INIT_COMPLETE
> > ptp4l[322.454]: port 0 (/var/run/ptp4l): INITIALIZING to LISTENING on
> > INIT_COMPLETE ptp4l[322.455]: port 0 (/var/run/ptp4lro): INITIALIZING to
> > LISTENING on INIT_COMPLETE ptp4l[328.797]: selected local clock
> > 005182.fffe.113302 as best master
> > 
> > that's all I see. If I drop the -2, then:
> 
> It seems you are still using your Marvell PHY drivers without my change.
> PTP L2 was broken on your first patch and I fixed it.
> I have the same result without the -2 which mean ptp4l uses UDP IPV4.

I'm not sure what you're referring to.

There isn't any change for the packet offsets in your patch in
https://termbin.com/gzei

You added configuration of the PTP global config 1 register, which
is already in my patches - I was writing ~0 to that, you were writing
3. This only changes which PTP MSGID values get timestamped. I've been
trying your value of 3 here just in case it was significant.

You changed to use ptp_parse_header() (which didn't exist at the time
you took my patch) and I had already updated my patches to use when
this new helper was introduced.

The overflow_ns change you made in https://termbin.com/6a18 doesn't
apply to my code, because my code became:

        overflow_ns = BIT_ULL(32) * param->cc_mult;
        overflow_ns >>= param->cc_shift;
        tai->half_overflow_period = nsecs_to_jiffies64(overflow_ns / 2);

with overflow_ns being a u64.

I think that covers everything that has a functional change in terms
of packet parsing either by the driver or by the hardware, so I'm not
sure what problem you are referring to, or what your fix for it is -
maybe it's not in either of these two patches?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

