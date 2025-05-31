Return-Path: <netdev+bounces-194506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFB7AC9B24
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 15:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 325D57AC250
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 13:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEF4238D56;
	Sat, 31 May 2025 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=syst3mfailure.io header.i=@syst3mfailure.io header.b="VwB4bMlO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch [79.135.106.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C004847B
	for <netdev@vger.kernel.org>; Sat, 31 May 2025 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748697645; cv=none; b=bEBxYu0CvPWK+NCumU/pcsydVjVNk8OtBb4ETRT1aSGNt1jnHETGceZeoGvk2limSz475vBRTvdqme6OzkUygrjHbfud/camcFdBTG6GI12hSvFaEL+UJO91lj3SQD01r92FRNjo3GYjbGc9hhWUjdf05YAl7Uy7oqZTVoiDgbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748697645; c=relaxed/simple;
	bh=EhFu1xz+eyfz7o9b8zICGWYUVLg/x5+iAPtR6069yWA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYMCwnuQ6/q45q1AAD0OIpZ+tb0y755/WPpHOuVLzCc9f7vDLvKDq1sjmd/nvhLWNoueT7ANEO9vXfO9MJ8gH1E9Y3eywzCb0+jmPJF3JtEJ0sFdM1GqOn/kukyTWlokMrc2XtDG1SOXXK8uHv+dW/5WO/hur8mGXa0bjlR0HVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=syst3mfailure.io; spf=pass smtp.mailfrom=syst3mfailure.io; dkim=pass (2048-bit key) header.d=syst3mfailure.io header.i=@syst3mfailure.io header.b=VwB4bMlO; arc=none smtp.client-ip=79.135.106.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=syst3mfailure.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syst3mfailure.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syst3mfailure.io;
	s=protonmail2; t=1748697633; x=1748956833;
	bh=pTlgnV8+5Am4daUUNwH25Phj7MAdDVNFgvTrbdslzug=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=VwB4bMlORs+E6jUJBQ6JAPMfvON5WgIbsC3WPQW44gVHniUBVqcfJOfy1qE4qmMYl
	 mEzosi06GL0nd+Rjv29mvrH2QXEKPRSEP/TtqhWVSSRBpfcWFtBdoq3atJa6XBjEiZ
	 23riR7taAVVQUWol96Ovg15+Mk4AboHL2XWP8f0+hFoLNRNQnuRHO1/nc3ZL7LA6Pf
	 YG/06IYILYbZmpxQ4kAj6wTRjwC2BEI7kZgRYCjSfIeugaCHbf9HPCw09+vbefWo6u
	 bq+iy9E6WKvEnk+hnSc5zpGfL1pCPSWxzXdivJ32U2S0YRm9F6RA8RwQg9PUBx7AMF
	 BeXdfBoIBpMWw==
Date: Sat, 31 May 2025 13:20:30 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: Savy <savy@syst3mfailure.io>
Cc: William Liu <will@willsroot.io>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
Message-ID: <99X_9_r0DXyyKP-0xVz3Bg2FFXhmpCsIdTix8J-a52alNswEyVRbhMFnzyT35EOUP-8TVPL-UDvBbOd8u5_jRE10A98e_ULf5x6GTv03tbg=@syst3mfailure.io>
In-Reply-To: <CAM0EoMmns+rSyg4h-WGAMewqYWx0-MYC1DtRyJe4=rbgZN2UKQ@mail.gmail.com>
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io> <CAM0EoMkO0vZ4ZtODLJEBP5FiA0+ofVNOSf-BxCOGOyWAZDHdTg@mail.gmail.com> <FiSC_W4LweZiirPYQVe8p7CvUePHrufeDOQgkDT07zh-uy5s6eah-a8Vtr_lPrW73PAF51p6PPIrJITwrJ5vspk99wI5uZELnJijU5ILMUQ=@willsroot.io> <q7G0Z7oMR2x9TWwNHOiPNsZ8lHzAuXuVgrZgGmAgkH8lkIYyTgeqXwcDrelE_fdS9OdJ4TlfS96px6O9SvnmKigNKFkiaFlStvAGPIJ3b84=@willsroot.io> <CAM0EoMnmpjGVU2XyrH=p=-BY6JGU44qsqyfEik4g5E2M8rMMOQ@mail.gmail.com> <DISZZlS5CdbUKITzkIyT3jki3inTWSMecT6FplNmkpYs9bJizbs0iwRbTGMrnqEXrL3-__IjOQxdULPdZwGdKFSXJ1DZYIj6xmWPBZxerdk=@willsroot.io> <CAM0EoMke7ar8O=aJeZy7_XYMGbgES-X2B19R83Qcihxv4OeG8g@mail.gmail.com> <0x7zdcWIGm0NWid6NxFLpYOtO0Z1g6UCzrNnyVZ6hRvWr5rU6b6hi5Yz8dD7_dyUOmvJfkR8LV2_TrDf7uACFgGshyfxiRWgxjWer41EZVY=@willsroot.io> <CAM0EoMmns+rSyg4h-WGAMewqYWx0-MYC1DtRyJe4=rbgZN2UKQ@mail.gmail.com>
Feedback-ID: 69690694:user:proton
X-Pm-Message-ID: 5344209591503951fd7cf0f7740cb22e2fd38f28
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, May 30th, 2025 at 9:41 PM, Jamal Hadi Salim <jhs@mojatatu.com> w=
rote:

>=20
>=20
> Hi Will,
>=20
> On Fri, May 30, 2025 at 10:49=E2=80=AFAM William Liu will@willsroot.io wr=
ote:
>=20
> > On Friday, May 30th, 2025 at 2:14 PM, Jamal Hadi Salim jhs@mojatatu.com=
 wrote:
> >=20
> > > On Thu, May 29, 2025 at 11:23=E2=80=AFAM William Liu will@willsroot.i=
o wrote:
> > >=20
> > > > On Wednesday, May 28th, 2025 at 10:00 PM, Jamal Hadi Salim jhs@moja=
tatu.com wrote:
> > > >=20
> > > > > Hi,
> > > > > Sorry for the latency..
> > > > >=20
> > > > > On Sun, May 25, 2025 at 4:43=E2=80=AFPM William Liu will@willsroo=
t.io wrote:
> > > > >=20
> > > > > > I did some more testing with the percpu approach, and we realiz=
ed the following problem caused now by netem_dequeue.
> > > > > >=20
> > > > > > Recall that we increment the percpu variable on netem_enqueue e=
ntry and decrement it on exit. netem_dequeue calls enqueue on the child qdi=
sc - if this child qdisc is a netem qdisc with duplication enabled, it coul=
d duplicate a previously duplicated packet from the parent back to the pare=
nt, causing the issue again. The percpu variable cannot protect against thi=
s case.
> > > > >=20
> > > > > I didnt follow why "percpu variable cannot protect against this c=
ase"
> > > > > - the enqueue and dequeue would be running on the same cpu, no?
> > > > > Also under what circumstances is the enqueue back to the root goi=
ng to
> > > > > end up in calling dequeue? Did you test and hit this issue or its=
 just
> > > > > theory? Note: It doesnt matter what the source of the skb is as l=
ong
> > > > > as it hits the netem enqueue.
> > > >=20
> > > > Yes, I meant that just using the percpu variable in enqueue will no=
t protect against the case for when dequeue calls enqueue on the child. Bec=
ause of the child netem with duplication enabled, packets already involved =
in duplication will get sent back to the parent's tfifo queue, and then the=
 current dequeue will remain stuck in the loop before hitting an OOM - refe=
r to the paragraph starting with "In netem_dequeue, the parent netem qdisc'=
s t_len" in the first email for additional clarification. We need to know w=
hether a packet we dequeue has been involved in duplication - if it has, we=
 increment the percpu variable to inform the children netem qdiscs.
> > > >=20
> > > > Hopefully the following diagram can help elucidate the problem:
> > > >=20
> > > > Step 1: Initial enqueue of Packet A:
> > > >=20
> > > > +----------------------+
> > > > | Packet A |
> > > > +----------------------+
> > > > |
> > > > v
> > > > +-------------------------+
> > > > | netem_enqueue |
> > > > +-------------------------+
> > > > |
> > > > v
> > > > +-----------------------------------+
> > > > | Duplication Logic (percpu OK): |
> > > > | =3D> Packet A, Packet B (dup) |
> > > > +-----------------------------------+
> > > > | <- percpu variable for netem_enqueue
> > > > v prevents duplication of B
> > > > +-------------+
> > > > | tfifo queue |
> > > > | [A, B] |
> > > > +-------------+
> > > >=20
> > > > Step 2: netem_dequeue processes Packet B (or A)
> > > >=20
> > > > +-------------+
> > > > | tfifo queue |
> > > > | [A] |
> > > > +-------------+
> > > > |
> > > > v
> > > > +----------------------------------------+
> > > > | netem_dequeue pops B in tfifo_dequeue |
> > > > +----------------------------------------+
> > > > |
> > > > v
> > > > +--------------------------------------------+
> > > > | netem_enqueue to child qdisc (netem w/ dup)|
> > > > +--------------------------------------------+
> > > > | <- percpu variable in netem_enqueue prologue
> > > > | and epilogue does not stop this dup,
> > > > v does not know about previous dup involvement
> > > > +--------------------------------------------------------+
> > > > | Child qdisc duplicates B to root (original netem) as C |
> > > > +--------------------------------------------------------+
> > > > |
> > > > v
> > > >=20
> > > > Step 3: Packet C enters original root netem again
> > > >=20
> > > > +-------------------------+
> > > > | netem_enqueue (again) |
> > > > +-------------------------+
> > > > |
> > > > v
> > > > +-------------------------------------+
> > > > | Duplication Logic (percpu OK again) |
> > > > | =3D> Packet C, Packet D |
> > > > +-------------------------------------+
> > > > |
> > > > v
> > > > .....
> > > >=20
> > > > If you increment a percpu variable in enqueue prologue and decremen=
t in enqueue epilogue, you will notice that our original repro will still t=
rigger a loop because of the scenario I pointed out above - this has been t=
ested.
> > > >=20
> > > > From a current view of the codebase, netem is the only qdisc that c=
alls enqueue on its child from its dequeue. The check we propose will only =
work if this invariant remains.
> > > >=20
> > > > > > However, there is a hack to address this. We can add a field in=
 netem_skb_cb called duplicated to track if a packet is involved in duplica=
