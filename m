Return-Path: <netdev+bounces-195747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF24AD2273
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68C43A6B76
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 15:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82528175D53;
	Mon,  9 Jun 2025 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="h8yzjWWA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9849E80B
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483082; cv=none; b=IvYWuyAmrPLgYLKwKpPqCHp4hq+5+DvLXXs5lEGY7HH2YzDIgGPx0K2cWMjV0ZRoldLSJMDLWxz4J00ydtSyAgiNd0K8M7H3PflZQyHMpJLEIAwSZH70lL46c6T+y33Ty3g582ojk2/5ekNq2lZQmM2p17P3QL+JV4Mib7XOfU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483082; c=relaxed/simple;
	bh=+gI4WFysFZjlgV6ypwE6lJ6ZhtJeMnd2aHUzs/WgDR8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPx+of5Nh18DmuCfm4dAT57EoBdU1bVsxbhd5mkZrbQ9Xz7GJXmjCNuw1Thru8D1WbN8F7e5TxP63vc88Zqj/v7tdtN/trDHvJsXQkj9cd5+X2PG4XubwkHBknzBdMajX76P/juTOUxqtRiygq1VN4QXN3g/6TUo5pRrSOT4JfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=h8yzjWWA; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1749483069; x=1749742269;
	bh=/t+EEE4TOe4mFnP4Npb2Jy7juoxPLME9TQE1T08yB/E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=h8yzjWWAJfzb492lKm7W4zUUIF9tsNOgLB9wQIhmnw8bJFdm2SDFdKgy4K1MRGxk/
	 /G6HIeHj5LePn2yRfdVMuM4tU6M131Y1Ss/GiaWOmcUQJHZplWceVKkAeJ0glQSBaC
	 zwPbc5AjJ/34tVyBqFUKKT21Wojd6Vl8LfGRGex0rl49d3ZFAWD9W12gN/cH0yd1zR
	 tnDAbG5fYXIfEc4tV/tRP2wIGRbcoFjFIiaPGUY+wcLVEtuYb07Argki1wT1arL1zI
	 8KTxswc0KP5PI699AYzrIUt8CtOm7AzqqpspXtXpFVncuCsCZE9kFdUTb64iEoQq3u
	 Jik8uwah5Rb2Q==
Date: Mon, 09 Jun 2025 15:31:03 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: William Liu <will@willsroot.io>
Cc: Savy <savy@syst3mfailure.io>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
Message-ID: <dF67hR5ZcMlQZMtkrUEol_zkunpoJipfdVXveT5z-3_g57e5T6TQZRYlluKWzRoNiW4dCl603wlnnYR8eE-alv6UwTf-F8o5GzHWuDsypj0=@willsroot.io>
In-Reply-To: <CAM0EoMmhP_9UsF18M=6B6AbY_am8cEnaqggpnVb9fkmBB4vjtA@mail.gmail.com>
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io> <99X_9_r0DXyyKP-0xVz3Bg2FFXhmpCsIdTix8J-a52alNswEyVRbhMFnzyT35EOUP-8TVPL-UDvBbOd8u5_jRE10A98e_ULf5x6GTv03tbg=@syst3mfailure.io> <CAM0EoMnCHu5HrNjE-mf8_OFanrptcTFgaEPJbkWXJybhm8f8tw@mail.gmail.com> <CAM0EoMk--+xXTf9ZG9M=r+gkRn2hczjqSTJRMV0dcgouJ4zw6g@mail.gmail.com> <CAM0EoMk4dxOFoN_=3yOy+XrtU=yvjJXAw3fVTmN9=M=R=vtbxA@mail.gmail.com> <lVH_UKrQzWPCHJS7_1Cj0gmEV0x4KI3VB_4auivP0fDokTBbmWuDV455wXrf6eQzakVFoK6wUxlDuMw_Lo0p4P9ByPLSjklsIkQiNcd_hvQ=@willsroot.io> <CAM0EoMkoFJJQD_ZVSMb7DUo1mafevgujx+WA=1ecTeYBcpB1Lw@mail.gmail.com> <A2nutOWbLBIdLRrnsUdavOagBEebp4YBFx0DdL23njEFVAySZul2pDRK1xf76_g6dLb82YXCRb1Ry9btDkZqeY9Btib0KgViSIIfsi4BDfU=@willsroot.io> <CAM0EoMmhP_9UsF18M=6B6AbY_am8cEnaqggpnVb9fkmBB4vjtA@mail.gmail.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 2484d51cf5d7ed3b91cb931defe4dc46950e41d2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, June 9th, 2025 at 12:27 PM, Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:

