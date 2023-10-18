Return-Path: <netdev+bounces-42145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B217CD5C4
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 09:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BBD7B207DB
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 07:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3610A11737;
	Wed, 18 Oct 2023 07:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B1NPJxhE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0E3883C
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 07:56:24 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DC6C6
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 00:56:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so6545a12.1
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 00:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697615781; x=1698220581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBRWisBhF25xsehN1OccU1T5oUQX3fcP87+AIk9GwnI=;
        b=B1NPJxhE+vYTPCh7lpwXMkogKpn2CSCVeaPKeKeLbRpN5+nk4zkoaShETheotcDg7Z
         S1wGVS75F4369T7W/nZEfgy1Nvxt6FEwk/L7kfINJ+qL/zHpTyTInW0QkQPHGCZwTdhO
         07l3eCL+UyR1bovkDvvrv97ku1uzATKZPyHT0ul3Gybg1+hLoStjpb9JNXtV6Mbaklmp
         uCdh4N44dZ9MoKtC+VyuBiIKxxszB406O1EV+obCHFXkvz2lCXOfrlM60RemrzpQTBAz
         XAHWIaFmkxIOumMHtTwbSuwIzqtDXKCk7LQF4M+E4DVkUWbuDOSGNH+ox0qFtsuKvWbv
         3Oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697615781; x=1698220581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBRWisBhF25xsehN1OccU1T5oUQX3fcP87+AIk9GwnI=;
        b=mtji29SN5HrLoBNUmYl+cwfczMbhy2sU3FD5cSvBJIioPbyowQVMyNdoDhihy8Qb5z
         czEsdRT6thrxbpExPLxUJYFYD/2qaWi1SiX6k/Ez/hCGB6qaU/PHhK2OM4Yf7yB0hPSa
         iZNcWJ//XSAJOUO8xwgpdz+8t1BErv/y5UhypW4/Maa74eOyltaLwJu/yS/NSS+7zZyY
         UbJEm9xz6nmN25E/9g7ggNicGE5CvPSVhuO7nep+dRYvmGV0q4Vf00hI6zEoWYmn+5iS
         aaoWvk7oTc8DzqQqAGNBbUXSDh7vYOvoU+O6iof7B8qjtU7gLikEa5HrQcwkzAeW5ZGy
         YpdA==
X-Gm-Message-State: AOJu0YzxD3ogJbjPZ2/MUDRRlyzV4rzhfp7djJL7+9fhZwczz+DfFf3m
	m8qtrZ/8JpIhkGife9qyWTI6y5BmTVCid02HSQ+a/w==
X-Google-Smtp-Source: AGHT+IGpPEQiWnhK6BfN+1mhzz0I+WPPPFMQkiWV8k1WjVthqWdX3ceYbf8JaYyq7f166y8ZUx38UOdzaM5lQ8hIK50=
X-Received: by 2002:a50:a6d9:0:b0:53e:7ad7:6d47 with SMTP id
 f25-20020a50a6d9000000b0053e7ad76d47mr72948edc.5.1697615780773; Wed, 18 Oct
 2023 00:56:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922034221.2471544-1-edumazet@google.com> <20230922034221.2471544-4-edumazet@google.com>
 <CC9C9B9C-6F03-4ABD-A180-95100737B2EE@icloud.com>
In-Reply-To: <CC9C9B9C-6F03-4ABD-A180-95100737B2EE@icloud.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 18 Oct 2023 09:56:06 +0200
Message-ID: <CANn89iKa2oJZZRW6mrRyO7-=aXjBr7wak2oZ3X74yLq3B_jcDQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/8] inet: implement lockless IP_TOS
To: Christoph Paasch <christophpaasch@icloud.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, netdev <netdev@vger.kernel.org>, 
	Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 5:37=E2=80=AFAM Christoph Paasch
