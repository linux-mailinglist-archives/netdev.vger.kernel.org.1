Return-Path: <netdev+bounces-40196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930A47C61A6
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 02:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880A01C209A4
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA552362;
	Thu, 12 Oct 2023 00:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY/hfOo7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389F019B
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 00:22:00 +0000 (UTC)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D761594
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 17:21:55 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-419cc494824so2940651cf.2
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 17:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697070115; x=1697674915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BbLCvUhQaur8pm/sGWLA1Dtqyo11Qx+qwU1iHbr55DU=;
        b=mY/hfOo7OxUHHnSF6ryTYBD+l0Z0Y2gridY4G6VAvk7wl5gQpLero7i5xalFU7qT/5
         xnJRjzJcD+DybuzWiim3v2Itsi9rVfvxK3hoBYK/YS5LhLuIJnCsqQhDRYFLjE0LSndO
         c+1c+noW3SAiSaxBoDwxvYCloyR8QFXpuw7KVDjJSlkuAKqBUu9wSSS0C4U3rqSF6Vob
         ChxuY/8P1nbNW1HxLIQ5LrVyn8NBfLv9fpVd6BVtO/372JCP+RG9PAdpHljOO8ybG5sV
         hTj8/9OndK0GITHWmJAtc1Teih+2amevvcq8JbW9iYQGPuwr7NCn4qnPoau9A/yezxsH
         kJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697070115; x=1697674915;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BbLCvUhQaur8pm/sGWLA1Dtqyo11Qx+qwU1iHbr55DU=;
        b=R0FEDrKjtZ0Y7B+Rhi0WIXHAI4PpuKIgqoAYyfA8N3tv0UXZJI5bGXZ/kDX8m3va22
         a0MvpaqMyyFWq3NeIIhUTwGyNBWg3X/Zp0uA1ZKmqsQ27buoDfpbRZgrfKEySg5bkAMj
         d85vtWdYD6isqfpvA8oyFkbu/Q9aPIaC1cEphxX03t3/+AtHylJBFYAmm9z5kk1kagCR
         zQ+Y3Ep7MjjjZnmcZj8pThl7SHR52hmAWgUIEJ//izUSSXbS77AtpGYNgcMVSzKdP5K7
         +zrk4aoni8Pn4EppBrv9HE4tXQSgGW3bwJlJtDwhakS2196UHiDhl9Wf6MCvdLXpzt87
         9GWw==
X-Gm-Message-State: AOJu0YxFtgaHvvrd4HFMO/kB9Lvotnj43aUjPHu9mdxulWZ1NW8jdJl9
	g8O641LljVpRjP2rQVKDprI=
X-Google-Smtp-Source: AGHT+IGMVghEh/c5yL4QZKRpOoIapV5neu37m52mg+L9i8oiSBwElJYrkzMxF7pOHmuEN1vR8Gqqlw==
X-Received: by 2002:ac8:5813:0:b0:418:1e88:83ca with SMTP id g19-20020ac85813000000b004181e8883camr29294712qtg.40.1697070114838;
        Wed, 11 Oct 2023 17:21:54 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id v18-20020ac87292000000b00419c9215f0asm5711649qto.53.2023.10.11.17.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 17:21:54 -0700 (PDT)
Message-ID: <3229ff0a-5ce5-4ee2-a79d-15007f2b6030@gmail.com>
Date: Wed, 11 Oct 2023 17:21:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] ethtool: Introduce WAKE_MDA
Content-Language: en-US
To: Michal Kubecek <mkubecek@suse.cz>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, opendmb@gmail.com, justin.chen@broadcom.com
References: <20231011221242.4180589-1-florian.fainelli@broadcom.com>
 <20231011221242.4180589-2-florian.fainelli@broadcom.com>
 <20231011230821.75axavcrjuy5islt@lion.mk-sys.cz>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20231011230821.75axavcrjuy5islt@lion.mk-sys.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/11/2023 4:08 PM, Michal Kubecek wrote:
