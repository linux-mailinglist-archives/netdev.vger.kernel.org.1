Return-Path: <netdev+bounces-243454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DACDCA19E0
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 22:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 038E13004416
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 21:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8B92C21CD;
	Wed,  3 Dec 2025 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KYuv9aX5"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A482D0636;
	Wed,  3 Dec 2025 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796034; cv=none; b=pQpOSKBW8dnsgTZtJV0D0wi4hCN42dy8zs3U5pesTI8Ak3WEfiK22XZO3pX4e8ORMSu8fGaioM5A3GDyxcEEHVKhQVMeso9GcMDc64ZUo4FQ+qDOEAna1e8KiUJl2YFv9Jya9jPiL0yFHV9CUOQC+NP3GnTspaNaC6dG7+xcN/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796034; c=relaxed/simple;
	bh=qVDJVAb7m8LhZF55QvKoiTvZ29MfCyKYtS45an5OrSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIsdWrrf2buBrbjl9YdMBNw8+LvtGN36gAZh1nyFKdwvTeOUipSQNxEJGEPkms/DXchOYP0g/YT9KxF9GOcP3qDXTmXXJp/GHjWYEN8qwi/nEDTT4dy8yo1wlwpUZZVN4Pp4jfX1byj7KDVMZuhZToQRh3aYWy7IHBPDmKRzqoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=KYuv9aX5; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dM9F24YD6z9tyH;
	Wed,  3 Dec 2025 22:07:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1764796022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eAh1SlQBuHPbEjaVW+h37YQVPv85RZ8746aPTiKpCV0=;
	b=KYuv9aX5XxgxY4N92efD75JwR8wamPSYFb7hskD2qwoCt7XgyHZJtHTUnPIoMZE2A3ElPo
	xpGmn5fxjYc06h327VzMb8Slv82Y13gOiirLboMtOUUyAgEg33cei36SpHHbd6NjydeNr3
	aVnqKeSWAyRq6vOtCusemZ7eSmMz5/6ZW5mfg+SJN6ARCmUbh6OcDO9Nvu+atf7SS0ltgk
	Y1DcAMyJmR5A62x6eQRGuuff1o/nU790BJgGB34moaQG62D4zgb1NhDPCjfZnDDy/qlpKu
	rnjg0I5DeB1A47O7otMCcOXgIm0q3lj/kBgjw+dvJCrhOUq4fKh1/uhksi8TOw==
Message-ID: <c52624fb-9d5f-4eb7-af3f-e2cef872a2ba@mailbox.org>
Date: Wed, 3 Dec 2025 20:21:00 +0100
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
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Klein <michael@fossekall.de>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
References: <20251130005843.234656-1-marek.vasut@mailbox.org>
 <20251130005843.234656-3-marek.vasut@mailbox.org>
 <aTAOe4c48zyIjVcb@shell.armlinux.org.uk>
 <20251203123430.zq7sjxfwb5kkff7q@skbuf>
 <aTB0x6JGcGUM04UX@shell.armlinux.org.uk>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aTB0x6JGcGUM04UX@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c43c75a9ce634b39c52
X-MBO-RS-META: sj3uknpc7hwyhgtqrd79d6rqrmm4d475

On 12/3/25 6:35 PM, Russell King (Oracle) wrote:
> On Wed, Dec 03, 2025 at 02:34:30PM +0200, Vladimir Oltean wrote:
>> On Wed, Dec 03, 2025 at 10:18:35AM +0000, Russell King (Oracle) wrote:
>>> On Sun, Nov 30, 2025 at 01:58:34AM +0100, Marek Vasut wrote:
>>>> Add support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-CG,
>>>> RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. The implementation
>>>> follows EMI improvement application note Rev. 1.2 for these PHYs.
>>>>
>>>> The current implementation enables SSC for both RXC and SYSCLK clock
>>>> signals. Introduce new DT property 'realtek,ssc-enable' to enable the
>>>> SSC mode.
>>>
>>> Should there be separate properties for CLKOUT SSC enable and RXC SSC
>>> enable?
>>
>> That's what we're trying to work out. I was going to try and give an
>> example (based on stmmac) why you wouldn't want RXC SSC but you'd still
>> want CLKOUT SSC, but it doesn't seem to hold water based on your feedback.
>> Having one device tree property to control both clocks is a bit simpler.
> 
> The problem I see is that if we introduce a single property for both,
> we then need to maintain this single property ad infinitum. If we
> later find that we need separate control, we could end up with three
> properties - the combined one, and two for individual controls.
> 
> If we are to go with a single property, then I think we should have at
> least discussed what we would do if we need separate control.
> 
> If we go with two properties now, then we don't have to consider this,
> and we will only ever have the two properties rather than three.
It seems the CLKOUT and RXC SSC can be enabled entirely separately, so I 
think two properties are the way to go ?