>=20
>=20
> On Sun, Jun 8, 2025 at 4:04=E2=80=AFPM William Liu will@willsroot.io wrot=
e:
>=20
> > On Sunday, June 8th, 2025 at 12:39 PM, Jamal Hadi Salim jhs@mojatatu.co=
m wrote:
> >=20
> > > On Thu, Jun 5, 2025 at 11:20=E2=80=AFAM William Liu will@willsroot.io=
 wrote:
> > >=20
> > > > On Monday, June 2nd, 2025 at 9:39 PM, Jamal Hadi Salim jhs@mojatatu=
.com wrote:
> > > >=20
> > > > > On Sat, May 31, 2025 at 11:38=E2=80=AFAM Jamal Hadi Salim jhs@moj=
atatu.com wrote:
> > > > >=20
> > > > > > On Sat, May 31, 2025 at 11:23=E2=80=AFAM Jamal Hadi Salim jhs@m=
ojatatu.com wrote:
> > > > > >=20
> > > > > > > On Sat, May 31, 2025 at 9:20=E2=80=AFAM Savy savy@syst3mfailu=
re.io wrote:
> > > > > > >=20
> > > > > > > > On Friday, May 30th, 2025 at 9:41 PM, Jamal Hadi Salim jhs@=
mojatatu.com wrote:
> > > > > > > >=20
> > > > > > > > > Hi Will,
> > > > > > > > >=20
> > > > > > > > > On Fri, May 30, 2025 at 10:49=E2=80=AFAM William Liu will=
@willsroot.io wrote:
> > > > > > > > >=20
> > > > > > > > > > On Friday, May 30th, 2025 at 2:14 PM, Jamal Hadi Salim =
jhs@mojatatu.com wrote:
> > > > > > > > > >=20
> > > > > > > > > > > On Thu, May 29, 2025 at 11:23=E2=80=AFAM William Liu =
will@willsroot.io wrote:
> > > > > > > > > > >=20
> > > > > > > > > > > > On Wednesday, May 28th, 2025 at 10:00 PM, Jamal Had=
i Salim jhs@mojatatu.com wrote:
> > > > > > > > > > > >=20
> > > > > > > > > > > > > Hi,
> > > > > > > > > > > > > Sorry for the latency..
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > On Sun, May 25, 2025 at 4:43=E2=80=AFPM William L=
iu will@willsroot.io wrote:
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > > I did some more testing with the percpu approac=
h, and we realized the following problem caused now by netem_dequeue.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Recall that we increment the percpu variable on=
 netem_enqueue entry and decrement it on exit. netem_dequeue calls enqueue =
on the child qdisc - if this child qdisc is a netem qdisc with duplication =
enabled, it could duplicate a previously duplicated packet from the parent =
back to the parent, causing the issue again. The percpu variable cannot pro=
tect against this case.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > I didnt follow why "percpu variable cannot protec=
t against this case"
> > > > > > > > > > > > > - the enqueue and dequeue would be running on the=
 same cpu, no?
> > > > > > > > > > > > > Also under what circumstances is the enqueue back=
 to the root going to
> > > > > > > > > > > > > end up in calling dequeue? Did you test and hit t=
his issue or its just
> > > > > > > > > > > > > theory? Note: It doesnt matter what the source of=
 the skb is as long
> > > > > > > > > > > > > as it hits the netem enqueue.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Yes, I meant that just using the percpu variable in=
 enqueue will not protect against the case for when dequeue calls enqueue o=
n the child. Because of the child netem with duplication enabled, packets a=
lready involved in duplication will get sent back to the parent's tfifo que=
ue, and then the current dequeue will remain stuck in the loop before hitti=
ng an OOM - refer to the paragraph starting with "In netem_dequeue, the par=
ent netem qdisc's t_len" in the first email for additional clarification. W=
e need to know whether a packet we dequeue has been involved in duplication=
 - if it has, we increment the percpu variable to inform the children netem=
 qdiscs.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Hopefully the following diagram can help elucidate =
