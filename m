Return-Path: <netdev+bounces-197324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C77A5AD81C0
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 05:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456733AECA2
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191CC1C5F2C;
	Fri, 13 Jun 2025 03:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="h5GB1l8u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFD131A60
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 03:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749785656; cv=none; b=i/6oF3FANCbD2evYxgMdRiYTlJ1kdkn1W0zGhcPxF8E9j4zm4PKTlFoHwqN50L61mOJjH7z5k/TLMqiLW4Wi/Ynh3wwfK4ulaRWF85rzZvCVKmW+uGn7gjVhgGFupRYbnwWrlghc6UUdpyX7zTpl0+Pdez5mBRoIaSVRiw+1XfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749785656; c=relaxed/simple;
	bh=G3r4e6zd2ORCdx6wup1APEeztwdOp6t+75H+Uh3f0AE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sk+yPrR/mG/VGCIOp1ooueeL4nWvgNhCUi3KeNaZvTq2iRXZ4+0YW1QFfiG2+RktqQVB1EgNcdcyIl98rNR3E+zJQFeOw0S1v/l1YMRmIIC8QC1wvRGnA4YJFPsSDGjP/+4L/gDV+XZPGeek+fOGd6h6F8zDd9ap+yKOkHuPbOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=h5GB1l8u; arc=none smtp.client-ip=79.135.106.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1749785644; x=1750044844;
	bh=XpKGQ+BbJpijZsqxA1JKl6PwR6Fow/I9dfELAWZyIzU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=h5GB1l8uQ/9YFC0655NTvl0ajbN5id1ecyr+4Y/dDqfYL0xge5IcnKJlCzo84OFSc
	 MXEtgD1Zlf9mBCv1JsGFK97b4mU5gG5Gho3RK8qgwzoI8KEmS2AwUrBITdwQPkdqaT
	 5fPwlFmy+riX5bdljg6YfAXBBFEkIx3uIaRLwINd7SsDVHYfwEABgTe7CMD0rGEcej
	 IWpnkXSuBRUMoSbXaCFMYH+71ZSAKZUJ7cdK17aG6Cs4S1wX1qqrmwK4mxKmEQVmVz
	 pbqmHXWZUDQRDdNIcGigcAbOEE0Z+Ypx8BgxllGVIemuRh+AWGIsVxQtRC1DYroT4x
	 /zG0Q1IdWUEgg==
Date: Fri, 13 Jun 2025 03:33:59 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: William Liu <will@willsroot.io>
Cc: Savy <savy@syst3mfailure.io>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
Message-ID: <yA-qROHJ2pCMLiRG8Au4YMe_V2R27OhaXkkjkImGzbhdlyHUs5nCkbbJYGkNLM4Rt5812LGXHathpDmqSYTGv1D4YF-zeJdWbCnNIAezEdg=@willsroot.io>
In-Reply-To: <CAM0EoMnd0nZxJW3zpEuBGWTwB3AnJSnj242f9hMpcLdBWdcbfQ@mail.gmail.com>
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io> <CAM0EoMk--+xXTf9ZG9M=r+gkRn2hczjqSTJRMV0dcgouJ4zw6g@mail.gmail.com> <CAM0EoMk4dxOFoN_=3yOy+XrtU=yvjJXAw3fVTmN9=M=R=vtbxA@mail.gmail.com> <lVH_UKrQzWPCHJS7_1Cj0gmEV0x4KI3VB_4auivP0fDokTBbmWuDV455wXrf6eQzakVFoK6wUxlDuMw_Lo0p4P9ByPLSjklsIkQiNcd_hvQ=@willsroot.io> <CAM0EoMkoFJJQD_ZVSMb7DUo1mafevgujx+WA=1ecTeYBcpB1Lw@mail.gmail.com> <A2nutOWbLBIdLRrnsUdavOagBEebp4YBFx0DdL23njEFVAySZul2pDRK1xf76_g6dLb82YXCRb1Ry9btDkZqeY9Btib0KgViSIIfsi4BDfU=@willsroot.io> <CAM0EoMmhP_9UsF18M=6B6AbY_am8cEnaqggpnVb9fkmBB4vjtA@mail.gmail.com> <dF67hR5ZcMlQZMtkrUEol_zkunpoJipfdVXveT5z-3_g57e5T6TQZRYlluKWzRoNiW4dCl603wlnnYR8eE-alv6UwTf-F8o5GzHWuDsypj0=@willsroot.io> <CAM0EoMnd0nZxJW3zpEuBGWTwB3AnJSnj242f9hMpcLdBWdcbfQ@mail.gmail.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 5556f9eff2f421e734467ece4854181c67914120
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, June 12th, 2025 at 10:08 PM, Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:

