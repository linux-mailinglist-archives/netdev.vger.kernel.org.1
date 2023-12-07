Return-Path: <netdev+bounces-54956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 399D6809026
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE151C209F1
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBE14E63A;
	Thu,  7 Dec 2023 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bozQleVg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584D19A
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 10:40:15 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5d8ddcc433fso10005947b3.1
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 10:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701974414; x=1702579214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oepq6TnMfHKWYmHwZNOaOS1jdC2rKJxJIBdCUDotiVU=;
        b=bozQleVgNT9oVKXPV9HOCIBcFFKnGgI+I5QqumsPnw6pZpm2X/dfzv419hAI/TMDMv
         VHOPLcdC2DFk9zpUKQWVPKmiJ6tBCHg+09hKFSt6aLecoiXXdn6lTaMCuUwh2UwpGFiu
         AFvcCLTKRb0Ok1v74VlYrmou996TjOwSzp1o9W2ka3M6eTi8gnvwtpUKM6bkqifnwSmS
         mLWiJp+9qjxIjLGZ0JzfUEk47SP+gUIYu/Lh8vtFNeFXfdns0x23GnM89kdlgKiD8IfI
         RZBCwCPTlhoyFdyYZuoLAeg6ydMnNeMC0giv0dcfyTXeSTk70dw12mPdWFmKDDwHdhYp
         4vUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701974414; x=1702579214;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oepq6TnMfHKWYmHwZNOaOS1jdC2rKJxJIBdCUDotiVU=;
        b=ckywJ79O2Y4+B/ZUI892GEAZ6YsGZXBli5MRJmjwPsOk1wFrRqirU+V36yWrj2nYXK
         wPDSKPKJKmEzt6NU/+iiMzKu9Lv3IdWUdkUNmY3xko3PJdG+4T8L8e8UqsYJW9WH1x0r
         AcQ0PsxIATqImB3mCEyq+SH+USXktVzaL/nbY9foFJIQhkFJee+fhqRT5Bs2Bdw/qWe3
         bVslwi1hAS62iJtOpu//ULMYyEOG7d846jgCCvJi3yNzzXbUjYkyPtHbtzQrgES9yx+0
         nO+VCaTUDpeY17Qe0CDN7Nt0ER1e2O2LDe4rzQcGGgImEkn0ix1qINT8F9MU4yL6FPoM
         t7uA==
X-Gm-Message-State: AOJu0YzVdFe7pV1/qzMLTTThyZgJMFidU6hZYX/+IJVHazRR0mmE7N1j
	Um0PkktvyXPUCZEsYSy6fYybMmUrXgg=
X-Google-Smtp-Source: AGHT+IHxjemGSxvCqRSo/gAZez4oQ1mQmAjtTZLw4GNZPHc3xlw9h4MKztKcEBdn39+zKB7jZD7awg==
X-Received: by 2002:a05:690c:f01:b0:5d7:1940:8de1 with SMTP id dc1-20020a05690c0f0100b005d719408de1mr2374659ywb.72.1701974414441;
        Thu, 07 Dec 2023 10:40:14 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:57df:3a91:11ad:dcd? ([2600:1700:6cf8:1240:57df:3a91:11ad:dcd])
        by smtp.gmail.com with ESMTPSA id m13-20020a0dca0d000000b005dde6b96d58sm72003ywd.27.2023.12.07.10.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 10:40:14 -0800 (PST)
Message-ID: <3b432fa3-8cfc-4d50-8363-848cbe775621@gmail.com>
Date: Thu, 7 Dec 2023 10:40:12 -0800
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
In-Reply-To: <d7ffcd2b-55b0-4084-a18d-49596df8b494@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/7/23 10:36, Kui-Feng Lee wrote:
> 
> 
> On 12/7/23 10:25, David Ahern wrote:
>> On 12/7/23 11:22 AM, Eric Dumazet wrote:
>>> Feel free to amend the patch, but the issue is that we insert a fib
>>> gc_link to a list, then free the fi6 object without removing it first
>>> from the external list.
>>
>> yes, move the insert down:
>>
>> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
>> index b132feae3393..7257ba0e72b7 100644
>> --- a/net/ipv6/route.c
>> +++ b/net/ipv6/route.c
>> @@ -3762,12 +3762,6 @@ static struct fib6_info
>> *ip6_route_info_create(struct fib6_config *cfg,
>>          if (cfg->fc_flags & RTF_ADDRCONF)
>>                  rt->dst_nocount = true;
>>
>> -       if (cfg->fc_flags & RTF_EXPIRES)
>> -               fib6_set_expires_locked(rt, jiffies +
>> -
>> clock_t_to_jiffies(cfg->fc_expires));
>> -       else
>> -               fib6_clean_expires_locked(rt);
>> -
> 
> fib6_set_expires_locked() here actually doesn't insert a fib gc_link
> since rt->fib6_table is not assigned yet.  The gc_link will
> be inserted by fib6_add() being called later.
> 
> 
>>          if (cfg->fc_protocol == RTPROT_UNSPEC)
>>                  cfg->fc_protocol = RTPROT_BOOT;
>>          rt->fib6_protocol = cfg->fc_protocol;
>> @@ -3824,6 +3818,12 @@ static struct fib6_info
>> *ip6_route_info_create(struct fib6_config *cfg,
>>          } else
>>                  rt->fib6_prefsrc.plen = 0;
>>
>> +
>> +       if (cfg->fc_flags & RTF_EXPIRES)
>> +               fib6_set_expires_locked(rt, jiffies +
>> +
>> clock_t_to_jiffies(cfg->fc_expires));
>> +       else
>> +               fib6_clean_expires_locked(rt);
>>          return rt;
>>   out:
>>          fib6_info_release(rt);
> 
> However, this should fix the warning messages.
Just realize this cause inserting the gc_link twice.  fib6_add()
will try to add it again!

