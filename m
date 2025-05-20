Return-Path: <netdev+bounces-191891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10DAABDAFF
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 846DD7A6656
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C442E243370;
	Tue, 20 May 2025 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="prnlNyiQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995D4222570
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749879; cv=none; b=dK6AJYy3wF19eP9r2204ocZKWDKZMLXoE8ISpsbBckYb80FAD/+PrYs413Rb8JDrP973nZbC64CHUi4AD9SiLcBj9qnbM/Rsk1HCwP/j33fF/hg0l0dx/2N7sRuFwcr5qPSE+u2MeSYJAHoFrVxW835K5j4g6hPyGMu/2R/KTBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749879; c=relaxed/simple;
	bh=bX5Zp4wzpoUFoed4JyvdPTIlxw5m3n8ZHCUkY+Tlf94=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpZ1VxeEDWN/RQ+L4sw3dplNrIOpxiHLmerdSiEsp35O6KBbJ2BLgxEkgSORL8HIAQxj2O2JasDOxQ0O15Rvgr7J9no+7OaHtiC9D6lAyu71j720R8tZhTN9g9he3TjYkmZuOza1fvdUnB2G66IDdzBkItpxKO2bmBXJTRxcZhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=prnlNyiQ; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1747749872; x=1748009072;
	bh=U+e6n9E0ExLRMigW5O+LLN3F1sF1Pofax0Na6dfiQMY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=prnlNyiQZ+z444GAfsF1vZEc7cT8gL04CVCjFOkXLyUHAOMBYwd+ayOVvOs/i8fg2
	 RauVHChu/h0aZbNSOeQ1GRtpawgYoyEj8UO22k3RdeN437sOrPvXgdr0WMhdlNMlU/
	 TbSh57yQRiKF3U8Z9QowIQlOzurGiDSj0tQYHLex5TPcrdZAj8GgvimGwoWvCIpWMD
	 eD1OqpeyA+ociq9+BYcKYUi44if0iIWPG/Ij9EysuKB6Rr6maFFUZt0xwda8R7wXpG
	 ds6awIV0eTSqwESpp8Ibfh2yaiCA2Rajt2i1gT1h2LxvLsQ5FBa1K8OZRWCpu3umcL
	 OTucjnxH/kFsw==
Date: Tue, 20 May 2025 14:04:28 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Savy <savy@syst3mfailure.io>, Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
Message-ID: <DglTO9NHmtFTRrCJf07R16_tYUUqoTV7M0hID_k-ryn5mAhe4ADq1mBpAuxNK24ZTnzIPaPq4x1woAtqZGXgAQS4k64C4SGRCfupe3H3dRs=@willsroot.io>
In-Reply-To: <CAM0EoMmKL68r_b1T4zHJTmdZPdCwS69F-Hh+0_ev+-5xPGy2=w@mail.gmail.com>
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io> <CAM0EoMmKL68r_b1T4zHJTmdZPdCwS69F-Hh+0_ev+-5xPGy2=w@mail.gmail.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 26108bbd47e5f1ee200fe515b560b5f4b5733381
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Saturday, May 17th, 2025 at 2:09 PM, Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>=20
>=20
> Unfortunately we cant change the approach of looping to the root at
> this point because it may be expected behavior by some setups.
>=20
> To the setup in the script you shared: that is most certainly not a
> practical setup
> So, two approaches to resolve it:
> 1) Either we disallow altogether the ability to have a hierarchy of
> netems in a qdisc tree. It would mean to scan the tree on
> configuration and make sure there's not already a parent netem in
> existence. If you want to be more fine grained we can check that netem
> is not trying to duplicate packets
>=20
> or 2) we put a loop counter to make sure - for the case of netem - we
> dont loop more than once (which i believe is the design intent for
> netem).
>=20
> cheers,
> jamal

Hi Jamal,

We decided to opt for the second approach by adding a bitfield in sk_buff. =
We also moved the duplication to happen after the original sk_buff finishes=
 the enqueue to avoid using a stale limit check value.

