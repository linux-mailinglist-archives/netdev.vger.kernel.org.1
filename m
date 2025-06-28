Return-Path: <netdev+bounces-202115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF0EAEC4D5
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 06:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C993B38F3
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 04:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A5221ABAE;
	Sat, 28 Jun 2025 04:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="J/irfx5m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27782BCFB
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 04:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751084607; cv=none; b=d3uUI14FDHa9XLi7u/EBFKEryyEzBTBNVVw96rHd2N2vNGqnOEWa2meAlyQR6N7qTfwvoDBnyABIueajG5rDmYVUzvo5YMBIFR/hakfhRjSyArOv8BI+CJ/vSVQZrfv2O7B0fKvuF9qDjLQLG54OBHNtHlHpxHfDN/pcnYHdLhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751084607; c=relaxed/simple;
	bh=fLhpmIKePNiqIl4UJaZfpA5dmsLkzjh1k1uqrEg7fFo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMU4aklKW39KgJBjFTzgjp1VxI5H5VIWn9514aWrEolS0k2F/ovLkygfGWjhadvZQkKxUCif6n9SNWCkrGSQYwbeW4yBFLg7kI5p7l4IA5QNszZM1yHebg7JnYAarhoofZSe/tQtEcQAwmv7s2nzgQvVGpaf/Ml/GZXd34Sq6dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=J/irfx5m; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1751084597; x=1751343797;
	bh=fLhpmIKePNiqIl4UJaZfpA5dmsLkzjh1k1uqrEg7fFo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=J/irfx5mMFsaa4l6+P3HUitW2NhHzRv66lyXy+LF66Axu306fD3amkDqI4NYTVgrB
	 DIjQLtNulnQAYn5n9t2+HUahDXW7F940ot6N+m6UmVN0QNZKmPHrFVuU9y3xzDHtem
	 CCwN92yCgY8ZEkRdWRRcScar8/5RKdB8ku2IgRlFVXUQa1JmL8ps9uLvqnVqMw9Yun
	 X9Um6GbIvuQV4uMk97sXbxSmYXoH9AvywycdKh7VCk07eFdwDiFe/VpebIKHi4F8Ph
	 Ubxe+1ktYfGvTRgP2SfpNASukjJtX1KeV6JCmzp3CW5ksNQ4yMftabHjcfZTtOVODi
	 fVwqKIvTITtQw==
Date: Sat, 28 Jun 2025 04:23:11 +0000
To: Cong Wang <xiyou.wangcong@gmail.com>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org
Subject: Re: [PATCH net v4 1/2] net/sched: Restrict conditions for adding duplicating netems to qdisc tree
Message-ID: <sf650XmBNi0tyPjDgs_wVtj-7oFNDmX8diA3IzKTuTaZcLYNc5YZPLnAHd5eI2BDtxugv74Bv67017EAuIvfNbfB6y7Pr7IUZ2w1j6JEMrM=@willsroot.io>
In-Reply-To: <aF80DNslZSX7XT3l@pop-os.localdomain>
References: <20250627061600.56522-1-will@willsroot.io> <aF80DNslZSX7XT3l@pop-os.localdomain>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: ea37d3b3b98d4ccf2e61b31dcea4752eb387bc2c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Saturday, June 28th, 2025 at 12:15 AM, Cong Wang <xiyou.wangcong@gmail.c=
om> wrote:

>=20
>=20
> On Fri, Jun 27, 2025 at 06:17:31AM +0000, William Liu wrote:
>=20
> > netem_enqueue's duplication prevention logic breaks when a netem
> > resides in a qdisc tree with other netems - this can lead to a
> > soft lockup and OOM loop in netem_dequeue, as seen in [1].
> > Ensure that a duplicating netem cannot exist in a tree with other
> > netems.
>=20
>=20
> Thanks for providing more details.
>=20
> > Previous approaches suggested in discussions in chronological order:
> >=20
> > 1) Track duplication status or ttl in the sk_buff struct. Considered
> > too specific a use case to extend such a struct, though this would
> > be a resilient fix and address other previous and potential future
> > DOS bugs like the one described in loopy fun [2].
> >=20
> > 2) Restrict netem_enqueue recursion depth like in act_mirred with a
> > per cpu variable. However, netem_dequeue can call enqueue on its
> > child, and the depth restriction could be bypassed if the child is a
> > netem.
> >=20
> > 3) Use the same approach as in 2, but add metadata in netem_skb_cb
> > to handle the netem_dequeue case and track a packet's involvement
> > in duplication. This is an overly complex approach, and Jamal
> > notes that the skb cb can be overwritten to circumvent this
> > safeguard.
>=20
>=20
> This approach looks most elegant to me since it is per-skb and only
> contained for netem. Since netem_skb_cb is shared among qdisc's, what
> about just extending qdisc_skb_cb? Something like:
>=20
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 638948be4c50..4c5505661986 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -436,6 +436,7 @@ struct qdisc_skb_cb {
> unsigned int pkt_len;
> u16 slave_dev_queue_mapping;
> u16 tc_classid;
> + u32 reserved;
> };
> #define QDISC_CB_PRIV_LEN 20
> unsigned char data[QDISC_CB_PRIV_LEN];
>=20
>=20
> Then we just set and check it for duplicated skbs:
>=20
>=20
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index fdd79d3ccd8c..4290f8fca0e9 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -486,7 +486,7 @@ static int netem_enqueue(struct sk_buff *skb, struct =
Qdisc *sch,
> * If we need to duplicate packet, then clone it before
> * original is modified.
> */
> - if (count > 1)
>=20
> + if (count > 1 && !qdisc_skb_cb(skb)->reserved)
>=20
> skb2 =3D skb_clone(skb, GFP_ATOMIC);
>=20
> /*
> @@ -540,9 +540,8 @@ static int netem_enqueue(struct sk_buff *skb, struct =
Qdisc *sch,
> struct Qdisc rootq =3D qdisc_root_bh(sch);
> u32 dupsave =3D q->duplicate; / prevent duplicating a dup... */
>=20
>=20
> - q->duplicate =3D 0;
>=20
> + qdisc_skb_cb(skb2)->reserved =3D dupsave;
>=20
> rootq->enqueue(skb2, rootq, to_free);
>=20
> - q->duplicate =3D dupsave;
>=20
> skb2 =3D NULL;
> }
>=20
>=20
> Could this work? It looks even shorter than your patch. :-)
>=20
> Note, I don't even compile test it, I just show it to you for discussion.
>=20

Thank you for the suggestion. Jamal, would this work in this case? I recall=
 you mentioning that the cb approach can be circumvented by zeroing the cb =
at the root: https://lore.kernel.org/netdev/CAM0EoMk4dxOFoN_=3D3yOy+XrtU=3D=
yvjJXAw3fVTmN9=3DM=3DR=3DvtbxA@mail.gmail.com/

I'm not sure if qdisc_skb_cb would be different than the case for private d=
ata for qdiscs.


