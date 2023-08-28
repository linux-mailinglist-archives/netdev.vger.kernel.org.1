Return-Path: <netdev+bounces-31031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B893C78AEA8
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 13:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3BC1C208A8
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 11:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE9011C95;
	Mon, 28 Aug 2023 11:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C486116
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 11:20:22 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BAAB6
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 04:20:20 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-407db3e9669so309501cf.1
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 04:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693221619; x=1693826419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwW/TSjEyRyiNqhvcuXddtH4aylyB5VmtJFu661Coe8=;
        b=FKle6Wyq3VAqlGv2cy0mbAiAV26TZHd5uXvQauPYyXHx2DIobATJcVSDj3fTSBv3Tp
         OkqmQoA/bdDM4VSLDz0Tcfygo4tdeEzWQ037tXIcPtb7aLRPiUj40Ycwwh0TU9nTssdD
         duphZGEs8IYK7ylSF6xSe2P6Ua63nI5pKf2KQ09PUcwVZrrVUrQ3IvgJKbgd1Um3lnim
         UFvBvAZE76d0GA0WJHXGFYAZ+i162RWjBQygK+2tK/8o7/fRtzrTEem9wstZyZSqvVVb
         uCnqy93Cwljgxl5WBctgNfQ5nfQmGck0/XZsv8caU7g2JdNxILMe2ahLct65JIwdSJ8d
         sXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693221619; x=1693826419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwW/TSjEyRyiNqhvcuXddtH4aylyB5VmtJFu661Coe8=;
        b=XJOyRx7zzSnuXvue/pfwbY6sO1k+MDPdPaApt+kce1EsEDWd21IOcS1QPIW7AUaR8H
         IoNu6i6Ld+rJ08EMIKet+2+HDLyMm+HMu/tZzBIMxIdGNbbjXqXaAn504UEEfyrR/B/i
         m5GOG2ta1ILrAddiNv0mo0L6N3T9ZN3tzf/h/kU4uaeqQ1CQR25Z46N6++Gmgwocrsb9
         VMIv0vLhljQoj+2i2zU43tjlNVrhiJYhLfv0CJ8D9ymOOQnoJXjOKtSncc1SQHjNg3Iw
         Lxl9cONevN8ocPZAfZuvz4ECcVHS88rrjacCAbNU/+b67mZDbt6XE1Pzs97Z2fm7msPy
         Z6GA==
X-Gm-Message-State: AOJu0YzuFoCzomW3M5N0Upm6yjMnj1vmjnKBMtODprne62X840z+uWBc
	h1LKwa5WLvQuiGT1Tbo/jk9X5mt4oTwxEb9upnVVdw==
X-Google-Smtp-Source: AGHT+IEzJXugHM4KtxnzgzUdK1fi8jEo/us1BddRtKOnf3g9Mxs7iR0g5SGMi3t5aUgnK5NGskmed1qLgJfvPYdw3Do=
X-Received: by 2002:a05:622a:198f:b0:3f8:8c06:c53b with SMTP id
 u15-20020a05622a198f00b003f88c06c53bmr371039qtc.0.1693221619513; Mon, 28 Aug
 2023 04:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230808135809.2300241-1-edumazet@google.com> <bdf7db1a44ab0ee46fc621329ef9bc61734a723a.camel@redhat.com>
In-Reply-To: <bdf7db1a44ab0ee46fc621329ef9bc61734a723a.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 28 Aug 2023 13:20:08 +0200
Message-ID: <CANn89iJSjug5+UaLMQ0QLa49nFRnO6a_x7pCJUQggnmfezj62g@mail.gmail.com>
Subject: Re: [PATCH net-next] net: annotate data-races around sock->ops
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 28, 2023 at 12:17=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> Hi,
>
> On Tue, 2023-08-08 at 13:58 +0000, Eric Dumazet wrote:
> > IPV6_ADDRFORM socket option is evil, because it can change sock->ops
> > while other threads might read it. Same issue for sk->sk_family
> > being set to AF_INET.
> >
> > Adding READ_ONCE() over sock->ops reads is needed for sockets
> > that might be impacted by IPV6_ADDRFORM.
> >
> > Note that mptcp_is_tcpsk() can also overwrite sock->ops.
> >
> > Adding annotations for all sk->sk_family reads will require
> > more patches :/
>
> I was unable to give the above a proper look before due to OoO on my
> side.
>
> The mptcp code calls mptcp_is_tcpsk() only before the fd for the newly
> accepted socket is installed, so we should not have concurrent racing
> access to sock->ops?!? Do you have any related splat handy?
>

syzbot splat was on another layer. I tried to fix all sites that could
trigger a similar issue.

BUG: KCSAN: data-race in ____sys_sendmsg / do_ipv6_setsockopt

write to 0xffff888109f24ca0 of 8 bytes by task 4470 on cpu 0:
do_ipv6_setsockopt+0x2c5e/0x2ce0 net/ipv6/ipv6_sockglue.c:491
ipv6_setsockopt+0x57/0x130 net/ipv6/ipv6_sockglue.c:1012
udpv6_setsockopt+0x95/0xa0 net/ipv6/udp.c:1690
sock_common_setsockopt+0x61/0x70 net/core/sock.c:3663
__sys_setsockopt+0x1c3/0x230 net/socket.c:2273
__do_sys_setsockopt net/socket.c:2284 [inline]
__se_sys_setsockopt net/socket.c:2281 [inline]
__x64_sys_setsockopt+0x66/0x80 net/socket.c:2281
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff888109f24ca0 of 8 bytes by task 4469 on cpu 1:
sock_sendmsg_nosec net/socket.c:724 [inline]
sock_sendmsg net/socket.c:747 [inline]
____sys_sendmsg+0x349/0x4c0 net/socket.c:2503
___sys_sendmsg net/socket.c:2557 [inline]
__sys_sendmmsg+0x263/0x500 net/socket.c:2643
__do_sys_sendmmsg net/socket.c:2672 [inline]
__se_sys_sendmmsg net/socket.c:2669 [inline]
__x64_sys_sendmmsg+0x57/0x60 net/socket.c:2669
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0xffffffff850e32b8 -> 0xffffffff850da890

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 4469 Comm: syz-executor.1 Not tainted
6.4.0-rc5-syzkaller-00313-g4c605260bc60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 05/25/2023

Maybe MPTCP side (mptcp_is_tcpsk()) was ok,
but  the fact that mptcp_is_tcpsk() was able to write over sock->ops
was a bit strange to me.

mptcp_is_tcpsk() should answer a question, with a read-only argument.

I suggest changing the name of the helper to better reflect what it is doin=
g.