the problem:
> > > > > > > > > > > >=20
> > > > > > > > > > > > Step 1: Initial enqueue of Packet A:
> > > > > > > > > > > >=20
> > > > > > > > > > > > +----------------------+
> > > > > > > > > > > > | Packet A |
> > > > > > > > > > > > +----------------------+
> > > > > > > > > > > > |
> > > > > > > > > > > > v
> > > > > > > > > > > > +-------------------------+
> > > > > > > > > > > > | netem_enqueue |
> > > > > > > > > > > > +-------------------------+
> > > > > > > > > > > > |
> > > > > > > > > > > > v
> > > > > > > > > > > > +-----------------------------------+
> > > > > > > > > > > > | Duplication Logic (percpu OK): |
> > > > > > > > > > > > | =3D> Packet A, Packet B (dup) |
> > > > > > > > > > > > +-----------------------------------+
> > > > > > > > > > > > | <- percpu variable for netem_enqueue
> > > > > > > > > > > > v prevents duplication of B
> > > > > > > > > > > > +-------------+
> > > > > > > > > > > > | tfifo queue |
> > > > > > > > > > > > | [A, B] |
> > > > > > > > > > > > +-------------+
> > > > > > > > > > > >=20
> > > > > > > > > > > > Step 2: netem_dequeue processes Packet B (or A)
> > > > > > > > > > > >=20
> > > > > > > > > > > > +-------------+
> > > > > > > > > > > > | tfifo queue |
> > > > > > > > > > > > | [A] |
> > > > > > > > > > > > +-------------+
> > > > > > > > > > > > |
> > > > > > > > > > > > v
> > > > > > > > > > > > +----------------------------------------+
> > > > > > > > > > > > | netem_dequeue pops B in tfifo_dequeue |
> > > > > > > > > > > > +----------------------------------------+
> > > > > > > > > > > > |
> > > > > > > > > > > > v
> > > > > > > > > > > > +--------------------------------------------+
> > > > > > > > > > > > | netem_enqueue to child qdisc (netem w/ dup)|
> > > > > > > > > > > > +--------------------------------------------+
> > > > > > > > > > > > | <- percpu variable in netem_enqueue prologue
> > > > > > > > > > > > | and epilogue does not stop this dup,
> > > > > > > > > > > > v does not know about previous dup involvement
> > > > > > > > > > > > +--------------------------------------------------=
------+
> > > > > > > > > > > > | Child qdisc duplicates B to root (original netem)=
 as C |
> > > > > > > > > > > > +--------------------------------------------------=
------+
> > > > > > > > > > > > |
> > > > > > > > > > > > v
> > > > > > > > > > > >=20
> > > > > > > > > > > > Step 3: Packet C enters original root netem again
> > > > > > > > > > > >=20
> > > > > > > > > > > > +-------------------------+
> > > > > > > > > > > > | netem_enqueue (again) |
> > > > > > > > > > > > +-------------------------+
> > > > > > > > > > > > |
> > > > > > > > > > > > v
> > > > > > > > > > > > +-------------------------------------+
> > > > > > > > > > > > | Duplication Logic (percpu OK again) |
> > > > > > > > > > > > | =3D> Packet C, Packet D |
> > > > > > > > > > > > +-------------------------------------+
> > > > > > > > > > > > |
> > > > > > > > > > > > v
> > > > > > > > > > > > .....
> > > > > > > > > > > >=20
> > > > > > > > > > > > If you increment a percpu variable in enqueue prolo=
gue and decrement in enqueue epilogue, you will notice that our original re=
pro will still trigger a loop because of the scenario I pointed out above -=
 this has been tested.
> > > > > > > > > > > >=20
> > > > > > > > > > > > From a current view of the codebase, netem is the o=
nly qdisc that calls enqueue on its child from its dequeue. The check we pr=
opose will only work if this invariant remains.
> > > > > > > > > > > >=20
> > > > > > > > > > > > > > However, there is a hack to address this. We ca=
n add a field in netem_skb_cb called duplicated to track if a packet is inv=
olved in duplicated (both the original and duplicated packet should have it=
 marked). Right before we call the child enqueue in netem_dequeue, we check=
 for the duplicated value. If it is true, we increment the percpu variable =
before and decrement it after the child enqueue call.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > is netem_skb_cb safe really for hierarchies? grep=
 for qdisc_skb_cb
> > > > > > > > > > > > > net/sched/ to see what i mean
> > > > > > > > > > > >=20
> > > > > > > > > > > > We are not using it for cross qdisc hierarchy check=
ing. We are only using it to inform a netem dequeue whether the packet has =
partaken in duplication from its corresponding netem enqueue. That part see=
ms to be private data for the sk_buff residing in the current qdisc, so my =
understanding is that it's ok.
> > > > > > > > > > > >=20
> > > > > > > > > > > > > > This only works under the assumption that there=
 aren't other qdiscs that call enqueue on their child during dequeue, which=
 seems to be the case for now. And honestly, this is quite a fragile fix - =
