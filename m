Return-Path: <netdev+bounces-23694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E54076D21C
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE078281CCF
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04DB8F47;
	Wed,  2 Aug 2023 15:35:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C058C0C
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:35:35 +0000 (UTC)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909FB3C0B
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:35:16 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3490ebe5286so16376325ab.1
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690990514; x=1691595314;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rgbhpoSZCaAY7YANv+KXZ/GRWdghwOLHw+lHYp3Qycc=;
        b=NwrG9pQOJKIT0EkQqEL8MmYhwV9pu6jnZeIj+95z3igtpISkKhNivd7VX6dHF7Cmy0
         Ijwp6ETFUfIhvQVYEO+O14UQzfDILc3QkIuss0QCbprPry/EU6ZRSmaAbq45m45nINni
         BNMFl6q8dI9QbrAHj0Ec0HeAi8NuHG40i+Mm3zo8ghtPWRZhrp4GiIOES5ggXnnC74mY
         +XJik1BTLx6KaNx7YbbH5CfoE0/7u4aqiBy3i6NrQVZORII/h1qk/grztScE1N4v3D4T
         e5D4wwB2Z///ficXObWPlmD/TrdwcLcSvBMiEGz7gv9U8P+RVhQoUGBKst7kxq344mmf
         tnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690990514; x=1691595314;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rgbhpoSZCaAY7YANv+KXZ/GRWdghwOLHw+lHYp3Qycc=;
        b=dVt9X/UKoblXkHH0/iBGsN3b9yBK6LsvNMAbnHaumZ1WTwyTYDmJ0/BW8OmxXEy2kB
         IQ0F/F8xPhRyUUt2m2XYLEEb83Qr11c7rF9dXiC7xqNnttBU6rE3gjUkgUT4aL4s1aLa
         4/A5SGlgwyriGIdcrEutCBo4hIAXaYql94z4c9tMz5Ji3D4DLV6bw9ceyHm/82nJ/0L6
         ht4iR9TaJE7kFrZ8pQJ1ry7DlrbWfBY+33aAV3seOJBzfH1GXI2ProgkMcOIROtEpfP0
         Eg2QfoLyEO7D6p/FTWcPo3JBOwDlW9VvejELJ5C713iUT7GcnncRFr3yH4FXwKyPB6Of
         Zb0g==
X-Gm-Message-State: ABy/qLaxgZ+9z/+xDimYfFZyFKCJHuk+kalzqqQRYGDi/sSpjGKESrEz
	whntSaLXI3ZF714J7Es+osk=
X-Google-Smtp-Source: APBJJlHnyBv4o0Nnki4Ji5t4jNVA8QbhZlbeDvKKk70zBH/u8W5jy0lej42fmR9BYcQqBPZ8f/NCmQ==
X-Received: by 2002:a05:6e02:1a2b:b0:345:a6c5:1ce8 with SMTP id g11-20020a056e021a2b00b00345a6c51ce8mr17884143ile.14.1690990514168;
        Wed, 02 Aug 2023 08:35:14 -0700 (PDT)
Received: from ?IPV6:2601:282:800:7ed0:bd1d:fe8d:d220:8378? ([2601:282:800:7ed0:bd1d:fe8d:d220:8378])
        by smtp.googlemail.com with ESMTPSA id a8-20020a926608000000b00348ac48e127sm4641706ilc.33.2023.08.02.08.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 08:35:13 -0700 (PDT)
Message-ID: <16c562ce-433d-ac78-95ad-101bef710efc@gmail.com>
Date: Wed, 2 Aug 2023 09:35:12 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH iproute2-next] bridge: Add backup nexthop ID support
Content-Language: en-US
To: Ido Schimmel <idosch@idosch.org>, Petr Machata <petrm@nvidia.com>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 stephen@networkplumber.org, razor@blackwall.org
References: <20230801152138.132719-1-idosch@nvidia.com>
 <87sf91enuf.fsf@nvidia.com> <ZMpNRzXKIS7ZzSVN@shredder>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <ZMpNRzXKIS7ZzSVN@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/2/23 6:34 AM, Ido Schimmel wrote:
> On Wed, Aug 02, 2023 at 11:55:26AM +0200, Petr Machata wrote:
>>
>> Ido Schimmel <idosch@nvidia.com> writes:
>>
>>> diff --git a/bridge/link.c b/bridge/link.c
>>> index b35429866f52..c7ee5e760c08 100644
>>> --- a/bridge/link.c
>>> +++ b/bridge/link.c
>>> @@ -186,6 +186,10 @@ static void print_protinfo(FILE *fp, struct rtattr *attr)
>>>  				     ll_index_to_name(ifidx));
>>>  		}
>>>  
>>> +		if (prtb[IFLA_BRPORT_BACKUP_NHID])
>>> +			print_uint(PRINT_ANY, "backup_nhid", "backup_nhid %u ",
>>> +				   rta_getattr_u32(prtb[IFLA_BRPORT_BACKUP_NHID]));
>>> +
>>
>> This doesn't build on current main. I think we usually send the relevant
>> header sync patch, but maybe there's an assumption the maintainer pushes
>> it _before_ this patch? I'm not sure, just calling it out.
> 
> Not needed. David syncs the headers himself.

just pushed the update.

> 
>>
>>>  		if (prtb[IFLA_BRPORT_ISOLATED])
>>>  			print_on_off(PRINT_ANY, "isolated", "isolated %s ",
>>>  				     rta_getattr_u8(prtb[IFLA_BRPORT_ISOLATED]));
>>> @@ -311,6 +315,7 @@ static void usage(void)
>>>  		"                               [ mab {on | off} ]\n"
>>>  		"                               [ hwmode {vepa | veb} ]\n"
>>>  		"                               [ backup_port DEVICE ] [ nobackup_port ]\n"
>>> +		"                               [ backup_nhid NHID ]\n"
>>
>> I thought about whether there should be "nobackup_nhid", but no. The
>> corresponding nobackup_port is necessary because it would be awkward to
>> specify "backup_port ''" or something. No such issue with NHID.
>>
>>>  		"                               [ self ] [ master ]\n"
>>>  		"       bridge link show [dev DEV]\n");
>>>  	exit(-1);
>>> @@ -330,6 +335,7 @@ static int brlink_modify(int argc, char **argv)
>>>  	};
>>>  	char *d = NULL;
>>>  	int backup_port_idx = -1;
>>> +	__s32 backup_nhid = -1;
>>>  	__s8 neigh_suppress = -1;
>>>  	__s8 neigh_vlan_suppress = -1;
>>>  	__s8 learning = -1;
>>> @@ -493,6 +499,10 @@ static int brlink_modify(int argc, char **argv)
>>>  			}
>>>  		} else if (strcmp(*argv, "nobackup_port") == 0) {
>>>  			backup_port_idx = 0;
>>> +		} else if (strcmp(*argv, "backup_nhid") == 0) {
>>> +			NEXT_ARG();
>>> +			if (get_s32(&backup_nhid, *argv, 0))
>>> +				invarg("invalid backup_nhid", *argv);
>>
>> Not sure about that s32. NHID's are unsigned in general. I can add a
>> NHID of 0xffffffff just fine:
>>
>> # ip nexthop add id 0xffffffff via 192.0.2.3 dev Xd
>>
>> (Though ip nexthop show then loops endlessly probably because -1 is used
>> as a sentinel in the dump code. Oops!)

ugh, please send a fix.


