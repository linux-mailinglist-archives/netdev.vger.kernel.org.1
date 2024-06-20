Return-Path: <netdev+bounces-105365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D26910D51
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 18:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952D0286EDD
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9931B1420;
	Thu, 20 Jun 2024 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjPJZ7a+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C781AD4B9;
	Thu, 20 Jun 2024 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901709; cv=none; b=ugLqtmNV4p1eHnLEIULF1R0D8vTyhdZlMxcKf/OlsDBq8p0TImzsbyyb7J3mPxEPv/idlPBx9qyY040cKNDQa5P8WIJIITwFL0/zVYvXOXYXlP2wYbTNxEwm3Ki/sXJWWasWuDK7SuNBB96APK9vtNl3H7uW7LLhiLSoyTAKR3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901709; c=relaxed/simple;
	bh=JbcfIOO5HqOQfYsdak5ItbpLoQQ6woDUCr1zHls2zpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEODgi4SVZ4cAqZeGLrHxT9WMuPKmeHgYHZ9SGdaJADPnF4NorDn/bOnvygMJmnLjnhWdo6X+SMvrWY0LlJzYhZAuLu21+tIIVjxNwlP5WgxfZALa4UPKTPPdQeoLTV7SlO1MeB6XmsUnE26qeJMrE7AVHtzP+wAvL0OkcVFpD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjPJZ7a+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF95C2BD10;
	Thu, 20 Jun 2024 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718901709;
	bh=JbcfIOO5HqOQfYsdak5ItbpLoQQ6woDUCr1zHls2zpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BjPJZ7a+4rnATZyDn2NDQG5PEIpapGxvOa3AftMhhDUWH9FV5KkRjwyYpicPKO4tu
	 uCtc1RLALs+nAboIpnk2hziGg2Uw7DSdP08oOJk0lx38nJry96QgMcDVmQsqTAiruB
	 jN5vtzrHwTL003vZHDXmF67BOb4tjZtYidfxeNdbwnPkZDymYeyeLXwQwsjBKn3n9h
	 Dos8W2geWIZbgu30MHms8WzRO8vgZ9gGrPKKzOLpKcCbRLJUMWYbweXnTbTf1Omdo8
	 /+QCgPrcFMIq2oBnuY+KMZWQPadAiJrwGSdD0rrqqDDlQjkqjf6b4I8ZsytoobrKz0
	 Ju7ABqk0DesLA==
Date: Thu, 20 Jun 2024 17:41:43 +0100
From: Simon Horman <horms@kernel.org>
To: "Karumanchi, Vineeth" <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@armlinux.org.uk, vadim.fedorenko@linux.dev, andrew@lunn.ch,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH net-next v6 3/4] net: macb: Add ARP support to WOL
Message-ID: <20240620164143.GL959333@kernel.org>
References: <20240617070413.2291511-1-vineeth.karumanchi@amd.com>
 <20240617070413.2291511-4-vineeth.karumanchi@amd.com>
 <20240618105659.GL8447@kernel.org>
 <616a10c5-9c72-4221-a181-6251e808b9b8@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <616a10c5-9c72-4221-a181-6251e808b9b8@amd.com>

Hi Vineeth,

On Thu, Jun 20, 2024 at 09:29:01PM +0530, Karumanchi, Vineeth wrote:
> Hi Simon,
> 
> On 6/18/2024 4:26 PM, Simon Horman wrote:
> > On Mon, Jun 17, 2024 at 12:34:12PM +0530, Vineeth Karumanchi wrote:

...

> > > @@ -5290,6 +5289,14 @@ static int __maybe_unused macb_suspend(struct device *dev)
> > >   		macb_writel(bp, TSR, -1);
> > >   		macb_writel(bp, RSR, -1);
> > > +		tmp = (bp->wolopts & WAKE_MAGIC) ? MACB_BIT(MAG) : 0;
> > > +		if (bp->wolopts & WAKE_ARP) {
> > > +			tmp |= MACB_BIT(ARP);
> > > +			/* write IP address into register */
> > > +			tmp |= MACB_BFEXT(IP,
> > > +					 (__force u32)(cpu_to_be32p((uint32_t *)&ifa->ifa_local)));
> > 
> > Hi Vineeth and Harini,
> > 
> > I guess I must be reading this wrong, beause I am confused
> > by the intent of the endeness handling above.
> > 
> > * ifa->ifa_local is a 32-bit big-endian value
> > 
> > * It's address is cast to a 32-bit host-endian pointer
> > 
> >    nit: I think u32 would be preferable to uint32_t; this is kernel code.
> > 
> > * The value at this address is then converted to a host byte order value.
> > 
> >    nit: Why is cpu_to_be32p() used here instead of the more commonly used
> >         cpu_to_be32() ?
> > 
> >    More importantly, why is a host byte order value being converted from
> >    big-endian to host byte order?
> > 
> > * The value returned by cpu_to_be32p, which is big-endian, because
> >    that is what that function does, is then cast to host-byte order.
> > 
> > 
> > So overall we have:
> > 
> > 1. Cast from big endian to host byte order
> > 2. Conversion from host byte order to big endian
> >     (a bytes-swap on litte endian hosts; no-op on big endian hosts)
> > 3. Cast from big endian to host byte oder
> > 
> > All three of these steps seem to warrant explanation.
> > And the combination is confusing to say the least.
> > 
> 
> tmp |= MACB_BFEXT(IP, be32_to_cpu(ifa->ifa_local));
> 
> The above snippet will address above points.
> Consider the ip address is : 11.11.70.78
> 
> 1. ifa->ifa_local : returns be32 -> 0x4E460b0b
> 2. be32_to_cpu(ifa->ifa_local) : converts be32 to host byte order u32:
> 0x0b0b464e
> 
> There are no sparse errors as well.
> I will make the change, please let me know your suggestions/thoughts.

Thanks for your response, your proposal looks good to me.