there might be other edge cases that will cause problems later down the lin=
e.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Are you aware of other more elegant approaches =
we can try for us to track this required cross-qdisc state? We suggested ad=
ding a single bit to the skb, but we also see the problem with adding a fie=
ld for a one-off use case to such a vital structure (but this would also co=
mpletely stomp out this bug).
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > It sounds like quite a complicated approach - i d=
ont know what the
> > > > > > > > > > > > > dequeue thing brings to the table; and if we real=
ly have to dequeue to
> > > > > > > > > > > >=20
> > > > > > > > > > > > Did what I say above help clarify what the problem =
is? Feel free to let me know if you have more questions, this bug is quite =
a nasty one.
> > > > > > > > > > >=20
> > > > > > > > > > > The text helped a bit, but send a tc reproducer of th=
e issue you
> > > > > > > > > > > described to help me understand better how you end up=
 in the tfifo
> > > > > > > > > > > which then calls the enqueu, etc, etc.
> > > > > > > > > >=20
> > > > > > > > > > The reproducer is the same as the original reproducer w=
e reported:
> > > > > > > > > > tc qdisc add dev lo root handle 1: netem limit 1 duplic=
ate 100%
> > > > > > > > > > tc qdisc add dev lo parent 1: handle 2: netem gap 1 lim=
it 1 duplicate 100% delay 1us reorder 100%
> > > > > > > > > > ping -I lo -f -c1 -s48 -W0.001 127.0.0.1
> > > > > > > > > >=20
> > > > > > > > > > We walked through the issue in the codepath in the firs=
t email of this thread at the paragraph starting with "The root cause for t=
his is complex. Because of the way we setup the parent qdisc" - please let =
me know if any additional clarification is needed for any part of it.
> > > > > > > > >=20
> > > > > > > > > Ok, so I tested both your approach and a slight modificat=
ion of the
> > > > > > > > > variant I sent you. They both fix the issue. TBH, I still=
 find your
> > > > > > > > > approach complex. While i hate to do this to you, my pref=
erence is
> > > > > > > > > that you use the attached version - i dont need the credi=
t, so just
> > > > > > > > > send it formally after testing.
> > > > > > > > >=20
> > > > > > > > > cheers,
> > > > > > > > > jamal
> > > > > > > >=20
> > > > > > > > Hi Jamal,
> > > > > > > >=20
> > > > > > > > Thank you for your patch. Unfortunately, there is an issue =
that Will and I
> > > > > > > > also encountered when we submitted the first version of our=
 patch.
> > > > > > > >=20
> > > > > > > > With this check:
> > > > > > > >=20
> > > > > > > > if (unlikely(nest_level > 1)) {
> > > > > > > > net_warn_ratelimited("Exceeded netem recursion %d > 1 on de=
v %s\n",
> > > > > > > > nest_level, netdev_name(skb->dev));
> > > > > > > > // ...
> > > > > > > > }
> > > > > > > >=20
> > > > > > > > when netem_enqueue is called, we have:
> > > > > > > >=20
> > > > > > > > netem_enqueue()
> > > > > > > > // nest_level is incremented to 1
> > > > > > > > // q->duplicate is 100% (0xFFFFFFFF)
> > > > > > > > // skb2 =3D skb_clone()
> > > > > > > > // rootq->enqueue(skb2, ...)
> > > > > > > > netem_enqueue()
> > > > > > > > // nest_level is incremented to 2
> > > > > > > > // nest_level now is > 1
> > > > > > > > // The duplicate is dropped
> > > > > > > >=20
> > > > > > > > Basically, with this approach, all duplicates are automatic=
ally dropped.
> > > > > > > >=20
> > > > > > > > If we modify the check by replacing 1 with 2:
> > > > > > > >=20
> > > > > > > > if (unlikely(nest_level > 2)) {
> > > > > > > > net_warn_ratelimited("Exceeded netem recursion %d > 1 on de=
v %s\n",
> > > > > > > > nest_level, netdev_name(skb->dev));
> > > > > > > > // ...
> > > > > > > > }
> > > > > > > >=20
> > > > > > > > the infinite loop is triggered again (this has been tested =
and also verified in GDB).
> > > > > > > >=20
> > > > > > > > This is why we proposed an alternative approach, but I unde=
rstand it is more complex.
> > > > > > > > Maybe we can try to work on that and make it more elegant.
> > > > > > >=20
> > > > > > > I am not sure.
> > > > > > > It is a choice between complexity to "fix" something that is =
a bad
> > > > > > > configuration, i.e one that should not be allowed to begin wi=
th, vs
> > > > > > > not burdening the rest.
> > > > > > > IOW, if you created a single loop(like the original report) t=
he
> > > > > > > duplicate packet will go through but subsequent ones will not=
). If you
> > > > > > > created a loop inside a loop(as you did here), does anyone re=
ally care
> > > > > > > about the duplicate in each loop not making it through? It wo=
uld be
> > > > > > > fine to "fix it" so you get duplicates in each loop if there =
was
> > > > > > > actually a legitimate use case. Remember one of the original =
choices
> > > > > > > was to disallow the config ...
> > > > > >=20
> > > > > > Actually I think i misunderstood you. You are saying it breaks =
even
> > > > > > the working case for duplication.
> > > > > > Let me think about it..
> > > > >=20
> > > > > After some thought and experimentation - I believe the only way t=
o fix
> > > > > this so nobody comes back in the future with loops is to disallow=
 the
