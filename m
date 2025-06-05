Return-Path: <netdev+bounces-195288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F33BAACF2E8
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 17:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F279E1894DB9
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF5519CC27;
	Thu,  5 Jun 2025 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="P4GfhvdJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944381B423C
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136817; cv=none; b=rv6tjySei4mMMccI3a3shzEndC4YW531ajy1a41F4uyGLygx18H9ImFuhaabfhSXFxfl+z0f4Ht4IOa/8UhqK6Lvf9IzJWqcXjTvxovFz8XJEdVbuhdcRVrYLbZA1X7lIbKlkBXOGGge1hYA9D/OE/Q+TmyenQKAg/O1+8Dcagw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136817; c=relaxed/simple;
	bh=NsD9K5qJkOnDlFbuF+/ob8gtypfVng9sHSqmU7wstnY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjEurCWPDeCo0zUUJmcips3gf1vcDGoImEeS8B6pVhgMH0V9HZB3yiNfphWMe01H6eoJbDaapa0EwEQCbOTIQqNbxrdQGRZYqB8mIfQS8enhxWtPsCSGDCi9ye3jS/tlE0jlm6Hr98HZXyn2aWXmtnItDYZo+m53/J0q8s3i2RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=P4GfhvdJ; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1749136805; x=1749396005;
	bh=nuTajlJMKC8+tinspkExg0mWVHQj/7t3qReejPK3Kg4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=P4GfhvdJ/aOk7DGahzxU500X3d3y8KuxB/dArVyNM0El23BGBC8n4LnoqHM4WfM+u
	 dyuP5ra5Pwpkc0vnFkt6HkwHI9qYCMEyDNyb0zxdq9brIVVsxDEZ1EVyg3S1XQEYCG
	 JjNeRQHMqsBevw5Ooplu/cnqiaOqjf6yrg0ElugkwIK6fVuE5M+sJJDpSYuzj1xOlk
	 5txKqxAExkRpyzeB12u2x+9wcGz6WSf4Wu0BUQumReBp5jD8psd1R+woFJTUxyz0bo
	 /xnR6GjQXRp0vPlgVA2DY6f7wvVmnN9xL35hfl/IKft0Pm1qBNbELow69Y154FQnIQ
	 A3ZYyKWYAFCIg==
Date: Thu, 05 Jun 2025 15:20:01 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: William Liu <will@willsroot.io>
Cc: Savy <savy@syst3mfailure.io>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
Message-ID: <lVH_UKrQzWPCHJS7_1Cj0gmEV0x4KI3VB_4auivP0fDokTBbmWuDV455wXrf6eQzakVFoK6wUxlDuMw_Lo0p4P9ByPLSjklsIkQiNcd_hvQ=@willsroot.io>
In-Reply-To: <CAM0EoMk4dxOFoN_=3yOy+XrtU=yvjJXAw3fVTmN9=M=R=vtbxA@mail.gmail.com>
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io> <DISZZlS5CdbUKITzkIyT3jki3inTWSMecT6FplNmkpYs9bJizbs0iwRbTGMrnqEXrL3-__IjOQxdULPdZwGdKFSXJ1DZYIj6xmWPBZxerdk=@willsroot.io> <CAM0EoMke7ar8O=aJeZy7_XYMGbgES-X2B19R83Qcihxv4OeG8g@mail.gmail.com> <0x7zdcWIGm0NWid6NxFLpYOtO0Z1g6UCzrNnyVZ6hRvWr5rU6b6hi5Yz8dD7_dyUOmvJfkR8LV2_TrDf7uACFgGshyfxiRWgxjWer41EZVY=@willsroot.io> <CAM0EoMmns+rSyg4h-WGAMewqYWx0-MYC1DtRyJe4=rbgZN2UKQ@mail.gmail.com> <99X_9_r0DXyyKP-0xVz3Bg2FFXhmpCsIdTix8J-a52alNswEyVRbhMFnzyT35EOUP-8TVPL-UDvBbOd8u5_jRE10A98e_ULf5x6GTv03tbg=@syst3mfailure.io> <CAM0EoMnCHu5HrNjE-mf8_OFanrptcTFgaEPJbkWXJybhm8f8tw@mail.gmail.com> <CAM0EoMk--+xXTf9ZG9M=r+gkRn2hczjqSTJRMV0dcgouJ4zw6g@mail.gmail.com> <CAM0EoMk4dxOFoN_=3yOy+XrtU=yvjJXAw3fVTmN9=M=R=vtbxA@mail.gmail.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: c75d47c9f0af90ba82342705fb8411b31c9b620a
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, June 2nd, 2025 at 9:39 PM, Jamal Hadi Salim <jhs@mojatatu.com> w=
rote:

