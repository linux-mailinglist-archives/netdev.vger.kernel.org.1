Return-Path: <netdev+bounces-63574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8181082E211
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 22:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2978B217D7
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 21:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4EC1AADB;
	Mon, 15 Jan 2024 21:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="VkTme3Pr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7F51AACF
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 21:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5f0629e67f4so90929917b3.3
        for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 13:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705352582; x=1705957382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrN470yywlQOzrwHqokxMTMfFEgHTI9ErDguvOKA6PY=;
        b=VkTme3Pr0gtw4nXhrWj6oMfCOGkn0W1ScdH/QXMe+idEas8FTbK5kHsS2dMmNWyPCb
         g3KOaKs7FRH4UVbcK1RL/A1MNCswtfNyQr38XIGGciXvl0EJvifxriLd2v9wlsEGPh11
         J6mFN79CiQscs2XyZ7ug11FJHl4gs0P/EMCb53kasnX83BXz2I81+fKN5NwOVI4wB9ly
         XoI4E1Zs3v0P5SRRDfXKyNCKAxTqdyS12gpWDl1dc3PUeY39RiZCHFIkSFkfZWnQmeEk
         1IraU7y6sPOLAiDsJzdlWyXvGmK5w8nGSf28qLP+Z32sccemZrVVMQowCO7oOVWgVvf9
         vb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705352582; x=1705957382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OrN470yywlQOzrwHqokxMTMfFEgHTI9ErDguvOKA6PY=;
        b=lMM33BktjUykxIc8PGSNaaIxqpIH5s4g+EBfd2WKApELGDkENz9JHnhYjhBeKffZN2
         xI+T3gCt7tCGTHAMfJXPjnOJDFGNXoNjw3MkE8oIrchj7FjhYganlGm/AmMNdLWDNeZg
         rr6hnwOCZ3e/t46ARGahx9ZzSL81u6kfLmEz37c5eRmS43tLQ6UbxuQ0b0JwqmGnQYFR
         a1d69Ld4vf6y+NnHRUcr/m/cKwMfzrIBiEOCzQ5t0R5Zh80xtbBxyzDrHWUdozW5EVtt
         01Nn6LiCU3RgXqwIvJoNIrs6xesasUxH3R7D2+djk/ipHRtcZT5n3gGxRfpnYQfJSbrx
         tUrg==
X-Gm-Message-State: AOJu0YwwxTNucRomsi8V7cW04El75mwv2psui1CnSEcmmlLkI3a73prv
	ZC1ak10ZW/EDzGc+T+n8SgyKt6atLEZAYNsVJGBl/IxLP/6E
X-Google-Smtp-Source: AGHT+IEejD6SaNdo06EYnpfY/Z2scMI2YlpWIgCnGIKacHg9mzgAh+IPvx4lP8PNp7O4Y1we4+YVoyWAlbilfbRmCVM=
X-Received: by 2002:a81:ad4d:0:b0:5e9:76a3:d6bc with SMTP id
 l13-20020a81ad4d000000b005e976a3d6bcmr4641707ywk.69.1705352582021; Mon, 15
 Jan 2024 13:03:02 -0800 (PST)
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
 <87zfxbmp5i.fsf@nvidia.com> <CAM0EoMmC1z9SzF7zNtquPinBDr3Zu-wfKKRU0CMK3SP4ZobOsg@mail.gmail.com>
 <87v87ymqzq.fsf@nvidia.com>
In-Reply-To: <87v87ymqzq.fsf@nvidia.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 15 Jan 2024 16:02:49 -0500
Message-ID: <CAM0EoMmLhg7DW4qOT0FZTpYN5rFX+406oNY3-wZv98td4X4Uhg@mail.gmail.com>
Subject: Re: [patch net-next] net: sched: move block device tracking into tcf_block_get/put_ext()
To: Petr Machata <petrm@nvidia.com>
Cc: Petr Machata <me@pmachata.org>, Ido Schimmel <idosch@idosch.org>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, xiyou.wangcong@gmail.com, 
	victor@mojatatu.com, pctammela@mojatatu.com, mleitner@redhat.com, 
	vladbu@nvidia.com, paulb@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 11:55=E2=80=AFAM Petr Machata <petrm@nvidia.com> wr=
