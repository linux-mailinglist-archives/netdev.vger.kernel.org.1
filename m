Return-Path: <netdev+bounces-54974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656838090FF
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 20:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9333D1C20852
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF8A4EB2A;
	Thu,  7 Dec 2023 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fXQZSJ1F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E406122
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 11:06:12 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso1225a12.1
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 11:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701975971; x=1702580771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0mP7s6tcoQsOMf3Qz0t8GiXPVWesd84UnoGwdnbK8E=;
        b=fXQZSJ1F6GD5UJdxBMecFbqkIV2pBY57RycBxLKrJ1qguneOeiu5pFR4ncepxwkagu
         f9XvXNaAG2qh0RQbTI6HbAPWdUAMewWDE6D44bKE/hkPUHwmxwRj0uWJ+HG7yzEBcSXN
         6yxURWsa/07YHca2LskoPJtBpBw7wTu0okeLZpHENs66+4U/eqDiv43thu+McL0foo8j
         io+wJeCb5jhhrsDs50j6x3ktpUbr2E87QeYJpFO3q4xpNnDwXZQ6WSIuw41Um0LZZeJT
         w42gcpkI05weBT7rPHwQvUAnIQCZmOgZfcACxv1rOTW0/j11MfMSB8wsfbO/rdZKkqEP
         NjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701975971; x=1702580771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0mP7s6tcoQsOMf3Qz0t8GiXPVWesd84UnoGwdnbK8E=;
        b=Gc4KIgj0KpdQwRP3jIuOgonYrcgo3UiM2jpp0BuNDfS3kCW5CjdsNlEwGPZbF5fY2w
         5i/QhsmgyQ6tfR3HJrsKtEW8LRDSGciM1ENQL4+ZTHrVxZGbvpzlKck+Oal93r21fsEp
         eXaKSGot86Sp2P54SoEpCJuRnMzQBiIMhF05DR7/kUmE7nHM6/u879kDGwNLJ/hFojRo
         kUxSsYBBsNH2JFFAk1QMssoDo33mGYvMADvXTs4Wn+m6zbpHfLBUl+gUM582HBbIxVNw
         Ji5z3csD9+O+woWrLHc1diPmnSLcwTiIx70fQ1+hZsHcgRvoQ060uwXw3pAFZFFk7rVg
         qivg==
X-Gm-Message-State: AOJu0Yzxtro4UeG4W8zxMwMJFxM85XrYHErZebc2E207BAevQkZFYZuU
	qnPs1w1k5sl6RcMMmeSFJhcSxU8yts29x3SFQrR/bA==
X-Google-Smtp-Source: AGHT+IHVlMvBAxTi/xfsJiHBwqIgcdriEh7gfu6MCD/rivViJ6Ovzc65Z/1AcD9A19grLwSa3ZudSSJO/CfMwViWS3E=
X-Received: by 2002:a50:d7dc:0:b0:54c:9996:7833 with SMTP id
 m28-20020a50d7dc000000b0054c99967833mr1894edj.7.1701975970772; Thu, 07 Dec
 2023 11:06:10 -0800 (PST)
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
 <590c27ae-c583-4404-ace7-ea68548d07a2@kernel.org> <d7ffcd2b-55b0-4084-a18d-49596df8b494@gmail.com>
 <3b432fa3-8cfc-4d50-8363-848cbe775621@gmail.com> <d973fd6a-4fd0-4578-a784-00ed7fd1c927@gmail.com>
In-Reply-To: <d973fd6a-4fd0-4578-a784-00ed7fd1c927@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Dec 2023 20:05:56 +0100
Message-ID: <CANn89iJo6i67tf=k8_KHYNFXy1DyPoOZKLB2NbyY4xqmp_qWgw@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: add debug checks in fib6_info_release()
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, patchwork-bot+netdevbpf@kernel.org, 
	Kui-Feng Lee <thinker.li@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 8:00=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> w=