<christophpaasch@icloud.com> wrote:
>
> Hello Eric,
>
> > On Sep 21, 2023, at 8:42=E2=80=AFPM, Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > Some reads of inet->tos are racy.
> >
> > Add needed READ_ONCE() annotations and convert IP_TOS option lockless.
> >
> > v2: missing changes in include/net/route.h (David Ahern)
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> > include/net/ip.h                              |  3 +-
> > include/net/route.h                           |  4 +--
> > net/dccp/ipv4.c                               |  2 +-
> > net/ipv4/inet_diag.c                          |  2 +-
> > net/ipv4/ip_output.c                          |  4 +--
> > net/ipv4/ip_sockglue.c                        | 29 ++++++++-----------
> > net/ipv4/tcp_ipv4.c                           |  9 +++---
> > net/mptcp/sockopt.c                           |  8 ++---
> > net/sctp/protocol.c                           |  4 +--
> > .../selftests/net/mptcp/mptcp_connect.sh      |  2 +-
> > 10 files changed, 31 insertions(+), 36 deletions(-)
>
> This patch causes a NULL-pointer deref in my syzkaller instances:
>
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 12bad6067 P4D 12bad6067 PUD 12bad5067 PMD 0
> Oops: 0000 [#1] PREEMPT SMP
> CPU: 1 PID: 2750 Comm: syz-executor.5 Not tainted 6.6.0-rc4-g7a5720a344e7=
 #49
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 =
04/01/2014
> RIP: 0010:tcp_get_metrics+0x118/0x8f0 net/ipv4/tcp_metrics.c:321
> Code: c7 44 24 70 02 00 8b 03 89 44 24 48 c7 44 24 4c 00 00 00 00 66 c7 4=
4 24 58 02 00 66 ba 02 00 b1 01 89 4c 24 04 4c 89 7c 24 10 <49> 8b 0f 48 8b=
 89 50 05 00 00 48 89 4c 24 30 33 81 00 02 00 00 69
> RSP: 0018:ffffc90000af79b8 EFLAGS: 00010293
> RAX: 000000000100007f RBX: ffff88812ae8f500 RCX: ffff88812b5f8f01
> RDX: 0000000000000002 RSI: ffffffff8300f080 RDI: 0000000000000002
> RBP: 0000000000000002 R08: 0000000000000003 R09: ffffffff8205eca0
> R10: 0000000000000002 R11: ffff88812b5f8f00 R12: ffff88812a9e0580
> R13: 0000000000000000 R14: ffff88812ae8fbd2 R15: 0000000000000000
> FS: 00007f70a006b640(0000) GS:ffff88813bd00000(0000) knlGS:00000000000000=
00
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000012bad7003 CR4: 0000000000170ee0
> Call Trace:
> <TASK>
> tcp_fastopen_cache_get+0x32/0x140 net/ipv4/tcp_metrics.c:567
> tcp_fastopen_cookie_check+0x28/0x180 net/ipv4/tcp_fastopen.c:419
> tcp_connect+0x9c8/0x12a0 net/ipv4/tcp_output.c:3839
> tcp_v4_connect+0x645/0x6e0 net/ipv4/tcp_ipv4.c:323
> __inet_stream_connect+0x120/0x590 net/ipv4/af_inet.c:676
> tcp_sendmsg_fastopen+0x2d6/0x3a0 net/ipv4/tcp.c:1021
> tcp_sendmsg_locked+0x1957/0x1b00 net/ipv4/tcp.c:1073
> tcp_sendmsg+0x30/0x50 net/ipv4/tcp.c:1336
> __sock_sendmsg+0x83/0xd0 net/socket.c:730
> __sys_sendto+0x20a/0x2a0 net/socket.c:2194
> __do_sys_sendto net/socket.c:2206 [inline]
> __se_sys_sendto net/socket.c:2202 [inline]
> __x64_sys_sendto+0x28/0x30 net/socket.c:2202
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x47/0xa0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>
> The reason is that setting IP_TOS calls sk_reset_dst, which then causes t=
hese issues in the places where we assume that the dst in the socket is set=
 (specifically, the tcp_connect-path).
>

Thanks for the report.

You are right, too many places calling __sk_dst_get() would have to
properly use RCU,
this does not seem worth the pain.

I will send a fix.

