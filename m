Return-Path: <netdev+bounces-50073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A797F4853
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032A91C20A35
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E75A4E60E;
	Wed, 22 Nov 2023 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RpN4yL9n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43DA10C4
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 05:53:16 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso10930a12.1
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 05:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700661195; x=1701265995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj6oyOdW2Xvm1QufVJ+uIJ0FzpSWaZsFrtXO58tNbSU=;
        b=RpN4yL9n1g7rpT0iz3jn/B1bCzvhVT5GdU0EF4ivLIwa0NR4TlASrA/SRJ0V7usziC
         WAwufqETpXpZM2SVy5lt9+qaTSFCc++9HuOPmiWddWHC9TAVSJdxnMogaScLrYqOGjyo
         qs3u1KGxRSANk5eT08+NJKXDo6qanF5NcQmNiAJPIhE+bNPkkZUkAv2ZdG3P0LCtEzch
         6PopVdZqZjoTCSBLBy3rInrbVp/pcBLIJKp33mim6nHbF0Go1MBXj2xQJDVpUx8NnluP
         fNulPz+Jqk2paNco0U/L2mKNoV8eJdR7pLHgkTH5bitj1kx+J+KZes5bL5hxzkb6BGl9
         A+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700661195; x=1701265995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gj6oyOdW2Xvm1QufVJ+uIJ0FzpSWaZsFrtXO58tNbSU=;
        b=YEvGqph0hHWD0iYW5s3b7bnt0yZOfHYPR8h6CMw4PuXnE/0o1TT/3VOsZPG1yky7ph
         kQfPLZeIrTDmoy8IFQ3axK8BecyhH+LBQO/baPNIt1iMR40+Q5/FUvRzleS792wGsYqa
         o3TL5uOlsaHsUd4B91dU24sqQ8SQHyWY084TDzlUHGFTwKpIRBZkuzeHvYA9LLJaBknJ
         HKcroVF5LB/bKYaQLBLkPJeIeK+Nr8auP7IMXwEcr9rfIj2ewUKG9p3Q8YjfjpLzkK57
         17YXrV5gHZBakKFN1vXgIe57zm+PTd/nWWgtIK7COQsshgyEhAA8e0sjL7iPo8OfB7HB
         eolQ==
X-Gm-Message-State: AOJu0YwTqqbZxZPDpzjBMQmtCtdfyRRPvr09Hta13pxOnuVXjnecOA1j
	LBvcxp7IwQlbrERN6r/DuGVdHTKYoLS1K41rpNulFw==
X-Google-Smtp-Source: AGHT+IGlghtudxqV9qbV3LYvCA/cnj3P7s6YIQ8VB0zWLEGo+mKPxXz7fwsLwoptVjn3JbOyqJrhUb11BEZEdGUTpYE=
X-Received: by 2002:a05:6402:35ca:b0:544:24a8:ebd with SMTP id
 z10-20020a05640235ca00b0054424a80ebdmr172913edc.4.1700661194342; Wed, 22 Nov
 2023 05:53:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122034420.1158898-1-kuba@kernel.org> <20231122034420.1158898-13-kuba@kernel.org>
In-Reply-To: <20231122034420.1158898-13-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Nov 2023 14:53:00 +0100
Message-ID: <CANn89i+6HOE8rs5S3OemjrY9yKGkUb0ZMcs3+npGCLNSFROoUg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 12/13] net: page_pool: mute the periodic
 warning for visible page pools
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	almasrymina@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 4:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Mute the periodic "stalled pool shutdown" warning if the page pool
> is visible to user space. Rolling out a driver using page pools
> to just a few hundred hosts at Meta surfaces applications which
> fail to reap their broken sockets. Obviously it's best if the
> applications are fixed, but we don't generally print warnings
> for application resource leaks. Admins can now depend on the
> netlink interface for getting page pool info to detect buggy
> apps.
>
> While at it throw in the ID of the pool into the message,
> in rare cases (pools from destroyed netns) this will make
> finding the pool with a debugger easier.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/page_pool.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 3d0938a60646..c2e7c9a6efbe 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -897,18 +897,21 @@ static void page_pool_release_retry(struct work_str=
uct *wq)
>  {
>         struct delayed_work *dwq =3D to_delayed_work(wq);
>         struct page_pool *pool =3D container_of(dwq, typeof(*pool), relea=
se_dw);
> +       void *netdev;
>         int inflight;
>
>         inflight =3D page_pool_release(pool);
>         if (!inflight)
>                 return;
>
> -       /* Periodic warning */
> -       if (time_after_eq(jiffies, pool->defer_warn)) {
> +       /* Periodic warning for page pools the user can't see */
> +       netdev =3D READ_ONCE(pool->slow.netdev);
> +       if (time_after_eq(jiffies, pool->defer_warn) &&
> +           (!netdev || netdev =3D=3D NET_PTR_POISON)) {
>                 int sec =3D (s32)((u32)jiffies - (u32)pool->defer_start) =
/ HZ;

Orthogonal to your patch, but this probably could avoid all these casts.

long sec =3D (jiffies - pool->defer_start) / HZ;


>
> -               pr_warn("%s() stalled pool shutdown %d inflight %d sec\n"=
,
> -                       __func__, inflight, sec);
> +               pr_warn("%s() stalled pool shutdown: id %u, %d inflight %=
d sec\n",
> +                       __func__, pool->user.id, inflight, sec);
>                 pool->defer_warn =3D jiffies + DEFER_WARN_INTERVAL;
>         }
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

