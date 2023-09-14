Return-Path: <netdev+bounces-33743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E11F79FD95
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 09:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C2D1F2244F
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 07:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCE4CA49;
	Thu, 14 Sep 2023 07:56:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E35C8D5
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 07:56:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 797C11BF6
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 00:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694678196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48+t5z/Kb5OpcvXQj7/KchS7kZkd1CvxVF0fh6jW5kk=;
	b=eRJDSkGJHSNpc2Rd2LdlYMZrxcWoJ1Bq0FulSAuASUZCjgieoA4uinWRuxcfvuHJDvvgzn
	8ctP7Y+OH+zyTbHBbBDcllSmOQwPZsXFTWesHlXNgWD6iMoFqkbbQQob9hzJ1k0oGSqwXb
	rGUVRXKxT1ymSXKbZY+4fepAKfBZvJs=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-vtaPifl6Opy-ZLxMk505cw-1; Thu, 14 Sep 2023 03:56:33 -0400
X-MC-Unique: vtaPifl6Opy-ZLxMk505cw-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5769346dc50so169549eaf.0
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 00:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694678193; x=1695282993;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=48+t5z/Kb5OpcvXQj7/KchS7kZkd1CvxVF0fh6jW5kk=;
        b=J4sRKkSuoHqBbhaDf5uNmvLZ2XdAE9GZ6qF81spyltYjM6stw+zG8ZQr449JBj6VFx
         7qhVlwcJgBXOF5i3zojX7Bj97Fxz5VU3hOF/6JpwrZ+hWUwZBzDfCi5KhjoZq/l+4rVl
         ztDUdbNqI5d4flfRZ95QjQbpw8gSsm6ZM4fD9v7z3u1fFMZ936zvzRrLUEIxc0V21XR/
         vhG8vD5EvzUeKYNCItnhNCdrsKhQ/dlqeN3sjQAOXilqcwWIVXvMC4vn9RUzqeLMbMkY
         cCIAXdtC6CwWAq5RS+6LBvYzZcsVxTnRcteohA1Krx4gJJc5vFo1HbsgK5Wen6hAIiBA
         m+Cg==
X-Gm-Message-State: AOJu0YzK3ugrLEK8e+rTWANUQYLblPSGxZ91pw3v7u4L2JjEnwb8wAZN
	5exEIGtCWWlLObfPhEQARWCzKUIW4E2+eYG9rxYkQaGHl4eiB1qL9AZHGn9OR3h+PGQYdEZkNQL
	SoGFLRTj3SF/n99N8
X-Received: by 2002:a4a:ddc2:0:b0:573:4a72:6ec with SMTP id i2-20020a4addc2000000b005734a7206ecmr5330925oov.1.1694678193106;
        Thu, 14 Sep 2023 00:56:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbClAPwUGkufnJeRZuQc+06gc2fm09HfiV0u+Zf9MCC3XHdx01xDpYAENI+kC2txWnCwjMJw==
X-Received: by 2002:a4a:ddc2:0:b0:573:4a72:6ec with SMTP id i2-20020a4addc2000000b005734a7206ecmr5330903oov.1.1694678192723;
        Thu, 14 Sep 2023 00:56:32 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-187.dyn.eolo.it. [146.241.242.187])
        by smtp.gmail.com with ESMTPSA id a36-20020a4a98a7000000b005658aed310bsm405867ooj.15.2023.09.14.00.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 00:56:32 -0700 (PDT)
Message-ID: <55c8780bd9c4e8bf9bffef3d8becf7eb094677dc.camel@redhat.com>
Subject: Re: [PATCH net-next v3 3/3] net/sched: act_blockcast: Introduce
 blockcast tc action
From: Paolo Abeni <pabeni@redhat.com>
To: Victor Nogueira <victor@mojatatu.com>, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org
Cc: mleitner@redhat.com, vladbu@nvidia.com, horms@kernel.org, 
	pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
