Return-Path: <netdev+bounces-62247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 843BD826565
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 18:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241E2281F32
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 17:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ADB13AF8;
	Sun,  7 Jan 2024 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqTQeJ9j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2914D13FE1
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cd08f0c12aso10036591fa.0
        for <netdev@vger.kernel.org>; Sun, 07 Jan 2024 09:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704649816; x=1705254616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RfZsiZJCtBLveHnOAscVTxLZc9XIM/Ev1sTDExiKZtI=;
        b=GqTQeJ9jxn12AsuDTZ0Hzrt0OcU7X15xd0fIII3OrKDgncQYAVLRPkJJZnIasALHlK
         XPZvl84++Hz/M6et2etbcUuMq6kgyT0r1CGJJRZKiV7ZFW6+HCqtPyf/cn4or8U9Oshu
         EMKo0Vu5VBw2BuDZWVlntDxcn9JpK6Tubyt4mOsPnsbg6HHlIcyeFiiuB9PkrGUoGyeZ
         24t8aMZfbpNB2oyarQOISxIilWSGr+9dvW/1/f7yRnK+z52NpxHvzWNAuJuz+4vUn2sf
         CX3nL9AuoeQy30UJ8Pa6+huM9Hzwe0hLLBCWvGFN+PUgvXV3lxid2h7Nl4YBUijZCMos
         ehEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704649816; x=1705254616;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RfZsiZJCtBLveHnOAscVTxLZc9XIM/Ev1sTDExiKZtI=;
        b=RsBGBBzDZXkqTwGzyWNDfX16zff1QJrzIgUpVkIUR5Z9bvwn/ycMoZFzvpzjCs4y76
         CojLMDVuz0yCMhe+rd34/kUqp5ngO/bUanyesmX4gzXtW5mm0/7uc1oqh268tVa4uyCX
         MkjGJSYJCi8c289S+Q1r4Q3LwAOZXEaBimo3JgRL2nNFquQqmSCTCjrRv7KFry4GbpgP
         Vo6XrUTod/PqPnyxj6mBG9Yiu95pXxG0YYojrIyf2l8+lYVuWnBrN1P6/iaNn8prUWLB
         sKtBfFSlVW9ie0JrZnla2GWTzHm94KASK8Rl1lIWw9iKrTA8/WSxf4FM7Og4wKZFFQxZ
         6Q9g==
X-Gm-Message-State: AOJu0YysOjYdknBOQ99jecysm2Z4aZJ2fTLHFrfwgFAZjJitS2bgq9x6
	GL8UdosSKo17LakK3CxC3lI=
X-Google-Smtp-Source: AGHT+IH/ES66d+iDChsJSL8i3CZllEZIzuV4eom89coxEsBI3hRr9rLoSEs0oFIJVEbVvq+0G2MbqQ==
X-Received: by 2002:a05:6512:a91:b0:50e:609c:ab90 with SMTP id m17-20020a0565120a9100b0050e609cab90mr713089lfu.32.1704649815694;
        Sun, 07 Jan 2024 09:50:15 -0800 (PST)
Received: from ?IPV6:2a01:c23:c4fa:1c00:e12e:52d:1303:8525? (dynamic-2a01-0c23-c4fa-1c00-e12e-052d-1303-8525.c23.pool.telefonica.de. [2a01:c23:c4fa:1c00:e12e:52d:1303:8525])
        by smtp.googlemail.com with ESMTPSA id t7-20020a50d707000000b00554d57621eesm3525270edi.90.2024.01.07.09.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 09:50:15 -0800 (PST)
Message-ID: <1cf62a4b-9837-4957-bd7a-0b648b8b3cae@gmail.com>
Date: Sun, 7 Jan 2024 18:50:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RFC 4/5] ethtool: add linkmode bitmap support to struct
 ethtool_keee
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <8d8700c8-75b2-49ba-b303-b8d619008e45@gmail.com>
 <87a063ed-1b06-40b4-9c12-37658f36ea06@gmail.com>
 <802f71b2-8707-4799-8258-89c4315a00c2@lunn.ch>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <802f71b2-8707-4799-8258-89c4315a00c2@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.01.2024 18:14, Andrew Lunn wrote:
> On Sat, Jan 06, 2024 at 11:21:31PM +0100, Heiner Kallweit wrote:
>> Add linkmode bitmap members to struct ethtool_keee, but keep the legacy
>> u32 bitmaps for compatibility with existing drivers.
>> Use link_modes.supported not being empty as indicator that a user wants
>> to use the linkmode bitmap members instead of the legacy bitmaps.
> 
> So my fear is, the legacy code will never get cleaned up.
> 
> How many MAC drivers are there which don't use phylib/phylink?
> 
A grep for lp_advertised gives the following, excluding lan78xx and lan743x,
for which I just submitted patches:
https://patchwork.kernel.org/project/netdevbpf/patch/3340ff84-8d7a-404b-8268-732c7f281164@gmail.com/
https://patchwork.kernel.org/project/netdevbpf/patch/b086b296-0a1b-42d4-8e2b-ef6682598185@gmail.com/

drivers/net/usb/r8152.c
drivers/net/usb/ax88179_178a.c
drivers/net/ethernet/qlogic/qede/qede_ethtool.c
drivers/net/ethernet/broadcom/tg3.c
drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
drivers/net/ethernet/broadcom/bnxt/bnxt.c
drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
drivers/net/ethernet/intel/igb/igb_ethtool.c
drivers/net/ethernet/intel/i40e/i40e_ethtool.c
drivers/net/ethernet/intel/igc/igc_ethtool.c
  This one is completely broken, we just talked about it.
drivers/net/ethernet/intel/e1000e/ethtool.c
drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c

> Maybe i can help out converting them.
> 
>> +++ b/include/linux/ethtool.h
>> @@ -223,6 +223,11 @@ __ethtool_get_link_ksettings(struct net_device *dev,
>>  			     struct ethtool_link_ksettings *link_ksettings);
>>  
>>  struct ethtool_keee {
>> +	struct {
>> +		__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
>> +		__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
>> +		__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising);
>> +	} link_modes;
>>  	u32	supported;
>>  	u32	advertised;
>>  	u32	lp_advertised;
> 
> I don't particularly like having the link_modes struct here. The end
> goal should be that supported, advertised and lp_advertised become
> link modes, and all the drivers are changed to use them.
> 
> Maybe we have one patch which does another global replace,
> supported->supported_u32, advertised->advertised_32, etc, making space
> for link mode symbols. phylib can directly use the new link modes so
> there is no real change in that code. We can then convert the MAC
> drivers not using phylib one by one, and then remove the _u32 members
> at the end.
> 
Agreed. I'll add that.

>       Andrew

Heiner

