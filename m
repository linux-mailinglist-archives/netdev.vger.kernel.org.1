Return-Path: <netdev+bounces-54972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 455288090ED
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 20:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3921F2133B
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EF74D588;
	Thu,  7 Dec 2023 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No6n05/9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608D710C8
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 11:00:44 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5d05ff42db0so10608897b3.2
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 11:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701975643; x=1702580443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=45B9Bpg3PtOcKLlH2dLpinRKuAiGNNU2u6nPb6qrdoU=;
        b=No6n05/96iQnoAlZRv9t+/TcZvVbkUGsWBtwqN5Du6budoDrbpSvJUiBHyToJNQEX+
         vV14Dv6P384S40/DO27xywkVNJOBqtiKve+FrnrDiuGRvTQyBXhEhy163pE1nS+uhkvF
         NW9hCvRfBY0LHZavYefy/F/Y+7f5kuvUOXVHRDoV9/SWOnW8xFEyZ8bIim2wyjYy4bQe
         dtV5tWdLMFd7UY1ZQY94qf+ompnaOSTmOWdnhW9Z5WWQR4bMviKjeTvB1rVavw7Em+aR
         ZHE0rruqm0zRmrPEKCTtb7LGrtM3ykOEvH3EnimdAp0xkICxNUliCIj5LplkbOW/hesM
         MC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701975643; x=1702580443;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45B9Bpg3PtOcKLlH2dLpinRKuAiGNNU2u6nPb6qrdoU=;
        b=fLf3jtdecE/0x0eQgkcmJmQAhDsTbyiBqLf5nW4Lf2ZtTk13/kNWANK3nbG7pIp3WI
         /IvKghz/YbsYDuoOF7bxi1f5JFx+dtiV0PdZ44CXY1m2g7BfNORy36A01eGz2KG613iO
         XmdvXheWIANfoKXHR/LR6iHLZhnTU1xEQ2Rjl2h90XDeC3A51WTGniBLAm1uOA2ixgpZ
         8ZLYhJyOmovjHvf9ImRA7lZQq41KvT91ogfN+7NHt012D8s0z+GQzoLt+35Mxl66TMrF
         n3t7/Uu4B6rRi8jSky4eGodT3CpPsfgCEGL4sWWuhC2JsI1JRoGZhGLr2YvENeaKQSRa
         UzLQ==
X-Gm-Message-State: AOJu0YwtboBYQoCba5pLrmng72Jw7tzBxoTvKwvdepEFiPchrLLly8zw
	OVU3HL7VRTyRa4MHuUjp008=
X-Google-Smtp-Source: AGHT+IEA7mZ70kOrtvuDDepMlw9sp9b3KcLdFcWGJw9IGu8zETHHhYPNfC/D2R/qRrdeKv6kiNiuUg==
X-Received: by 2002:a81:b622:0:b0:5c9:29e7:498f with SMTP id u34-20020a81b622000000b005c929e7498fmr2703294ywh.52.1701975643524;
        Thu, 07 Dec 2023 11:00:43 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:57df:3a91:11ad:dcd? ([2600:1700:6cf8:1240:57df:3a91:11ad:dcd])
        by smtp.gmail.com with ESMTPSA id v6-20020a81a546000000b005ca4e49bb54sm72536ywg.142.2023.12.07.11.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 11:00:43 -0800 (PST)
Message-ID: <d973fd6a-4fd0-4578-a784-00ed7fd1c927@gmail.com>
Date: Thu, 7 Dec 2023 11:00:41 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: add debug checks in fib6_info_release()
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
To: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: patchwork-bot+netdevbpf@kernel.org, Kui-Feng Lee <thinker.li@gmail.com>,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20231205173250.2982846-1-edumazet@google.com>
 <170191862445.7525.14404095197034927243.git-patchwork-notify@kernel.org>
 <CANn89iKcFxJ68+M8UvHzqp1k-FDiZHZ8ujP79WJd1338DVJy6w@mail.gmail.com>
 <c4ca9c7d-12fa-4205-84e2-c1001242fc0d@gmail.com>
 <CANn89iKpM33oQ+2dwoLHzZvECAjwiKJTR3cDM64nE6VvZA99Sg@mail.gmail.com>
 <2ba1bbde-0e80-4b73-be2b-7ce27c784089@gmail.com>
 <CANn89i+2NJ4sp8iGQHG9wKakRD+uzvo7juqAFpE4CdRbg8F6gQ@mail.gmail.com>
 <590c27ae-c583-4404-ace7-ea68548d07a2@kernel.org>
 <d7ffcd2b-55b0-4084-a18d-49596df8b494@gmail.com>
 <3b432fa3-8cfc-4d50-8363-848cbe775621@gmail.com>
