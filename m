Return-Path: <netdev+bounces-57995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D11FF814C1C
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 16:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8573A281981
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 15:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4C8381B3;
	Fri, 15 Dec 2023 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="cH7MyiJO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97E8381AF
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-333536432e0so688461f8f.3
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 07:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702655541; x=1703260341; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8QKL0+H7DQXcTKI/I7/G1kP6AgiFqvxt3B82ErhU/Qc=;
        b=cH7MyiJOtqYXASgCZ4NWNVvFgTY3bQeYXZkNNDWTArula+8EOxMR9/mBZRqudqqhqs
         jNkC+/Yy2pLq4VQHDWQtt7t/Md5RQYu/VgcVie8JfVeT9sISMzN5KCAZTpOxKauy0IB1
         tVV60f8ehyqjUKSkIRhqPDOHm5n/5yw/W4J5d3DpApJbqErUZoGPcFHcdvmZiDI1xern
         8sptzydv+T8NBM8SiPhHerkVZbVsH9CwgVYsEUm8kaf5RtFiaaOgkMP4mIxDsON7YaVQ
         UxgZL1W/CzOLs15Kn9umi6kEes2DHywTwEWKLHabKhLiECZ/sx3+RlvKj/EwFsH1FWZQ
         yLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702655541; x=1703260341;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8QKL0+H7DQXcTKI/I7/G1kP6AgiFqvxt3B82ErhU/Qc=;
        b=wquzPtHuxQwnsnT4ar9Vq/FbENP2Vrf55WZ8cAbsJOJbstYTxlSiCjZefSYsHH5u2k
         8VURoEwFEY6wlIjpS0I0mOcWREuXrbuJO/U6jxSYRk+ZsCIe4ikxETZLNAKO9LUNYoAF
         HMlWWCJ54unftfuI+SFe42Vo8naASqOROeOAITJagOcfyd7z4XcWk09TCcIkV/oOD9DD
         xSCCh6EzK3UOndOkZH8YuuHHK1DOr4s31EVe5grBjETLZt9xX+JD/ycpEFuxNAIMyWUi
         4B/8HpzO9LlO5nYD6M8WhwxV3sS12S2XqHC9PlGdGMlHFNfxnhdm5pzE8dQJfx9xCouf
         880g==
X-Gm-Message-State: AOJu0Yyq2IebntNVQWzhRFHOozLVjH/M844OPEFaXo/mbI0axz5L/zC2
	tR+HWiRcgdz71i3QzRHMY5fYoA==
X-Google-Smtp-Source: AGHT+IFMXa7520o+iaRhrLW2XY4XwAMQwfbF7yL1u5RoIYFVr4O7E5tfP3To4b4DnQ5f8h2vhhUmIQ==
X-Received: by 2002:a5d:448b:0:b0:336:442e:8b20 with SMTP id j11-20020a5d448b000000b00336442e8b20mr2226266wrq.26.1702655540355;
        Fri, 15 Dec 2023 07:52:20 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u10-20020a5d434a000000b0033342338a24sm19366695wrr.6.2023.12.15.07.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 07:52:19 -0800 (PST)
Date: Fri, 15 Dec 2023 16:52:18 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <hadi@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>, jhs@mojatatu.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, xiyou.wangcong@gmail.com, mleitner@redhat.com,
	vladbu@nvidia.com, paulb@nvidia.com, pctammela@mojatatu.com,
	netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next v7 1/3] net/sched: Introduce tc block netdev
 tracking infra
Message-ID: <ZXx2Ml5m4I4v4J33@nanopsycho>
References: <20231215111050.3624740-1-victor@mojatatu.com>
 <20231215111050.3624740-2-victor@mojatatu.com>
 <ZXxVQ0E-kd-ab3XD@nanopsycho>
 <CAAFAkD8Tx9TALNdHrwH19dKzRNaWNKKeQ-Tvd1DrwgT0MfxdJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAFAkD8Tx9TALNdHrwH19dKzRNaWNKKeQ-Tvd1DrwgT0MfxdJA@mail.gmail.com>

