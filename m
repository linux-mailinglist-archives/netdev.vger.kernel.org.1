Return-Path: <netdev+bounces-63283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8848382C20A
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 15:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594F21C21B25
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 14:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCB96DD0A;
	Fri, 12 Jan 2024 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ZT40FtMG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF966A345
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbdb124491cso5154460276.1
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 06:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705070852; x=1705675652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNL0Tu00M787VBiq9YV3mVNCgZRg1vgmo7HdGJbj6k4=;
        b=ZT40FtMGMdsdxI2rXmCzjGFhS0VTxZO6IE2MTe0XbM5N9kitqEvIEIJIxbXvrXvD2Q
         qyQ0qPxKTOxqjpOZS0m6Ze62WbPzN6NbbIM/8LdtDAdCTdVuOn/d69G4kpuVJ3gFuZMe
         bV3lu91+hjeFvlCIgqeZj86glXPCrKBfdrCJ5gAyZXm1YPuyhLV5M6TSozRgbm9EbD4M
         WIuxv97sdKaloVc6I3mDYIeFb73SiSaFACC04xmDSHFUGfdVxqYzh72YijeiIn1Xnpta
         BYASO3bl58l0gnQ0rbMGDrAiSFRxHA6cbX/lNih/252NXRZHeCmm0n+3G7Ak1f3NU1Wd
         nqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705070852; x=1705675652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNL0Tu00M787VBiq9YV3mVNCgZRg1vgmo7HdGJbj6k4=;
        b=pk3kGjkUe8fU8uSAJh3ChBWVyOXtI5Kd1+Dbola4FFEJdvQIJekCkN15AKiLFQ9+dj
         t4nbigIkJRCXG/fI+G7h+An1s2wvjpNf6ayZUJA+ZXd0bDkM5B38yg3MZ3EP6dypGV/U
         2ZNgf4Ztx0r+b2FRO7fzXWF7ZFyTHmRH4Woyht23hpigt/nSWGJgQsT0bX8uA+cpqoAB
         XwkoMwd0Bulw2ioNxif6bUNl85hGvDypoLicrzJ1SC15TYxmg4kjKoEzsTJNrn6VOe9S
         LyytNc1ZyvMdekdBMBdy6zr9wo33IvcX43A5bPwZ4XFypTLJVWW4d3tCcneKLxsjVHYf
         Uggg==
X-Gm-Message-State: AOJu0YzSJkUd7N7Z0BACaX/QAXUNizKqxIrObpRPXLqbeLuiFinH6KRQ
	FAhX2jWl2IKJZoV8wk2WzmGeLF4+eABtuQ+ta2hpLceqM1kC
X-Google-Smtp-Source: AGHT+IFqDSe/qLcsQ+s4N9pbKdTXL6i3CWhBlqsSF2hmlotDryILCb20fh/O0+/QIR1hpcNmCLtwvIltU4FtHrpb4sc=
X-Received: by 2002:a5b:888:0:b0:dbc:d059:c31b with SMTP id
 e8-20020a5b0888000000b00dbcd059c31bmr574581ybq.8.1705070851687; Fri, 12 Jan
 2024 06:47:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104125844.1522062-1-jiri@resnulli.us> <ZZ6JE0odnu1lLPtu@shredder>
 <CAM0EoM=AGxO0gdeHPi7ST0+-YVuT20ysPbrFkYVXLqGv39oR7Q@mail.gmail.com>
 <CAM0EoMkpzsEWXMw27xgsfzwA2g4CNeDYQ9niTJAkgu3=Kgp81g@mail.gmail.com>
 <878r4volo0.fsf@nvidia.com> <CAM0EoMkFkJBGc5wsYec+1QZ_o6tEi6vm_KjAJV8SWB4EOPcppg@mail.gmail.com>
 <87zfxbmp5i.fsf@nvidia.com>
In-Reply-To: <87zfxbmp5i.fsf@nvidia.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 12 Jan 2024 09:47:20 -0500
Message-ID: <CAM0EoMmC1z9SzF7zNtquPinBDr3Zu-wfKKRU0CMK3SP4ZobOsg@mail.gmail.com>
Subject: Re: [patch net-next] net: sched: move block device tracking into tcf_block_get/put_ext()
To: Petr Machata <me@pmachata.org>
Cc: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@idosch.org>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, xiyou.wangcong@gmail.com, 
	victor@mojatatu.com, pctammela@mojatatu.com, mleitner@redhat.com, 
	vladbu@nvidia.com, paulb@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 6:22=E2=80=AFPM Petr Machata <me@pmachata.org> wrot=
