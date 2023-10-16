Return-Path: <netdev+bounces-41260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936F17CA64C
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47AB82814D8
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C6F2110E;
	Mon, 16 Oct 2023 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qwilt.com header.i=@qwilt.com header.b="EtsWwFR0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CA2210F4
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:10:30 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDCDAB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 04:10:28 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso58298591fa.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 04:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qwilt.com; s=google; t=1697454626; x=1698059426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtL1+aW8LhVip/6UvTCsFpfFZJkrcvT0X1r2ce5OAeM=;
        b=EtsWwFR0DryIhJvMnfw/iDyQNoCG3rMHUqJrMrfCmf9YaQbrJSsud6277EdICMFPL6
         jW6KFWVI9l28W3n+2M0aHQfYaJOK7uYVAw+GHnL8eAH+DZ2R7/uuG7TwSNp43las/obI
         obDSKoqlqc/2P2+jKnuAZYuD5m6eIenAJDCb0mdSbKK2Nb+uMDFT755QB+P3mlToq2HD
         7stD6Kblt0WphExCawa5d/JPlKSKnSh3VQwaeJi3poygHXUutxRCQAE8q5FUx/NT6M4g
         K0aLawbM8UOVu9e+jdCwakfm/SuRwnH5wL4izy2y7h2EO7OlQ+Y8sUjKlbY9+xuwpMZL
         x+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697454626; x=1698059426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtL1+aW8LhVip/6UvTCsFpfFZJkrcvT0X1r2ce5OAeM=;
        b=cS1gRa5EIyKAZ7WN87FxsyyLqBAy7kFnrvBUbbU8sLOmFuN7atrcmyE6t0PiKEbQD+
         n5bamksYzvWCFbtmxl0oR+ls2jI5cCAvEa+lV8pN4E2c7ys9erIMfqbraSUTNV2U5qkR
         c/Id0c9tJ+r6WCO1ziqVaLKPOxKNuXxm8MEgTbv95tgiQg4j+/ymksb9ESheY5RguCVv
         FCIn3+lp+MxUF/iBl7vmfWXFRvgToHhEH5iOPLXePnnXDcgM3TtFj0182F65X19eFFHJ
         UusLWiCAZdlqz3eOcKrOrcsW8YRoEpU58e37hkVA7ywkh34jPq603BkTyN1Gh+C2izLQ
         hMDA==
X-Gm-Message-State: AOJu0YxYVHi/1ShKoU0KRXuxn8y2OJ2zwOwjkRMMd5BSmw6wc7PUey7x
	Eks8VAhFSZezOJHHlhI0GAaqvQge84X+/NXgWG3TqQ==
X-Google-Smtp-Source: AGHT+IG970oy53W9GmJr4b+hpeJzyHKorWw17NPXaMdu8DKqphWqKDp0YeK21rYCd6+SAQJGUpaCXP4oLTraSOmuX2k=
X-Received: by 2002:a05:6512:33d0:b0:507:a1dd:5a86 with SMTP id
 d16-20020a05651233d000b00507a1dd5a86mr5145691lfg.13.1697454626170; Mon, 16
 Oct 2023 04:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCjhhxBHL63O4s4ufhU7-rptJgX1LM7zEDGeQ9zGP+9Am2kA@mail.gmail.com>
 <20231011205428.81550-1-kuniyu@amazon.com> <CAAvCjhhEPd4MHNT9x5h_gpyphp3jB9MAnzbCDogiuRVGcqtdkQ@mail.gmail.com>
 <CAAvCjhjOmDDbDCF9xAVifHEsQqJOFJ1whtzzKu-0+Um=Odm=NQ@mail.gmail.com>
