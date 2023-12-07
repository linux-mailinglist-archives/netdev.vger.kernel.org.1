Return-Path: <netdev+bounces-54959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E8980907A
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121F21F20F57
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816C42C841;
	Thu,  7 Dec 2023 18:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kACMV1ti"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66237E0
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 10:46:38 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-dae7cc31151so1306785276.3
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 10:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701974797; x=1702579597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8F7lOZCVmdSUUKlTY5pCjlBF+y7hAUCTTCk7yXihrYE=;
        b=kACMV1ti3dCuADik6J2zCm99f4nj9CYfu6xMLGBwMUCU90uqqwSAj2G5jkhejReegz
         dTDxbusDjgPHBceJN5vImZeug5GbCfJDDACaNKijUffywDqsar7EezB/be9pKW6QqHKg
         kbgF2DGsgUSWwUFbEnuv13hxhfxYQmhSl2tjeQPcldT6OEjCZm1RhgoC9aeqPqcMS5aT
         OQBBaPrk8fiETebl+45663B4LMRaUnwur6IgXAjueK9TW6U+WiehqRCwBk2hCLQIDP76
         41F/2WoIKi13Gi4FGWkYTqQEII5TNxyExN+cGRBBjzdhW4fKX75lkAbiUbQmV6WwHAlc
         CHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701974797; x=1702579597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8F7lOZCVmdSUUKlTY5pCjlBF+y7hAUCTTCk7yXihrYE=;
        b=FGSchRVB2XsH2VnszNDGGkXsYO1h5zqGPhupC7erA92vUwm4UFBlIYJJsj+X4Zqogy
         1VUiOki/svb/xdBSd65Gynhy2Enu3kd6NRWUvY6OxXtjFxAkMM8ealGqoKzDnwdZ+dBk
         Z1S09W5cih3IcM9cagYcXVoiXcB+HPmvsEeCJmDK6pOcaM4w6K/M/EWjCSGo/DR4C0oj
         823OfFqVWzJ6mRnMSoLoixr6B9QMzrQe1PegjfqwJX1B0m6o2vtmDQYvgP3RY05MrcpS
         NaH0Mk1JYvo81n1eIlV3fa7nSdKCrUShxKpVRr0g+Ep9buIRShzkZsnfgBEjhzlcD2la
         okow==
X-Gm-Message-State: AOJu0YyFdNBgaBc2tIgNnhPpx8PLkIYuQt+vm176A16/A9v8QyK75Y6U
	a8wr47TPQwMJgmDq3a5ivok=
X-Google-Smtp-Source: AGHT+IEJZxSmFmDdukxJpL/OCGsHoPxloyEwXbaKJgoRy0sEQVfGDIi6it83UtLkPPquKWjCucn9GQ==
X-Received: by 2002:a25:68ce:0:b0:da0:a52d:1be8 with SMTP id d197-20020a2568ce000000b00da0a52d1be8mr2812934ybc.9.1701974797544;
        Thu, 07 Dec 2023 10:46:37 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:57df:3a91:11ad:dcd? ([2600:1700:6cf8:1240:57df:3a91:11ad:dcd])
        by smtp.gmail.com with ESMTPSA id 13-20020a25040d000000b00d7f06aa25c5sm78622ybe.58.2023.12.07.10.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 10:46:37 -0800 (PST)
Message-ID: <ca59f955-dc6f-49d8-ae32-fb2d0f7e7522@gmail.com>
Date: Thu, 7 Dec 2023 10:46:35 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: add debug checks in fib6_info_release()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: patchwork-bot+netdevbpf@kernel.org, Kui-Feng Lee <thinker.li@gmail.com>,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20231205173250.2982846-1-edumazet@google.com>
 <170191862445.7525.14404095197034927243.git-patchwork-notify@kernel.org>
 <CANn89iKcFxJ68+M8UvHzqp1k-FDiZHZ8ujP79WJd1338DVJy6w@mail.gmail.com>
 <c4ca9c7d-12fa-4205-84e2-c1001242fc0d@gmail.com>
 <CANn89iKpM33oQ+2dwoLHzZvECAjwiKJTR3cDM64nE6VvZA99Sg@mail.gmail.com>
 <2ba1bbde-0e80-4b73-be2b-7ce27c784089@gmail.com>
 <CANn89i+2NJ4sp8iGQHG9wKakRD+uzvo7juqAFpE4CdRbg8F6gQ@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CANn89i+2NJ4sp8iGQHG9wKakRD+uzvo7juqAFpE4CdRbg8F6gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/7/23 10:22, Eric Dumazet wrote:
> On Thu, Dec 7, 2023 at 7:19 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>
>> On 12/7/23 10:10, Eric Dumazet wrote:
>>> On Thu, Dec 7, 2023 at 7:06 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>>
>>>> Do you happen to have a test program that can reproduce it?
>>>
>>> syzbot has a repro, let me release the bug.
>>>
>>> Of course syzbot bisection points to my last patch.
>>
>> I just looked into the code.
>> The origin issue mentioned at the thread head should be something
>> related to a GC change I made. But, the warnings you added doesn't
>> catch the the error correctly.  According to your stacktrace
>>
>>
>>   > ip6_route_add+0x26/0x1f0 net/ipv6/route.c:3843
>>   > ipv6_route_ioctl+0x3ff/0x590 net/ipv6/route.c:4467
>>   > inet6_ioctl+0x265/0x2b0 net/ipv6/af_inet6.c:575
>>   > sock_do_ioctl+0x113/0x270 net/socket.c:1220
>>   > sock_ioctl+0x22e/0x6b0 net/socket.c:1339
>>   > vfs_ioctl fs/ioctl.c:51 [inline]
>>   > __do_sys_ioctl fs/ioctl.c:871 [inline]
>>   > __se_sys_ioctl fs/ioctl.c:857 [inline]
>>   > __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
>>   > do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>>   > do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
>>   > entry_SYSCALL_64_after_hwframe+0x63/0x6b
>>
>> and warning messages you provided
>>
>>   > WARNING: CPU: 0 PID: 5059 at include/net/ip6_fib.h:332
>>   > fib6_info_release include/net/ip6_fib.h:332 [inline]
>>   > WARNING: CPU: 0 PID: 5059 at include/net/ip6_fib.h:332
>>   > ip6_route_info_create+0x1a1a/0x1f10 net/ipv6/route.c:3829
>>
>> It takes place in ip6_route_info_create() to do error handling.
>> It can be fib6_has_expires() in fib6_info_release() in this case.
> 
> Feel free to amend the patch, but the issue is that we insert a fib
> gc_link to a list,
> then free the fi6 object without removing it first from the external list.
> 
> I added two different warnings, and removing one or both will still
> keep the bug.

The gc_link is not inserted here actually. (see my explanation in
another message.)

According to the messages in the thread head, it is an issue of dangling
pointer, right? If I read it correctly, the original issue is gc_link
pointing to a block of memory that is already free. Am I right?