ted (both the original and duplicated packet should have it marked). Right =
before we call the child enqueue in netem_dequeue, we check for the duplica=
ted value. If it is true, we increment the percpu variable before and decre=
ment it after the child enqueue call.
> > > > >=20
> > > > > is netem_skb_cb safe really for hierarchies? grep for qdisc_skb_c=
b
> > > > > net/sched/ to see what i mean
> > > >=20
> > > > We are not using it for cross qdisc hierarchy checking. We are only=
 using it to inform a netem dequeue whether the packet has partaken in dupl=
ication from its corresponding netem enqueue. That part seems to be private=
 data for the sk_buff residing in the current qdisc, so my understanding is=
 that it's ok.
> > > >=20
> > > > > > This only works under the assumption that there aren't other qd=
iscs that call enqueue on their child during dequeue, which seems to be the=
 case for now. And honestly, this is quite a fragile fix - there might be o=
ther edge cases that will cause problems later down the line.
> > > > > >=20
> > > > > > Are you aware of other more elegant approaches we can try for u=
s to track this required cross-qdisc state? We suggested adding a single bi=
t to the skb, but we also see the problem with adding a field for a one-off=
 use case to such a vital structure (but this would also completely stomp o=
ut this bug).
> > > > >=20
> > > > > It sounds like quite a complicated approach - i dont know what th=
e
> > > > > dequeue thing brings to the table; and if we really have to deque=
ue to
> > > >=20
> > > > Did what I say above help clarify what the problem is? Feel free to=
 let me know if you have more questions, this bug is quite a nasty one.
> > >=20
> > > The text helped a bit, but send a tc reproducer of the issue you
> > > described to help me understand better how you end up in the tfifo
> > > which then calls the enqueu, etc, etc.
> >=20
> > The reproducer is the same as the original reproducer we reported:
> > tc qdisc add dev lo root handle 1: netem limit 1 duplicate 100%
> > tc qdisc add dev lo parent 1: handle 2: netem gap 1 limit 1 duplicate 1=
00% delay 1us reorder 100%
> > ping -I lo -f -c1 -s48 -W0.001 127.0.0.1
> >=20
> > We walked through the issue in the codepath in the first email of this =
thread at the paragraph starting with "The root cause for this is complex. =
Because of the way we setup the parent qdisc" - please let me know if any a=
dditional clarification is needed for any part of it.
>=20
>=20
> Ok, so I tested both your approach and a slight modification of the
> variant I sent you. They both fix the issue. TBH, I still find your
> approach complex. While i hate to do this to you, my preference is
> that you use the attached version - i dont need the credit, so just
> send it formally after testing.
>=20
> cheers,
> jamal

Hi Jamal,

Thank you for your patch. Unfortunately, there is an issue that Will and I=
=20
also encountered when we submitted the first version of our patch.

With this check:

        if (unlikely(nest_level > 1)) {
                net_warn_ratelimited("Exceeded netem recursion %d > 1 on de=
v %s\n",
                                     nest_level, netdev_name(skb->dev));
                // ...
        }

when netem_enqueue is called, we have:

        netem_enqueue()         =20
                // nest_level is incremented to 1
                // q->duplicate is 100% (0xFFFFFFFF)
                // skb2 =3D skb_clone()
                // rootq->enqueue(skb2, ...)
                netem_enqueue()   =20
                        // nest_level is incremented to 2
                        // nest_level now is > 1
                        // The duplicate is dropped

Basically, with this approach, all duplicates are automatically dropped.

If we modify the check by replacing 1 with 2:

        if (unlikely(nest_level > 2)) {
                net_warn_ratelimited("Exceeded netem recursion %d > 1 on de=
v %s\n",
                                     nest_level, netdev_name(skb->dev));
                // ...
        }

the infinite loop is triggered again (this has been tested and also verifie=
d in GDB).

This is why we proposed an alternative approach, but I understand it is mor=
e complex.
Maybe we can try to work on that and make it more elegant.

Best,
Savy

