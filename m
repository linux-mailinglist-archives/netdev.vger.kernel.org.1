Return-Path: <netdev+bounces-58403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B88C8163EE
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 02:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F131F2158A
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 01:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00DC1C10;
	Mon, 18 Dec 2023 01:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3CyY2im"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5304F5392
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 01:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5e6c8b70766so837777b3.3
        for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 17:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702861531; x=1703466331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x51KhBjI0MLd07OgssniTOsM2MTiwxatCokOct1f3N8=;
        b=e3CyY2imidRATHO5wWeOJoozrZ9sD8bpEhGkWcyDQZrQv8+o9Md691ns9SIuX2tjVg
         B4/MQTuInonpGqBGurtAmYXsS8sgOhvHukAZggJfqUDXXxuaheQW91xQ6RZ/YZ5DNLOH
         nUjnv+Boi3mTRXiamZMy7B9LmQnYckTnmQ25EUuNHEjGrtvhG1Nb9W9BCcluigjQOuih
         gY+NJvlkhdnNPPE+fEkdr1JenTCOXBl1jjQCCFu8go06hRpL+yNvxOmhAKt7ZP1RYzGV
         /ZAkVGSkcqQDQ9WArpYkWxGc3V1jwq54jFasYDXx+zHCS3qHZeluLq+9Wn04MhTgCu+2
         7ePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702861531; x=1703466331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x51KhBjI0MLd07OgssniTOsM2MTiwxatCokOct1f3N8=;
        b=HwTmaCfdv+kPmFtCC82qO3QFlSp/Uq4dSySFbtVLwRGxQbh2F1reiO1IHnVcKVO/Tv
         UHCHWpY7+kmDGrQpFGc83MrPsDPMpzOrHhFmKpe7d3VOBNTajahQYeuxVSif23iiCB3y
         LH/81Z8icagnt/UGJC4D1LSOnRCe9OkMkBcuOLW6Xatj1v+JZwifKdcXPtVAlg8JUdw9
         1pbPxMKhhql0JssRMEKopenxRbBPZZGDl7GEmUfPCwnsXtFN1836AHxQ9pMzn8Yh13Wb
         Dbp1ueuhgR/tiOh9uUJgP6zzDI3G9gUHZkziDmPDyIHO9yYwLrWBwafSlVjP8+vKdjPr
         3Kzg==
X-Gm-Message-State: AOJu0YxfJzdgyElufKgcr3VX9SiQ3mtAqAbDxeg+2tkVQUhm7eKmEYw3
	wvX3SyHnW7mnhRh/Yf31XWU=
X-Google-Smtp-Source: AGHT+IGHixLk3tSqpxCjyOUa91rq/T5/Lfb+SnlyxyUNajU8q8KeijU95Mum3B9I0d1Zk+vZOIOG1A==
X-Received: by 2002:a0d:ea08:0:b0:5e4:e05e:cb33 with SMTP id t8-20020a0dea08000000b005e4e05ecb33mr1960445ywe.39.1702861531007;
        Sun, 17 Dec 2023 17:05:31 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:6c55:8ec3:2883:1a4? ([2600:1700:6cf8:1240:6c55:8ec3:2883:1a4])
        by smtp.gmail.com with ESMTPSA id gt6-20020a05690c450600b005d76f9e256esm2584005ywb.29.2023.12.17.17.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 17:05:30 -0800 (PST)
Message-ID: <285dd3fd-2562-4704-95ed-005aee3cb687@gmail.com>
Date: Sun, 17 Dec 2023 17:05:28 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net/ipv6: insert a f6i to a GC list only
 if the f6i is in a fib6_table tree.
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, thinker.li@gmail.com,
 netdev@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: kuifeng@meta.com, syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
References: <20231213213735.434249-1-thinker.li@gmail.com>
 <20231213213735.434249-2-thinker.li@gmail.com>
 <28f016bc-3514-444f-82df-719aeb2d013a@kernel.org>
 <185a3177-3281-4ead-838e-6d621151ea36@gmail.com>
 <e587f26f-f003-4730-acb0-cecb2a5a83f2@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <e587f26f-f003-4730-acb0-cecb2a5a83f2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/16/23 10:36, David Ahern wrote:
