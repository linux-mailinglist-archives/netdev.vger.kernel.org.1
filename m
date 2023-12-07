Return-Path: <netdev+bounces-54852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA51808931
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 14:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A829828304A
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 13:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D9C40BE1;
	Thu,  7 Dec 2023 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlL/YjVc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC6C10C2
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 05:29:37 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso8442a12.1
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 05:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701955776; x=1702560576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iE5wSRpyi4qkVk7sZZIsQKJL0ecDYjuI1CJ7H63UiBc=;
        b=mlL/YjVcKlkIW6klOOCiqJ/Lc+dkYXYEHGarWNyfXdzj2vjrlWWyV5hafEXKX89m5G
         u0+sFKc4sEEoYVKer5XfUjqkm0G/SiTGm9DHpvp3zJyObj7YqYgcN/ONlzYQbf876WWF
         m6UqeKGByNwz32rCsqaow4jnIs0nhwQGLURU4/ErTE5VGONdtjzj4rwja5lCc0AG5+mH
         TiNCRDZWeg+OoFeJTNseNR0McGRQQeI349t82/nk5b69gEssEDap9Vt4zLjMGZzco8kl
         lAtdmplT7j6OymDWd1TfUynOwY17eztABkgGeNzal24qRiJv4FtXf09E8CoSJriIjt1m
         ZytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701955776; x=1702560576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iE5wSRpyi4qkVk7sZZIsQKJL0ecDYjuI1CJ7H63UiBc=;
        b=SfyYW7XVgCV0srkX51IVPpbiW5ceAMQN2M7hJMi47wTIRB1rkyIcSS7saw2Q8OHHm1
         KuufY1O2ZxXIiHamlQB4l3nrM1l7I/68J1FXTbG2UDYrsinYxnD0KqcLeiPwXuQDatEm
         u8+L5Efw1FD6/ZFd/a8ooU9HrLd5o4q5Mlkfu2Kop0oLyDe1ZMOfrEUZQOg7Ievb9VxP
         XIKhGGk1dawCxSAaPgYfpyaPEhzuHiD5SM5Kf2dfbYi3oanOciRot7O7/pCSVDOAhkdD
         LCf6XLzATkSxWY68o7V68J3fQ9pgXdfQjxxdzHxFh49VyArk+X1ZxWT6tEsvkJWktBMu
         7T6Q==
X-Gm-Message-State: AOJu0YyE0fAYO0Ps2eKKFCG0LMg7/78dd0coP/4C3gMS3pTuPw54oaic
	Oo8QJ0MdYVAx1BX3zwjFx5xrYq8dVfII+8oNpehyhByFeR0Wi9x3nVWtUg==
X-Google-Smtp-Source: AGHT+IH1cr6O9yPTA6CMV8lL48xt8H+lS9Y52KAetUTOS0cUzDKx34oWeNOUmLvJH1gvczrRN5RM02JtxhnZ9dRNpac=
X-Received: by 2002:a50:c35d:0:b0:54c:79ed:a018 with SMTP id
 q29-20020a50c35d000000b0054c79eda018mr246249edb.2.1701955775847; Thu, 07 Dec
 2023 05:29:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205173250.2982846-1-edumazet@google.com> <170191862445.7525.14404095197034927243.git-patchwork-notify@kernel.org>
In-Reply-To: <170191862445.7525.14404095197034927243.git-patchwork-notify@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Dec 2023 14:29:22 +0100
Message-ID: <CANn89iKcFxJ68+M8UvHzqp1k-FDiZHZ8ujP79WJd1338DVJy6w@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: add debug checks in fib6_info_release()
To: patchwork-bot+netdevbpf@kernel.org, Kui-Feng Lee <thinker.li@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 4:10=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org>=
 wrote:
