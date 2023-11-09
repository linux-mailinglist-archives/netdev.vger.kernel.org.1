Return-Path: <netdev+bounces-46925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B681C7E7185
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 19:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42AA9281114
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 18:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F204E1DDCB;
	Thu,  9 Nov 2023 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyeV9wFh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E61347C9
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 18:29:24 +0000 (UTC)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640164EE1
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 10:29:23 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-45da601e6f9so551812137.0
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 10:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699554563; x=1700159363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owLGhPVWoMyhfcs/yF8NtV0IvKkgbso6O/IPlgWyXxA=;
        b=fyeV9wFhlFC85yoGFRWPrRTf+xlj+a5J6B3mP71HG5fDS0jonxIAE7oKowfJg2e+jO
         ST7A8Q37SJFCGigXQHcl8ou2RS95Jzo+zWbfOTAAKyYR5HmkE2aXDz5xj512NjbZw3eD
         OOu8HBLY05afrxaI5PI3MjoFFokWCb+LsHGdHQvjCokMZyd43n/Zsj5gaQtnB/mBOUUI
         uv+NyWBMlIV4oHmpXDZ60AQlwjKj1p37RTnMpwzMzMw3/0RUdq959u1bM0wspnmjdXxh
         hk6rU+NvawQagBj6pj8yI/BKEDqv8ZBQZTikLM11doeCatLkav8SBB4+6is8sbwK4JqU
         e+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699554563; x=1700159363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owLGhPVWoMyhfcs/yF8NtV0IvKkgbso6O/IPlgWyXxA=;
        b=FUY56sVjnaI+C/6ZXxwjk6q9twHZzOvoo1++FjscUHiVFc9QkS8fpSUvQEmG2MDQLO
         di/pJa8s8BHevy6tb5utipYn3HoF4q3TP9X8Vkoh0VAJGLljnPiLSk/U0AJqHoxBmtoG
         NsYe1fGgbB3aPnJ8tFegZ2rybVaVQDAxjwoBZrFtLoPDQXDoBsImtHYecVM42kwlyKpj
         /Yl4hYpu4jUmApPY0P6XNpkLQQiSzs/lDs3jHxmpgO7pLqXv9VrgB2P/dqhswNv4/4fH
         GtFC/sGNvlqWm2IMK7w3XHViBtVP7rX8cI8gylYFx2HMWFqo0IhBj31G2N1b0+AxBtn3
         pTKQ==
X-Gm-Message-State: AOJu0YxpQMFEe4z5oupwVjkgsK0mje91HMTiY9jCHS+zS8brj34GEC8p
	pbDDiqdnD+BxquDGlWE9AexWZWCcvb1Bfx6T1Oc=
X-Google-Smtp-Source: AGHT+IFwBq9gvUG1eZeGFqIlGqWsjV7SefUe+MqaQ/MZX+wHm/m6umheH6YRsNeBgj5SfUEJg1PNv8YphSYA9ZsPgV4=
X-Received: by 2002:a67:a64f:0:b0:45f:3b30:9c95 with SMTP id
 r15-20020a67a64f000000b0045f3b309c95mr5519944vsh.7.1699554562852; Thu, 09 Nov
 2023 10:29:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109152241.3754521-1-edumazet@google.com>