> > > > > netem on top of netem setup. The cb approach can be circumvented =
by
> > > > > zeroing the cb at the root.
> > > > >=20
> > > > > cheers,
> > > > > jamal
> > > >=20
> > > > Doesn't the cb zeroing only happen upon reset, which should be fine=
?
> > >=20
> > > The root qdisc can be coerced to set values that could be zero. IMO,
> > > it is not fine for folks to come back in a few months and claim some
> > > prize because they managed to create the loop after this goes in. I a=
m
> > > certainly not interested in dealing with that...
> > > I wish we still had the 2 bit TTL in the skb, this would have been an
> > > easy fix[1].
> >=20
> > The loopy fun problem combined with this duplication issue maybe shows =
the need for us to get some bits in the sk_buff reserved for this case - th=
is is a security issue, as container/unprivileged users can trigger DOS.
> >=20
> > Regarding the size of sk_buff, at least when I tried this approach, the=
re was no increase in struct size. The slab allocator architecture wouldn't=
 cause increased memory consumption even if an extra byte were to be used. =
A robust fix here can future proof this subsystem against packet looping bu=
gs, so maybe this can be a consideration for later.
>=20
>=20
> There are approaches which alleviate these issues but i would argue
> the return on investment to remove those two bits has been extremely
> poor return on investment in terms of human hours invested for working
> around and fixing bugs. The "penny wise pound foolish" adage is a very
> apropos. Decisions like that work if you assume free labor.
> I dont think you will get far trying to restore those bits, so no
> point in trying.
>=20
> > > > I agree that the strategy you propose would be more durable. We wou=
ld have to prevent setups of the form:
> > > >=20
> > > > qdisc 0 ... qdisc i, netem, qdisc i + 1, ... qdisc j, netem, ...
> > > >=20
> > > > Netem qdiscs can be identified through the netem_qdisc_ops pointer.
> > > >=20
> > > > We would also have to check this property on qdisc insertion and re=
placement. I'm assuming the traversal can be done with the walk/leaf handle=
rs.
> > > >=20
> > > > Are there other things we are missing?
> > >=20
> > > Make it simple: Try to prevent the config of a new netem being added
> > > when one already exists at any hierarchy i.e dont bother checking if
> > > Can I assume you will work on this? Otherwise I or someone else can.
> >=20
> > Yep, I will give this a try in the coming days and will let you know if=
 I encounter any difficulties.
>=20
>=20
> I didnt finish my thought on that: I meant just dont allow a second
> netem to be added to a specific tree if one already exists. Dont
> bother checking for duplication.
>=20
> cheers,
> jamal
>=20
> > > [1] see "loopy fun" in https://lwn.net/Articles/719297/
> >=20
Hi Jamal,

I came up with the following fix last night to disallow adding a netem qdis=
c if one of its ancestral qdiscs is a netem. It's just a draft -I will clea=
n it up, move qdisc_match_from_root to sch_generic, add test cases, and sub=
mit a formal patchset for review if it looks good to you. Please let us kno=
w if you catch any edge cases or correctness issues we might be missing.=20

Also, please let us know if you would us to bring in fixes for the 2 other =
small issues we discussed previously - moving the duplication after the ini=
tial enqueue to more accurately respect the limit check, and having loss ta=
ke priority over duplication.