In-Reply-To: <CAAvCjhjOmDDbDCF9xAVifHEsQqJOFJ1whtzzKu-0+Um=Odm=NQ@mail.gmail.com>
From: Dmitry Kravkov <dmitryk@qwilt.com>
Date: Mon, 16 Oct 2023 14:10:15 +0300
Message-ID: <CAAvCjhj+c14o1EN77gtU_EsPM3_TzY5riQ3zH=AmaU2pUjMoXQ@mail.gmail.com>
Subject: Re: kernel BUG at net/ipv4/tcp_output.c:2642 with kernel 5.19.0-rc2
 and newer
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: edumazet@google.com, netdev@vger.kernel.org, slavas@qwilt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 7:49=E2=80=AFPM Dmitry Kravkov <dmitryk@qwilt.com> =
wrote:
>
> On Thu, Oct 12, 2023 at 12:19=E2=80=AFAM Dmitry Kravkov <dmitryk@qwilt.co=
m> wrote:
> >
> > On Wed, Oct 11, 2023 at 11:54=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amaz=
on.com> wrote:
> > >
> > > From: Dmitry Kravkov <dmitryk@qwilt.com>
> > > Date: Wed, 11 Oct 2023 23:20:10 +0300
> > > > On Wed, Oct 11, 2023 at 5:02=E2=80=AFPM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > > >
> > > > > On Wed, Oct 11, 2023 at 12:28=E2=80=AFPM Dmitry Kravkov <dmitryk@=
qwilt.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > In our try to upgrade from 5.10 to 6.1 kernel we noticed stable=
 crash
> > > > > > in kernel that bisected to this commit:
> > > > > >
> > > > > > commit 849b425cd091e1804af964b771761cfbefbafb43
> > > > > > Author: Eric Dumazet <edumazet@google.com>
> > > > > > Date:   Tue Jun 14 10:17:34 2022 -0700
> > > > > >
> > > > > >     tcp: fix possible freeze in tx path under memory pressure
> > > > > >
> > > > > >     Blamed commit only dealt with applications issuing small wr=
ites.
> > > > > >
> > > > > >     Issue here is that we allow to force memory schedule for th=
e sk_buff
> > > > > >     allocation, but we have no guarantee that sendmsg() is able=
 to
> > > > > >     copy some payload in it.
> > > > > >
> > > > > >     In this patch, I make sure the socket can use up to tcp_wme=
m[0] bytes.
> > > > > >
> > > > > >     For example, if we consider tcp_wmem[0] =3D 4096 (default o=
n x86),
> > > > > >     and initial skb->truesize being 1280, tcp_sendmsg() is able=
 to
