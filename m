Return-Path: <netdev+bounces-55149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B824809931
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 03:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64651F21165
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 02:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653EE37A;
	Fri,  8 Dec 2023 02:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKLNFjcd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688931708
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 18:30:47 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5d226f51f71so15270997b3.3
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 18:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702002646; x=1702607446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gPFzsWif4JOmQ6Tsvqo3ehgr2PEw06oPAeKXnjWTZ+c=;
        b=AKLNFjcdAxiQgVG2tGNfHabFRlXIDVQl7FDDiHRtKD9pMjX9EhrojHZGU8A6GI4oNB
         yuMCnerK+tJEml4Qkq9icqwV2xwvoeK4c3hbar3s0V/9enlNP1ZuCkJf90diRqpV3wOC
         nmNDLwqLuR6QkoayfLCTUQauMxjx7pi/X2oPgwlyqZlIP8K3LtObppjdobIcC8If4vHe
         kDLgB8Otu2dc/Tx4U8hALyUN6UdexYcVIvow8Va43Jd7CFzAqcx7uZx59q+geKmyMW24
         Qq1BZ6n1zArFahqBra4afH56O8Sjq/hUEqEyCbQg+z/vN8c75fdYvHvDLmQKFThP0UuG
         d1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702002646; x=1702607446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gPFzsWif4JOmQ6Tsvqo3ehgr2PEw06oPAeKXnjWTZ+c=;
        b=OUB8pN/DD5nDCc8wXQJHKikiJF175yeMsRWxt+DvwUcNqRHHhbbM0qGjuIc51hD5mH
         CHDhjY/8uu+6b3CNAsTjHNKSIi7DjvKLSTccRJVkcB58xtqlaiuE78zwSA5B+BPHTDQC
         XDi+w4cQceaJjW96KahWy9dZdQLTmlwjI2TSGLW5cSsr4nGlhZFymRjkMHsgtKrpZVfT
         oYPFbbQAj+N92sU0dW8UMux5kpxlomGWHc9EWh/eCPin/6osQXeqi1rJJRhcyFR37y7o
         ZQRzIv8rRt3Q63uy4iHFqsPXxk0UgQSMGzkBGSJRIvqg1phJeJKagcJCbkwM4RS0zSHO
         TVJA==
X-Gm-Message-State: AOJu0YyoCieTlkcS0kF3t7sHs6Uih8tym77gslVtQbmL61Va1KJ+IvSy
	44cPYXavMQHstuG8+ZVC3hWzseDJcIE=
X-Google-Smtp-Source: AGHT+IGvtktP222WoL3SNePrllIsVm4/MIMKU9JQ89aNqrqymBuvUnGxvORvdqIR3IpozaEAmTPLtw==
X-Received: by 2002:a81:ac0c:0:b0:5d7:1940:dd75 with SMTP id k12-20020a81ac0c000000b005d71940dd75mr3114135ywh.75.1702002646514;
        Thu, 07 Dec 2023 18:30:46 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:57df:3a91:11ad:dcd? ([2600:1700:6cf8:1240:57df:3a91:11ad:dcd])
        by smtp.gmail.com with ESMTPSA id y131-20020a0dd689000000b005b59652bcdesm343719ywd.60.2023.12.07.18.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 18:30:46 -0800 (PST)
Message-ID: <831a3aed-8ba3-451f-bd8a-6d8fe63067d1@gmail.com>
Date: Thu, 7 Dec 2023 18:30:44 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/ipv6: insert the fib6 gc_link of a fib6_info
 only if in fib6.
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, thinker.li@gmail.com,
 netdev@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: kuifeng@meta.com, syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
References: <20231207221627.746324-1-thinker.li@gmail.com>
 <8f44514b-f5b4-4fd1-b361-32bb10ed14ad@kernel.org>
 <4eebd408-ee47-4ef0-bb72-0c7abad3eecf@kernel.org>
 <dbccbd5d-8968-43cb-9eca-d19cc12f6515@gmail.com>
 <b6fccc0d-c60b-4f11-9ef7-25b01c25425d@kernel.org>
 <b0fe3183-4df9-42bc-84e4-ba8e807318f4@gmail.com>
 <3d9f78ff-15b4-4c66-a007-a82e4be6d510@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <3d9f78ff-15b4-4c66-a007-a82e4be6d510@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/7/23 17:23, David Ahern wrote:
