Return-Path: <netdev+bounces-57957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F701814952
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 14:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B941C23249
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 13:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7E62DB99;
	Fri, 15 Dec 2023 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DU58M7eH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB52DB91
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c69403b3eso6219445e9.3
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 05:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702647109; x=1703251909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fknnBHAUDHqih7lWjNaXjjlEh6BAM5q393HmPyhGQWc=;
        b=DU58M7eHUrOS1d+IyQAKCBt05cum7RPCksA6TnE1xk4zybu5s6egZPsvLO9m3gNBiH
         bVjxr0b1iDAg/ncHyX16+4JCa+t8i4utiVZ8x47z06V7dQkKIR353wMv5Bzokst2ia4J
         5fy4K5f9XxKGhNjuFdoXwwbQR023g5pGGbCCBXWwVB/spKOqk05YbE7huimAZ+ladM3g
         cIZUvvQOjUS4zwx/bUAj2TGQ5eTNpHHAGeqJPXQuxnC+ZECjPDN9439q1FCzjO88Gg4m
         Ya4dbLpV6Q/uCv5NMbSvjufpuHjyLr2ikLxTs1Tq5e9s+Vjty9z/F3JdU/cnl8GVfpei
         RNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702647109; x=1703251909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fknnBHAUDHqih7lWjNaXjjlEh6BAM5q393HmPyhGQWc=;
        b=g9pUvsfizftrHEQmBg/Im5Bz8BM0uHEqVQGOGutzVjvqCxu+LB7JWqbCc74XWx90d9
         c+5CPgBPpqjlNQAsM/liy3EEBSxfz7MnFgiy3CTciIfxIN38D0dEUjJYAXIfplAhAQtO
         OdIqwWQaLRCm7/p1ea1Cq5NcBZeAEduklx5e6v4BYRgF4AicgFIwcSyP0KnhjmLIm9jo
         /WOfYFjvrSw1wMSToX2jB/kI6wn+NhxsQV7lE1Hz6JT8fDTpcZxn9EGZhoZVwpjQvG1z
         qCVBGqDs8JDrvJIV93Q0lunw1pGtYR0p5wxcr6dzDxrIebCaxZ2Ain5BGfV34S+4Cc0A
         DvDQ==
X-Gm-Message-State: AOJu0YxBTkT5MoK/mPNVq5VKqjqW/UtMZp3u4FA6Z3FAporih6t06kuG
	nHpXxm/AAdfDv/fYO0J1A/3t6w==
X-Google-Smtp-Source: AGHT+IGwZyifJQf8bQosNR3q61b+4xdyqw6UPZCfp50CKYOfTeE0U4hoJmZtpILEI8WIg7kxN2LMTQ==
X-Received: by 2002:a05:600c:4c8a:b0:40c:377c:4b66 with SMTP id g10-20020a05600c4c8a00b0040c377c4b66mr6495671wmp.76.1702647109038;
        Fri, 15 Dec 2023 05:31:49 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c459400b0040b349c91acsm31218203wmo.16.2023.12.15.05.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 05:31:48 -0800 (PST)
Date: Fri, 15 Dec 2023 14:31:47 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com,
	mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com,
	pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next v7 1/3] net/sched: Introduce tc block netdev
 tracking infra
Message-ID: <ZXxVQ0E-kd-ab3XD@nanopsycho>
References: <20231215111050.3624740-1-victor@mojatatu.com>
 <20231215111050.3624740-2-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215111050.3624740-2-victor@mojatatu.com>

