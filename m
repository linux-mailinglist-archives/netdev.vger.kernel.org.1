Return-Path: <netdev+bounces-195568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79093AD141F
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 22:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CD57A53C4
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 20:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8721E25F8;
	Sun,  8 Jun 2025 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="C6UZP1gc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D42D1519A6
	for <netdev@vger.kernel.org>; Sun,  8 Jun 2025 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749413081; cv=none; b=qitqC/VOCRVAC50uHHHzx6d3ku6vu/tPcXzG34VcYLXIFAAEzhfLS7S018NoxtwgJGaxYHokMAx55BHfZRAbouHd+Ll6f+VHyoxuvhx3V5YjR3cEyMpbdSmuM39LBYNfJ0suShH8IighkNtv3ZtyPuqkoZfSwJXzVwOTEN+mv/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749413081; c=relaxed/simple;
	bh=GBseTPe9qhvkL7oRwSchQXPRrDhVvhw6A9dgI5QOoz8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZy/qhCo/rUKQvaa7nS3kC/1rV/2E7XvlnC6+TI62URzXUz7jwI8YjiKI2mOM+A3moDWcwfQpBhDgtOKCTgmPZ+dQt/rZ4Xe0hJVVXBNiYiNXht0TmgIMRLYWeAuJEyiYg9JKUiTtt1UO92Nv+GqrzU/qZqiKb3KVdPk/SF6m3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=C6UZP1gc; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1749413067; x=1749672267;
	bh=GBseTPe9qhvkL7oRwSchQXPRrDhVvhw6A9dgI5QOoz8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=C6UZP1gc+peeDXHZL+4O4bGhvnhJZ3WSv7g1HNyvu2SiskAYB5FC3Y9EFJ1sheoag
	 0PWuYdlTtJptpaH14TkqvFrrEdrfI5eVRCs0No3bBD7aTIl0eeQO3yehuIySxBATuD
	 8tZIQTwJ18r8r6JTh6UdvSJLoYfaAvUIlGFBGMe9BAePWwWIZrOip0VTEk006VL85E
	 PVVx2P0W8IpKdgR94pCGJwi0ZXMcHFx2P+dBm8Yp0NKTwG9k3fmbOCp5KPi+HcTzRK
	 7zS8BjKRiyLVlF6kqDrbN82+lSlex3Z7awB+Pc+0WUIP009XmtjuT3+QpukRvC80xz
	 qjxVYhGbQQwJg==
Date: Sun, 08 Jun 2025 20:04:23 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: William Liu <will@willsroot.io>
Cc: Savy <savy@syst3mfailure.io>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
Message-ID: <A2nutOWbLBIdLRrnsUdavOagBEebp4YBFx0DdL23njEFVAySZul2pDRK1xf76_g6dLb82YXCRb1Ry9btDkZqeY9Btib0KgViSIIfsi4BDfU=@willsroot.io>
In-Reply-To: <CAM0EoMkoFJJQD_ZVSMb7DUo1mafevgujx+WA=1ecTeYBcpB1Lw@mail.gmail.com>
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io> <0x7zdcWIGm0NWid6NxFLpYOtO0Z1g6UCzrNnyVZ6hRvWr5rU6b6hi5Yz8dD7_dyUOmvJfkR8LV2_TrDf7uACFgGshyfxiRWgxjWer41EZVY=@willsroot.io> <CAM0EoMmns+rSyg4h-WGAMewqYWx0-MYC1DtRyJe4=rbgZN2UKQ@mail.gmail.com> <99X_9_r0DXyyKP-0xVz3Bg2FFXhmpCsIdTix8J-a52alNswEyVRbhMFnzyT35EOUP-8TVPL-UDvBbOd8u5_jRE10A98e_ULf5x6GTv03tbg=@syst3mfailure.io> <CAM0EoMnCHu5HrNjE-mf8_OFanrptcTFgaEPJbkWXJybhm8f8tw@mail.gmail.com> <CAM0EoMk--+xXTf9ZG9M=r+gkRn2hczjqSTJRMV0dcgouJ4zw6g@mail.gmail.com> <CAM0EoMk4dxOFoN_=3yOy+XrtU=yvjJXAw3fVTmN9=M=R=vtbxA@mail.gmail.com> <lVH_UKrQzWPCHJS7_1Cj0gmEV0x4KI3VB_4auivP0fDokTBbmWuDV455wXrf6eQzakVFoK6wUxlDuMw_Lo0p4P9ByPLSjklsIkQiNcd_hvQ=@willsroot.io> <CAM0EoMkoFJJQD_ZVSMb7DUo1mafevgujx+WA=1ecTeYBcpB1Lw@mail.gmail.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 0e3274598dda5ad2e1519ca7b48f06e3f3a5a024
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






