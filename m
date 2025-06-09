Return-Path: <netdev+bounces-195841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B05AD270E
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9812316F34D
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 19:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865FC21CFEF;
	Mon,  9 Jun 2025 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="y0H9oSCr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ED421D3DF
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749498965; cv=none; b=i40OfIdnLDycEQbpIpTGDEW+uWQ0vFAIXNyES8GJgT0LUG1uR1V3O/u16nD3LuC8ml4fEQh3Jpgn9lISic5blBZRk1q+jUeFC9WADedOSSCLXkmbgT0OWPpVga5djk2IQ+pba3ronYMfYL05Do3TBCTWauB9SckNCB+cw3Tn+LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749498965; c=relaxed/simple;
	bh=8MvQhCtyQUftmroV3OH0KT+bTE8cHFpM8MhHDg75R9k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjwCw3PvYQQ6LKzgQ1/PrNNRiETx69qMeF4Brnm//NdwwEn1kyW7j4LMNRqHF6jIKAHH0AGGKj9RUw3kngrMZoPJTiSslN6/iffr+3e1qrrP5/pfKgOCozoJzM0smtc92HPHvdbXQmrCStKwqQt7DsJAVc2S0YG3kCkbbyWMTJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=y0H9oSCr; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1749498952; x=1749758152;
	bh=rKvc6W73JHxvYSoajeybf+9gF8vUb98/ivMhYmzyIxo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=y0H9oSCr6P7YuwNvc0r5bcVFMeQzQ8W0mZarImttMnvm978mSVoKYx8KCEI8fKNbI
	 H25cADj3+iBbSc/W8DlJpTw6/QP8oWtrbfjBX5BXVZQ3dk08S2d5rKZ2D0sPyk94VQ
	 bxbyb7uKohPZ4bad0wAGyXpgvy0tj2ZSlNlWazpYPW7q4rMsaSjWwC1O2fJTOodBDA
	 pI0ZsQchHT9jhlNPTobq2R0sOaML1lQZ9JblR0gEr8cNrX5BRZCuK4oiSWH9aQf6EZ
	 2EkLOfI+HRj3ntFJ+yYS5FeNXKNydO+pWfZl/U63BhNIq1MSZ/sDGSK/etmOQxP0lV
	 tmXsUNexLhlYw==
Date: Mon, 09 Jun 2025 19:55:49 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: William Liu <will@willsroot.io>
Cc: Savy <savy@syst3mfailure.io>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
Message-ID: <xHNRt9BXhR1vk5BYygHc0KpzK2os-725E9Jgq4ycBo0hIcAknk2ewG_bidnYKmiIbfzaPcIjWPv6-5FQB_LWIhCmoZ7uz3y52pfrvV9MklI=@willsroot.io>
In-Reply-To: <dF67hR5ZcMlQZMtkrUEol_zkunpoJipfdVXveT5z-3_g57e5T6TQZRYlluKWzRoNiW4dCl603wlnnYR8eE-alv6UwTf-F8o5GzHWuDsypj0=@willsroot.io>
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io> <99X_9_r0DXyyKP-0xVz3Bg2FFXhmpCsIdTix8J-a52alNswEyVRbhMFnzyT35EOUP-8TVPL-UDvBbOd8u5_jRE10A98e_ULf5x6GTv03tbg=@syst3mfailure.io> <CAM0EoMnCHu5HrNjE-mf8_OFanrptcTFgaEPJbkWXJybhm8f8tw@mail.gmail.com> <CAM0EoMk--+xXTf9ZG9M=r+gkRn2hczjqSTJRMV0dcgouJ4zw6g@mail.gmail.com> <CAM0EoMk4dxOFoN_=3yOy+XrtU=yvjJXAw3fVTmN9=M=R=vtbxA@mail.gmail.com> <lVH_UKrQzWPCHJS7_1Cj0gmEV0x4KI3VB_4auivP0fDokTBbmWuDV455wXrf6eQzakVFoK6wUxlDuMw_Lo0p4P9ByPLSjklsIkQiNcd_hvQ=@willsroot.io> <CAM0EoMkoFJJQD_ZVSMb7DUo1mafevgujx+WA=1ecTeYBcpB1Lw@mail.gmail.com> <A2nutOWbLBIdLRrnsUdavOagBEebp4YBFx0DdL23njEFVAySZul2pDRK1xf76_g6dLb82YXCRb1Ry9btDkZqeY9Btib0KgViSIIfsi4BDfU=@willsroot.io> <CAM0EoMmhP_9UsF18M=6B6AbY_am8cEnaqggpnVb9fkmBB4vjtA@mail.gmail.com> <dF67hR5ZcMlQZMtkrUEol_zkunpoJipfdVXveT5z-3_g57e5T6TQZRYlluKWzRoNiW4dCl603wlnnYR8eE-alv6UwTf-F8o5GzHWuDsypj0=@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 473b78b39aa7a372219521083176f3de21fe6dc3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






