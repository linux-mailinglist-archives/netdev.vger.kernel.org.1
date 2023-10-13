Return-Path: <netdev+bounces-40597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BF27C7CCF
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 06:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6F81F20610
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 04:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9055C110D;
	Fri, 13 Oct 2023 04:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdkAQknp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E201139A
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 04:42:45 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FFCBE
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:42:43 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-65b0e623189so9040756d6.1
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697172162; x=1697776962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eXZNYajYxhXTb3UBWzzLxXc/EdYltPYPSY96CeeHUM=;
        b=OdkAQknpRnfvGCH71xEU15qUCK5S/qt7qzkQVPYCnAj5HiNO+VHLW6KkEEb5KjwL5r
         MNjF3ZCuu86IoF6MRnTo2QYafHOqizxRZX2ScOj6ZvtQ4Nb2TdJ1gxZvmG51dYXU19Ma
         LeXdbqHlrelHWvYeAAE8UbDBXyK2HN4hRYhmcClPH9+c5zf8Q497Hzp9HRS/Bttm87ly
         5Sv3PskjIYsvMqPxjIN7aB4EGUcFrsibWoaz8F8kU5S5wCAMczXQVHHjvBXhOiKUnY52
         MxANoQKyu/PYLm86bGQutLBMjoibIYMNccntRjJEb3NGT6/uTZPS6+krrBorGrA5rfjw
         IGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697172162; x=1697776962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eXZNYajYxhXTb3UBWzzLxXc/EdYltPYPSY96CeeHUM=;
        b=wfvzuDetGWyuAx0/jqrgu59HKAeom5Obp2n8K07biYRtXsCU/HGX1FQIwjbhfB/EOG
         Meh15gq+OqNt1jeHcnF7IQeIqSWyn6jgh/a5uEOzDnEBuWnDh203tTxhCWXwcPivRoqt
         nxWI9+Tzieie5sQ/nIe5gEWQjNu0Z9nCNBTCf5DWtOjXt8ZIvwWQZgFqMoCkdR6fLJ4P
         MC1k1H7s6AALirwOY721b5Fj/67ZJ3rtSD8WgsXr2ELR6WeEfkekNg/ZaUfc2k62H0As
         7+TJ18zXAJnzTvh8ljm61CzYX2cy7U20AsW7iotTvzTSzvBMam7HgkGSkk1T4jxrxQ9r
         IyWw==
X-Gm-Message-State: AOJu0YyJValqsZV8Y5mz7zp0EuysofmLd4zmhn0cQcOR2lmXZJrbumzq
	ZUEzfQoJYm/iQpN+H6uLG6SZmH0j+lI8Jvicag==
X-Google-Smtp-Source: AGHT+IE9PsZH1NhRmltNTrG8z6uPRtXN08y0szaTE+r0rr2NW5xbFQ7EibXW6brQBi4eyO0tZwCDZ15ktr1M3kNDWSw=
X-Received: by 2002:a0c:aa0c:0:b0:66c:faa7:c5f0 with SMTP id
 d12-20020a0caa0c000000b0066cfaa7c5f0mr7984319qvb.63.1697172162578; Thu, 12
 Oct 2023 21:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3b95e47e3dbed840960548aebaa8d954372db41.1697008693.git.pabeni@redhat.com>
 <CANn89iL_nbz9Cg1LP6c8amvvGbwBMFRxmtE_b6CF8WyLGt3MnA@mail.gmail.com>
In-Reply-To: <CANn89iL_nbz9Cg1LP6c8amvvGbwBMFRxmtE_b6CF8WyLGt3MnA@mail.gmail.com>
From: Xin Guo <guoxin0309@gmail.com>
Date: Fri, 13 Oct 2023 12:42:31 +0800
Message-ID: <CAMaK5_ii38_Ze2uBmcyX8rnntEi35kXJ47yhxZvCb-ks0bMbxw@mail.gmail.com>
Subject: Re: [PATCH v2 net] tcp: allow again tcp_disconnect() when threads are waiting
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Ayush Sawal <ayush.sawal@chelsio.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, mptcp@lists.linux.dev, 
	Boris Pismenny <borisp@nvidia.com>, Tom Deseyn <tdeseyn@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,
In my view, this patch is NOT so good, and it seems that trying to fix
a problem temporarily without knowing its root cause,
because sk_wait_event function should know nothing about the other
functions were called or not,
but now this patch added a logic to let sk_wait_event know the
specific tcp_dissconnect function was called by other threads or NOT,
honestly speaking, it is NOT a good designation,
so what is root cause about the problem which [0] commit want to fix?
can we have a way to fix it directly instead of denying
tcp_disconnect() when threads are waiting?
if No better way to fix it, please add some description about the
difficulty and our compromise in the commit message, otherwise the
patch will be confused.


[0]: 4faeee0cf8a5 ("tcp: deny tcp_disconnect() when threads are waiting")

On Wed, Oct 11, 2023 at 3:36=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Oct 11, 2023 at 9:21=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > As reported by Tom, .NET and applications build on top of it rely
> > on connect(AF_UNSPEC) to async cancel pending I/O operations on TCP
> > socket.
> >
> > The blamed commit below caused a regression, as such cancellation
> > can now fail.
> >
> > As suggested by Eric, this change addresses the problem explicitly
> > causing blocking I/O operation to terminate immediately (with an error)
> > when a concurrent disconnect() is executed.
> >
> > Instead of tracking the number of threads blocked on a given socket,
> > track the number of disconnect() issued on such socket. If such counter
> > changes after a blocking operation releasing and re-acquiring the socke=
t
> > lock, error out the current operation.
> >
> > Fixes: 4faeee0cf8a5 ("tcp: deny tcp_disconnect() when threads are waiti=
ng")
> > Reported-by: Tom Deseyn <tdeseyn@redhat.com>
> > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1886305
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
>
> Thanks !
>

