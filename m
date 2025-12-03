Return-Path: <netdev+bounces-243457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9E7CA19FB
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 22:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED5F1301E151
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 21:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F84D2C15B8;
	Wed,  3 Dec 2025 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Z5wMKfZ7"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD83262FDD;
	Wed,  3 Dec 2025 21:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796042; cv=none; b=lJf3NoxRHzry/gPacE64bt5TyrkcAydjHNifgyXL/wV8yD7qXGJBfUWaK4rqVlZmp01DqDaNTJpmGJ38Gg6aw5DmqGwUHzHPRvizldoBgq2kfEiwGffo4H3e4HDjUJEfFRQs2Pj22T0+oUbIoBXtRl6v/sABYD5IE1Y1ah3dWoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796042; c=relaxed/simple;
	bh=U26KQWKRDJ9c8vcZSVuTUNeTAQ8Ho3yUmC9j3ZwhArA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpHBp81H7faQAXh1EW4+r8kR6wXbYqvmJcTs1iGvjm3zZkSz0PFomAgbHGxchuBQHQJVStKSie9JorSAMNqxfIPVWOi8tZCzmGuLo9gIS4HF2Kp6OwP/DhKKCd1wOW44lQfdOPCsbVNkrQ4dDXGdwj4zghc7zwv09msv+LQHDgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Z5wMKfZ7; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dM9FH4wQrz9tVB;
	Wed,  3 Dec 2025 22:07:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1764796035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQ9X4Reb6e5Lqd8wC4oC6gHlssTggRaBizr1r0Jsxo8=;
	b=Z5wMKfZ7YdKgsMsvGUDDaihxGrzUdfeiFCrAOlrjfxYUkX+I5kyTEz/uNQVgB9ViR9Z/Ty
	A68k24gwcLB7kSOzAnmz2VzW43BwhQusV9qfFIXS8QdKMH0rC/S/rNOF7Q4KCFP+RfpBh8
	EsbEPU0YYTekBEfEySXl9vOt7GKK+spESegTlhtlRla71eAXAoo1GYBeHQ2Hp+x93Qbh+2
	v5DnZ4T3q8BNc7SVAqXDvUttNiUJMFo+un+JGpranakbNmIzBadO01LapcytlWf0DfQlYt
	X2G4CZeOrMJjZ342eSQc53bP830zMIVuxQKJNTrYFptkbQIELx/UQiCho/PM+w==
Message-ID: <a68ae867-55d8-4198-b0ab-0419af8c46b1@mailbox.org>
Date: Wed, 3 Dec 2025 21:51:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next,PATCH 3/3] net: phy: realtek: Add property to enable
 SSC
To: Ivan Galkin <Ivan.Galkin@axis.com>,
 "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "andrew@lunn.ch" <andrew@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "michael@fossekall.de" <michael@fossekall.de>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
 <robh@kernel.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "olek2@wp.pl" <olek2@wp.pl>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "kuba@kernel.org"
 <kuba@kernel.org>
References: <20251130005843.234656-1-marek.vasut@mailbox.org>
 <20251130005843.234656-3-marek.vasut@mailbox.org>
 <20251203094224.jelvaizfq7h6jzke@skbuf>
 <37d89648fddf1d597e6be0c541cbc93cb3b42e24.camel@axis.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <37d89648fddf1d597e6be0c541cbc93cb3b42e24.camel@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8370b72e4c4ffb37bea
X-MBO-RS-META: omiyk591y7gmnc9urr4ixq91h6gid13e