Fri, Dec 15, 2023 at 03:35:01PM CET, hadi@mojatatu.com wrote:
>On Fri, Dec 15, 2023 at 8:31 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Fri, Dec 15, 2023 at 12:10:48PM CET, victor@mojatatu.com wrote:
>> >This commit makes tc blocks track which ports have been added to them.
>> >And, with that, we'll be able to use this new information to send
>> >packets to the block's ports. Which will be done in the patch #3 of this
>> >series.
>> >
>> >Suggested-by: Jiri Pirko <jiri@nvidia.com>
>> >Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> >Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> >Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
>> >Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>> >Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>> >---
>> > include/net/sch_generic.h |  4 +++
>> > net/sched/cls_api.c       |  2 ++
>> > net/sched/sch_api.c       | 55 +++++++++++++++++++++++++++++++++++++++
>> > net/sched/sch_generic.c   | 31 ++++++++++++++++++++--
>> > 4 files changed, 90 insertions(+), 2 deletions(-)
>> >
>> >diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
>> >index dcb9160e6467..cefca55dd4f9 100644
>> >--- a/include/net/sch_generic.h
>> >+++ b/include/net/sch_generic.h
>> >@@ -19,6 +19,7 @@
>> > #include <net/gen_stats.h>
>> > #include <net/rtnetlink.h>
>> > #include <net/flow_offload.h>
>> >+#include <linux/xarray.h>
>> >
>> > struct Qdisc_ops;
>> > struct qdisc_walker;
>> >@@ -126,6 +127,8 @@ struct Qdisc {
>> >
>> >       struct rcu_head         rcu;
>> >       netdevice_tracker       dev_tracker;
>> >+      netdevice_tracker       in_block_tracker;
>> >+      netdevice_tracker       eg_block_tracker;
>> >       /* private data */
>> >       long privdata[] ____cacheline_aligned;
>> > };
>> >@@ -457,6 +460,7 @@ struct tcf_chain {
>> > };
>> >
>> > struct tcf_block {
>> >+      struct xarray ports; /* datapath accessible */
>> >       /* Lock protects tcf_block and lifetime-management data of chains
>> >        * attached to the block (refcnt, action_refcnt, explicitly_created).
>> >        */
>> >diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
>> >index dc1c19a25882..6020a32ecff2 100644
>> >--- a/net/sched/cls_api.c
>> >+++ b/net/sched/cls_api.c
>> >@@ -531,6 +531,7 @@ static void tcf_block_destroy(struct tcf_block *block)
>> > {
>> >       mutex_destroy(&block->lock);
>> >       mutex_destroy(&block->proto_destroy_lock);
>> >+      xa_destroy(&block->ports);
>> >       kfree_rcu(block, rcu);
>> > }
>> >
>> >@@ -1002,6 +1003,7 @@ static struct tcf_block *tcf_block_create(struct net *net, struct Qdisc *q,
>> >       refcount_set(&block->refcnt, 1);
>> >       block->net = net;
>> >       block->index = block_index;
>> >+      xa_init(&block->ports);
>> >
>> >       /* Don't store q pointer for blocks which are shared */
>> >       if (!tcf_block_shared(block))
>> >diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
>> >index e9eaf637220e..09ec64f2f463 100644
>> >--- a/net/sched/sch_api.c
>> >+++ b/net/sched/sch_api.c
>> >@@ -1180,6 +1180,57 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
>> >       return 0;
>> > }
>> >
>> >+static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *dev,
>> >+                             struct nlattr **tca,
>> >+                             struct netlink_ext_ack *extack)
>> >+{
>> >+      const struct Qdisc_class_ops *cl_ops = sch->ops->cl_ops;
>> >+      struct tcf_block *in_block = NULL;
>> >+      struct tcf_block *eg_block = NULL;
>>
>> No need to null.
>>
>> Can't you just have:
>>         struct tcf_block *block;
>>
>>         And use it in both ifs? You can easily obtain the block again on
>>         the error path.
>>
>
>It's just easier to read.

Hmm.

>
>> >+      int err;
>> >+
>> >+      if (tca[TCA_INGRESS_BLOCK]) {
>> >+              /* works for both ingress and clsact */
>> >+              in_block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>> >+              if (!in_block) {
>>
>> I don't see how this could happen. In fact, why exactly do you check
>> tca[TCA_INGRESS_BLOCK]?
>>
>
>It's lazy but what is wrong with doing that?

It's not needed, that's wrong.


>
>> At this time, the clsact/ingress init() function was already called, you
>> can just do:
>>
>>         block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>>         if (block) {
>>                 err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>>                 if (err) {
>>                         NL_SET_ERR_MSG(extack, "Ingress block dev insert failed");
>>                         return err;
>>                 }
>>                 netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL);
>>         }
>>         block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
>>         if (block) {
>>                 err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>>                 if (err) {
>>                         NL_SET_ERR_MSG(extack, "Egress block dev insert failed");
>>                         goto err_out;
>>                 }
>>                 netdev_hold(dev, &sch->eg_block_tracker, GFP_KERNEL);
>>         }
>>         return 0;
>>
>> err_out:
>>         block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>>         if (block) {
>>                 xa_erase(&block->ports, dev->ifindex);
>>                 netdev_put(dev, &sch->in_block_tracker);
>>         }
>>         return err;
>>
>> >+                      NL_SET_ERR_MSG(extack, "Shared ingress block missing");
>> >+                      return -EINVAL;
>> >+              }
>> >+
>> >+              err = xa_insert(&in_block->ports, dev->ifindex, dev, GFP_KERNEL);
>> >+              if (err) {
>> >+                      NL_SET_ERR_MSG(extack, "Ingress block dev insert failed");
>> >+                      return err;
>> >+              }
>> >+
>
>How about a middle ground:
>        in_block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>        if (in_block) {
>                err = xa_insert(&in_block->ports, dev->ifindex, dev,
>GFP_KERNEL);
>                if (err) {
>                        NL_SET_ERR_MSG(extack, "ingress block dev
>insert failed");
>                        return err;
>                }
>                netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL)
>      }
>       eg_block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
>        if (eg_block) {
>                err = xa_insert(&eg_block->ports, dev->ifindex, dev,
>GFP_KERNEL);
>                if (err) {
>                        netdev_put(dev, &sch->eg_block_tracker);
>                        NL_SET_ERR_MSG(extack, "Egress block dev
>insert failed");
>                        xa_erase(&in_block->ports, dev->ifindex);
>                        netdev_put(dev, &sch->in_block_tracker);
>                        return err;
>                }
>                netdev_hold(dev, &sch->eg_block_tracker, GFP_KERNEL);
>        }
>        return 0;
>
>> >+              netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL);
>>
>> Why exactly do you need an extra reference of netdev? Qdisc is already
>> having one.
>
>More fine grained tracking.

Again, good for what exactly?


>
>>
>> >+      }
>> >+
>> >+      if (tca[TCA_EGRESS_BLOCK]) {
>> >+              eg_block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
>> >+              if (!eg_block) {
>> >+                      NL_SET_ERR_MSG(extack, "Shared egress block missing");
>> >+                      err = -EINVAL;
>> >+                      goto err_out;
>> >+              }
>> >+
>> >+              err = xa_insert(&eg_block->ports, dev->ifindex, dev, GFP_KERNEL);
>> >+              if (err) {
>> >+                      NL_SET_ERR_MSG(extack, "Egress block dev insert failed");
>> >+                      goto err_out;
>> >+              }
>> >+              netdev_hold(dev, &sch->eg_block_tracker, GFP_KERNEL);
>> >+      }
>> >+
>> >+      return 0;
>> >+err_out:
>> >+      if (in_block) {
>> >+              xa_erase(&in_block->ports, dev->ifindex);
>> >+              netdev_put(dev, &sch->in_block_tracker);
>> >+      }
>> >+      return err;
>> >+}
>> >+
>> > static int qdisc_block_indexes_set(struct Qdisc *sch, struct nlattr **tca,
>> >                                  struct netlink_ext_ack *extack)
>> > {
>> >@@ -1350,6 +1401,10 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
>> >       qdisc_hash_add(sch, false);
>> >       trace_qdisc_create(ops, dev, parent);
>> >
>> >+      err = qdisc_block_add_dev(sch, dev, tca, extack);
>> >+      if (err)
>> >+              goto err_out4;
>> >+
>> >       return sch;
>> >
>> > err_out4:
>> >diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
>> >index 8dd0e5925342..32bed60dea9f 100644
>> >--- a/net/sched/sch_generic.c
>> >+++ b/net/sched/sch_generic.c
>> >@@ -1050,7 +1050,11 @@ static void qdisc_free_cb(struct rcu_head *head)
>> >
>> > static void __qdisc_destroy(struct Qdisc *qdisc)
>> > {
>> >-      const struct Qdisc_ops  *ops = qdisc->ops;
>> >+      struct net_device *dev = qdisc_dev(qdisc);
>> >+      const struct Qdisc_ops *ops = qdisc->ops;
>> >+      const struct Qdisc_class_ops *cops;
>> >+      struct tcf_block *block;
>> >+      u32 block_index;
>> >
>> > #ifdef CONFIG_NET_SCHED
>> >       qdisc_hash_del(qdisc);
>> >@@ -1061,11 +1065,34 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
>> >
>> >       qdisc_reset(qdisc);
>> >
>> >+      cops = ops->cl_ops;
>> >+      if (ops->ingress_block_get) {
>> >+              block_index = ops->ingress_block_get(qdisc);
>> >+              if (block_index) {
>>
>> I don't follow. What you need block_index for? Why can't you just call:
>>         block = cops->tcf_block(qdisc, TC_H_MIN_INGRESS, NULL);
>> right away?
>
>Good point.
>
>cheers,
>jamal
>
>>
>> >+                      block = cops->tcf_block(qdisc, TC_H_MIN_INGRESS, NULL);
>> >+                      if (block) {
>> >+                              if (xa_erase(&block->ports, dev->ifindex))
>> >+                                      netdev_put(dev, &qdisc->in_block_tracker);
>> >+                      }
>> >+              }
>> >+      }
>> >+
>> >+      if (ops->egress_block_get) {
>> >+              block_index = ops->egress_block_get(qdisc);
>> >+              if (block_index) {
>> >+                      block = cops->tcf_block(qdisc, TC_H_MIN_EGRESS, NULL);
>> >+                      if (block) {
>> >+                              if (xa_erase(&block->ports, dev->ifindex))
>> >+                                      netdev_put(dev, &qdisc->eg_block_tracker);
>> >+                      }
>> >+              }
>> >+      }
>> >+
>> >       if (ops->destroy)
>> >               ops->destroy(qdisc);
>> >
>> >       module_put(ops->owner);
>> >-      netdev_put(qdisc_dev(qdisc), &qdisc->dev_tracker);
>> >+      netdev_put(dev, &qdisc->dev_tracker);
>> >
>> >       trace_qdisc_destroy(qdisc);
>> >
>> >--
>> >2.25.1
>> >

