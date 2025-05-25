Return-Path: <netdev+bounces-193287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B91AC36C6
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 22:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B3317349F
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 20:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0D61A5BB1;
	Sun, 25 May 2025 20:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="rY2X4D49"
X-Original-To: netdev@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D793382
	for <netdev@vger.kernel.org>; Sun, 25 May 2025 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748205840; cv=none; b=iDiBEKThqG160R2yL1NxQ3/8zBpgQ6EFjYNelNriPWO5OP6KlX0xgkhNrf5P7w8zjLF4qaATo/hmGV5NmewxMPYBUGeA/SIyfsVUgr4Ksucr0KKVrGZusFhnbM5RIq4ORSyn/N/z54W2qGhjZUdABjfK/BK0wEJAWOAmwaT0U9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748205840; c=relaxed/simple;
	bh=UZZODe8LBJt6fIc91WtXHt8wuPK6YexStxju4nnuU+k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNzuxtrvkKXYdtvaWzhNgcYLOsU4lgqR23z4D8wsx8E57yluMMVv3k5+RWcOHJbjc7Nk9Y8KT5PicfVQ3IjOCkjNPf27AJ2UwC+E/jQ2mKQrqiGpN/Lyc2jtCXuPuF7ET4dS32rRGaGxbhlsGY57Nfitp9YRlj0qcfIefmAjqvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=rY2X4D49; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1748205820; x=1748465020;
	bh=qdnrCC+/nYi9Lx7FL5CzagDjxA7tAQDekrFe8xS94Ws=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=rY2X4D49fTgm0zrhMXZT2Iax67ZNlY7jo1dFd9nUixMEQUdGDc3l+oifylnmOtvOA
	 eyHAKbpi0djZlMPzFfMTw4TJEKvxDz0V5dmYyBS3ksTk2iKIXP2phpCk7yBZNfZCIs
	 LYr3Md70MJ7RxXYMdOOh5Rc2now82KI4K7tu8o322yFeJ2zbP93wNRXv7zMJwYaUHx
	 QUJ6yQl/Coyf+IkVSZ0+pEFHk6n+rcJmFeoG3O+zqzlaFszgzIc3LkKM475gJ87mUT
	 mMw+wxw8OzMwhgdOtZjwFC1ZkvJo6T5drEun8fNuw96eVL0XDtYBawunvket7LEjkX
	 gbS1XdHu0rOYw==
Date: Sun, 25 May 2025 20:43:35 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Savy <savy@syst3mfailure.io>, Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
Message-ID: <q7G0Z7oMR2x9TWwNHOiPNsZ8lHzAuXuVgrZgGmAgkH8lkIYyTgeqXwcDrelE_fdS9OdJ4TlfS96px6O9SvnmKigNKFkiaFlStvAGPIJ3b84=@willsroot.io>
In-Reply-To: <FiSC_W4LweZiirPYQVe8p7CvUePHrufeDOQgkDT07zh-uy5s6eah-a8Vtr_lPrW73PAF51p6PPIrJITwrJ5vspk99wI5uZELnJijU5ILMUQ=@willsroot.io>
References:
	=?us-ascii?Q?<8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR=5FeIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis=5F0G7VEk=3D@willsroot.io>_<CAM0EoMmQau9+uXVm-vpuWqYjh=3D51a=5FCCS6orS6VrK6qBdddxrQ@mail.gmail.com>_<iEqzQsC-O2kAXqH1=5F58I59DIhBjRgebyGym2ZqyMEI3DaMtgsKSYR0KUsbxj5xqvfzf-4XzpM8dXvATHJhVVw3NedRdL3j1FJaqiXPlNWeE=3D@willsroot.io>_<ggSxq-NP-LDpev4N-rvkgs0Rrd0qOrbwtGRjcu4j4y3SuZth9k5RxTg2tFvhriQu4w=5FGxRPYjnkKN6VqFP6Q6FCyqWudz7=5F5iuOV06IEzgY=3D@willsroot.io>_<CAM0EoMkd87-6ZJ5PWsV8K+Pn+dVNEOP9NcfGAjXVrzAH70F4YA@mail.gmail.com>_<Ppi6ol0VaHrqJs9Rp0-SGp0J1Y0K8hki=5FjbNZ8sjNOmtEq0mD4f0IozBxxX-m4535QPJonGFYmiPmB643yd4SOpd1HDDYyMeGQuASuFHl-E=3D@willsroot.io>_<CAM0EoM=3D=3Dm=5Ff3=5FDNgSEKODQzHgE=5FzyRpXKweNGw1mxz-e3u6+Hg@mail.gmail.com>_<8fcsX7qgyK6tCGCqfi8RN7a-hMGfmh0K2wOpqXayxNM0lKgbjttNfpYkZHA29D0SN5WJ5h3-auiaClAq1nGw5BulC8wOzfa=5FlqR4bx73phM=3D@willsroot.io>_<CAM0EoMkO0vZ4ZtODLJEBP5FiA0+ofVNOSf-BxCOGOyWAZDHdTg@mail.gmail.com>_<FiSC=5FW4LweZiirPYQVe8p7CvUePHrufeDOQgkDT07zh-u?=
 =?us-ascii?Q?y5s6eah-a8Vtr=5FlPrW73PAF51p6PPIrJITwrJ5vspk99wI5uZELnJijU5ILMUQ=3D@willsroot.io>?=
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: e40acd30581ce390fd71f675853284f5d73a25bb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I did some more testing with the percpu approach, and we realized the follo=
wing problem caused now by netem_dequeue.

