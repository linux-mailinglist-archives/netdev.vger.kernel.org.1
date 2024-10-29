Return-Path: <netdev+bounces-139842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0B39B4643
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 10:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535A7283743
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 09:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11D2204926;
	Tue, 29 Oct 2024 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="JCCqFgMU"
X-Original-To: netdev@vger.kernel.org
Received: from mx23lb.world4you.com (mx23lb.world4you.com [81.19.149.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0C520695B
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730195773; cv=none; b=BFlppO7H1Nat3GfBb4u1O0HzrIBc/p37T51ms1RWij1ktSil0g8td4DK9B3+zhiwZQZkweCkOSCb+VmkNvPwWC5S8DaZVB13n7OYhOE5CicjMi/6NAtzxL7HILYlnaPQ7kWmkHNiqpTiDj63FzrC7447tciyh/5C7WWyl6PSf34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730195773; c=relaxed/simple;
	bh=DD4XboWEA2JhPSTXo9clwEZF7wSXWZhDuNXyU9LQBAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQOAcVsi61BR1BlNqVZoedOMx3h+547cuamX5ZmlzQu+SdS31Ebb4BwLOi+c9M53+6P/HHf9GiwBppq7fF4QuUlopclqXrIJJKcUwd4HeXhcam14FGB99KZgRKVoDq0g8cAukCgo8g1PEx9HAAqmAtOLRvJRj3O4RDXk97vy4qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=JCCqFgMU; arc=none smtp.client-ip=81.19.149.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lt6Ldsc9OVTM3qqCsxMt2JKN301lXVxGYeaoWCdF2g8=; b=JCCqFgMUflCflfdQuL1/se2bhV
	YiFrU2KBcBFA8Tl0usSLplzb1/UU719oUc6OfxQLZXXKue0CZU4A8xun0adXfH4Ia8FzTe0l+wrry
	G/EH3PD+GGI0Z7ScfpwDgrgCsswVODPTngSIkD37yHPd+LclL/PQ5ETSHSt+mfCjESIo=;
Received: from [88.117.52.189] (helo=[10.0.0.160])
	by mx23lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1t5f6z-000000006o7-30So;
	Tue, 29 Oct 2024 06:49:49 +0100
Message-ID: <b075514b-74b6-46bb-ba3b-da5a2490e5b3@engleder-embedded.com>
Date: Tue, 29 Oct 2024 06:49:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: phy: Allow loopback speed selection for
 PHY drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20241028203804.41689-1-gerhard@engleder-embedded.com>
 <20241028203804.41689-2-gerhard@engleder-embedded.com>
 <04baac62-ace2-4f44-a32e-640f30b24d96@lunn.ch>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <04baac62-ace2-4f44-a32e-640f30b24d96@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 29.10.24 03:45, Andrew Lunn wrote:
>> -	int (*set_loopback)(struct phy_device *dev, bool enable);
>> +	/**
>> +	 * @set_loopback: Set the loopback mode of the PHY
>> +	 * enable selects if the loopback mode is enabled or disabled. If the
>> +	 * loopback mode is enabled, then the speed of the loopback mode can be
>> +	 * requested with the speed argument. If the speed argument is zero,
>> +	 * then any speed can be selected. If the speed argument is > 0, then
>> +	 * this speed shall be selected for the loopback mode or EOPNOTSUPP
>> +	 * shall be returned if speed selection is not supported.
>> +	 */
> 
> I think we need to take a step back here and think about how this
> currently works.
> 
> The MAC and the PHY probably need to agree on the speed. Does an RGMII
> MAC sending at 10Mbps work against a PHY expecting 1000Mbps? The MAC
> is repeating the symbols 100 times to fill the channel, so it might?
> But does a PHY expecting 100 repeats work when actually passed a
> signal instance of a symbol?  What about an SGMII link, 10Mbps one
> side, 1G the other? What about 1000BaseX vs 2500BaseX?
> 
> I've never thought about how this actually works today. My _guess_
> would be, you first either have the link perform auto-neg, or you
> force a speed using ethtool. In both cases, the adjust_link callback
> of phylib is called, which for phylink will result in the mac_link_up
> callback being called with the current link mode, etc. So the PHY and
> the MAC know the properties of the link between themselves.
> 
>> +	int (*set_loopback)(struct phy_device *dev, bool enable, int speed);
> 
> You say:
> 
>> +                                    If the speed argument is zero,
>> +	 * then any speed can be selected.
> 
> How do the PHY and the MAC agree on the speed? Are you assuming the
> adjust_link/mac_link_up will be called? Phylink has the hard
> assumption the link will go down before coming up at another speed. Is
> that guaranteed here?

Yes, the PHY and the MAC has to agree on the speed. In my opinion
adjust_link/mac_link_up shall be called like in normal operation without
loopback. The question is when? adjust_link/mac_link_up could be called
after phy_loopback() returns with success or before phy_loopback()
returns. I would prefer that a successful return of phy_loopback()
guarantees that the loopback mode is active and signaled. This would
eliminate the need to wait for the loopback, which would be again
error prone.

It is not guaranteed that the link goes down before its coming up at
another speed. That needs to be fixed. If the link is up and the speed
matches, then the link shall stay up. If the link is up and the speed
does not match, then the link shall first go down and then come up after
the loopback is established. If the link is down, then the link come up
after the loopback is established. Would that be ok? Or should the link
always go down before the loopback is switched on?

> What happens when you pass a specific speed? How does the MAC get to
> know?

I agree that adjust_link/mac_link_up shall still be used to let the MAC
know the speed.

> I think we need to keep as close as possible to the current
> scheme. The problem is >= 1G, where the core will now enable autoneg
> even for forced speeds. If there is a link partner, auto-neg should
> succeed and adjust_link/mac_link_up will be called, and so the PHY and
> MAC will already be in sync when loopback is enabled. If there is no
> link partner, auto-neg will fail. In this case, we need set_loopback
> to trigger link up so that the PHY and MAC get in sync. And then it is
> disabled, the link needs to go down again.

I would like to try it. Would be great to hear your opinion about when
adjust_link/mac_link_up should be called in case of successful
set_loopback() and if the link shall always go down before loopback.

Thank you for your feedback!

Gerhard

