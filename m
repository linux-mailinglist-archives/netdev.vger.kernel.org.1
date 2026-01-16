Return-Path: <netdev+bounces-250526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5873D31A52
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FDE0300B828
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 13:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FBC23ABB0;
	Fri, 16 Jan 2026 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1PKvHjJr"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A37518872A
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569295; cv=none; b=P+tHqfTRkaxZTVY7smHc4+zLY7ajtUhbch3IvRmJr3tjGrPBgEw+Yf/ufpmddBAmhBneEwMDLKIxdfIg+h+VYCSj3uREX8oUQf0R0VYZeduBRDY5s/RjKDPkJQWBfmEmQyUCSDhAaafDKjCZyYWf1nyfrH0P02/mFtFcm8Gfn1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569295; c=relaxed/simple;
	bh=R/B/Q+5wV793Mx3vY7d2Ino5SxUriravyn7S9YyBnWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1EpRSnPSVhC28KqC1aS715gPhBdtQrXN3O6JXv8owcmrvIgxYO48EnzPcfQ5V8bbB+ohD+lev6zyja1Cw1PIJYNb9VUqs5ahyPssTrJ8CBLnkUsajTwIOZ66md9OnA+yXDVD0sQeXYF1alyD9X2eLFDHLY4Lromd261DfSHlhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1PKvHjJr; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 152DA1A28C1;
	Fri, 16 Jan 2026 13:14:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DE29360732;
	Fri, 16 Jan 2026 13:14:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5FCCC10B68B1E;
	Fri, 16 Jan 2026 14:14:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768569291; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=sCXTWYnyvPFHKd3Uq1BGbQKBy+EJl7kipDxPHG/vX8s=;
	b=1PKvHjJrfc4l4unmplNOazPPWEocsWhtbnHWKArIjbJuwhDJ/AZ4+Lhz/hFo7+zmezjd4g
	1q4ucABdM7Z+HJ6/OOyLbTmbZ48+l6gJt2St2Skhuci+DxKLnnSl0cloWGdXgCsKhAgj2R
	yOfMHFAIMct9UZgKS/rMygUmyCWmxfeey43JqU2zhlMEcDPF+tldVuBrgToh7epK7qzOtE
	zE5/D7bcEb78/J7lczUDcgkpgr0Ksm4YXJ1UGYCODY/VUsc38JmAMHjW/w7tZdF48+abc9
	nZJj0ELyRAXa4CXmhLtwjJoLrgcnn8p6EHM49rBdr2iNH6xUqCXKqablBE7I5g==
Message-ID: <5074364c-31c6-4fa6-a705-f10ffd7cb16a@bootlin.com>
Date: Fri, 16 Jan 2026 14:14:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: sfp: add SMBus I2C block support
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, Paolo Abeni
 <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
References: <20260109101321.2804-1-jelonek.jonas@gmail.com>
 <466efdd2-ffe2-4d2e-b964-decde3d6369b@bootlin.com>
 <397e0cdd-86de-4978-a068-da8237b6e247@gmail.com>
 <0c181c3d-cb68-4ce4-b505-6fc9d10495cd@bootlin.com>
 <d5c11fec-1e75-46cf-aeae-593fb6a4af09@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <d5c11fec-1e75-46cf-aeae-593fb6a4af09@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jonas

On 16/01/2026 12:16, Jonas Jelonek wrote:
> Hi Maxime,
> 
> On 09.01.26 18:03, Maxime Chevallier wrote:
>> ACK, I'll gladly help with testing. This should actually be easily
>> achievable with a board that has a real i2c interface connected to the
>> SFP cage, as there's a i2c smbus emulation layer. The SMBus helpers will
>> work with a true I2C adapter, you may have to tweak the code though.
>>
>> This is relevant for modules that have a built-in PHY that you can
>> access, if you don't have any I can run some tests here, I have more
>> than enough modules...
>>
>> If you don't have time at all for that, I may give this a shot at some
>> point, but my time is a bit scarce right now :'(
>>
> 
> I'd postpone this part if that's ok. Quite busy at the moment :(

That's OK

> 
> When I come to trying to work on that, should that all be kept in
> mdio-i2c.c? I'm asking because we have a downstream implementation
> moving that SMbus stuff to mdio-smbus.c. This covers quite a lot right
> now, C22/C45 and Rollball, but just with byte access [1]. Because that
> isn't my work, I'll need to check with the original authors and adapt this
> for an upstream patch, trying to add word + block access.
> 
> Kind regards,
> Jonas
> 
> [1] https://github.com/openwrt/openwrt/blob/66b6791abe6f08dec2924b5d9e9e7dac93f37bc4/target/linux/realtek/patches-6.12/712-net-phy-add-an-MDIO-SMBus-library.patch

I don't think this patch is fit for upstream indeed. I remember Antoine
working on this back in the days, but don't know if he's even aware
that it made it into openwrt.

Nevertheless, let's keep everything in the mdio-i2c driver. I may give
this a shot at some point but I can't make any promise as to when :(

Maxime

