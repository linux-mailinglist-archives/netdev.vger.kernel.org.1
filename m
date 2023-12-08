Return-Path: <netdev+bounces-55139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B1C809885
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 02:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64690B20A68
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 01:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F6A10E7;
	Fri,  8 Dec 2023 01:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FljviaaI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A98E85
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 17:16:50 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5d7346442d4so14848247b3.2
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 17:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701998210; x=1702603010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNzjWD132Kyiv7g2yHYR/MNmbDTWow6sWmvwYiVue9k=;
        b=FljviaaIb7vAvF57/Aq+Cn5RyxHcLxLWGW15tE/H25zsKw/rOuBXIsdMI/e0g6b7xe
         UA938FH/XtdDI6/waRGLK+eqNOAXs/Z3kBByBkdPThRmUAKHbKj2V1V2nR3UBxTsldXk
         OHju8p7QArK7MBDvMWrvjM8Dpsj7GP8b5AcMelvqPn5zmC6Jae1MIMZouZnnUrM3Wrup
         C37gaO61dPRJLCPqMIbr4TqOFhmJH5UX4iqZPIvImDVMINTwS/iKXwxf5vpxhxqYYt/+
         AGqwIxqkAnHkd5EdwhOb29d91AXhOE2+XqPvBW1ztI6atR5Z8N4ZKSE6G2Dg0iv1q6tx
         GmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701998210; x=1702603010;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNzjWD132Kyiv7g2yHYR/MNmbDTWow6sWmvwYiVue9k=;
        b=pP4j+OUvJD9KVYdwzCPQc4gb4zwj4jQ4MLM97a4W138PEa+EaTrfaJZylQxr0uZuSl
         W0hytSQtFAwNhkOwavbX3Lu1VH8wiHjOa2ZJd/P0BH9SxtXu4V4kim5N4oPkyIxpkxHd
         DPvJRerTW1+ebM8QtnC7r603TG75+hgToNqPavyFm7Lv6QGgBAreCFZFSpgyrIVMMJNi
         N4/B3znlSQvYOtN5nqSCZWgmi/J4NIACeIxG7KzQDC+oXZJvLsDU9BABHL6HsS0gkn/E
         6ElGM6WSWnWFxs6+LCZQskiC9e1bsPN54ZfO/xs3HmRVX5at3BneNe8pZzMesFHY+aeA
         KIiQ==
X-Gm-Message-State: AOJu0YwVXOuqVrk8oRUxbevmi8BxdsSE/fqJQbltv0eUB/cpUoBdFYTt
	9ptCIwPHeE5ZCNVfi/VpUKs=
X-Google-Smtp-Source: AGHT+IH+gV4DwB3RSas12oUlmOuW39e99AKXY950yF8DzcgiGwhJWG9mCmE9oYhBWFOlDrsCEgmwzw==
X-Received: by 2002:a05:690c:dc4:b0:5d7:1941:3575 with SMTP id db4-20020a05690c0dc400b005d719413575mr3750188ywb.92.1701998209774;
        Thu, 07 Dec 2023 17:16:49 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:57df:3a91:11ad:dcd? ([2600:1700:6cf8:1240:57df:3a91:11ad:dcd])
        by smtp.gmail.com with ESMTPSA id b6-20020a0dd906000000b005d9b5811f21sm314317ywe.37.2023.12.07.17.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 17:16:49 -0800 (PST)
Message-ID: <b0fe3183-4df9-42bc-84e4-ba8e807318f4@gmail.com>
Date: Thu, 7 Dec 2023 17:16:47 -0800
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
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <b6fccc0d-c60b-4f11-9ef7-25b01c25425d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/7/23 17:02, David Ahern wrote:
> On 12/7/23 4:33 PM, Kui-Feng Lee wrote:
>>
>>
>> On 12/7/23 15:20, David Ahern wrote:
>>> On 12/7/23 4:17 PM, David Ahern wrote:
>>>> On 12/7/23 3:16 PM, thinker.li@gmail.com wrote:
>>>>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>>>>
>>>>> Check f6i->fib6_node before inserting a f6i (fib6_info) to
>>>>> tb6_gc_hlist.
>>>>
>>>> any place setting expires should know if the entry is in a table or not.
>>>>
>>>> And the syzbot report contains a reproducer, a kernel config and other
>>>> means to test a patch.
>>>>
>>>
>>> Fundamentally, the set and clear helpers are doing 2 things; they need
>>> to be split into separate helpers.
>>
>> Sorry, I don't follow you.
>>
>> There are fib6_set_expires_locked()) and fib6_clean_expires_locked(),
>> two separate helpers. Is this what you are saying?
>>
>> Doing checks of f6i->fib6_node in fib6_set_expires_locked() should
>> already apply everywhere setting expires, right?
>>
>> Do I miss anything?
> 
> static inline void fib6_set_expires_locked(struct fib6_info *f6i,
>                                             unsigned long expires)
> {
>          struct fib6_table *tb6;
> 
>          tb6 = f6i->fib6_table;
>          f6i->expires = expires;
>          if (tb6 && !fib6_has_expires(f6i))
>                  hlist_add_head(&f6i->gc_link, &tb6->tb6_gc_hlist);
>          f6i->fib6_flags |= RTF_EXPIRES;
> }
> 
> 1. You are abusing this helper in create_info to set the value of
> expires knowing (expecting) tb6 to NOT be set and hence not setting
> gc_link so no cleanup is needed on errors.
> 
> 2. You then open code gc_link when adding to the tree.
> 
> I had my reservations when you sent this patch months ago, but I did not
> have time to suggest a cleaner approach and now this is where we are --
> trying to find some race corrupting the list.

So, what you said is to split fib6_set_expires_locked() into two
functions. One is setting expires, and the other is adding a f6i to
tb6_gc_hlist. fib6_clean_expires_locked() should be split in the same
way.

Is it correct?


