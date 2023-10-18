Return-Path: <netdev+bounces-42293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B62B07CE16A
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2F6FB20F7E
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EDC3B2A6;
	Wed, 18 Oct 2023 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fh86ZhIX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A815E3B288
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 15:45:00 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AEF118
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 08:44:58 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so86736751fa.3
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 08:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1697643897; x=1698248697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MPDES5suCngPNNIoi8yjiAlTevZp9WeVDPNOj+vFy9s=;
        b=fh86ZhIXRbrWv1CzXsSuS7T2ksKWTRI3QDE3qmdWN9HtvvA8ajXT3PrjoKHVOwefxa
         MnTreS/waR75wuiVERI7KyVgVYs9Hn68ONJ3O0jBFhcivKShNYe8+QSyzAHOrk1yXLz6
         34+GRjjmKOy3hVywWQP55BAnYZHR4oDhfPAXjG5w8jWSBecvMWXaJQmPCa8HibHytPup
         X5FjPb2W0nbmK4LQTIw08Lx4gY2rcBwvbqK722lKizB1smcME4iL5e62FYZSqiWnlqMG
         lRMGkHX1NSOwfhWn6axNyGYP1zlku/GdfVg0KwWEJp2zzT4wLVqrVMll6KoT1zk8BVJ/
         ZbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697643897; x=1698248697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPDES5suCngPNNIoi8yjiAlTevZp9WeVDPNOj+vFy9s=;
        b=Rs3m6dj1W4DgtzO3K5DLcKV7j0VD+zCMOiKC4Bmas8yqyknW/B5VWfghGVbmNtOomT
         0cLfBZBl6K+EwFGkmpeCMVI2mCT4Yh/1N/yWBt4ON2cViz8hNv7bJ/h6iORLvB6dF4ev
         C4MOl5WYnHW3q+tQXrsggaHOxOe6xRN0fYySeGcSAYENubjaVANhUoewGnZBXEFuzxW5
         6evQK/Eiv46eZSNaY399DUIN23RSIZWQOAUXlTb5JCMWoXZAt1ohWp+soAO4cKh4FPzF
         mc4Giel7Fc1a30r6pUGBcUV2cJjiX4jWK3w++7vGDD48UnG5hrrPYioVfJPOY5FhTmCZ
         gSxg==
X-Gm-Message-State: AOJu0YzK0V2vEU1UW8Dk/kf4ww5Lvtp5xMiRmzJ1R0wf3LcinPtdcxn5
	4dqGNNJw6fp4NqNnm2c4n7RYRg==
X-Google-Smtp-Source: AGHT+IE+MD3+AZtJMYk8HHAFz2zts5QOpGNrz/MzUMMG6eB1RgLXxX8zG3MHFaEQ6NU/RvWTvAp7hg==
X-Received: by 2002:a2e:a178:0:b0:2c5:1ad3:7798 with SMTP id u24-20020a2ea178000000b002c51ad37798mr3896968ljl.52.1697643897093;
        Wed, 18 Oct 2023 08:44:57 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c130e00b0040772934b12sm1954880wmf.7.2023.10.18.08.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 08:44:56 -0700 (PDT)
Message-ID: <db46960b-c334-422a-bfd9-ebda1505477e@arista.com>
Date: Wed, 18 Oct 2023 16:44:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 net-next 08/23] net/tcp: Add AO sign to RST packets
Content-Language: en-US
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Francesco Ruggeri <fruggeri@arista.com>,
 Salam Noureddine <noureddine@arista.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, Ard Biesheuvel <ardb@kernel.org>,
 Bob Gilligan <gilligan@arista.com>, Dan Carpenter <error27@gmail.com>,
 David Laight <David.Laight@aculab.com>, Dmitry Safonov
 <0x7f454c46@gmail.com>, Donald Cassidy <dcassidy@redhat.com>,
 Eric Biggers <ebiggers@kernel.org>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Francesco Ruggeri <fruggeri05@gmail.com>,
 "Gaillardetz, Dominik" <dgaillar@ciena.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Ivan Delalande <colona@arista.com>, Leonard Crestez <cdleonard@gmail.com>,
 "Nassiri, Mohammad" <mnassiri@ciena.com>,
 "Tetreault, Francois" <ftetreau@ciena.com>
References: <202310171606.30e15ebe-oliver.sang@intel.com>
 <bd0e29db-c8dd-4d1a-a898-69e0b8e6dc54@arista.com>
 <ZS+J9yVm2ezCf6js@xsang-OptiPlex-9020>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <ZS+J9yVm2ezCf6js@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Oliver,

