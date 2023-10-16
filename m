Return-Path: <netdev+bounces-41261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8525D7CA651
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD26FB20CA9
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0472134C;
	Mon, 16 Oct 2023 11:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhkGarQD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F401D543
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:12:18 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC65D83
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 04:12:16 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507a5edc2ebso4045e87.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 04:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697454735; x=1698059535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnIrmXxUURiIeSQAirrpqB7bVt8GpjLnuUlE7YD5p24=;
        b=NhkGarQDVUCAvHKxCQ8YHbW2KpbUlKLPPyJ0IDHwRhuzB54hK2jrT1FSM6WgquVyeK
         J0Y9GriLqg2S6XwJxyfdHZ/AhZG4QCUsp4h5TdNIMCMhN+Eed1e3K4v3T5WgqmzyWuGy
         K0sVKOlyX0wnBx0Vq3R48f2zck1DH5kH8304afm3Gga5VIi6TWWQEAnWOUmSsrv25J/+
         xrhAm2moBSNhFykIzc92TjaBY/YjZT2GlHNyKrcJ/ZVObsHBiTIhOtMbJ7S7uYC02DSF
         GBk32w4Kp1gcwO3/wg99B2ETWz6ie5iEbG/9/f+fiHhykg4PhfupuE5joj8MrWNKUu6u
         2YNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697454735; x=1698059535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnIrmXxUURiIeSQAirrpqB7bVt8GpjLnuUlE7YD5p24=;
        b=gV9kYCDMefXfISQnOesX3Famf9uUdPE/Gi/++XkJLn/J/tZw/TV0dwObCH4akRM0Ul
         iK3yf0QOi3Si0+7oIztNnwYT0HQlww54ouFYy4rXd4Cn/8M+/lgd5LrDs19agc8e90q5
         3OSa1zxyLo153yuKvgOEIikxUVLkDn5jaxHfHOL5tkvkyN0+y8/Rcg5gv8+Sf9JV699P
         Zv8etibIKTyb3mauBQn0MGR6J6id0r4QaeAokjoX8iqq6dhhXMWOR6Nn5P+4RY5nMr5F
         gGJ2M/fEbFKkrjHgT9wQHL7ayU1CZYvZ9fbG089jJrmWz0AgwoDiSeOKYefEt9aPumbo
         btUA==
X-Gm-Message-State: AOJu0Yx+0HotbvwMQFpn1LfD7lkJgCOr44sRRSPbIbFOlHSyG+iu3SdX
	xFxbG2RgHTa/+DEl42V8zshB6HNNVVCVuHKzCnO0gQ==
X-Google-Smtp-Source: AGHT+IFiQPqCekOD9xRqRNzBiQO4tMiCAju5oqVq9Ao3ep6aen4OftyM+3ToH13eBp2swwVCm9vH0nndYA6YSge2LEA=
X-Received: by 2002:a05:6512:2095:b0:501:a2b9:6046 with SMTP id
 t21-20020a056512209500b00501a2b96046mr97698lfr.7.1697454734638; Mon, 16 Oct
 2023 04:12:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCjhiqtTBYNfgVHtOashJZuArY3mz2=938ip=5i4u_7wd85A@mail.gmail.com>
 <CANn89iJkOsrxGaAwhaJxd7xoH6cnSah+nV8rQ1X19U7H8NSkiw@mail.gmail.com> <CAAvCjhhxBHL63O4s4ufhU7-rptJgX1LM7zEDGeQ9zGP+9Am2kA@mail.gmail.com>
In-Reply-To: <CAAvCjhhxBHL63O4s4ufhU7-rptJgX1LM7zEDGeQ9zGP+9Am2kA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Oct 2023 13:12:00 +0200
Message-ID: <CANn89iLGEFBMP=90cqdThj-0yJOA9UkUfQK9jMdU6vG8Q3O_6A@mail.gmail.com>
Subject: Re: kernel BUG at net/ipv4/tcp_output.c:2642 with kernel 5.19.0-rc2
 and newer