On Monday, June 9th, 2025 at 3:31 PM, William Liu <will@willsroot.io> wrote=
:

>=20
>=20
> On Monday, June 9th, 2025 at 12:27 PM, Jamal Hadi Salim jhs@mojatatu.com =
wrote:
>=20
> > On Sun, Jun 8, 2025 at 4:04=E2=80=AFPM William Liu will@willsroot.io wr=
ote:
> >=20
> > > On Sunday, June 8th, 2025 at 12:39 PM, Jamal Hadi Salim jhs@mojatatu.=
com wrote:
> > >=20
> > > > On Thu, Jun 5, 2025 at 11:20=E2=80=AFAM William Liu will@willsroot.=
io wrote:
> > > >=20
> > > > > On Monday, June 2nd, 2025 at 9:39 PM, Jamal Hadi Salim jhs@mojata=
tu.com wrote:
> > > > >=20
> > > > > > On Sat, May 31, 2025 at 11:38=E2=80=AFAM Jamal Hadi Salim jhs@m=
ojatatu.com wrote:
> > > > > >=20
> > > > > > > On Sat, May 31, 2025 at 11:23=E2=80=AFAM Jamal Hadi Salim jhs=
@mojatatu.com wrote:
> > > > > > >=20
> > > > > > > > On Sat, May 31, 2025 at 9:20=E2=80=AFAM Savy savy@syst3mfai=
lure.io wrote:
> > > > > > > >=20
> > > > > > > > > On Friday, May 30th, 2025 at 9:41 PM, Jamal Hadi Salim jh=
s@mojatatu.com wrote:
> > > > > > > > >=20
> > > > > > > > > > Hi Will,
> > > > > > > > > >=20
> > > > > > > > > > On Fri, May 30, 2025 at 10:49=E2=80=AFAM William Liu wi=
ll@willsroot.io wrote:
> > > > > > > > > >=20
> > > > > > > > > > > On Friday, May 30th, 2025 at 2:14 PM, Jamal Hadi Sali=
m jhs@mojatatu.com wrote:
> > > > > > > > > > >=20
> > > > > > > > > > > > On Thu, May 29, 2025 at 11:23=E2=80=AFAM William Li=
u will@willsroot.io wrote:
> > > > > > > > > > > >=20
> > > > > > > > > > > > > On Wednesday, May 28th, 2025 at 10:00 PM, Jamal H=
adi Salim jhs@mojatatu.com wrote:
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Hi,
> > > > > > > > > > > > > > Sorry for the latency..
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > On Sun, May 25, 2025 at 4:43=E2=80=AFPM William=
 Liu will@willsroot.io wrote:
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > I did some more testing with the percpu appro=
ach, and we realized the following problem caused now by netem_dequeue.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Recall that we increment the percpu variable =
on netem_enqueue entry and decrement it on exit. netem_dequeue calls enqueu=
e on the child qdisc - if this child qdisc is a netem qdisc with duplicatio=
n enabled, it could duplicate a previously duplicated packet from the paren=
t back to the parent, causing the issue again. The percpu variable cannot p=
rotect against this case.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > I didnt follow why "percpu variable cannot prot=
ect against this case"
> > > > > > > > > > > > > > - the enqueue and dequeue would be running on t=
he same cpu, no?
> > > > > > > > > > > > > > Also under what circumstances is the enqueue ba=
ck to the root going to
> > > > > > > > > > > > > > end up in calling dequeue? Did you test and hit=
 this issue or its just