On 10/18/23 08:32, Oliver Sang wrote:
> hi, Dmitry Safonov,
> 
> On Wed, Oct 18, 2023 at 12:19:56AM +0100, Dmitry Safonov wrote:
>> On 10/17/23 09:37, kernel test robot wrote:
>>>
>>>
>>> Hello,
>>>
>>> kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_net/core/sock.c" on:
>>>
>>> commit: df13d11e6a2a3cc5f973aca36f68f880fa42d55f ("[PATCH v14 net-next 08/23] net/tcp: Add AO sign to RST packets")
[..]
>>>
>>> [  221.348247][ T7133] BUG: sleeping function called from invalid context at net/core/sock.c:2978
>>> [  221.349875][ T7133] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 7133, name: trinity-c4
>>> [  221.351666][ T7133] preempt_count: 0, expected: 0
>>> [  221.352614][ T7133] RCU nest depth: 1, expected: 0
>>> [  221.353518][ T7133] 2 locks held by trinity-c4/7133:
>>> [ 221.354530][ T7133] #0: ed8b5660 (sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_sendmsg (net/ipv4/tcp.c:1336) 
>>> [ 221.374314][ T7133] #1: c27dbb18 (rcu_read_lock){....}-{1:2}, at: inet6_csk_xmit (include/linux/rcupdate.h:747 net/ipv6/inet6_connection_sock.c:129) 
>>> [  221.375906][ T7133] CPU: 1 PID: 7133 Comm: trinity-c4 Tainted: G        W       TN 6.6.0-rc4-01105-gdf13d11e6a2a #1
>>
>> Quite puzzling. It doesn't seem that it can happen to inet6_csk_xmit():
>>
>> :	rcu_read_lock();
>> :	skb_dst_set_noref(skb, dst);
>> :
>> :	/* Restore final destination back after routing done */
>> :	fl6.daddr = sk->sk_v6_daddr;
>> :
>> :	res = ip6_xmit(sk, skb, &fl6, sk->sk_mark, rcu_dereference(np->opt),
>> :		       np->tclass,  sk->sk_priority);
>> :	rcu_read_unlock();
>>
>> So, I presumed the calltrace was for nested rcu_read_lock() case.
>> Then I've looked at all return/goto cases, I couldn't find any
>> unbalanced rcu_read_{,un}lock().
>>
>> Is this reproducible by any chance?
> 
> do you mean how often it could be reproduced?
> 
> we run the tests upon this commit and parent both up to 15 times.
> from below, parent shows quite clean, but there are various issues while
> running tests upon this patch.
Thanks a lot for running your tests over it!

That's what a fresh brain does:
I see that tcp_v6_send_reset() with neither CONFIG_TCP_MD5SIG nor
CONFIG_TCP_AO set does grab rcu_read_lock() [as I wasn't sure at that
moment that nothing but md5 key does rely on that being held], but the
exit is covered with ifdefs:

: #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
: out:
:        if (allocated_traffic_key)
:                kfree(key.traffic_key);
:        rcu_read_unlock();
: #endif

Seems to have been correct versions ago (version 6), but on refactoring
when I've moved ifdeffs to tcp_parse_auth_options() declaration to
pollute less code - missed this.

Thanks again for your testing and reporting!


> 8468a6f4f3143 net/tcp: Add tcp_parse_auth_options()
> df13d11e6a2a3 net/tcp: Add AO sign to RST packets
> 
> 8468a6f4f3143ba2 df13d11e6a2a3cc5f973aca36f6
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :15          87%          13:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_arch/x86/entry/common.c
>            :15          33%           5:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_fs/dcache.c
>            :15          13%           2:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_include/linux/percpu-rwsem.h
>            :15          60%           9:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h
>            :15           7%           1:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c
>            :15           7%           1:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/rwsem.c
>            :15           7%           1:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_kernel/sched/completion.c
>            :15          40%           6:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_kernel/task_work.c
>            :15          33%           5:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_lib/iov_iter.c
>            :15          33%           5:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_lib/strncpy_from_user.c
>            :15          20%           3:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_lib/usercopy.c
>            :15          13%           2:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_mm/vmscan.c
>            :15         100%          15:15    dmesg.BUG:sleeping_function_called_from_invalid_context_at_net/core/sock.c
>            :15         100%          15:15    dmesg.EIP:rcu_note_context_switch
>            :15         100%          15:15    dmesg.WARNING:at_kernel/rcu/tree_plugin.h:#rcu_note_context_switch
>            :15         100%          15:15    dmesg.WARNING:lock_held_when_returning_to_user_space
>            :15         100%          15:15    dmesg.is_leaving_the_kernel_with_locks_still_held
> 
[..]

Thanks,
           Dmitry