>=20
>=20
> On Sat, May 31, 2025 at 11:38=E2=80=AFAM Jamal Hadi Salim jhs@mojatatu.co=
m wrote:
>=20
> > On Sat, May 31, 2025 at 11:23=E2=80=AFAM Jamal Hadi Salim jhs@mojatatu.=
com wrote:
> >=20
> > > On Sat, May 31, 2025 at 9:20=E2=80=AFAM Savy savy@syst3mfailure.io wr=
ote:
> > >=20
> > > > On Friday, May 30th, 2025 at 9:41 PM, Jamal Hadi Salim jhs@mojatatu=
.com wrote:
> > > >=20
> > > > > Hi Will,
> > > > >=20
> > > > > On Fri, May 30, 2025 at 10:49=E2=80=AFAM William Liu will@willsro=
ot.io wrote:
> > > > >=20
> > > > > > On Friday, May 30th, 2025 at 2:14 PM, Jamal Hadi Salim jhs@moja=
tatu.com wrote:
> > > > > >=20
> > > > > > > On Thu, May 29, 2025 at 11:23=E2=80=AFAM William Liu will@wil=
lsroot.io wrote:
> > > > > > >=20
> > > > > > > > On Wednesday, May 28th, 2025 at 10:00 PM, Jamal Hadi Salim =
jhs@mojatatu.com wrote:
> > > > > > > >=20
> > > > > > > > > Hi,
> > > > > > > > > Sorry for the latency..
> > > > > > > > >=20
> > > > > > > > > On Sun, May 25, 2025 at 4:43=E2=80=AFPM William Liu will@=
willsroot.io wrote:
> > > > > > > > >=20
> > > > > > > > > > I did some more testing with the percpu approach, and w=
e realized the following problem caused now by netem_dequeue.
> > > > > > > > > >=20
> > > > > > > > > > Recall that we increment the percpu variable on netem_e=
nqueue entry and decrement it on exit. netem_dequeue calls enqueue on the c=
hild qdisc - if this child qdisc is a netem qdisc with duplication enabled,=
 it could duplicate a previously duplicated packet from the parent back to =
the parent, causing the issue again. The percpu variable cannot protect aga=
inst this case.
> > > > > > > > >=20
> > > > > > > > > I didnt follow why "percpu variable cannot protect agains=
t this case"
> > > > > > > > > - the enqueue and dequeue would be running on the same cp=
u, no?
> > > > > > > > > Also under what circumstances is the enqueue back to the =
root going to
> > > > > > > > > end up in calling dequeue? Did you test and hit this issu=
e or its just
> > > > > > > > > theory? Note: It doesnt matter what the source of the skb=
 is as long
> > > > > > > > > as it hits the netem enqueue.
> > > > > > > >=20
> > > > > > > > Yes, I meant that just using the percpu variable in enqueue=
 will not protect against the case for when dequeue calls enqueue on the ch=
ild. Because of the child netem with duplication enabled, packets already i=
nvolved in duplication will get sent back to the parent's tfifo queue, and =
then the current dequeue will remain stuck in the loop before hitting an OO=
M - refer to the paragraph starting with "In netem_dequeue, the parent nete=
m qdisc's t_len" in the first email for additional clarification. We need t=
o know whether a packet we dequeue has been involved in duplication - if it=
 has, we increment the percpu variable to inform the children netem qdiscs.