ote:
>
>
> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>
> > On Thu, Jan 11, 2024 at 6:22=E2=80=AFPM Petr Machata <me@pmachata.org> =
wrote:
> >>
> >> Jamal Hadi Salim <jhs@mojatatu.com> writes:
> >>
> >> > On Thu, Jan 11, 2024 at 11:55=E2=80=AFAM Petr Machata <petrm@nvidia.=
com> wrote:
> >> >
> >> >> qevents are binding locations for blocks, similar in principle to
> >> >> clsact's ingress_block / egress_block. So the way to create a block=
 is
> >> >> the same: just mention the block number for the first time.
> >> >>
> >> >> What qevents there are depends on the qdisc. They are supposed to
> >> >> reflect events that are somehow interesting, from the point of view=
 of
> >> >> an skb within a qdisc. Thus RED has two qevents: early_drop for pac=
kets
> >> >> that were chosen to be, well, dropped early, and mark for packets t=
hat
> >> >> are ECN-marked. So when a packet is, say, early-dropped, the RED qd=
isc
> >> >> passes it through the TC block bound at that qevent (if any).
> >> >>
> >> >
> >> > Ok, the confusing part was the missing block command. I am assuming =
in
> >> > addition to Ido's example one would need to create block 10 and then
> >> > attach a filter to it?
> >> > Something like:
> >> > tc qdisc add dev swp1 parent 10:7 handle 107: red limit 1000000 min
> >> > 500000 max 500001 probability 1.0 avpkt 8000 burst 63 qevent
> >> > early_drop block 10
> >> > tc filter add block 10 ...
> >>
> >> Yes, correct.
> >>
> >> > So a packet tagged for early drop will end up being processed in som=
e
> >> > filter chain with some specified actions. So in the case of offload,
> >> > does it mean early drops will be sent to the kernel and land at the
> >> > specific chain? Also trying to understand (in retrospect, not armcha=
ir
> >>
> >> For offload, the idea is that the silicon is configured to do the thin=
gs
> >> that the user configures at the qevent.
> >
> > Ok, so none of these qevents related packets need to escape to s/w then=
.
>
> Like yeah, I suppose drops and marks shouldn't be /that/ numerous, so
> maybe you can get away with the cookie / schedule from driver that you
> talk about below. But you've got dozens of ports each of which is
> capable of flooding the PCI on its own. I can see this working for like
> connection tracking, or some other sort of miss that gets quickly
> installed in HW and future traffic stays there. I'm not sure it makes
> sense as a strategy for basically unbounded amounts of drops.

I misunderstood this to be more to trigger the control plane to do
something like adjust buffer sizes etc, etc. But if you are getting a
lot of these packets like you said it will be tantamount to a DoS.
For monitoring purposes (which seems to be the motivation here) I
wouldnt send pkts to the kernel.
Mirroring that you pointed to is sane, possibly even to a remote
machine dedicated for this makes more sense. BTW, is there a way for
the receiving end (where the packet is mirrored to) to know if the
packet they received was due to a RED drop or threshold excess/ecn
mark?

> >> In the particular case of mlxsw, we only permit adding one chain with
> >> one filter, which has to be a matchall, and the action has to be eithe=
r
> >> a mirred or trap, plus it needs to have hw_stats disabled. Because the
> >> HW is limited like that, it can't do much in that context.
> >>
> >
> > Understood. The challenge right now is we depend on a human to know
> > what the h/w constraints are and on misconfig you reject the bad
> > config. The other model is you query for the h/w capabilities and then
> > only allow valid config (in case of skip_sw)
>
> This is not new with qevents though. The whole TC offload is an exercise
> in return -EOPNOTSUPP. And half VXLAN, and IPIP, and, and. But I guess
> that's your point, that this sucks as a general approach?

Current scheme works fine - and in some cases is unavoidable. In P4 it
is different because resources are reserved; so by the time the
request hits the kernel, the tc layer already knows if such a request
will succeed or not if sent to the driver. This would be hard to do if
you have dynamic clever resourcing where you are continuously
adjusting the hardware resources - either growing or shrinking them
(as i think the mlxsw works); in such a case sending to the driver
makes more sense.

> >> > lawyering): why was a block necessary? feels like the goto chain
> >> > action could have worked, no? i.e something like: qevent early_drop
> >> > goto chain x.. Is the block perhaps tied to something in the h/w or =
is
> >> > it just some clever metainfo that is used to jump to tc block when t=
he
> >> > exceptions happen?
> >>
> >> So yeah, blocks are super fancy compared to what the HW can actually d=
o.
> >
> > My curiosity on blocks was more if the ports added to a block are
> > related somehow from a grouping perspective and in particular to the
> > h/w.
>
> Not necessarily. You could have two nics from different vendors with
> different offloading capabilities, and still share the same block with
> both, so long as you use the subset of features common to both.
>

