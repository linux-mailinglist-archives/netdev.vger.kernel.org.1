Return-Path: <netdev+bounces-107796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B52C91C675
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 21:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210031F24C62
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 19:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A7442ABB;
	Fri, 28 Jun 2024 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="InO2wkxB"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC1117C6D;
	Fri, 28 Jun 2024 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719602159; cv=none; b=p9wJS1cU8knZirYz8O+XKxHhdBwWe/AC/4F8LoO9gMcwGzLOmBxxEhODUWofMLJ/9ZyOECyWynsPsPl2OmYkUSQ30lxQ4xrZRArzaryWmTTlEGzXH5E7TC2lkLGfO9M//ITrih3+2oYiFesFlt//865bE1EQXXbzEZ64D5f/3f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719602159; c=relaxed/simple;
	bh=VQ0oJozePE0vhUiowrlkloG2tzYcH7wzcR84m1+pPVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uABI1j/WV5r0H59JMMWa65rBG+IXexBNIYTPftCC5WIEXgHssnOKn/lG5MZEdcJ0tCK03zupp4mIIdAwtogeyzBtOZLdqNMAsi0JruOnZrSqdJWNExzTnnnvTlDAbW21lXyOmXC1ORZ/2w0IhzUSDdUGN5muBoFz2K/AeSUeQuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=InO2wkxB; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id C0072881EC;
	Fri, 28 Jun 2024 21:15:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719602154;
	bh=oINkqH9AcxU9yB663ckTotTFJrsnQBZc8vW3NmUf1tg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=InO2wkxBtTVNTp15sGlyLYHfry+sjDy/836Xzo5cdZohEYELUmGqIecxZFxBUAzkG
	 GhBStbrqPoIjtPEA6Y6KRr8bkYCoTrI2YBlrjH5xrrlScHbwEOFbtjkXrsUwnukDdq
	 bjhr4VRg9yFQ2+a+GBmWyoD13GmZ9+XUc1ku2ot0CkDjoGa9eFDR9mFg6iUG+1hW3N
	 qSpLPUhK3Jw94SQ4uoCmylQWEYVYZ5s0F/9Io4hNQkZWGhDMVGpJHTCm3lCR19nYPP
	 upsLott4y511NNFEjA/uPzwmI4E3NNPaRfocMfFNcTb024mZ3lgJIhGdvDgzMvJmRf
	 n9dEw+8vT7TNw==
Message-ID: <a7f614cd-fe39-4746-8a83-2a2d14fc46f4@denx.de>
Date: Fri, 28 Jun 2024 20:58:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v2] net: phy: realtek: Add support for PHY LEDs
 on RTL8211F
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, kernel@dh-electronics.com,
 linux-kernel@vger.kernel.org
References: <20240625204221.265139-1-marex@denx.de>
 <20240628142742.GH783093@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240628142742.GH783093@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/28/24 4:27 PM, Simon Horman wrote:
> On Tue, Jun 25, 2024 at 10:42:17PM +0200, Marek Vasut wrote:
>> Realtek RTL8211F Ethernet PHY supports 3 LED pins which are used to
>> indicate link status and activity. Add minimal LED controller driver
>> supporting the most common uses with the 'netdev' trigger.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Christophe Roullier <christophe.roullier@foss.st.com>
>> Cc: David S. Miller <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Heiner Kallweit <hkallweit1@gmail.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: kernel@dh-electronics.com
>> Cc: linux-kernel@vger.kernel.org
>> Cc: netdev@vger.kernel.org
>> ---
>> V2: - RX and TX are not differentiated, either both are set or not set,
>>        filter this in rtl8211f_led_hw_is_supported()
>> ---
>>   drivers/net/phy/realtek.c | 106 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 106 insertions(+)
>>
>> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
>> index 2174893c974f3..bed839237fb55 100644
>> --- a/drivers/net/phy/realtek.c
>> +++ b/drivers/net/phy/realtek.c
>> @@ -32,6 +32,15 @@
>>   #define RTL8211F_PHYCR2				0x19
>>   #define RTL8211F_INSR				0x1d
>>   
>> +#define RTL8211F_LEDCR				0x10
>> +#define RTL8211F_LEDCR_MODE			BIT(15)
>> +#define RTL8211F_LEDCR_ACT_TXRX			BIT(4)
>> +#define RTL8211F_LEDCR_LINK_1000		BIT(3)
>> +#define RTL8211F_LEDCR_LINK_100			BIT(1)
>> +#define RTL8211F_LEDCR_LINK_10			BIT(0)
>> +#define RTL8211F_LEDCR_MASK			GENMASK(4, 0)
>> +#define RTL8211F_LEDCR_SHIFT			5
>> +
> 
> Hi Marek,
> 
> FWIIW, I think that if you use FIELD_PREP and FIELD_GET then
> RTL8211F_LEDCR_SHIFT can be removed.

FIELD_PREP/FIELD_GET only works for constant mask, in this case the mask 
is not constant but shifted by SHIFT*index .

Other drivers introduce workarounds like this for exactly this issue:

drivers/clk/at91/pmc.h:#define field_prep(_mask, _val) (((_val) << 
(ffs(_mask) - 1)) & (_mask))

I don't think it is worth perpetuating that.