> On 12/15/23 11:12 AM, Kui-Feng Lee wrote:
>>
>> I tried to reproduce the issue yesterday, according to the hypothesis
>> behind the patch of this thread. The following is the instructions
>> to reproduce the UAF issue. However, this instruction doesn't create
>> a crash at the place since the memory is still available even it has
>> been free. But, the log shows a UAF.
>>
>> The patch at the end of this message is required to reproduce and
>> show UAF. The most critical change in the patch is to insert
>> a 'mdelay(3000)' to sleep 3s in rt6_route_rcv(). That gives us
>> a chance to manipulate the kernel to reproduce the UAF.
>>
>> Here is my conclusion. There is no protection between finding
>> a route and changing the route in rt6_route_rcv(), including inserting
>> the entry to the gc list. It is possible to insert an entry that will be
>> free later to the gc list, causing a UAF. There is more explanations
>> along with the following logs.
> 
> TL;DR: I think 3dec89b14d37 should be reverted for 6.6 and 6.7
> (selftests should be valid with or without this change) and you try
> again for 6.9 (6.7 dev cycle is about to close).
> 
> ###
> 
> I was successful in triggering UAF twice yesterday, but a slightly
> different code path that in Eric's trace:
> 
> This is the WARN_ON for !hlist_unhashed in fib6_info_release:
> 
> [   46.926339] ------------[ cut here ]------------
> [   46.926368] WARNING: CPU: 3 PID: 0 at include/net/ip6_fib.h:332
> fib6_info_release+0x2a/0x43
> [   46.926384] Modules linked in:
> [   46.926393] CPU: 3 PID: 0 Comm: swapper/3 Not tainted
> 6.7.0-rc4-debug+ #16
> [   46.926399] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> 1.15.0-1 04/01/2014
> [   46.926404] RIP: 0010:fib6_info_release+0x2a/0x43
> [   46.926409] Code: 48 85 ff 74 3d 55 48 89 e5 53 48 89 fb 48 8d 7f 2c
> e8 3e ff ff ff 84 c0 74 25 48 8d 7b 40 e8 33 11 8b ff 48 83 7b 40 00 74
> 02 <0f> 0b 48 8d bb a0 00 00 00 48 c7 c6 93 ea ae 81 e8 3f 00 66 ff 5b
> [   46.926416] RSP: 0018:ffffc900002a8390 EFLAGS: 00010282
> [   46.926422] RAX: 1ffff11002048b00 RBX: ffff888010245c00 RCX:
> ffffffff81af8c9e
> [   46.926426] RDX: dffffc0000000000 RSI: 0000000000000004 RDI:
> ffff888010245c40
> [   46.926431] RBP: ffffc900002a8398 R08: ffffed1002048b86 R09:
> 0000000000000001
> [   46.926435] R10: ffffffff81af8be4 R11: ffff888010245c2f R12:
> ffff88800aeec000
> [   46.926439] R13: 0000000000000000 R14: ffff88801ab7c200 R15:
> 0000000000000020
> [   46.926444] FS:  0000000000000000(0000) GS:ffff88806c000000(0000)
> knlGS:0000000000000000
> [   46.926448] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   46.926452] CR2: 00007f897cc95fb0 CR3: 000000001d69d000 CR4:
> 0000000000750ef0
> [   46.926458] PKRU: 55555554
> [   46.926462] Call Trace:
> [   46.926466]  <IRQ>
> [   46.926470]  ? show_regs+0x5c/0x60
> [   46.926478]  ? fib6_info_release+0x2a/0x43
> [   46.926483]  ? __warn+0xcb/0x19c
> [   46.926489]  ? fib6_info_release+0x2a/0x43
> [   46.926495]  ? report_bug+0x114/0x186
> [   46.926504]  ? handle_bug+0x40/0x6b
> [   46.926510]  ? exc_invalid_op+0x19/0x41
> [   46.926515]  ? asm_exc_invalid_op+0x1b/0x20
> [   46.926524]  ? refcount_dec_and_test+0x15/0x43
> [   46.926530]  ? fib6_info_release+0x23/0x43
> [   46.926536]  ? fib6_info_release+0x2a/0x43
> [   46.926542]  ndisc_router_discovery+0xf41/0xfa6
> 
> 
> UAF here:
> 
> [   47.941928]
> ==================================================================
> [   47.942548] BUG: KASAN: slab-use-after-free in
> fib6_gc_all.constprop.0+0x19b/0x294
> [   47.943178] Read of size 8 at addr ffff888010245c38 by task swapper/3/0
> 
> [   47.943866] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W
>   6.7.0-rc4-debug+ #16
> [   47.944548] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> 1.15.0-1 04/01/2014
> [   47.945204] Call Trace:
> [   47.945416]  <IRQ>
> [   47.945595]  dump_stack_lvl+0x5b/0x82
> [   47.945912]  print_address_description.constprop.0+0x7a/0x2eb
> [   47.946391]  print_report+0x106/0x1e0
> [   47.946703]  ? virt_to_slab+0x9/0x1a
> [   47.947007]  ? kmem_cache_debug_flags+0x13/0x1f
> [   47.947392]  ? kasan_complete_mode_report_info+0x19e/0x1a1
> [   47.947850]  ? fib6_gc_all.constprop.0+0x19b/0x294
> [   47.948254]  kasan_report+0x99/0xc4
> [   47.948554]  ? fib6_gc_all.constprop.0+0x19b/0x294
> [   47.948962]  __asan_load8+0x77/0x79
> [   47.949262]  fib6_gc_all.constprop.0+0x19b/0x294
> 
> 
> for a route added here:
> 
> [   47.970092] Allocated by task 0:
> [   47.970366]  stack_trace_save+0x8d/0xbb
> [   47.970373]  kasan_save_stack+0x26/0x46
> [   47.970379]  kasan_set_track+0x25/0x2b
> [   47.970385]  kasan_save_alloc_info+0x1e/0x21
> [   47.970392]  ____kasan_kmalloc+0x6f/0x7b
> [   47.970398]  __kasan_kmalloc+0x9/0xb
> [   47.970404]  __kmalloc+0x91/0xbf
> [   47.970411]  kzalloc+0xf/0x11
> [   47.970416]  fib6_info_alloc+0x26/0xa1
> [   47.970422]  ip6_route_info_create+0x266/0x6c5
> [   47.970428]  ip6_route_add+0x14/0x46
> [   47.970433]  rt6_add_dflt_router+0x123/0x1bd
> [   47.970439]  ndisc_router_discovery+0x5a4/0xfa6
> [   47.970447]  ndisc_rcv+0x1a2/0x1b5
> 
> This is just aggressive RA's and aggressive gc with a hack to the stack
> to toggle lifetime or metric on every RA (something that can be scripted
> with an ra command - set and reset lifetime in every other RA and change
> the metric in every RA).
> 
> I was targeting this code path because I noticed rt6_add_dflt_router
> sets RTF_EXPIRES but does not pass in the expires value. There are races
> (like the one you found with a different code path) in the handling of
> RTF_EXPIRES, setting the timer, running gc and adding the route entry to
> the gc list.

I am not sure what you mean a race in rt6_add_dflt_router().
In this function, it calls ip6_route_add() to add a default route
with RTF_EXPIRES. In ip6_route_add(), it calls ip6_route_info_create()
to create a f6i, and calls __ip6_ins_rt() to add the entry to gc list.

Although there is a gap between ip6_route_info_create() and
__ip6_ins_rt() without any protection, it should not cause a race.
The newly created entry is not available to the rest of the system
until __ip6_ins_rt() adds it to the tree.  And, adding the entry
to the gc list and adding the entry to the tree are performed
atomically, being protected by table->tb6_lock. So, it should not have
a race between adding to tree and adding to gc list if this is what
you mean.

By the way, do you happen to have a chance to try the patch here in
you tests?  It fixed the issue for my test scenario. According to
your stacktraces, it should be the same issue happening in my test.
Somewhere adds a entry to gc list by faultily believing that
the entry is still on a tree. And, the patch here fixes this
faultily believe.

> 
> In short there are a number of places in the RA path that need the
> lifetime handling cleaned up first to make it all consistent with the
> idea of using a linked list to track entries with an expires tag.