True, for the general case. The hard part is dealing with exceptions,
for example, lets say we have two vendors who can both mirror in
hardware:
if you have a rule to mirror from vendor A port 0 to vendor B port 1,
it cant be done from Vendor A's ASIC directly. It would work if you
made it an exception that goes via kernel and some tc chain there
picks it up and sends it to vendor B's port1. You can probably do some
clever things like have direct DMA from vendor A to B, but that would
be very speacilized code.

> > For example in P4TC, at a hardware level we are looking to use
> > blocks to group devices that are under one PCI-dev (PF, VFs, etc) -
> > mostly this is because the underlying ASIC has them related already
> > (and if for example you said to mirror from one to the other it would
> > work whether in s/w or h/w)
>
> Yeah, I've noticed the "flood to other ports" patches. This is an
> interesting use case, but not one that was necessarily part of the
> blocks abstraction IMHO. I think originally blocks were just a sharing
> mechanism, which was the mindset with which I worked on qevents.
>

Basically now if you attach a mirror to a block all netdevs on that
block will receive a copy, note sure if that will have any effect on
what you are doing. Note:
Sharing of tables, actions, etc (or as P4 calls them
programs/pipelines) for all the ports in a block is still in play.
Challenge: assume vendor A from earlier has N ports which are part of
block 11: There is no need for vendor A's driver to register its tc
callback everytime one of the N ports get added into the block, one
should be enough (at least that is the thought process in the
discussions for offloads with P4TC).
Vendor A and B both register once, then you can replay the same rule
request to both. For actions that dont require cross-ASIC activity
(example a "drop")  it works fine because it will be localized.

> >> The initial idea was to have a single action, but then what if the HW
> >> can do more than that? And qdiscs still exist as SW entitites obviousl=
y,
> >> why limit ourselves to a single action in SW? OK, so maybe we can make
> >> that one action a goto chain, where the real stuff is, but where would
> >> it look the chain up? On ingress? Egress? So say that we know where to
> >> look it up,
> >
> > Note: At the NIC offloads i have seen - typically it is the driver
> > that would maintain such state and would know where to jump to.
> >
> >> but then also you'll end up with totally unhinged actions on
> >> an ingress / egress qdisc that are there just as jump targets of some
> >> qevent. Plus the set of actions permissible on ingress / egress can be
> >> arbitrarily different from the set of actions permissible on a qevent,
> >> which makes the validation in an offloading driver difficult. And chai=
n
> >> reuse is really not a thing in Linux TC, so keeping a chain on its own
> >> seems wrong. Plus the goto chain is still unclear in that scenario.
> >
> > It is a configuration/policy domain and requires human knowledge. The
> > NIC guys do it today. There's some default assumptions of "missed"
> > lookups - which end up as exceptions on chain 0 of the same qdisc
> > where skip_sw is configured. But you are right on the ingress/egress
> > issues: the NIC model at the moment assumes an ingress only approach
> > (at least in the ASICs), whereas you as a switch have to deal with
> > both. The good news is that TC can be taught to handle both.
>
> Oh, right. You mean give the packets a cookie to recognize them later,
> and do the scheduling by hand in the driver. Instead of injecting to
> ingress, directly pass the packet through some chain. But again, you
> need a well-defined way to specify which chain should be invoked, and it
> needs to work for any qdisc that decides to implement qevents. I know I
> sound like a broken record, but just make that reference be a block
> number and it's done for you, and everybody will agree on the semantics.
>

The block approach is simpler but i think the cookie continuation
approach is more autonomous.

