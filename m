Return-Path: <netdev+bounces-194245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C76FAC803D
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 17:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2231C06E30
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 15:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4741022D4C1;
	Thu, 29 May 2025 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="x7WN4q5X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCD222CBFE
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748532193; cv=none; b=dG9sj3sjwakRY5a7MbVTF+kCDVlZfAPfun2pqSsZYwfqnrWeerSkFszCoqsvVDnGynCgKd0/vrjVCimeEBxfEGQn7Mms+vE7j3ZoxLqLm+Mg7yYhDwQGuspH4Q5uWnuJIL1C3vsNHhGE/fiafFgXcRBHo/1bTQle9oABm8ueXp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748532193; c=relaxed/simple;
	bh=KzIBy0LROxu6zIykfaalt5YYcA4mzJ/uWj3TWW3TXhY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gALhzkrSBzQYTuFPI54f1Gfr77vV90fXOh5ZBmFXPPiIKKTe/wLtut2sOI4mM6HU97eUWJbM5Dstjj9PUJuFN18srKbiE7LBSuWQInjzlEa31wL6QZrExQK9n43ZI82CNfa79YCl/W5nMbr2LvMFL4BDjdtVqiNA6JyPnNClgOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=x7WN4q5X; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1748532186; x=1748791386;
	bh=psJOtspO9QE9T6NvgCRDOTwVi7IGLKw/6Ze5XA78KhE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=x7WN4q5Xb26BB0kDfAJQHkw4U1y71ZQkulN7ikHwIsZ+kMAisabJowuYgsvHcDSQN
	 R8WVWBmPkF+Ki+6endmAEqyUFH/pOudYyn9FGxQ4dwAgmPmYVEA7UnWLc5kjNc/iNW
	 3iWBy7H/DFMFOZem7CB4VgOsz93qhL8UaNUctnXCc1EinRAStthdFM8coGOQws7kxa
	 r4/9QIJzmfvXTvuNn3TPUi26FQYSSCyJYdILERhR9mPfCxqXdSM7jQW83Zuj6b6KPz
	 I3MGiVbJU+l0U0dNBlsewUaaOe+8RRF425AKk+zK6jqj1XJpP+ufEpwS90YV5LWOkb
	 fl7VhVW9Gu2rg==
Date: Thu, 29 May 2025 15:23:04 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Savy <savy@syst3mfailure.io>, Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
Message-ID: <DISZZlS5CdbUKITzkIyT3jki3inTWSMecT6FplNmkpYs9bJizbs0iwRbTGMrnqEXrL3-__IjOQxdULPdZwGdKFSXJ1DZYIj6xmWPBZxerdk=@willsroot.io>
In-Reply-To: <CAM0EoMnmpjGVU2XyrH=p=-BY6JGU44qsqyfEik4g5E2M8rMMOQ@mail.gmail.com>
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io> <CAM0EoMkd87-6ZJ5PWsV8K+Pn+dVNEOP9NcfGAjXVrzAH70F4YA@mail.gmail.com> <Ppi6ol0VaHrqJs9Rp0-SGp0J1Y0K8hki_jbNZ8sjNOmtEq0mD4f0IozBxxX-m4535QPJonGFYmiPmB643yd4SOpd1HDDYyMeGQuASuFHl-E=@willsroot.io> <CAM0EoM==m_f3_DNgSEKODQzHgE_zyRpXKweNGw1mxz-e3u6+Hg@mail.gmail.com> <8fcsX7qgyK6tCGCqfi8RN7a-hMGfmh0K2wOpqXayxNM0lKgbjttNfpYkZHA29D0SN5WJ5h3-auiaClAq1nGw5BulC8wOzfa_lqR4bx73phM=@willsroot.io> <CAM0EoMkO0vZ4ZtODLJEBP5FiA0+ofVNOSf-BxCOGOyWAZDHdTg@mail.gmail.com> <FiSC_W4LweZiirPYQVe8p7CvUePHrufeDOQgkDT07zh-uy5s6eah-a8Vtr_lPrW73PAF51p6PPIrJITwrJ5vspk99wI5uZELnJijU5ILMUQ=@willsroot.io> <q7G0Z7oMR2x9TWwNHOiPNsZ8lHzAuXuVgrZgGmAgkH8lkIYyTgeqXwcDrelE_fdS9OdJ4TlfS96px6O9SvnmKigNKFkiaFlStvAGPIJ3b84=@willsroot.io> <CAM0EoMnmpjGVU2XyrH=p=-BY6JGU44qsqyfEik4g5E2M8rMMOQ@mail.gmail.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 126175be933af01f7b20546bdef0f7dc121bc372
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, May 28th, 2025 at 10:00 PM, Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:

>=20
>=20
> Hi,
> Sorry for the latency..
>=20
> On Sun, May 25, 2025 at 4:43=E2=80=AFPM William Liu will@willsroot.io wro=
te:
>=20
> > I did some more testing with the percpu approach, and we realized the f=
ollowing problem caused now by netem_dequeue.
> >=20
> > Recall that we increment the percpu variable on netem_enqueue entry and=
 decrement it on exit. netem_dequeue calls enqueue on the child qdisc - if =