In-Reply-To: <3b432fa3-8cfc-4d50-8363-848cbe775621@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/7/23 10:40, Kui-Feng Lee wrote:
> 
> 
> On 12/7/23 10:36, Kui-Feng Lee wrote:
>>
>>
>> On 12/7/23 10:25, David Ahern wrote:
>>> On 12/7/23 11:22 AM, Eric Dumazet wrote:
>>>> Feel free to amend the patch, but the issue is that we insert a fib
>>>> gc_link to a list, then free the fi6 object without removing it first
>>>> from the external list.
>>>
>>> yes, move the insert down:
>>>
>>> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
>>> index b132feae3393..7257ba0e72b7 100644
>>> --- a/net/ipv6/route.c
>>> +++ b/net/ipv6/route.c
>>> @@ -3762,12 +3762,6 @@ static struct fib6_info
>>> *ip6_route_info_create(struct fib6_config *cfg,
>>>          if (cfg->fc_flags & RTF_ADDRCONF)
>>>                  rt->dst_nocount = true;
>>>
>>> -       if (cfg->fc_flags & RTF_EXPIRES)
>>> -               fib6_set_expires_locked(rt, jiffies +
>>> -
>>> clock_t_to_jiffies(cfg->fc_expires));
>>> -       else
>>> -               fib6_clean_expires_locked(rt);
>>> -
>>
>> fib6_set_expires_locked() here actually doesn't insert a fib gc_link
>> since rt->fib6_table is not assigned yet.  The gc_link will
>> be inserted by fib6_add() being called later.
>>
>>
>>>          if (cfg->fc_protocol == RTPROT_UNSPEC)
>>>                  cfg->fc_protocol = RTPROT_BOOT;
>>>          rt->fib6_protocol = cfg->fc_protocol;
>>> @@ -3824,6 +3818,12 @@ static struct fib6_info
>>> *ip6_route_info_create(struct fib6_config *cfg,
>>>          } else
>>>                  rt->fib6_prefsrc.plen = 0;
>>>
>>> +
>>> +       if (cfg->fc_flags & RTF_EXPIRES)
>>> +               fib6_set_expires_locked(rt, jiffies +
>>> +
>>> clock_t_to_jiffies(cfg->fc_expires));
>>> +       else
>>> +               fib6_clean_expires_locked(rt);
>>>          return rt;
>>>   out:
>>>          fib6_info_release(rt);
>>
>> However, this should fix the warning messages.
> Just realize this cause inserting the gc_link twice.  fib6_add()
> will try to add it again!

I made a minor change to the patch that fix warning messages
provided by David Ahern. Will send an official patch later.

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3762,17 +3762,10 @@ static struct fib6_info 
*ip6_route_info_create(struct fib6_config *cfg,
         if (cfg->fc_flags & RTF_ADDRCONF)
                 rt->dst_nocount = true;

-       if (cfg->fc_flags & RTF_EXPIRES)
-               fib6_set_expires_locked(rt, jiffies +
- 
clock_t_to_jiffies(cfg->fc_expires));
-       else
-               fib6_clean_expires_locked(rt);
-
         if (cfg->fc_protocol == RTPROT_UNSPEC)
                 cfg->fc_protocol = RTPROT_BOOT;
         rt->fib6_protocol = cfg->fc_protocol;

-       rt->fib6_table = table;
         rt->fib6_metric = cfg->fc_metric;
         rt->fib6_type = cfg->fc_type ? : RTN_UNICAST;
         rt->fib6_flags = cfg->fc_flags & ~RTF_GATEWAY;
@@ -3824,6 +3817,17 @@ static struct fib6_info 
*ip6_route_info_create(struct fib6_config *cfg,
         } else
                 rt->fib6_prefsrc.plen = 0;

+       if (cfg->fc_flags & RTF_EXPIRES)
+               fib6_set_expires_locked(rt, jiffies +
+ 
clock_t_to_jiffies(cfg->fc_expires));
+       else
+               fib6_clean_expires_locked(rt);
+       /* Set fib6_table after fib6_set_expires_locked() to ensure the
+        * gc_link is not inserted until fib6_add() is called to insert the
+        * fib6_info to the fib.
+        */
+       rt->fib6_table = table;
+
         return rt;
  out:

