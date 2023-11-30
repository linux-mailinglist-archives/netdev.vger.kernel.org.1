Return-Path: <netdev+bounces-52430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6137FEB60
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 10:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E12281FCD
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035A4347B2;
	Thu, 30 Nov 2023 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Q3K7ila"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B9ACF
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 01:06:35 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso6743a12.1
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 01:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701335194; x=1701939994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ji0TcYQnbQEbDh01WgrJTk7wL+caCmxVODK2KI2XUTs=;
        b=1Q3K7ilaKOumFPuY10P1rU/0/sDAXFgmQRNJZTFwCSxx2+jqebsg2rOwMNP6A6GxSh
         9KFbuMa7ng81l7C9Se9Vprqmg34U6E5OVEjPD9PZLkZooc0kljCZhSdjR6vvrbVMxIeU
         OmpxacxuBwrCMSV7IlnLsaQjKRfwDZhh5GmmAfSNulZVaUkW41GTpL4wPZchA6+Gj8jy
         IHu7eXI5oVfo2pzbTmPU7kA9OijE1NNCF6pwOXPWJyScOEYmLusk7ogvhu8CjtzNhzpK
         dbGB9JLP02JTP0uceycE1E/TXx2oJI0wllmS4GCwEvXdtv5ztPT6YZQIzEgVgWrt50Ou
         FTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701335194; x=1701939994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ji0TcYQnbQEbDh01WgrJTk7wL+caCmxVODK2KI2XUTs=;
        b=Sl2Xf6++akZrOFvpboCiuT11ICfOiW7zh1DMgA7G/KAQ/oHaCuoFGiXPNhdUt/ATAw
         MRns10yh98dASEDUly9B0cy3cGYwaqDH+jLIaWk+1rj7LsunnCV61MkPZ0yK3JH/Rz22
         LSs/Cy60yybGe4vD05rrLNXuVTORRNqVi6xO1lbxWDYyqFu2sICjrTnNLkptB9QW4F9p
         SfPb+2RmM+DeBtGPLfmPIP3ZCPVSqVaudZ43XKdrhPDlzjGFWmT4ypsYKIwvNRZdbdhF
         4noT38G2urbTL0M5sbOurDJgQWKLvzKaqwQgpltZ0QibVZmtqvTafIVbjzHSUxwZAbOG
         lmKg==
X-Gm-Message-State: AOJu0YwxqnJC8FkOhf2+B9lYyfBMN0TI6oz9yhO9RIbT2DEHzr6oY/k/
	wmEdJiTXFkF8gd1CKo77ZHQz+1Z5jJw6/SAQ2UZLdg==
X-Google-Smtp-Source: AGHT+IH1Pp3wiHdsDAnteFWdj5kVjIBa/ymgRlPikZYTN1ohVofW7QppOL2mSsJW3mzKg0X8sA586SgCJmVWbQI+TkI=
X-Received: by 2002:a50:9f82:0:b0:54b:221d:ee1c with SMTP id
 c2-20020a509f82000000b0054b221dee1cmr80711edf.5.1701335193804; Thu, 30 Nov
 2023 01:06:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJxtgkKLQwmi2ZZYQP0VnrWgarJZrSL2KgkSdkO615vcw@mail.gmail.com>
 <20231130085810.4014847-1-lizhi.xu@windriver.com>
