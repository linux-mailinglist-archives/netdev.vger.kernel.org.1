Return-Path: <netdev+bounces-190400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEA6AB6B70
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793021B674E7
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 12:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4774225DCF9;
	Wed, 14 May 2025 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sfQBRVSE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD37A221DA8;
	Wed, 14 May 2025 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747225952; cv=none; b=bluty4zZiObwS6BLECXRCaqgH4mw6vbCR5A64c7heWx9c74CyQLLeGi6brHs+qOQ6wk5PYezQlQLigFwnsUnQGJ8xN3mpwCkBIfqqd2j3BJeKdJs1yrFZJEVaXjlLy92D+QxKWzWPthXzpbZ+HHCn/W4R0kRfJS88bfqIOVX1Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747225952; c=relaxed/simple;
	bh=Z8rWqmEeIhKOeg5WnbJTJ1nlK62kAGElSJntAPIs1HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnMAi4bAOBpWYHEQcRkYpKI8sjmiQ1v3o58vuRqi8ar4TkQd0Qaiao/cim4FxmT14c45sT0NGMJdt0axln4bvWvG94OjyLIdywFsCvJGPhtq35kHgsdJ91C6O8yTNiQlHkMQ8ev1is41dEDAnO786IR3kTGIrmN+nte0uagOa4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sfQBRVSE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uDwLgd+Z6XGpTs5pSaKr4FEc8F6bbnZj3fd00cER8iI=; b=sfQBRVSEgzQ8RdcQDQKi1IKsFl
	v55r/BUpQMY5On+vwc5ab6J5/pOkY0clFIoXVFd79ra7QjUNawEI+keqims4GECSz33g/nbtDUvLn
	em339XfuQ/J/M58nC95GIlvXQVCeRywEIuivtAa065laZlO4bgy1D60/j4KhgZc3b6Vs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uFBHa-00CYfE-83; Wed, 14 May 2025 14:32:22 +0200
Date: Wed, 14 May 2025 14:32:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Antoine Tenart <atenart@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: phy: dp83869: Support 1000Base-X SFP
 modules
Message-ID: <519e17e0-9739-43bc-b77a-a77fd103d8d7@lunn.ch>
References: <20250514-dp83869-1000basex-v1-0-1bdb3c9c3d63@bootlin.com>
 <20250514-dp83869-1000basex-v1-3-1bdb3c9c3d63@bootlin.com>
 <3iyvm6curoco35xuyos5llxvnvopvphl5cnndaacg2v5jiu3l7@aaic3jfqhjaz>
 <4702428.LvFx2qVVIh@fw-rgant>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4702428.LvFx2qVVIh@fw-rgant>

> > > +	/* Update advertisement */
> > > +	if (mutex_trylock(&phydev->lock)) {
> > > +		ret = dp83869_config_aneg(phydev);
> > > +		mutex_unlock(&phydev->lock);
> > > +	}
> > 
> > Just skimmed through this quickly and it's not clear to me why aneg is
> > restarted only if there was no contention on the global phydev lock;
> > it's not guaranteed a concurrent holder would do the same. If this is
> > intended, a comment would be welcomed.
> 
> The reasoning here is that there are code paths which call 
> dp83869_port_configure_serdes() with phydev->lock already held, for example:
> 
> phy_start() -> sfp_upstream_start() -> sfp_start() -> \
> 	sfp_sm_event() -> __sfp_sm_event() -> sfp_sm_module() -> \ 
> 	sfp_module_insert() -> phy_sfp_module_insert() -> \
> 	dp83869_port_configure_serdes()
> 
> so taking this lock could result in a deadlock.
> 
> mutex_trylock() is definitely not a perfect solution though, but I went with it
> partly because the marvell-88x2222 driver already does it this way, and partly 
> because if phydev->lock() is held, then there's a solid chance that the phy 
> state machine is already taking care of reconfiguring the advertisement. 
> However, I'll admit that this is a bit of a shaky argument.
> 
> If someone has a better solution in mind, I'll gladly hear it out, but for now 
> I guess I'll just add a comment explaining why trylock() is being used.

The marvell10g driver should be the reference to look at.

As you say, phy_start() will eventually get around to calling
dp83869_config_aneg(). What is more interesting here are the paths
which lead to this function which don't result in a call to
dp83869_config_aneg(). What are those?

	Andrew


