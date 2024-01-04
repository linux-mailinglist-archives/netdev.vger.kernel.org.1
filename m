Return-Path: <netdev+bounces-61676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EEF824994
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 21:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E80D286A65
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 20:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717D11DFE6;
	Thu,  4 Jan 2024 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0rNVnYJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30EE1DFDC
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e36e29685so1709045e9.3
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 12:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704400225; x=1705005025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F9OT05WNGUD9F90QFBUDNLrrv9qdsolm4BBLPjqeqQs=;
        b=d0rNVnYJJ0musA80m5eCvUYG1a11s4wEet8fwjDDhZZELUFOegaTMJthCR8gcC/T28
         +tiuqx4jh4H6B1t1UXO096IwwVfM3E3ou+h216fu9drQfpccdgZQgv2kBzOqxuXVQcnj
         JdKPrTstkSqSIBoZ1qwlnsnyyqLvklKqmLS+SmxctsE460hGpMb4MM41DZAWNI5ewyYf
         cURZBp7ghS0SwR/aeCp1k3ExoDwf3TFL+rlSyJs/3QCbsSympTPUDwOHGtOEb7fBPU3r
         pYy/hGKQdI/vr3qw6W6fsza2BsN2OCX5RvzZ1d8J/oOUr9yOEfH6utAKkQtpFBOwYtpb
         lJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704400225; x=1705005025;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9OT05WNGUD9F90QFBUDNLrrv9qdsolm4BBLPjqeqQs=;
        b=hiBzvVKT5PxyUxE3m4+EvDM9hEfYaeIefgzrRnMG28r7nFlKg6J/Adv7s5k58wU2sY
         jToPjD3By3HEIe9lvHRoXPNrbt079aR7xHH6qB0qPaGiIbb2FQlBav7riRwBjnUHHVbA
         /m2kOmN8JmbtL/a5qYcrTd4R47rSwCgBtJkJa9BnQ7Kk6I068UzvlhDCyshf+zu8hTu+
         3AgWvwffG09LCxteWcHiR6XYPGD/EeclMBt7fw96ew5UN6PhJ0ioPKURfccnoXDHXxpd
         0yFXgLwIsnScdL8GMGM/nNTm1VVvY1Y/Yyzvh+0Hkl0rrK4stSSJp9PRr9754Gyg2Q+Y
         f5Fg==
X-Gm-Message-State: AOJu0Yyj21oNBtmSSW3Zqcg4sYfsK+dxAcPfCjZ9hJI/pQU+ogilRzFT
	agmz+8NWWS6/kpv6at3hhes=
X-Google-Smtp-Source: AGHT+IFx41VUntDhdEWYXUac2ETQKuGSxAMNogQ4RvExJOVBXx4PriIbAE1DuZ7z+EMaZQLVubkiug==
X-Received: by 2002:a05:600c:458f:b0:40d:8ef2:2e6b with SMTP id r15-20020a05600c458f00b0040d8ef22e6bmr619024wmo.1.1704400224556;
        Thu, 04 Jan 2024 12:30:24 -0800 (PST)
Received: from ?IPV6:2a01:c22:6ffe:b000:1d0:e6df:b486:c903? (dynamic-2a01-0c22-6ffe-b000-01d0-e6df-b486-c903.c22.pool.telefonica.de. [2a01:c22:6ffe:b000:1d0:e6df:b486:c903])
        by smtp.googlemail.com with ESMTPSA id c17-20020a7bc2b1000000b0040d6d755c90sm282466wmk.42.2024.01.04.12.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 12:30:24 -0800 (PST)
Message-ID: <bb1a3694-16bf-4343-bb21-8a3df484773d@gmail.com>
Date: Thu, 4 Jan 2024 21:30:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] ethtool: add struct ethtool_keee and extend
 struct ethtool_eee
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <783d4a61-2f08-41fc-b91d-bd5f512586a2@gmail.com>
 <a044621e-07f3-4387-9573-015f255db895@gmail.com>
 <f704864d-56bb-4ff4-933d-8771d0bb6c19@lunn.ch>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <f704864d-56bb-4ff4-933d-8771d0bb6c19@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04.01.2024 18:16, Andrew Lunn wrote:
> On Mon, Jan 01, 2024 at 10:23:15PM +0100, Heiner Kallweit wrote:
>> In order to pass EEE link modes beyond bit 32 to userspace we have to
>> complement the 32 bit bitmaps in struct ethtool_eee with linkmode
>> bitmaps. Therefore, similar to ethtool_link_settings and
>> ethtool_link_kesettings, add a struct ethtool_keee. Use one byte of
>> the reserved fields in struct ethtool_eee as flag that an instance
>> of struct ethtool_eee is embedded in a struct ethtool_keee, thus the
>> linkmode bitmaps being accessible. Add ethtool_eee2keee() as accessor.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  include/linux/ethtool.h      | 18 ++++++++++++++++++
>>  include/uapi/linux/ethtool.h |  4 +++-
>>  2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
>> index cfcd952a1..3b46405dd 100644
>> --- a/include/linux/ethtool.h
>> +++ b/include/linux/ethtool.h
>> @@ -163,6 +163,24 @@ static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
>>  #define __ETHTOOL_DECLARE_LINK_MODE_MASK(name)		\
>>  	DECLARE_BITMAP(name, __ETHTOOL_LINK_MODE_MASK_NBITS)
>>  
>> +struct ethtool_keee {
>> +	struct ethtool_eee eee;
>> +	struct {
>> +		__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
>> +		__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
>> +		__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising);
>> +	} link_modes;
>> +	bool use_link_modes;
>> +};
> 
> I know its a lot more work, but its not how i would do it.
> 
> 1) Add struct ethtool_keee which is a straight copy of ethtool_eee.
> 
I think I would make some (compatible) changes.
Member cmd isn't needed, and the type of the boolean values that is
__u32 currently I'd change to bool.

> 2) Then modify every in kernel MAC driver using ethtool_eee to
> actually take ethtool_keee. Since its identical, its just a function
> prototype change.
> 
> 3) Then i would add some helpers to get and set eee bits. The initial
> version would be limited to 32 bits, and expect to be passed a pointer
> to a u32. Them modify all the MAC drivers which manipulate the
> supported, advertising and lp_advertising to use these helpers.
> 
> 4) Lastly, flip supported, advertising and lp_advertising to
> ETHTOOL_DECLARE_LINK_MODE_MASK, modify the helpers, and fixup the
> IOCTL API to convert to legacy u32 etc.
> 
> The first 2 steps are a patch each. Step 3 is a lot of patches, one
> per MAC driver, but the changes should be simple and easy to
> review. And then 4 is probably a single patch.
> 
I hope we get away with step 2 being a single patch, as it is a pure
mechanical change. Typically a series is needed with one patch per
module, then having to wait for the ACK from the respective maintainers.
Can we get an OK upfront for the single patch approach?

> Doing it like this, we have a clean internal API.
> 
This indeed looks like the cleanest solution approach to me.
One benefit would be that we can almost completely get rid of the
strict data structure based coupling between userspace and kernel.
However this applies only if we keep the ioctl interface out of scope.

Is it consensus that the ioctl interface is considered legacy and
extended functionality may be implemented for the netlink interface only?
An upfront maintainer OK would be helpful.

I don't like the link settings ioctl handshake too much, which is needed
to communicate the number of bits in a linkmode bitmap to userspace.
Presumably we had to reuse this approach for EEE linkmode bitmaps if
we want to support linkmode bitmaps over ioctl.

>       Andrew
> 
> 
Heiner


