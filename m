Return-Path: <netdev+bounces-94712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6454F8C050A
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 21:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9618D1C20988
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403C112D75D;
	Wed,  8 May 2024 19:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="CaHbcaJq"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3499130A48
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196642; cv=none; b=ppVU9nVt6YIaMLoDZ9Pf9Jahq27QhI8UDHaPEVFu2y28TZRVzC1vH+LbEJkL1j2MpHCYBv0QkM5Y0D3wwmoecT6sCeYcmR01+lIVr8zSJJ73BKJNlHVvnChfjEILqJszPjrTViUutjrQ99eGR5XQfQ9yRzmj7eQFBHYsypo1ttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196642; c=relaxed/simple;
	bh=iZaQWFhaunlMvEUOLNzwsbnS9IHM0+wGH7vg+7XXHvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEcbOVvZeQnze/mBDERPzAOvrKyui5i6uTaPRGFrYbIC7O1kTQGNWa+Gff1rHDqN1kzPbWfJJHK9vwONO6bvfhgke+vYNRMd+89tO9DJ/qYCpBlGaz6F9r9u72LvNbhhfGZwX3IePmvYdsATTZFHyRxvcLtCIpTUHh6Tv6OB6QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=CaHbcaJq; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1715196628; x=1715801428; i=hfdevel@gmx.net;
	bh=Q9CeGcF5RngopU4rfRB7vEnpfIId4pZDjMAY2anxqq4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CaHbcaJq4MOf2BMwNKX4GdLJ99BhmeBeKYtYQPisRC0pAMHSJ8cRvU8470JR8cSf
	 wJOkaXa51ek1PWe9a5s6AwuKKU62E9xwtzHfg00ZcFYRHtzBsFa2vzkypFGJvi3q/
	 1ta+yE3hSqsRTHzth1nP8ylr0rhOA4CK7H8ZRNDg/uBmc28cyp8INn6dHcxL0+LTx
	 LiPzpWH+U3IUV9yzoNzKZ3VRL7CXMWWzmhKHKxZX3NyM726zU/GhKIs+FXcNSN/Dz
	 FmF9FWrn7eX+Cb/hI6YfKJ5dy9V4MvETlsFcLJEX36jnI+i4GLgyzMqKZQWryz6h2
	 XCmna9EmyWYukWCrcg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpOd-1sWy0T2UPZ-00gGtv; Wed, 08
 May 2024 21:30:28 +0200
Message-ID: <71d4a673-73b6-4ebe-a669-de3ae6c9af5f@gmx.net>
Date: Wed, 8 May 2024 21:30:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/6] net: tn40xx: add mdio bus support
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
 horms@kernel.org, kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com
References: <1f28bc3c-3489-4fc7-b5de-20824631e5df@gmx.net>
 <12394ae6-6a2d-4575-9ba1-1b39ca983264@lunn.ch>
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <12394ae6-6a2d-4575-9ba1-1b39ca983264@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MIloyuaUwsGkR7Sq69bvEgdf6R4nymWmJopPn335pp/OngdemjC
 nykjVd9TRUwzNVqGyMsWMSUgNEXEz9kxP17XV8QdiumRKOek7+wXkAyHRUGM5TJa9QgNCjs
 pc02t2BsctvY0uj1f0f4Wk37zoytQz+fvxRNsPIQm6IoMGEWkFcSa+DhmMUO8ZkZM6vN/Xp
 GZcaYQk3MAn31jTzBuxiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Lc7Y14kTm9M=;sC/3gBeFs+YY335iyK5C5vMW7XS
 GluecYJIa2PkNHUi+/RUMZAALo0HGFPsJMi5EYj3YbIxQNYeolzySzgPdzjIeomI49ocJX3Gk
 WnyeeqKy7qTZ2p9oDCymZWobqXu9fxFO3ClrWxkadp/oZc72eNceeUXGMb9f/o8/ibCgmBUcx
 VocN43tnhRaA5ipXUZM9nzgbq2iKzVRkllXBtOmg8jlVMpnXxaZ9LgHtwB6p2FqA2shN9ormI
 U3AXE3eh0poybSie9fbLFGhtNQ+jQRfKf6b7uQgdTyt3dYF/mbx7Jkw05vjAkIwnjIbsayDvo
 Fvh1xYaBjuzB3ifBbphfuiIqtikxBZOMqVh8oO1jaVQH6+dQa2GT1PtswSA8hxY9ye7T8WU9b
 hq/sC/sNbgDUZMV/ilN11kf2pC/ZHe+m3FsRBrl4dg0KlPP5IoHjb4v/pviSw1MteK+OgGMZD
 3iYwhKu+5Xo/hm5BcKGjkeM0B5Gf1doAjvpHnLEUhCygsjT3cjdbH2y0UVmOjESeQgVCG42LW
 gwyabPAQxnk/oxRyCIDqY0XX/kCv7hnsSXNgSBoz+qRdFzlm5fHEWjGwwt3zWy+M0/g7V5f8l
 q65JE96H2/oab0MiZBgo8SkLYrBr0pfFPzQ4qu0hbya6sPJojoDvZdjpDwvELowcJxgM84Mvx
 7w7rK8s4sK5rHGqcrwBpR2ch9NsLsHuNvADbgwMaJKgQT1stZxxfXQk0M6tp+39oettHW6ZLp
 we0i50XyIz1A9R/J1T+PdR4AYCms57Y4kOTzX+p+rc9x4rzMJeUbRuEiPTMXeYjh394XB0KwK
 SW0pmRictRJ5/JliU5XABvnOhZV18us1RW4SZqu/yomsQ=

On 08.05.2024 20.25, Andrew Lunn wrote:
>>> +=C2=A0=C2=A0=C2=A0 writel(((1 << 15) | i), regs + TN40_REG_MDIO_CMD);
>> similarly here:
>>
>> writel((MDIO_PHY_ID_C45 | i), regs + TN40_REG_MDIO_CMD);
> This one i don't agree with. It happens to work, but there is no
> reason to think the hardware has been designed around how Linux
> combines the different parts of a C45 address into one word, using the
> top bit to indicate it is actually a C45 address, not a C22.
>
> I would much prefer a TN40_ define is added for this bit.
OK, yes, very valid point.
>
>>> +=C2=A0=C2=A0=C2=A0 writel(((device & 0x1F) | ((port & 0x1F) << 5)),
>> and also here, similarly:
>>
>> writel((device & MDIO_PHY_ID_DEVAD) | ((port << 5) & MDIO_PHY_ID_PRTAD)=
,
> Similarly here, this happens to work, but that is just because the
> hardware matches a software construct Linux uses. It would be better
> to add TN40_ macros to describe the hardware.
agreed, I assume I just interpreted too much into the constants.
>
>     Andrew

Thanks!
Hans