> > > > > > > >=20
> > > > > > > > Hopefully the following diagram can help elucidate the prob=
lem:
> > > > > > > >=20
> > > > > > > > Step 1: Initial enqueue of Packet A:
> > > > > > > >=20
> > > > > > > > +----------------------+
> > > > > > > > | Packet A |
> > > > > > > > +----------------------+
> > > > > > > > |
> > > > > > > > v
> > > > > > > > +-------------------------+
> > > > > > > > | netem_enqueue |
> > > > > > > > +-------------------------+
> > > > > > > > |
> > > > > > > > v
> > > > > > > > +-----------------------------------+
> > > > > > > > | Duplication Logic (percpu OK): |
> > > > > > > > | =3D> Packet A, Packet B (dup) |
> > > > > > > > +-----------------------------------+
> > > > > > > > | <- percpu variable for netem_enqueue
> > > > > > > > v prevents duplication of B
> > > > > > > > +-------------+
> > > > > > > > | tfifo queue |
> > > > > > > > | [A, B] |
> > > > > > > > +-------------+
> > > > > > > >=20
> > > > > > > > Step 2: netem_dequeue processes Packet B (or A)
> > > > > > > >=20
> > > > > > > > +-------------+
> > > > > > > > | tfifo queue |
> > > > > > > > | [A] |
> > > > > > > > +-------------+
> > > > > > > > |
> > > > > > > > v
> > > > > > > > +----------------------------------------+
> > > > > > > > | netem_dequeue pops B in tfifo_dequeue |
> > > > > > > > +----------------------------------------+
> > > > > > > > |
> > > > > > > > v
> > > > > > > > +--------------------------------------------+
> > > > > > > > | netem_enqueue to child qdisc (netem w/ dup)|
> > > > > > > > +--------------------------------------------+
> > > > > > > > | <- percpu variable in netem_enqueue prologue
> > > > > > > > | and epilogue does not stop this dup,
> > > > > > > > v does not know about previous dup involvement
> > > > > > > > +--------------------------------------------------------+
> > > > > > > > | Child qdisc duplicates B to root (original netem) as C |
> > > > > > > > +--------------------------------------------------------+
> > > > > > > > |
> > > > > > > > v
> > > > > > > >=20
> > > > > > > > Step 3: Packet C enters original root netem again
> > > > > > > >=20
> > > > > > > > +-------------------------+
> > > > > > > > | netem_enqueue (again) |
> > > > > > > > +-------------------------+
> > > > > > > > |
> > > > > > > > v
> > > > > > > > +-------------------------------------+
> > > > > > > > | Duplication Logic (percpu OK again) |
> > > > > > > > | =3D> Packet C, Packet D |
> > > > > > > > +-------------------------------------+
> > > > > > > > |
> > > > > > > > v
> > > > > > > > .....
> > > > > > > >=20
> > > > > > > > If you increment a percpu variable in enqueue prologue and =
decrement in enqueue epilogue, you will notice that our original repro will=
 still trigger a loop because of the scenario I pointed out above - this ha=
s been tested.
> > > > > > > >=20
> > > > > > > > From a current view of the codebase, netem is the only qdis=
c that calls enqueue on its child from its dequeue. The check we propose wi=
ll only work if this invariant remains.
> > > > > > > >=20
> > > > > > > > > > However, there is a hack to address this. We can add a =
field in netem_skb_cb called duplicated to track if a packet is involved in=
 duplicated (both the original and duplicated packet should have it marked)=
. Right before we call the child enqueue in netem_dequeue, we check for the=
 duplicated value. If it is true, we increment the percpu variable before a=
nd decrement it after the child enqueue call.
> > > > > > > > >=20
> > > > > > > > > is netem_skb_cb safe really for hierarchies? grep for qdi=
sc_skb_cb
> > > > > > > > > net/sched/ to see what i mean
> > > > > > > >=20
> > > > > > > > We are not using it for cross qdisc hierarchy checking. We =
are only using it to inform a netem dequeue whether the packet has partaken=
 in duplication from its corresponding netem enqueue. That part seems to be=
 private data for the sk_buff residing in the current qdisc, so my understa=
nding is that it's ok.
> > > > > > > >=20
> > > > > > > > > > This only works under the assumption that there aren't =
other qdiscs that call enqueue on their child during dequeue, which seems t=
o be the case for now. And honestly, this is quite a fragile fix - there mi=
ght be other edge cases that will cause problems later down the line.
> > > > > > > > > >=20
> > > > > > > > > > Are you aware of other more elegant approaches we can t=
ry for us to track this required cross-qdisc state? We suggested adding a s=
ingle bit to the skb, but we also see the problem with adding a field for a=
 one-off use case to such a vital structure (but this would also completely=
 stomp out this bug).
> > > > > > > > >=20
> > > > > > > > > It sounds like quite a complicated approach - i dont know=
 what the
> > > > > > > > > dequeue thing brings to the table; and if we really have =
to dequeue to
> > > > > > > >=20
> > > > > > > > Did what I say above help clarify what the problem is? Feel=
 free to let me know if you have more questions, this bug is quite a nasty =
