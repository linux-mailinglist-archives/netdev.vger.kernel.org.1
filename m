Return-Path: <netdev+bounces-194372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA3EAC91CE
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 16:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395844E0BBE
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 14:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DAE22A4EE;
	Fri, 30 May 2025 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="E6+JUOBJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21B7227EBF
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748616578; cv=none; b=a5GYDyMeHn8sFZ9Jz4Rfy5CDPbZ0DJg8rj4m+/KvtCN++ObAhNWcUbp51lYOtaAZfbqOu8Rk40xZNvpvdX3qskmHrcin+seJ70MT3QGcZI7ucwusoryMr6APxNZaaHKls0HwpDm+rSadeLJIPzcdvHhG5+yZXQ7N6E4MnKt2xw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748616578; c=relaxed/simple;
	bh=g/BNaqiSjtqcikS1gL72/7TkfvoQzL16GZbZGThjGsc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVlmeLH6ArpeEjOv5OhPYDr+0jm88dQ2LueTLJ+5NkV0lyA6ywYv3RxDgHwl1bz4Wp3VQzJe9UCMEpcfS8cxLKFRq5q7xOa9dD3ERk3io1v2+imcre7OThl4BqZXqyASXFUbdLiWGgb9t0A8oj5q9MvWJQOoYO/vj2hYaAYfxSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=E6+JUOBJ; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1748616571; x=1748875771;
	bh=g/BNaqiSjtqcikS1gL72/7TkfvoQzL16GZbZGThjGsc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=E6+JUOBJyvmtYhOikhbYGGymUoH7bmnDXThNqZE1nMDSMvCO+ffp9kKk3zrc3CD53
	 KV5VYOuRbvR10keXxHqTR0zXjX8Uv9CKI+J+mesB2sVZPDb6LH+Z41vLNKx2PPG9Ev
	 IkeAdLsvX1Y24cYVP6ioT2iJ9pz2EZkDFyMocnO3+WgYk3fGux20/j3DLAB6cXBkSm
	 tMILLrHKnFtDVMRgjZ5ru4v3X1qYHVPeAkH27Ob12lPgcDQX8QWshFmUBezbdnac3r
	 cso+m1lU60K3j59++SA94V28/q03phv2GpnzQ2VZjGaKdyE+A4i1p15Uw9TCvZx1Dy
	 3VtGmSAjEJfig==
Date: Fri, 30 May 2025 14:49:25 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Savy <savy@syst3mfailure.io>, Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
Message-ID: <0x7zdcWIGm0NWid6NxFLpYOtO0Z1g6UCzrNnyVZ6hRvWr5rU6b6hi5Yz8dD7_dyUOmvJfkR8LV2_TrDf7uACFgGshyfxiRWgxjWer41EZVY=@willsroot.io>
In-Reply-To: <CAM0EoMke7ar8O=aJeZy7_XYMGbgES-X2B19R83Qcihxv4OeG8g@mail.gmail.com>
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io> <CAM0EoM==m_f3_DNgSEKODQzHgE_zyRpXKweNGw1mxz-e3u6+Hg@mail.gmail.com> <8fcsX7qgyK6tCGCqfi8RN7a-hMGfmh0K2wOpqXayxNM0lKgbjttNfpYkZHA29D0SN5WJ5h3-auiaClAq1nGw5BulC8wOzfa_lqR4bx73phM=@willsroot.io> <CAM0EoMkO0vZ4ZtODLJEBP5FiA0+ofVNOSf-BxCOGOyWAZDHdTg@mail.gmail.com> <FiSC_W4LweZiirPYQVe8p7CvUePHrufeDOQgkDT07zh-uy5s6eah-a8Vtr_lPrW73PAF51p6PPIrJITwrJ5vspk99wI5uZELnJijU5ILMUQ=@willsroot.io> <q7G0Z7oMR2x9TWwNHOiPNsZ8lHzAuXuVgrZgGmAgkH8lkIYyTgeqXwcDrelE_fdS9OdJ4TlfS96px6O9SvnmKigNKFkiaFlStvAGPIJ3b84=@willsroot.io> <CAM0EoMnmpjGVU2XyrH=p=-BY6JGU44qsqyfEik4g5E2M8rMMOQ@mail.gmail.com> <DISZZlS5CdbUKITzkIyT3jki3inTWSMecT6FplNmkpYs9bJizbs0iwRbTGMrnqEXrL3-__IjOQxdULPdZwGdKFSXJ1DZYIj6xmWPBZxerdk=@willsroot.io> <CAM0EoMke7ar8O=aJeZy7_XYMGbgES-X2B19R83Qcihxv4OeG8g@mail.gmail.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 02127b19084ed9a4e708ea1210b375785382302a
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, May 30th, 2025 at 2:14 PM, Jamal Hadi Salim <jhs@mojatatu.com> w=
rote:

>=20
>=20
> On Thu, May 29, 2025 at 11:23=E2=80=AFAM William Liu will@willsroot.io wr=
ote:
>=20
> > On Wednesday, May 28th, 2025 at 10:00 PM, Jamal Hadi Salim jhs@mojatatu=
.com wrote:
> >=20
> > > Hi,
> > > Sorry for the latency..
> > >=20
> > > On Sun, May 25, 2025 at 4:43=E2=80=AFPM William Liu will@willsroot.io=
 wrote:
> > >=20
> > > > I did some more testing with the percpu approach, and we realized t=
he following problem caused now by netem_dequeue.
> > > >=20
> > > > Recall that we increment the percpu variable on netem_enqueue entry=
 and decrement it on exit. netem_dequeue calls enqueue on the child qdisc -=
 if this child qdisc is a netem qdisc with duplication enabled, it could du=