To: Dmitry Kravkov <dmitryk@qwilt.com>
Cc: netdev@vger.kernel.org, "Slava (Ice) Sheremet" <slavas@qwilt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 10:20=E2=80=AFPM Dmitry Kravkov <dmitryk@qwilt.com>=
 wrote:
>
> On Wed, Oct 11, 2023 at 5:02=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Oct 11, 2023 at 12:28=E2=80=AFPM Dmitry Kravkov <dmitryk@qwilt.=
com> wrote:
> > >
> > > Hi,
> > >
> > > In our try to upgrade from 5.10 to 6.1 kernel we noticed stable crash
> > > in kernel that bisected to this commit:
> > >
> > > commit 849b425cd091e1804af964b771761cfbefbafb43
> > > Author: Eric Dumazet <edumazet@google.com>
> > > Date:   Tue Jun 14 10:17:34 2022 -0700
> > >
> > >     tcp: fix possible freeze in tx path under memory pressure
> > >
> > >     Blamed commit only dealt with applications issuing small writes.
> > >
> > >     Issue here is that we allow to force memory schedule for the sk_b=
uff
> > >     allocation, but we have no guarantee that sendmsg() is able to
> > >     copy some payload in it.
> > >
> > >     In this patch, I make sure the socket can use up to tcp_wmem[0] b=
ytes.
> > >
> > >     For example, if we consider tcp_wmem[0] =3D 4096 (default on x86)=
,
> > >     and initial skb->truesize being 1280, tcp_sendmsg() is able to
> > >     copy up to 2816 bytes under memory pressure.
> > >
> > >     Before this patch a sendmsg() sending more than 2816 bytes
> > >     would either block forever (if persistent memory pressure),
> > >     or return -EAGAIN.
> > >
> > >     For bigger MTU networks, it is advised to increase tcp_wmem[0]
> > >     to avoid sending too small packets.
> > >
> > >     v2: deal with zero copy paths.
> > >
> > >     Fixes: 8e4d980ac215 ("tcp: fix behavior for epoll edge trigger")
> > >     Signed-off-by: Eric Dumazet <edumazet@google.com>
> > >     Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
> > >     Reviewed-by: Wei Wang <weiwan@google.com>
> > >     Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > >     Signed-off-by: David S. Miller <davem@davemloft.net>
> > >
> > > This happens in a pretty stressful situation when two 100Gb (E810 or
> > > ConnectX6) ports transmit above 150Gbps that most of the data is read
> > > from disks. So it appears that the system is constantly in a memory
> > > deficit. Apparently reverting the patch in 6.1.38 kernel eliminates
> > > the crash and system appears stable at delivering 180Gbps
> > >
> > > [ 2445.532318] ------------[ cut here ]------------
> > > [ 2445.532323] kernel BUG at net/ipv4/tcp_output.c:2642!
> > > [ 2445.532334] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > > [ 2445.550934] CPU: 61 PID: 109767 Comm: nginx Tainted: G S         O=
E
> > >     5.19.0-rc2+ #21
> > > [ 2445.560127] ------------[ cut here ]------------
> > > [ 2445.560565] Hardware name: Cisco Systems Inc
> > > UCSC-C220-M6N/UCSC-C220-M6N, BIOS C220M6.4.2.1g.0.1121212157
> > > 11/21/2021
> > > [ 2445.560571] RIP: 0010:tcp_write_xmit+0x70b/0x830
> > > [ 2445.561221] kernel BUG at net/ipv4/tcp_output.c:2642!
> > > [ 2445.561821] Code: 84 0b fc ff ff 0f b7 43 32 41 39 c6 0f 84 fe fb
> > > ff ff 8b 43 70 41 39 c6 0f 82 ff 00 00 00 c7 43 30 01 00 00 00 e9 e6
> > > fb ff ff <0f> 0b 8b 74 24 20 8b 85 dc 05 00 00 44 89 ea 01 c8 2b 43 2=
8
> > > 41 39
> > > [ 2445.561828] RSP: 0000:ffffc110ed647dc0 EFLAGS: 00010246
> > > [ 2445.561832] RAX: 0000000000000000 RBX: ffff9fe1f8081a00 RCX: 00000=
000000005a8
> > > [ 2445.561833] RDX: 000000000000043a RSI: 000002389172f8f4 RDI: 00000=
0000000febf
> > > [ 2445.561835] RBP: ffff9fe5f864e900 R08: 0000000000000000 R09: 00000=
00000000100
> > > [ 2445.561836] R10: ffffffff9be060d0 R11: 000000000000000e R12: ffff9=
fe5f864e901
> > > [ 2445.561837] R13: 0000000000000001 R14: 00000000000005a8 R15: 00000=
00000000000
> > > [ 2445.561839] FS:  00007f342530c840(0000) GS:ffff9ffa7f940000(0000)
> > > knlGS:0000000000000000
> > > [ 2445.561842] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [ 2445.561844] CR2: 00007f20ca4ed830 CR3: 00000045d976e005 CR4: 00000=
00000770ee0
> > > [ 2445.561846] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
> > > [ 2445.561847] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000=
00000000400
> > > [ 2445.561849] PKRU: 55555554
> > > [ 2445.561853] Call Trace:
> > > [ 2445.561858]  <TASK>
> > > [ 2445.564202] ------------[ cut here ]------------
> > > [ 2445.568007]  ? tcp_tasklet_func+0x120/0x120
> > > [ 2445.569107] kernel BUG at net/ipv4/tcp_output.c:2642!
> > > [ 2445.569608]  tcp_tsq_handler+0x7c/0xa0
> > > [ 2445.569627]  tcp_pace_kick+0x19/0x60
> > > [ 2445.569632]  __run_hrtimer+0x5c/0x1d0
> > > [ 2445.572264] ------------[ cut here ]------------
> > > [ 2445.574287] ------------[ cut here ]------------
> > > [ 2445.574292] kernel BUG at net/ipv4/tcp_output.c:2642!
> > > [ 2445.582581]  __hrtimer_run_queues+0x7d/0xe0
> > > --
> > > --
> > >
> > > --
> > > --
> > >
> > > Dmitry Kravkov     Software  Engineer
> > > Qwilt | Mobile: +972-54-4839923 | dmitryk@qwilt.com
> >
> > Hi Dmitry, thanks for the report.
> >
> > Can you post content of /proc/sys/net/ipv4/tcp_wmem and
> > /proc/sys/net/ipv4/tcp_rmem ?
> Thank you, Eric
>
> # cat /proc/sys/net/ipv4/tcp_wmem
> 786432 1048576 6291456

Hmm. This does look strange to me.

tcp_rmem[0] is supposed to be small.




> # cat /proc/sys/net/ipv4/tcp_rmem
> 4096 87380 6291456
>
> >
> > Are you using memcg ?
> No
> >
> > Can you try the following patch ?
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 3f66cdeef7decb5b5d2b84212c623781b8ce63db..d74b197e02e94aa2f032f2c=
3971969e604abc7de
> > 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1286,6 +1286,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct
> > msghdr *msg, size_t size)
> >                 continue;
> >
> >  wait_for_space:
> > +               tcp_remove_empty_skb(sk);
> >                 set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> >                 if (copied)
> >                         tcp_push(sk, flags & ~MSG_MORE, mss_now,
>
>
> The patched kernel crashed in the same manner:
> [ 2214.154278] kernel BUG at net/ipv4/tcp_output.c:2642!
>
>
>
> --
> --
>
> Dmitry Kravkov     Software  Engineer
> Qwilt | Mobile: +972-54-4839923 | dmitryk@qwilt.com