> > > > > >     copy up to 2816 bytes under memory pressure.
> > > > > >
> > > > > >     Before this patch a sendmsg() sending more than 2816 bytes
> > > > > >     would either block forever (if persistent memory pressure),
> > > > > >     or return -EAGAIN.
> > > > > >
> > > > > >     For bigger MTU networks, it is advised to increase tcp_wmem=
[0]
> > > > > >     to avoid sending too small packets.
> > > > > >
> > > > > >     v2: deal with zero copy paths.
> > > > > >
> > > > > >     Fixes: 8e4d980ac215 ("tcp: fix behavior for epoll edge trig=
ger")
> > > > > >     Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > >     Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
> > > > > >     Reviewed-by: Wei Wang <weiwan@google.com>
> > > > > >     Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > > > > >     Signed-off-by: David S. Miller <davem@davemloft.net>
> > > > > >
> > > > > > This happens in a pretty stressful situation when two 100Gb (E8=
10 or
> > > > > > ConnectX6) ports transmit above 150Gbps that most of the data i=
s read
> > > > > > from disks. So it appears that the system is constantly in a me=
mory
> > > > > > deficit. Apparently reverting the patch in 6.1.38 kernel elimin=
ates
> > > > > > the crash and system appears stable at delivering 180Gbps
> > > > > >
> > > > > > [ 2445.532318] ------------[ cut here ]------------
> > > > > > [ 2445.532323] kernel BUG at net/ipv4/tcp_output.c:2642!
> > > > > > [ 2445.532334] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > > > > > [ 2445.550934] CPU: 61 PID: 109767 Comm: nginx Tainted: G S    =
     OE
> > >
> > > It seems 3rd party module is loaded.
> > >
> > > Just curious if it is possible to reproduce the issue without
> > > out-of-tree modules.
> > Not sure if ice driver is mature enough there. We will give it a try. T=
hanks
>
> Happens on not-tained kernel too (we went for 6.1.38 to have more mature =
ice)
>
> [ 1057.099780] ------------[ cut here ]------------
> [ 1057.100389] RSP: 0018:ffffaa4e10093df0 EFLAGS: 00010286
> [ 1057.101060] kernel BUG at net/ipv4/tcp_output.c:2645!
> [ 1057.122021] RAX: 00000000ffff4000 RBX: ffff8ccad77e3540 RCX: 000000000=
0000000
> [ 1057.122025] RDX: 0000000000000000 RSI: 00000000ffff4000 RDI: ffff8ccad=
77e3540
> [ 1057.122027] RBP: ffff8ccad77e3480 R08: ffff8ccad77e35d4 R09: 000000008=
0400013
> [ 1057.122029] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8ccad=
77e3480
> [ 1057.122031] R13: 7fffffffffffff00 R14: ffff8ccad77e3698 R15: 000000000=
0000000
> [ 1057.122033] FS:  00007fd600d42840(0000) GS:ffff8ce1ffac0000(0000)
> knlGS:0000000000000000
> [ 1057.122035] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1057.122038] CR2: 00007fd57dacdc80 CR3: 00000041dda7a005 CR4: 000000000=
0770ee0
> [ 1057.122041] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [ 1057.122042] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [ 1057.122044] PKRU: 55555554
> [ 1057.122046] Call Trace:
> [ 1057.122880] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [ 1057.123683]  <TASK>
> [ 1057.124409] CPU: 112 PID: 51072 Comm: nginx Not tainted 6.1.38 #27
> [ 1057.125125]  ? show_trace_log_lvl+0x1c4/0x2df
> [ 1057.125812] Hardware name: Cisco Systems Inc
> UCSC-C220-M6N/UCSC-C220-M6N, BIOS C220M6.4.2.1g.0.1121212157
> 11/21/2021
> [ 1057.125815] RIP: 0010:tcp_write_xmit+0x70f/0x830
> [ 1057.126559]  ? show_trace_log_lvl+0x1c4/0x2df
>
>
>
> > >
> > >
> > > > > >     5.19.0-rc2+ #21
> > > > > > [ 2445.560127] ------------[ cut here ]------------
> > > > > > [ 2445.560565] Hardware name: Cisco Systems Inc
> > > > > > UCSC-C220-M6N/UCSC-C220-M6N, BIOS C220M6.4.2.1g.0.1121212157
> > > > > > 11/21/2021
> > > > > > [ 2445.560571] RIP: 0010:tcp_write_xmit+0x70b/0x830
> > > > > > [ 2445.561221] kernel BUG at net/ipv4/tcp_output.c:2642!
> > > > > > [ 2445.561821] Code: 84 0b fc ff ff 0f b7 43 32 41 39 c6 0f 84 =
fe fb
> > > > > > ff ff 8b 43 70 41 39 c6 0f 82 ff 00 00 00 c7 43 30 01 00 00 00 =
e9 e6
> > > > > > fb ff ff <0f> 0b 8b 74 24 20 8b 85 dc 05 00 00 44 89 ea 01 c8 2=
b 43 28
> > > > > > 41 39
> > > > > > [ 2445.561828] RSP: 0000:ffffc110ed647dc0 EFLAGS: 00010246
> > > > > > [ 2445.561832] RAX: 0000000000000000 RBX: ffff9fe1f8081a00 RCX:=
 00000000000005a8
> > > > > > [ 2445.561833] RDX: 000000000000043a RSI: 000002389172f8f4 RDI:=
 000000000000febf