> > > > > > > > > > > > > > theory? Note: It doesnt matter what the source =
of the skb is as long
> > > > > > > > > > > > > > as it hits the netem enqueue.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Yes, I meant that just using the percpu variable =
in enqueue will not protect against the case for when dequeue calls enqueue=
 on the child. Because of the child netem with duplication enabled, packets=
 already involved in duplication will get sent back to the parent's tfifo q=
ueue, and then the current dequeue will remain stuck in the loop before hit=
ting an OOM - refer to the paragraph starting with "In netem_dequeue, the p=
arent netem qdisc's t_len" in the first email for additional clarification.=
 We need to know whether a packet we dequeue has been involved in duplicati=
on - if it has, we increment the percpu variable to inform the children net=
em qdiscs.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Hopefully the following diagram can help elucidat=
e the problem:
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Step 1: Initial enqueue of Packet A:
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > +----------------------+
> > > > > > > > > > > > > | Packet A |
> > > > > > > > > > > > > +----------------------+
> > > > > > > > > > > > > |
> > > > > > > > > > > > > v
> > > > > > > > > > > > > +-------------------------+
> > > > > > > > > > > > > | netem_enqueue |
> > > > > > > > > > > > > +-------------------------+
> > > > > > > > > > > > > |
> > > > > > > > > > > > > v
> > > > > > > > > > > > > +-----------------------------------+
> > > > > > > > > > > > > | Duplication Logic (percpu OK): |
> > > > > > > > > > > > > | =3D> Packet A, Packet B (dup) |
> > > > > > > > > > > > > +-----------------------------------+
> > > > > > > > > > > > > | <- percpu variable for netem_enqueue
> > > > > > > > > > > > > v prevents duplication of B
> > > > > > > > > > > > > +-------------+
> > > > > > > > > > > > > | tfifo queue |
> > > > > > > > > > > > > | [A, B] |
> > > > > > > > > > > > > +-------------+
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Step 2: netem_dequeue processes Packet B (or A)
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > +-------------+
> > > > > > > > > > > > > | tfifo queue |
> > > > > > > > > > > > > | [A] |
> > > > > > > > > > > > > +-------------+
> > > > > > > > > > > > > |
> > > > > > > > > > > > > v
> > > > > > > > > > > > > +----------------------------------------+
> > > > > > > > > > > > > | netem_dequeue pops B in tfifo_dequeue |
> > > > > > > > > > > > > +----------------------------------------+
> > > > > > > > > > > > > |
> > > > > > > > > > > > > v
> > > > > > > > > > > > > +--------------------------------------------+
> > > > > > > > > > > > > | netem_enqueue to child qdisc (netem w/ dup)|
> > > > > > > > > > > > > +--------------------------------------------+
> > > > > > > > > > > > > | <- percpu variable in netem_enqueue prologue
> > > > > > > > > > > > > | and epilogue does not stop this dup,
> > > > > > > > > > > > > v does not know about previous dup involvement
> > > > > > > > > > > > > +------------------------------------------------=
--------+
> > > > > > > > > > > > > | Child qdisc duplicates B to root (original nete=
m) as C |
> > > > > > > > > > > > > +------------------------------------------------=
--------+
> > > > > > > > > > > > > |
> > > > > > > > > > > > > v
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Step 3: Packet C enters original root netem again
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > +-------------------------+
> > > > > > > > > > > > > | netem_enqueue (again) |
> > > > > > > > > > > > > +-------------------------+
> > > > > > > > > > > > > |
> > > > > > > > > > > > > v
> > > > > > > > > > > > > +-------------------------------------+
> > > > > > > > > > > > > | Duplication Logic (percpu OK again) |
> > > > > > > > > > > > > | =3D> Packet C, Packet D |
> > > > > > > > > > > > > +-------------------------------------+
> > > > > > > > > > > > > |
> > > > > > > > > > > > > v
> > > > > > > > > > > > > .....
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > If you increment a percpu variable in enqueue pro=
logue and decrement in enqueue epilogue, you will notice that our original =
repro will still trigger a loop because of the scenario I pointed out above=
 - this has been tested.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > From a current view of the codebase, netem is the=
 only qdisc that calls enqueue on its child from its dequeue. The check we =