> On Wed, Oct 11, 2023 at 03:12:39PM -0700, Florian Fainelli wrote:
>> Allow Ethernet PHY and MAC drivers with simplified matching logic to be
>> waking-up on a custom MAC destination address. This is particularly
>> useful for Ethernet PHYs which have limited amounts of buffering but can
>> still wake-up on a custom MAC destination address.
>>
>> When WAKE_MDA is specified, the "sopass" field in the existing struct
>> ethtool_wolinfo is re-purposed to hold a custom MAC destination address
>> to match against.
>>
>> Example:
>> 	ethtool -s eth0 wol e mac-da 01:00:5e:00:00:fb
>>
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
>>   Documentation/networking/ethtool-netlink.rst |  7 ++++++-
>>   include/uapi/linux/ethtool.h                 | 10 ++++++++--
>>   include/uapi/linux/ethtool_netlink.h         |  1 +
>>   net/ethtool/common.c                         |  1 +
>>   net/ethtool/netlink.h                        |  2 +-
>>   net/ethtool/wol.c                            | 21 ++++++++++++++++++++
>>   6 files changed, 38 insertions(+), 4 deletions(-)
>>
> [...]
>> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
>> index f7fba0dc87e5..8134ac8870bd 100644
>> --- a/include/uapi/linux/ethtool.h
>> +++ b/include/uapi/linux/ethtool.h
>> @@ -207,12 +207,17 @@ struct ethtool_drvinfo {
>>    * @wolopts: Bitmask of %WAKE_* flags for enabled Wake-On-Lan modes.
>>    * @sopass: SecureOn(tm) password; meaningful only if %WAKE_MAGICSECURE
>>    *	is set in @wolopts.
>> + * @mac_da: Destination MAC address to match; meaningful only if
>> + *	%WAKE_MDA is set in @wolopts.
>>    */
>>   struct ethtool_wolinfo {
>>   	__u32	cmd;
>>   	__u32	supported;
>>   	__u32	wolopts;
>> -	__u8	sopass[SOPASS_MAX];
>> +	union {
>> +		__u8	sopass[SOPASS_MAX];
>> +		__u8	mac_da[ETH_ALEN];
>> +	};
>>   };
> 
> If we use the union here, we should also make sure the request cannot
> set both WAKE_MAGICSECURE and WAKE_MDA, otherwise the same data will be
> used for two different values (and interpreted in two different ways in
> GET requests and notifications).
> 
> Another option would be keeping the existing structure for ioctl UAPI
> and using another structure (like we did in other cases where we needed
> new attributes beyond frozen ioctl structures) so that a combination of
> WAKE_MAGICSECURE and WAKE_MDA is possible. (It doesn't seem to make much
> sense to me to combine WAKE_MAGICSECURE with other bits but I can't rule
> out someone might want that one day.)

I am having some second thoughts about this proposed interface as I can 
see a few limitations:

- we can only specify an exact destination MAC address to match, but the 
HW filter underneath is typically implemented using a match + mask so 
you can actually be selective about which bits you want to match on. In 
the use case that I have in mind we would actually want to match both 
multicast MAC destination addresses corresponding to mDNS over IPv4 or IPv6

- in case a MAC/PHY/switch supports multiple filters/slots we would not 
be able to address a specific slot in the matching logic

This sort of brings me back to the original proposal which allowed this:

https://lore.kernel.org/all/20230516231713.2882879-1-florian.fainelli@broadcom.com/

Andrew, what do you think?

> 
> [...]
>> diff --git a/net/ethtool/wol.c b/net/ethtool/wol.c
>> index 0ed56c9ac1bc..13dfcc9bb1e5 100644
>> --- a/net/ethtool/wol.c
>> +++ b/net/ethtool/wol.c
>> @@ -12,6 +12,7 @@ struct wol_reply_data {
>>   	struct ethnl_reply_data		base;
>>   	struct ethtool_wolinfo		wol;
>>   	bool				show_sopass;
>> +	bool				show_mac_da;
>>   };
>>   
>>   #define WOL_REPDATA(__reply_base) \
>> @@ -41,6 +42,8 @@ static int wol_prepare_data(const struct ethnl_req_info *req_base,
>>   	/* do not include password in notifications */
>>   	data->show_sopass = !genl_info_is_ntf(info) &&
>>   		(data->wol.supported & WAKE_MAGICSECURE);
>> +	data->show_mac_da = !genl_info_is_ntf(info) &&
>> +		(data->wol.supported & WAKE_MDA);
>>   
>>   	return 0;
>>   }
> 
> The test for !genl_info_is_ntf(info) above is meant to prevent the
> sopass value (which is supposed to be secret) from being included in
> notifications which can be seen by unprivileged users. Is the MAC
> address to match also supposed to be secret?

Either way could be considered, so I erred on the side of caution.
-- 
Florian

