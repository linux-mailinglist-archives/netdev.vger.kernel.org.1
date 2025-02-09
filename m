Return-Path: <netdev+bounces-164517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 059A2A2E179
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 00:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5017418843CA
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 23:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3051E4928;
	Sun,  9 Feb 2025 23:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X1pdPiu2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7341E04B5;
	Sun,  9 Feb 2025 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739144012; cv=none; b=GHBma2vwoDZhIf/i8bS3yoZHHc+fscuxXEIX33VcLJaJ5R2JxLSiYa9q4fhCjBDIaB/pSqzx1GITFL7hG12Xwr1t05k45I1h/MWRBYUE6PwbMlAcdPreyPNfzBgYknfYSCTUpCRf3Ac7rbyDyYXUEY/DrHT5G5ylddQsVOBqH34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739144012; c=relaxed/simple;
	bh=mzjCf111KOEU50w+Xi7gNyvxax+8EWxZ0+XHz1jAM94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRlrqVChZcK3YQIzDAyKkr77LpsHXIpABuOTaqnVX0dsyJNnb/zo1VL/wWPoHuUcYdsWt5kQXcFNoCzmprbHOI3WE4egA12o2KthwQy9C4Udk1x8HKa0/Q+Y77Y2F73oSuftqk95LD9sZc3BkwwEMhy6UjO1Gprp6YZWo98cwic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=X1pdPiu2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aBt4WhTEfMb2t+mK3gXY4zMR0Yzsnr4lWWL9x6tMiaA=; b=X1pdPiu2LKY6R/RmeXbXsFzMYq
	VNfwYaC+OsN3t0zLqhbCRIoldKlN/272AN4ZYOF41aBp1mcmQJaa4xrKX5vhxsre7f+KOqxFFMvRa
	25zBOABddUIZd6y9sruABTEYTIb/AhuLd3SIYppBLZw0V8PP4VnoibvQcEHYvF1S8J20=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1thGnj-00CXUA-32; Mon, 10 Feb 2025 00:33:23 +0100
Date: Mon, 10 Feb 2025 00:33:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] net: phy: Add support for
 driver-specific next update time
Message-ID: <1d7b8949-5b37-49c8-9407-298cc4997dff@lunn.ch>
References: <20250206093902.3331832-1-o.rempel@pengutronix.de>
 <20250206093902.3331832-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206093902.3331832-2-o.rempel@pengutronix.de>

> +++ b/include/linux/phy.h
> @@ -1273,6 +1273,19 @@ struct phy_driver {
>  	 */
>  	int (*led_polarity_set)(struct phy_device *dev, int index,
>  				unsigned long modes);
> +
> +	/**
> +	 * @get_next_update_time: Get the time until the next update event
> +	 * @dev: PHY device which has the LED

LED ?

	Andrew

