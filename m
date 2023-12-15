Return-Path: <netdev+bounces-57980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E69814A97
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 15:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC001F2406C
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 14:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE891117;
	Fri, 15 Dec 2023 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="vcd0R/JE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCD23589F
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5c66418decaso277077a12.3
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 06:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702650912; x=1703255712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnlS7puGnykzLk4EJuyG8myrm7i6tXcW0GlnSLaTedw=;
        b=vcd0R/JEzoneDTjotNfypaQBI0IuAtrr1J472i28T4B2KinKVNwFDg8aRETlZW5heg
         mCPZ9FLHN/jskbDyQbHp3ZCVZLwZlDMBb9jMzrpC2jZvzuWr9RGDpY9kcSZk34s6FbFF
         878Pd2BxhYZ6FNz+n7WKUI3vKloSnCvys4rClndYjcpdR51M1XixzcOKFfz2146MMIkd
         pKn8MMkP+B6rIJijjpFMc6OkmXar4YAHOBP9OQIUYJPDNp+vYrHfvkiJGSjZ2O3ckaC1
         DvwLaeC3/bfV0mg5OT5DPetY5KcP+9jXJdGD1AMASOk/qlVfi+mkWt7G2OO112ebgsZg
         MVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702650912; x=1703255712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnlS7puGnykzLk4EJuyG8myrm7i6tXcW0GlnSLaTedw=;
        b=lD4hI2J0HWUpSCjjKbgEgwx0Mh7ywotap3X4uqHyrji+P9+vQv0KTn0qhdzwHTN43R
         b5FJIm2henyV60KDJr2NurVLnIuguBDdiThU8SEnwhRSKY2tqwnYkElzI1XpSsMdcHSM
         n8cm/zEoqMN5OGHBzOxG7pk4QMPaFKCST+fo3frv1FwbzXH9U8N77W7HMyrzA3loUR+j
         /a7FVVU2TCp4RSCuqREFKXrqAY6JdbfjgX3j0DIJLlDxF007IPTT7rkOa/oPbeRZ8pyY
         hdv3/N1QSiOLU8s3KRTSqyPbkopzUx4xcpYfUmHxUpvM3UvTWjhNBuJx8/hAu7mroYpc
         GV0w==
X-Gm-Message-State: AOJu0YzYPkgh+sumT3i0Aa5LheC+odn5Ww6fv+z8nZX9/XsQfgCjiV+O
	CRN7LLYxAf9w3gOlFOdqGjcwenM+Yty4la5HfGfLZw==
X-Google-Smtp-Source: AGHT+IG+FaK0KzPoLKfz9HbGTqGhnLFGiSQKE3/ha0idn7e9xwdqtwQmdFdUIbjG9ztooY/exWq7FlWQjBMKh94csk0=
X-Received: by 2002:a05:6a20:6a10:b0:191:b226:f927 with SMTP id
 p16-20020a056a206a1000b00191b226f927mr2994174pzk.87.1702650912284; Fri, 15
 Dec 2023 06:35:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215111050.3624740-1-victor@mojatatu.com> <20231215111050.3624740-2-victor@mojatatu.com>
 <ZXxVQ0E-kd-ab3XD@nanopsycho>
In-Reply-To: <ZXxVQ0E-kd-ab3XD@nanopsycho>
From: Jamal Hadi Salim <hadi@mojatatu.com>
Date: Fri, 15 Dec 2023 09:35:01 -0500
Message-ID: <CAAFAkD8Tx9TALNdHrwH19dKzRNaWNKKeQ-Tvd1DrwgT0MfxdJA@mail.gmail.com>
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