> >> Blocks have no such issues, they are self-contained. They are heavy
> >> compared to what we need, true. But that's not really an issue -- the
> >> driver can bounce invalid configuration just fine. And there's no risk
> >> of making another driver or SW datapath user unhappy because their set
> >> of constrants is something we didn't anticipate. Conceptually it's
> >> cleaner than if we had just one action / one rule / one chain, because
> >> you can point at e.g. ingress_block and say, this, it's the same as
> >> this, except instead of all ingress packets, only those that are
> >> early_dropped are passed through.
> >
> > /nod
> >
> >> BTW, newer Spectrum chips actually allow (some?) ACL matching to run i=
n
> >> the qevent context, so we may end up relaxing the matchall requirement
> >> in the future and do a more complex offload of qevents.
> >
> > In P4 a lot of this could be modelled to one's liking really - but
> > that's a different discussion.
>
> Pretty sure :)
>
> BTW Spectrum's ACLs are really fairly close to what flower is doing.
> At least that's the ABI we get to work with. Not really a good target
> for u32 at all. So I suspect that P4 would end up looking remarkably
> flower-like, no offsets or layouts, most of it just pure symbolics.
>

Its a "fixed" ASIC, so it is expected. But: One should be able to
express the Spectrum's ACLs or even the whole datapath as a P4 program
and i dont see why it wouldnt work with P4TC. Matty has at least once
in the past, if i am not mistaken, pitched such an idea.

> >> > Important thing is we need tests so we can catch these regressions i=
n
> >> > the future.  If you can, point me to some (outside of the ones Ido
> >> > posted) and we'll put them on tdc.
> >>
> >> We just have the followin. Pretty sure that's where Ido's come from:
> >>
> >>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
> >>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/tools/testing/selftests/drivers/net/mlxsw/sch_red_root.sh
> >>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/tools/testing/selftests/drivers/net/mlxsw/sch_red_ets.sh
> >>
> >> Which is doing this (or s/early_drop/mark/ instead):
> >>
> >>     tc qdisc add dev $swp3 parent 1: handle 108: red \
> >>             limit 1000000 min $BACKLOG max $((BACKLOG + 1)) \
> >>             probability 1.0 avpkt 8000 burst 38 qevent early_drop bloc=
k 10
> >>
> >> And then installing a rule like one of these:
> >>
> >>     tc filter add block 10 pref 1234 handle 102 matchall skip_sw \
> >>             action mirred egress mirror dev $swp2 hw_stats disabled
> >>     tc filter add block 10 pref 1234 handle 102 matchall skip_sw \
> >>             action trap hw_stats disabled
> >>     tc filter add block 10 pref 1234 handle 102 matchall skip_sw \
> >>             action trap_fwd hw_stats disabled
> >>
> >> Then in runs traffic and checks the right amount gets mirrored or trap=
ped.
> >>
> >
> > Makes sense. Is the Red piece offloaded as well?
>
> Yeah, it does offload the early dropping / ECN marking logic, as per the
> configured min/max, if that's what you mean.
>
> >> >> > Also: Is it only Red or other qdiscs could behave this way?
> >> >>
> >> >> Currently only red supports any qevents at all, but in principle th=
e
> >> >> mechanism is reusable. With my mlxsw hat on, an obvious next candid=
ate
> >> >> would be tail_drop on FIFO qdisc.
> >> >
> >> > Sounds cool. I can see use even for s/w only dpath.
> >>
> >> FIFO is tricky to extend BTW. I wrote some patches way back before it
> >> got backburner'd, and the only payloads that are currently bounced are
> >> those that are <=3D3 bytes. Everything else is interpreted to mean
> >> something, extra garbage is ignored, etc. Fun fun.
> >
> > FIFO may have undergone too many changes to be general purpose anymore
> > (thinking of the attempts to make it lockless in particular) but I
> > would think that all you need is to share the netlink attributes with
> > the h/w, no? i.e you need a new attribute to enable qevents on fifo.
>
> Like the buffer model of our HW is just wildly incompatible with qdiscs'
> ideas. But that's not what I wanted to say. Say you want to add a new
> configuration knob to FIFO, e.g. the tail_drop qevent. How do you
> configure it?
>
> For reasonable qdiscs it's a simple matter of adding new attributes. But
> with FIFO, there _are_ no attributes. It's literally just if no nlattr,
> use defaults, otherwise bounce if the payload size < 4, else first 4
> bytes are limit and ignore the rest. Done & done. No attributes, and
> nowhere to put them in a backward compatible manner. So extending it is
> a bit hacky. (Can be done safely I believe, but it's not very pretty.)

I believe you but will have to look to make sense. There's at least
one attribute you mention above carried in some data structure in a
TLV (if i am not mistaken it is queue size either in packet or bytes,
depending on which fifo mode you are running). You are saying you cant
add another one or a flag at least?

cheers,
jamal