> > > > > > [ 2445.561835] RBP: ffff9fe5f864e900 R08: 0000000000000000 R09:=
 0000000000000100
> > > > > > [ 2445.561836] R10: ffffffff9be060d0 R11: 000000000000000e R12:=
 ffff9fe5f864e901
> > > > > > [ 2445.561837] R13: 0000000000000001 R14: 00000000000005a8 R15:=
 0000000000000000
> > > > > > [ 2445.561839] FS:  00007f342530c840(0000) GS:ffff9ffa7f940000(=
0000)
> > > > > > knlGS:0000000000000000
> > > > > > [ 2445.561842] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> > > > > > [ 2445.561844] CR2: 00007f20ca4ed830 CR3: 00000045d976e005 CR4:=
 0000000000770ee0
> > > > > > [ 2445.561846] DR0: 0000000000000000 DR1: 0000000000000000 DR2:=
 0000000000000000
> > > > > > [ 2445.561847] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:=
 0000000000000400
> > > > > > [ 2445.561849] PKRU: 55555554
> > > > > > [ 2445.561853] Call Trace:
> > > > > > [ 2445.561858]  <TASK>
> > > > > > [ 2445.564202] ------------[ cut here ]------------
> > > > > > [ 2445.568007]  ? tcp_tasklet_func+0x120/0x120
> > > > > > [ 2445.569107] kernel BUG at net/ipv4/tcp_output.c:2642!
> > > > > > [ 2445.569608]  tcp_tsq_handler+0x7c/0xa0
> > > > > > [ 2445.569627]  tcp_pace_kick+0x19/0x60
> > > > > > [ 2445.569632]  __run_hrtimer+0x5c/0x1d0
> > > > > > [ 2445.572264] ------------[ cut here ]------------
> > > > > > [ 2445.574287] ------------[ cut here ]------------
> > > > > > [ 2445.574292] kernel BUG at net/ipv4/tcp_output.c:2642!
> > > > > > [ 2445.582581]  __hrtimer_run_queues+0x7d/0xe0
> > > > > > --
> > > > > > --
> > > > > >
> > > > > > --
> > > > > > --
> > > > > >
> > > > >
> > > > > Hi Dmitry, thanks for the report.
> > > > >
> > > > > Can you post content of /proc/sys/net/ipv4/tcp_wmem and
> > > > > /proc/sys/net/ipv4/tcp_rmem ?
> > > > Thank you, Eric
> > > >
> > > > # cat /proc/sys/net/ipv4/tcp_wmem
> > > > 786432 1048576 6291456
> > > > # cat /proc/sys/net/ipv4/tcp_rmem
> > > > 4096 87380 6291456
> > > >
> > > > >
> > > > > Are you using memcg ?
> > > > No
> > > > >
> > > > > Can you try the following patch ?
> > > > >
> > > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > > index 3f66cdeef7decb5b5d2b84212c623781b8ce63db..d74b197e02e94aa2f=
032f2c3971969e604abc7de
> > > > > 100644
> > > > > --- a/net/ipv4/tcp.c
> > > > > +++ b/net/ipv4/tcp.c
> > > > > @@ -1286,6 +1286,7 @@ int tcp_sendmsg_locked(struct sock *sk, str=
uct
> > > > > msghdr *msg, size_t size)
> > > > >                 continue;
> > > > >
> > > > >  wait_for_space:
> > > > > +               tcp_remove_empty_skb(sk);
> > > > >                 set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> > > > >                 if (copied)
> > > > >                         tcp_push(sk, flags & ~MSG_MORE, mss_now,
> > > >
> > > >
> > > > The patched kernel crashed in the same manner:
> > > > [ 2214.154278] kernel BUG at net/ipv4/tcp_output.c:2642!

Hi Eric, do you think we can try something to avoid the crash?
Decreasing tcp_wmem[0] did not help
# cat /proc/sys/net/ipv4/tcp_wmem
4096 1048576 629145

> > >
> >
> >
> > --
> > --

