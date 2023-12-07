Return-Path: <netdev+bounces-54933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDC6808F8D
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F8C0B20BC7
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2584B5D9;
	Thu,  7 Dec 2023 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myU3Xq5t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6F110DE
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 10:06:09 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5d2d0661a8dso10987497b3.2
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 10:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701972368; x=1702577168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8C74fQmzhqkQeNgmhjPDIUKyWi8DOzJJHKByqR0X+uY=;
        b=myU3Xq5thnAgBTuWdtgM42CK7q1rjuA2oSiBWV7CiBOSYV7koNRhOunw8dp3bT02xL
         fC0fLV9QxK1dpz9WAofrBgieOGiMYx8KBbkZyA5PAC7MaLS4WhuBIl2PsgGD4qCdTk70
         Ea++DV2XuRLJE2uZtgS3SY663bOlhC7CDB1jcFdS8Eqt+OzdPj9Buw/jRIcatXO3DxKt
         /DVmX6rLEZICeIOXbVRFrlxiLpg/PfqPzuVKgov7klriOO9DlctwUNuxnyogpFEniA9u
         iiNrompodEIHMAYKyQcIgLUSS9Wn3NWI798tHHczEaoju4YlKnxSfojSO78v4Zzv2Yj2
         lkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701972368; x=1702577168;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8C74fQmzhqkQeNgmhjPDIUKyWi8DOzJJHKByqR0X+uY=;
        b=RuqaQ/eCElNtZeDWDEwWdQYP+VAx9RvLdgeMq+sMEMVblGZAIXvl9rTjZBr9CDW9R0
         fkmjWdybN+haTwosN3s/lrePfG/83YzrggwMqnldDt+Sy+efCuVFcE46J9wXZaH4l1TA
         1N9OwGrsuuAetNctH7poQntFXJXjShJNzUT86MIzWbZg+PnKkqZw65ti+/57agTZnMCX
         /w2ywZWF0HjN1/Qm7drc5n1dyBGXCxAcpG+WOxllI9vv9BFzAw3ZeYiKNFNpDg+07e3s
         r3jkjzIQeHJcXqKRlLFIwMQLHDTCSQ7YxDGCngQduXlMMVgMDxz5b75V0RDdkQAwNFSU
         Mc4A==
X-Gm-Message-State: AOJu0YxZ8LOQgp3BkKm6/zCH9LsOMDPTN7t83eIx4CpA2Dk0tGn2Zo2x
	uLL62wBCPpWuQ1+u0idmPe0=
X-Google-Smtp-Source: AGHT+IFfhj9oOYgSpz/MokFtVcUHDd8wPIFQKQ3f9T9F6oo/riC2yqnxmavyPMWFP8ZUlRkmZHJHkA==
X-Received: by 2002:a81:79d8:0:b0:5d3:81f2:17f5 with SMTP id u207-20020a8179d8000000b005d381f217f5mr2364620ywc.47.1701972368483;
        Thu, 07 Dec 2023 10:06:08 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:57df:3a91:11ad:dcd? ([2600:1700:6cf8:1240:57df:3a91:11ad:dcd])
        by smtp.gmail.com with ESMTPSA id i2-20020a0df802000000b00583b144fe51sm42768ywf.118.2023.12.07.10.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 10:06:08 -0800 (PST)
Message-ID: <c4ca9c7d-12fa-4205-84e2-c1001242fc0d@gmail.com>
Date: Thu, 7 Dec 2023 10:06:06 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: add debug checks in fib6_info_release()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, patchwork-bot+netdevbpf@kernel.org,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20231205173250.2982846-1-edumazet@google.com>
 <170191862445.7525.14404095197034927243.git-patchwork-notify@kernel.org>
 <CANn89iKcFxJ68+M8UvHzqp1k-FDiZHZ8ujP79WJd1338DVJy6w@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CANn89iKcFxJ68+M8UvHzqp1k-FDiZHZ8ujP79WJd1338DVJy6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/7/23 05:29, Eric Dumazet wrote:
