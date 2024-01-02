Return-Path: <netdev+bounces-60936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1C1821F00
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 16:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584351C22516
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BAB14AB1;
	Tue,  2 Jan 2024 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CU3Kk4av"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F105D14A9E
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-553ba2f0c8fso10597824a12.1
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 07:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704210460; x=1704815260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+0XPqZ7+9K/BCXTqm3xLamIPUETXWQ24VDTPmm4lAuw=;
        b=CU3Kk4av7Me9LpfUwYTmLxWPHnsowV26KMcauOjkVMBNVOXy715kKNU/8G5UWeSsRv
         tlkiwWWfY7c8auMAlHzQmsJrrUcLKyo5Y+EMjUigS5N9ET2B7O5G2rHNIK4CSm+0lLBe
         1aPiEwA0MxQ6Vg54v2ug9CucXI+pfBjW9U4mzt2a9hndlp39HyC1DH9LclCUrZbig1Sf
         WNgJqg021wQf9DhySeQfduz8iVEXplV1160eg5UVO0uresIA2xoGLSudNv6mljiAf8tr
         EBNzVkJOZ0MV7uorlZE4GxoqhKvscI7ItKHOIzOoNQlolz3/pnk30JVH9sr6nxbbE8NO
         tybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704210460; x=1704815260;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0XPqZ7+9K/BCXTqm3xLamIPUETXWQ24VDTPmm4lAuw=;
        b=oEMNQwt9ucd0PV6cTrSN6mL34PNlfWzVSxFzBMd/MDHgS0e3EgF8k8vqqYpGNsRRdF
         65mb8VixXowYgdVe8WjZPh2RHYKPnoki1CKrBhxdeBHJhfldtzQ4h/aV2y/Nw/FVJhaL
         bI4rg3MLS4h5S0iSerXCrMdlMd1Vef+xkp/88aDYxcvvJYOcN0JPnww9vhB6K2OH2GGN
         2QKnhLlyoUpCDH1b4J/dsTN7C196TR/ifzNbAwGlZ17Dtq25JH/kNZ8WQ3FPJxIl0ouy
         t03J/+YzdsFv0EvkL9HAmD73iBzqSO2u2PoqrbOamr/YDQpTbHwR/QywBXqQTYxeax4D
         2fAQ==
X-Gm-Message-State: AOJu0YwdfwsFh5O9MKRa7wPUxzpSfyAckEOXSsnVctUgO7hpT7oyZfp5
	Qg8DTOp1cpCjlj8VNX4BrKk=
X-Google-Smtp-Source: AGHT+IHktO5iyJ8ax6IgUqqlUz/7/2ZFRiMQ/cNZeTML1KMlDf3uU348tWW4EFCBlOekdreOvgXVsw==
X-Received: by 2002:aa7:ccda:0:b0:556:a28d:470b with SMTP id y26-20020aa7ccda000000b00556a28d470bmr239190edt.137.1704210459941;
        Tue, 02 Jan 2024 07:47:39 -0800 (PST)
Received: from ?IPV6:2a01:c23:c1df:9400:2dfa:6a98:a1f2:c23c? (dynamic-2a01-0c23-c1df-9400-2dfa-6a98-a1f2-c23c.c23.pool.telefonica.de. [2a01:c23:c1df:9400:2dfa:6a98:a1f2:c23c])
        by smtp.googlemail.com with ESMTPSA id x7-20020aa7cd87000000b00555b548c3fesm6094075edv.29.2024.01.02.07.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 07:47:39 -0800 (PST)
Message-ID: <8dbad648-561d-407a-9d2f-41175acccff4@gmail.com>
Date: Tue, 2 Jan 2024 16:47:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] net: mdio_bus: make check in mdiobus_prevent_c45_scan
 more granular
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c379276f-2276-4c15-b483-7379b16031f7@gmail.com>
 <ZZQpK9Uw72qhxA6l@shell.armlinux.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <ZZQpK9Uw72qhxA6l@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02.01.2024 16:18, Russell King (Oracle) wrote:
> On Tue, Jan 02, 2024 at 03:38:05PM +0100, Heiner Kallweit wrote:
>> Matching on OUI level is a quite big hammer. So let's make matching
>> more granular.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>> This is what I'm thinking of. Maybe the problem of misbehaving
>> on c45 access affects certain groups of PHY's only.
>> Then we don't have to blacklist all PHY's from this vendor.
>> What do you think?
>> ---
>>  drivers/net/phy/mdio_bus.c | 18 +++++++++++++-----
>>  1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
>> index 6cf73c156..848d5d2d6 100644
>> --- a/drivers/net/phy/mdio_bus.c
>> +++ b/drivers/net/phy/mdio_bus.c
>> @@ -621,19 +621,27 @@ static int mdiobus_scan_bus_c45(struct mii_bus *bus)
>>   */
>>  static bool mdiobus_prevent_c45_scan(struct mii_bus *bus)
>>  {
>> -	int i;
>> +	const struct {
>> +		u32 phy_id;
>> +		u32 phy_id_mask;
>> +	} id_list[] = {
>> +		{ MICREL_OUI << 10, GENMASK(31, 10) },
>> +	};
> 
> Do we need a new structure? Would struct mdio_device_id do (which
> actually has exactly the same members with exactly the same names in
> exactly the same order.)
> 
> Also, as this is not static, the compiler will need to generate code
> to initialise the structure, possibly storing a copy of it in the
> .data segment and memcpy()ing it onto the kernel stack. I suggest
> marking it static to avoid that unnecessary hidden code complexity.
> 
Both good points. I missed the static declaration.

>> +		for (j = 0; j < ARRAY_SIZE(id_list); j++) {
>> +			u32 mask = id_list[j].phy_id_mask;
>> +
>> +			if ((phydev->phy_id & mask) == (id_list[j].phy_id & mask))
> 
> 			if (phy_id_compare(phydev->phy_id, id_list[j].phy_id,
> 					   id_list[j].phy_id_mask))
> 
> Or it could be:
> 
> 			const struct mdio_device_id *id = id_list + j;
> 
> 			if (phy_id_compare(phydev->phy_id, id->phy_id,
> 					   id->phy_id_mask))
> 
This looks best to me.