propose will only work if this invariant remains.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > However, there is a hack to address this. We =
can add a field in netem_skb_cb called duplicated to track if a packet is i=
nvolved in duplicated (both the original and duplicated packet should have =
it marked). Right before we call the child enqueue in netem_dequeue, we che=
ck for the duplicated value. If it is true, we increment the percpu variabl=
e before and decrement it after the child enqueue call.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > is netem_skb_cb safe really for hierarchies? gr=
ep for qdisc_skb_cb
> > > > > > > > > > > > > > net/sched/ to see what i mean
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > We are not using it for cross qdisc hierarchy che=
cking. We are only using it to inform a netem dequeue whether the packet ha=
s partaken in duplication from its corresponding netem enqueue. That part s=
eems to be private data for the sk_buff residing in the current qdisc, so m=
y understanding is that it's ok.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > This only works under the assumption that the=
re aren't other qdiscs that call enqueue on their child during dequeue, whi=
ch seems to be the case for now. And honestly, this is quite a fragile fix =
- there might be other edge cases that will cause problems later down the l=
ine.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Are you aware of other more elegant approache=
s we can try for us to track this required cross-qdisc state? We suggested =
adding a single bit to the skb, but we also see the problem with adding a f=
ield for a one-off use case to such a vital structure (but this would also =
completely stomp out this bug).
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > It sounds like quite a complicated approach - i=
 dont know what the
> > > > > > > > > > > > > > dequeue thing brings to the table; and if we re=
ally have to dequeue to
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Did what I say above help clarify what the proble=
m is? Feel free to let me know if you have more questions, this bug is quit=
e a nasty one.
> > > > > > > > > > > >=20
> > > > > > > > > > > > The text helped a bit, but send a tc reproducer of =
the issue you
> > > > > > > > > > > > described to help me understand better how you end =
up in the tfifo
> > > > > > > > > > > > which then calls the enqueu, etc, etc.
> > > > > > > > > > >=20
> > > > > > > > > > > The reproducer is the same as the original reproducer=
 we reported:
> > > > > > > > > > > tc qdisc add dev lo root handle 1: netem limit 1 dupl=
icate 100%
> > > > > > > > > > > tc qdisc add dev lo parent 1: handle 2: netem gap 1 l=
imit 1 duplicate 100% delay 1us reorder 100%
> > > > > > > > > > > ping -I lo -f -c1 -s48 -W0.001 127.0.0.1
> > > > > > > > > > >=20
> > > > > > > > > > > We walked through the issue in the codepath in the fi=
rst email of this thread at the paragraph starting with "The root cause for=
 this is complex. Because of the way we setup the parent qdisc" - please le=
