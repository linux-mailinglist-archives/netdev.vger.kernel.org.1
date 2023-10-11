Return-Path: <netdev+bounces-40142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4C27C5EF7
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00645282240
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 21:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4C21D54A;
	Wed, 11 Oct 2023 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qwilt.com header.i=@qwilt.com header.b="SB7euOnY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADD512E5E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 21:20:13 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912469E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:20:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-504a7f9204eso420616e87.3
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qwilt.com; s=google; t=1697059210; x=1697664010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laHBVcJ03lkNmnTaqYvkEd51XljrSETaLsEKsasYUcY=;
        b=SB7euOnYT8pHoh7Hh78G8waOioL5CpBwbMbSHgWpnGzu+63YandRN00tDcZDMJaaY/
         cnHJyCFcVDrtSoBT/VGwc2uNbt9ZXeIirYIXS4qQth8PUdnK8U3+bNpmsOWXtn0x4Gb4
         sIUoJP/dSVwb3cQINcsfi4b2u3LOZAcM+FgezIdR6nUoytw2gqFxppoTb8v5d+ArqGwb
         /hey17FZqcoyYmaBiW8RG9G3cTS6Tz9LxL6d4blBB7g9Ef2ewLu/QNkUuNabLfXWk8yV
         5k96h6Z15B/DomPYg3J7FQCnUDOVGxhKDpfVunGEhKC+GEsHLp093NhEKfm9Th5KepUy
         Y9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697059210; x=1697664010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laHBVcJ03lkNmnTaqYvkEd51XljrSETaLsEKsasYUcY=;
        b=JSFmEIRABxkbuagzgtB9GxEVa2N4Nsg+/oONif9iwOkW0Wpx6n3EeIJFlsYnbWjRCP
         vyLQ9AGut3US/f0hkT6K5XU41HOGioaLnFTHLfVSzBEvBsnCNj12g9izJvqXK7/gwJiA
         bMGZU373pBpUTms90ZauSvnOP/o6ZxTktf5mgSf30bozT0txnT3nWeH/kGLmKTLpQuhC
         XUyCO08aJChpm5HvaOrVzSnxR63ScRiMDEBATcfkbcFnoIYFKpHauxXHinV0rc4zaIVi
         jTkCcPFtKdmO3vJgVXd8TM6Y2oaRlhJsaZtZULQCbPAPCEkYQEf+glhYU2Bu9hxFe6++
         JJEA==
X-Gm-Message-State: AOJu0YyOm1QO40OvhEHH2Ekm6uKfdSvlnVYjHatwMDk/jfRSWNkan23A
	CvbtgqzGezdAKCHFFfDgkEiY8Bn6WLa32MMqtvFXpw==
X-Google-Smtp-Source: AGHT+IGGiXQvu6MsXlrtv3PIcfBV5NudamdvDYaaHQXY1JxQgumr6OYMVEw4YGX42CJc2sx4Op/qQ6rFeJXo7FPWkEM=
X-Received: by 2002:a05:6512:68a:b0:505:73e7:b478 with SMTP id
 t10-20020a056512068a00b0050573e7b478mr23491313lfe.16.1697059209711; Wed, 11
 Oct 2023 14:20:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCjhhxBHL63O4s4ufhU7-rptJgX1LM7zEDGeQ9zGP+9Am2kA@mail.gmail.com>
 <20231011205428.81550-1-kuniyu@amazon.com>