> On Thu, Dec 7, 2023 at 4:10 AM <patchwork-bot+netdevbpf@kernel.org> wrote:
>>
>> Hello:
>>
>> This patch was applied to netdev/net-next.git (main)
>> by Jakub Kicinski <kuba@kernel.org>:
>>
>> On Tue,  5 Dec 2023 17:32:50 +0000 you wrote:
>>> Some elusive syzbot reports are hinting to fib6_info_release(),
>>> with a potential dangling f6i->gc_link anchor.
>>>
>>> Add debug checks so that syzbot can catch the issue earlier eventually.
>>>
>>> BUG: KASAN: slab-use-after-free in __hlist_del include/linux/list.h:990 [inline]
>>> BUG: KASAN: slab-use-after-free in hlist_del_init include/linux/list.h:1016 [inline]
>>> BUG: KASAN: slab-use-after-free in fib6_clean_expires_locked include/net/ip6_fib.h:533 [inline]
>>> BUG: KASAN: slab-use-after-free in fib6_purge_rt+0x986/0x9c0 net/ipv6/ip6_fib.c:1064
>>> Write of size 8 at addr ffff88802805a840 by task syz-executor.1/10057
>>>
>>> [...]
>>
>> Here is the summary with links:
>>    - [net-next] ipv6: add debug checks in fib6_info_release()
>>      https://git.kernel.org/netdev/net-next/c/5a08d0065a91
> 
> Nice, syzbot gave me exactly what I was looking for.
> 
> WARNING: CPU: 0 PID: 5059 at include/net/ip6_fib.h:332
> fib6_info_release include/net/ip6_fib.h:332 [inline]
> WARNING: CPU: 0 PID: 5059 at include/net/ip6_fib.h:332
> ip6_route_info_create+0x1a1a/0x1f10 net/ipv6/route.c:3829
> Modules linked in:
> CPU: 0 PID: 5059 Comm: syz-executor256 Not tainted
> 6.7.0-rc3-syzkaller-00805-g5a08d0065a91 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 11/10/2023
> RIP: 0010:fib6_info_release include/net/ip6_fib.h:332 [inline]
> RIP: 0010:ip6_route_info_create+0x1a1a/0x1f10 net/ipv6/route.c:3829
> Code: 49 83 7f 40 00 75 28 e8 04 ae 50 f8 49 8d bf a0 00 00 00 48 c7
> c6 c0 ae 37 89 e8 41 2c 3a f8 e9 65 f4 ff ff e8 e7 ad 50 f8 90 <0f> 0b
> 90 eb ad e8 dc ad 50 f8 90 0f 0b 90 eb cd e8 d1 ad 50 f8 e8
> RSP: 0018:ffffc90003bdf8e0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000400000 RCX: ffffffff8936e418
> RDX: ffff888026a58000 RSI: ffffffff8936e469 RDI: 0000000000000005
> RBP: ffffc90003bdf9d0 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000400000 R11: ffffffff81de4c35 R12: ffffffffffffffea
> R13: ffff88802993242c R14: ffffc90003bdfac4 R15: ffff888029932400
> FS: 00005555562b4380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004585c0 CR3: 000000007390d000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> ip6_route_add+0x26/0x1f0 net/ipv6/route.c:3843
> ipv6_route_ioctl+0x3ff/0x590 net/ipv6/route.c:4467
> inet6_ioctl+0x265/0x2b0 net/ipv6/af_inet6.c:575
> sock_do_ioctl+0x113/0x270 net/socket.c:1220
> sock_ioctl+0x22e/0x6b0 net/socket.c:1339
> vfs_ioctl fs/ioctl.c:51 [inline]
> __do_sys_ioctl fs/ioctl.c:871 [inline]
> __se_sys_ioctl fs/ioctl.c:857 [inline]
> __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
> do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7f175790d369
> 
> 
> Following commit seems buggy.
> 
> commit 3dec89b14d37ee635e772636dad3f09f78f1ab87
> Author: Kui-Feng Lee <thinker.li@gmail.com>
> Date:   Tue Aug 15 11:07:05 2023 -0700
> 
>      net/ipv6: Remove expired routes with a separated list of routes.
> 
>      FIB6 GC walks trees of fib6_tables to remove expired routes. Walking a tree
>      can be expensive if the number of routes in a table is big, even if most of
>      them are permanent. Checking routes in a separated list of routes having
>      expiration will avoid this potential issue.
> 
>      Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>      Reviewed-by: David Ahern <dsahern@kernel.org>
>      Signed-off-by: David S. Miller <davem@davemloft.net>
> 

Do you happen to have a test program that can reproduce it?