Fri, Dec 15, 2023 at 12:10:48PM CET, victor@mojatatu.com wrote:
>This commit makes tc blocks track which ports have been added to them.
>And, with that, we'll be able to use this new information to send
>packets to the block's ports. Which will be done in the patch #3 of this
>series.
>
>Suggested-by: Jiri Pirko <jiri@nvidia.com>
>Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
>Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>---
> include/net/sch_generic.h |  4 +++
> net/sched/cls_api.c       |  2 ++
> net/sched/sch_api.c       | 55 +++++++++++++++++++++++++++++++++++++++
> net/sched/sch_generic.c   | 31 ++++++++++++++++++++--
> 4 files changed, 90 insertions(+), 2 deletions(-)
>
>diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
>index dcb9160e6467..cefca55dd4f9 100644
>--- a/include/net/sch_generic.h
>+++ b/include/net/sch_generic.h
>@@ -19,6 +19,7 @@
> #include <net/gen_stats.h>
> #include <net/rtnetlink.h>
> #include <net/flow_offload.h>
>+#include <linux/xarray.h>
> 
> struct Qdisc_ops;
> struct qdisc_walker;
>@@ -126,6 +127,8 @@ struct Qdisc {
> 
> 	struct rcu_head		rcu;
> 	netdevice_tracker	dev_tracker;
>+	netdevice_tracker	in_block_tracker;
>+	netdevice_tracker	eg_block_tracker;
> 	/* private data */
> 	long privdata[] ____cacheline_aligned;
> };
>@@ -457,6 +460,7 @@ struct tcf_chain {
> };
> 
> struct tcf_block {
>+	struct xarray ports; /* datapath accessible */
> 	/* Lock protects tcf_block and lifetime-management data of chains
> 	 * attached to the block (refcnt, action_refcnt, explicitly_created).
> 	 */
>diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
>index dc1c19a25882..6020a32ecff2 100644
>--- a/net/sched/cls_api.c
>+++ b/net/sched/cls_api.c
>@@ -531,6 +531,7 @@ static void tcf_block_destroy(struct tcf_block *block)
> {
> 	mutex_destroy(&block->lock);
> 	mutex_destroy(&block->proto_destroy_lock);
>+	xa_destroy(&block->ports);
> 	kfree_rcu(block, rcu);
> }
> 
>@@ -1002,6 +1003,7 @@ static struct tcf_block *tcf_block_create(struct net *net, struct Qdisc *q,
> 	refcount_set(&block->refcnt, 1);
> 	block->net = net;
> 	block->index = block_index;
>+	xa_init(&block->ports);
> 
> 	/* Don't store q pointer for blocks which are shared */
> 	if (!tcf_block_shared(block))
>diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
>index e9eaf637220e..09ec64f2f463 100644
>--- a/net/sched/sch_api.c
>+++ b/net/sched/sch_api.c
>@@ -1180,6 +1180,57 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
> 	return 0;
> }
> 
>+static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *dev,
>+			       struct nlattr **tca,
>+			       struct netlink_ext_ack *extack)
>+{
>+	const struct Qdisc_class_ops *cl_ops = sch->ops->cl_ops;
>+	struct tcf_block *in_block = NULL;
>+	struct tcf_block *eg_block = NULL;

No need to null.

Can't you just have:
	struct tcf_block *block;

	And use it in both ifs? You can easily obtain the block again on
	the error path.

>+	int err;
>+
>+	if (tca[TCA_INGRESS_BLOCK]) {
>+		/* works for both ingress and clsact */
>+		in_block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>+		if (!in_block) {

I don't see how this could happen. In fact, why exactly do you check
tca[TCA_INGRESS_BLOCK]?

At this time, the clsact/ingress init() function was already called, you
can just do:

	block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
	if (block) {
		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
		if (err) {
			NL_SET_ERR_MSG(extack, "Ingress block dev insert failed");
			return err;
		}
		netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL);
	}
	block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
	if (block) {
		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
		if (err) {
			NL_SET_ERR_MSG(extack, "Egress block dev insert failed");
			goto err_out;
		}
		netdev_hold(dev, &sch->eg_block_tracker, GFP_KERNEL);
	}
	return 0;

err_out:
	block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
	if (block) {
		xa_erase(&block->ports, dev->ifindex);
		netdev_put(dev, &sch->in_block_tracker);
	}
	return err;

>+			NL_SET_ERR_MSG(extack, "Shared ingress block missing");
>+			return -EINVAL;
>+		}
>+
>+		err = xa_insert(&in_block->ports, dev->ifindex, dev, GFP_KERNEL);
>+		if (err) {
>+			NL_SET_ERR_MSG(extack, "Ingress block dev insert failed");
>+			return err;
>+		}
>+
>+		netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL);