Date: Thu, 14 Sep 2023 09:56:28 +0200
In-Reply-To: <20230911232749.14959-4-victor@mojatatu.com>
References: <20230911232749.14959-1-victor@mojatatu.com>
	 <20230911232749.14959-4-victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-09-11 at 20:27 -0300, Victor Nogueira wrote:
> This action takes advantage of the presence of tc block ports set in the
> datapath and broadcast a packet to all ports on that set with exception o=
f
> the port in which it arrived on.
>=20
> Example usage:
>     $ tc qdisc add dev ens7 ingress block 22
>     $ tc qdisc add dev ens8 ingress block 22
>=20
> Now we can add a filter using the block index:
> $ tc filter add block 22 protocol ip pref 25 \
>   flower dst_ip 192.168.0.0/16 action blockcast
>=20
> Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
>  include/net/tc_wrapper.h     |   5 +
>  include/uapi/linux/pkt_cls.h |   1 +
>  net/sched/Kconfig            |  13 ++
>  net/sched/Makefile           |   1 +
>  net/sched/act_blockcast.c    | 297 +++++++++++++++++++++++++++++++++++
>  5 files changed, 317 insertions(+)
>  create mode 100644 net/sched/act_blockcast.c
>=20
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
> @@ -57,6 +58,10 @@ static inline int tc_act(struct sk_buff *skb, const st=
ruct tc_action *a,
>  	if (a->ops->act =3D=3D tcf_mirred_act)
>  		return tcf_mirred_act(skb, a, res);
>  #endif
> +#if IS_BUILTIN(CONFIG_NET_ACT_BLOCKCAST)
> +	if (a->ops->act =3D=3D tcf_blockcast_run)
> +		return tcf_blockcast_run(skb, a, res);
> +#endif
>  #if IS_BUILTIN(CONFIG_NET_ACT_PEDIT)
>  	if (a->ops->act =3D=3D tcf_pedit_act)
>  		return tcf_pedit_act(skb, a, res);
> diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
> index c7082cc60d21..e12fc51c1be1 100644
> --- a/include/uapi/linux/pkt_cls.h
> +++ b/include/uapi/linux/pkt_cls.h
> @@ -139,6 +139,7 @@ enum tca_id {
>  	TCA_ID_MPLS,
>  	TCA_ID_CT,
>  	TCA_ID_GATE,
> +	TCA_ID_BLOCKCAST,
>  	/* other actions go here */
>  	__TCA_ID_MAX =3D 255
>  };
> diff --git a/net/sched/Kconfig b/net/sched/Kconfig
> index 470c70deffe2..abf26f0c921f 100644
> --- a/net/sched/Kconfig
> +++ b/net/sched/Kconfig
> @@ -780,6 +780,19 @@ config NET_ACT_SIMP
>  	  To compile this code as a module, choose M here: the
>  	  module will be called act_simple.
> =20
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
> @@ -17,6 +17,7 @@ obj-$(CONFIG_NET_ACT_IPT)	+=3D act_ipt.o
>  obj-$(CONFIG_NET_ACT_NAT)	+=3D act_nat.o
>  obj-$(CONFIG_NET_ACT_PEDIT)	+=3D act_pedit.o
>  obj-$(CONFIG_NET_ACT_SIMP)	+=3D act_simple.o
> +obj-$(CONFIG_NET_ACT_BLOCKCAST)	+=3D act_blockcast.o
>  obj-$(CONFIG_NET_ACT_SKBEDIT)	+=3D act_skbedit.o
>  obj-$(CONFIG_NET_ACT_CSUM)	+=3D act_csum.o
>  obj-$(CONFIG_NET_ACT_MPLS)	+=3D act_mpls.o
> diff --git a/net/sched/act_blockcast.c b/net/sched/act_blockcast.c
> new file mode 100644
> index 000000000000..823a7c209173
> --- /dev/null
> +++ b/net/sched/act_blockcast.c
> @@ -0,0 +1,297 @@
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
> +#define CAST_RECURSION_LIMIT  4
> +
> +static DEFINE_PER_CPU(unsigned int, redirect_rec_level);
> +
> +static int cast_one(struct sk_buff *skb, const u32 ifindex)
> +{
> +	struct sk_buff *skb2 =3D skb;
> +	int retval =3D TC_ACT_PIPE;
> +	struct net_device *dev;
> +	unsigned int rec_level;
> +	bool expects_nh;
> +	int mac_len;
> +	bool at_nh;
> +	int err;
> +
> +	rec_level =3D __this_cpu_inc_return(redirect_rec_level);
> +	if (unlikely(rec_level > CAST_RECURSION_LIMIT)) {
> +		net_warn_ratelimited("blockcast: exceeded redirect recursion limit on =
dev %s\n",
> +				     netdev_name(skb->dev));
> +		__this_cpu_dec(redirect_rec_level);
> +		return TC_ACT_SHOT;

You can avoid a bunch of duplicate code replacing the error paths with:

		goto out_shot;

> +	}
> +
> +	dev =3D dev_get_by_index_rcu(dev_net(skb->dev), ifindex);
> +	if (unlikely(!dev)) {
> +		__this_cpu_dec(redirect_rec_level);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	if (unlikely(!(dev->flags & IFF_UP) || !netif_carrier_ok(dev))) {
> +		__this_cpu_dec(redirect_rec_level);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	skb2 =3D skb_clone(skb, GFP_ATOMIC);
> +	if (!skb2) {
> +		__this_cpu_dec(redirect_rec_level);
> +		return retval;
> +	}
> +
> +	nf_reset_ct(skb2);
> +
> +	expects_nh =3D !dev_is_mac_header_xmit(dev);
> +	at_nh =3D skb->data =3D=3D skb_network_header(skb);
> +	if (at_nh !=3D expects_nh) {
> +		mac_len =3D skb_at_tc_ingress(skb) ?
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
> +	skb2->skb_iif =3D skb->dev->ifindex;
> +	skb2->dev =3D dev;
> +
> +	err =3D dev_queue_xmit(skb2);
> +	if (err)
> +		retval =3D TC_ACT_SHOT;
> +

Here with:

		goto out_shot;
out:


> +	__this_cpu_dec(redirect_rec_level);
> +
> +	return retval;

And finally:

out_shot:
	retval =3D TC_ACT_SHOT;
	goto out;



> +}
> +
> +TC_INDIRECT_SCOPE int tcf_blockcast_run(struct sk_buff *skb,
> +					const struct tc_action *a,
> +					struct tcf_result *res)
> +{
> +	u32 block_index =3D qdisc_skb_cb(skb)->block_index;
> +	struct tcf_blockcast_act *p =3D to_blockcast_act(a);
> +	int action =3D READ_ONCE(p->tcf_action);
> +	struct net *net =3D dev_net(skb->dev);
> +	struct tcf_block *block;
> +	struct net_device *dev;
> +	u32 exception_ifindex;
> +	unsigned long index;
> +
> +	block =3D tcf_block_lookup(net, block_index);
> +	exception_ifindex =3D skb->dev->ifindex;
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
> +		if (index =3D=3D exception_ifindex)
> +			continue;
> +
> +		err =3D cast_one(skb, dev->ifindex);
> +		if (err !=3D TC_ACT_PIPE)
> +			tcf_action_inc_overlimit_qstats(&p->common);
> +	}
> +
> +act_done:
> +	if (action =3D=3D TC_ACT_SHOT)
> +		tcf_action_inc_drop_qstats(&p->common);
> +	return action;
> +}
> +
> +static const struct nla_policy blockcast_policy[TCA_DEF_MAX + 1] =3D {
> +	[TCA_DEF_PARMS]	=3D { .len =3D sizeof(struct tc_defact) },
> +};
> +
> +static int tcf_blockcast_init(struct net *net, struct nlattr *nla,
> +			      struct nlattr *est, struct tc_action **a,
> +			      struct tcf_proto *tp, u32 flags,
> +			      struct netlink_ext_ack *extack)
> +{
> +	struct tc_action_net *tn =3D net_generic(net, act_blockcast_ops.net_id)=
;
> +	struct tcf_blockcast_act *p =3D to_blockcast_act(a);
> +	bool bind =3D flags & TCA_ACT_FLAGS_BIND;
> +	struct nlattr *tb[TCA_DEF_MAX + 1];
> +	struct tcf_chain *goto_ch =3D NULL;
> +	struct tc_defact *parm;
> +	bool exists =3D false;
> +	int ret =3D 0, err;
> +	u32 index;
> +
> +	if (!nla)
> +		return -EINVAL;
> +
> +	err =3D nla_parse_nested(tb, TCA_DEF_MAX, nla,
> +			       blockcast_policy, extack);
> +	if (err < 0)
> +		return err;
> +
> +	if (!tb[TCA_DEF_PARMS])
> +		return -EINVAL;
> +
> +	parm =3D nla_data(tb[TCA_DEF_PARMS]);
> +	index =3D parm->index;
> +
> +	err =3D tcf_idr_check_alloc(tn, &index, a, bind);
> +	if (err < 0)
> +		return err;
> +
> +	exists =3D err;
> +	if (exists && bind)
> +		return 0;
> +
> +	if (!exists) {
> +		ret =3D tcf_idr_create_from_flags(tn, index, est, a,
> +						&act_blockcast_ops, bind, flags);
> +		if (ret) {
> +			tcf_idr_cleanup(tn, index);
> +			return ret;
> +		}
> +
> +		ret =3D ACT_P_CREATED;
> +	} else {
> +		if (!(flags & TCA_ACT_FLAGS_REPLACE)) {
> +			err =3D -EEXIST;
> +			goto release_idr;
> +		}
> +	}
> +
> +	err =3D tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
> +	if (err < 0)
> +		goto release_idr;
> +
> +	if (exists) {
> +		spin_lock_bh(&p->tcf_lock);
> +		goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> +		spin_unlock_bh(&p->tcf_lock);
> +	} else {
> +		goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> +	}
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
> +	unsigned char *b =3D skb_tail_pointer(skb);
> +	struct tcf_blockcast_act *p =3D to_blockcast_act(a);
> +	struct tc_defact opt =3D {
> +		.index   =3D p->tcf_index,
> +		.refcnt  =3D refcount_read(&p->tcf_refcnt) - ref,
> +		.bindcnt =3D atomic_read(&p->tcf_bindcnt) - bind,
> +	};
> +	struct tcf_t t;
> +
> +	spin_lock_bh(&p->tcf_lock);
> +	opt.action =3D p->tcf_action;
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
> +static struct tc_action_ops act_blockcast_ops =3D {
> +	.kind		=3D	"blockcast",
> +	.id		=3D	TCA_ID_BLOCKCAST,
> +	.owner		=3D	THIS_MODULE,
> +	.act		=3D	tcf_blockcast_run,
> +	.dump		=3D	tcf_blockcast_dump,
> +	.init		=3D	tcf_blockcast_init,
> +	.size		=3D	sizeof(struct tcf_blockcast_act),
> +};
> +
> +static __net_init int blockcast_init_net(struct net *net)
> +{
> +	struct tc_action_net *tn =3D net_generic(net, act_blockcast_ops.net_id)=
;
> +
> +	return tc_action_net_init(net, tn, &act_blockcast_ops);
> +}
> +
> +static void __net_exit blockcast_exit_net(struct list_head *net_list)
> +{
> +	tc_action_net_exit(net_list, act_blockcast_ops.net_id);
> +}
> +
> +static struct pernet_operations blockcast_net_ops =3D {
> +	.init =3D blockcast_init_net,
> +	.exit_batch =3D blockcast_exit_net,
> +	.id   =3D &act_blockcast_ops.net_id,
> +	.size =3D sizeof(struct tc_action_net),
> +};
> +
> +MODULE_AUTHOR("Mojatatu Networks, Inc");
> +MODULE_LICENSE("GPL");

The CI is complaining about the lack of MODULE_DESCRIPTION()

Cheers,

Paolo


