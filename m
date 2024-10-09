Return-Path: <netdev+bounces-133653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8FD9969C0
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D6EDB21282
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4CD1922DD;
	Wed,  9 Oct 2024 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5BUzL+Jt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592B518C024;
	Wed,  9 Oct 2024 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476207; cv=none; b=EodJD0J5h6ukavYkH4wsAofu6P/t2Tip9ogRi9/aijmTzzNnnFe1LS7/QqBIlIGzmS2Yn9lYEAK2yFvl4PumUMB81E+/e8kcKuxzbdVh3kDzBxTZZBydFQyKZlMSEBi6YhLtMyeo7RSEV+MNz+mloBSRaVthjdczfKY3msOU2lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476207; c=relaxed/simple;
	bh=Ekd22GoxVswK4+YZ5R6XAgJuoq2Y0V4ErL88lP9FQcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoUDwi88BBtQHQwQ5kzMKI7oWESu8zFgWnrk0gJL3OHEEIpS1sTb8aybyUfGqFsYZYzy0+jNQf6P1XVOP44vSC5L8ax65iSkA8756cAFV+Vf07bIKcU00GEd5ui+Pjob6eBTs3PAimSKfm4o6aQ64ty0sq3KqZeSDVxOdgQ94kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5BUzL+Jt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=34kWFpg00FJJRDKeTtvdBzFE+0mODfI3Gmdv1o72FJU=; b=5BUzL+JtekbRt18vrglN1wrnkI
	wqZ0P1QO+0KrQNqZ6G5BdQfJvQ56Evyt3TvNExZT2YCtdExPE0RH4nIRxM9HS/SCG5IhXKeqJj4P9
	sG8T8As5yB+Tenbm6Ncf4mjUY0pEwOT8K2Lh88EKADlFwxeTV3o8/3nuYzPWeGkSe8Xw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syVcD-009UbJ-Us; Wed, 09 Oct 2024 14:16:29 +0200
Date: Wed, 9 Oct 2024 14:16:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: intel-xway: add support for PHY LEDs
Message-ID: <bc9e4e95-8896-4087-8649-0d8ec6e2cb69@lunn.ch>
References: <c1358e27e3fea346600369bb5d9195e6ccfbcf50.1728440758.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1358e27e3fea346600369bb5d9195e6ccfbcf50.1728440758.git.daniel@makrotopia.org>

> +static int xway_gphy_led_polarity_set(struct phy_device *phydev, int index,
> +				      unsigned long modes)
> +{
> +	bool active_low = false;
> +	u32 mode;
> +
> +	if (index >= XWAY_GPHY_MAX_LEDS)
> +		return -EINVAL;
> +
> +	for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
> +		switch (mode) {
> +		case PHY_LED_ACTIVE_LOW:
> +			active_low = true;
> +			break;
> +		case PHY_LED_ACTIVE_HIGH:
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return phy_modify(phydev, XWAY_MDIO_LED, XWAY_GPHY_LED_INV(index),
> +			  active_low ? XWAY_GPHY_LED_INV(index) : 0);

This does not appear to implement the 'leave it alone' option.

	Andrew