We also considered the first approach by traversing the tree and checking f=
or netem_ops as a way to idenitfy the netem qdisc, but feel that this is no=
t very elegant.=20

Of course, this approach would disable duplication in netem qdiscs
that are children of a netem qdisc with duplication. However, we
are not aware of a good way to do a real de-duplication check like that for=
 sk_buff. Let us know what you think of this patch below.

Best,
Will
Savy

From 33af24d4bef8b141b608fa513528a804f689f823 Mon Sep 17 00:00:00 2001
From: William Liu <will@willsroot.io>
Date: Mon, 19 May 2025 08:46:15 -0700
Subject: [PATCH] net/sched: Fix duplication logic in netem_enqueue

netem_enqueue's duplication prevention logic is broken when multiple
netem qdiscs with duplication enabled are stacked together as seen
in [1]. Add a bit in sk_buff to track whether it has previously been
duplicated by netem. Also move the duplication logic to happen after
the initial packet has finished the enqueue process to preserve the
accuracy of the limit check.

[1] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsE=
BNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=3D@will=
sroot.io/

Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
Reported-by: William Liu <will@willsroot.io>
Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
Signed-off-by: William Liu <will@willsroot.io>
Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>
---
 include/linux/skbuff.h |  4 ++++
 net/sched/sch_netem.c  | 31 +++++++++++++++----------------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b974a277975a..e6b53af6322b 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -844,6 +844,7 @@ enum skb_tstamp_type {
  * @csum_level: indicates the number of consecutive checksums found in
  *     the packet minus one that have been verified as
  *     CHECKSUM_UNNECESSARY (max 3)
+ *      @netem_duplicate: indicates that netem has already duplicated this=
 packet
  * @unreadable: indicates that at least 1 of the fragments in this skb is
  *     unreadable.
  * @dst_pending_confirm: need to confirm neighbour
@@ -1026,6 +1027,9 @@ struct sk_buff {
    __u8            slow_gro:1;
 #if IS_ENABLED(CONFIG_IP_SCTP)
    __u8            csum_not_inet:1;
+#endif
+#if IS_ENABLED(CONFIG_NET_SCH_NETEM)
+   __u8                    netem_duplicate:1;
 #endif
    __u8            unreadable:1;
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index fdd79d3ccd8c..ce6e55b49acb 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -460,7 +460,8 @@ static int netem_enqueue(struct sk_buff *skb, struct Qd=
isc *sch,
    skb->prev =3D NULL;
=20
    /* Random duplication */
-   if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor, &q->prng=
))
+   if (!skb->netem_duplicate && q->duplicate &&
+       q->duplicate >=3D get_crandom(&q->dup_cor, &q->prng))
        ++count;
=20
    /* Drop packet? */
@@ -531,21 +532,6 @@ static int netem_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
        return NET_XMIT_DROP;
    }
=20
-   /*
-    * If doing duplication then re-insert at top of the
-    * qdisc tree, since parent queuer expects that only one
-    * skb will be queued.
-    */
-   if (skb2) {
-       struct Qdisc *rootq =3D qdisc_root_bh(sch);
-       u32 dupsave =3D q->duplicate; /* prevent duplicating a dup... */
-
-       q->duplicate =3D 0;
-       rootq->enqueue(skb2, rootq, to_free);
-       q->duplicate =3D dupsave;
-       skb2 =3D NULL;
-   }
-
    qdisc_qstats_backlog_inc(sch, skb);
=20
    cb =3D netem_skb_cb(skb);
@@ -613,6 +599,19 @@ static int netem_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
        sch->qstats.requeues++;
    }
=20
+   /*
+    * If doing duplication then re-insert at top of the
+    * qdisc tree, since parent queuer expects that only one
+    * skb will be queued.
+    */
+   if (skb2) {
+       struct Qdisc *rootq =3D qdisc_root_bh(sch);
+
+       skb2->netem_duplicate =3D 1;
+       rootq->enqueue(skb2, rootq, to_free);
+       skb2 =3D NULL;
+   }
+
 finish_segs:
    if (skb2)
        __qdisc_drop(skb2, to_free);
--=20
2.43.0

