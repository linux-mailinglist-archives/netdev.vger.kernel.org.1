Return-Path: <netdev+bounces-54969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062FC8090CD
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0FEA1F21361
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8504F5E8;
	Thu,  7 Dec 2023 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AWneQOO4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494F41709
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 10:55:24 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c2db0ca48so7325e9.1
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 10:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701975323; x=1702580123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DT2Q3Gbd2Tbm8pkdOaTKpKTAjtIXkR3EBHGiya7A+QM=;
        b=AWneQOO4+mxmgWaIsiyly+yiQDn9/aF+FcRdlPG7uYn2ts6sop4AOZeZQHQamk9Vg3
         kpcau5HU5qDYt6wXVJykiu9e6fGX8rf720r8iUAq4w+HI8ZW4Tc+k//fce5KlHJXG2dR
         oLPdnSyMq0LUuj72h0UzgfPn9cGM1xHsie57jQ/uXedpn20SmtnLkNzI0ZosiY45r4KD
         IjtBjk4mqcyKWdvHG0hG/eLAgmXshS76h9gnHUizBTI03A7Fz9QbRNfj3hMXSLbVCpdw
         F3EzA9gXBkI0K7QRdeXHhGUNU3+QgD85HeY4Z289lDt6RSKazbU1K68QW06LlUSYdiMQ
         7aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701975323; x=1702580123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DT2Q3Gbd2Tbm8pkdOaTKpKTAjtIXkR3EBHGiya7A+QM=;
        b=UpUf1yQQINRoIEWbfjm/zz6EhNKPqWUKwVVrdH+EJqtD81fdy1ZxpGoJLmw1w/cAiE
         CP7ZscfldBhh5AoQYc2wVZXr5vcGtgGfkPXX7cRHxqyQtr0iNyQBJLBx/LixsebAWhyi
         9TwsLR9RexjtbtnV8MFEw9qej5FH1mLJWxhPzPTJiOFJBMNlAHkt3kHCVHId3+DdVK1C
         rJov7FAaIdvvvfb0NIRJCe+0OnIseImHByHQLmekB1Yui5/OsZRZcWp0yO+G3luPZG1Z
         8hwFwn27L/YMrQMgpvoCZypbD5scKhXzStWQaXR2aCfNCnyhBz7evMS3jPeqnW24C5J0
         gZDQ==
X-Gm-Message-State: AOJu0Yz9IANp9qK1k92IEo7MxvrcGEbDv8zAF7WhWvSzlzyloJZ6PwXy
	88lb2bQc8RG9tsNGDwJzlY2Ph5lNamgmYHjwDfSwNW4qHGDSR3LkCip9iA==
X-Google-Smtp-Source: AGHT+IHDjyFU4dujdsLnYS3GAJWE644rujuR+l1Kc/1yVZc2Fpn9y0TQeLVEiGSv0KS4R6MWZUIudtl77Fv919GZr90=
X-Received: by 2002:a1c:7913:0:b0:40c:329:d498 with SMTP id
 l19-20020a1c7913000000b0040c0329d498mr1481wme.1.1701975322433; Thu, 07 Dec
 2023 10:55:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205173250.2982846-1-edumazet@google.com> <170191862445.7525.14404095197034927243.git-patchwork-notify@kernel.org>
 <CANn89iKcFxJ68+M8UvHzqp1k-FDiZHZ8ujP79WJd1338DVJy6w@mail.gmail.com>
 <c4ca9c7d-12fa-4205-84e2-c1001242fc0d@gmail.com> <CANn89iKpM33oQ+2dwoLHzZvECAjwiKJTR3cDM64nE6VvZA99Sg@mail.gmail.com>
 <2ba1bbde-0e80-4b73-be2b-7ce27c784089@gmail.com> <CANn89i+2NJ4sp8iGQHG9wKakRD+uzvo7juqAFpE4CdRbg8F6gQ@mail.gmail.com>
 <ca59f955-dc6f-49d8-ae32-fb2d0f7e7522@gmail.com>
In-Reply-To: <ca59f955-dc6f-49d8-ae32-fb2d0f7e7522@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Dec 2023 19:55:08 +0100
Message-ID: <CANn89i+zM7t=BYrqwTgEnhAWMHa8+JHVhokkFkdDTBWQPOYCXg@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: add debug checks in fib6_info_release()
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, Kui-Feng Lee <thinker.li@gmail.com>, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 7:46=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> w=
rote:
>
>
>
> On 12/7/23 10:22, Eric Dumazet wrote:
> > On Thu, Dec 7, 2023 at 7:19=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.co=
m> wrote:
> >>
> >>
> >>
> >> On 12/7/23 10:10, Eric Dumazet wrote:
> >>> On Thu, Dec 7, 2023 at 7:06=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.=
com> wrote:
> >>>
> >>>> Do you happen to have a test program that can reproduce it?
> >>>
> >>> syzbot has a repro, let me release the bug.
> >>>
> >>> Of course syzbot bisection points to my last patch.
> >>
> >> I just looked into the code.
> >> The origin issue mentioned at the thread head should be something
> >> related to a GC change I made. But, the warnings you added doesn't
> >> catch the the error correctly.  According to your stacktrace
> >>
> >>
> >>   > ip6_route_add+0x26/0x1f0 net/ipv6/route.c:3843
> >>   > ipv6_route_ioctl+0x3ff/0x590 net/ipv6/route.c:4467
> >>   > inet6_ioctl+0x265/0x2b0 net/ipv6/af_inet6.c:575
> >>   > sock_do_ioctl+0x113/0x270 net/socket.c:1220
> >>   > sock_ioctl+0x22e/0x6b0 net/socket.c:1339
> >>   > vfs_ioctl fs/ioctl.c:51 [inline]
> >>   > __do_sys_ioctl fs/ioctl.c:871 [inline]
> >>   > __se_sys_ioctl fs/ioctl.c:857 [inline]
> >>   > __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
> >>   > do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> >>   > do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
> >>   > entry_SYSCALL_64_after_hwframe+0x63/0x6b
> >>
> >> and warning messages you provided
> >>
> >>   > WARNING: CPU: 0 PID: 5059 at include/net/ip6_fib.h:332
> >>   > fib6_info_release include/net/ip6_fib.h:332 [inline]
> >>   > WARNING: CPU: 0 PID: 5059 at include/net/ip6_fib.h:332
> >>   > ip6_route_info_create+0x1a1a/0x1f10 net/ipv6/route.c:3829
> >>
> >> It takes place in ip6_route_info_create() to do error handling.
> >> It can be fib6_has_expires() in fib6_info_release() in this case.
> >
> > Feel free to amend the patch, but the issue is that we insert a fib
> > gc_link to a list,
> > then free the fi6 object without removing it first from the external li=
st.
> >
> > I added two different warnings, and removing one or both will still
> > keep the bug.
>
> The gc_link is not inserted here actually. (see my explanation in
> another message.)
>
> According to the messages in the thread head, it is an issue of dangling
> pointer, right? If I read it correctly, the original issue is gc_link
> pointing to a block of memory that is already free. Am I right?

Original issue is about gc_link corruption, or use-after-free

Perhaps fib6_has_expires()  should really be rewritten to use
hlist_unhashed(&f6i->gc_link)

Setting RTF_EXPIRES on f6i->fib6_flags seems redundant/risky in light
of all the syzbot reports I had lately...

