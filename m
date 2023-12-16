Return-Path: <netdev+bounces-58209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA413815885
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 10:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC5B2878F3
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 09:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D292F1427B;
	Sat, 16 Dec 2023 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bBvXFtyy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41D214268
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c3fe6c1b5so15420335e9.2
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 01:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702718701; x=1703323501; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n+5vU2JxrrANO2u/FsumftVRJqAoZM2H25IrdmvVfJc=;
        b=bBvXFtyygWXG9v2F7lnm44AmNUkugqsrngpEAwsci06UXkQ7QxXpywwaG8t8CJUUrK
         c7d3aKuQD4lz7uLZYqWKQ4zilKcG/YhuJjzKdu90Vht98XB9qGmtstjZYtekFTUCDeEl
         9xZ/KPt5kfokfqUapM+FigrgjgZ+VhE0t5B02YsZ0Lwl4AqyVY1rIjsgPAQAr8Uck+2S
         0kHVGqwCOfkLmWLmaG0yx8+ZvB0D6X9fNZ6m7JqU9AC2N29gS1m713AG10+PzsbEkR8l
         80W4+R6utVODrNNMKsEPL1Q7uiJ3GXnE8o28oAYlJLExCgoIC9PutFWJkH41f02LHdP7
         pm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702718701; x=1703323501;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+5vU2JxrrANO2u/FsumftVRJqAoZM2H25IrdmvVfJc=;
        b=XS0SkyV+Ry+u9qZPK5T7wUnSgQViyDLQDaesW3AaR1ABrt7T8srYIJHPyS1KOm4PvW
         dDrdsDc4IF0JSqzGw4y0FzNj+xzEmRiGXQMnhCXO78Lq/UHdohtSmjAn++z+Fgiw9Ms8
         zacmthS/auFD1GDlCI3RptiYubSp4HuTe7IPIRuHL0O25md3Cu5ttC1kdH68m17dDhSK
         zPQMz+3iHr/hjYOAhlX2CV3jhdPM9Q9T4k5YjXyCXSaxS6qb+KejDLuNzqURhP32nf5X
         ysWz4hJcVAzU2nO4GxsQ1z9e65PAlV+11tVLdviEF+TOyHutmmPwpXd3uHfGm+9mtecl
         8Pgg==
X-Gm-Message-State: AOJu0YxLLtVLQnGFHKVncbFBoXCv2eEnsCiRoZGSdxDw4wHRrrFETqHz
	0dFeUUkwvI4jqG9/SOF0VJ/WvA==
X-Google-Smtp-Source: AGHT+IHkEIt/z0oKqqyWbA3ZFXgyNlYWCNkpiKirE6HICR+iI9RHX/DRkjUiPRZ0wMd2ChB95dbn2g==
X-Received: by 2002:a05:600c:138d:b0:40c:55ce:658f with SMTP id u13-20020a05600c138d00b0040c55ce658fmr3340293wmf.127.1702718700763;
        Sat, 16 Dec 2023 01:25:00 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id q3-20020a5d5743000000b003365bd008a1sm2166310wrw.71.2023.12.16.01.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 01:25:00 -0800 (PST)
Date: Sat, 16 Dec 2023 10:24:59 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jamal Hadi Salim <hadi@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xiyou.wangcong@gmail.com, mleitner@redhat.com, vladbu@nvidia.com,
	paulb@nvidia.com, pctammela@mojatatu.com, netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: Re: [PATCH net-next v7 1/3] net/sched: Introduce tc block netdev
 tracking infra
Message-ID: <ZX1s66ArRjetuRs-@nanopsycho>
References: <20231215111050.3624740-1-victor@mojatatu.com>
 <20231215111050.3624740-2-victor@mojatatu.com>
 <ZXxVQ0E-kd-ab3XD@nanopsycho>
 <CAAFAkD8Tx9TALNdHrwH19dKzRNaWNKKeQ-Tvd1DrwgT0MfxdJA@mail.gmail.com>
 <ZXx2Ml5m4I4v4J33@nanopsycho>
 <CAAFAkD9t-b_gs8AWOCHOF_8Qr5NTrWJVLJJhqcE1uv+XVs_7Bw@mail.gmail.com>
 <ZXyXAjWrWh_Zstyt@nanopsycho>
 <CAM0EoMnK1eTJaFAYaKKO=nDmzP0JSSkv3pYJtMq274iYYp1kJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMnK1eTJaFAYaKKO=nDmzP0JSSkv3pYJtMq274iYYp1kJw@mail.gmail.com>

