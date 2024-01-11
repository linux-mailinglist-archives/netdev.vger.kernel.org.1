Return-Path: <netdev+bounces-63148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D31982B57C
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 20:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF391C2441E
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 19:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738675674D;
	Thu, 11 Jan 2024 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="OqbX3yUl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE6314F7A
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 19:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5e734251f48so45441007b3.1
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 11:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705002916; x=1705607716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13rw39O97Yd5BxpZ+F1nH/mYbFkgcCKR9n2vzZLrrgk=;
        b=OqbX3yUlC1SVbWvnGdZ/pycrtp9Au3BAxzEgLs+1jPSXH0yH2Mu3n/A5G4eJ9nrEGf
         nkIRUE2Nh1wQmWj6vs+oQDPFbgRyf4stJTGAoGh7IdhU9owdVX3V++fUxrLtCFY/O18x
         uFreNlbgG3epHKVEwuoEuOMNXrePRlYiLiHaeYsjXfFZCW/Mb8gLIgC4ARcXPleniQTs
         duNNlmuwCEDF7EJe8mnhR7mgvi5c2iP3a7Wlexc8wAAqqnu22DQECfI6TCq/dyUvCDtB
         vQ+TvFZtEkPWJ/fXX+o8cAc3xJ5L8j08bhAHHrzZdzlE4HXoA6JN6gcTaZlREKMhcsz3
         l7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705002916; x=1705607716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13rw39O97Yd5BxpZ+F1nH/mYbFkgcCKR9n2vzZLrrgk=;
        b=Qnmz9zKmJgHU3fp+zJAnaixYwhT7zwfxbhsFZvEjAI1Rl6nXi4rmenqukKnPLhQ2EL
         JTzVQV/2Zlc+UprYC7NSn0gIsBYFaOOhqm9A5yGSQGd3VObhTpuyOIArtpDLOYW6D2Ro
         0YtzQdrQFdDhJoixKU4eVI/wWLWmVyEkqmgWE9Ez6ORWr/EjxXsZDQEP0juXrXLEWWna
         rxIgknsW4D2nw/7oksnGh9MKE8un74mV0yprtXpXPyKPkStpcGQ0kTe5O9s9vDo0kk/t
         vLuSQFSKEpYx0o5BTPn3VqaJ81fgnqYKrrba5KZs8kL0SIBI3WmrXd/vQm13BbX0lKL7
         UAag==
X-Gm-Message-State: AOJu0Yz/dINZFRL6UoYe8H8Nkbym9wMQgtv2EsdcuUwPy7oMwikDzF3i
	Z19vrdCD1scneI3KIX11qndjEWFblaN2pkOkbZmXZaUtzvhV4FqZNap+KqH/cg==
X-Google-Smtp-Source: AGHT+IHXPxzs9iCj/GkGEV+mA0/90xujWPzHoabK1OTrUJ3mKLV76ANldmtgvIe5MDhz+ekmwE2FsiGuGTudXFwuc9Q=
X-Received: by 2002:a0d:d603:0:b0:5df:c224:fb44 with SMTP id
 y3-20020a0dd603000000b005dfc224fb44mr730704ywd.23.1705002916501; Thu, 11 Jan
 2024 11:55:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104125844.1522062-1-jiri@resnulli.us> <ZZ6JE0odnu1lLPtu@shredder>
 <CAM0EoM=AGxO0gdeHPi7ST0+-YVuT20ysPbrFkYVXLqGv39oR7Q@mail.gmail.com>
 <CAM0EoMkpzsEWXMw27xgsfzwA2g4CNeDYQ9niTJAkgu3=Kgp81g@mail.gmail.com> <878r4volo0.fsf@nvidia.com>
In-Reply-To: <878r4volo0.fsf@nvidia.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 11 Jan 2024 14:55:04 -0500
Message-ID: <CAM0EoMkFkJBGc5wsYec+1QZ_o6tEi6vm_KjAJV8SWB4EOPcppg@mail.gmail.com>
Subject: Re: [patch net-next] net: sched: move block device tracking into tcf_block_get/put_ext()
To: Petr Machata <petrm@nvidia.com>
Cc: Ido Schimmel <idosch@idosch.org>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, edumazet@google.com, 
	xiyou.wangcong@gmail.com, victor@mojatatu.com, pctammela@mojatatu.com, 
	mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 11:55=E2=80=AFAM Petr Machata <petrm@nvidia.com> wr=