On Sunday, June 8th, 2025 at 12:39 PM, Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:

>=20
>=20
> On Thu, Jun 5, 2025 at 11:20=E2=80=AFAM William Liu will@willsroot.io wro=
te:
>=20
> > On Monday, June 2nd, 2025 at 9:39 PM, Jamal Hadi Salim jhs@mojatatu.com=
 wrote:
> >=20
> > > On Sat, May 31, 2025 at 11:38=E2=80=AFAM Jamal Hadi Salim jhs@mojatat=
u.com wrote:
> > >=20
> > > > On Sat, May 31, 2025 at 11:23=E2=80=AFAM Jamal Hadi Salim jhs@mojat=
atu.com wrote:
> > > >=20
> > > > > On Sat, May 31, 2025 at 9:20=E2=80=AFAM Savy savy@syst3mfailure.i=
o wrote:
> > > > >=20
> > > > > > On Friday, May 30th, 2025 at 9:41 PM, Jamal Hadi Salim jhs@moja=
tatu.com wrote:
> > > > > >=20
> > > > > > > Hi Will,
> > > > > > >=20
> > > > > > > On Fri, May 30, 2025 at 10:49=E2=80=AFAM William Liu will@wil=
lsroot.io wrote:
> > > > > > >=20
> > > > > > > > On Friday, May 30th, 2025 at 2:14 PM, Jamal Hadi Salim jhs@=
mojatatu.com wrote:
> > > > > > > >=20
> > > > > > > > > On Thu, May 29, 2025 at 11:23=E2=80=AFAM William Liu will=
@willsroot.io wrote:
> > > > > > > > >=20
> > > > > > > > > > On Wednesday, May 28th, 2025 at 10:00 PM, Jamal Hadi Sa=
lim jhs@mojatatu.com wrote:
> > > > > > > > > >=20
> > > > > > > > > > > Hi,
> > > > > > > > > > > Sorry for the latency..
> > > > > > > > > > >=20
> > > > > > > > > > > On Sun, May 25, 2025 at 4:43=E2=80=AFPM William Liu w=
ill@willsroot.io wrote:
> > > > > > > > > > >=20
> > > > > > > > > > > > I did some more testing with the percpu approach, a=
nd we realized the following problem caused now by netem_dequeue.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Recall that we increment the percpu variable on net=
em_enqueue entry and decrement it on exit. netem_dequeue calls enqueue on t=
he child qdisc - if this child qdisc is a netem qdisc with duplication enab=
led, it could duplicate a previously duplicated packet from the parent back=
 to the parent, causing the issue again. The percpu variable cannot protect=
 against this case.
> > > > > > > > > > >=20
> > > > > > > > > > > I didnt follow why "percpu variable cannot protect ag=
ainst this case"
> > > > > > > > > > > - the enqueue and dequeue would be running on the sam=
e cpu, no?
> > > > > > > > > > > Also under what circumstances is the enqueue back to =
the root going to
> > > > > > > > > > > end up in calling dequeue? Did you test and hit this =
issue or its just
> > > > > > > > > > > theory? Note: It doesnt matter what the source of the=
 skb is as long