t me know if any additional clarification is needed for any part of it.
> > > > > > > > > >=20
> > > > > > > > > > Ok, so I tested both your approach and a slight modific=
ation of the
> > > > > > > > > > variant I sent you. They both fix the issue. TBH, I sti=
ll find your
> > > > > > > > > > approach complex. While i hate to do this to you, my pr=
eference is
> > > > > > > > > > that you use the attached version - i dont need the cre=
dit, so just
> > > > > > > > > > send it formally after testing.
> > > > > > > > > >=20
> > > > > > > > > > cheers,
> > > > > > > > > > jamal
> > > > > > > > >=20
> > > > > > > > > Hi Jamal,
> > > > > > > > >=20
> > > > > > > > > Thank you for your patch. Unfortunately, there is an issu=
e that Will and I
> > > > > > > > > also encountered when we submitted the first version of o=
ur patch.
> > > > > > > > >=20
> > > > > > > > > With this check:
> > > > > > > > >=20
> > > > > > > > > if (unlikely(nest_level > 1)) {
> > > > > > > > > net_warn_ratelimited("Exceeded netem recursion %d > 1 on =
dev %s\n",
> > > > > > > > > nest_level, netdev_name(skb->dev));
> > > > > > > > > // ...
> > > > > > > > > }
> > > > > > > > >=20
> > > > > > > > > when netem_enqueue is called, we have:
> > > > > > > > >=20
> > > > > > > > > netem_enqueue()
> > > > > > > > > // nest_level is incremented to 1
> > > > > > > > > // q->duplicate is 100% (0xFFFFFFFF)
> > > > > > > > > // skb2 =3D skb_clone()
> > > > > > > > > // rootq->enqueue(skb2, ...)
> > > > > > > > > netem_enqueue()
> > > > > > > > > // nest_level is incremented to 2
> > > > > > > > > // nest_level now is > 1
> > > > > > > > > // The duplicate is dropped
> > > > > > > > >=20
> > > > > > > > > Basically, with this approach, all duplicates are automat=
ically dropped.
> > > > > > > > >=20
> > > > > > > > > If we modify the check by replacing 1 with 2:
> > > > > > > > >=20
> > > > > > > > > if (unlikely(nest_level > 2)) {
> > > > > > > > > net_warn_ratelimited("Exceeded netem recursion %d > 1 on =
dev %s\n",
> > > > > > > > > nest_level, netdev_name(skb->dev));
> > > > > > > > > // ...
> > > > > > > > > }
> > > > > > > > >=20
> > > > > > > > > the infinite loop is triggered again (this has been teste=
d and also verified in GDB).
> > > > > > > > >=20
> > > > > > > > > This is why we proposed an alternative approach, but I un=
derstand it is more complex.
> > > > > > > > > Maybe we can try to work on that and make it more elegant=
.
> > > > > > > >=20
> > > > > > > > I am not sure.
> > > > > > > > It is a choice between complexity to "fix" something that i=
s a bad
> > > > > > > > configuration, i.e one that should not be allowed to begin =
with, vs
> > > > > > > > not burdening the rest.
> > > > > > > > IOW, if you created a single loop(like the original report)=
 the
> > > > > > > > duplicate packet will go through but subsequent ones will n=
ot). If you
> > > > > > > > created a loop inside a loop(as you did here), does anyone =
really care
> > > > > > > > about the duplicate in each loop not making it through? It =
would be
> > > > > > > > fine to "fix it" so you get duplicates in each loop if ther=
e was
> > > > > > > > actually a legitimate use case. Remember one of the origina=
l choices
> > > > > > > > was to disallow the config ...
> > > > > > >=20
> > > > > > > Actually I think i misunderstood you. You are saying it break=
s even
> > > > > > > the working case for duplication.
> > > > > > > Let me think about it..
> > > > > >=20
> > > > > > After some thought and experimentation - I believe the only way=
 to fix
> > > > > > this so nobody comes back in the future with loops is to disall=
ow the
> > > > > > netem on top of netem setup. The cb approach can be circumvente=
d by
> > > > > > zeroing the cb at the root.
> > > > > >=20
> > > > > > cheers,
> > > > > > jamal
> > > > >=20
> > > > > Doesn't the cb zeroing only happen upon reset, which should be fi=
ne?
> > > >=20
> > > > The root qdisc can be coerced to set values that could be zero. IMO=
,
> > > > it is not fine for folks to come back in a few months and claim som=
e
> > > > prize because they managed to create the loop after this goes in. I=
 am
