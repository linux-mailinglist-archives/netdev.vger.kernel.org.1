Return-Path: <netdev+bounces-58061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F79814E98
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 18:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004E51F258AA
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F043FB1A;
	Fri, 15 Dec 2023 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="LDn81EmW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FE166AAD
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cd68a0de49so529675a12.2
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 09:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702660658; x=1703265458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCAm1Ni6Cdha4u9AHDohjRb25yQoEQRDw8Af8dU+fNU=;
        b=LDn81EmWtsB3Rxl0MUub2m22kCAbrus9IgXMoeeDNQaBZ5WTcTWdYkYAgiDygF7FCl
         d8iXR/R57AyREqdvG2Gwr4DY5UEYUkFfelekx1N5w8Jxs5JXOfIBXP6Ou8NjBV/4Ckvo
         giGm1VtRVCgHU5PjZZyXp4ntluWlb6rX1sOigukfGL4qCJEE2TT4zzAce+IFij6XmA5h
         y2NCagM3w3zfnu7tTYmsZvRY0WAv5xE9twTOueN2lNhrUokpau5813bWAXqApqBNCH4P
         rCdtHbULst7XLmMYEYPfDujynxgiEn/qtDlugfRb6c+nBPjxus1aEMBkhbg2vPvoro+F
         va4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702660658; x=1703265458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCAm1Ni6Cdha4u9AHDohjRb25yQoEQRDw8Af8dU+fNU=;
        b=oVJPWfCZBDU/FycoEtuC207CF5beKsUr2eq53+EbTkzaPI/o2p89bBLdBjSKve0ZJe
         uucCNrGl2qAoqxFNrxsJ3jJhh5wOTdIVc2/1m25I1j7Jp77tkaFI5Pr1Eg/rbjYwpbrO
         bqnelQaI5f5Gs++kWlbPdTtXr5eFjkwd2vyhnw5rRiUgRQD0WCak2EDVfs9M5QPbDWK+
         HOHvZU/1Fjjg3AmVmO7ma3VuI1WTA+UERN4BHtDZ1zosqEejbpYX6QG/z9JjwQhXsSTy
         a8lzlAE0M7/PQ6UzGhXADJAouqn9EQ1tTsROHZMobKKxnW8s29KCkaSRCoC9JEeuxnZ+
         dHvA==
X-Gm-Message-State: AOJu0Yw48bh7dPyweZsuN3Tm/TYAxGg5gFYnURDgAqcu4Wx3M4OIQU5I
	9XCoOAYJpH4Om9sv5dK75K8fYHvc3iYEzf7d75XjUg==
X-Google-Smtp-Source: AGHT+IEnLVTzIIkRGgMybKz3yIvwEg2RoK549jkWmzqKgfCwMWQcdbSI2U5tumVpADsfLGNa/um6rmokDA2QXIv4Bp4=
X-Received: by 2002:a17:90a:77c1:b0:285:8673:450d with SMTP id
 e1-20020a17090a77c100b002858673450dmr9155706pjs.40.1702660657969; Fri, 15 Dec
 2023 09:17:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215111050.3624740-1-victor@mojatatu.com> <20231215111050.3624740-2-victor@mojatatu.com>
 <ZXxVQ0E-kd-ab3XD@nanopsycho> <CAAFAkD8Tx9TALNdHrwH19dKzRNaWNKKeQ-Tvd1DrwgT0MfxdJA@mail.gmail.com>
 <ZXx2Ml5m4I4v4J33@nanopsycho>
In-Reply-To: <ZXx2Ml5m4I4v4J33@nanopsycho>
From: Jamal Hadi Salim <hadi@mojatatu.com>
Date: Fri, 15 Dec 2023 12:17:27 -0500
Message-ID: <CAAFAkD9t-b_gs8AWOCHOF_8Qr5NTrWJVLJJhqcE1uv+XVs_7Bw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/3] net/sched: Introduce tc block netdev
 tracking infra
To: Jiri Pirko <jiri@resnulli.us>
Cc: Victor Nogueira <victor@mojatatu.com>, jhs@mojatatu.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	xiyou.wangcong@gmail.com, mleitner@redhat.com, vladbu@nvidia.com, 
	paulb@nvidia.com, pctammela@mojatatu.com, netdev@vger.kernel.org, 
	kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 10:52=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrot=