>=20
>=20
> Hi William,
> Apologies again for the latency.
>=20
> On Mon, Jun 9, 2025 at 11:31=E2=80=AFAM William Liu will@willsroot.io wro=
te:
>=20
> > On Monday, June 9th, 2025 at 12:27 PM, Jamal Hadi Salim jhs@mojatatu.co=
m wrote:
>=20
> > > I didnt finish my thought on that: I meant just dont allow a second
> > > netem to be added to a specific tree if one already exists. Dont
> > > bother checking for duplication.
> > >=20
> > > cheers,
> > > jamal
> > >=20
> > > > > [1] see "loopy fun" in https://lwn.net/Articles/719297/
> >=20
> > Hi Jamal,
> >=20
> > I came up with the following fix last night to disallow adding a netem =
qdisc if one of its ancestral qdiscs is a netem. It's just a draft -I will =
clean it up, move qdisc_match_from_root to sch_generic, add test cases, and=
 submit a formal patchset for review if it looks good to you. Please let us=
 know if you catch any edge cases or correctness issues we might be missing=
.
>=20
>=20
> It is a reasonable approach for fixing the obvious case you are
> facing. But I am still concerned.
> Potentially if you had another netem on a different branch of the tree
> it may still be problematic.
> Consider a prio qdisc with 3 bands each with a netem child with duplicati=
on on.
> Your solution will solve it for each branch if one tries to add a
> netem child to any of these netems.
>=20
> But consider you have a filter on the root qdisc or some intermediate
> qdisc and an associated action that changes skb->prio; when it hits
>=20
> netem and gets duplicated then when it goes back to the root it may be
> classified by prio to a different netem which will duplicate and on
> and on..
> BTW: I gave the example of skb->prio but this could be skb->mark.
>=20

Ah, good catch. I attached the modified patch below then.=20

>=20
> Perhaps we should only allow one netem per tree or allow more but
> check for duplication and only allow one per tree...
>=20

I believe we have to keep it at one netem per tree. The OOM loop can still =
trigger if a netem without duplication has a netem child with duplication. =
Consider the following setup:

tc qdisc add dev lo root handle 1: netem limit 1
tc qdisc add dev lo parent 1: handle 2: netem gap 1 limit 1 duplicate 100% =
delay 1us reorder 100%

The first netem will store everything in the tfifo queue on netem_enqueue. =
Since netem_dequeue calls enqueue on the child, and the child will duplicat=
e every packet back to the root, the first netem's netem_dequeue will never=
 exit the tfifo_loop.

Best,
William

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index fdd79d3ccd8c..4db5df202403 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -1085,6 +1085,36 @@ static int netem_change(struct Qdisc *sch, struct nl=
attr *opt,
        return ret;
 }
=20
+static const struct Qdisc_class_ops netem_class_ops;
+
+static bool has_netem_in_tree(struct Qdisc *sch) {
+       struct Qdisc *root, *q;
+       unsigned int i;
+       bool ret =3D false;
+
+       sch_tree_lock(sch);
+       root =3D qdisc_root_sleeping(sch);
+
+       if (root->ops->cl_ops =3D=3D &netem_class_ops) {
+               ret =3D true;
+               goto unlock;
+       }
+
+       hash_for_each_rcu(qdisc_dev(root)->qdisc_hash, i, q, hash) {
+               if (q->ops->cl_ops =3D=3D &netem_class_ops) {
+                       ret =3D true;
+                       goto unlock;
+               }
+       }
+
+unlock:
+       if (ret)
+               pr_warn("Cannot have multiple netems in tree\n");
+
+       sch_tree_unlock(sch);
+       return ret;
+}
+
 static int netem_init(struct Qdisc *sch, struct nlattr *opt,
                      struct netlink_ext_ack *extack)
 {
@@ -1093,6 +1123,9 @@ static int netem_init(struct Qdisc *sch, struct nlatt=
r *opt,
=20
        qdisc_watchdog_init(&q->watchdog, sch);
=20
+       if (has_netem_in_tree(sch))
+               return -EINVAL;
+
        if (!opt)
                return -EINVAL;
=20
@@ -1330,3 +1363,4 @@ module_init(netem_module_init)
 module_exit(netem_module_exit)
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Network characteristics emulator qdisc");