Recall that we increment the percpu variable on netem_enqueue entry and dec=
rement it on exit. netem_dequeue calls enqueue on the child qdisc - if this=
 child qdisc is a netem qdisc with duplication enabled, it could duplicate =
a previously duplicated packet from the parent back to the parent, causing =
the issue again. The percpu variable cannot protect against this case.

However, there is a hack to address this. We can add a field in netem_skb_c=
b called duplicated to track if a packet is involved in duplicated (both th=
e original and duplicated packet should have it marked). Right before we ca=
ll the child enqueue in netem_dequeue, we check for the duplicated value. I=
f it is true, we increment the percpu variable before and decrement it afte=
r the child enqueue call.

This only works under the assumption that there aren't other qdiscs that ca=
ll enqueue on their child during dequeue, which seems to be the case for no=
w. And honestly, this is quite a fragile fix - there might be other edge ca=
ses that will cause problems later down the line.

Are you aware of other more elegant approaches we can try for us to track t=
his required cross-qdisc state? We suggested adding a single bit to the skb=
, but we also see the problem with adding a field for a one-off use case to=
 such a vital structure (but this would also completely stomp out this bug)=
.

Anyways, below is a diff with our fix plus the test suites to catch for thi=
s bug as well as to ensure that a packet loss takes priority over a packet =
duplication event.

Please let me know of your thoughts - if this seems like a good enough fix,=
 I will submit a formal patchset. If any others cc'd here have any good ide=
as, please chime in too!

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index fdd79d3ccd8c..38bf85e24bbd 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -165,8 +165,11 @@ struct netem_sched_data {
  */
 struct netem_skb_cb {
        u64             time_to_send;
+       bool            duplicated;
 };
=20
+static DEFINE_PER_CPU(unsigned int, enqueue_nest_level);
+
 static inline struct netem_skb_cb *netem_skb_cb(struct sk_buff *skb)
 {
        /* we assume we can use skb next/prev/tstamp as storage for rb_node=
 */
@@ -448,32 +451,39 @@ static struct sk_buff *netem_segment(struct sk_buff *=
skb, struct Qdisc *sch,
 static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
                         struct sk_buff **to_free)
 {
+       int nest_level =3D __this_cpu_inc_return(enqueue_nest_level);
        struct netem_sched_data *q =3D qdisc_priv(sch);
-       /* We don't fill cb now as skb_unshare() may invalidate it */
-       struct netem_skb_cb *cb;
+       unsigned int prev_len =3D qdisc_pkt_len(skb);
        struct sk_buff *skb2 =3D NULL;
        struct sk_buff *segs =3D NULL;
-       unsigned int prev_len =3D qdisc_pkt_len(skb);
-       int count =3D 1;
+       /* We don't fill cb now as skb_unshare() may invalidate it */
+       struct netem_skb_cb *cb;
+       bool duplicate =3D false;
+       int retval;
=20
        /* Do not fool qdisc_drop_all() */
        skb->prev =3D NULL;
=20
-       /* Random duplication */
-       if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor, &q->=
prng))
-               ++count;
+       /*
+        * Random duplication
+        * We must avoid duplicating a duplicated packet, but there is no
+        * good way to track this. The nest_level check disables duplicatio=
n
+        * if a netem qdisc duplicates the skb in the call chain already
+        */
+       if (q->duplicate && nest_level <=3D1 &&
+           q->duplicate >=3D get_crandom(&q->dup_cor, &q->prng)) {
+               duplicate =3D true;
+       }
=20
        /* Drop packet? */
        if (loss_event(q)) {
-               if (q->ecn && INET_ECN_set_ce(skb))
-                       qdisc_qstats_drop(sch); /* mark packet */
-               else
-                       --count;
-       }
-       if (count =3D=3D 0) {
-               qdisc_qstats_drop(sch);
-               __qdisc_drop(skb, to_free);
-               return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
+               qdisc_qstats_drop(sch); /* mark packet */
+               if (!(q->ecn && INET_ECN_set_ce(skb))) {
+                       qdisc_qstats_drop(sch);
+                       __qdisc_drop(skb, to_free);
+                       retval =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
+                       goto dec_nest_level;
+               }
        }
=20
        /* If a delay is expected, orphan the skb. (orphaning usually takes
@@ -486,7 +496,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qd=
isc *sch,
         * If we need to duplicate packet, then clone it before
         * original is modified.
         */
-       if (count > 1)
+       if (duplicate)
                skb2 =3D skb_clone(skb, GFP_ATOMIC);
=20
        /*
@@ -528,27 +538,15 @@ static int netem_enqueue(struct sk_buff *skb, struct =
Qdisc *sch,
                qdisc_drop_all(skb, sch, to_free);
                if (skb2)
                        __qdisc_drop(skb2, to_free);
-               return NET_XMIT_DROP;
-       }
-
-       /*
-        * If doing duplication then re-insert at top of the
-        * qdisc tree, since parent queuer expects that only one
-        * skb will be queued.
-        */
-       if (skb2) {
-               struct Qdisc *rootq =3D qdisc_root_bh(sch);
-               u32 dupsave =3D q->duplicate; /* prevent duplicating a dup.=
.. */
-
-               q->duplicate =3D 0;
-               rootq->enqueue(skb2, rootq, to_free);
-               q->duplicate =3D dupsave;
-               skb2 =3D NULL;
+               retval =3D NET_XMIT_DROP;
+               goto dec_nest_level;
        }
=20
        qdisc_qstats_backlog_inc(sch, skb);
=20
        cb =3D netem_skb_cb(skb);
+       if (duplicate)
+               cb->duplicated =3D true;
        if (q->gap =3D=3D 0 ||              /* not doing reordering */
            q->counter < q->gap - 1 ||  /* inside last reordering gap */
            q->reorder < get_crandom(&q->reorder_cor, &q->prng)) {
@@ -613,6 +611,19 @@ static int netem_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
                sch->qstats.requeues++;
        }
=20
+       /*
+        * If doing duplication then re-insert at top of the
+        * qdisc tree, since parent queuer expects that only one
+        * skb will be queued.
+        */
+       if (skb2) {
+               struct Qdisc *rootq =3D qdisc_root_bh(sch);
+
+               netem_skb_cb(skb2)->duplicated =3D true;
+               rootq->enqueue(skb2, rootq, to_free);
+               skb2 =3D NULL;
+       }
+
 finish_segs:
        if (skb2)
                __qdisc_drop(skb2, to_free);
@@ -642,9 +653,14 @@ static int netem_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
                /* Parent qdiscs accounted for 1 skb of size @prev_len */
                qdisc_tree_reduce_backlog(sch, -(nb - 1), -(len - prev_len)=
);
        } else if (!skb) {
-               return NET_XMIT_DROP;
+               retval =3D NET_XMIT_DROP;
+               goto dec_nest_level;
        }
