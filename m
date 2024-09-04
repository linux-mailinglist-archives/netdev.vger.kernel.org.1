Return-Path: <netdev+bounces-124839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C1E96B2B0
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E9B1F28736
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8368E130ADA;
	Wed,  4 Sep 2024 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TsML5KZM"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C560B83CDB
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 07:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434436; cv=none; b=RGzCLsqe4lzpu3i8friCaU4/yA6WHmXTzIRLyAOTwip5CSvgBj4bOgQ/kdSurhQ3bhS7apZhokz320mJQ+aSiySdxO2dc29O4l7Bm+J/Edpq/k7gm3KPu9O5pJc7jlCE3hKU6KXFpqqe/02d/jUDxbAdQrABsGM3P0nLDMKbYfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434436; c=relaxed/simple;
	bh=UlnIXAtuDdzdwryGxZDI+oYa780rDwfbRyyt+jn+UYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m5U/GOez2f0UsgemsTfEia6NdFBgxTj+/M4cyelwfG/0GgVc39ePUnNeYANS6JLBC2t/bKeiZs9lG6HR2vqi/TE0AJBQDSEjvRr2fFckuCobZTjHmz+aBxy/2ZXIHyCo2zh03SnjfzaeCgjjKnWwQ/857UQVARjxwjQWWju7Xc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TsML5KZM; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 40527240005;
	Wed,  4 Sep 2024 07:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725434426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AL8g0kvVWs9hZaXw+t+uBi6VLDjjO03wPgkiircqXnI=;
	b=TsML5KZMe/GVP0/Ydhm487BI2MWZ3q8xEtx0BjFnbIp8x3q+h+pL1skRp2gcjtCar2nUYU
	qh1W4wa8Tk+fSP08i27O/lYV97MD2mkJSIyNCRgHjsUUdkduMxTwenH3he/dAXrHbvLLFl
	9dGXibHJuUlj7MQ6uNcp1/nx6//RlIOSIt7napdpfgcXiepPxdilhqwR+kNzNPc2Put/a0
	Aa0OmFC5bu5Z4rw79jx/p9SWG/sJDqKNvZfRiFT6dEw7puY0//GBuUlxeIK5Or3nZUZexB
	o7+9vC4SRzTIxEt08U+R3I4wG4zTicyW3q2PJti5OAIKzKlzdG8oyfVx+hoB5A==
Date: Wed, 4 Sep 2024 09:20:24 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, Vladimir Oltean <olteanv@gmail.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, woojung.huh@microchip.com,
 o.rempel@pengutronix.de
Subject: Re: [RFC net-next 1/2] net: ethtool: plumb PHY stats to PHY drivers
Message-ID: <20240904092024.530c54c3@fedora.home>
In-Reply-To: <20240830113047.10dcee79@kernel.org>
References: <20240829174342.3255168-1-kuba@kernel.org>
	<20240829174342.3255168-2-kuba@kernel.org>
	<20240830101630.52032f20@device-28.home>
	<20240830113047.10dcee79@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Jakub,

On Fri, 30 Aug 2024 11:30:47 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 30 Aug 2024 10:16:30 +0200 Maxime Chevallier wrote:
> > > +static void
> > > +ethtool_get_phydev_stats(struct net_device *dev,
> > > +			 struct linkstate_reply_data *data)
> > > +{
> > > +	struct phy_device *phydev = dev->phydev;    
> > 
> > This would be a very nice spot to use the new
> > ethnl_req_get_phydev(), if there are multiple PHYs on that device.
> > Being able to access the stats individually can help
> > troubleshoot HW issues.
> >   
> > > +static void
> > > +ethtool_get_phydev_stats(struct net_device *dev, struct stats_reply_data *data)
> > > +{
> > > +	struct phy_device *phydev = dev->phydev;    
> > 
> > Here as well, but that's trickier, as the MAC can override the PHY
> > stats, but it doesn't know which PHY were getting the stats from.
> > 
> > Maybe we could make so that when we pass a phy_index in the netlink
> > command, we don't allow the mac to override the phy stats ? Or better,
> > don't allow the mac to override these stats and report the MAC-reported
> > PHY stats alongside the PHY-reported stats ?  
> 
> Maybe we can flip the order of querying regardless of the PHY that's
> targeted? Always query the MAC first and then the PHY, so that the
> PHY can override. Presumably the PHY can always provide more detailed
> stats than the MAC (IOW if it does provide stats they will be more
> accurate).

I think that could work indeed, good point.

[...]

> > I'm all in for getting the PHY stats from netlink though :)  
> 
> Great! FWIW I'm not sure what the status of these patches is.
> I don't know much about PHYs.
> I wrote them to help Oleksij out with the "netlink parts".
> I'm not sure how much I convinced Andrew about the applicability.
> And I don't know if this is enough for Oleksij to take it forward.
> So in the unlikely even that you have spare cycles and a PHY you can
> test with, do not hesitate to take these, rework, reset the author 
> and repost... :)

I do have some hardware I can test this on, and I'm starting to get
familiar with netlink :) I can give it a try, however I can't guarantee
as of right now that I'll be able to send anything before net-next
closes. I'll ping here if I start moving forward with this :)

Thanks,

Maxime

