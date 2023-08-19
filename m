Return-Path: <netdev+bounces-29039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D13F7816F7
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 05:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDAB281E61
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 03:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C97A1100;
	Sat, 19 Aug 2023 03:13:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8034D63C
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 03:13:26 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D257420E
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 20:13:25 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-407db3e9669so92191cf.1
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 20:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692414804; x=1693019604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7CAyoPtZ5IPvRO19x1z/WIHrqKvsvHvoeH1BiEhZ38=;
        b=zdtjEgN/YUKfW6+/rM2ckA6FcHFIIIL94txK1pnmiXc4LDLgWQ0Yk1idQ4BhQMkpsy
         dkl+JMx3u7QoKRy6oQAzXctnwOQ4OaPxF7uiRBp64u6rsMX6LgjrZfyX2+/osGMLFPKB
         zFjZclubhqeeQMJYpdWtmFAND3Q9MShVK3kkSBVDJYCujl1pxb7nDtFg9mlNcXDE+PIS
         NaslTh9JHS9Ik69nOGLFIhmmRmTBvsK3JSHDHPjaoOdMLr0KdUfyg6dh59pKFGatF78j
         KrW4kA1bc1YMc4QH3yQFHS2G9CzCO9a1o459+JJdyeFHgk8a5tAFr/xW4tmO8DQ+r5RA
         90ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692414804; x=1693019604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7CAyoPtZ5IPvRO19x1z/WIHrqKvsvHvoeH1BiEhZ38=;
        b=RE98BhOXJeEStUoBl0Kzpk2hlBlXuyCZ99DL0b/HYeBsD++d44hZ0ihdsGUNH83Df7
         M04wlsXTJN49VZFKPXlMxQ55wohKpH4X44bd8Yk2aSz67+maCmFisPVNf838UqgiryIs
         2xAWNyqMNHYTSmKAtUjzNUxRjDDc6gqGAEF4p/DxThW2B/CL4eIHnkvs3QED2MGszxsM
         DfsIkPOsH2AmPW8p3tNPxX4T9Hf6Snozfgmfv+Wrg0s+tmxKNduHXfoITUawmEZaY9IF
         BiDuhCuR2Um0Xf52oHpQIMG+3onPjvN8xM9OEmhSFHfRfrDCfSocLNoZlBgjSrTbWa5y
         iKlg==
X-Gm-Message-State: AOJu0Yz2lE079ErI+vOJfpitxgmnq8W5XXuwXlXvDhUKLP2vornghjrL
	+QSdXTa+pqjyJiRpu+fA7MGjer6mpd2Z/xcBstPL0g==
X-Google-Smtp-Source: AGHT+IGxD4JsrzrsAQ8lp04m91SBtz2Tyd0DrHFhW3NFFEcYuadJsGP0IcwG5gUXcl3E1ieUoVeuje55ewr+887kehc=
X-Received: by 2002:a05:622a:1041:b0:3f6:97b4:1a4d with SMTP id
 f1-20020a05622a104100b003f697b41a4dmr319810qte.23.1692414804070; Fri, 18 Aug
 2023 20:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230818104031.3890323-1-edumazet@google.com> <c2b1d4da-6b99-3fed-e24b-b695f54f9723@kernel.org>
In-Reply-To: <c2b1d4da-6b99-3fed-e24b-b695f54f9723@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 19 Aug 2023 05:13:12 +0200
Message-ID: <CANn89iLv+zCrP28NKi9fpS7JELTQvAf=c-w1OCb6jA6mVQiKJA@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: fix data-races around inet->inet_id
To: David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 19, 2023 at 3:19=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 8/18/23 4:40 AM, Eric Dumazet wrote:
> > UDP sendmsg() is lockless, so ip_select_ident_segs()
> > can very well be run from multiple cpus [1]
> >
> > Convert inet->inet_id to an atomic_t, but implement
> > a dedicated path for TCP, avoiding cost of a locked
> > instruction (atomic_add_return())
> >
> > Note that this patch will cause a trivial merge conflict
> > because we added inet->flags in net-next tree.
> >
> > [1]
> >
> > BUG: KCSAN: data-race in __ip_make_skb / __ip_make_skb
> >
> > read-write to 0xffff888145af952a of 2 bytes by task 7803 on cpu 1:
> > ip_select_ident_segs include/net/ip.h:542 [inline]
> > ip_select_ident include/net/ip.h:556 [inline]
> > __ip_make_skb+0x844/0xc70 net/ipv4/ip_output.c:1446
> > ip_make_skb+0x233/0x2c0 net/ipv4/ip_output.c:1560
> > udp_sendmsg+0x1199/0x1250 net/ipv4/udp.c:1260
> > inet_sendmsg+0x63/0x80 net/ipv4/af_inet.c:830
> > sock_sendmsg_nosec net/socket.c:725 [inline]
> > sock_sendmsg net/socket.c:748 [inline]
> > ____sys_sendmsg+0x37c/0x4d0 net/socket.c:2494
> > ___sys_sendmsg net/socket.c:2548 [inline]
> > __sys_sendmmsg+0x269/0x500 net/socket.c:2634
> > __do_sys_sendmmsg net/socket.c:2663 [inline]
> > __se_sys_sendmmsg net/socket.c:2660 [inline]
> > __x64_sys_sendmmsg+0x57/0x60 net/socket.c:2660
> > do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> > entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > read to 0xffff888145af952a of 2 bytes by task 7804 on cpu 0:
> > ip_select_ident_segs include/net/ip.h:541 [inline]
> > ip_select_ident include/net/ip.h:556 [inline]
> > __ip_make_skb+0x817/0xc70 net/ipv4/ip_output.c:1446
> > ip_make_skb+0x233/0x2c0 net/ipv4/ip_output.c:1560
> > udp_sendmsg+0x1199/0x1250 net/ipv4/udp.c:1260
> > inet_sendmsg+0x63/0x80 net/ipv4/af_inet.c:830
> > sock_sendmsg_nosec net/socket.c:725 [inline]
> > sock_sendmsg net/socket.c:748 [inline]
> > ____sys_sendmsg+0x37c/0x4d0 net/socket.c:2494
> > ___sys_sendmsg net/socket.c:2548 [inline]
> > __sys_sendmmsg+0x269/0x500 net/socket.c:2634
> > __do_sys_sendmmsg net/socket.c:2663 [inline]
> > __se_sys_sendmmsg net/socket.c:2660 [inline]
> > __x64_sys_sendmmsg+0x57/0x60 net/socket.c:2660
> > do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> > entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > value changed: 0x184d -> 0x184e
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 0 PID: 7804 Comm: syz-executor.1 Not tainted 6.5.0-rc6-syzkaller #=
0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 07/26/2023
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Fixes: 23f57406b82d ("ipv4: avoid using shared IP generator for connect=
ed sockets")
> > Reported-by: syzbot <syzkaller@googlegroups.com>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/net/inet_sock.h |  2 +-
> >  include/net/ip.h        | 15 +++++++++++++--
> >  net/dccp/ipv4.c         |  4 ++--
> >  net/ipv4/af_inet.c      |  2 +-
> >  net/ipv4/datagram.c     |  2 +-
> >  net/ipv4/tcp_ipv4.c     |  4 ++--
> >  net/sctp/socket.c       |  2 +-
> >  7 files changed, 21 insertions(+), 10 deletions(-)
> >
>
> drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c also
> references inet_id.

Oh well, I really wonder how we accepted such a big mess of layering violat=
ions.

I will send a v2, thanks !