-       return NET_XMIT_SUCCESS;
+       retval =3D NET_XMIT_SUCCESS;
+
+dec_nest_level:
+       __this_cpu_dec(enqueue_nest_level);
+       return retval;
 }
=20
 /* Delay the next round with a new future slot with a
@@ -743,8 +759,11 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch=
)
                                unsigned int pkt_len =3D qdisc_pkt_len(skb)=
;
                                struct sk_buff *to_free =3D NULL;
                                int err;
-
+                               if (netem_skb_cb(skb)->duplicated)
+                                       __this_cpu_inc(enqueue_nest_level);
                                err =3D qdisc_enqueue(skb, q->qdisc, &to_fr=
ee);
+                               if (netem_skb_cb(skb)->duplicated)
+                                       __this_cpu_dec(enqueue_nest_level);
                                kfree_skb_list(to_free);
                                if (err !=3D NET_XMIT_SUCCESS) {
                                        if (net_xmit_drop_count(err))
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json =
b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
index 3c4444961488..f5dd9c5cd9b2 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
@@ -336,5 +336,46 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "d34d",
+        "name": "NETEM test qdisc duplication recursion limit",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set lo up || true",
+            "$TC qdisc add dev lo root handle 1: netem limit 1 duplicate 1=
00%",
+            "$TC qdisc add dev lo parent 1: handle 2: netem gap 1 limit 1 =
duplicate 100% delay 1us reorder 100%"
+        ],
+        "cmdUnderTest": "ping -I lo -c1 127.0.0.1 > /dev/null",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev lo",
+        "matchPattern": "qdisc netem",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev lo handle 1:0 root"
+        ]
+    },
+    {
+        "id": "b33f",
+        "name": "NETEM test qdisc maximum duplication and loss",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set lo up || true",
+            "$TC qdisc add dev lo root handle 1: netem limit 1 duplicate 1=
00% loss 100%"
+        ],
+        "cmdUnderTest": "ping -I lo -c1 127.0.0.1 > /dev/null",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -s qdisc show dev lo",
+        "matchPattern": "Sent 0 bytes 0 pkt",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev lo handle 1:0 root"
+        ]
     }
 ]