this child qdisc is a netem qdisc with duplication enabled, it could duplic=
ate a previously duplicated packet from the parent back to the parent, caus=
ing the issue again. The percpu variable cannot protect against this case.
>=20
>=20
> I didnt follow why "percpu variable cannot protect against this case"
> - the enqueue and dequeue would be running on the same cpu, no?
> Also under what circumstances is the enqueue back to the root going to
> end up in calling dequeue? Did you test and hit this issue or its just
> theory? Note: It doesnt matter what the source of the skb is as long
> as it hits the netem enqueue.

Yes, I meant that just using the percpu variable in enqueue will not protec=
t against the case for when dequeue calls enqueue on the child. Because of =
the child netem with duplication enabled, packets already involved in dupli=
cation will get sent back to the parent's tfifo queue, and then the current=
 dequeue will remain stuck in the loop before hitting an OOM - refer to the=
 paragraph starting with "In netem_dequeue, the parent netem qdisc's t_len"=
 in the first email for additional clarification. We need to know whether a=
 packet we dequeue has been involved in duplication - if it has, we increme=
nt the percpu variable to inform the children netem qdiscs.

Hopefully the following diagram can help elucidate the problem:

Step 1: Initial enqueue of Packet A:

    +----------------------+
    |     Packet A         |
    +----------------------+
              |
              v
    +-------------------------+
    |     netem_enqueue       |
    +-------------------------+
              |
              v
    +-----------------------------------+
    | Duplication Logic (percpu OK):   |
    |   =3D> Packet A, Packet B (dup)    |
    +-----------------------------------+
              | <- percpu variable for netem_enqueue
              v    prevents duplication of B
        +-------------+=20
        | tfifo queue |
        |   [A, B]    |
        +-------------+

Step 2: netem_dequeue processes Packet B (or A)

        +-------------+
        | tfifo queue |
        |   [A]       |
        +-------------+
              |
              v
    +----------------------------------------+
    | netem_dequeue pops B in tfifo_dequeue  |
    +----------------------------------------+
              |
              v
    +--------------------------------------------+
    | netem_enqueue to child qdisc (netem w/ dup)|
    +--------------------------------------------+
              | <- percpu variable in netem_enqueue prologue
              |    and epilogue does not stop this dup,
              v    does not know about previous dup involvement
    +--------------------------------------------------------+
    | Child qdisc duplicates B to root (original netem) as C |
    +--------------------------------------------------------+
              |
              v

Step 3: Packet C enters original root netem again

    +-------------------------+
    | netem_enqueue (again)   |
    +-------------------------+
              |
              v
    +-------------------------------------+
    | Duplication Logic (percpu OK again) |
    |   =3D> Packet C, Packet D             |
    +-------------------------------------+
              |=20
              v=20
            .....

If you increment a percpu variable in enqueue prologue and decrement in enq=
ueue epilogue, you will notice that our original repro will still trigger a=
 loop because of the scenario I pointed out above - this has been tested.=
=20

From a current view of the codebase, netem is the only qdisc that calls enq=
ueue on its child from its dequeue. The check we propose will only work if =
this invariant remains.


> > However, there is a hack to address this. We can add a field in netem_s=
kb_cb called duplicated to track if a packet is involved in duplicated (bot=
h the original and duplicated packet should have it marked). Right before w=
e call the child enqueue in netem_dequeue, we check for the duplicated valu=
e. If it is true, we increment the percpu variable before and decrement it =
after the child enqueue call.
>=20
>=20
> is netem_skb_cb safe really for hierarchies? grep for qdisc_skb_cb
> net/sched/ to see what i mean

We are not using it for cross qdisc hierarchy checking. We are only using i=
t to inform a netem dequeue whether the packet has partaken in duplication =
from its corresponding netem enqueue. That part seems to be private data fo=
r the sk_buff residing in the current qdisc, so my understanding is that it=
's ok.

> > This only works under the assumption that there aren't other qdiscs tha=
t call enqueue on their child during dequeue, which seems to be the case fo=
r now. And honestly, this is quite a fragile fix - there might be other edg=
e cases that will cause problems later down the line.
> >=20
> > Are you aware of other more elegant approaches we can try for us to tra=
ck this required cross-qdisc state? We suggested adding a single bit to the=
 skb, but we also see the problem with adding a field for a one-off use cas=
e to such a vital structure (but this would also completely stomp out this =
bug).
>=20
>=20
> It sounds like quite a complicated approach - i dont know what the
> dequeue thing brings to the table; and if we really have to dequeue to

Did what I say above help clarify what the problem is? Feel free to let me =
know if you have more questions, this bug is quite a nasty one.

> reinject into enqueue then i dont think we are looping anymore..
>=20

We are still duplicating packets that have already partaken in duplication =
all the way back to root, so the tfifo dequeue loop in netem_dequeue won't =
stop.

> cheers,
> jamal
>=20

Best,
Will