ote:
>
>
> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>
> > On Thu, Jan 11, 2024 at 10:40=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> >>
> >> On Wed, Jan 10, 2024 at 7:10=E2=80=AFAM Ido Schimmel <idosch@idosch.or=
g> wrote:
> >> >
> >> > On Thu, Jan 04, 2024 at 01:58:44PM +0100, Jiri Pirko wrote:
> >> > > diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> >> > > index adf5de1ff773..253b26f2eddd 100644
> >> > > --- a/net/sched/cls_api.c
> >> > > +++ b/net/sched/cls_api.c
> >> > > @@ -1428,6 +1428,7 @@ int tcf_block_get_ext(struct tcf_block **p_b=
lock, struct Qdisc *q,
> >> > >                     struct tcf_block_ext_info *ei,
> >> > >                     struct netlink_ext_ack *extack)
> >> > >  {
> >> > > +     struct net_device *dev =3D qdisc_dev(q);
> >> > >       struct net *net =3D qdisc_net(q);
> >> > >       struct tcf_block *block =3D NULL;
> >> > >       int err;
> >> > > @@ -1461,9 +1462,18 @@ int tcf_block_get_ext(struct tcf_block **p_=
block, struct Qdisc *q,
> >> > >       if (err)
> >> > >               goto err_block_offload_bind;
> >> > >
> >> > > +     if (tcf_block_shared(block)) {
> >> > > +             err =3D xa_insert(&block->ports, dev->ifindex, dev, =
GFP_KERNEL);
> >> > > +             if (err) {
> >> > > +                     NL_SET_ERR_MSG(extack, "block dev insert fai=
led");
> >> > > +                     goto err_dev_insert;
> >> > > +             }
> >> > > +     }
> >> >
> >> > While this patch fixes the original issue, it creates another one:
> >> >
> >> > # ip link add name swp1 type dummy
> >> > # tc qdisc replace dev swp1 root handle 10: prio bands 8 priomap 7 6=
 5 4 3 2 1
> >> > # tc qdisc add dev swp1 parent 10:8 handle 108: red limit 1000000 mi=
n 200000 max 200001 probability 1.0 avpkt 8000 burst 38 qevent early_drop b=
lock 10
> >> > RED: set bandwidth to 10Mbit
> >> > # tc qdisc add dev swp1 parent 10:7 handle 107: red limit 1000000 mi=
n 500000 max 500001 probability 1.0 avpkt 8000 burst 63 qevent early_drop b=
lock 10
> >> > RED: set bandwidth to 10Mbit
> >> > Error: block dev insert failed.
> >> >
> >>
> >>
> >> +cc Petr
> >> We'll add a testcase on tdc - it doesnt seem we have any for qevents.
> >> If you have others that are related let us know.
> >> But how does this work? I see no mention of block on red code and i
>
> Look for qe_early_drop and qe_mark in sch_red.c.
>

I see it...

> >> see no mention of block on the reproducer above.
> >
> > Context: Yes, i see it on red setup but i dont see any block being setu=
p.
>
> qevents are binding locations for blocks, similar in principle to
> clsact's ingress_block / egress_block. So the way to create a block is
> the same: just mention the block number for the first time.
>
> What qevents there are depends on the qdisc. They are supposed to
> reflect events that are somehow interesting, from the point of view of
> an skb within a qdisc. Thus RED has two qevents: early_drop for packets
> that were chosen to be, well, dropped early, and mark for packets that
> are ECN-marked. So when a packet is, say, early-dropped, the RED qdisc
> passes it through the TC block bound at that qevent (if any).
>

Ok, the confusing part was the missing block command. I am assuming in
addition to Ido's example one would need to create block 10 and then
attach a filter to it?
Something like:
tc qdisc add dev swp1 parent 10:7 handle 107: red limit 1000000 min
500000 max 500001 probability 1.0 avpkt 8000 burst 63 qevent
early_drop block 10
tc filter add block 10 ...

So a packet tagged for early drop will end up being processed in some
filter chain with some specified actions. So in the case of offload,
does it mean early drops will be sent to the kernel and land at the
specific chain? Also trying to understand (in retrospect, not armchair
lawyering): why was a block necessary? feels like the goto chain
action could have worked, no? i.e something like: qevent early_drop
goto chain x.. Is the block perhaps tied to something in the h/w or is
it just some clever metainfo that is used to jump to tc block when the
exceptions happen?

Important thing is we need tests so we can catch these regressions in
the future.  If you can, point me to some (outside of the ones Ido
posted) and we'll put them on tdc.

> > Also: Is it only Red or other qdiscs could behave this way?
>
> Currently only red supports any qevents at all, but in principle the
> mechanism is reusable. With my mlxsw hat on, an obvious next candidate
> would be tail_drop on FIFO qdisc.

Sounds cool. I can see use even for s/w only dpath.

cheers,
jamal

