Return-Path: <netdev+bounces-200502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718FAAE5B9E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 06:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95C13A756B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 04:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C357819C558;
	Tue, 24 Jun 2025 04:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="mqTtIzT0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E0126ACB
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 04:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750740391; cv=none; b=QzfQZCtY1xmw1Bv3FsHkV+EcylfnzYVpXdKDZ3x4uMJrxXJLbIGwS8PI0EBMFLvlBxASpejje1HTbsDSUuDIbyCyV73/XmWomOcLYJQoWTbsbLe090cDD3sOTgyLOeLgIsHAYyvzfml09FuRkMHOkw1bqJCDPX3QEe8Lfke+71g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750740391; c=relaxed/simple;
	bh=BgQU7hY5gMLNlJvvxM++doCFS4Qgl25tHatRtc2qK+E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+51fnj9p5Pwrc7GzVsLk8dIYz47fE5y+M6zsQ2O/yAUJY5upPvV3rZITaXaKjjXnj96QSzl+YkAZrW1ICNXNQIfP3htCgodZyJNTfrcW2Ght/PhBFBbsVpvjMWooCTLZCdgCvGchVHqpuYNCw1/XmLO4uQIxJMu8+G7apdaraE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=mqTtIzT0; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1750740385; x=1750999585;
	bh=BgQU7hY5gMLNlJvvxM++doCFS4Qgl25tHatRtc2qK+E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mqTtIzT0h4eKwsQ15tyCu+vnnfSfj32JuQL8j/xtcvmXSYIyppEhhQTgaR9GbUrBd
	 o9voIdJpdsaBWDNWSpbicXB2NuImp+OVOommkb16jc0RkDX6QIx8w5hfxeno+YZo8q
	 Tgjsy0v7j6KWcYpv9vwbXo6XhUh58lKU8NjyIwWSGUd9LNa5sREJlQz9SaFbL6vDxt
	 lfiFAlR1p1w0/ZA4po/LPQzl3Ap9mKkrFvBIC32VvNQLeOX3Z+nU+OOeXZodGvxAmI
	 MT4Y1kR2NQIKLbrAjsvqcPoZ2lSZDYhD1xpNQGLsoMRNaIoRY+e4M+o4yIpqiZbttK
	 4nR+d+8cVcc2w==
Date: Tue, 24 Jun 2025 04:46:22 +0000
To: Cong Wang <xiyou.wangcong@gmail.com>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org
Subject: Re: [PATCH net 1/2] net/sched: Restrict conditions for adding duplicating netems to qdisc tree
Message-ID: <Mg8Y4BPLchTQ9KEXuuZ4-nTKQf2s0SFeWM8X23wXeUJaJ0bbM7eGSnivxX3wmh8dob2WHtI17KBSXXEywmk5-Dqqg6RmctdK9HHn0lBtTN0=@willsroot.io>
In-Reply-To: <aFopK5iWHa0wrEIk@pop-os.localdomain>
References: <20250622190344.446090-1-will@willsroot.io> <aFopK5iWHa0wrEIk@pop-os.localdomain>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 0e9dca2008b41e72fd982815c3311009afd43aec
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, June 24th, 2025 at 4:27 AM, Cong Wang <xiyou.wangcong@gmail.com=
> wrote:

>=20
>=20
> On Sun, Jun 22, 2025 at 07:05:18PM +0000, William Liu wrote:
>=20
> > netem_enqueue's duplication prevention logic breaks when a netem
> > resides in a qdisc tree with other netems - this can lead to a
> > soft lockup and OOM loop in netem_dequeue as seen in [1].
> > Ensure that a duplicating netem cannot exist in a tree with other
> > netems.
>=20
>=20
> Thanks for the patch. But singling out this specific case in netem does
> not look like an elegant solution to me, it looks hacky.
>=20
> I know you probably discussed this with Jamal before posting this, could
> you please summarize why you decided to pick up this solution in the
> changelog? It is very important for code review.
>=20

Oh oops, I saw this email right after my reply and posting v2. I will updat=
e this in v3.

I originally suggested adding a single bit to the skb to track duplication =
for netem - Jamal mentioned a similar issue with a loopy DOS due to the rem=
oval of some TTL bits in the skb structure. I assumed it would be ok since =
it didn't change the struct size (and even if it did, it's backed by a slab=
 allocator), but was informed that such a change would be very hard to push=
 through.

The alternative approach is to ensure that multiple netems do not remain on=
 the same qdisc tree path when duplication is involved. But Jamal pointed o=
ut that the issue will come up once again when filters and actions redirect=
 packets from one path of the qdisc tree to another.=20

> One additional comment below.
>=20
> > [1] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1i=
lxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=3D@=
willsroot.io/
> >=20
> > Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> > Reported-by: William Liu will@willsroot.io
> > Reported-by: Savino Dicanosa savy@syst3mfailure.io
> > Signed-off-by: William Liu will@willsroot.io
> > Signed-off-by: Savino Dicanosa savy@syst3mfailure.io
> > ---
> > net/sched/sch_netem.c | 45 +++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 45 insertions(+)
> >=20
> > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > index fdd79d3ccd8c..308ce6629d7e 100644
> > --- a/net/sched/sch_netem.c
> > +++ b/net/sched/sch_netem.c
> > @@ -973,6 +973,46 @@ static int parse_attr(struct nlattr *tb[], int max=
type, struct nlattr *nla,
> > return 0;
> > }
> >=20
> > +static const struct Qdisc_class_ops netem_class_ops;
> > +
> > +static inline bool has_duplication(struct Qdisc *sch)
> > +{
> > + struct netem_sched_data *q =3D qdisc_priv(sch);
> > +
> > + return q->duplicate !=3D 0;
> > +}
>=20
>=20
> This is not worth a helper, because it only has one line and it is
> actually more readable without using a helper, IMHO.
>=20
> Regards,
> Cong