one.
> > > > > > >=20
> > > > > > > The text helped a bit, but send a tc reproducer of the issue =
you
> > > > > > > described to help me understand better how you end up in the =
tfifo
> > > > > > > which then calls the enqueu, etc, etc.
> > > > > >=20
> > > > > > The reproducer is the same as the original reproducer we report=
ed:
> > > > > > tc qdisc add dev lo root handle 1: netem limit 1 duplicate 100%
> > > > > > tc qdisc add dev lo parent 1: handle 2: netem gap 1 limit 1 dup=
licate 100% delay 1us reorder 100%
> > > > > > ping -I lo -f -c1 -s48 -W0.001 127.0.0.1
> > > > > >=20
> > > > > > We walked through the issue in the codepath in the first email =
of this thread at the paragraph starting with "The root cause for this is c=
omplex. Because of the way we setup the parent qdisc" - please let me know =
if any additional clarification is needed for any part of it.
> > > > >=20
> > > > > Ok, so I tested both your approach and a slight modification of t=
he
> > > > > variant I sent you. They both fix the issue. TBH, I still find yo=
ur
> > > > > approach complex. While i hate to do this to you, my preference i=
s
> > > > > that you use the attached version - i dont need the credit, so ju=
st
> > > > > send it formally after testing.
> > > > >=20
> > > > > cheers,
> > > > > jamal
> > > >=20
> > > > Hi Jamal,
> > > >=20
> > > > Thank you for your patch. Unfortunately, there is an issue that Wil=
l and I
> > > > also encountered when we submitted the first version of our patch.
> > > >=20
> > > > With this check:
> > > >=20
> > > > if (unlikely(nest_level > 1)) {
> > > > net_warn_ratelimited("Exceeded netem recursion %d > 1 on dev %s\n",
> > > > nest_level, netdev_name(skb->dev));
> > > > // ...
> > > > }
> > > >=20
> > > > when netem_enqueue is called, we have:
> > > >=20
> > > > netem_enqueue()
> > > > // nest_level is incremented to 1
> > > > // q->duplicate is 100% (0xFFFFFFFF)
> > > > // skb2 =3D skb_clone()
> > > > // rootq->enqueue(skb2, ...)
> > > > netem_enqueue()
> > > > // nest_level is incremented to 2
> > > > // nest_level now is > 1
> > > > // The duplicate is dropped
> > > >=20
> > > > Basically, with this approach, all duplicates are automatically dro=
pped.
> > > >=20
> > > > If we modify the check by replacing 1 with 2:
> > > >=20
> > > > if (unlikely(nest_level > 2)) {
> > > > net_warn_ratelimited("Exceeded netem recursion %d > 1 on dev %s\n",
> > > > nest_level, netdev_name(skb->dev));
> > > > // ...
> > > > }
> > > >=20
> > > > the infinite loop is triggered again (this has been tested and also=
 verified in GDB).
> > > >=20
> > > > This is why we proposed an alternative approach, but I understand i=
t is more complex.
> > > > Maybe we can try to work on that and make it more elegant.
> > >=20
> > > I am not sure.
> > > It is a choice between complexity to "fix" something that is a bad
> > > configuration, i.e one that should not be allowed to begin with, vs
> > > not burdening the rest.
> > > IOW, if you created a single loop(like the original report) the
> > > duplicate packet will go through but subsequent ones will not). If yo=
u
> > > created a loop inside a loop(as you did here), does anyone really car=
e
> > > about the duplicate in each loop not making it through? It would be
> > > fine to "fix it" so you get duplicates in each loop if there was
> > > actually a legitimate use case. Remember one of the original choices
> > > was to disallow the config ...
> >=20
> > Actually I think i misunderstood you. You are saying it breaks even
> > the working case for duplication.
> > Let me think about it..
>=20
>=20
> After some thought and experimentation - I believe the only way to fix
> this so nobody comes back in the future with loops is to disallow the
> netem on top of netem setup. The cb approach can be circumvented by
> zeroing the cb at the root.
>=20
> cheers,
> jamal

Doesn't the cb zeroing only happen upon reset, which should be fine?

I agree that the strategy you propose would be more durable.  We would have=
 to prevent setups of the form:

qdisc 0 ... qdisc i, netem, qdisc i + 1, ... qdisc j, netem, ...

Netem qdiscs can be identified through the netem_qdisc_ops pointer.

We would also have to check this property on qdisc insertion and replacemen=
t. I'm assuming the traversal can be done with the walk/leaf handlers.

Are there other things we are missing?

