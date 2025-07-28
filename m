Return-Path: <netdev+bounces-210552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31D0B13E2D
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB48017C73D
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87BA26D4E2;
	Mon, 28 Jul 2025 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="gG/ARB0x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927B91A254E
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716315; cv=none; b=kWuX8WC4vw/Ys7cX7+4G2URKdR/M9sSMyOfzUzp8VT8qhQtVB6a/qC5qYF9pIREnNGDqgcRfAyMQOHfTCiPH/m8BFJAfPxTyi+8CrG2S3xRhBLl0dxKXhL+7MbYA7KCNhnx76atoEn92E9nbOLO3qVbYhXl8UMQ2EN17oPhLRAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716315; c=relaxed/simple;
	bh=IgZBumURBZn3Sf1eLjQJxnY/VLdgD3j/8do2ZrMZKMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fi68QixP1tNk2aESVub+FskrvSmdtbBk7FzsEWeaABz4i/HIoyMyLg06KVtt8ZFqyfzTalNbqFTUPB6fPcwYDEAzMDj3oehZ894xFP9BcA6qBicPDTibyBRU+kVPK9bWisvOFySAat0BKMmz4j88k5WXx00cWnxObyeYdc6HicY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=gG/ARB0x; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1753716307;
 bh=jd6WXK9KVAKuAai0Rlvgq64nX1IBqeA40jOYWtgY/NM=;
 b=gG/ARB0x+z6XS7e2a7d3nIYdBXrKDbnV65rc45L1Hrj/i1Ry/qqWiKLHCd8HT2kd7CLRuzRQ4
 VYLpk08BRR4izQc3UPdo5n2+Dscto6dUi1+tGf1QUycppys+fbn+WdUzr2qW/8cnHy/1Ykp5AHf
 fCBxFugQpZ+VD1viQ2DwUoI5mLh7bYVCNBcJyC5fl8uAwJAHRUU5fJMus+mCDrQ9Ad95W0frWRq
 2YXDhAfRsyUTJVzGp3g9+GSdn3ORH/IJ5VS/uCeD7JuzXwff2gcgKk8JgonBOIskisz3QpGMQsF
 z/2jwQbBPZBU+Ml/4ti/210w9UdntkV5BX05TwfdCt2A==
X-Forward-Email-ID: 68879630351ec66b15a1c462
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <1c639c62-cc07-4b3d-a18b-77f93668b88f@kwiboo.se>
Date: Mon, 28 Jul 2025 17:24:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: dsa: realtek: Add support for use of an
 optional mdio node
To: Andrew Lunn <andrew@lunn.ch>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250727180305.381483-1-jonas@kwiboo.se>
 <20250727180305.381483-3-jonas@kwiboo.se>
 <2504b605-24e7-4573-bec0-78f55688a482@lunn.ch>
 <badef015-22ff-4232-a4d0-80d2034113ca@kwiboo.se>
 <9702f3da-f755-4392-bf2b-28814ee0a8c7@lunn.ch>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <9702f3da-f755-4392-bf2b-28814ee0a8c7@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 7/28/2025 12:09 AM, Andrew Lunn wrote:
>> Something like above does not seem to work, I get following:
>>
>>   mdio_bus stmmac-0: MDIO device at address 0 is missing.
>>   mdio_bus stmmac-0: MDIO device at address 1 is missing.
>>   mdio_bus stmmac-0: MDIO device at address 2 is missing.
>>   mdio_bus stmmac-0: MDIO device at address 3 is missing.
> 
> O.K, So i was wrong.
> 
>> And without an explicit 'mdio' child node the driver currently fails to
>> load and the switch is never registered:
>>
>>   rtl8365mb-mdio stmmac-0:1d: found an RTL8367RB-VB switch
>>   rtl8365mb-mdio stmmac-0:1d: no MDIO bus node
>>   rtl8365mb-mdio stmmac-0:1d: could not set up MDIO bus
>>   rtl8365mb-mdio stmmac-0:1d: error -ENODEV: unable to register switch
> 
> So, not having an MDIO node was a long time ago seen as a short cut
> for when there was a clear 1:1 mapping between port number and PHY bus
> address. It still works, but it is somewhat deprecated. It also seems
> like it is become more normal to need additional properties, like what
> interrupt the PHY is using, the LEDs it has, etc.

Sure, no problem to change to a more verbose DT even when there is a
clear 1:1 mapping between port, phy and interrupt here.

When it comes to having the switch being described as an interrupt
controller in the DT is also very wrong, the switch only consume a
single HW interrupt. The fact that the driver creates virtual irq for
each port is purely a software construct and is not something that
should be reflected in the DT.

Possible something for a future series to clean up.

> 
>>
>> With a 'mdio' child node 'make CHECK_DTBS=y' report something like:
>>
>>   rockchip/rk3528-radxa-e24c.dtb: ethernet-switch@1d (realtek,rtl8365mb): mdio: False schema does not allow { [snip] }
>>         from schema $id: http://devicetree.org/schemas/net/dsa/realtek.yaml#
>>
>> So something should probably be changed, the driver, dt-bindings or
>> possible both.
> 
> I think you should allow an MDIO node in DT. This is the only DSA
> driver that i know of which does not allow it.

Sure, I will drop this driver change and instead update the dt-binding
to allow use of a mdio node when the reg prop is defined.

Regards,
Jonas

> 
> 	Andrew