> On 12/7/23 6:16 PM, Kui-Feng Lee wrote:
>>
>>
>> On 12/7/23 17:02, David Ahern wrote:
>>> On 12/7/23 4:33 PM, Kui-Feng Lee wrote:
>>>>
>>>>
>>>> On 12/7/23 15:20, David Ahern wrote:
>>>>> On 12/7/23 4:17 PM, David Ahern wrote:
>>>>>> On 12/7/23 3:16 PM, thinker.li@gmail.com wrote:
>>>>>>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>>>>>>
>>>>>>> Check f6i->fib6_node before inserting a f6i (fib6_info) to
>>>>>>> tb6_gc_hlist.
>>>>>>
>>>>>> any place setting expires should know if the entry is in a table or
>>>>>> not.
>>>>>>
>>>>>> And the syzbot report contains a reproducer, a kernel config and other
>>>>>> means to test a patch.
>>>>>>
>>>>>
>>>>> Fundamentally, the set and clear helpers are doing 2 things; they need
>>>>> to be split into separate helpers.
>>>>
>>>> Sorry, I don't follow you.
>>>>
>>>> There are fib6_set_expires_locked()) and fib6_clean_expires_locked(),
>>>> two separate helpers. Is this what you are saying?
>>>>
>>>> Doing checks of f6i->fib6_node in fib6_set_expires_locked() should
>>>> already apply everywhere setting expires, right?
>>>>
>>>> Do I miss anything?
>>>
>>> static inline void fib6_set_expires_locked(struct fib6_info *f6i,
>>>                                              unsigned long expires)
>>> {
>>>           struct fib6_table *tb6;
>>>
>>>           tb6 = f6i->fib6_table;
>>>           f6i->expires = expires;
>>>           if (tb6 && !fib6_has_expires(f6i))
>>>                   hlist_add_head(&f6i->gc_link, &tb6->tb6_gc_hlist);
> 
> --> no check that f6i is already in the list yet fib6_set_expires and
> fib6_set_expires_locked are called on existing entries - entries already
> in the tree and so *maybe* already linked. See fib6_add_rt2node and most
> of fib6_set_expires callers.

Although it bases on a false assumption, checking tb6 ensures the
entry is added to the list only if this f6i is already on the tree.
The correct one should checks f6i->fib6_node.
So, with checking f6i->fib6_ndoe and the open code you mentioned,
fib6_has_expires() does check if a f6i is already in the list.

But, like what you mentioned earlier, hlist_unhashed(&f6i->gc_link) is
clearer. I will move to ti.

> 
> Your selftests only check that entries are removed; it does not check
> updating the expires time on an existing entry. It does not check a
> route replace that toggles between no expires value or to an expires
> (fib6_add_rt2node use of fib6_set_expires_locked) and then replacing
> that route -- various permutations here.
> 
> 
>>>           f6i->fib6_flags |= RTF_EXPIRES;
>>> }
>>>
>>> 1. You are abusing this helper in create_info to set the value of
>>> expires knowing (expecting) tb6 to NOT be set and hence not setting
>>> gc_link so no cleanup is needed on errors.
>>>
>>> 2. You then open code gc_link when adding to the tree.
>>>
>>> I had my reservations when you sent this patch months ago, but I did not
>>> have time to suggest a cleaner approach and now this is where we are --
>>> trying to find some race corrupting the list.
>>
>> So, what you said is to split fib6_set_expires_locked() into two
>> functions. One is setting expires, and the other is adding a f6i to
>> tb6_gc_hlist. fib6_clean_expires_locked() should be split in the same
>> way.
>>
>> Is it correct?
>>
> 
> one helper sets expires value and one helper that adds/removes from the
> gc_link. If it is already linked, then no need to do it again.

Got it!

