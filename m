Return-Path: <netdev+bounces-52410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5C17FEA91
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE29BB20E71
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 08:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F57E20DC5;
	Thu, 30 Nov 2023 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lDF1uK/O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476259A
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 00:29:18 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so9814a12.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 00:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701332957; x=1701937757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFTl4jZbDi1ledWgZnw7rIX26CdANEx4lUnCFxwxKpM=;
        b=lDF1uK/O3s+Cw4ZGyhLm5V7LKq7acI1Mox2+LxBtAVQ/jxCoDQa1Sn+qQreHLSqiGU
         u1+c/wUOxWyQDo1Dxtrzjj+wc+bk7Ed1yrBgkywl1dYpvIJNt8k5Ttu6MBPwInKJMuEX
         qt8hqbu1D72hF3OSRc86YblqucXemrGAiTDAQIWw6raxJ9RkuWknBDDxODU5Gc1sGKLv
         wjYvir7fCJezu5Sb9O8TWfgRNB/zowB+J5mO1LgjEDQn/L9hwaI60w/25vJtjR1taVNp
         KppayjVXfqWYRKDgyYscmlGvWa2GL7E2AV7+rRzV2xGv9KJHaLRfwONYcW3jIlKX/E/r
         3dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701332957; x=1701937757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFTl4jZbDi1ledWgZnw7rIX26CdANEx4lUnCFxwxKpM=;
        b=KmGxX8/rdTiThishbiyVKFpzmganNfoGGqndPyQP/W9pnbsvtiJo+cglUWcz3gJclv
         tb3N76qOKCkdhgXTRV69nRBD1MDsRzCTOMa19nYlNkWjXXNggF5i1CvhSh8uvfyhnfe5
         JxdPoqzZKfFFCEn03uomSjOTAZZwUbuwGP9Dow9kLPhTS8RMLb8bGooznmjvvh+o+5X9
         Hc+VOgKZuM9uVp0IeVBCKaiThMn9rfhlCZfdA7D1Fw9WQu+RwH3ozVWm+Sx/UJNAHCjT
         S/76W0fcZEXGcqmrTrhgWDYfzh+YlFi+6e/opy/d4anb8gePyXdA0QBnbZYhCPy69BWE
         b2mg==
X-Gm-Message-State: AOJu0YzR7YTTtq8Q5TUF+CnhXwaGH0UzSz5I0gUjVOvtV8CPmzSkZC96
	LZGDbUPqGHk72pBQUgKcZJ9vqXoFA8VcWzsNqbpeyg==
X-Google-Smtp-Source: AGHT+IE9La8PldLRffnM6AOmleVNiMY5TwpT1Qc2L/No4wXzKaDjG4fVeR2KvOlf3yY2BgjN5XvQrCtrts9oQ/Rz78c=
X-Received: by 2002:a50:8a8e:0:b0:54b:bf08:a95f with SMTP id
 j14-20020a508a8e000000b0054bbf08a95fmr117800edj.6.1701332956427; Thu, 30 Nov
 2023 00:29:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f2b6b0060b488674@google.com> <20231130073749.1329999-1-lizhi.xu@windriver.com>
In-Reply-To: <20231130073749.1329999-1-lizhi.xu@windriver.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Nov 2023 09:29:04 +0100
Message-ID: <CANn89iJxtgkKLQwmi2ZZYQP0VnrWgarJZrSL2KgkSdkO615vcw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: page_pool: fix null-ptr-deref in page_pool_unlist
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com, 
	almasrymina@google.com, davem@davemloft.net, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 8:37=E2=80=AFAM Lizhi Xu <lizhi.xu@windriver.com> w=
rote:
>
> [Syz report]
> Illegal XDP return value 4294946546 on prog  (id 2) dev N/A, expect packe=
t loss!
> general protection fault, probably for non-canonical address 0xdffffc0000=
000000: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 0 PID: 5064 Comm: syz-executor391 Not tainted 6.7.0-rc2-syzkaller-00=
533-ga379972973a8 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 11/10/2023
> RIP: 0010:__hlist_del include/linux/list.h:988 [inline]
> RIP: 0010:hlist_del include/linux/list.h:1002 [inline]
> RIP: 0010:page_pool_unlist+0xd1/0x170 net/core/page_pool_user.c:342
> Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 90 00 00 00 4c 8b a3 f0 0=
6 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75=
 68 48 85 ed 49 89 2c 24 74 24 e8 1b ca 07 f9 48 8d
> RSP: 0018:ffffc900039ff768 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffff88814ae02000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88814ae026f0
> RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1d57fdc
> R10: ffffffff8eabfee3 R11: ffffffff8aa0008b R12: 0000000000000000
> R13: ffff88814ae02000 R14: dffffc0000000000 R15: 0000000000000001
> FS:  000055555717a380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000002555398 CR3: 0000000025044000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __page_pool_destroy net/core/page_pool.c:851 [inline]
>  page_pool_release+0x507/0x6b0 net/core/page_pool.c:891
>  page_pool_destroy+0x1ac/0x4c0 net/core/page_pool.c:956
>  xdp_test_run_teardown net/bpf/test_run.c:216 [inline]
>  bpf_test_run_xdp_live+0x1578/0x1af0 net/bpf/test_run.c:388
>  bpf_prog_test_run_xdp+0x827/0x1530 net/bpf/test_run.c:1254
>  bpf_prog_test_run kernel/bpf/syscall.c:4041 [inline]
>  __sys_bpf+0x11bf/0x4920 kernel/bpf/syscall.c:5402
>  __do_sys_bpf kernel/bpf/syscall.c:5488 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5486 [inline]
>  __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5486
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> [Analysis]
> If "user.list" is initialized, the corresponding slow.netdev device must =
exist,
> so before recycling "user.list", it is necessary to confirm that the "slo=
w.netdev"
> device is valid.
>
> [Fix]
> Add slow.netdev !=3D NULL check before delete "user.list".
>
> Fixes: 083772c9f972 ("net: page_pool: record pools per netdev")
> Reported-by: syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>



I sent a fix already ?

https://lore.kernel.org/netdev/CANn89i+6BuZA6AjocG_0zTkD1u=3DpNgZc_DpZMO=3D=
yUN=3DS1cHS3w@mail.gmail.com/

Please do not attribute to yourself work done by others, let me submit
the fix formally, thanks.





> ---
>  net/core/page_pool_user.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
> index 1426434a7e15..ca71f4103b3a 100644
> --- a/net/core/page_pool_user.c
> +++ b/net/core/page_pool_user.c
> @@ -339,7 +339,8 @@ void page_pool_unlist(struct page_pool *pool)
>         mutex_lock(&page_pools_lock);
>         netdev_nl_page_pool_event(pool, NETDEV_CMD_PAGE_POOL_DEL_NTF);
>         xa_erase(&page_pools, pool->user.id);
> -       hlist_del(&pool->user.list);
> +       if (pool->slow.netdev)
> +               hlist_del(&pool->user.list);
>         mutex_unlock(&page_pools_lock);
>  }
>
> --
> 2.26.1
>

