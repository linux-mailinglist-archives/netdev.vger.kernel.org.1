Return-Path: <netdev+bounces-40239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901947C65DB
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 08:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0B21C20B13
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 06:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1253DDA8;
	Thu, 12 Oct 2023 06:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="EkYMohy9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F0BD296
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 06:47:59 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE26BA
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:47:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4054496bde3so6630275e9.1
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1697093276; x=1697698076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=McAn7XXo5ik6ohNaPH4SqxrrsZVKvhppZZA60/ZS6go=;
        b=EkYMohy9EixrqwY5r2CuN0zz2o1EtSx7q5s2aVi83HyDfc1cCf0z+kKsS8ZpfzUXeC
         F2sf63hCG5ymropNnVDbDsAgr8gk71mKvtD/1dn5kLsr/97F3MO4WBJWRkBj2kCOqDI4
         anlR7i/eJTPtODCUv9Ck/UORFy0AddRIrXQEIUGweFsb5yFo3CXTutM9abS4RAb8F8z5
         A0a2O/9h6rjLmwNG40yXPRtTEb+kHKsrzjvP9k49V0gOYjyZU1HvFPRGNKzZteiJv54N
         aPzftAyZO2N7gkPMD0zPUmOdrVdYunziw7zwKBpU4CbvnjsbV4p1YrlUtTgNlS65xMTM
         pN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697093276; x=1697698076;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McAn7XXo5ik6ohNaPH4SqxrrsZVKvhppZZA60/ZS6go=;
        b=FyMoEuLZAxG2CXn9oR/E3TMudoHC+mt7+dL/dXw1wj3G0YaZh3mDfBr/V26ltkqPfy
         uEwOCQkQ1vVFO+wlLNhvCRcjJFmRKjLsuGlOXAhHrVuCQSHKB571WNOnkPas2UZU0ePD
         iFahNwjIWgPfeJnNX6lERM+IXECxaFvHs/mB7100d1ggbyt78/9d61Bzmhi0vjjC0A/M
         IlpZ2Dds33NMeTlTQJ8/C7s87JA6/oGtp9D7hjBSkiEFLMWs/IQY9q/4HvmpXOR3ezNX
         KcbJ4I0CG/sJ5P1WNak1OX4GrFqZK3hMJfMcathPncnp4ONAimgAf1o62M1bFk70EFYQ
         eQFQ==
X-Gm-Message-State: AOJu0Yz4re2LwGhcpihbm4MFWUMTbTs5Yun8+zIxgyVtZbqOIcwvIy59
	B1K8Atqqwll4ESLrA7uRgvENVQ==
X-Google-Smtp-Source: AGHT+IFEY9RkFwacHqiCB62rS9yvuSISGruhHOV8JF0g17WOafZzldsWjDVM4TJb87Ej6choX9Wdtw==
X-Received: by 2002:a7b:c8d7:0:b0:405:3b92:2fed with SMTP id f23-20020a7bc8d7000000b004053b922fedmr19676673wml.26.1697093276264;
        Wed, 11 Oct 2023 23:47:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:19ad:3130:804:e23? ([2a01:e0a:b41:c160:19ad:3130:804:e23])
        by smtp.gmail.com with ESMTPSA id z5-20020a7bc7c5000000b00401bbfb9b2bsm698355wmk.0.2023.10.11.23.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 23:47:55 -0700 (PDT)
Message-ID: <8d3fc502-f568-4fab-96e3-aead6bd29063@6wind.com>
Date: Thu, 12 Oct 2023 08:47:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [RFC] netlink: add variable-length / auto integers
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
 fw@strlen.de, pablo@netfilter.org, jiri@resnulli.us, mkubecek@suse.cz,
 aleksander.lobakin@intel.com, Thomas Haller <thaller@redhat.com>
References: <20231011003313.105315-1-kuba@kernel.org>
 <f75851720c356fe43771a5c452d113ca25d43f0f.camel@sipsolutions.net>
 <6ec63a78-b0cc-452e-9946-0acef346cac2@6wind.com>
 <20231011085230.2d3dc1ab@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20231011085230.2d3dc1ab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



Le 11/10/2023 à 17:52, Jakub Kicinski a écrit :
> On Wed, 11 Oct 2023 16:03:26 +0200 Nicolas Dichtel wrote:
>>> On Tue, 2023-10-10 at 17:33 -0700, Jakub Kicinski wrote:  
>>>> We currently push everyone to use padding to align 64b values in netlink.
>>>> I'm not sure what the story behind this is. I found this:
>>>> https://lore.kernel.org/all/1461339084-3849-1-git-send-email-nicolas.dichtel@6wind.com/#t  
>> There was some attempts before:
>> https://lore.kernel.org/netdev/20121205.125453.1457654258131828976.davem@davemloft.net/
>> https://lore.kernel.org/netdev/1355500160.2626.9.camel@bwh-desktop.uk.solarflarecom.com/
>> https://lore.kernel.org/netdev/1461142655-5067-1-git-send-email-nicolas.dichtel@6wind.com/
>>
>>>> but it doesn't go into details WRT the motivation.
>>>> Even for arches which don't have good unaligned access - I'd think
>>>> that access aligned to 4B *is* pretty efficient, and that's all
>>>> we need. Plus kernel deals with unaligned input. Why can't user space?  
>>>
>>> Hmm. I have a vague recollection that it was related to just not doing
>>> it - the kernel will do get_unaligned() or similar, but userspace if it
>>> just accesses it might take a trap on some architectures?
>>>
>>> But I can't find any record of this in public discussions, so ...  
>> If I remember well, at this time, we had some (old) architectures that triggered
>> traps (in kernel) when a 64-bit field was accessed and unaligned. Maybe a mix
>> between 64-bit kernel / 32-bit userspace, I don't remember exactly. The goal was
>> to align u64 fields on 8 bytes.
> 
> Reading the discussions I think we can chalk the alignment up 
> to "old way of doing things". Discussion was about stats64, 
> if someone wants to access stats directly in the message then yes, 
> they care a lot about alignment.
> 
> Today we try to steer people towards attr-per-field, rather than
> dumping structs. Instead of doing:
> 
> 	struct stats *stats = nla_data(attr);
> 	print("A: %llu", stats->a);
> 
> We will do:
> 
> 	print("A: %llu", nla_get_u64(attrs[NLA_BLA_STAT_A]));
> 
> Assuming nla_get_u64() is unalign-ready the problem doesn't exist.
> 
> If user space goes thru a standard parsing library like YNL
> the application never even sees the raw netlink message,
> and deals with deserialized structs.
> 
> 
> Does the above sounds like a fair summary? If so I'll use it in 
> the commit message?
I think it is, it's ok for me.


Thank you,
Nicolas

