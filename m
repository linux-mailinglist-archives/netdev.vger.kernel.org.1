Return-Path: <netdev+bounces-242333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6786EC8F4A6
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79A7A4E6C85
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 15:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516D8335071;
	Thu, 27 Nov 2025 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GxMPXrqH"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C584336ECB
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257526; cv=none; b=bCFMQhOqaKnmQGu6t4gCfo4FaN/lZ9AjrfTfNgKSf/48Ylx7BO20UoDRgKgWZT/zCX400XC4h+h9llvj1yFwoQMRSgW3lzx9lodx/9UUgWvV6yRJJ1rL3CA93CJd8JrPzAes9ww3tTHBrCmDD25C4r1WD2vf3U39K2Cmt3MFINY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257526; c=relaxed/simple;
	bh=msSHSGXp3D+r4I+P0AjK3CWDZIQ8kBRUoWWzV5LiEPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eg6pFsXKskTc94tomCz/709tuGk37eDn9o6QiaA8gcJCzhQL5wOv8yKKLNor2pbQ63R2T/Z4gEHeIfMdSo8+H8jwSpEWaa0YVksS7CdqzKZ23S9LZ2bDPFwjdiqcg0hw41EKpx/NEAIUaevlF2YdDlRPYrMvmJkGLRk9s0HrLUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GxMPXrqH; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 103124E418E4;
	Thu, 27 Nov 2025 15:32:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D55DA6068C;
	Thu, 27 Nov 2025 15:32:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F3F42102F218C;
	Thu, 27 Nov 2025 16:31:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764257520; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=z7kzfN+4IxIUJeJ9Y0UHWxqVlHfeGyKEeyN9o3GqdiI=;
	b=GxMPXrqHi724S3YP2geSWgKAplg4FeCODlTaR9T3NHBGGNNkmtjkDOUmGzEfurMVfjCa3e
	b1uSM9PWFwXpK6j9zzBhKgiQEorqV1y9aZpTp9j4TmNq1kzjcXlUbi9oDJc9oGGJIJFtvu
	legmP0ntO52XJVJB2r5vmSjEhAah6aPuqAj/xKTz7dWuh6x7rn8Ggwr7mXrYcFIwjeMu4R
	dWzxToUA5EPtmLGjKqLs24NB/0g6vIf04bI8KmMuyfRgH9SYU56SEMVuFvxvl1lmpdA2RP
	3v/ph7NnvgRzaEHUwnsFW3zjafgDqHF8hLzeQxTMpANvTishuhYmqEwJPPUnLQ==
Message-ID: <c14b1dae-142e-4038-92a9-cfcad492f4e2@bootlin.com>
Date: Thu, 27 Nov 2025 16:31:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 1/1] Documentation: net: add flow control
 guide and document ethtool API
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Alexei Starovoitov <ast@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Eric Dumazet <edumazet@google.com>, Rob Herring <robh@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Jonathan Corbet <corbet@lwn.net>,
 John Fastabend <john.fastabend@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Divya.Koppera@microchip.com, Kory Maincent <kory.maincent@bootlin.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 Sabrina Dubroca <sd@queasysnail.net>, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Heiner Kallweit <hkallweit1@gmail.com>
References: <20251119140318.2035340-1-o.rempel@pengutronix.de>
 <20251125181957.5b61bdb3@kernel.org> <aSa8Gkl1AP1U2C9j@pengutronix.de>
 <20251126144225.3a91b8cc@kernel.org> <aSgX9ue6uUheX4aB@pengutronix.de>
 <7a5a9201-4c26-42f8-94f2-02763f26e8c1@lunn.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <7a5a9201-4c26-42f8-94f2-02763f26e8c1@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrew

I am sorry, I have a bit of sidetracking...

>> State Persistence and Toggling When toggling autoneg (e.g., autoneg on -> off
>> -> on), should the kernel or driver cache the previous advertisement?
> 
> This has been discussed in the past, and i _think_ phylink does.
> 
> But before we go too far into edge causes, my review experience is
> that MAC drivers get the basics wrong. What we really want to do here
> is:
> 
> 1) Push driver developers towards phylink

Is it something we should insist on in the review process ? Can we make
it a hard requirement that _new_ MAC drivers need to use phylink, if the
driver plans to interact with a PHY ?

phylink has long outgrown the original use-case of supporting SFPs by
abstracting away the MAc to [PHY/SFP] interactions, it's now used as a
an abstraction layer that avoids MAC drivers making the same mistakes
over and over again on a lot of cases that don't have anything to do
with SFP.

I think we can no longer really say "If your driver is simple enough,
you can stick to using phylib directly", at least not for new drivers,
as phylink now simplifies EEE, WoL, Pause, etc.

> 2) For those who don't use phylink give clear documentation of the
>    basics.
> 
> We can look at edge cases, but i would only do it in the context of
> phylink. Its one central implementation means we can add complexity
> there and not overload developers who get the basics wrong.
> 
> 	Andrew

Maxime