plicate a previously duplicated packet from the parent back to the parent, =
causing the issue again. The percpu variable cannot protect against this ca=
se.
> > >=20
> > > I didnt follow why "percpu variable cannot protect against this case"
> > > - the enqueue and dequeue would be running on the same cpu, no?
> > > Also under what circumstances is the enqueue back to the root going t=
o
> > > end up in calling dequeue? Did you test and hit this issue or its jus=
t
> > > theory? Note: It doesnt matter what the source of the skb is as long
> > > as it hits the netem enqueue.
> >=20
> > Yes, I meant that just using the percpu variable in enqueue will not pr=
otect against the case for when dequeue calls enqueue on the child. Because=
 of the child netem with duplication enabled, packets already involved in d=
uplication will get sent back to the parent's tfifo queue, and then the cur=
rent dequeue will remain stuck in the loop before hitting an OOM - refer to=
 the paragraph starting with "In netem_dequeue, the parent netem qdisc's t_=
len" in the first email for additional clarification. We need to know wheth=
er a packet we dequeue has been involved in duplication - if it has, we inc=
rement the percpu variable to inform the children netem qdiscs.
> >=20
> > Hopefully the following diagram can help elucidate the problem:
> >=20
> > Step 1: Initial enqueue of Packet A:
> >=20
> > +----------------------+
> > | Packet A |
> > +----------------------+
> > |
> > v
> > +-------------------------+
> > | netem_enqueue |
> > +-------------------------+
> > |
> > v
> > +-----------------------------------+
> > | Duplication Logic (percpu OK): |
> > | =3D> Packet A, Packet B (dup) |
> > +-----------------------------------+
> > | <- percpu variable for netem_enqueue
> > v prevents duplication of B
> > +-------------+
> > | tfifo queue |
> > | [A, B] |
> > +-------------+
> >=20
> > Step 2: netem_dequeue processes Packet B (or A)
> >=20
> > +-------------+
> > | tfifo queue |
> > | [A] |
> > +-------------+
> > |
> > v
> > +----------------------------------------+
> > | netem_dequeue pops B in tfifo_dequeue |
> > +----------------------------------------+
> > |
> > v
> > +--------------------------------------------+
> > | netem_enqueue to child qdisc (netem w/ dup)|
> > +--------------------------------------------+
> > | <- percpu variable in netem_enqueue prologue
> > | and epilogue does not stop this dup,
> > v does not know about previous dup involvement
> > +--------------------------------------------------------+
> > | Child qdisc duplicates B to root (original netem) as C |
> > +--------------------------------------------------------+
> > |
> > v
> >=20
> > Step 3: Packet C enters original root netem again
> >=20
> > +-------------------------+
> > | netem_enqueue (again) |
> > +-------------------------+
> > |
> > v
> > +-------------------------------------+
> > | Duplication Logic (percpu OK again) |
> > | =3D> Packet C, Packet D |
> > +-------------------------------------+
> > |
> > v
> > .....
> >=20
> > If you increment a percpu variable in enqueue prologue and decrement in=
 enqueue epilogue, you will notice that our original repro will still trigg=
er a loop because of the scenario I pointed out above - this has been teste=
d.
> >=20
> > From a current view of the codebase, netem is the only qdisc that calls=
 enqueue on its child from its dequeue. The check we propose will only work=
 if this invariant remains.
> >=20
> > > > However, there is a hack to address this. We can add a field in net=
em_skb_cb called duplicated to track if a packet is involved in duplicated =
(both the original and duplicated packet should have it marked). Right befo=
re we call the child enqueue in netem_dequeue, we check for the duplicated =
value. If it is true, we increment the percpu variable before and decrement=
 it after the child enqueue call.
> > >=20
> > > is netem_skb_cb safe really for hierarchies? grep for qdisc_skb_cb
> > > net/sched/ to see what i mean
> >=20
> > We are not using it for cross qdisc hierarchy checking. We are only usi=
ng it to inform a netem dequeue whether the packet has partaken in duplicat=
ion from its corresponding netem enqueue. That part seems to be private dat=
a for the sk_buff residing in the current qdisc, so my understanding is tha=
t it's ok.
> >=20
> > > > This only works under the assumption that there aren't other qdiscs=
 that call enqueue on their child during dequeue, which seems to be the cas=
e for now. And honestly, this is quite a fragile fix - there might be other=
 edge cases that will cause problems later down the line.
> > > >=20
> > > > Are you aware of other more elegant approaches we can try for us to=
 track this required cross-qdisc state? We suggested adding a single bit to=
 the skb, but we also see the problem with adding a field for a one-off use=
 case to such a vital structure (but this would also completely stomp out t=
his bug).
> > >=20
> > > It sounds like quite a complicated approach - i dont know what the
> > > dequeue thing brings to the table; and if we really have to dequeue t=
o
> >=20
> > Did what I say above help clarify what the problem is? Feel free to let=
 me know if you have more questions, this bug is quite a nasty one.
>=20
>=20
> The text helped a bit, but send a tc reproducer of the issue you
> described to help me understand better how you end up in the tfifo
> which then calls the enqueu, etc, etc.

The reproducer is the same as the original reproducer we reported:
tc qdisc add dev lo root handle 1: netem limit 1 duplicate 100%
tc qdisc add dev lo parent 1: handle 2: netem gap 1 limit 1 duplicate 100% =
delay 1us reorder 100%
ping -I lo -f -c1 -s48 -W0.001 127.0.0.1

We walked through the issue in the codepath in the first email of this thre=
ad at the paragraph starting with "The root cause for this is complex. Beca=
use of the way we setup the parent qdisc" - please let me know if any addit=
ional clarification is needed for any part of it.

Best,
Will