> > > > > > > > > > > as it hits the netem enqueue.
> > > > > > > > > >=20
> > > > > > > > > > Yes, I meant that just using the percpu variable in enq=
ueue will not protect against the case for when dequeue calls enqueue on th=
e child. Because of the child netem with duplication enabled, packets alrea=
dy involved in duplication will get sent back to the parent's tfifo queue, =
and then the current dequeue will remain stuck in the loop before hitting a=
n OOM - refer to the paragraph starting with "In netem_dequeue, the parent =
netem qdisc's t_len" in the first email for additional clarification. We ne=
ed to know whether a packet we dequeue has been involved in duplication - i=
f it has, we increment the percpu variable to inform the children netem qdi=
scs.
> > > > > > > > > >=20
> > > > > > > > > > Hopefully the following diagram can help elucidate the =
problem:
> > > > > > > > > >=20
> > > > > > > > > > Step 1: Initial enqueue of Packet A:
> > > > > > > > > >=20
> > > > > > > > > > +----------------------+
> > > > > > > > > > | Packet A |
> > > > > > > > > > +----------------------+
> > > > > > > > > > |
> > > > > > > > > > v
> > > > > > > > > > +-------------------------+
> > > > > > > > > > | netem_enqueue |
> > > > > > > > > > +-------------------------+
> > > > > > > > > > |
> > > > > > > > > > v
> > > > > > > > > > +-----------------------------------+
> > > > > > > > > > | Duplication Logic (percpu OK): |
> > > > > > > > > > | =3D> Packet A, Packet B (dup) |
> > > > > > > > > > +-----------------------------------+
> > > > > > > > > > | <- percpu variable for netem_enqueue
> > > > > > > > > > v prevents duplication of B
> > > > > > > > > > +-------------+
> > > > > > > > > > | tfifo queue |
> > > > > > > > > > | [A, B] |
> > > > > > > > > > +-------------+
> > > > > > > > > >=20
> > > > > > > > > > Step 2: netem_dequeue processes Packet B (or A)
> > > > > > > > > >=20
> > > > > > > > > > +-------------+
> > > > > > > > > > | tfifo queue |
> > > > > > > > > > | [A] |
> > > > > > > > > > +-------------+
> > > > > > > > > > |
> > > > > > > > > > v
> > > > > > > > > > +----------------------------------------+
> > > > > > > > > > | netem_dequeue pops B in tfifo_dequeue |
> > > > > > > > > > +----------------------------------------+
> > > > > > > > > > |
> > > > > > > > > > v
> > > > > > > > > > +--------------------------------------------+
> > > > > > > > > > | netem_enqueue to child qdisc (netem w/ dup)|
> > > > > > > > > > +--------------------------------------------+
> > > > > > > > > > | <- percpu variable in netem_enqueue prologue
> > > > > > > > > > | and epilogue does not stop this dup,
> > > > > > > > > > v does not know about previous dup involvement
> > > > > > > > > > +------------------------------------------------------=
--+
> > > > > > > > > > | Child qdisc duplicates B to root (original netem) as =
C |
> > > > > > > > > > +------------------------------------------------------=
--+
> > > > > > > > > > |
> > > > > > > > > > v
> > > > > > > > > >=20
> > > > > > > > > > Step 3: Packet C enters original root netem again
> > > > > > > > > >=20
> > > > > > > > > > +-------------------------+
> > > > > > > > > > | netem_enqueue (again) |
> > > > > > > > > > +-------------------------+
> > > > > > > > > > |
> > > > > > > > > > v
> > > > > > > > > > +-------------------------------------+
> > > > > > > > > > | Duplication Logic (percpu OK again) |
> > > > > > > > > > | =3D> Packet C, Packet D |
> > > > > > > > > > +-------------------------------------+
> > > > > > > > > > |
> > > > > > > > > > v
> > > > > > > > > > .....
> > > > > > > > > >=20
> > > > > > > > > > If you increment a percpu variable in enqueue prologue =
and decrement in enqueue epilogue, you will notice that our original repro =
will still trigger a loop because of the scenario I pointed out above - thi=
s has been tested.
> > > > > > > > > >=20
> > > > > > > > > > From a current view of the codebase, netem is the only =
qdisc that calls enqueue on its child from its dequeue. The check we propos=
e will only work if this invariant remains.
> > > > > > > > > >=20
> > > > > > > > > > > > However, there is a hack to address this. We can ad=
d a field in netem_skb_cb called duplicated to track if a packet is involve=
d in duplicated (both the original and duplicated packet should have it mar=
ked). Right before we call the child enqueue in netem_dequeue, we check for=
 the duplicated value. If it is true, we increment the percpu variable befo=
