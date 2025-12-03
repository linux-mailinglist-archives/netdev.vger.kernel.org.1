Return-Path: <netdev+bounces-243456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF63CA19E6
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 22:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E69943006477
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 21:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A190E2D063F;
	Wed,  3 Dec 2025 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iLBQU1Gv"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3967F2C15B8;
	Wed,  3 Dec 2025 21:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796038; cv=none; b=lIRULxIX3AM/yhd6RNWco0skvUZq5EZ20vwzxQhAOXBrNThPcvS8tHAkGkYvfivxArUmQK0wSigOVC1TefGmOAJ5FAWrsB0gdHjKO6mANF8bHjdqeAc67pgYG4tMZnmlpms6Lhd2GpsmZlmAxIC4B3/6n1baWXqiZu+hfKNfhG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796038; c=relaxed/simple;
	bh=L/KwpKfetHVAKb2bucO4m2g5XMw3lWzNapYxHsLa+XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uF9dJdaSmunwfL6f0bNPCUcfZN/pwuEiOxUI253HbEbW5Uh1Fu3q03T9KQYheXrkUyl0teGpcmHgF5vklnQKPFtxKf/fCYeNDfBdHIwV3e+x+OL/XHd2psalDtrBPeuSLT/p5YDR6Q+GpCv3PYPkkKqhH2KEFCQMx9mt0PK2NvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=iLBQU1Gv; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dM9FD4VdTz9sjn;
	Wed,  3 Dec 2025 22:07:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1764796032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+7vdX3foJCovPIDuNWvdkmUlaoRsPiNhWMj+vm0lHGk=;
	b=iLBQU1Gvu38mHyjwDxuhCe6THSKQ3j5YrMFBvirzHUzCOoMOBelZr0qGiGwKwVuFrlzlT9
	PXHoWWPf212b26oTY6fR4Z9iwCoZO+JeMogQQ5BebyT7ddffrH8yInmM6E0hgV0HEsdAMk
	3mq2Nd2JIZ8WD9duaCft/RWJHv2UYDhw2/iynGzFZ5tA+QXKcQO8WQd8VhDzgINWh0+c3i
	H2MJ2BFwvsN6G5/Y9Jyt6XvW3aQtmH0SZyW+s7pE/ePVSUHp/NgF3bkqXFFvBSk05wLVn1
	Y0WZ3jC0cebxIp5zfCyhlZUD7A3zfmHgQ2BKPFKuua5fecRbW7sxeOSPEmJxaw==
Message-ID: <ddefca55-0f5f-4ba9-ac13-06bcfd59ee95@mailbox.org>
Date: Wed, 3 Dec 2025 21:46:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next,PATCH 3/3] net: phy: realtek: Add property to enable
 SSC
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Ivan Galkin <ivan.galkin@axis.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Klein <michael@fossekall.de>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
References: <20251130005843.234656-1-marek.vasut@mailbox.org>
 <20251130005843.234656-3-marek.vasut@mailbox.org>
 <20251203094224.jelvaizfq7h6jzke@skbuf>
 <aTAN5lX_OgwQh7E8@shell.armlinux.org.uk>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aTAN5lX_OgwQh7E8@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 4c30b459ba8ffe44b93
X-MBO-RS-META: m6rgzpyqkniqtbwd7i61gjqfo56hmtr4

On 12/3/25 11:16 AM, Russell King (Oracle) wrote:
> On Wed, Dec 03, 2025 at 11:42:24AM +0200, Vladimir Oltean wrote:
>>> +
>>> +       ret = phy_write_paged(phydev, RTL8211F_SSC_PAGE, RTL8211F_SSC_RXC, 0x5f00);
>>> +       if (ret < 0) {
>>> +               dev_err(dev, "RXC SCC configuration failed: %pe\n", ERR_PTR(ret));
>>> +               return ret;
>>> +       }
>>
>> I'm going to show a bit of lack of knowledge, but I'm thinking in the context
>> of stmmac (user of phylink_config :: mac_requires_rxc), which I don't exactly
>> know what it requires it for.
> 
> stmmac requires _all_ clocks to be running in order to complete reset,
> as the core is made up of multiple modules, all of which are
> synchronously clocked by their respective clocks. So, e.g. for the
> receive sections to complete their reset activity, clk_rx_i must be
> running. In RGMII mode, this means that the RGMII RXC from the PHY must
> be running when either the stmmac core is subject to hardware or
> software reset.
> 
>> Does it use the RGMII RXC as a system clock?
>> If so, I guess intentionally introducing jitter (via the spread spectrum
>> feature) would be disastrous for it. In that case we should seriously consider
>> separating the "spread spectrum for CLKOUT" and "spread spectrum for RGMII"
>> device tree control properties.
> 
> I don't think it will affect stmmac - as long as the clock is toggling
> so that the synchronous components in stmmac can change state, that's
> all that the stmmac reset issue cares about.
> 
> However, looking at the RTL8211FS(I)(-VS) datasheet, CLKOUT and RXC
> are two different clocks.
> 
> CLKOUT can be:
> - reference clock generated from internal PLL.
> - UTP recovery receive clock (for SyncE)
> - Fibre recovery receive clock (for SyncE)
> - PTP synchronised clock output
> 
> This can't be used for clocking the RGMII data, because it won't be
> guaranteed to have the clock edges at the correct point, nor does it
> switch clock speed according to the negotiated data rate. In SyncE
> modes, the recovered clock is either 125MHz or 25MHz, whereas RXC
> is 125, 25 or 2.5MHz.
> 
> There is a separate bit for enabling SSC on RXC - PHYCR2 bit 3 vs
> CLKOUT SSC in bit 7.
Uh ... and sadly, the "EMI improvement parameters application note 1.2 
fails to mention this big when enabling CLK_OUT SSC. Also, there is 
PHYCR2 CLKOUT SSC capability bits 13:12 , which does who knows what ?