Fri, Dec 15, 2023 at 09:58:38PM CET, jhs@mojatatu.com wrote:
>On Fri, Dec 15, 2023 at 1:12 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Fri, Dec 15, 2023 at 06:17:27PM CET, hadi@mojatatu.com wrote:
>> >On Fri, Dec 15, 2023 at 10:52 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Fri, Dec 15, 2023 at 03:35:01PM CET, hadi@mojatatu.com wrote:
>> >> >On Fri, Dec 15, 2023 at 8:31 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >>
>> >> >> Fri, Dec 15, 2023 at 12:10:48PM CET, victor@mojatatu.com wrote:
>> >> >> >This commit makes tc blocks track which ports have been added to them.
>> >> >> >And, with that, we'll be able to use this new information to send
>> >> >> >packets to the block's ports. Which will be done in the patch #3 of this
>> >> >> >series.
>> >> >> >
>> >> >> >Suggested-by: Jiri Pirko <jiri@nvidia.com>
>> >> >> >Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> >> >> >Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> >> >> >Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
>> >> >> >Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>> >> >> >Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>> >> >> >---
>> >> >> > include/net/sch_generic.h |  4 +++
>> >> >> > net/sched/cls_api.c       |  2 ++
>> >> >> > net/sched/sch_api.c       | 55 +++++++++++++++++++++++++++++++++++++++
>> >> >> > net/sched/sch_generic.c   | 31 ++++++++++++++++++++--
>> >> >> > 4 files changed, 90 insertions(+), 2 deletions(-)
>> >> >> >
>> >> >> >diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
>> >> >> >index dcb9160e6467..cefca55dd4f9 100644
>> >> >> >--- a/include/net/sch_generic.h
>> >> >> >+++ b/include/net/sch_generic.h
>> >> >> >@@ -19,6 +19,7 @@
>> >> >> > #include <net/gen_stats.h>
>> >> >> > #include <net/rtnetlink.h>
>> >> >> > #include <net/flow_offload.h>
>> >> >> >+#include <linux/xarray.h>
>> >> >> >
>> >> >> > struct Qdisc_ops;
>> >> >> > struct qdisc_walker;
>> >> >> >@@ -126,6 +127,8 @@ struct Qdisc {
>> >> >> >
>> >> >> >       struct rcu_head         rcu;
>> >> >> >       netdevice_tracker       dev_tracker;
>> >> >> >+      netdevice_tracker       in_block_tracker;
>> >> >> >+      netdevice_tracker       eg_block_tracker;
>> >> >> >       /* private data */
>> >> >> >       long privdata[] ____cacheline_aligned;
>> >> >> > };
>> >> >> >@@ -457,6 +460,7 @@ struct tcf_chain {
>> >> >> > };
>> >> >> >
>> >> >> > struct tcf_block {
>> >> >> >+      struct xarray ports; /* datapath accessible */
>> >> >> >       /* Lock protects tcf_block and lifetime-management data of chains
>> >> >> >        * attached to the block (refcnt, action_refcnt, explicitly_created).
>> >> >> >        */
>> >> >> >diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
>> >> >> >index dc1c19a25882..6020a32ecff2 100644
>> >> >> >--- a/net/sched/cls_api.c
>> >> >> >+++ b/net/sched/cls_api.c
>> >> >> >@@ -531,6 +531,7 @@ static void tcf_block_destroy(struct tcf_block *block)
>> >> >> > {
>> >> >> >       mutex_destroy(&block->lock);
>> >> >> >       mutex_destroy(&block->proto_destroy_lock);
>> >> >> >+      xa_destroy(&block->ports);
>> >> >> >       kfree_rcu(block, rcu);
>> >> >> > }
>> >> >> >
>> >> >> >@@ -1002,6 +1003,7 @@ static struct tcf_block *tcf_block_create(struct net *net, struct Qdisc *q,
>> >> >> >       refcount_set(&block->refcnt, 1);
>> >> >> >       block->net = net;
>> >> >> >       block->index = block_index;
>> >> >> >+      xa_init(&block->ports);
>> >> >> >
>> >> >> >       /* Don't store q pointer for blocks which are shared */
>> >> >> >       if (!tcf_block_shared(block))
>> >> >> >diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
>> >> >> >index e9eaf637220e..09ec64f2f463 100644
>> >> >> >--- a/net/sched/sch_api.c
>> >> >> >+++ b/net/sched/sch_api.c
>> >> >> >@@ -1180,6 +1180,57 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
>> >> >> >       return 0;
>> >> >> > }
>> >> >> >
>> >> >> >+static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *dev,
>> >> >> >+                             struct nlattr **tca,
>> >> >> >+                             struct netlink_ext_ack *extack)
>> >> >> >+{
>> >> >> >+      const struct Qdisc_class_ops *cl_ops = sch->ops->cl_ops;
>> >> >> >+      struct tcf_block *in_block = NULL;
>> >> >> >+      struct tcf_block *eg_block = NULL;
>> >> >>
>> >> >> No need to null.
>> >> >>
>> >> >> Can't you just have:
>> >> >>         struct tcf_block *block;
>> >> >>
>> >> >>         And use it in both ifs? You can easily obtain the block again on
>> >> >>         the error path.
>> >> >>
>> >> >
>> >> >It's just easier to read.
>> >>
>> >> Hmm.
>> >>
>> >> >
>> >> >> >+      int err;
>> >> >> >+
>> >> >> >+      if (tca[TCA_INGRESS_BLOCK]) {
>> >> >> >+              /* works for both ingress and clsact */
>> >> >> >+              in_block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>> >> >> >+              if (!in_block) {
>> >> >>
>> >> >> I don't see how this could happen. In fact, why exactly do you check
>> >> >> tca[TCA_INGRESS_BLOCK]?
>> >> >>
>> >> >
>> >> >It's lazy but what is wrong with doing that?
>> >>
>> >> It's not needed, that's wrong.
>> >>
>> >
>> >Are you ok with the proposal i made?
>>
>> Not sure what you mean here.
>
>I was referring to the suggestion I made. Ok, this is going nowhere;
>we'll just do _exactly_ what you said ;->

Sorry, I'm not sure what suggestion you are talking about. I see no
suggestion here. :/


>
>>
>> >
>> >>
>> >> >
>> >> >> At this time, the clsact/ingress init() function was already called, you
>> >> >> can just do:
>> >> >>
>> >> >>         block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>> >> >>         if (block) {
>> >> >>                 err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>> >> >>                 if (err) {
>> >> >>                         NL_SET_ERR_MSG(extack, "Ingress block dev insert failed");
>> >> >>                         return err;
>> >> >>                 }
>> >> >>                 netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL);
>> >> >>         }
>> >> >>         block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
>> >> >>         if (block) {
>> >> >>                 err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>> >> >>                 if (err) {
>> >> >>                         NL_SET_ERR_MSG(extack, "Egress block dev insert failed");
>> >> >>                         goto err_out;
>> >> >>                 }
>> >> >>                 netdev_hold(dev, &sch->eg_block_tracker, GFP_KERNEL);
>> >> >>         }
>> >> >>         return 0;
>> >> >>
>> >> >> err_out:
>> >> >>         block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>> >> >>         if (block) {
>> >> >>                 xa_erase(&block->ports, dev->ifindex);
>> >> >>                 netdev_put(dev, &sch->in_block_tracker);
>> >> >>         }
>> >> >>         return err;
>> >> >>
>> >> >> >+                      NL_SET_ERR_MSG(extack, "Shared ingress block missing");
>> >> >> >+                      return -EINVAL;
>> >> >> >+              }
>> >> >> >+
>> >> >> >+              err = xa_insert(&in_block->ports, dev->ifindex, dev, GFP_KERNEL);
>> >> >> >+              if (err) {
>> >> >> >+                      NL_SET_ERR_MSG(extack, "Ingress block dev insert failed");
>> >> >> >+                      return err;
>> >> >> >+              }
>> >> >> >+
>> >> >
>> >> >How about a middle ground:
>> >> >        in_block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>> >> >        if (in_block) {
>> >> >                err = xa_insert(&in_block->ports, dev->ifindex, dev,
>> >> >GFP_KERNEL);
>> >> >                if (err) {
>> >> >                        NL_SET_ERR_MSG(extack, "ingress block dev
>> >> >insert failed");
>> >> >                        return err;
>> >> >                }
>> >> >                netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL)
>> >> >      }
>> >> >       eg_block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
>> >> >        if (eg_block) {
>> >> >                err = xa_insert(&eg_block->ports, dev->ifindex, dev,
>> >> >GFP_KERNEL);
>> >> >                if (err) {
>> >> >                        netdev_put(dev, &sch->eg_block_tracker);
>> >> >                        NL_SET_ERR_MSG(extack, "Egress block dev
>> >> >insert failed");
>> >> >                        xa_erase(&in_block->ports, dev->ifindex);
>> >> >                        netdev_put(dev, &sch->in_block_tracker);
>> >> >                        return err;
>> >> >                }
>> >> >                netdev_hold(dev, &sch->eg_block_tracker, GFP_KERNEL);
>> >> >        }
>> >> >        return 0;
>> >> >
>> >> >> >+              netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL);
>> >> >>
>> >> >> Why exactly do you need an extra reference of netdev? Qdisc is already
>> >> >> having one.
>> >> >
>> >> >More fine grained tracking.
>> >>
>> >> Again, good for what exactly?
>> >
>> >We do xa_insert(&eg_block->ports, dev->ifindex, dev,...) which calls
>> >for a hold on the dev.
>>
>> Why you need to take a reference for it exactly? You already hold a
>> reference for qdisc, why is that not enough?
>>
>
>Justification is:
>We added the device on a new list/xarray (as you saw on the patch). To
>keep track of it we incr the refcnt when it's added to the xarray and
>decr when it is removed. It certainly helped when we were debugging
>the code - in case of failures the trace was very nicely descriptive.
>We could remove it.

To hold a reference without reason, just because you add netdev to a
list/xarray, does not make any sense. Please don't.



>
>cheers,
>jamal
>
>>
>> >Then we need to track that for debugging; so, instead of incrementing
>> >the same qdisc tracker again for each of those inserts we keep a
>> >separate tracker.
>> >
>> >cheers,
>> >jamal
>> >
>> >>
>> >> >
>> >> >>
>> >> >> >+      }
>> >> >> >+
>> >> >> >+      if (tca[TCA_EGRESS_BLOCK]) {
>> >> >> >+              eg_block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
>> >> >> >+              if (!eg_block) {
>> >> >> >+                      NL_SET_ERR_MSG(extack, "Shared egress block missing");
>> >> >> >+                      err = -EINVAL;
>> >> >> >+                      goto err_out;
>> >> >> >+              }
>> >> >> >+
>> >> >> >+              err = xa_insert(&eg_block->ports, dev->ifindex, dev, GFP_KERNEL);
>> >> >> >+              if (err) {
>> >> >> >+                      NL_SET_ERR_MSG(extack, "Egress block dev insert failed");
>> >> >> >+                      goto err_out;
>> >> >> >+              }
>> >> >> >+              netdev_hold(dev, &sch->eg_block_tracker, GFP_KERNEL);
>> >> >> >+      }
>> >> >> >+
>> >> >> >+      return 0;
>> >> >> >+err_out:
>> >> >> >+      if (in_block) {
>> >> >> >+              xa_erase(&in_block->ports, dev->ifindex);
>> >> >> >+              netdev_put(dev, &sch->in_block_tracker);
>> >> >> >+      }
>> >> >> >+      return err;
>> >> >> >+}
>> >> >> >+
>> >> >> > static int qdisc_block_indexes_set(struct Qdisc *sch, struct nlattr **tca,
>> >> >> >                                  struct netlink_ext_ack *extack)
>> >> >> > {
>> >> >> >@@ -1350,6 +1401,10 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
>> >> >> >       qdisc_hash_add(sch, false);
>> >> >> >       trace_qdisc_create(ops, dev, parent);
>> >> >> >
>> >> >> >+      err = qdisc_block_add_dev(sch, dev, tca, extack);
>> >> >> >+      if (err)
>> >> >> >+              goto err_out4;
>> >> >> >+
>> >> >> >       return sch;
>> >> >> >
>> >> >> > err_out4:
>> >> >> >diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
>> >> >> >index 8dd0e5925342..32bed60dea9f 100644
>> >> >> >--- a/net/sched/sch_generic.c
>> >> >> >+++ b/net/sched/sch_generic.c
>> >> >> >@@ -1050,7 +1050,11 @@ static void qdisc_free_cb(struct rcu_head *head)
>> >> >> >
>> >> >> > static void __qdisc_destroy(struct Qdisc *qdisc)
>> >> >> > {
>> >> >> >-      const struct Qdisc_ops  *ops = qdisc->ops;
>> >> >> >+      struct net_device *dev = qdisc_dev(qdisc);
>> >> >> >+      const struct Qdisc_ops *ops = qdisc->ops;
>> >> >> >+      const struct Qdisc_class_ops *cops;
>> >> >> >+      struct tcf_block *block;
>> >> >> >+      u32 block_index;
>> >> >> >
>> >> >> > #ifdef CONFIG_NET_SCHED
>> >> >> >       qdisc_hash_del(qdisc);
>> >> >> >@@ -1061,11 +1065,34 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
>> >> >> >
>> >> >> >       qdisc_reset(qdisc);
>> >> >> >
>> >> >> >+      cops = ops->cl_ops;
>> >> >> >+      if (ops->ingress_block_get) {
>> >> >> >+              block_index = ops->ingress_block_get(qdisc);
>> >> >> >+              if (block_index) {
>> >> >>
>> >> >> I don't follow. What you need block_index for? Why can't you just call:
>> >> >>         block = cops->tcf_block(qdisc, TC_H_MIN_INGRESS, NULL);
>> >> >> right away?
>> >> >
>> >> >Good point.
>> >> >
>> >> >cheers,
>> >> >jamal
>> >> >
>> >> >>
>> >> >> >+                      block = cops->tcf_block(qdisc, TC_H_MIN_INGRESS, NULL);
>> >> >> >+                      if (block) {
>> >> >> >+                              if (xa_erase(&block->ports, dev->ifindex))
>> >> >> >+                                      netdev_put(dev, &qdisc->in_block_tracker);
>> >> >> >+                      }
>> >> >> >+              }
>> >> >> >+      }
>> >> >> >+
>> >> >> >+      if (ops->egress_block_get) {
>> >> >> >+              block_index = ops->egress_block_get(qdisc);
>> >> >> >+              if (block_index) {
>> >> >> >+                      block = cops->tcf_block(qdisc, TC_H_MIN_EGRESS, NULL);
>> >> >> >+                      if (block) {
>> >> >> >+                              if (xa_erase(&block->ports, dev->ifindex))
>> >> >> >+                                      netdev_put(dev, &qdisc->eg_block_tracker);
>> >> >> >+                      }
>> >> >> >+              }
>> >> >> >+      }
>> >> >> >+
>> >> >> >       if (ops->destroy)
>> >> >> >               ops->destroy(qdisc);
>> >> >> >
>> >> >> >       module_put(ops->owner);
>> >> >> >-      netdev_put(qdisc_dev(qdisc), &qdisc->dev_tracker);
>> >> >> >+      netdev_put(dev, &qdisc->dev_tracker);
>> >> >> >
>> >> >> >       trace_qdisc_destroy(qdisc);
>> >> >> >
>> >> >> >--
>> >> >> >2.25.1
>> >> >> >

