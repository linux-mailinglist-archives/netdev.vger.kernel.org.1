Return-Path: <netdev+bounces-45912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 506607E0498
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 15:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8106C1C2098F
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 14:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63FD18E1F;
	Fri,  3 Nov 2023 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="H/t/DJRN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8181A58E
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 14:22:03 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2C4D49
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 07:21:58 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-408382da7f0so15628275e9.0
        for <netdev@vger.kernel.org>; Fri, 03 Nov 2023 07:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1699021317; x=1699626117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5Uk4CPF0BBRF+bVj0s0eL7CcpvLknK4GIdu9RnpX2Es=;
        b=H/t/DJRNfLVo4Ucx8eyVC4ozwYl+RbiRiz5q5/BraGmD39fXvuB40nxRkCFSARxLRA
         UDmSVT78+WT7UaHV8xnXjCDomKGTdI4DfU10IV1KYS9Gv/8cnzpzCcBvVVhAXfOrl6Uy
         LF7YrbGtM/Sf4vZ3xW3FGXVFG4GGBQcpBjbddwpiMC+2tuLLQQYahwS4UYTClkayK2dE
         dQGbW3SXliUviLtjomCa9AIyE4jBQHPvfTvf6ZO+WWy0nPT6ddXUocs85e0fO8l9ptUL
         JqZoqyG8ua4Xj2iBOFXDMsEG0Ggpdp3dg9V8Vub4hAdJdanrDWg60kQLntvqGUeoFvWJ
         Crow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699021317; x=1699626117;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Uk4CPF0BBRF+bVj0s0eL7CcpvLknK4GIdu9RnpX2Es=;
        b=JFJD4f4BrOpDnOgZ4kTSjXSQmpVreoUSErU/DWMkMpU0ynyIDgoQLSqWqyPMOwq4RM
         Kp4grau1OzyPNMLS4mV4jcawNFiNj1O7hP3PUfctKSTDkYy9cjFHGYPz2C5qY5ds5xt3
         MODLGOUKdUf+W70NwHPyeacqtJPxYHtyBIO86wX+hj/B6fpaH6/ynrWc14xpwcesFxn9
         1tskoh/1rKOo8IQMGQdNAEhKRJQzY0LXLqH8fsASBLe8c0RBjf4VktK+nXIU4REzMY4T
         LO9nZvswM8vQTXKz+PyHadGcSNVqf17Brr+eGoP9g0hNu4HRV+ZbuTgM91V3Rga5CU2s
         3uHQ==
X-Gm-Message-State: AOJu0Yy20DDHgICh+kr+pdTHW29rb3Bejts0VIW1JuGzUfS4E1m83hEb
	rBj7audtdnPkW7kylxVmTiaKdg==
X-Google-Smtp-Source: AGHT+IE4+EnnbWCGrqzcO5dvKllV5bvlEnU72oSI3Z0wbn6Ot+ltDahvbMO1g1tBXq2y2IiyLU5NsQ==
X-Received: by 2002:a05:600c:458e:b0:408:3fae:d809 with SMTP id r14-20020a05600c458e00b004083faed809mr18376719wmo.17.1699021316858;
        Fri, 03 Nov 2023 07:21:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:7bea:b090:d69:c878? ([2a01:e0a:b41:c160:7bea:b090:d69:c878])
        by smtp.gmail.com with ESMTPSA id h21-20020a05600c499500b0040586360a36sm2579011wmp.17.2023.11.03.07.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 07:21:56 -0700 (PDT)
Message-ID: <7627f7d5-89d5-487a-938a-5156be9d4fbd@6wind.com>
Date: Fri, 3 Nov 2023 15:21:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH] net: ipmr_base: Check iif when returning a (*, G) MFC
Content-Language: en-US
To: Yang Sun <sunytt@google.com>
Cc: Ido Schimmel <idosch@idosch.org>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20231031015756.1843599-1-sunytt@google.com>
 <ZUNxcxMq8EW0cVUT@shredder>
 <CAF+qgb4gW8vBb8c2xDHfsXsm1-O2KCwXMCTUcT2mYqED51fHoQ@mail.gmail.com>
 <fc356b9d-d7fc-4db8-b26c-8c786758d3e5@6wind.com>
 <CAF+qgb6uUF-Z8EkZoqzfboaCZv4PP6yG_r=-2ojaG9T61Kg3jA@mail.gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <CAF+qgb6uUF-Z8EkZoqzfboaCZv4PP6yG_r=-2ojaG9T61Kg3jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 03/11/2023 à 12:05, Yang Sun a écrit :