re and decrement it after the child enqueue call.
> > > > > > > > > > >=20
> > > > > > > > > > > is netem_skb_cb safe really for hierarchies? grep for=
 qdisc_skb_cb
> > > > > > > > > > > net/sched/ to see what i mean
> > > > > > > > > >=20
> > > > > > > > > > We are not using it for cross qdisc hierarchy checking.=
 We are only using it to inform a netem dequeue whether the packet has part=
aken in duplication from its corresponding netem enqueue. That part seems t=
o be private data for the sk_buff residing in the current qdisc, so my unde=
rstanding is that it's ok.
> > > > > > > > > >=20
> > > > > > > > > > > > This only works under the assumption that there are=
n't other qdiscs that call enqueue on their child during dequeue, which see=
ms to be the case for now. And honestly, this is quite a fragile fix - ther=
e might be other edge cases that will cause problems later down the line.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Are you aware of other more elegant approaches we c=
an try for us to track this required cross-qdisc state? We suggested adding=
 a single bit to the skb, but we also see the problem with adding a field f=
or a one-off use case to such a vital structure (but this would also comple=
tely stomp out this bug).
> > > > > > > > > > >=20
> > > > > > > > > > > It sounds like quite a complicated approach - i dont =
know what the
> > > > > > > > > > > dequeue thing brings to the table; and if we really h=
ave to dequeue to
> > > > > > > > > >=20
> > > > > > > > > > Did what I say above help clarify what the problem is? =
Feel free to let me know if you have more questions, this bug is quite a na=
sty one.
> > > > > > > > >=20
> > > > > > > > > The text helped a bit, but send a tc reproducer of the is=
sue you
> > > > > > > > > described to help me understand better how you end up in =
the tfifo
> > > > > > > > > which then calls the enqueu, etc, etc.
> > > > > > > >=20
> > > > > > > > The reproducer is the same as the original reproducer we re=
ported:
> > > > > > > > tc qdisc add dev lo root handle 1: netem limit 1 duplicate =
100%
> > > > > > > > tc qdisc add dev lo parent 1: handle 2: netem gap 1 limit 1=
 duplicate 100% delay 1us reorder 100%
> > > > > > > > ping -I lo -f -c1 -s48 -W0.001 127.0.0.1
> > > > > > > >=20
> > > > > > > > We walked through the issue in the codepath in the first em=
ail of this thread at the paragraph starting with "The root cause for this =
is complex. Because of the way we setup the parent qdisc" - please let me k=
now if any additional clarification is needed for any part of it.
> > > > > > >=20
> > > > > > > Ok, so I tested both your approach and a slight modification =
of the
> > > > > > > variant I sent you. They both fix the issue. TBH, I still fin=
d your
> > > > > > > approach complex. While i hate to do this to you, my preferen=
ce is
> > > > > > > that you use the attached version - i dont need the credit, s=
o just
> > > > > > > send it formally after testing.
> > > > > > >=20
> > > > > > > cheers,
> > > > > > > jamal
> > > > > >=20
> > > > > > Hi Jamal,
> > > > > >=20
> > > > > > Thank you for your patch. Unfortunately, there is an issue that=
 Will and I
> > > > > > also encountered when we submitted the first version of our pat=
ch.
> > > > > >=20
> > > > > > With this check:
> > > > > >=20
> > > > > > if (unlikely(nest_level > 1)) {
> > > > > > net_warn_ratelimited("Exceeded netem recursion %d > 1 on dev %s=
\n",
> > > > > > nest_level, netdev_name(skb->dev));
> > > > > > // ...
> > > > > > }
> > > > > >=20
> > > > > > when netem_enqueue is called, we have:
> > > > > >=20
> > > > > > netem_enqueue()
> > > > > > // nest_level is incremented to 1
> > > > > > // q->duplicate is 100% (0xFFFFFFFF)
> > > > > > // skb2 =3D skb_clone()
> > > > > > // rootq->enqueue(skb2, ...)
> > > > > > netem_enqueue()
> > > > > > // nest_level is incremented to 2
> > > > > > // nest_level now is > 1
> > > > > > // The duplicate is dropped
> > > > > >=20
> > > > > > Basically, with this approach, all duplicates are automatically=
 dropped.
