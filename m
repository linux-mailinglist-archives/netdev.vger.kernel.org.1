Return-Path: <netdev+bounces-153128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CF19F6ECD
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 21:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559EC169FAC
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 20:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9CB158536;
	Wed, 18 Dec 2024 20:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="trMGkvTx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CC4157E82;
	Wed, 18 Dec 2024 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734553198; cv=none; b=TPyVHrzGBMW0GTprrdBzUiPf5MkPhGWA9HtwXhG/TNnuIbSFCUnf00qsD6sMldvjGNHcKsAACYtivmpkzBUnOrSydkjwiccNpbvtwBQhmL7j7TOCOqeDoVT0kBhOzzsYxo529OE+UyHK+I6QGr7pFIfiSjf4x44XUnXGALq6mUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734553198; c=relaxed/simple;
	bh=jWzGBd0BKEuiLmx+uld7GcpzYovijF/kf5TEFJf1oco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACmlhjm1ZmaC0hiJf28Pzm0L9myK2vzMZbavARB+NZ/pRqkukye1w5Uf57hR6TzYYydwYaxZaWaUd5lOMt0UpATT7qtvxu5vjYx+fdhKCC/6JA0329QD7wh5UzgON26QO5PfRuKVT9/0rzQj+t3aHPkTQxyqCxWGF52gQeW+Cx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=trMGkvTx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lV+4t7X5XKoe8b6mNRsLV4cReA6+ap4h4QaHMnaKT1A=; b=trMGkvTxbYY4nkzXbB7P62JFCV
	dzafWnoG5u1caSJAehj5BcoWPlhJOG6a0T3b4aAKMx+YvHOKwM8/LWdx3t/sNCbBMqUe6e9z5jwoz
	VN8tvE+hOM7DlLHK1g8AA2Kz1UctROPQXjj5Blq7Lu1NrcEBbEVe/fzvwZhGOAJtQXNA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tO0WJ-001O1x-1E; Wed, 18 Dec 2024 21:19:47 +0100
Date: Wed, 18 Dec 2024 21:19:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: dp83822: Add support for PHY LEDs on
 DP83822
Message-ID: <4f40c476-565f-4f74-8cab-7250045fdd90@lunn.ch>
References: <20241217-dp83822-leds-v1-1-800b24461013@gmail.com>
 <1a7513fd-c78f-47de-94d7-757c83e9b94c@lunn.ch>
 <20241218085400.GA779107@debian>
 <c63316ac-696d-4ca9-8169-109ed1739f2a@lunn.ch>
 <20241218181752.GA792287@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218181752.GA792287@debian>

On Wed, Dec 18, 2024 at 07:17:52PM +0100, Dimitri Fedrau wrote:
> Am Wed, Dec 18, 2024 at 06:16:20PM +0100 schrieb Andrew Lunn:
> > > By the way. Wouldn't it be helpful adding a u32 max_leds to
> > > struct phy_driver ? Every driver supporting PHY LEDs validates index at the
> > > moment. With max_leds it should be easy to check it in of_phy_leds and
> > > return with an error if index is not valid.
> > 
> > I have been considering it. However, so far developers have been good
> > at adding the checks, because the first driver had the checks, cargo
> > cult at its best.
> > 
> > If we are going to add it, we should do it early, before there are too
> > many PHY drivers which need updating.
> >
> Another solution without breaking others driver would be to add a
> callback in struct phy_driver:

Adding the maximum number of LEDs to struct phy_driver will not break
anything. But we would want to remove all the tests for the index
value from the drivers, since they become pointless. That will be
easier to do when there are less drivers which need editing.

> int (*led_validate_index)(struct phy_device *dev, int index)
> It should be called in of_phy_led right after reading in reg property:
> if (phydev->drv->led_validate_index)
> 	ret = phydev->drv->led_validate_index(phydev, index);
> 
> This would solve another isssue I have. The LED pins of the DP83822 can
> be multiplexed. Not all of them have per default a LED function. So I
> need to set them up. In dp83822_of_init_leds I iterate over all DT nodes
> in leds to get the information which of the pins should output LED
> function. Using the callback would eleminate the need for copying code of
> functions of_phy_leds and of_phy_led.

Your hardware is pretty unique. It might be best to keep it in the
driver, until there is a second driver which needs the same. I also
think you need the complete configuration in order to validate it, not
each LED one by one, which your led_validate_index() would provide.

	Andrew

