Return-Path: <netdev+bounces-243831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9E9CA85BC
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 17:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34DE93115BED
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE983446D2;
	Fri,  5 Dec 2025 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="muioDP9O"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DFB340A73;
	Fri,  5 Dec 2025 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764949989; cv=none; b=e0Y7iq8PkiEQrrMTA1/6sM6fwiSuY0rZQ7p4soQhE2PBN+eqixUX5BY0sFqkpXRkq5UsL63GXyuqCQ23bafziNJ/bKqeRdaT2RDj4Dpesxm2r+6i16WQHH+Rw3DGu7C7m9oBEL2l9jPWoNYnV4DkVEpIdlggffPzMctKuWeNfuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764949989; c=relaxed/simple;
	bh=y2cK6IyZXZbmVrWIWWRzmGYdpXa03P9hEoJ3e8a4jTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+fYAINCVwHXKzBbj2KuefaqvGwFLM4DfspjrNn2+Yo2KoGvpcgT+8FJBApOTR0qaPRfvN45k+eyzkyHaQY1RB474EmrxwGRVxvaKox9gNiIrZkhG8ki9AU8e7/MlD35x/+lhDxK5zmfdPZIvVt4ATi9EHq6Bg2IvKXpENvnC5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=muioDP9O; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nEy4g+e2hmQgtTvRjJ0/Ped3Oy+A4kflypJV9zSX/l0=; b=muioDP9OgjxtVnfL07EqJ/SKZp
	H8N3XHTh2Mpnw5IKwvxQN1y0RjYEbXY1Vm7gdUrzWUcMjlpOxB1k+jRu3tQKB0JjhXk1CrM/qYR7E
	XevZrTczT5kooevgqjsCY6kFqA50grMBtrKwtw2zt2gcQl9o1MFx2ygzTcZcjDhaXwQvVB6eUcrKt
	gIwHfYANQB3ts279n9lObDpA8LMAR6ReDq6wt0TWoZUDhoGaBN3XJK9CNizcnZ1N8VgoLsLhkjI5o
	VIzdDekmotXqo8hNIVJ3vaHnf1IMSZp1noTSjZMB8ru0/ZExk6wnY6pulZVTIAQHK3/orFJnnGUJN
	DN7lxLJQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52206)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vRY71-000000004nv-22vz;
	Fri, 05 Dec 2025 15:52:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vRY6z-000000002EM-2RB1;
	Fri, 05 Dec 2025 15:52:49 +0000
Date: Fri, 5 Dec 2025 15:52:49 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Hauke Mehrtens <hauke@hauke-m.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net] net: dsa: mxl-gsw1xx: manually clear RANEG bit
Message-ID: <aTL_0ZHa3vggLz6z@shell.armlinux.org.uk>
References: <ab836f5d36e3f00cd8e2fb3e647b7204b5b6c990.1764898074.git.daniel@makrotopia.org>
 <97389f24-d900-4ff0-8a80-f75e44163499@lunn.ch>
 <aTLkl0Zey4u4P8x6@makrotopia.org>
 <aTL3kc1spFf3bIzf@shell.armlinux.org.uk>
 <aTL886vReHP74XPn@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTL886vReHP74XPn@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Dec 05, 2025 at 03:40:35PM +0000, Daniel Golle wrote:
> On Fri, Dec 05, 2025 at 03:17:37PM +0000, Russell King (Oracle) wrote:
> > On Fri, Dec 05, 2025 at 01:56:39PM +0000, Daniel Golle wrote:
> > > On Fri, Dec 05, 2025 at 02:45:35PM +0100, Andrew Lunn wrote:
> > > > On Fri, Dec 05, 2025 at 01:32:20AM +0000, Daniel Golle wrote:
> > > > > Despite being documented as self-clearing, the RANEG bit sometimes
> > > > > remains set, preventing auto-negotiation from happening.
> > > > > 
> > > > > Manually clear the RANEG bit after 10ms as advised by MaxLinear, using
> > > > > delayed_work emulating the asynchronous self-clearing behavior.
> > > > 
> > > > Maybe add some text why the complexity of delayed work is used, rather
> > > > than just a msleep(10)?
> > > > 
> > > > Calling regmap_read_poll_timeout() to see if it clears itself could
> > > > optimise this, and still be simpler.
> > > 
> > > Is the restart_an() operation allowed to sleep? Looking at other
> > > drivers I only ever see that it sets a self-clearing AN RESTART bit,
> > > never waiting for that bit to clear. Hence I wanted to immitate
> > > that behavior by clearing the bit asynchronously. If that's not needed
> > > and msleep(10) or usleep_range(10000, 20000) can be used instead that'd
> > > be much easier, of course.
> > 
> > Sleeping is permitted in this code path, but bear in mind that it
> > will be called from ethtool ops, and thus the RTNL will be held,
> > please keep sleep durations to a minimum.
> 
> In that sense 10ms (on top of the MDIO operation) is not that little.
> Maybe it is worth to use delayed_work to clear the bit after all...

... in which case I think you need to do a better job.

The cancel_delayed_work() in the pcs_disable() method means if we
stopp using this PCS briefly while the AN restart bit is set, there's
nothing that will clear it.

There are other implementations that have this problem. mvneta has
the same problem, but there we can write the register to set the
MVNETA_GMAC_INBAND_RESTART_AN, and then immediately write it again
without delay to clear this bit. The bit is documented as self
clearing, but practical observation indicates it never does.

Are you sure you need to wait 10ms ? What happens if you set the
bit and then immediately clear it, like we do for mvneta?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