>
> Hello:
>
> This patch was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
>
> On Tue,  5 Dec 2023 17:32:50 +0000 you wrote:
> > Some elusive syzbot reports are hinting to fib6_info_release(),
> > with a potential dangling f6i->gc_link anchor.
> >
> > Add debug checks so that syzbot can catch the issue earlier eventually.
> >
> > BUG: KASAN: slab-use-after-free in __hlist_del include/linux/list.h:990=
 [inline]
> > BUG: KASAN: slab-use-after-free in hlist_del_init include/linux/list.h:=
1016 [inline]
> > BUG: KASAN: slab-use-after-free in fib6_clean_expires_locked include/ne=
t/ip6_fib.h:533 [inline]
> > BUG: KASAN: slab-use-after-free in fib6_purge_rt+0x986/0x9c0 net/ipv6/i=
p6_fib.c:1064
> > Write of size 8 at addr ffff88802805a840 by task syz-executor.1/10057
> >
> > [...]
>
> Here is the summary with links:
>   - [net-next] ipv6: add debug checks in fib6_info_release()
>     https://git.kernel.org/netdev/net-next/c/5a08d0065a91

Nice, syzbot gave me exactly what I was looking for.

WARNING: CPU: 0 PID: 5059 at include/net/ip6_fib.h:332
fib6_info_release include/net/ip6_fib.h:332 [inline]
WARNING: CPU: 0 PID: 5059 at include/net/ip6_fib.h:332
ip6_route_info_create+0x1a1a/0x1f10 net/ipv6/route.c:3829
Modules linked in:
CPU: 0 PID: 5059 Comm: syz-executor256 Not tainted
6.7.0-rc3-syzkaller-00805-g5a08d0065a91 #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 11/10/2023
RIP: 0010:fib6_info_release include/net/ip6_fib.h:332 [inline]
RIP: 0010:ip6_route_info_create+0x1a1a/0x1f10 net/ipv6/route.c:3829
Code: 49 83 7f 40 00 75 28 e8 04 ae 50 f8 49 8d bf a0 00 00 00 48 c7
c6 c0 ae 37 89 e8 41 2c 3a f8 e9 65 f4 ff ff e8 e7 ad 50 f8 90 <0f> 0b
90 eb ad e8 dc ad 50 f8 90 0f 0b 90 eb cd e8 d1 ad 50 f8 e8
RSP: 0018:ffffc90003bdf8e0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000400000 RCX: ffffffff8936e418
RDX: ffff888026a58000 RSI: ffffffff8936e469 RDI: 0000000000000005
RBP: ffffc90003bdf9d0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000400000 R11: ffffffff81de4c35 R12: ffffffffffffffea
R13: ffff88802993242c R14: ffffc90003bdfac4 R15: ffff888029932400
FS: 00005555562b4380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004585c0 CR3: 000000007390d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
ip6_route_add+0x26/0x1f0 net/ipv6/route.c:3843
ipv6_route_ioctl+0x3ff/0x590 net/ipv6/route.c:4467
inet6_ioctl+0x265/0x2b0 net/ipv6/af_inet6.c:575
sock_do_ioctl+0x113/0x270 net/socket.c:1220
sock_ioctl+0x22e/0x6b0 net/socket.c:1339
vfs_ioctl fs/ioctl.c:51 [inline]
__do_sys_ioctl fs/ioctl.c:871 [inline]
__se_sys_ioctl fs/ioctl.c:857 [inline]
__x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
do_syscall_x64 arch/x86/entry/common.c:51 [inline]
do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f175790d369


Following commit seems buggy.

commit 3dec89b14d37ee635e772636dad3f09f78f1ab87
Author: Kui-Feng Lee <thinker.li@gmail.com>
Date:   Tue Aug 15 11:07:05 2023 -0700

    net/ipv6: Remove expired routes with a separated list of routes.

    FIB6 GC walks trees of fib6_tables to remove expired routes. Walking a =
tree
    can be expensive if the number of routes in a table is big, even if mos=
t of
    them are permanent. Checking routes in a separated list of routes havin=
g
    expiration will avoid this potential issue.

    Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
    Reviewed-by: David Ahern <dsahern@kernel.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>