e:
>
> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>
> > On Thu, Jan 11, 2024 at 11:55=E2=80=AFAM Petr Machata <petrm@nvidia.com=
> wrote:
> >>
> >>
> >> Jamal Hadi Salim <jhs@mojatatu.com> writes:
> >>
> >> > On Thu, Jan 11, 2024 at 10:40=E2=80=AFAM Jamal Hadi Salim <jhs@mojat=
atu.com> wrote:
> >> >>
> >> >> On Wed, Jan 10, 2024 at 7:10=E2=80=AFAM Ido Schimmel <idosch@idosch=
.org> wrote:
> >> >> >
> >> >> > On Thu, Jan 04, 2024 at 01:58:44PM +0100, Jiri Pirko wrote:
> >> >> > > diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> >> >> > > index adf5de1ff773..253b26f2eddd 100644
> >> >> > > --- a/net/sched/cls_api.c
> >> >> > > +++ b/net/sched/cls_api.c
> >> >> > > @@ -1428,6 +1428,7 @@ int tcf_block_get_ext(struct tcf_block **=
p_block, struct Qdisc *q,
> >> >> > >                     struct tcf_block_ext_info *ei,
> >> >> > >                     struct netlink_ext_ack *extack)
> >> >> > >  {
> >> >> > > +     struct net_device *dev =3D qdisc_dev(q);
> >> >> > >       struct net *net =3D qdisc_net(q);
> >> >> > >       struct tcf_block *block =3D NULL;
> >> >> > >       int err;
> >> >> > > @@ -1461,9 +1462,18 @@ int tcf_block_get_ext(struct tcf_block *=
*p_block, struct Qdisc *q,
> >> >> > >       if (err)
> >> >> > >               goto err_block_offload_bind;
> >> >> > >
> >> >> > > +     if (tcf_block_shared(block)) {
> >> >> > > +             err =3D xa_insert(&block->ports, dev->ifindex, de=
v, GFP_KERNEL);
> >> >> > > +             if (err) {
> >> >> > > +                     NL_SET_ERR_MSG(extack, "block dev insert =
failed");
> >> >> > > +                     goto err_dev_insert;
> >> >> > > +             }
> >> >> > > +     }
> >> >> >
> >> >> > While this patch fixes the original issue, it creates another one=
:
> >> >> >
> >> >> > # ip link add name swp1 type dummy
> >> >> > # tc qdisc replace dev swp1 root handle 10: prio bands 8 priomap =
7 6 5 4 3 2 1
> >> >> > # tc qdisc add dev swp1 parent 10:8 handle 108: red limit 1000000=
 min 200000 max 200001 probability 1.0 avpkt 8000 burst 38 qevent early_dro=
p block 10
> >> >> > RED: set bandwidth to 10Mbit
> >> >> > # tc qdisc add dev swp1 parent 10:7 handle 107: red limit 1000000=
 min 500000 max 500001 probability 1.0 avpkt 8000 burst 63 qevent early_dro=
p block 10
> >> >> > RED: set bandwidth to 10Mbit
> >> >> > Error: block dev insert failed.
> >> >> >
> >> >>
> >> >>
> >> >> +cc Petr
> >> >> We'll add a testcase on tdc - it doesnt seem we have any for qevent=
s.
> >> >> If you have others that are related let us know.
> >> >> But how does this work? I see no mention of block on red code and i
> >>
> >> Look for qe_early_drop and qe_mark in sch_red.c.
> >>
> >
> > I see it...
> >
> >> >> see no mention of block on the reproducer above.
> >> >
> >> > Context: Yes, i see it on red setup but i dont see any block being s=
etup.
> >>
> >> qevents are binding locations for blocks, similar in principle to
> >> clsact's ingress_block / egress_block. So the way to create a block is
> >> the same: just mention the block number for the first time.
> >>
> >> What qevents there are depends on the qdisc. They are supposed to
> >> reflect events that are somehow interesting, from the point of view of
> >> an skb within a qdisc. Thus RED has two qevents: early_drop for packet=
s
> >> that were chosen to be, well, dropped early, and mark for packets that
> >> are ECN-marked. So when a packet is, say, early-dropped, the RED qdisc
> >> passes it through the TC block bound at that qevent (if any).
> >>
> >
> > Ok, the confusing part was the missing block command. I am assuming in
> > addition to Ido's example one would need to create block 10 and then
> > attach a filter to it?
> > Something like:
> > tc qdisc add dev swp1 parent 10:7 handle 107: red limit 1000000 min
> > 500000 max 500001 probability 1.0 avpkt 8000 burst 63 qevent
> > early_drop block 10
> > tc filter add block 10 ...
>
> Yes, correct.
>
> > So a packet tagged for early drop will end up being processed in some
> > filter chain with some specified actions. So in the case of offload,
> > does it mean early drops will be sent to the kernel and land at the
> > specific chain? Also trying to understand (in retrospect, not armchair
>
> For offload, the idea is that the silicon is configured to do the things
> that the user configures at the qevent.
>

Ok, so none of these qevents related packets need to escape to s/w then.

> In the particular case of mlxsw, we only permit adding one chain with
> one filter, which has to be a matchall, and the action has to be either
> a mirred or trap, plus it needs to have hw_stats disabled. Because the
> HW is limited like that, it can't do much in that context.
>

Understood. The challenge right now is we depend on a human to know
what the h/w constraints are and on misconfig you reject the bad
config. The other model is you query for the h/w capabilities and then
only allow valid config (in case of skip_sw)

> > lawyering): why was a block necessary? feels like the goto chain
> > action could have worked, no? i.e something like: qevent early_drop
> > goto chain x.. Is the block perhaps tied to something in the h/w or is
> > it just some clever metainfo that is used to jump to tc block when the
> > exceptions happen?
>
> So yeah, blocks are super fancy compared to what the HW can actually do.

My curiosity on blocks was more if the ports added to a block are
related somehow from a grouping perspective and in particular to the
h/w. For example in P4TC, at a hardware level we are looking to use
blocks to group devices that are under one PCI-dev (PF, VFs, etc) -
mostly this is because the underlying ASIC has them related already
(and if for example you said to mirror from one to the other it would
work whether in s/w or h/w)

> The initial idea was to have a single action, but then what if the HW
> can do more than that? And qdiscs still exist as SW entitites obviously,
> why limit ourselves to a single action in SW? OK, so maybe we can make
> that one action a goto chain, where the real stuff is, but where would
> it look the chain up? On ingress? Egress? So say that we know where to
> look it up,

Note: At the NIC offloads i have seen - typically it is the driver
that would maintain such state and would know where to jump to.

>but then also you'll end up with totally unhinged actions on
> an ingress / egress qdisc that are there just as jump targets of some
> qevent. Plus the set of actions permissible on ingress / egress can be
> arbitrarily different from the set of actions permissible on a qevent,
> which makes the validation in an offloading driver difficult. And chain
> reuse is really not a thing in Linux TC, so keeping a chain on its own
> seems wrong. Plus the goto chain is still unclear in that scenario.
>

It is a configuration/policy domain and requires human knowledge. The
NIC guys do it today. There's some default assumptions of "missed"
lookups - which end up as exceptions on chain 0 of the same qdisc
where skip_sw is configured. But you are right on the ingress/egress
issues: the NIC model at the moment assumes an ingress only approach
(at least in the ASICs), whereas you as a switch have to deal with
both. The good news is that TC can be taught to handle both.

> Blocks have no such issues, they are self-contained. They are heavy
> compared to what we need, true. But that's not really an issue -- the
> driver can bounce invalid configuration just fine. And there's no risk
> of making another driver or SW datapath user unhappy because their set
> of constrants is something we didn't anticipate. Conceptually it's
> cleaner than if we had just one action / one rule / one chain, because
> you can point at e.g. ingress_block and say, this, it's the same as
> this, except instead of all ingress packets, only those that are
> early_dropped are passed through.
>

/nod

> BTW, newer Spectrum chips actually allow (some?) ACL matching to run in
> the qevent context, so we may end up relaxing the matchall requirement
> in the future and do a more complex offload of qevents.
>

In P4 a lot of this could be modelled to one's liking really - but
that's a different discussion.

> > Important thing is we need tests so we can catch these regressions in
> > the future.  If you can, point me to some (outside of the ones Ido
> > posted) and we'll put them on tdc.
>
> We just have the followin. Pretty sure that's where Ido's come from:
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/tools/testing/selftests/drivers/net/mlxsw/sch_red_root.sh
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/tools/testing/selftests/drivers/net/mlxsw/sch_red_ets.sh
>
> Which is doing this (or s/early_drop/mark/ instead):
>
>     tc qdisc add dev $swp3 parent 1: handle 108: red \
>             limit 1000000 min $BACKLOG max $((BACKLOG + 1)) \
>             probability 1.0 avpkt 8000 burst 38 qevent early_drop block 1=
0
>
> And then installing a rule like one of these:
>
>     tc filter add block 10 pref 1234 handle 102 matchall skip_sw \
>             action mirred egress mirror dev $swp2 hw_stats disabled
>     tc filter add block 10 pref 1234 handle 102 matchall skip_sw \
>             action trap hw_stats disabled
>     tc filter add block 10 pref 1234 handle 102 matchall skip_sw \
>             action trap_fwd hw_stats disabled
>
> Then in runs traffic and checks the right amount gets mirrored or trapped=
.
>

Makes sense. Is the Red piece offloaded as well?

> >> > Also: Is it only Red or other qdiscs could behave this way?
> >>
> >> Currently only red supports any qevents at all, but in principle the
> >> mechanism is reusable. With my mlxsw hat on, an obvious next candidate
> >> would be tail_drop on FIFO qdisc.
> >
> > Sounds cool. I can see use even for s/w only dpath.
>
> FIFO is tricky to extend BTW. I wrote some patches way back before it
> got backburner'd, and the only payloads that are currently bounced are
> those that are <=3D3 bytes. Everything else is interpreted to mean
> something, extra garbage is ignored, etc. Fun fun.

FIFO may have undergone too many changes to be general purpose anymore
(thinking of the attempts to make it lockless in particular) but I
would think that all you need is to share the netlink attributes with
the h/w, no? i.e you need a new attribute to enable qevents on fifo.

cheers,
jamal

