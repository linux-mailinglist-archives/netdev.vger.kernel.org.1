Return-Path: <netdev+bounces-205512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078A7AFF010
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 19:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27043A55F9
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F083522FDFF;
	Wed,  9 Jul 2025 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tbhZoaNA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7120822D9E3;
	Wed,  9 Jul 2025 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752082947; cv=none; b=j6SK4UdnrWevHKsAH6VVXvif1zLatJp3gngXVvf8Y6r0/vY8GKr/VcpbF55iGouZN/KB8D5ZvhSJjRzI1Xzzqmgcpsyf1iGUVntfEgyu1u1fpgMIB5+Phls8iwvTtGPqmU5X328g9rE/4oXtEXWr8vkvy6kMW6ieDZQ9/up50eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752082947; c=relaxed/simple;
	bh=L/bU3Vjvhst8h5Zlf/0Herx+Z0zUver5++nZF9RW5Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BT4Y5L34RpPzvviMbrVYBrURC1KEZAV7tmlKUbK61gXxbc1E8cxNC+1b+fp4Wi8MeU0iTdqMe1tpT29VGW0vEzhNSHpqCS73ADlA1RrvYhQopbX4ojhqZTOgRe3K8KKT85T/o9j6lsNfJHAEDjX09r9vub/ismKXmKIC9u3apMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tbhZoaNA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9JNMjRDCMIHa+Po0H1LYj8KqoI3Jfy0hutL9Xpr7pSU=; b=tbhZoaNAh9WyeIfezPzjBJKpAf
	jyvVdnsDK+o+tp55I7V65vC8T5Cl8sjTg6iLu1L6Nu+zrJj5U80bQv9AwD4+7dY0PsPAOwIafbpOh
	TIiGkLQFVw5dJwNeWWmUsj103sFDE2EN26yOUWNQmMzvprLx4/Lxxq2hn1IuCzcKLwxdhetx0QJ1X
	djzSN/MMoqkGr8IPalFPJYpD7lGFfccg1bd+654QLcIVLFjZEwnSJWze1InOSEa8Z5925YX4TToUy
	MhZQF6JqWQ+/jsQS/gN4G779mK07e4zaL5ZPDaWUHyqrvaCPgJRNmDNsoKBxm/g1wB1CmIShjP/M2
	xKv4TjyA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56254)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uZYo3-0008JZ-0r;
	Wed, 09 Jul 2025 18:42:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uZYnv-0002pD-1X;
	Wed, 09 Jul 2025 18:41:59 +0100
Date: Wed, 9 Jul 2025 18:41:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: lizhe <sensor1010@163.com>
Cc: Andrew Lunn <andrew@lunn.ch>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, vladimir.oltean@nxp.com,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: Re: Re: [PATCH] net: stmmac: Support gpio high-level
 reset for devices requiring it
Message-ID: <aG6p5_p9CmqxZcxM@shell.armlinux.org.uk>
References: <20250708165044.3923-1-sensor1010@163.com>
 <52b71fe7-d10a-4680-9549-ca55fd2e2864@lunn.ch>
 <5c7adfef.1876.197ece74c25.Coremail.sensor1010@163.com>
 <aG3vj1WYn3TjcBZe@shell.armlinux.org.uk>
 <5bb49dc0.6933.197ee28444e.Coremail.sensor1010@163.com>
 <aG5ORmbgMYd08eNR@shell.armlinux.org.uk>
 <4cfb4aab.9588.197eefef55f.Coremail.sensor1010@163.com>
 <aG582lPgpOr8oyyx@shell.armlinux.org.uk>
 <2352b745.a454.197efeef829.Coremail.sensor1010@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2352b745.a454.197efeef829.Coremail.sensor1010@163.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jul 10, 2025 at 12:05:05AM +0800, lizhe wrote:
> Hi，
> 
>      
> 
>   if i add the following code to this function, the gpio outputs a high level
> 
>   without this code, it outputs a low level, 
>   the function currently drivers the reset GPIO to a low state, failing to account 
> 
>   for devices requiring an active-high reset.
> 
> 
> 
> 
>   i invited our hardware engineer to  measure the voltage level on this GPIO pin,
> 
>   without  adding this code, the voltage at this GPIO pin remains at 0V
> 
> 
> 
> 
>   +             int current_value;
> 
> 
> 
> 
>   +             keep_high = device_property_read_bool(priv->device,
> 
>   +                                                             "snps,reset-keep-high");
> 
>   +              if (keep_high) {
> 
>   +                     gpiod_set_value_cansleep(reset_gpio, 1);
> 
>   +                      current_value = gpiod_get_value_cansleep(reset_gpio);
> 
>   +                      pr_info("current_value: %d\n", current_value);
> 
>   +              }
> 
>    in the RK3588 system, i am using ,there are many DTS node configured link this:
> 
>     snps, reset-gpio = <&gpioX RK_PXX GPIO_ACTIVE_HIGH>;   
>     All of them correctly parse the GPIO pin's state are described in the DTS
> 

I'm wondering at this point whether the problem here is one of
mis-understanding the engineering terminology. Look at the below
using a fixed-width font:

Active-high reset: _____/^^^^^^^^\____

Active-low reset:  ^^^^^\________/^^^^

                        | reset  |
			|asserted|

So, an active high reset needs to be logic low in order for the
device to function. An active low reset needs to be logic high
for the device to function.

You seem to be wanting to tell the kernel that you have an
active high reset, and expect it to be logic high when you
want it to be active. That is *not* an active high reset.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