> On Thu, Nov 2, 2023 at 10:19 PM Nicolas Dichtel
> <nicolas.dichtel@6wind.com> wrote:
>>
>> Le 02/11/2023 à 12:48, Yang Sun a écrit :
>>>> Is this a regression (doesn't seem that way)? If not, the change should
>>>> be targeted at net-next which is closed right now:
>>>
>>>> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>>>
>>> I see.
>>>
>>>>> - if (c->mfc_un.res.ttls[vifi] < 255)
>>>>> + if (c->mfc_parent == vifi && c->mfc_un.res.ttls[vifi] < 255)
>>>
>>>> What happens if the route doesn't have an iif (-1)? It won't match
>>>> anymore?
>>>
>>> Looks like the mfc_parent can't be -1? There is the check:
>>>     if (mfc->mf6cc_parent >= MAXMIFS)
>>>         return -ENFILE;
>>> before setting the parent:
>>>     c->_c.mfc_parent = mfc->mf6cc_parent;
>>>
>>> I wrote this patch thinking (*, G) MFCs could be per iif, similar to the
>>> (S, G) MFCs, like we can add the following MFCs to forward packets from
>>> any address with group destination ff05::aa from if1 to if2, and forward
>>> packets from any address with group destination ff05::aa from if2 to
>>> both if1 and if3.
>>>
>>> (::, ff05::aa)      Iif: if1 Oifs: if1 if2  State: resolved
>>> (::, ff05::aa)      Iif: if2 Oifs: if1 if2 if3  State: resolved
>>>
>>> But reading Nicolas's initial commit message again, it seems to me that
>>> (*, G) has to be used together with (*, *) and there should be only one
>>> (*, G) entry per group address and include all relevant interfaces in
>>> the oifs? Like the following:
>>>
>>> (::, ::)         Iif: if1 Oifs: if1 if2 if3   State: resolved
>>> (::, ff05::aa)   Iif: if1 Oifs: if1 if2 if3   State: resolved
>>>
>>> Is this how the (*, *|G) MFCs are intended to be used? which means packets
>>> to ff05::aa are forwarded from any one of the interfaces to all the other
>>> interfaces? If this is the intended way it works then my patch would break
>>> things and should be rejected.
>> Yes, this was the intend. Only one (*, G) entry was expected (per G).
>>
>>>
>>> Is there a way to achieve the use case I described above? Like having
>>> different oifs for different iif?
>> Instead of being too strict, maybe you could try to return the 'best' entry.
>>
>> #1 (::, ff05::aa)      Iif: if1 Oifs: if1 if2  State: resolved
>> #2 (::, ff05::aa)      Iif: if2 Oifs: if1 if2 if3  State: resolved
>>
>> If a packet comes from if2, returns #2, but if a packet comes from if3, returns
>> the first matching entry, ie #1 here.
>>
> 
> Thanks for your reply Nicolas!
> Here if it returns the first matching then it depends on which entry
> is returned first
> by the hash table lookup, the forwarding behavior may be indeterminate
> in that case
> it seems.
As I said, only one (*,G) entry was expected thus the 'first' one is
indeterminate if there are several entries.

> 
> If a packet has no matching (*, G) entry, then it will use the (*, *)
> entry to be forwarded
> to the upstream interface in (*, *). And with the (*, *) it means we
> won't get any nocache upcall
> for interfaces included in the static tree, right? So the (S, G) MFC
> and the static proxy MFCs
> are not meant to be used together?
Not together. With proxy multicast, the multicast tree is static, ie there is no
multicast daemon. Mcast packets received from one interface are sent to the
other interfaces that are part of the tree.


Regards,
Nicolas

> 
> I wonder how a real use case with (*, G|*) would look like, what
> interface could be an
> upstream interface. Is there an example?
> 
> Thanks,
> Yang
> 
>>
>> Regards,
>> Nicolas

