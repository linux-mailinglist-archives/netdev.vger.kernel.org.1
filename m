Return-Path: <netdev+bounces-154827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 163D89FFE23
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F2416197D
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE5618F2FD;
	Thu,  2 Jan 2025 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yYgJxp3U"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327A62114;
	Thu,  2 Jan 2025 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735842524; cv=none; b=J/zvNjEJfq9biZl5s6f5cC8DUQMPTffpSr+VMfKXXGPc0xHYlK6l8AfHAkjil4u5yqTRJPy5t9gXnPqqnEDJ7lnnIr02n2+Y5MjT68/+ZuhO9b3lvDbX4fRTajy+9PI8LBRUSlwMGcvF9rPopRJe2HBW4TeT+WwVYep2cJgW1Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735842524; c=relaxed/simple;
	bh=hcNUR2oevSHlDg7p90wSbtprvFqp0at8SHKVYOtIR0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUICATGI9/EG9UvmNr/ZiOKbafcKlIR+/59ocxCcTrniC1ue2RjbxPRGn89cRKiBrcxpijDOsKenyMuggbOOIH1iz2DBX0WTtDmqCxi0QDXy9vb6e9DL/OxQy9BBfzt79WKi9woCLOY6+Z3pzEb9sYiU13uiJt1VKSatCsQyIC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yYgJxp3U; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=It1pIuzXXjaoHWAah3S1bbwQ/XzdNgxVc9Nj989B/0A=; b=yYgJxp3UHzE1HCMzXuaRpMTSuG
	0ZsSzPo52ovb168QOFTHnjUXSiXvePHovCmVFLSxcf4iNR01pqUCPENHuMYCX9BejwB3/ZFi/Gsxt
	NJrX3Mc8C/F5tHQ1Wxbm+fTqzpcb7Hk+qZn1pjkEM9XisWPZCTc0zhBhnmTenah97UudizuS6bBnC
	sGxuCDHf3DVX8edeHt6NecGkTANb883BX/GDPwNMayUoIF6JYbq27a2QvHP753dhb/IxMlT1UB5fS
	zXV4E9naJxQkG/H+0bk9s0Fk2i0wQknUIqfxlAH1TBLc4vK8ze2LBXACqCjEIInbE+kk5cvnQWZBG
	8RSSRdRg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37086)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tTPvs-0002Hy-02;
	Thu, 02 Jan 2025 18:28:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tTPvq-0000Uo-0q;
	Thu, 02 Jan 2025 18:28:30 +0000
Date: Thu, 2 Jan 2025 18:28:30 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: Move callback comments from
 struct to kernel-doc section
Message-ID: <Z3bazqZkXwVqJ8Nf@shell.armlinux.org.uk>
References: <20241206113952.406311-1-o.rempel@pengutronix.de>
 <e6a812ba-b7ea-4f8a-8bdd-1306921c318f@redhat.com>
 <Z1hJ4Wopr_4BJzan@shell.armlinux.org.uk>
 <20241210063704.09c0ac8a@kernel.org>
 <Z2AbBilPf2JRXNzH@pengutronix.de>
 <20241216175316.6df45645@kernel.org>
 <Z2EO45xuUkzlw-Uy@pengutronix.de>
 <Z3bFWDjtGNqSGfdD@shell.armlinux.org.uk>
 <87seq1xffx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87seq1xffx.fsf@trenco.lwn.net>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 02, 2025 at 11:01:54AM -0700, Jonathan Corbet wrote:
> "Russell King (Oracle)" <linux@armlinux.org.uk> writes:
> 
> > This is the fundamental problem with kernel-doc, when it's missing
> > something that really should already be there. It's not like we're
> > the first to use function pointers in structs - that's a thing that
> > the kernel has been doing for decades.
> 
> Unfortunately, kernel-doc is a gnarly collection of Perl regexes that
> first appeared in 2.3.52pre1 some 25 years ago and has only grown more
> gnarly since.
> 
> > I also have no desire to attempt to fix kernel-doc -
> 
> Neither does anybody else.  There are a few of us who will mount an
> expedition into those dark woods on occasion to fix something, but there
> is little desire on any part to make significant improvements, including
> adding things that should already be there.  It's just barely
> maintainable.
> 
> The proper solution is to reimplement kernel-doc in a language that
> people actually want to deal with, cleaning out 25 years of cruft in the
> process.  One way to do that would be to bring that functionality
> directly into our Sphinx extension, rewriting it in Python.  An
> alternative I have been considering, as a learning project that would
> make me One Of The Cool Kids again, would be to do it in Rust instead.
> 
> For the time being, though, I wouldn't hold my breath for getting this
> kind of improvement into kernel-doc.  I wish I could say otherwise.

Right, so we're at logger-heads. Someone needs to give.

Either:

1) kernel-doc gets fixed

2) we accept that we have to work around kernel-doc to decently document
   function pointers, and while it may not be great, it gives _full_ and
   complete documentation of the function pointer.

3) we don't document function pointers at all (which leads to users not
   having something to read when implementing those methods, and
   reviewers having to post boiler plate explanations of the function
   pointers when reviewing patches... or just give up with trying to
   get people to implement the methods sanely.)

I'll leave it to others to decide which they want to do, but I'm
intending to continue with (2) for phylink, because I believe that has
the most benefit to the community, even though it is sub-optimal.

If one looks at:

https://kernel.org/doc/html/v6.13-rc5/networking/kapi.html#c.phylink_mac_ops

then one can see there is a _heck_ of a lot of valuable detail
documented against each of the function pointers - and I have no
intention what so ever to get rid of that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