> > > > > >=20
> > > > > > If we modify the check by replacing 1 with 2:
> > > > > >=20
> > > > > > if (unlikely(nest_level > 2)) {
> > > > > > net_warn_ratelimited("Exceeded netem recursion %d > 1 on dev %s=
\n",
> > > > > > nest_level, netdev_name(skb->dev));
> > > > > > // ...
> > > > > > }
> > > > > >=20
> > > > > > the infinite loop is triggered again (this has been tested and =
also verified in GDB).
> > > > > >=20
> > > > > > This is why we proposed an alternative approach, but I understa=
nd it is more complex.
> > > > > > Maybe we can try to work on that and make it more elegant.
> > > > >=20
> > > > > I am not sure.
> > > > > It is a choice between complexity to "fix" something that is a ba=
d
> > > > > configuration, i.e one that should not be allowed to begin with, =
vs
> > > > > not burdening the rest.
> > > > > IOW, if you created a single loop(like the original report) the
> > > > > duplicate packet will go through but subsequent ones will not). I=
f you
> > > > > created a loop inside a loop(as you did here), does anyone really=
 care
> > > > > about the duplicate in each loop not making it through? It would =
be
> > > > > fine to "fix it" so you get duplicates in each loop if there was
> > > > > actually a legitimate use case. Remember one of the original choi=
ces
> > > > > was to disallow the config ...
> > > >=20
> > > > Actually I think i misunderstood you. You are saying it breaks even
> > > > the working case for duplication.
> > > > Let me think about it..
> > >=20
> > > After some thought and experimentation - I believe the only way to fi=
x
> > > this so nobody comes back in the future with loops is to disallow the
> > > netem on top of netem setup. The cb approach can be circumvented by
> > > zeroing the cb at the root.
> > >=20
> > > cheers,
> > > jamal
> >=20
> > Doesn't the cb zeroing only happen upon reset, which should be fine?
>=20
>=20
> The root qdisc can be coerced to set values that could be zero. IMO,
> it is not fine for folks to come back in a few months and claim some
> prize because they managed to create the loop after this goes in. I am
> certainly not interested in dealing with that...
> I wish we still had the 2 bit TTL in the skb, this would have been an
> easy fix[1].
>=20

The loopy fun problem combined with this duplication issue maybe shows the =
need for us to get some bits in the sk_buff reserved for this case - this i=
s a security issue, as container/unprivileged users can trigger DOS.=20

Regarding the size of sk_buff, at least when I tried this approach, there w=
as no increase in struct size. The slab allocator architecture wouldn't cau=
se increased memory consumption even if an extra byte were to be used. A ro=
bust fix here can future proof this subsystem against packet looping bugs, =
so maybe this can be a consideration for later.

> > I agree that the strategy you propose would be more durable. We would h=
ave to prevent setups of the form:
> >=20
> > qdisc 0 ... qdisc i, netem, qdisc i + 1, ... qdisc j, netem, ...
> >=20
> > Netem qdiscs can be identified through the netem_qdisc_ops pointer.
> >=20
> > We would also have to check this property on qdisc insertion and replac=
ement. I'm assuming the traversal can be done with the walk/leaf handlers.
> >=20
> > Are there other things we are missing?
>=20
>=20
> Make it simple: Try to prevent the config of a new netem being added
> when one already exists at any hierarchy i.e dont bother checking if
> Can I assume you will work on this? Otherwise I or someone else can.
>=20

Yep, I will give this a try in the coming days and will let you know if I e=
ncounter any difficulties.

>=20
> [1] see "loopy fun" in https://lwn.net/Articles/719297/

Best,
Will

