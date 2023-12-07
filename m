Return-Path: <netdev+bounces-54978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6104E809117
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 20:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3DA21F20FD9
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1475E4F5E9;
	Thu,  7 Dec 2023 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nzB7uLr4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06F1A9
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 11:14:34 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so1545a12.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 11:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701976473; x=1702581273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcwuHJDz6rT+NIEd3PryDsp1eSD2KWnzOIpinVYI0j8=;
        b=nzB7uLr4S8sLfP1uYk53dLx6/QWmTx38QrrjVTdt+aswxdAajSzITWMPTRbhF0LBJY
         JodSufXOUNlqzsjEBznLKmJQNSSk24zjiEe2iDSCyODeDDEseD/XIoS4i+BlSGcKtIly
         oEqwuH2Aj/ft8XEyYXd7S0MagEdbGb6HHYYyU8EbageP6SJkIAGDTBK9FUwiFZC+YNQx
         Vqi/0bHmRiAbwPoypr97HebCDdwgdf72hRojHRUqYNDi/B96jciedFn4sP/kb1C6t2Ek
         3Zl7vMfSnBw6dKcZwHTxE3ZguyV4XXbPh/74+IZCSKfZOL+CTg23OZphmnjQpmH6gyYJ
         GztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701976473; x=1702581273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcwuHJDz6rT+NIEd3PryDsp1eSD2KWnzOIpinVYI0j8=;
        b=lroKtgMiGqvNauU7BYIpyVkGL8572ThIzhJ8h5jk3ccJbRtOVKNXwxbAOyc0GK68f0
         NUM0JPnszs48AOXYpgDCFHMgR1D9aHSZOXwPar8FdJfmvzZUs3/ADDgreG+OB6ol3CjP
         LMcG4bha+OsGP4L2M3Evde2JQ4BGYe11ZuWi8NPh/G124CfG7tdz0BMn/rYHzj+wKRVo
         opwSpBNgqggCrFwuZatsTyZpz5M68v/HzbStjrXAM8UQ9RhRYQQ2gP8KHWRGP1NZqPNV
         xfX0AQoRrpB1zYTrXAU6kybL2WBrO7avmHlH2sB0icZ3Jho221Osv8NFaKXzr98IM+5/
         QH+w==
X-Gm-Message-State: AOJu0YzObppuyWMk2DWKvfGSTUBszPE6IpW2kEzLmDWwno1VphypLYGa
	ysXc6SebciaaIjsS0Xlf92H8ZcvfaEQFIEQEzLQ0Aw==
X-Google-Smtp-Source: AGHT+IEa7uunpympljWBZWnz8n+BOWAI1jB2GqdBJ50DZSgEZLO74wttZBUFw9SECts2jEOfnGatMOjOXT00qVus6WM=
X-Received: by 2002:a50:9f6e:0:b0:54c:794b:875b with SMTP id
 b101-20020a509f6e000000b0054c794b875bmr3143edf.1.1701976472824; Thu, 07 Dec
 2023 11:14:32 -0800 (PST)
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
 <CANn89iJo6i67tf=k8_KHYNFXy1DyPoOZKLB2NbyY4xqmp_qWgw@mail.gmail.com> <dd9aefd4-b436-4ef7-8d1f-e966bccb2a14@gmail.com>
In-Reply-To: <dd9aefd4-b436-4ef7-8d1f-e966bccb2a14@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Dec 2023 20:14:21 +0100
Message-ID: <CANn89i+fo=SUqP01vNwNhZiDYo-vi5xst26V8JpYh8oJjSNr7Q@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: add debug checks in fib6_info_release()
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, patchwork-bot+netdevbpf@kernel.org, 
	Kui-Feng Lee <thinker.li@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 8:08=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> w=