rote:
>
>
>
> On 12/7/23 10:40, Kui-Feng Lee wrote:
> >
> >
> > On 12/7/23 10:36, Kui-Feng Lee wrote:
> >>
> >>
> >> On 12/7/23 10:25, David Ahern wrote:
> >>> On 12/7/23 11:22 AM, Eric Dumazet wrote:
> >>>> Feel free to amend the patch, but the issue is that we insert a fib
> >>>> gc_link to a list, then free the fi6 object without removing it firs=
t
> >>>> from the external list.
> >>>
> >>> yes, move the insert down:
> >>>
> >>> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> >>> index b132feae3393..7257ba0e72b7 100644
> >>> --- a/net/ipv6/route.c
> >>> +++ b/net/ipv6/route.c
> >>> @@ -3762,12 +3762,6 @@ static struct fib6_info
> >>> *ip6_route_info_create(struct fib6_config *cfg,
> >>>          if (cfg->fc_flags & RTF_ADDRCONF)
> >>>                  rt->dst_nocount =3D true;
> >>>
> >>> -       if (cfg->fc_flags & RTF_EXPIRES)
> >>> -               fib6_set_expires_locked(rt, jiffies +
> >>> -
> >>> clock_t_to_jiffies(cfg->fc_expires));
> >>> -       else
> >>> -               fib6_clean_expires_locked(rt);
> >>> -
> >>
> >> fib6_set_expires_locked() here actually doesn't insert a fib gc_link
> >> since rt->fib6_table is not assigned yet.  The gc_link will
> >> be inserted by fib6_add() being called later.
> >>
> >>
> >>>          if (cfg->fc_protocol =3D=3D RTPROT_UNSPEC)
> >>>                  cfg->fc_protocol =3D RTPROT_BOOT;
> >>>          rt->fib6_protocol =3D cfg->fc_protocol;
> >>> @@ -3824,6 +3818,12 @@ static struct fib6_info
> >>> *ip6_route_info_create(struct fib6_config *cfg,
> >>>          } else
> >>>                  rt->fib6_prefsrc.plen =3D 0;
> >>>
> >>> +
> >>> +       if (cfg->fc_flags & RTF_EXPIRES)
> >>> +               fib6_set_expires_locked(rt, jiffies +
> >>> +
> >>> clock_t_to_jiffies(cfg->fc_expires));
> >>> +       else
> >>> +               fib6_clean_expires_locked(rt);
> >>>          return rt;
> >>>   out:
> >>>          fib6_info_release(rt);
> >>
> >> However, this should fix the warning messages.
> > Just realize this cause inserting the gc_link twice.  fib6_add()
> > will try to add it again!
>
> I made a minor change to the patch that fix warning messages
> provided by David Ahern. Will send an official patch later.
>
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -3762,17 +3762,10 @@ static struct fib6_info
> *ip6_route_info_create(struct fib6_config *cfg,
>          if (cfg->fc_flags & RTF_ADDRCONF)
>                  rt->dst_nocount =3D true;
>
> -       if (cfg->fc_flags & RTF_EXPIRES)
> -               fib6_set_expires_locked(rt, jiffies +
> -
> clock_t_to_jiffies(cfg->fc_expires));
> -       else
> -               fib6_clean_expires_locked(rt);
> -
>          if (cfg->fc_protocol =3D=3D RTPROT_UNSPEC)
>                  cfg->fc_protocol =3D RTPROT_BOOT;
>          rt->fib6_protocol =3D cfg->fc_protocol;
>
> -       rt->fib6_table =3D table;
>          rt->fib6_metric =3D cfg->fc_metric;
>          rt->fib6_type =3D cfg->fc_type ? : RTN_UNICAST;
>          rt->fib6_flags =3D cfg->fc_flags & ~RTF_GATEWAY;
> @@ -3824,6 +3817,17 @@ static struct fib6_info
> *ip6_route_info_create(struct fib6_config *cfg,
>          } else
>                  rt->fib6_prefsrc.plen =3D 0;
>
> +       if (cfg->fc_flags & RTF_EXPIRES)
> +               fib6_set_expires_locked(rt, jiffies +
> +
> clock_t_to_jiffies(cfg->fc_expires));
> +       else
> +               fib6_clean_expires_locked(rt);

Note that I do not see why we call fib6_clean_expires_locked() on a
freshly allocated object.

f6i->expires should already be zero...

> +       /* Set fib6_table after fib6_set_expires_locked() to ensure the
> +        * gc_link is not inserted until fib6_add() is called to insert t=
he
> +        * fib6_info to the fib.
> +        */
> +       rt->fib6_table =3D table;
> +
>          return rt;
>   out:

