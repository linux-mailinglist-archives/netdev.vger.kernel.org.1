Return-Path: <netdev+bounces-30081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A7C785F06
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90DC1C20C2D
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 17:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA301F195;
	Wed, 23 Aug 2023 17:58:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BD21ED59
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 17:58:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24588CC7
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692813509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t1UJVum5OFZ6ifNpzC4nr43smcpk2HAWInG4I2g+yMA=;
	b=TXEe8I12u/+9CXZnB+/xtCyVXmK3Ezl9PFSiJM7YumqpIxOPk6rBvVpGRbDEFmzv6u5E+t
	KmL0WOr11ShdP1mfDu7KWdnbIN+M8/H6WSuZb8Fo6xnwVCGLw9LP7P61QWdkA07pcLyoub
	LNpL56HF4CK03DtRUSmhyg3rw6A/NEE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-ZcYc8xZXNMi42YV0qbpQnw-1; Wed, 23 Aug 2023 13:58:27 -0400
X-MC-Unique: ZcYc8xZXNMi42YV0qbpQnw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-52a38baa269so807693a12.2
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692813505; x=1693418305;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1UJVum5OFZ6ifNpzC4nr43smcpk2HAWInG4I2g+yMA=;
        b=fW289vHa+lnvCsUt5MxEpgKIsaJcHiRtWHd2DDSQt4XQgv78Xtlm76zxHRkr1Kr0/P
         L6juiKnPO6HT/434FQ5Yo005FRNz4Bz7CPeMc3MLK3oAsVgC6f/9gylPCQBvcByv1uis
         rrGLSG/ZL1dEvUURSKffBFcAPmy/twzpbFxhscLhNxyZ4pXJ650Z3uOT3j7Y0icFavVC
         jOrFXZpS7JGAle+QsnPXPRM4yvEN0XuwmWLcKzyO2Ln30CME4N/hjIJ1iAv//KgtqqWH
         kpiBtzM4te8/i4L0E1LY2J5FM3+5rP13TC81DmY/muUpFJpg917gv1XX3ls+LKFjpz4V
         fLcA==
X-Gm-Message-State: AOJu0YzHJOSxsiM9t4cC7ji6CDcbg3FpefBMnpesL8JjoLIj81fkUB7o
	yaIu51fleUFmzQTeOUPZyW+X/ZZWVmP180lGJAE93xE7xGNSv5RAqUtv5m/K6DLya9ENqA3btB4
	CU8EV7IvTNb1y+KquGX8AWSphpKemQ9RVRKAfvNov
X-Received: by 2002:a05:6402:1817:b0:522:ca7c:df78 with SMTP id g23-20020a056402181700b00522ca7cdf78mr9946217edy.0.1692813505494;
        Wed, 23 Aug 2023 10:58:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxxEhnj5qXD1GoowCtwhf0JUrXwWOcP6zGby7ghiIkPyWoSnPT4tIFKK+jzCNRKWiAcUm/WRjg7uPtxZ5QkWs=
X-Received: by 2002:a05:6402:1817:b0:522:ca7c:df78 with SMTP id
 g23-20020a056402181700b00522ca7cdf78mr9946201edy.0.1692813505121; Wed, 23 Aug
 2023 10:58:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Aug 2023 10:58:24 -0700
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20230819163515.2266246-1-victor@mojatatu.com> <20230819163515.2266246-4-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230819163515.2266246-4-victor@mojatatu.com>
Date: Wed, 23 Aug 2023 10:58:24 -0700
Message-ID: <CALnP8ZYQJLv2zzjmg5Q6M1ZLEUm_fK9q6re7xtRsbYtTPTMbSw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net/sched: act_blockcast: Introduce
 blockcast tc action
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, vladbu@nvidia.com, horms@kernel.org, 
	pctammela@mojatatu.com, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 19, 2023 at 01:35:14PM -0300, Victor Nogueira wrote:
> This action takes advantage of the presence of tc block ports set in the
> datapath and broadcast a packet to all ports on that set with exception of
> the port in which it arrived on..

I couldn't find anything int he code blocking this action from being
used in the egress path as well. So what about: s/arrived/& or is
being transmitted/ , making it explicit that it is an expected usage?

more below

>
> Example usage:
>     $ tc qdisc add dev ens7 ingress block 22
>     $ tc qdisc add dev ens8 ingress block 22
>
> Now we can add a filter using the block index:
> $ tc filter add block 22 protocol ip pref 25 \
>   flower dst_ip 192.168.0.0/16 action blockcast
>
> Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
>  include/net/tc_wrapper.h  |   5 +
>  net/sched/Kconfig         |  13 ++
>  net/sched/Makefile        |   1 +
>  net/sched/act_blockcast.c | 299 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 318 insertions(+)
>  create mode 100644 net/sched/act_blockcast.c
>
> diff --git a/include/net/tc_wrapper.h b/include/net/tc_wrapper.h
> index a6d481b5bcbc..8ef848968be7 100644
> --- a/include/net/tc_wrapper.h
> +++ b/include/net/tc_wrapper.h
> @@ -28,6 +28,7 @@ TC_INDIRECT_ACTION_DECLARE(tcf_csum_act);
>  TC_INDIRECT_ACTION_DECLARE(tcf_ct_act);
>  TC_INDIRECT_ACTION_DECLARE(tcf_ctinfo_act);
>  TC_INDIRECT_ACTION_DECLARE(tcf_gact_act);
> +TC_INDIRECT_ACTION_DECLARE(tcf_blockcast_run);
>  TC_INDIRECT_ACTION_DECLARE(tcf_gate_act);
>  TC_INDIRECT_ACTION_DECLARE(tcf_ife_act);
>  TC_INDIRECT_ACTION_DECLARE(tcf_ipt_act);
> @@ -57,6 +58,10 @@ static inline int tc_act(struct sk_buff *skb, const struct tc_action *a,
>  	if (a->ops->act == tcf_mirred_act)
>  		return tcf_mirred_act(skb, a, res);
>  #endif
> +#if IS_BUILTIN(CONFIG_NET_ACT_BLOCKCAST)
> +	if (a->ops->act == tcf_blockcast_run)
> +		return tcf_blockcast_run(skb, a, res);
> +#endif
>  #if IS_BUILTIN(CONFIG_NET_ACT_PEDIT)
>  	if (a->ops->act == tcf_pedit_act)
>  		return tcf_pedit_act(skb, a, res);
> diff --git a/net/sched/Kconfig b/net/sched/Kconfig
> index 4b95cb1ac435..1b0edf1287d0 100644
> --- a/net/sched/Kconfig
> +++ b/net/sched/Kconfig
> @@ -780,6 +780,19 @@ config NET_ACT_SIMP
>  	  To compile this code as a module, choose M here: the
>  	  module will be called act_simple.
>
> +config NET_ACT_BLOCKCAST
> +	tristate "TC block Multicast"
> +	depends on NET_CLS_ACT
> +	help
> +	  Say Y here to add an action that will multicast an skb to egress of
> +	  all netdevs that belong to a tc block except for the netdev on which
> +          the skb arrived on
> +
> +	  If unsure, say N.
> +
> +	  To compile this code as a module, choose M here: the
> +	  module will be called act_blockcast.
> +
>  config NET_ACT_SKBEDIT
>  	tristate "SKB Editing"
>  	depends on NET_CLS_ACT
> diff --git a/net/sched/Makefile b/net/sched/Makefile
> index b5fd49641d91..2cdcf30645eb 100644
> --- a/net/sched/Makefile
> +++ b/net/sched/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_NET_ACT_IPT)	+= act_ipt.o
>  obj-$(CONFIG_NET_ACT_NAT)	+= act_nat.o
>  obj-$(CONFIG_NET_ACT_PEDIT)	+= act_pedit.o
>  obj-$(CONFIG_NET_ACT_SIMP)	+= act_simple.o
> +obj-$(CONFIG_NET_ACT_BLOCKCAST)	+= act_blockcast.o
>  obj-$(CONFIG_NET_ACT_SKBEDIT)	+= act_skbedit.o
>  obj-$(CONFIG_NET_ACT_CSUM)	+= act_csum.o
>  obj-$(CONFIG_NET_ACT_MPLS)	+= act_mpls.o
> diff --git a/net/sched/act_blockcast.c b/net/sched/act_blockcast.c
> new file mode 100644
> index 000000000000..85fd0289927c
> --- /dev/null
> +++ b/net/sched/act_blockcast.c
> @@ -0,0 +1,299 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * net/sched/act_blockcast.c	Block Cast action
> + * Copyright (c) 2023, Mojatatu Networks
> + * Authors:     Jamal Hadi Salim <jhs@mojatatu.com>
> + *              Victor Nogueira <victor@mojatatu.com>
> + *              Pedro Tammela <pctammela@mojatatu.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/skbuff.h>
> +#include <linux/rtnetlink.h>
> +#include <net/netlink.h>
> +#include <net/pkt_sched.h>
> +#include <net/pkt_cls.h>
> +#include <linux/if_arp.h>
> +#include <net/tc_wrapper.h>
> +
> +#include <linux/tc_act/tc_defact.h>
> +
> +static struct tc_action_ops act_blockcast_ops;
> +
> +struct tcf_blockcast_act {
> +	struct tc_action	common;
> +};
> +
> +#define to_blockcast_act(a) ((struct tcf_blockcast_act *)a)
> +
> +#define TCA_ID_BLOCKCAST 123