On Fri, Dec 15, 2023 at 8:31=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Fri, Dec 15, 2023 at 12:10:48PM CET, victor@mojatatu.com wrote:
> >This commit makes tc blocks track which ports have been added to them.
> >And, with that, we'll be able to use this new information to send
> >packets to the block's ports. Which will be done in the patch #3 of this
> >series.
> >
> >Suggested-by: Jiri Pirko <jiri@nvidia.com>
> >Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> >Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> >Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> >---
> > include/net/sch_generic.h |  4 +++
> > net/sched/cls_api.c       |  2 ++
> > net/sched/sch_api.c       | 55 +++++++++++++++++++++++++++++++++++++++
> > net/sched/sch_generic.c   | 31 ++++++++++++++++++++--
> > 4 files changed, 90 insertions(+), 2 deletions(-)
> >
> >diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> >index dcb9160e6467..cefca55dd4f9 100644
> >--- a/include/net/sch_generic.h
> >+++ b/include/net/sch_generic.h
> >@@ -19,6 +19,7 @@
> > #include <net/gen_stats.h>
> > #include <net/rtnetlink.h>
> > #include <net/flow_offload.h>
> >+#include <linux/xarray.h>
> >
> > struct Qdisc_ops;
> > struct qdisc_walker;
> >@@ -126,6 +127,8 @@ struct Qdisc {
> >
> >       struct rcu_head         rcu;
> >       netdevice_tracker       dev_tracker;
> >+      netdevice_tracker       in_block_tracker;
> >+      netdevice_tracker       eg_block_tracker;
> >       /* private data */
> >       long privdata[] ____cacheline_aligned;
> > };
> >@@ -457,6 +460,7 @@ struct tcf_chain {
> > };
> >
> > struct tcf_block {
> >+      struct xarray ports; /* datapath accessible */
> >       /* Lock protects tcf_block and lifetime-management data of chains
> >        * attached to the block (refcnt, action_refcnt, explicitly_creat=
ed).
> >        */
> >diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> >index dc1c19a25882..6020a32ecff2 100644
> >--- a/net/sched/cls_api.c
> >+++ b/net/sched/cls_api.c
> >@@ -531,6 +531,7 @@ static void tcf_block_destroy(struct tcf_block *bloc=
k)
> > {
> >       mutex_destroy(&block->lock);
> >       mutex_destroy(&block->proto_destroy_lock);
> >+      xa_destroy(&block->ports);
> >       kfree_rcu(block, rcu);
> > }
> >
> >@@ -1002,6 +1003,7 @@ static struct tcf_block *tcf_block_create(struct n=
et *net, struct Qdisc *q,
> >       refcount_set(&block->refcnt, 1);
> >       block->net =3D net;
> >       block->index =3D block_index;
> >+      xa_init(&block->ports);
> >
> >       /* Don't store q pointer for blocks which are shared */
> >       if (!tcf_block_shared(block))
> >diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> >index e9eaf637220e..09ec64f2f463 100644
> >--- a/net/sched/sch_api.c
> >+++ b/net/sched/sch_api.c
> >@@ -1180,6 +1180,57 @@ static int qdisc_graft(struct net_device *dev, st=
ruct Qdisc *parent,
> >       return 0;
> > }
> >
> >+static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *de=
v,
> >+                             struct nlattr **tca,
> >+                             struct netlink_ext_ack *extack)
> >+{
> >+      const struct Qdisc_class_ops *cl_ops =3D sch->ops->cl_ops;
> >+      struct tcf_block *in_block =3D NULL;
> >+      struct tcf_block *eg_block =3D NULL;
>
> No need to null.
>
> Can't you just have:
>         struct tcf_block *block;
>
>         And use it in both ifs? You can easily obtain the block again on
>         the error path.
>

It's just easier to read.

> >+      int err;
> >+
> >+      if (tca[TCA_INGRESS_BLOCK]) {
> >+              /* works for both ingress and clsact */
> >+              in_block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NUL=
L);
> >+              if (!in_block) {
>
> I don't see how this could happen. In fact, why exactly do you check
> tca[TCA_INGRESS_BLOCK]?
>

It's lazy but what is wrong with doing that?

> At this time, the clsact/ingress init() function was already called, you
> can just do:
>
>         block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>         if (block) {
>                 err =3D xa_insert(&block->ports, dev->ifindex, dev, GFP_K=
ERNEL);
>                 if (err) {
>                         NL_SET_ERR_MSG(extack, "Ingress block dev insert =
failed");
>                         return err;
>                 }
>                 netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL);
>         }
>         block =3D cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
>         if (block) {
>                 err =3D xa_insert(&block->ports, dev->ifindex, dev, GFP_K=
ERNEL);
>                 if (err) {
>                         NL_SET_ERR_MSG(extack, "Egress block dev insert f=
ailed");
>                         goto err_out;
>                 }
>                 netdev_hold(dev, &sch->eg_block_tracker, GFP_KERNEL);
>         }
>         return 0;
>
> err_out:
>         block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>         if (block) {
>                 xa_erase(&block->ports, dev->ifindex);
>                 netdev_put(dev, &sch->in_block_tracker);
>         }
>         return err;
>
> >+                      NL_SET_ERR_MSG(extack, "Shared ingress block miss=
ing");
> >+                      return -EINVAL;
> >+              }
> >+
> >+              err =3D xa_insert(&in_block->ports, dev->ifindex, dev, GF=
P_KERNEL);
> >+              if (err) {
> >+                      NL_SET_ERR_MSG(extack, "Ingress block dev insert =
failed");
> >+                      return err;
> >+              }
> >+

How about a middle ground:
        in_block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
        if (in_block) {
                err =3D xa_insert(&in_block->ports, dev->ifindex, dev,
GFP_KERNEL);
                if (err) {
                        NL_SET_ERR_MSG(extack, "ingress block dev
insert failed");
                        return err;
                }
                netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL)
      }
       eg_block =3D cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
        if (eg_block) {
                err =3D xa_insert(&eg_block->ports, dev->ifindex, dev,
GFP_KERNEL);
                if (err) {
                        netdev_put(dev, &sch->eg_block_tracker);
                        NL_SET_ERR_MSG(extack, "Egress block dev
insert failed");
                        xa_erase(&in_block->ports, dev->ifindex);
                        netdev_put(dev, &sch->in_block_tracker);
                        return err;
                }
                netdev_hold(dev, &sch->eg_block_tracker, GFP_KERNEL);
        }
        return 0;

> >+              netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL);
>
> Why exactly do you need an extra reference of netdev? Qdisc is already
> having one.

More fine grained tracking.

>
> >+      }
> >+
> >+      if (tca[TCA_EGRESS_BLOCK]) {
> >+              eg_block =3D cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL=
);
> >+              if (!eg_block) {
> >+                      NL_SET_ERR_MSG(extack, "Shared egress block missi=
ng");
> >+                      err =3D -EINVAL;
> >+                      goto err_out;
> >+              }
> >+
> >+              err =3D xa_insert(&eg_block->ports, dev->ifindex, dev, GF=
P_KERNEL);
> >+              if (err) {
> >+                      NL_SET_ERR_MSG(extack, "Egress block dev insert f=
ailed");
> >+                      goto err_out;
> >+              }
> >+              netdev_hold(dev, &sch->eg_block_tracker, GFP_KERNEL);
> >+      }
> >+
> >+      return 0;
> >+err_out:
> >+      if (in_block) {
> >+              xa_erase(&in_block->ports, dev->ifindex);
> >+              netdev_put(dev, &sch->in_block_tracker);
> >+      }
> >+      return err;
> >+}
> >+
> > static int qdisc_block_indexes_set(struct Qdisc *sch, struct nlattr **t=
ca,
> >                                  struct netlink_ext_ack *extack)
> > {
> >@@ -1350,6 +1401,10 @@ static struct Qdisc *qdisc_create(struct net_devi=
ce *dev,
> >       qdisc_hash_add(sch, false);
> >       trace_qdisc_create(ops, dev, parent);
> >
> >+      err =3D qdisc_block_add_dev(sch, dev, tca, extack);
> >+      if (err)
> >+              goto err_out4;
> >+
> >       return sch;
> >
> > err_out4:
> >diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> >index 8dd0e5925342..32bed60dea9f 100644
> >--- a/net/sched/sch_generic.c
> >+++ b/net/sched/sch_generic.c
> >@@ -1050,7 +1050,11 @@ static void qdisc_free_cb(struct rcu_head *head)
> >
> > static void __qdisc_destroy(struct Qdisc *qdisc)
> > {
> >-      const struct Qdisc_ops  *ops =3D qdisc->ops;
> >+      struct net_device *dev =3D qdisc_dev(qdisc);
> >+      const struct Qdisc_ops *ops =3D qdisc->ops;
> >+      const struct Qdisc_class_ops *cops;
> >+      struct tcf_block *block;
> >+      u32 block_index;
> >
> > #ifdef CONFIG_NET_SCHED
> >       qdisc_hash_del(qdisc);
> >@@ -1061,11 +1065,34 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
> >
> >       qdisc_reset(qdisc);
> >
> >+      cops =3D ops->cl_ops;
> >+      if (ops->ingress_block_get) {
> >+              block_index =3D ops->ingress_block_get(qdisc);
> >+              if (block_index) {
>
> I don't follow. What you need block_index for? Why can't you just call:
>         block =3D cops->tcf_block(qdisc, TC_H_MIN_INGRESS, NULL);
> right away?

Good point.

cheers,
jamal

>
> >+                      block =3D cops->tcf_block(qdisc, TC_H_MIN_INGRESS=
, NULL);
> >+                      if (block) {
> >+                              if (xa_erase(&block->ports, dev->ifindex)=
)
> >+                                      netdev_put(dev, &qdisc->in_block_=
tracker);
> >+                      }
> >+              }
> >+      }
> >+
> >+      if (ops->egress_block_get) {
> >+              block_index =3D ops->egress_block_get(qdisc);
> >+              if (block_index) {
> >+                      block =3D cops->tcf_block(qdisc, TC_H_MIN_EGRESS,=
 NULL);
> >+                      if (block) {
> >+                              if (xa_erase(&block->ports, dev->ifindex)=
)
> >+                                      netdev_put(dev, &qdisc->eg_block_=
tracker);
> >+                      }
> >+              }
> >+      }
> >+
> >       if (ops->destroy)
> >               ops->destroy(qdisc);
> >
> >       module_put(ops->owner);
> >-      netdev_put(qdisc_dev(qdisc), &qdisc->dev_tracker);
> >+      netdev_put(dev, &qdisc->dev_tracker);
> >
> >       trace_qdisc_destroy(qdisc);
> >
> >--
> >2.25.1
> >

