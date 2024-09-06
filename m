Return-Path: <netdev+bounces-125933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5352796F4D8
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4061B1C22B6D
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF741CBEBC;
	Fri,  6 Sep 2024 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4m52fepH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8521CB14E;
	Fri,  6 Sep 2024 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627470; cv=none; b=Xk7td164dEWvFxbLO1zV6JLtY1lezgJ3buNoW4Sws7kJvL1fomi3eROKg61AZLDVLU9ZTjJ9/xBgghvEblnyewFE/FG1lJWKU24BLY+LPKe3AaIvpduwTxsS7HEQ8ihiWV9pRFF6sUPva7O6Tm01bbwrz2hfQ6oFv2EmgkR9EoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627470; c=relaxed/simple;
	bh=/2FtnWCHaPjHsUcPxHXdI1VpOC7eip5BSxs8aBELA+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZE42o7GRPqjyMxIAEELaxOPwGR+FT3wrawGUhY75UwIjcVCr3Z3S7WI6dV6s1pFVRk84IHY2nj0dXtDnY5z/3GRBw5cRNDEFlXVaOqK1jryxfGZ3GVo42zuqxPJQy6kXh40sDKTVe/YiKDlRPH0icEPYQYZ3yMTeZ/fjgp1Go9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4m52fepH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZZLMqGWTh9m7ksvTShRd1ZBjtLKzyMJggprBHSOKla0=; b=4m52fepHMFB4fqS/495CWIdz34
	F2NPjaqbz1BohSs+cIe8xG8HumG+uZUFaCToIdb3k6bOXXTxfSzDI/aOTl2jktjcQmc6K5KJeVe6u
	/+iH8rTx/w/9tAlCsNUOAhoV7/I4DTl8VYSD1U6VugZu5JTaXS8UQ6y7zH+1CW1ebczI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smYWt-006oLc-Li; Fri, 06 Sep 2024 14:57:35 +0200
Date: Fri, 6 Sep 2024 14:57:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tarun.Alle@microchip.com
Cc: Arun.Ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: microchip_t1: SQI support for LAN887x
Message-ID: <af78280b-68a5-47f4-986e-667cc704f8da@lunn.ch>
References: <20240904102606.136874-1-tarun.alle@microchip.com>
 <dba796b1-bb59-4d90-b592-1d56e3fba758@lunn.ch>
 <DM4PR11MB623922B7FE567372AB617CA88B9E2@DM4PR11MB6239.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB623922B7FE567372AB617CA88B9E2@DM4PR11MB6239.namprd11.prod.outlook.com>

> > How long does this take?
> > 
> 
> ~76ms

That is faster than i expected. You have a pretty efficient MDIO bus
implementation.

> > genphy_c45_read_link() takes a few MDIO transaction, plus the two you see
> > here. So maybe 1000 MDIO bus transactions? Which could be
> > 3000-4000 if it needs to use C45 over C22.
> > 
> > Do you have any data on the accuracy, with say 10, 20, 40, 80, 160 samples?
> >
> 
> Here number of samples are suggested by our compliance test data.
> There is an APP Note regarding SQI samples and calculations.
> No, the number of samples are only 200 as any other count was not
> consistent in terms of accuracy.
>  
> > Can the genphy_c45_read_link() be moved out of the loop? If the link is lost, is the
> > sample totally random, or does it have a well defined value? Looking at the link
> > status every iteration, rather than before and after collecting the samples, you are
> > trying to protect against the link going down and back up again. If it is taking a
> > couple of seconds to collect all the samples, i suppose that is possible, but if its
> > 50ms, do you really have to worry?
> > 
> 
> 
> Sampling data is random. If the link is down at any point during
> the data sampling we are discarding the entire set.
> If we check the link status before and after the data collection, there could
> be an invalidate SQI derivation in very worst-case scenario.
> 
> Just to improve instead of register read can I change it to use phydev->link variable?
> This link variable is update by PHY state machine.

Which won't get to run because the driver is actively doing SQI. There
is no preemption here, this code will run to completion, and then
phylib will deal with any interrupts for link down, or do its once per
second poll to check the link status.

With this only taking 76ms, what is the likelihood of link down and
link up again within 76ms? For a 1000BaseT PHY, they don't report link
down for 1 second, and it takes another 1 second to perform autoneg
before the link is up again. Now this is an automotive PHY, so the
timing is different. What does the data sheet say about how fast it
detects and reports link down and up?

	Andrew