On 12/3/25 2:01 PM, Ivan Galkin wrote:
> On Wed, 2025-12-03 at 11:42 +0200, Vladimir Oltean wrote:
>> [You don't often get email from vladimir.oltean@nxp.com. Learn why
>> this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> On Sun, Nov 30, 2025 at 01:58:34AM +0100, Marek Vasut wrote:
>>> Add support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-
>>> CG,
>>> RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. The implementation
>>> follows EMI improvement application note Rev. 1.2 for these PHYs.
>>>
>>> The current implementation enables SSC for both RXC and SYSCLK
>>> clock
>>> signals. Introduce new DT property 'realtek,ssc-enable' to enable
>>> the
>>> SSC mode.
>>>
>>> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
>>> ---
>>> Cc: "David S. Miller" <davem@davemloft.net>
>>> Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
>>> Cc: Andrew Lunn <andrew@lunn.ch>
>>> Cc: Conor Dooley <conor+dt@kernel.org>
>>> Cc: Eric Dumazet <edumazet@google.com>
>>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>>> Cc: Heiner Kallweit <hkallweit1@gmail.com>
>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>>> Cc: Michael Klein <michael@fossekall.de>
>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>> Cc: Rob Herring <robh@kernel.org>
>>> Cc: Russell King <linux@armlinux.org.uk>
>>> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
>>> Cc: devicetree@vger.kernel.org
>>> Cc: netdev@vger.kernel.org
>>> ---
>>>   drivers/net/phy/realtek/realtek_main.c | 47
>>> ++++++++++++++++++++++++++
>>>   1 file changed, 47 insertions(+)
>>>
>>> diff --git a/drivers/net/phy/realtek/realtek_main.c
>>> b/drivers/net/phy/realtek/realtek_main.c
>>> index 67ecf3d4af2b1..b1b48936d6422 100644
>>> --- a/drivers/net/phy/realtek/realtek_main.c
>>> +++ b/drivers/net/phy/realtek/realtek_main.c
>>> @@ -74,11 +74,17 @@
>>>
>>>   #define RTL8211F_PHYCR2                                0x19
>>>   #define RTL8211F_CLKOUT_EN                     BIT(0)
>>> +#define RTL8211F_SYSCLK_SSC_EN                 BIT(3)
>>>   #define RTL8211F_PHYCR2_PHY_EEE_ENABLE         BIT(5)
>>>
>>>   #define RTL8211F_INSR_PAGE                     0xa43
>>>   #define RTL8211F_INSR                          0x1d
>>>
>>> +/* RTL8211F SSC settings */
>>> +#define RTL8211F_SSC_PAGE                      0xc44
>>> +#define RTL8211F_SSC_RXC                       0x13
>>> +#define RTL8211F_SSC_SYSCLK                    0x17
>>> +
>>>   /* RTL8211F LED configuration */
>>>   #define RTL8211F_LEDCR_PAGE                    0xd04
>>>   #define RTL8211F_LEDCR                         0x10
>>> @@ -203,6 +209,7 @@ MODULE_LICENSE("GPL");
>>>   struct rtl821x_priv {
>>>          bool enable_aldps;
>>>          bool disable_clk_out;
>>> +       bool enable_ssc;
>>>          struct clk *clk;
>>>          /* rtl8211f */
>>>          u16 iner;
>>> @@ -266,6 +273,8 @@ static int rtl821x_probe(struct phy_device
>>> *phydev)
>>>                                                     "realtek,aldps-
>>> enable");
>>>          priv->disable_clk_out = of_property_read_bool(dev->of_node,
>>>                                                       
>>> "realtek,clkout-disable");
>>> +       priv->enable_ssc = of_property_read_bool(dev->of_node,
>>> +                                                "realtek,ssc-
>>> enable");
>>>
>>>          phydev->priv = priv;
>>>
>>> @@ -700,6 +709,37 @@ static int rtl8211f_config_phy_eee(struct
>>> phy_device *phydev)
>>>                                  RTL8211F_PHYCR2_PHY_EEE_ENABLE, 0);
>>>   }
>>>
>>> +static int rtl8211f_config_ssc(struct phy_device *phydev)
>>> +{
>>> +       struct rtl821x_priv *priv = phydev->priv;
>>> +       struct device *dev = &phydev->mdio.dev;
>>> +       int ret;
>>> +
>>> +       /* The value is preserved if the device tree property is
>>> absent */
>>> +       if (!priv->enable_ssc)
>>> +               return 0;
>>> +
>>> +       /* RTL8211FVD has no PHYCR2 register */
>>> +       if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
>>> +               return 0;
>>
>> Ivan, do your conversations with Realtek support suggest that the VFD
>> PHY variant also supports the spread spectrum clock bits configured
>> here
>> in RTL8211F_PHYCR2?
>>
>>
>>
> 
>  From what I learned from Realtek, the statement about RTL8211F(D)(I)-
> VD-CG not having PHYCR2 (Page 0xa43 Address 0x19) is incorrect. This
> register does exist and manages nearly identical configurations as the
> rest of the RTL8211F series, with the exception of the CLKOUT
> configuration, which has been relocated to a different control
> register. Marek, you can read about my findings here
> https://lore.kernel.org/netdev/20251202-phy_eee-v1-1-fe0bf6ab3df0@axis.com/
> 
> Unfortunately I don't have the complete description of PHYCR2 on this
> particular PHY. I will reach out to Realtek regarding SSC and provide
> an update once I have more information.

I think the bits of interest are PHYCR2 bits 13:12 CLKOUT SSC 
capability, 7 CLKOUT SSC Enable and 3 SYSCLK SSC Enable .

Thank you for this information.

I will send a patchset V2 shortly, with the split configuration that 
follows EMI improvement parameters application note 1.2 and also sets 
the bits in PHYCR2 accordingly .