This needs to be part of enum tca_id instead, as this is uapi.

> +#define CAST_RECURSION_LIMIT  4
> +
> +static DEFINE_PER_CPU(unsigned int, redirect_rec_level);
> +
> +static int cast_one(struct sk_buff *skb, const u32 ifindex)
> +{
> +	struct sk_buff *skb2 = skb;
> +	int retval = TC_ACT_PIPE;
> +	struct net_device *dev;
> +	unsigned int rec_level;
> +	bool expects_nh;
> +	int mac_len;
> +	bool at_nh;
> +	int err;
> +
> +	rec_level = __this_cpu_inc_return(redirect_rec_level);
> +	if (unlikely(rec_level > CAST_RECURSION_LIMIT)) {
> +		net_warn_ratelimited("blockcast: exceeded redirect recursion limit on dev %s\n",
> +				     netdev_name(skb->dev));

I wrote the comment below earlier than this one :-)
Here, I would think this is really an exception path, and if this
shows up, it needs to be addressed. So this msg IMHO is fine.

> +		__this_cpu_dec(redirect_rec_level);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	dev = dev_get_by_index_rcu(dev_net(skb->dev), ifindex);
> +	if (unlikely(!dev)) {
> +		__this_cpu_dec(redirect_rec_level);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	if (unlikely(!(dev->flags & IFF_UP) || !netif_carrier_ok(dev))) {
> +		net_notice_ratelimited("blockcast: device %s is down\n",
> +				       dev->name);

Please no, not this warning. We already have a situation with mirred
and ovs bridges often being down and getting dmesg spammed. We
couldn't remove that log msg because of fear of some sysadmin missing
the hint. But here, that doesn't apply, and dmesg is not the right way
to debug packet drops.

> +		__this_cpu_dec(redirect_rec_level);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	skb2 = skb_clone(skb, GFP_ATOMIC);
> +	if (!skb2) {
> +		__this_cpu_dec(redirect_rec_level);
> +		return retval;
> +	}
> +
> +	nf_reset_ct(skb2);
> +
> +	expects_nh = !dev_is_mac_header_xmit(dev);
> +	at_nh = skb->data == skb_network_header(skb);
> +	if (at_nh != expects_nh) {
> +		mac_len = skb_at_tc_ingress(skb) ?
> +				  skb->mac_len :
> +				  skb_network_header(skb) - skb_mac_header(skb);
> +
> +		if (expects_nh) {
> +			/* target device/action expect data at nh */
> +			skb_pull_rcsum(skb2, mac_len);
> +		} else {
> +			/* target device/action expect data at mac */
> +			skb_push_rcsum(skb2, mac_len);
> +		}
> +	}
> +
> +	skb2->skb_iif = skb->dev->ifindex;
> +	skb2->dev = dev;
> +
> +	err = dev_queue_xmit(skb2);
> +	if (err)
> +		retval = TC_ACT_SHOT;
> +
> +	__this_cpu_dec(redirect_rec_level);
> +
> +	return retval;
> +}
> +
> +TC_INDIRECT_SCOPE int tcf_blockcast_run(struct sk_buff *skb,
> +					const struct tc_action *a,
> +					struct tcf_result *res)
> +{
> +	u32 block_index = qdisc_skb_cb(skb)->block_index;
> +	struct tcf_blockcast_act *p = to_blockcast_act(a);
> +	int action = READ_ONCE(p->tcf_action);
> +	struct net *net = dev_net(skb->dev);
> +	struct tcf_block *block;
> +	struct net_device *dev;
> +	u32 exception_ifindex;
> +	unsigned long index;
> +
> +	block = tcf_block_lookup(net, block_index);
> +	exception_ifindex = skb->dev->ifindex;
> +
> +	tcf_action_update_bstats(&p->common, skb);
> +	tcf_lastuse_update(&p->tcf_tm);
> +
> +	if (!block || xa_empty(&block->ports))
> +		goto act_done;
> +
> +	/* we are already under rcu protection, so iterating block is safe*/
> +	xa_for_each(&block->ports, index, dev) {
> +		int err;
> +
> +		if (index == exception_ifindex)
> +			continue;
> +
> +		err = cast_one(skb, dev->ifindex);
> +		if (err != TC_ACT_PIPE)
> +			printk("(%d)Failed to send to dev\t%d: %s\n", err,
> +			       dev->ifindex, dev->name);

Same comment here about logging.

> +	}
> +
> +act_done:
> +	if (action == TC_ACT_SHOT)
> +		tcf_action_inc_drop_qstats(&p->common);
> +	return action;
> +}
> +
> +static const struct nla_policy blockcast_policy[TCA_DEF_MAX + 1] = {
> +	[TCA_DEF_PARMS]	= { .len = sizeof(struct tc_defact) },
> +};
> +
> +static int tcf_blockcast_init(struct net *net, struct nlattr *nla,
> +			      struct nlattr *est, struct tc_action **a,
> +			      struct tcf_proto *tp, u32 flags,
> +			      struct netlink_ext_ack *extack)
> +{
> +	struct tc_action_net *tn = net_generic(net, act_blockcast_ops.net_id);
> +	struct tcf_blockcast_act *p = to_blockcast_act(a);
> +	bool bind = flags & TCA_ACT_FLAGS_BIND;
> +	struct nlattr *tb[TCA_DEF_MAX + 1];
> +	struct tcf_chain *goto_ch = NULL;
> +	struct tc_defact *parm;
> +	bool exists = false;
> +	int ret = 0, err;
> +	u32 index;
> +
> +	if (!nla)
> +		return -EINVAL;
> +
> +	err = nla_parse_nested_deprecated(tb, TCA_DEF_MAX, nla,
> +					  blockcast_policy, NULL);

Why the _deprecated one again please? This one doesn't need backwards
compatibility.

Thanks,
Marcelo

> +	if (err < 0)
> +		return err;
> +
> +	if (!tb[TCA_DEF_PARMS])
> +		return -EINVAL;
> +
> +	parm = nla_data(tb[TCA_DEF_PARMS]);
> +	index = parm->index;
> +
> +	err = tcf_idr_check_alloc(tn, &index, a, bind);
> +	if (err < 0)
> +		return err;
> +
> +	exists = err;
> +	if (exists && bind)
> +		return 0;
> +
> +	if (!exists) {
> +		ret = tcf_idr_create_from_flags(tn, index, est, a,
> +						&act_blockcast_ops, bind, flags);
> +		if (ret) {
> +			tcf_idr_cleanup(tn, index);
> +			return ret;
> +		}
> +
> +		ret = ACT_P_CREATED;
> +	} else {
> +		if (!(flags & TCA_ACT_FLAGS_REPLACE)) {
> +			err = -EEXIST;
> +			goto release_idr;
> +		}
> +	}
> +
> +	err = tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
> +	if (err < 0)
> +		goto release_idr;
> +
> +	if (exists)
> +		spin_lock_bh(&p->tcf_lock);
> +	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> +	if (exists)
> +		spin_unlock_bh(&p->tcf_lock);
> +
> +	if (goto_ch)
> +		tcf_chain_put_by_act(goto_ch);
> +
> +	return ret;
> +release_idr:
> +	tcf_idr_release(*a, bind);
> +	return err;
> +}
> +
> +static int tcf_blockcast_dump(struct sk_buff *skb, struct tc_action *a,
> +			      int bind, int ref)
> +{
> +	unsigned char *b = skb_tail_pointer(skb);
> +	struct tcf_blockcast_act *p = to_blockcast_act(a);
> +	struct tc_defact opt = {
> +		.index   = p->tcf_index,
> +		.refcnt  = refcount_read(&p->tcf_refcnt) - ref,
> +		.bindcnt = atomic_read(&p->tcf_bindcnt) - bind,
> +	};
> +	struct tcf_t t;
> +
> +	spin_lock_bh(&p->tcf_lock);
> +	opt.action = p->tcf_action;
> +	if (nla_put(skb, TCA_DEF_PARMS, sizeof(opt), &opt))
> +		goto nla_put_failure;
> +
> +	tcf_tm_dump(&t, &p->tcf_tm);
> +	if (nla_put_64bit(skb, TCA_DEF_TM, sizeof(t), &t, TCA_DEF_PAD))
> +		goto nla_put_failure;
> +	spin_unlock_bh(&p->tcf_lock);
> +
> +	return skb->len;
> +
> +nla_put_failure:
> +	spin_unlock_bh(&p->tcf_lock);
> +	nlmsg_trim(skb, b);
> +	return -1;
> +}
> +
> +static struct tc_action_ops act_blockcast_ops = {
> +	.kind		=	"blockcast",
> +	.id		=	TCA_ID_BLOCKCAST,
> +	.owner		=	THIS_MODULE,
> +	.act		=	tcf_blockcast_run,
> +	.dump		=	tcf_blockcast_dump,
> +	.init		=	tcf_blockcast_init,
> +	.size		=	sizeof(struct tcf_blockcast_act),
> +};
> +
> +static __net_init int blockcast_init_net(struct net *net)
> +{
> +	struct tc_action_net *tn = net_generic(net, act_blockcast_ops.net_id);
> +
> +	return tc_action_net_init(net, tn, &act_blockcast_ops);
> +}
> +
> +static void __net_exit blockcast_exit_net(struct list_head *net_list)
> +{
> +	tc_action_net_exit(net_list, act_blockcast_ops.net_id);
> +}
> +
> +static struct pernet_operations blockcast_net_ops = {
> +	.init = blockcast_init_net,
> +	.exit_batch = blockcast_exit_net,
> +	.id   = &act_blockcast_ops.net_id,
> +	.size = sizeof(struct tc_action_net),
> +};
> +
> +MODULE_AUTHOR("Mojatatu Networks, Inc");
> +MODULE_LICENSE("GPL");
> +
> +static int __init blockcast_init_module(void)
> +{
> +	int ret = tcf_register_action(&act_blockcast_ops, &blockcast_net_ops);
> +
> +	if (!ret)
> +		pr_info("blockcast TC action Loaded\n");
> +	return ret;
> +}
> +
> +static void __exit blockcast_cleanup_module(void)
> +{
> +	tcf_unregister_action(&act_blockcast_ops, &blockcast_net_ops);
> +}
> +
> +module_init(blockcast_init_module);
> +module_exit(blockcast_cleanup_module);
> --
> 2.25.1
>