Why exactly do you need an extra reference of netdev? Qdisc is already
having one.


>+	}
>+
>+	if (tca[TCA_EGRESS_BLOCK]) {
>+		eg_block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
>+		if (!eg_block) {
>+			NL_SET_ERR_MSG(extack, "Shared egress block missing");
>+			err = -EINVAL;
>+			goto err_out;
>+		}
>+
>+		err = xa_insert(&eg_block->ports, dev->ifindex, dev, GFP_KERNEL);
>+		if (err) {
>+			NL_SET_ERR_MSG(extack, "Egress block dev insert failed");
>+			goto err_out;
>+		}
>+		netdev_hold(dev, &sch->eg_block_tracker, GFP_KERNEL);
>+	}
>+
>+	return 0;
>+err_out:
>+	if (in_block) {
>+		xa_erase(&in_block->ports, dev->ifindex);
>+		netdev_put(dev, &sch->in_block_tracker);
>+	}
>+	return err;
>+}
>+
> static int qdisc_block_indexes_set(struct Qdisc *sch, struct nlattr **tca,
> 				   struct netlink_ext_ack *extack)
> {
>@@ -1350,6 +1401,10 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
> 	qdisc_hash_add(sch, false);
> 	trace_qdisc_create(ops, dev, parent);
> 
>+	err = qdisc_block_add_dev(sch, dev, tca, extack);
>+	if (err)
>+		goto err_out4;
>+
> 	return sch;
> 
> err_out4:
>diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
>index 8dd0e5925342..32bed60dea9f 100644
>--- a/net/sched/sch_generic.c
>+++ b/net/sched/sch_generic.c
>@@ -1050,7 +1050,11 @@ static void qdisc_free_cb(struct rcu_head *head)
> 
> static void __qdisc_destroy(struct Qdisc *qdisc)
> {
>-	const struct Qdisc_ops  *ops = qdisc->ops;
>+	struct net_device *dev = qdisc_dev(qdisc);
>+	const struct Qdisc_ops *ops = qdisc->ops;
>+	const struct Qdisc_class_ops *cops;
>+	struct tcf_block *block;
>+	u32 block_index;
> 
> #ifdef CONFIG_NET_SCHED
> 	qdisc_hash_del(qdisc);
>@@ -1061,11 +1065,34 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
> 
> 	qdisc_reset(qdisc);
> 
>+	cops = ops->cl_ops;
>+	if (ops->ingress_block_get) {
>+		block_index = ops->ingress_block_get(qdisc);
>+		if (block_index) {

I don't follow. What you need block_index for? Why can't you just call:
	block = cops->tcf_block(qdisc, TC_H_MIN_INGRESS, NULL);
right away?


>+			block = cops->tcf_block(qdisc, TC_H_MIN_INGRESS, NULL);
>+			if (block) {
>+				if (xa_erase(&block->ports, dev->ifindex))
>+					netdev_put(dev, &qdisc->in_block_tracker);
>+			}
>+		}
>+	}
>+
>+	if (ops->egress_block_get) {
>+		block_index = ops->egress_block_get(qdisc);
>+		if (block_index) {
>+			block = cops->tcf_block(qdisc, TC_H_MIN_EGRESS, NULL);
>+			if (block) {
>+				if (xa_erase(&block->ports, dev->ifindex))
>+					netdev_put(dev, &qdisc->eg_block_tracker);
>+			}
>+		}
>+	}
>+
> 	if (ops->destroy)
> 		ops->destroy(qdisc);
> 
> 	module_put(ops->owner);
>-	netdev_put(qdisc_dev(qdisc), &qdisc->dev_tracker);
>+	netdev_put(dev, &qdisc->dev_tracker);
> 
> 	trace_qdisc_destroy(qdisc);
> 
>-- 
>2.25.1
>