rote:
>
>
>
> On 12/7/23 11:05, Eric Dumazet wrote:
> > On Thu, Dec 7, 2023 at 8:00=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.co=
m> wrote:
> >>
> >>
> >>
> >> On 12/7/23 10:40, Kui-Feng Lee wrote:
> >>>
> >>>
> >>> On 12/7/23 10:36, Kui-Feng Lee wrote:
> >>>>
> >>>>
> >>>> On 12/7/23 10:25, David Ahern wrote:
> >>>>> On 12/7/23 11:22 AM, Eric Dumazet wrote:
> >>>>>> Feel free to amend the patch, but the issue is that we insert a fi=
b
> >>>>>> gc_link to a list, then free the fi6 object without removing it fi=
rst
> >>>>>> from the external list.
> >>>>>
> >>>>> yes, move the insert down:
> >>>>>
> >>>>> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> >>>>> index b132feae3393..7257ba0e72b7 100644
> >>>>> --- a/net/ipv6/route.c
> >>>>> +++ b/net/ipv6/route.c
> >>>>> @@ -3762,12 +3762,6 @@ static struct fib6_info
> >>>>> *ip6_route_info_create(struct fib6_config *cfg,
> >>>>>           if (cfg->fc_flags & RTF_ADDRCONF)
> >>>>>                   rt->dst_nocount =3D true;
> >>>>>
> >>>>> -       if (cfg->fc_flags & RTF_EXPIRES)
> >>>>> -               fib6_set_expires_locked(rt, jiffies +
> >>>>> -
> >>>>> clock_t_to_jiffies(cfg->fc_expires));
> >>>>> -       else
> >>>>> -               fib6_clean_expires_locked(rt);
> >>>>> -
> >>>>
> >>>> fib6_set_expires_locked() here actually doesn't insert a fib gc_link
> >>>> since rt->fib6_table is not assigned yet.  The gc_link will
> >>>> be inserted by fib6_add() being called later.
> >>>>
> >>>>
> >>>>>           if (cfg->fc_protocol =3D=3D RTPROT_UNSPEC)
> >>>>>                   cfg->fc_protocol =3D RTPROT_BOOT;
> >>>>>           rt->fib6_protocol =3D cfg->fc_protocol;
> >>>>> @@ -3824,6 +3818,12 @@ static struct fib6_info
> >>>>> *ip6_route_info_create(struct fib6_config *cfg,
> >>>>>           } else
> >>>>>                   rt->fib6_prefsrc.plen =3D 0;
> >>>>>
> >>>>> +
> >>>>> +       if (cfg->fc_flags & RTF_EXPIRES)
> >>>>> +               fib6_set_expires_locked(rt, jiffies +
> >>>>> +
> >>>>> clock_t_to_jiffies(cfg->fc_expires));
> >>>>> +       else
> >>>>> +               fib6_clean_expires_locked(rt);
> >>>>>           return rt;
> >>>>>    out:
> >>>>>           fib6_info_release(rt);
> >>>>
> >>>> However, this should fix the warning messages.
> >>> Just realize this cause inserting the gc_link twice.  fib6_add()
> >>> will try to add it again!
> >>
> >> I made a minor change to the patch that fix warning messages
> >> provided by David Ahern. Will send an official patch later.
> >>
> >> --- a/net/ipv6/route.c
> >> +++ b/net/ipv6/route.c
> >> @@ -3762,17 +3762,10 @@ static struct fib6_info
> >> *ip6_route_info_create(struct fib6_config *cfg,
> >>           if (cfg->fc_flags & RTF_ADDRCONF)
> >>                   rt->dst_nocount =3D true;
> >>
> >> -       if (cfg->fc_flags & RTF_EXPIRES)
> >> -               fib6_set_expires_locked(rt, jiffies +
> >> -
> >> clock_t_to_jiffies(cfg->fc_expires));
> >> -       else
> >> -               fib6_clean_expires_locked(rt);
> >> -
> >>           if (cfg->fc_protocol =3D=3D RTPROT_UNSPEC)
> >>                   cfg->fc_protocol =3D RTPROT_BOOT;
> >>           rt->fib6_protocol =3D cfg->fc_protocol;
> >>
> >> -       rt->fib6_table =3D table;
> >>           rt->fib6_metric =3D cfg->fc_metric;
> >>           rt->fib6_type =3D cfg->fc_type ? : RTN_UNICAST;
> >>           rt->fib6_flags =3D cfg->fc_flags & ~RTF_GATEWAY;
> >> @@ -3824,6 +3817,17 @@ static struct fib6_info
> >> *ip6_route_info_create(struct fib6_config *cfg,
> >>           } else
> >>                   rt->fib6_prefsrc.plen =3D 0;
> >>
> >> +       if (cfg->fc_flags & RTF_EXPIRES)
> >> +               fib6_set_expires_locked(rt, jiffies +
> >> +
> >> clock_t_to_jiffies(cfg->fc_expires));
> >> +       else
> >> +               fib6_clean_expires_locked(rt);
> >
> > Note that I do not see why we call fib6_clean_expires_locked() on a
> > freshly allocated object.
> >
> > f6i->expires should already be zero...
> >
>
> Agree! I will remove it as well.

Please also add the following, if really we keep fib6_has_expires()
current definition.

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index e1e7a894863a7891610ce5afb2034473cc208d3e..95ed495c3a4028457baf1503c36=
7d2e7a6e14770
100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -329,7 +329,6 @@ static inline bool fib6_info_hold_safe(struct
fib6_info *f6i)
 static inline void fib6_info_release(struct fib6_info *f6i)
 {
        if (f6i && refcount_dec_and_test(&f6i->fib6_ref)) {
-               DEBUG_NET_WARN_ON_ONCE(fib6_has_expires(f6i));
                DEBUG_NET_WARN_ON_ONCE(!hlist_unhashed(&f6i->gc_link));
                call_rcu(&f6i->rcu, fib6_info_destroy_rcu);
        }

