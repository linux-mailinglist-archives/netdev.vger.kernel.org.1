Return-Path: <netdev+bounces-111099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF68592FDCE
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 17:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DC31F225DA
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 15:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F357171079;
	Fri, 12 Jul 2024 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Su8ukl/W"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FA11802B;
	Fri, 12 Jul 2024 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720799145; cv=none; b=PTuzUgWhz1Y6Mp082bEO7nFxOhwig4OaiZKbOJurLByv8Z+j6LaPx+sns6REiLZ4m33pTpkyON1W8G7wE18i/wFmgAQQJB9FiD5tDeR0zd+iQKA4ulgHcEORdKpiPpYeRqrot5qb7/JeuYnrD/yPoKu1AxTcj8Z1QK4m/2Lk81k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720799145; c=relaxed/simple;
	bh=L2JKt6/Zlr5nDNVV0e3G0fjAh34YvW7l5yQ2teHM8ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKL0cGwWQYfwrKwdbGhmXKQRiAgfu6i21Vex904VlUnTmnvLtd4Qa2WQSw1BiuWyp4X3qwQ/lTveYQQbWYuVsSQvEE+cI5Q9zY4fao0snrLGtp59qtFPK2ySY18m1hMP2FXgPIx4ZKAAHLY5QHIKzx9mMgtBO1bGRDTJfndbrE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Su8ukl/W; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=V+hVLKlnw9flmcT/HXHKBgl0FZ5CMsd/j0BjaZpZ8mU=; b=Su
	8ukl/WTPEmSL5dqfZmLvkRyvijsIjBcyMnhJHWRxKocBTKwVt7ldFeewF1L0sxAaGY0gF8S9bg7S9
	3KOm/AloB7s2XzoRJBnTA1DXugy2IYjpxwH7YjsmQEhKtC9S+9ub+VkMrDUJo0GkA65YqWDNrIYTe
	2dl+0JPyk6T71fo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sSISe-002Psa-HP; Fri, 12 Jul 2024 17:45:28 +0200
Date: Fri, 12 Jul 2024 17:45:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?Q?Hor=E1k_=282N=29?= <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 4/4] net: phy: bcm-phy-lib: Implement BroadR-Reach
 link modes
Message-ID: <ca6a5b50-6b34-4455-bd22-cfe152df4728@lunn.ch>
References: <20240708102716.1246571-1-kamilh@axis.com>
 <20240708102716.1246571-5-kamilh@axis.com>
 <885eec03-b4d0-4bd1-869f-c334bb22888c@lunn.ch>
 <bc1ce748-7620-45b0-b1ad-17d77f6d6331@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc1ce748-7620-45b0-b1ad-17d77f6d6331@axis.com>

On Fri, Jul 12, 2024 at 05:10:48PM +0200, Kamil Horák (2N) wrote:
> 
> On 7/11/24 21:01, Andrew Lunn wrote:
> > > +static int bcm5481x_get_brrmode(struct phy_device *phydev, u8 *data)
> > >   {
> > > -	int err, reg;
> > > +	int reg;
> > > -	/* Disable BroadR-Reach function. */
> > >   	reg = bcm_phy_read_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL);
> > > -	reg &= ~BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
> > > -	err = bcm_phy_write_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL,
> > > -				reg);
> > > -	if (err < 0)
> > bcm_phy_read_exp() could fail. So you should keep the test. Also, the
> > caller of this function does look at the return value.
> True - it can at least return -EOPNOTSUPP from __mdiobus_read()
> Trying to handle it.
> 
> This neglect can be found elsewhere such as bcm-phy-ptp.c  and eg.
> bcm54xx_config_init()
> 
> function. I feel that at least the latest one should be fixed but it would
> be unrelated to bcm54811,
> 
> so leaving it as-is for now.

In general PHY drivers are a bit hit and miss with checking error
codes. If the first access works, it is very likely all further
accesses will work. If they fail, the hardware is probably dead and
there is little you can do about it other than report the error. So i
would say probe, suspend and resume should always check the error
codes, since that is where clock problems are likely to be. But after
that it is good practice to check error codes, but a driver is
unlikely to be NACKed because of missing checks.

> Done. Now we rely on the DT setting and never read the PHY state. It is
> vulnerable to external manipulation
> 
> of MDIO registers and PHY reset as both hardware and software (bit 15 of
> register 0 in both
> 
> IEEE and LRE modes) reset switch to IEEE mode.

I don't think this is any worse. With the old code you would of
silently swapped to standard IEEE modes, which cannot work. Now you
continue programming BRR registers, which just get ignored because it
is no longer in that mode.

But if somebody performed some sort of external manipulation, all bets
are off anyway. 

	Andrew