> > > > certainly not interested in dealing with that...
> > > > I wish we still had the 2 bit TTL in the skb, this would have been =
an
> > > > easy fix[1].
> > >=20
> > > The loopy fun problem combined with this duplication issue maybe show=
s the need for us to get some bits in the sk_buff reserved for this case - =
this is a security issue, as container/unprivileged users can trigger DOS.
> > >=20
> > > Regarding the size of sk_buff, at least when I tried this approach, t=
here was no increase in struct size. The slab allocator architecture wouldn=
't cause increased memory consumption even if an extra byte were to be used=
. A robust fix here can future proof this subsystem against packet looping =
bugs, so maybe this can be a consideration for later.
> >=20
> > There are approaches which alleviate these issues but i would argue
> > the return on investment to remove those two bits has been extremely
> > poor return on investment in terms of human hours invested for working
> > around and fixing bugs. The "penny wise pound foolish" adage is a very
> > apropos. Decisions like that work if you assume free labor.
> > I dont think you will get far trying to restore those bits, so no
> > point in trying.
> >=20
> > > > > I agree that the strategy you propose would be more durable. We w=
ould have to prevent setups of the form:
> > > > >=20
> > > > > qdisc 0 ... qdisc i, netem, qdisc i + 1, ... qdisc j, netem, ...
> > > > >=20
> > > > > Netem qdiscs can be identified through the netem_qdisc_ops pointe=
r.
> > > > >=20
> > > > > We would also have to check this property on qdisc insertion and =
replacement. I'm assuming the traversal can be done with the walk/leaf hand=
lers.
> > > > >=20
> > > > > Are there other things we are missing?
> > > >=20
> > > > Make it simple: Try to prevent the config of a new netem being adde=
d
> > > > when one already exists at any hierarchy i.e dont bother checking i=
f
> > > > Can I assume you will work on this? Otherwise I or someone else can=
.
> > >=20
> > > Yep, I will give this a try in the coming days and will let you know =
if I encounter any difficulties.
> >=20
> > I didnt finish my thought on that: I meant just dont allow a second
> > netem to be added to a specific tree if one already exists. Dont
> > bother checking for duplication.
> >=20
> > cheers,
> > jamal
> >=20
> > > > [1] see "loopy fun" in https://lwn.net/Articles/719297/
>=20
> Hi Jamal,
>=20
> I came up with the following fix last night to disallow adding a netem qd=
isc if one of its ancestral qdiscs is a netem. It's just a draft -I will cl=
ean it up, move qdisc_match_from_root to sch_generic, add test cases, and s=
ubmit a formal patchset for review if it looks good to you. Please let us k=
now if you catch any edge cases or correctness issues we might be missing.
>=20
> Also, please let us know if you would us to bring in fixes for the 2 othe=
r small issues we discussed previously - moving the duplication after the i=
nitial enqueue to more accurately respect the limit check, and having loss =
take priority over duplication.
>=20
> We tested with the following configurations, all of which are illegal now=
 when we add the second netem (tc prints out RTNETLINK answers: Invalid arg=
ument).
>=20
> Netem parent is netem:
> tc qdisc add dev lo root handle 1: netem limit 1 duplicate 100%
> tc qdisc add dev lo parent 1: handle 2: netem gap 1 limit 1 duplicate 100=
% delay 1us reorder 100%
>=20
> Qdisc tree root is netem:
> tc qdisc add dev lo root handle 1:0 netem limit 1 duplicate 100%
> tc qdisc add dev lo parent 1:0 handle 2:0 hfsc
> tc class add dev lo parent 2:0 classid 2:1 hfsc rt m2 10Mbit
> tc qdisc add dev lo parent 2:1 handle 3:0 netem duplicate 100%
> tc class add dev lo parent 2:0 classid 2:2 hfsc rt m2 10Mbit
> tc qdisc add dev lo parent 2:2 handle 4:0 netem duplicate 100%
>=20
> netem grandparent is netem:
> tc qdisc add dev lo root handle 1:0 tbf rate 8bit burst 100b latency 1s
> tc qdisc add dev lo parent 1:0 handle 2:0 netem gap 1 limit 1 duplicate 1=
00% delay 1us reorder 100%
> tc qdisc add dev lo parent 2:0 handle 3:0 hfsc
> tc class add dev lo parent 3:0 classid 3:1 hfsc rt m2 10Mbit
> tc qdisc add dev lo parent 3:1 handle 4:0 netem duplicate 100%
>=20
> netem great-grandparent is netem:
> tc qdisc add dev lo root handle 1:0 netem limit 1 duplicate 100%
> tc qdisc add dev lo parent 1:0 handle 2:0 hfsc
> tc class add dev lo parent 2:0 classid 2:1 hfsc rt m2 10Mbit
> tc qdisc add dev lo parent 2:1 handle 3:0 tbf rate 8bit burst 100b latenc=
y 1s
> tc qdisc add dev lo parent 3:0 handle 4:0 netem duplicate 100%
>=20
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index fdd79d3ccd8c..6178cd1453c5 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -1085,6 +1085,52 @@ static int netem_change(struct Qdisc *sch, struct =
nlattr *opt,
> return ret;
> }
>=20
> +static const struct Qdisc_class_ops netem_class_ops;
> +
> +static struct Qdisc *qdisc_match_from_root(struct Qdisc *root, u32 handl=
e)
> +{
> + struct Qdisc *q;
> +
> + if (!qdisc_dev(root))
> + return (root->handle =3D=3D handle ? root : NULL);
>=20
> +
> + if (!(root->flags & TCQ_F_BUILTIN) &&
>=20
> + root->handle =3D=3D handle)
>=20
> + return root;
> +
> + hash_for_each_possible_rcu(qdisc_dev(root)->qdisc_hash, q, hash, handle=
,
>=20
> + lockdep_rtnl_is_held()) {
> + if (q->handle =3D=3D handle)
>=20
> + return q;
> + }
> + return NULL;
> +}
> +
> +static bool has_netem_ancestor(struct Qdisc *sch) {
> + struct Qdisc *root, *parent, *curr;
> + bool ret =3D false;
> +
> + sch_tree_lock(sch);
> + curr =3D sch;
> + root =3D qdisc_root_sleeping(sch);
> + parent =3D qdisc_match_from_root(root, TC_H_MAJ(curr->parent));
>=20
> +
> + while (parent !=3D NULL) {
> + if (parent->ops->cl_ops =3D=3D &netem_class_ops) {
>=20
> + ret =3D true;
> + pr_warn("Ancestral netem already exists, cannot nest netem");
> + goto unlock;
> + }
> +
> + curr =3D parent;
> + parent =3D qdisc_match_from_root(root, TC_H_MAJ(curr->parent));
>=20
> + }
> +
> +unlock:
> + sch_tree_unlock(sch);
> + return ret;
> +}
> +
> static int netem_init(struct Qdisc *sch, struct nlattr *opt,
> struct netlink_ext_ack *extack)
> {
> @@ -1093,6 +1139,9 @@ static int netem_init(struct Qdisc *sch, struct nla=
ttr *opt,
>=20
> qdisc_watchdog_init(&q->watchdog, sch);
>=20
>=20
> + if (has_netem_ancestor(sch))
> + return -EINVAL;
> +
> if (!opt)
> return -EINVAL;
>=20
> @@ -1330,3 +1379,4 @@ module_init(netem_module_init)
> module_exit(netem_module_exit)
> MODULE_LICENSE("GPL");
> MODULE_DESCRIPTION("Network characteristics emulator qdisc");

Just realized an edge case in regards to the parent being TC_H_ROOT and fac=
tored it in to the patch (as 0xffff can be a valid major handle).

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index fdd79d3ccd8c..3e28367ef081 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -1085,6 +1085,58 @@ static int netem_change(struct Qdisc *sch, struct nl=
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
+       if (sch->parent =3D=3D TC_H_ROOT)
+               return false;
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
+               if (curr->parent =3D=3D TC_H_ROOT)
+                       break;
+
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
@@ -1093,6 +1145,9 @@ static int netem_init(struct Qdisc *sch, struct nlatt=
r *opt,
=20
        qdisc_watchdog_init(&q->watchdog, sch);
=20
+       if (has_netem_ancestor(sch))
+               return -EINVAL;
+
        if (!opt)
                return -EINVAL;


