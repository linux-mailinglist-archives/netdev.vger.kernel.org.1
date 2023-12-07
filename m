Return-Path: <netdev+bounces-54949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C743E808FC3
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801AD2815A5
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EAB4D597;
	Thu,  7 Dec 2023 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WMuS8aXL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD80610E3
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 10:22:37 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54c79cca895so746a12.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 10:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701973356; x=1702578156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehp5mKCqkXfgq/MWm4+TiE5cFUAxsTGXywmS6IVYaiE=;
        b=WMuS8aXL4AqtIvgBZqEKnh61gW3FZnvq3epV53s2dTwDWbRDEqa/GxAvhLKP9/dPQA
         LOk6C83AWyjmEiPkhRCCpFbG4wbvlFBGYGsC/rTEsHif97pzmz84miRTP3IMkVGTP/nH
         Kittl1ui/7R9eiV3PSq16+kn/dXveFJCO0lMPa4iVHbXtXNM73E/XnLzc3kBX6dYqqvn
         bU397Un4rBhmRqocsZgQsebtWtylyWoPivtShxMbtNDw9e+s1ZM5j7efhS22wVhFqfrB
         C2DERaaehvIB0VeNS5kNmz3dO7dSzBwDf2Eyj/Ajp4/bXgy47deHy97xvB2tVDVKlaqz
         n05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701973356; x=1702578156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehp5mKCqkXfgq/MWm4+TiE5cFUAxsTGXywmS6IVYaiE=;
        b=SL2K8biM/W5Bs+X9gVJT5pTeABcI6gbKp7TCX7coVKrMpwwN7nuzfUnfJ30kD6yBT0
         9b3BP6eIGxoaZegyt0H+W0EkZDldRVhtdQQQMAzd4XySL6kQh3kxbkSn2ladzCePc8YP
         o7Cf/MNcGQoYqQer4OfAuto1nZA6lPPrIrUmoelPHiLfb43leYeXJ8mGvmLu4tdybPAF
         4bQM7GQpsZIff1wFVHYPqg0F5lalJ8ZBXyP7+KpyGQThURMSTDOIyqR0rXqGhnkBrl04
         zPEb7GLlRWHKczR1D3gnXTreX6aef2VVqqpuStZYUqgX2mszK8lnG3jQ8XcAcHxqTO/b
         YyBw==
X-Gm-Message-State: AOJu0Yztd57qqNEh4DaKfh4Wwa3QHv7EUtzJe8LoFG766Xq8LLbEqqay
	GCODDzxt8NuCOx7Cqtauu0Kq2hd7DuSZL9D6cHS/iQ==
X-Google-Smtp-Source: AGHT+IFwlr1AujX3V5UcCFRuJzd4vdIwk2Ab4SLwZPeV1uUctiyPw1fU2dJhBL0dssZA5v+EKc5k3ZsaVZGfXv09YBk=
X-Received: by 2002:a50:ccc6:0:b0:54a:ee8b:7a99 with SMTP id
 b6-20020a50ccc6000000b0054aee8b7a99mr167edj.0.1701973356060; Thu, 07 Dec 2023
 10:22:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205173250.2982846-1-edumazet@google.com> <170191862445.7525.14404095197034927243.git-patchwork-notify@kernel.org>
 <CANn89iKcFxJ68+M8UvHzqp1k-FDiZHZ8ujP79WJd1338DVJy6w@mail.gmail.com>
 <c4ca9c7d-12fa-4205-84e2-c1001242fc0d@gmail.com> <CANn89iKpM33oQ+2dwoLHzZvECAjwiKJTR3cDM64nE6VvZA99Sg@mail.gmail.com>
 <2ba1bbde-0e80-4b73-be2b-7ce27c784089@gmail.com>
In-Reply-To: <2ba1bbde-0e80-4b73-be2b-7ce27c784089@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Dec 2023 19:22:25 +0100
Message-ID: <CANn89i+2NJ4sp8iGQHG9wKakRD+uzvo7juqAFpE4CdRbg8F6gQ@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: add debug checks in fib6_info_release()
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, Kui-Feng Lee <thinker.li@gmail.com>, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 7:19=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> w=
rote:
>
>
>
> On 12/7/23 10:10, Eric Dumazet wrote:
> > On Thu, Dec 7, 2023 at 7:06=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.co=
m> wrote:
> >
> >> Do you happen to have a test program that can reproduce it?
> >
> > syzbot has a repro, let me release the bug.
> >
> > Of course syzbot bisection points to my last patch.
>
> I just looked into the code.
> The origin issue mentioned at the thread head should be something
> related to a GC change I made. But, the warnings you added doesn't
> catch the the error correctly.  According to your stacktrace
>
>
>  > ip6_route_add+0x26/0x1f0 net/ipv6/route.c:3843
>  > ipv6_route_ioctl+0x3ff/0x590 net/ipv6/route.c:4467
>  > inet6_ioctl+0x265/0x2b0 net/ipv6/af_inet6.c:575
>  > sock_do_ioctl+0x113/0x270 net/socket.c:1220
>  > sock_ioctl+0x22e/0x6b0 net/socket.c:1339
>  > vfs_ioctl fs/ioctl.c:51 [inline]
>  > __do_sys_ioctl fs/ioctl.c:871 [inline]
>  > __se_sys_ioctl fs/ioctl.c:857 [inline]
>  > __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
>  > do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  > do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
>  > entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> and warning messages you provided
>
>  > WARNING: CPU: 0 PID: 5059 at include/net/ip6_fib.h:332
>  > fib6_info_release include/net/ip6_fib.h:332 [inline]
>  > WARNING: CPU: 0 PID: 5059 at include/net/ip6_fib.h:332
>  > ip6_route_info_create+0x1a1a/0x1f10 net/ipv6/route.c:3829
>
> It takes place in ip6_route_info_create() to do error handling.
> It can be fib6_has_expires() in fib6_info_release() in this case.

Feel free to amend the patch, but the issue is that we insert a fib
gc_link to a list,
then free the fi6 object without removing it first from the external list.

I added two different warnings, and removing one or both will still
keep the bug.

