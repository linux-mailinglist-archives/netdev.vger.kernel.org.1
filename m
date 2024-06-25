Return-Path: <netdev+bounces-106323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1AB915BFA
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 04:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EE6283954
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 02:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879FE29428;
	Tue, 25 Jun 2024 02:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="BPJmQp6I"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17891870;
	Tue, 25 Jun 2024 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719280933; cv=none; b=ml3qY9VgV4e0DALFOpisDSlvINMsRs54jTmLYz0v06ihp8dWWeP8m3JxM2CrHryLbiJhqPaWtuIU99wYik9ISv/vSosgp+i2LDmk08oMjoozVSqujCOptOb2YIQP8NI1dEmA/ya4ggeC1CSKHGp8ElK3Cbd+tB9kPSlPT36kSC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719280933; c=relaxed/simple;
	bh=mNyuGT0Ktzk0EfUvsRuZHRHEV9UdbvuvSZqVwPLM/hU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIRgpImq2550lu4JBJHQ7alDZ3LNbbd3utHPztx6zq3HP3fv/Gec+4mMp0RUeN1WcEOYtEkfl+CjRqMvZM3oNl33RsZf4jcU6fTL3FwprL7YzgSTqZ06aAzez0v51ZxHkePwJlf++MUnBndIYb8iNc+wTZLm9XDfwb9yv4HKCOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=BPJmQp6I; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 4A8D988499;
	Tue, 25 Jun 2024 04:02:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719280930;
	bh=UhAJ28u0JJqRKhhPcHwo5G6yzWyYj3+0wIpRSE86fEg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BPJmQp6I6mHiv15o+Hi7YG6XW5LXuyNDrYXTO5SjD0NWcHjkrlqDoHYfNa05pJLOQ
	 KEo1xiPK102PCCJIlxDM8rWSuTzzDUVNII35NtFV/LArzW8XTnKAB08ZWVB+58v2Qs
	 JG/Q77pHWA353qEkahuiqKAdAHw0gaa0U9GDUeiIm4mXQB439lN4KB47ZPKK/BoldT
	 JzIrzii/SsJSBVWKeMeXqPbs7tlx2Rw/gKOh/M8oIQVGo5NWJDEyKcQu7d/R1N+5Zm
	 bzcRzQXzsBo1Hm/fC7FhzqXTYSWNzfEnR5XmdOXCoO9l00YTOknVxbnx3m4KlR2L4B
	 vyvpBhQQyC90Q==
Message-ID: <5e595eaa-3b23-4ad9-aed5-8354eaff0d3e@denx.de>
Date: Tue, 25 Jun 2024 03:59:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH] net: phy: realtek: Add support for PHY LEDs on
 RTL8211F
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, kernel@dh-electronics.com,
 linux-kernel@vger.kernel.org
References: <20240623234211.122475-1-marex@denx.de>
 <ZnjFTSmF3MGX7OuY@makrotopia.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZnjFTSmF3MGX7OuY@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/24/24 3:01 AM, Daniel Golle wrote:
> On Mon, Jun 24, 2024 at 01:40:33AM +0200, Marek Vasut wrote:
>> Realtek RTL8211F Ethernet PHY supports 3 LED pins which are used to
>> indicate link status and activity. Add minimal LED controller driver
>> supporting the most common uses with the 'netdev' trigger.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
>> [...]
>> +static int rtl8211f_led_hw_is_supported(struct phy_device *phydev, u8 index,
>> +					unsigned long rules)
>> +{
>> +	const unsigned long mask = BIT(TRIGGER_NETDEV_LINK_10) |
>> +				   BIT(TRIGGER_NETDEV_LINK_100) |
>> +				   BIT(TRIGGER_NETDEV_LINK_1000) |
>> +				   BIT(TRIGGER_NETDEV_RX) |
>> +				   BIT(TRIGGER_NETDEV_TX);
>> +
>> +	/* The RTL8211F PHY supports these LED settings on up to three LEDs:
>> +	 * - Link: Configurable subset of 10/100/1000 link rates
>> +	 * - Active: Blink on activity, RX or TX is not differentiated
>> +	 * The Active option has two modes, A and B:
>> +	 * - A: Link and Active indication at configurable, but matching,
>> +	 *      subset of 10/100/1000 link rates
>> +	 * - B: Link indication at configurable subset of 10/100/1000 link
>> +	 *      rates and Active indication always at all three 10+100+1000
>> +	 *      link rates.
>> +	 * This code currently uses mode B only.
>> +	 */
>> +
>> +	if (index >= RTL8211F_LED_COUNT)
>> +		return -EINVAL;
>> +
>> +	/* Filter out any other unsupported triggers. */
>> +	if (rules & ~mask)
>> +		return -EOPNOTSUPP;
> 
> It looks like it is not possible to let the hardware indicate only either
> RX or TX, it will always have to go together.
> 
> Please express this in this function accordingly, so fallback to
> software-driven trigger works as expected.
> 
> Example:
> if (!(rules & BIT(TRIGGER_NETDEV_RX)) ^ !(rules & BIT(TRIGGER_NETDEV_TX)))
> 	return -EOPNOTSUPP;

Added to V2, thank you.