e:
>
> Fri, Dec 15, 2023 at 03:35:01PM CET, hadi@mojatatu.com wrote:
> >On Fri, Dec 15, 2023 at 8:31=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >>
> >> Fri, Dec 15, 2023 at 12:10:48PM CET, victor@mojatatu.com wrote:
> >> >This commit makes tc blocks track which ports have been added to them=
.
> >> >And, with that, we'll be able to use this new information to send
> >> >packets to the block's ports. Which will be done in the patch #3 of t=
his
> >> >series.
> >> >
> >> >Suggested-by: Jiri Pirko <jiri@nvidia.com>
> >> >Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >> >Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >> >Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> >> >Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> >> >Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> >> >---
> >> > include/net/sch_generic.h |  4 +++
> >> > net/sched/cls_api.c       |  2 ++
> >> > net/sched/sch_api.c       | 55 +++++++++++++++++++++++++++++++++++++=
++
> >> > net/sched/sch_generic.c   | 31 ++++++++++++++++++++--
> >> > 4 files changed, 90 insertions(+), 2 deletions(-)
> >> >
> >> >diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> >> >index dcb9160e6467..cefca55dd4f9 100644
> >> >--- a/include/net/sch_generic.h
> >> >+++ b/include/net/sch_generic.h
> >> >@@ -19,6 +19,7 @@
> >> > #include <net/gen_stats.h>
> >> > #include <net/rtnetlink.h>
> >> > #include <net/flow_offload.h>
> >> >+#include <linux/xarray.h>
> >> >
> >> > struct Qdisc_ops;
> >> > struct qdisc_walker;
> >> >@@ -126,6 +127,8 @@ struct Qdisc {
> >> >
> >> >       struct rcu_head         rcu;
> >> >       netdevice_tracker       dev_tracker;
> >> >+      netdevice_tracker       in_block_tracker;
> >> >+      netdevice_tracker       eg_block_tracker;
> >> >       /* private data */
> >> >       long privdata[] ____cacheline_aligned;
> >> > };
> >> >@@ -457,6 +460,7 @@ struct tcf_chain {
> >> > };
> >> >
> >> > struct tcf_block {
> >> >+      struct xarray ports; /* datapath accessible */
> >> >       /* Lock protects tcf_block and lifetime-management data of cha=
ins
> >> >        * attached to the block (refcnt, action_refcnt, explicitly_cr=
eated).
> >> >        */
> >> >diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> >> >index dc1c19a25882..6020a32ecff2 100644
> >> >--- a/net/sched/cls_api.c
> >> >+++ b/net/sched/cls_api.c
> >> >@@ -531,6 +531,7 @@ static void tcf_block_destroy(struct tcf_block *b=
lock)
> >> > {
> >> >       mutex_destroy(&block->lock);
> >> >       mutex_destroy(&block->proto_destroy_lock);
> >> >+      xa_destroy(&block->ports);
> >> >       kfree_rcu(block, rcu);
> >> > }
> >> >
> >> >@@ -1002,6 +1003,7 @@ static struct tcf_block *tcf_block_create(struc=
t net *net, struct Qdisc *q,
> >> >       refcount_set(&block->refcnt, 1);
> >> >       block->net =3D net;
> >> >       block->index =3D block_index;
> >> >+      xa_init(&block->ports);
> >> >
> >> >       /* Don't store q pointer for blocks which are shared */
> >> >       if (!tcf_block_shared(block))
> >> >diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> >> >index e9eaf637220e..09ec64f2f463 100644
> >> >--- a/net/sched/sch_api.c
> >> >+++ b/net/sched/sch_api.c
> >> >@@ -1180,6 +1180,57 @@ static int qdisc_graft(struct net_device *dev,=
 struct Qdisc *parent,
> >> >       return 0;
> >> > }
> >> >
> >> >+static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device =
*dev,
> >> >+                             struct nlattr **tca,
> >> >+                             struct netlink_ext_ack *extack)
> >> >+{
> >> >+      const struct Qdisc_class_ops *cl_ops =3D sch->ops->cl_ops;
> >> >+      struct tcf_block *in_block =3D NULL;
> >> >+      struct tcf_block *eg_block =3D NULL;
> >>
> >> No need to null.
> >>
> >> Can't you just have:
> >>         struct tcf_block *block;
> >>
> >>         And use it in both ifs? You can easily obtain the block again =
on
> >>         the error path.
> >>
> >
> >It's just easier to read.
>
> Hmm.
>
> >
> >> >+      int err;
> >> >+
> >> >+      if (tca[TCA_INGRESS_BLOCK]) {
> >> >+              /* works for both ingress and clsact */
> >> >+              in_block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, =
NULL);
> >> >+              if (!in_block) {
> >>
> >> I don't see how this could happen. In fact, why exactly do you check
> >> tca[TCA_INGRESS_BLOCK]?
> >>
> >
> >It's lazy but what is wrong with doing that?
>
> It's not needed, that's wrong.
>

Are you ok with the proposal i made?

>
> >
> >> At this time, the clsact/ingress init() function was already called, y=
ou
> >> can just do:
> >>
> >>         block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
> >>         if (block) {
> >>                 err =3D xa_insert(&block->ports, dev->ifindex, dev, GF=
P_KERNEL);
> >>                 if (err) {
> >>                         NL_SET_ERR_MSG(extack, "Ingress block dev inse=
rt failed");
> >>                         return err;
> >>                 }
> >>                 netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL);
> >>         }
> >>         block =3D cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
> >>         if (block) {
> >>                 err =3D xa_insert(&block->ports, dev->ifindex, dev, GF=
P_KERNEL);
> >>                 if (err) {
> >>                         NL_SET_ERR_MSG(extack, "Egress block dev inser=
t failed");
> >>                         goto err_out;
> >>                 }
> >>                 netdev_hold(dev, &sch->eg_block_tracker, GFP_KERNEL);
> >>         }
> >>         return 0;
> >>
> >> err_out:
> >>         block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
> >>         if (block) {
> >>                 xa_erase(&block->ports, dev->ifindex);
> >>                 netdev_put(dev, &sch->in_block_tracker);
> >>         }
> >>         return err;
> >>
> >> >+                      NL_SET_ERR_MSG(extack, "Shared ingress block m=
issing");
> >> >+                      return -EINVAL;
> >> >+              }
> >> >+
> >> >+              err =3D xa_insert(&in_block->ports, dev->ifindex, dev,=
 GFP_KERNEL);
> >> >+              if (err) {
> >> >+                      NL_SET_ERR_MSG(extack, "Ingress block dev inse=
rt failed");
> >> >+                      return err;
> >> >+              }
> >> >+
> >
> >How about a middle ground:
> >        in_block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
> >        if (in_block) {
> >                err =3D xa_insert(&in_block->ports, dev->ifindex, dev,
> >GFP_KERNEL);
> >                if (err) {
> >                        NL_SET_ERR_MSG(extack, "ingress block dev
> >insert failed");
> >                        return err;
> >                }
> >                netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL)
> >      }
> >       eg_block =3D cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
> >        if (eg_block) {
> >                err =3D xa_insert(&eg_block->ports, dev->ifindex, dev,
> >GFP_KERNEL);
> >                if (err) {
> >                        netdev_put(dev, &sch->eg_block_tracker);
> >                        NL_SET_ERR_MSG(extack, "Egress block dev
> >insert failed");
> >                        xa_erase(&in_block->ports, dev->ifindex);
> >                        netdev_put(dev, &sch->in_block_tracker);
> >                        return err;
> >                }
> >                netdev_hold(dev, &sch->eg_block_tracker, GFP_KERNEL);
> >        }
> >        return 0;
> >
> >> >+              netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL);
> >>
> >> Why exactly do you need an extra reference of netdev? Qdisc is already
> >> having one.
> >
> >More fine grained tracking.
>
> Again, good for what exactly?

We do xa_insert(&eg_block->ports, dev->ifindex, dev,...) which calls
for a hold on the dev.
Then we need to track that for debugging; so, instead of incrementing
the same qdisc tracker again for each of those inserts we keep a
separate tracker.

cheers,
jamal

>
> >
> >>
> >> >+      }
> >> >+
> >> >+      if (tca[TCA_EGRESS_BLOCK]) {
> >> >+              eg_block =3D cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, N=
ULL);
> >> >+              if (!eg_block) {
> >> >+                      NL_SET_ERR_MSG(extack, "Shared egress block mi=
ssing");
> >> >+                      err =3D -EINVAL;
> >> >+                      goto err_out;
> >> >+              }
> >> >+
> >> >+              err =3D xa_insert(&eg_block->ports, dev->ifindex, dev,=
 GFP_KERNEL);
> >> >+              if (err) {
> >> >+                      NL_SET_ERR_MSG(extack, "Egress block dev inser=
t failed");
> >> >+                      goto err_out;
> >> >+              }
> >> >+              netdev_hold(dev, &sch->eg_block_tracker, GFP_KERNEL);
> >> >+      }
> >> >+
> >> >+      return 0;
> >> >+err_out:
> >> >+      if (in_block) {
> >> >+              xa_erase(&in_block->ports, dev->ifindex);
> >> >+              netdev_put(dev, &sch->in_block_tracker);
> >> >+      }
> >> >+      return err;
> >> >+}
> >> >+
> >> > static int qdisc_block_indexes_set(struct Qdisc *sch, struct nlattr =
**tca,
> >> >                                  struct netlink_ext_ack *extack)
> >> > {
> >> >@@ -1350,6 +1401,10 @@ static struct Qdisc *qdisc_create(struct net_d=
evice *dev,
> >> >       qdisc_hash_add(sch, false);
> >> >       trace_qdisc_create(ops, dev, parent);
> >> >
> >> >+      err =3D qdisc_block_add_dev(sch, dev, tca, extack);
> >> >+      if (err)
> >> >+              goto err_out4;
> >> >+
> >> >       return sch;
> >> >
> >> > err_out4:
> >> >diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> >> >index 8dd0e5925342..32bed60dea9f 100644
> >> >--- a/net/sched/sch_generic.c
> >> >+++ b/net/sched/sch_generic.c
> >> >@@ -1050,7 +1050,11 @@ static void qdisc_free_cb(struct rcu_head *hea=
d)
> >> >
> >> > static void __qdisc_destroy(struct Qdisc *qdisc)
> >> > {
> >> >-      const struct Qdisc_ops  *ops =3D qdisc->ops;
> >> >+      struct net_device *dev =3D qdisc_dev(qdisc);
> >> >+      const struct Qdisc_ops *ops =3D qdisc->ops;
> >> >+      const struct Qdisc_class_ops *cops;
> >> >+      struct tcf_block *block;
> >> >+      u32 block_index;
> >> >
> >> > #ifdef CONFIG_NET_SCHED
> >> >       qdisc_hash_del(qdisc);
> >> >@@ -1061,11 +1065,34 @@ static void __qdisc_destroy(struct Qdisc *qdi=
sc)
> >> >
> >> >       qdisc_reset(qdisc);
> >> >
> >> >+      cops =3D ops->cl_ops;
> >> >+      if (ops->ingress_block_get) {
> >> >+              block_index =3D ops->ingress_block_get(qdisc);
> >> >+              if (block_index) {
> >>
> >> I don't follow. What you need block_index for? Why can't you just call=
:
> >>         block =3D cops->tcf_block(qdisc, TC_H_MIN_INGRESS, NULL);
> >> right away?
> >
> >Good point.
> >
> >cheers,
> >jamal
> >
> >>
> >> >+                      block =3D cops->tcf_block(qdisc, TC_H_MIN_INGR=
ESS, NULL);
> >> >+                      if (block) {
> >> >+                              if (xa_erase(&block->ports, dev->ifind=
ex))
> >> >+                                      netdev_put(dev, &qdisc->in_blo=
ck_tracker);
> >> >+                      }
> >> >+              }
> >> >+      }
> >> >+
> >> >+      if (ops->egress_block_get) {
> >> >+              block_index =3D ops->egress_block_get(qdisc);
> >> >+              if (block_index) {
> >> >+                      block =3D cops->tcf_block(qdisc, TC_H_MIN_EGRE=
SS, NULL);
> >> >+                      if (block) {
> >> >+                              if (xa_erase(&block->ports, dev->ifind=
ex))
> >> >+                                      netdev_put(dev, &qdisc->eg_blo=
ck_tracker);
> >> >+                      }
> >> >+              }
> >> >+      }
> >> >+
> >> >       if (ops->destroy)
> >> >               ops->destroy(qdisc);
> >> >
> >> >       module_put(ops->owner);
> >> >-      netdev_put(qdisc_dev(qdisc), &qdisc->dev_tracker);
> >> >+      netdev_put(dev, &qdisc->dev_tracker);
> >> >
> >> >       trace_qdisc_destroy(qdisc);
> >> >
> >> >--
> >> >2.25.1
> >> >