In-Reply-To: <20231011205428.81550-1-kuniyu@amazon.com>
From: Dmitry Kravkov <dmitryk@qwilt.com>
Date: Thu, 12 Oct 2023 00:19:58 +0300
Message-ID: <CAAvCjhhEPd4MHNT9x5h_gpyphp3jB9MAnzbCDogiuRVGcqtdkQ@mail.gmail.com>
Subject: Re: kernel BUG at net/ipv4/tcp_output.c:2642 with kernel 5.19.0-rc2
 and newer
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: edumazet@google.com, netdev@vger.kernel.org, slavas@qwilt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 11:54=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Dmitry Kravkov <dmitryk@qwilt.com>
> Date: Wed, 11 Oct 2023 23:20:10 +0300
> > On Wed, Oct 11, 2023 at 5:02=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Wed, Oct 11, 2023 at 12:28=E2=80=AFPM Dmitry Kravkov <dmitryk@qwil=
t.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > In our try to upgrade from 5.10 to 6.1 kernel we noticed stable cra=
sh
> > > > in kernel that bisected to this commit:
> > > >
> > > > commit 849b425cd091e1804af964b771761cfbefbafb43
> > > > Author: Eric Dumazet <edumazet@google.com>
> > > > Date:   Tue Jun 14 10:17:34 2022 -0700
> > > >
> > > >     tcp: fix possible freeze in tx path under memory pressure
> > > >
> > > >     Blamed commit only dealt with applications issuing small writes=
.
> > > >
> > > >     Issue here is that we allow to force memory schedule for the sk=
_buff
> > > >     allocation, but we have no guarantee that sendmsg() is able to
> > > >     copy some payload in it.
> > > >
> > > >     In this patch, I make sure the socket can use up to tcp_wmem[0]=
 bytes.
> > > >
> > > >     For example, if we consider tcp_wmem[0] =3D 4096 (default on x8=
6),
> > > >     and initial skb->truesize being 1280, tcp_sendmsg() is able to
> > > >     copy up to 2816 bytes under memory pressure.
> > > >
> > > >     Before this patch a sendmsg() sending more than 2816 bytes
> > > >     would either block forever (if persistent memory pressure),
> > > >     or return -EAGAIN.
> > > >
> > > >     For bigger MTU networks, it is advised to increase tcp_wmem[0]
> > > >     to avoid sending too small packets.
> > > >
> > > >     v2: deal with zero copy paths.
> > > >
> > > >     Fixes: 8e4d980ac215 ("tcp: fix behavior for epoll edge trigger"=
)
> > > >     Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > >     Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
> > > >     Reviewed-by: Wei Wang <weiwan@google.com>
> > > >     Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > > >     Signed-off-by: David S. Miller <davem@davemloft.net>
> > > >
> > > > This happens in a pretty stressful situation when two 100Gb (E810 o=
r
> > > > ConnectX6) ports transmit above 150Gbps that most of the data is re=
ad
> > > > from disks. So it appears that the system is constantly in a memory
> > > > deficit. Apparently reverting the patch in 6.1.38 kernel eliminates
> > > > the crash and system appears stable at delivering 180Gbps
> > > >
> > > > [ 2445.532318] ------------[ cut here ]------------
> > > > [ 2445.532323] kernel BUG at net/ipv4/tcp_output.c:2642!
> > > > [ 2445.532334] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > > > [ 2445.550934] CPU: 61 PID: 109767 Comm: nginx Tainted: G S        =
 OE
>
> It seems 3rd party module is loaded.
>
> Just curious if it is possible to reproduce the issue without
> out-of-tree modules.
Not sure if ice driver is mature enough there. We will give it a try. Thank=
s
>
>
> > > >     5.19.0-rc2+ #21
> > > > [ 2445.560127] ------------[ cut here ]------------
> > > > [ 2445.560565] Hardware name: Cisco Systems Inc
> > > > UCSC-C220-M6N/UCSC-C220-M6N, BIOS C220M6.4.2.1g.0.1121212157
> > > > 11/21/2021
> > > > [ 2445.560571] RIP: 0010:tcp_write_xmit+0x70b/0x830
> > > > [ 2445.561221] kernel BUG at net/ipv4/tcp_output.c:2642!
> > > > [ 2445.561821] Code: 84 0b fc ff ff 0f b7 43 32 41 39 c6 0f 84 fe f=
b
> > > > ff ff 8b 43 70 41 39 c6 0f 82 ff 00 00 00 c7 43 30 01 00 00 00 e9 e=
6
> > > > fb ff ff <0f> 0b 8b 74 24 20 8b 85 dc 05 00 00 44 89 ea 01 c8 2b 43=
 28