In-Reply-To: <20231130085810.4014847-1-lizhi.xu@windriver.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Nov 2023 10:06:20 +0100
Message-ID: <CANn89iJT_dkpK2+9pAE376om6gDem7VKtCuALwPLc3AUWL8M8w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: page_pool: fix null-ptr-deref in page_pool_unlist
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: almasrymina@google.com, davem@davemloft.net, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 9:58=E2=80=AFAM Lizhi Xu <lizhi.xu@windriver.com> w=
rote:
>
> On Thu, 30 Nov 2023 09:29:04 +0100, Eric Dumazet <edumazet@google.com> wr=
ote:
> > > [Syz report]
> > > Illegal XDP return value 4294946546 on prog  (id 2) dev N/A, expect p=
acket loss!
> > > general protection fault, probably for non-canonical address 0xdffffc=
0000000000: 0000 [#1] PREEMPT SMP KASAN
> > > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007=
]
> > > CPU: 0 PID: 5064 Comm: syz-executor391 Not tainted 6.7.0-rc2-syzkalle=
r-00533-ga379972973a8 #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 11/10/2023
> > > RIP: 0010:__hlist_del include/linux/list.h:988 [inline]
> > > RIP: 0010:hlist_del include/linux/list.h:1002 [inline]
> > > RIP: 0010:page_pool_unlist+0xd1/0x170 net/core/page_pool_user.c:342
> > > Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 90 00 00 00 4c 8b a3 =
f0 06 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 0=
0 75 68 48 85 ed 49 89 2c 24 74 24 e8 1b ca 07 f9 48 8d
> > > RSP: 0018:ffffc900039ff768 EFLAGS: 00010246
> > > RAX: dffffc0000000000 RBX: ffff88814ae02000 RCX: 0000000000000000
> > > RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88814ae026f0
> > > RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1d57fdc
> > > R10: ffffffff8eabfee3 R11: ffffffff8aa0008b R12: 0000000000000000
> > > R13: ffff88814ae02000 R14: dffffc0000000000 R15: 0000000000000001
> > > FS:  000055555717a380(0000) GS:ffff8880b9800000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000000002555398 CR3: 0000000025044000 CR4: 00000000003506f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  __page_pool_destroy net/core/page_pool.c:851 [inline]
> > >  page_pool_release+0x507/0x6b0 net/core/page_pool.c:891
> > >  page_pool_destroy+0x1ac/0x4c0 net/core/page_pool.c:956
> > >  xdp_test_run_teardown net/bpf/test_run.c:216 [inline]
> > >  bpf_test_run_xdp_live+0x1578/0x1af0 net/bpf/test_run.c:388
> > >  bpf_prog_test_run_xdp+0x827/0x1530 net/bpf/test_run.c:1254
> > >  bpf_prog_test_run kernel/bpf/syscall.c:4041 [inline]
> > >  __sys_bpf+0x11bf/0x4920 kernel/bpf/syscall.c:5402
> > >  __do_sys_bpf kernel/bpf/syscall.c:5488 [inline]
> > >  __se_sys_bpf kernel/bpf/syscall.c:5486 [inline]
> > >  __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5486
> > >  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> > >  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
> > >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> > >
> > > [Analysis]
> > > If "user.list" is initialized, the corresponding slow.netdev device m=
ust exist,
> > > so before recycling "user.list", it is necessary to confirm that the =
"slow.netdev"
> > > device is valid.
> > >
> > > [Fix]
> > > Add slow.netdev !=3D NULL check before delete "user.list".
> > >
> > > Fixes: 083772c9f972 ("net: page_pool: record pools per netdev")
> > > Reported-by: syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com
> > > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> >
> >
> >
> > I sent a fix already ?
> >
> > https://lore.kernel.org/netdev/CANn89i+6BuZA6AjocG_0zTkD1u=3DpNgZc_DpZM=
O=3DyUN=3DS1cHS3w@mail.gmail.com/
> >
> > Please do not attribute to yourself work done by others, let me submit
> > the fix formally, thanks.
> What exists may not necessarily be right, and how do you prove that I saw=
 your
> fix before fixing it?
>
> You have only tested on syzbot, that's all.
> This does not mean that others should refer to you for repairs, nor does =
it
> prove that you have made repairs, and others cannot fix them.

I am just saying I sent a fix already, and that it was sent a few
minutes after the syzbot report was available.

(You included syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com in
your report, meaning that you must have seen my patch)

It is not because I sleep during night time that you can decide to use
my work without any credits.