In-Reply-To: <20231109152241.3754521-1-edumazet@google.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 9 Nov 2023 13:28:45 -0500
Message-ID: <CAF=yD-KjqkVJ7G_=EpKNRcdvbTujf6E4p1S_mTVQNBt9enOs2w@mail.gmail.com>
Subject: Re: [PATCH net] ipvlan: add ipvlan_route_v6_outbound() helper
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Mahesh Bandewar <maheshb@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 10:22=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Inspired by syzbot reports using a stack of multiple ipvlan devices.
>
> Reduce stack size needed in ipvlan_process_v6_outbound() by moving
> the flowi6 struct used for the route lookup in an non inlined
> helper. ipvlan_route_v6_outbound() needs 120 bytes on the stack,
> immediately reclaimed.
>
> Also make sure ipvlan_process_v4_outbound() is not inlined.
>
> We might also have to lower MAX_NEST_DEV, because only syzbot uses
> setups with more than four stacked devices.
>
> BUG: TASK stack guard page was hit at ffffc9000e803ff8 (stack is ffffc900=
0e804000..ffffc9000e808000)
> stack guard page: 0000 [#1] SMP KASAN
> CPU: 0 PID: 13442 Comm: syz-executor.4 Not tainted 6.1.52-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/09/2023
> RIP: 0010:kasan_check_range+0x4/0x2a0 mm/kasan/generic.c:188
> Code: 48 01 c6 48 89 c7 e8 db 4e c1 03 31 c0 5d c3 cc 0f 0b eb 02 0f 0b b=
8 ea ff ff ff 5d c3 cc 00 00 cc cc 00 00 cc cc 55 48 89 e5 <41> 57 41 56 41=
 55 41 54 53 b0 01 48 85 f6 0f 84 a4 01 00 00 48 89
> RSP: 0018:ffffc9000e804000 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff817e5bf2
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff887c6568
> RBP: ffffc9000e804000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: dffffc0000000001 R12: 1ffff92001d0080c
> R13: dffffc0000000000 R14: ffffffff87e6b100 R15: 0000000000000000
> FS: 00007fd0c55826c0(0000) GS:ffff8881f6800000(0000) knlGS:00000000000000=
00
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffc9000e803ff8 CR3: 0000000170ef7000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <#DF>
> </#DF>
> <TASK>
> [<ffffffff81f281d1>] __kasan_check_read+0x11/0x20 mm/kasan/shadow.c:31
> [<ffffffff817e5bf2>] instrument_atomic_read include/linux/instrumented.h:=
72 [inline]
> [<ffffffff817e5bf2>] _test_bit include/asm-generic/bitops/instrumented-no=
n-atomic.h:141 [inline]
> [<ffffffff817e5bf2>] cpumask_test_cpu include/linux/cpumask.h:506 [inline=
]
> [<ffffffff817e5bf2>] cpu_online include/linux/cpumask.h:1092 [inline]
> [<ffffffff817e5bf2>] trace_lock_acquire include/trace/events/lock.h:24 [i=
nline]
> [<ffffffff817e5bf2>] lock_acquire+0xe2/0x590 kernel/locking/lockdep.c:563=
2
> [<ffffffff8563221e>] rcu_lock_acquire+0x2e/0x40 include/linux/rcupdate.h:=
306
> [<ffffffff8561464d>] rcu_read_lock include/linux/rcupdate.h:747 [inline]
> [<ffffffff8561464d>] ip6_pol_route+0x15d/0x1440 net/ipv6/route.c:2221
> [<ffffffff85618120>] ip6_pol_route_output+0x50/0x80 net/ipv6/route.c:2606
> [<ffffffff856f65b5>] pol_lookup_func include/net/ip6_fib.h:584 [inline]
> [<ffffffff856f65b5>] fib6_rule_lookup+0x265/0x620 net/ipv6/fib6_rules.c:1=
16
> [<ffffffff85618009>] ip6_route_output_flags_noref+0x2d9/0x3a0 net/ipv6/ro=
ute.c:2638
> [<ffffffff8561821a>] ip6_route_output_flags+0xca/0x340 net/ipv6/route.c:2=
651
> [<ffffffff838bd5a3>] ip6_route_output include/net/ip6_route.h:100 [inline=
]
> [<ffffffff838bd5a3>] ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan=
_core.c:473 [inline]
> [<ffffffff838bd5a3>] ipvlan_process_outbound drivers/net/ipvlan/ipvlan_co=
re.c:529 [inline]
> [<ffffffff838bd5a3>] ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c=
:602 [inline]
> [<ffffffff838bd5a3>] ipvlan_queue_xmit+0xc33/0x1be0 drivers/net/ipvlan/ip=
vlan_core.c:677
> [<ffffffff838c2909>] ipvlan_start_xmit+0x49/0x100 drivers/net/ipvlan/ipvl=
an_main.c:229
> [<ffffffff84d03900>] netdev_start_xmit include/linux/netdevice.h:4966 [in=
line]
> [<ffffffff84d03900>] xmit_one net/core/dev.c:3644 [inline]
> [<ffffffff84d03900>] dev_hard_start_xmit+0x320/0x980 net/core/dev.c:3660
> [<ffffffff84d080e2>] __dev_queue_xmit+0x16b2/0x3370 net/core/dev.c:4324
> [<ffffffff855ce4cd>] dev_queue_xmit include/linux/netdevice.h:3067 [inlin=
e]
> [<ffffffff855ce4cd>] neigh_hh_output include/net/neighbour.h:529 [inline]
> [<ffffffff855ce4cd>] neigh_output include/net/neighbour.h:543 [inline]
> [<ffffffff855ce4cd>] ip6_finish_output2+0x160d/0x1ae0 net/ipv6/ip6_output=
.c:139
> [<ffffffff855b8616>] __ip6_finish_output net/ipv6/ip6_output.c:200 [inlin=
e]
> [<ffffffff855b8616>] ip6_finish_output+0x6c6/0xb10 net/ipv6/ip6_output.c:=
211
> [<ffffffff855b7e3c>] NF_HOOK_COND include/linux/netfilter.h:298 [inline]
> [<ffffffff855b7e3c>] ip6_output+0x2bc/0x3d0 net/ipv6/ip6_output.c:232
> [<ffffffff8575d27f>] dst_output include/net/dst.h:444 [inline]
> [<ffffffff8575d27f>] ip6_local_out+0x10f/0x140 net/ipv6/output_core.c:161
> [<ffffffff838bdae4>] ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan=
_core.c:483 [inline]
> [<ffffffff838bdae4>] ipvlan_process_outbound drivers/net/ipvlan/ipvlan_co=
re.c:529 [inline]
> [<ffffffff838bdae4>] ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c=
:602 [inline]
> [<ffffffff838bdae4>] ipvlan_queue_xmit+0x1174/0x1be0 drivers/net/ipvlan/i=
pvlan_core.c:677
> [<ffffffff838c2909>] ipvlan_start_xmit+0x49/0x100 drivers/net/ipvlan/ipvl=
an_main.c:229
> [<ffffffff84d03900>] netdev_start_xmit include/linux/netdevice.h:4966 [in=
line]
> [<ffffffff84d03900>] xmit_one net/core/dev.c:3644 [inline]
> [<ffffffff84d03900>] dev_hard_start_xmit+0x320/0x980 net/core/dev.c:3660
> [<ffffffff84d080e2>] __dev_queue_xmit+0x16b2/0x3370 net/core/dev.c:4324
> [<ffffffff855ce4cd>] dev_queue_xmit include/linux/netdevice.h:3067 [inlin=
e]
> [<ffffffff855ce4cd>] neigh_hh_output include/net/neighbour.h:529 [inline]
> [<ffffffff855ce4cd>] neigh_output include/net/neighbour.h:543 [inline]
> [<ffffffff855ce4cd>] ip6_finish_output2+0x160d/0x1ae0 net/ipv6/ip6_output=
.c:139
> [<ffffffff855b8616>] __ip6_finish_output net/ipv6/ip6_output.c:200 [inlin=
e]
> [<ffffffff855b8616>] ip6_finish_output+0x6c6/0xb10 net/ipv6/ip6_output.c:=
211
> [<ffffffff855b7e3c>] NF_HOOK_COND include/linux/netfilter.h:298 [inline]
> [<ffffffff855b7e3c>] ip6_output+0x2bc/0x3d0 net/ipv6/ip6_output.c:232
> [<ffffffff8575d27f>] dst_output include/net/dst.h:444 [inline]
> [<ffffffff8575d27f>] ip6_local_out+0x10f/0x140 net/ipv6/output_core.c:161
> [<ffffffff838bdae4>] ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan=
_core.c:483 [inline]
> [<ffffffff838bdae4>] ipvlan_process_outbound drivers/net/ipvlan/ipvlan_co=
re.c:529 [inline]
> [<ffffffff838bdae4>] ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c=
:602 [inline]
> [<ffffffff838bdae4>] ipvlan_queue_xmit+0x1174/0x1be0 drivers/net/ipvlan/i=
pvlan_core.c:677
> [<ffffffff838c2909>] ipvlan_start_xmit+0x49/0x100 drivers/net/ipvlan/ipvl=
an_main.c:229
> [<ffffffff84d03900>] netdev_start_xmit include/linux/netdevice.h:4966 [in=
line]
> [<ffffffff84d03900>] xmit_one net/core/dev.c:3644 [inline]
> [<ffffffff84d03900>] dev_hard_start_xmit+0x320/0x980 net/core/dev.c:3660
> [<ffffffff84d080e2>] __dev_queue_xmit+0x16b2/0x3370 net/core/dev.c:4324
> [<ffffffff855ce4cd>] dev_queue_xmit include/linux/netdevice.h:3067 [inlin=
e]
> [<ffffffff855ce4cd>] neigh_hh_output include/net/neighbour.h:529 [inline]
> [<ffffffff855ce4cd>] neigh_output include/net/neighbour.h:543 [inline]
> [<ffffffff855ce4cd>] ip6_finish_output2+0x160d/0x1ae0 net/ipv6/ip6_output=
.c:139
> [<ffffffff855b8616>] __ip6_finish_output net/ipv6/ip6_output.c:200 [inlin=
e]
> [<ffffffff855b8616>] ip6_finish_output+0x6c6/0xb10 net/ipv6/ip6_output.c:=
211
> [<ffffffff855b7e3c>] NF_HOOK_COND include/linux/netfilter.h:298 [inline]
> [<ffffffff855b7e3c>] ip6_output+0x2bc/0x3d0 net/ipv6/ip6_output.c:232
> [<ffffffff8575d27f>] dst_output include/net/dst.h:444 [inline]
> [<ffffffff8575d27f>] ip6_local_out+0x10f/0x140 net/ipv6/output_core.c:161
> [<ffffffff838bdae4>] ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan=
_core.c:483 [inline]
> [<ffffffff838bdae4>] ipvlan_process_outbound drivers/net/ipvlan/ipvlan_co=
re.c:529 [inline]
> [<ffffffff838bdae4>] ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c=
:602 [inline]
> [<ffffffff838bdae4>] ipvlan_queue_xmit+0x1174/0x1be0 drivers/net/ipvlan/i=
pvlan_core.c:677
> [<ffffffff838c2909>] ipvlan_start_xmit+0x49/0x100 drivers/net/ipvlan/ipvl=
an_main.c:229
> [<ffffffff84d03900>] netdev_start_xmit include/linux/netdevice.h:4966 [in=
line]
> [<ffffffff84d03900>] xmit_one net/core/dev.c:3644 [inline]
> [<ffffffff84d03900>] dev_hard_start_xmit+0x320/0x980 net/core/dev.c:3660
> [<ffffffff84d080e2>] __dev_queue_xmit+0x16b2/0x3370 net/core/dev.c:4324
> [<ffffffff855ce4cd>] dev_queue_xmit include/linux/netdevice.h:3067 [inlin=
e]
> [<ffffffff855ce4cd>] neigh_hh_output include/net/neighbour.h:529 [inline]
> [<ffffffff855ce4cd>] neigh_output include/net/neighbour.h:543 [inline]
> [<ffffffff855ce4cd>] ip6_finish_output2+0x160d/0x1ae0 net/ipv6/ip6_output=
.c:139
> [<ffffffff855b8616>] __ip6_finish_output net/ipv6/ip6_output.c:200 [inlin=
e]
> [<ffffffff855b8616>] ip6_finish_output+0x6c6/0xb10 net/ipv6/ip6_output.c:=
211
> [<ffffffff855b7e3c>] NF_HOOK_COND include/linux/netfilter.h:298 [inline]
> [<ffffffff855b7e3c>] ip6_output+0x2bc/0x3d0 net/ipv6/ip6_output.c:232
> [<ffffffff8575d27f>] dst_output include/net/dst.h:444 [inline]
> [<ffffffff8575d27f>] ip6_local_out+0x10f/0x140 net/ipv6/output_core.c:161
> [<ffffffff838bdae4>] ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan=
_core.c:483 [inline]
> [<ffffffff838bdae4>] ipvlan_process_outbound drivers/net/ipvlan/ipvlan_co=
re.c:529 [inline]
> [<ffffffff838bdae4>] ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c=
:602 [inline]
> [<ffffffff838bdae4>] ipvlan_queue_xmit+0x1174/0x1be0 drivers/net/ipvlan/i=
pvlan_core.c:677
> [<ffffffff838c2909>] ipvlan_start_xmit+0x49/0x100 drivers/net/ipvlan/ipvl=
an_main.c:229
> [<ffffffff84d03900>] netdev_start_xmit include/linux/netdevice.h:4966 [in=
line]
> [<ffffffff84d03900>] xmit_one net/core/dev.c:3644 [inline]
> [<ffffffff84d03900>] dev_hard_start_xmit+0x320/0x980 net/core/dev.c:3660
> [<ffffffff84d080e2>] __dev_queue_xmit+0x16b2/0x3370 net/core/dev.c:4324
> [<ffffffff84d4a65e>] dev_queue_xmit include/linux/netdevice.h:3067 [inlin=
e]
> [<ffffffff84d4a65e>] neigh_resolve_output+0x64e/0x750 net/core/neighbour.=
c:1560
> [<ffffffff855ce503>] neigh_output include/net/neighbour.h:545 [inline]
> [<ffffffff855ce503>] ip6_finish_output2+0x1643/0x1ae0 net/ipv6/ip6_output=
.c:139
> [<ffffffff855b8616>] __ip6_finish_output net/ipv6/ip6_output.c:200 [inlin=
e]
> [<ffffffff855b8616>] ip6_finish_output+0x6c6/0xb10 net/ipv6/ip6_output.c:=
211
> [<ffffffff855b7e3c>] NF_HOOK_COND include/linux/netfilter.h:298 [inline]
> [<ffffffff855b7e3c>] ip6_output+0x2bc/0x3d0 net/ipv6/ip6_output.c:232
> [<ffffffff855b9ce4>] dst_output include/net/dst.h:444 [inline]
> [<ffffffff855b9ce4>] NF_HOOK include/linux/netfilter.h:309 [inline]
> [<ffffffff855b9ce4>] ip6_xmit+0x11a4/0x1b20 net/ipv6/ip6_output.c:352
> [<ffffffff8597984e>] sctp_v6_xmit+0x9ae/0x1230 net/sctp/ipv6.c:250
> [<ffffffff8594623e>] sctp_packet_transmit+0x25de/0x2bc0 net/sctp/output.c=
:653
> [<ffffffff858f5142>] sctp_packet_singleton+0x202/0x310 net/sctp/outqueue.=
c:783
> [<ffffffff858ea411>] sctp_outq_flush_ctrl net/sctp/outqueue.c:914 [inline=
]
> [<ffffffff858ea411>] sctp_outq_flush+0x661/0x3d40 net/sctp/outqueue.c:121=
2
> [<ffffffff858f02f9>] sctp_outq_uncork+0x79/0xb0 net/sctp/outqueue.c:764
> [<ffffffff8589f060>] sctp_side_effects net/sctp/sm_sideeffect.c:1199 [inl=
ine]
> [<ffffffff8589f060>] sctp_do_sm+0x55c0/0x5c30 net/sctp/sm_sideeffect.c:11=
70
> [<ffffffff85941567>] sctp_primitive_ASSOCIATE+0x97/0xc0 net/sctp/primitiv=
e.c:73
> [<ffffffff859408b2>] sctp_sendmsg_to_asoc+0xf62/0x17b0 net/sctp/socket.c:=
1839
> [<ffffffff85910b5e>] sctp_sendmsg+0x212e/0x33b0 net/sctp/socket.c:2029
> [<ffffffff8544d559>] inet_sendmsg+0x149/0x310 net/ipv4/af_inet.c:849
> [<ffffffff84c6c4d2>] sock_sendmsg_nosec net/socket.c:716 [inline]
> [<ffffffff84c6c4d2>] sock_sendmsg net/socket.c:736 [inline]
> [<ffffffff84c6c4d2>] ____sys_sendmsg+0x572/0x8c0 net/socket.c:2504
> [<ffffffff84c6ca91>] ___sys_sendmsg net/socket.c:2558 [inline]
> [<ffffffff84c6ca91>] __sys_sendmsg+0x271/0x360 net/socket.c:2587
> [<ffffffff84c6cbff>] __do_sys_sendmsg net/socket.c:2596 [inline]
> [<ffffffff84c6cbff>] __se_sys_sendmsg net/socket.c:2594 [inline]
> [<ffffffff84c6cbff>] __x64_sys_sendmsg+0x7f/0x90 net/socket.c:2594
> [<ffffffff85b32553>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> [<ffffffff85b32553>] do_syscall_64+0x53/0x80 arch/x86/entry/common.c:84
> [<ffffffff85c00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Mahesh Bandewar <maheshb@google.com>
> Cc: Willem de Bruijn <willemb@google.com>
> ---
>  drivers/net/ipvlan/ipvlan_core.c | 41 +++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan=
_core.c
> index 21e9cac7312186380fa60de11f0a9178080b74b0..2d5b021b4ea6053eeb055a76f=
a4c7d9380cd2a53 100644
> --- a/drivers/net/ipvlan/ipvlan_core.c
> +++ b/drivers/net/ipvlan/ipvlan_core.c
> @@ -411,7 +411,7 @@ struct ipvl_addr *ipvlan_addr_lookup(struct ipvl_port=
 *port, void *lyr3h,
>         return addr;
>  }
>
> -static int ipvlan_process_v4_outbound(struct sk_buff *skb)
> +static noinline_for_stack int ipvlan_process_v4_outbound(struct sk_buff =
*skb)
>  {
>         const struct iphdr *ip4h =3D ip_hdr(skb);
>         struct net_device *dev =3D skb->dev;
> @@ -453,13 +453,11 @@ static int ipvlan_process_v4_outbound(struct sk_buf=
f *skb)
>  }
>
>  #if IS_ENABLED(CONFIG_IPV6)
> -static int ipvlan_process_v6_outbound(struct sk_buff *skb)
> +
> +static noinline_for_stack int
> +ipvlan_route_v6_outbound(struct net_device *dev, struct sk_buff *skb)
>  {
>         const struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
> -       struct net_device *dev =3D skb->dev;
> -       struct net *net =3D dev_net(dev);
> -       struct dst_entry *dst;
> -       int err, ret =3D NET_XMIT_DROP;
>         struct flowi6 fl6 =3D {
>                 .flowi6_oif =3D dev->ifindex,
>                 .daddr =3D ip6h->daddr,
> @@ -469,27 +467,38 @@ static int ipvlan_process_v6_outbound(struct sk_buf=
f *skb)
>                 .flowi6_mark =3D skb->mark,
>                 .flowi6_proto =3D ip6h->nexthdr,
>         };
> +       struct dst_entry *dst;
> +       int err;
>
> -       dst =3D ip6_route_output(net, NULL, &fl6);
> -       if (dst->error) {
> -               ret =3D dst->error;
> +       dst =3D ip6_route_output(dev_net(dev), NULL, &fl6);
> +       err =3D dst->error;
> +       if (err) {
>                 dst_release(dst);
> -               goto err;
> +               return err;
>         }
>         skb_dst_set(skb, dst);
> +       return 0;
> +}
> +
> +static int ipvlan_process_v6_outbound(struct sk_buff *skb)
> +{
> +       struct net_device *dev =3D skb->dev;
> +       int err, ret =3D NET_XMIT_DROP;
> +
> +       err =3D ipvlan_route_v6_outbound(dev, skb);
> +       if (unlikely(err)) {
> +               DEV_STATS_INC(dev, tx_errors);
> +               kfree_skb(skb);
> +               return err;

Do you think that it is an oversight that this function mixes a return
of NET_XMIT_DROP/NET_XMIT_SUCCESS with returning the error code
received from deep in the routing stack?

Either way, this patch preserves that existing behavior, so

Reviewed-by: Willem de Bruijn <willemb@google.com>


> +       }
>
>         memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
>
> -       err =3D ip6_local_out(net, skb->sk, skb);
> +       err =3D ip6_local_out(dev_net(dev), skb->sk, skb);
>         if (unlikely(net_xmit_eval(err)))
>                 DEV_STATS_INC(dev, tx_errors);
>         else
>                 ret =3D NET_XMIT_SUCCESS;
> -       goto out;
> -err:
> -       DEV_STATS_INC(dev, tx_errors);
> -       kfree_skb(skb);
> -out:
>         return ret;
>  }
>  #else
> --
> 2.42.0.869.gea05f2083d-goog
>
>