> > > > 41 39
> > > > [ 2445.561828] RSP: 0000:ffffc110ed647dc0 EFLAGS: 00010246
> > > > [ 2445.561832] RAX: 0000000000000000 RBX: ffff9fe1f8081a00 RCX: 000=
00000000005a8
> > > > [ 2445.561833] RDX: 000000000000043a RSI: 000002389172f8f4 RDI: 000=
000000000febf
> > > > [ 2445.561835] RBP: ffff9fe5f864e900 R08: 0000000000000000 R09: 000=
0000000000100
> > > > [ 2445.561836] R10: ffffffff9be060d0 R11: 000000000000000e R12: fff=
f9fe5f864e901
> > > > [ 2445.561837] R13: 0000000000000001 R14: 00000000000005a8 R15: 000=
0000000000000
> > > > [ 2445.561839] FS:  00007f342530c840(0000) GS:ffff9ffa7f940000(0000=
)
> > > > knlGS:0000000000000000
> > > > [ 2445.561842] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [ 2445.561844] CR2: 00007f20ca4ed830 CR3: 00000045d976e005 CR4: 000=
0000000770ee0
> > > > [ 2445.561846] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
> > > > [ 2445.561847] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
> > > > [ 2445.561849] PKRU: 55555554
> > > > [ 2445.561853] Call Trace:
> > > > [ 2445.561858]  <TASK>
> > > > [ 2445.564202] ------------[ cut here ]------------
> > > > [ 2445.568007]  ? tcp_tasklet_func+0x120/0x120
> > > > [ 2445.569107] kernel BUG at net/ipv4/tcp_output.c:2642!
> > > > [ 2445.569608]  tcp_tsq_handler+0x7c/0xa0
> > > > [ 2445.569627]  tcp_pace_kick+0x19/0x60
> > > > [ 2445.569632]  __run_hrtimer+0x5c/0x1d0
> > > > [ 2445.572264] ------------[ cut here ]------------
> > > > [ 2445.574287] ------------[ cut here ]------------
> > > > [ 2445.574292] kernel BUG at net/ipv4/tcp_output.c:2642!
> > > > [ 2445.582581]  __hrtimer_run_queues+0x7d/0xe0
> > > > --
> > > > --
> > > >
> > > > --
> > > > --
> > > >
> > > > Dmitry Kravkov     Software  Engineer
> > > > Qwilt | Mobile: +972-54-4839923 | dmitryk@qwilt.com
> > >
> > > Hi Dmitry, thanks for the report.
> > >
> > > Can you post content of /proc/sys/net/ipv4/tcp_wmem and
> > > /proc/sys/net/ipv4/tcp_rmem ?
> > Thank you, Eric
> >
> > # cat /proc/sys/net/ipv4/tcp_wmem
> > 786432 1048576 6291456
> > # cat /proc/sys/net/ipv4/tcp_rmem
> > 4096 87380 6291456
> >
> > >
> > > Are you using memcg ?
> > No
> > >
> > > Can you try the following patch ?
> > >
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index 3f66cdeef7decb5b5d2b84212c623781b8ce63db..d74b197e02e94aa2f032f=
2c3971969e604abc7de
> > > 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -1286,6 +1286,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct
> > > msghdr *msg, size_t size)
> > >                 continue;
> > >
> > >  wait_for_space:
> > > +               tcp_remove_empty_skb(sk);
> > >                 set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> > >                 if (copied)
> > >                         tcp_push(sk, flags & ~MSG_MORE, mss_now,
> >
> >
> > The patched kernel crashed in the same manner:
> > [ 2214.154278] kernel BUG at net/ipv4/tcp_output.c:2642!
>


--=20
--

Dmitry Kravkov     Software  Engineer
Qwilt | Mobile: +972-54-4839923 | dmitryk@qwilt.com