We tested with the following configurations, all of which are illegal now w=
hen we add the second netem (tc prints out RTNETLINK answers: Invalid argum=
ent).

Netem parent is netem:
tc qdisc add dev lo root handle 1: netem limit 1 duplicate 100%
tc qdisc add dev lo parent 1: handle 2: netem gap 1 limit 1 duplicate 100% =
delay 1us reorder 100%

Qdisc tree root is netem:
tc qdisc add dev lo root handle 1:0 netem limit 1 duplicate 100%
tc qdisc add dev lo parent 1:0 handle 2:0 hfsc
tc class add dev lo parent 2:0 classid 2:1 hfsc rt m2 10Mbit
tc qdisc add dev lo parent 2:1 handle 3:0 netem duplicate 100%
tc class add dev lo parent 2:0 classid 2:2 hfsc rt m2 10Mbit
tc qdisc add dev lo parent 2:2 handle 4:0 netem duplicate 100%

netem grandparent is netem:
tc qdisc add dev lo root handle 1:0 tbf rate 8bit burst 100b latency 1s
tc qdisc add dev lo parent 1:0 handle 2:0 netem gap 1 limit 1 duplicate 100=
% delay 1us reorder 100%
tc qdisc add dev lo parent 2:0 handle 3:0 hfsc
tc class add dev lo parent 3:0 classid 3:1 hfsc rt m2 10Mbit
tc qdisc add dev lo parent 3:1 handle 4:0 netem duplicate 100%

netem great-grandparent is netem:
tc qdisc add dev lo root handle 1:0 netem limit 1 duplicate 100%
tc qdisc add dev lo parent 1:0 handle 2:0 hfsc
tc class add dev lo parent 2:0 classid 2:1 hfsc rt m2 10Mbit
tc qdisc add dev lo parent 2:1 handle 3:0 tbf rate 8bit burst 100b latency =
1s
tc qdisc add dev lo parent 3:0 handle 4:0 netem duplicate 100%

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index fdd79d3ccd8c..6178cd1453c5 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -1085,6 +1085,52 @@ static int netem_change(struct Qdisc *sch, struct nl=
attr *opt,
        return ret;
 }
=20
+static const struct Qdisc_class_ops netem_class_ops;
+
+static struct Qdisc *qdisc_match_from_root(struct Qdisc *root, u32 handle)
+{
+       struct Qdisc *q;
+
+       if (!qdisc_dev(root))
+               return (root->handle =3D=3D handle ? root : NULL);
+
+       if (!(root->flags & TCQ_F_BUILTIN) &&
+           root->handle =3D=3D handle)
+               return root;
+
+       hash_for_each_possible_rcu(qdisc_dev(root)->qdisc_hash, q, hash, ha=
ndle,
+                                  lockdep_rtnl_is_held()) {
+               if (q->handle =3D=3D handle)
+                       return q;
+       }
+       return NULL;
+}
+
+static bool has_netem_ancestor(struct Qdisc *sch) {
+       struct Qdisc *root, *parent, *curr;
+       bool ret =3D false;
+
+       sch_tree_lock(sch);
+       curr =3D sch;
+       root =3D qdisc_root_sleeping(sch);
+       parent =3D qdisc_match_from_root(root, TC_H_MAJ(curr->parent));
+
+       while (parent !=3D NULL) {
+               if (parent->ops->cl_ops =3D=3D &netem_class_ops) {
+                       ret =3D true;
+                       pr_warn("Ancestral netem already exists, cannot nes=
t netem");
+                       goto unlock;
+               }
+
+               curr =3D parent;
+               parent =3D qdisc_match_from_root(root, TC_H_MAJ(curr->paren=
t));
+       }
+
+unlock:
+       sch_tree_unlock(sch);
+       return ret;
+}
+
 static int netem_init(struct Qdisc *sch, struct nlattr *opt,
                      struct netlink_ext_ack *extack)
 {
@@ -1093,6 +1139,9 @@ static int netem_init(struct Qdisc *sch, struct nlatt=
r *opt,
=20
        qdisc_watchdog_init(&q->watchdog, sch);
=20
+       if (has_netem_ancestor(sch))
+               return -EINVAL;
+
        if (!opt)
                return -EINVAL;
=20
@@ -1330,3 +1379,4 @@ module_init(netem_module_init)
 module_exit(netem_module_exit)
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Network characteristics emulator qdisc");

