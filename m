Return-Path: <netdev+bounces-59783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76F281C04E
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD561F25317
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F0A77B23;
	Thu, 21 Dec 2023 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Nm4+QEEm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CFE7765B
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 21:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d408d0bb87so7734845ad.0
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 13:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703194745; x=1703799545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KY9LTnUabSNd0ZzjKC7FGUjUxod9ELJvEzlRhsdvP3w=;
        b=Nm4+QEEmFVhCxnSxRcxdjssHHZ5RNHR3EITnSPSvslxNxlxe5WIo/JnIgdBZMSW7XJ
         WfKexk4ubT283ionOYIp8oE3NyS+7LqSY4L6Fl1kMDes1zBmP/jN4iotPZ0JTQjvk3k6
         cBQN37YZyhOMhdn8fly8aU+ksFkzd9dP61gG6d1BCbWgKOzg+sAwZNigZqWUl6vqEyH0
         Q73+axDjmvUvVJrneb4Ogv3fR2Jw9jJs4b9zDvl4sxmTbPJ55+nmd04oFW7xJzHOkXKh
         zDoIvo5FSSEN66yFK8/C2LuA2bn/aMtaezOa+Kc3RtQ+sb6DSK0IjuZNEQFJey7KK6vG
         tC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703194745; x=1703799545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KY9LTnUabSNd0ZzjKC7FGUjUxod9ELJvEzlRhsdvP3w=;
        b=G/F8pxvzS2M+42qsFWW3SWg8QCs87mJPef4oml1lDojJdubuw3oiEHqS9qjc74Ax9Q
         V5pOS36YmUk0zrh7YONhciuGc0mEXDlTab4/8DIMXX2fkdw5VPaf2mALcHl2WuEH2bFx
         YCt1cGg7woqvb0Qhmyj9NPIEDlruhA3b5e0899SGj1/s4mgARqsozUt4s2sqd1X4D+rN
         aMnqpHeXAZUwuxZWfzpU9s7JY2bVOZYb+orYDAz3/M3ASuIUe+wCSurzs2WbQ47EWuYQ
         AD4za2tKq6Dmxm8CNMzjpe8qHh5k1I3/Azt0NrLPvF+M+cNap+dmHG6sCSwdPVAZbQY6
         ys0w==
X-Gm-Message-State: AOJu0YzUEosSaEssUyY8MnGfIpBpA27IVvrYrH97hPt6nAkXgLLSbGyg
	wgwFMoKmaQ7zPK5a0YDXHrZqTr2kL8YNjbBgW3RZ5jVNoA==
X-Google-Smtp-Source: AGHT+IFgUc3vlsUIM69zRNf3BLoMG7NcAm0cTqnGrfEJ+PobMbUFMBU2t0FYMJ/b6p3ZZyXxceqd9A==
X-Received: by 2002:a17:903:32c1:b0:1d0:6ffd:9e21 with SMTP id i1-20020a17090332c100b001d06ffd9e21mr278641plr.115.1703194745099;
        Thu, 21 Dec 2023 13:39:05 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001cfce833b6fsm2095607plb.204.2023.12.21.13.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 13:39:04 -0800 (PST)
Message-ID: <6aab67d6-d3cc-42f5-8ec5-dbd439d7886f@mojatatu.com>
Date: Thu, 21 Dec 2023 18:38:59 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net/sched: Retire ipt action
To: Jamal Hadi Salim <jhs@mojatatu.com>, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 stephen@networkplumber.org, dsahern@gmail.com, fw@strlen.de,
 victor@mojatatu.com
References: <20231221213105.476630-1-jhs@mojatatu.com>
 <20231221213105.476630-2-jhs@mojatatu.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20231221213105.476630-2-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/12/2023 18:31, Jamal Hadi Salim wrote:
> The tc ipt action was intended to run all netfilter/iptables target.
> Unfortunately it has not benefitted over the years from proper updates when
> netfilter changes, and for that reason it has remained rudimentary.
> Pinging a bunch of people that i was aware were using this indicates that
> removing it wont affect them.
> Retire it to reduce maintenance efforts. Buh-bye.
> 
> Reviewed-by: Victor Noguiera <victor@mojatatu.com>
> Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>   include/net/tc_act/tc_ipt.h               |  17 -
>   include/net/tc_wrapper.h                  |   4 -
>   include/uapi/linux/pkt_cls.h              |   4 +-
>   include/uapi/linux/tc_act/tc_ipt.h        |  20 -
>   net/sched/Makefile                        |   1 -
>   net/sched/act_ipt.c                       | 464 ----------------------
>   tools/testing/selftests/tc-testing/config |   1 -
>   tools/testing/selftests/tc-testing/tdc.sh |   1 -
>   8 files changed, 2 insertions(+), 510 deletions(-)
>   delete mode 100644 include/net/tc_act/tc_ipt.h
>   delete mode 100644 include/uapi/linux/tc_act/tc_ipt.h
>   delete mode 100644 net/sched/act_ipt.c
> 
> diff --git a/include/net/tc_act/tc_ipt.h b/include/net/tc_act/tc_ipt.h
> deleted file mode 100644
> index 4225fcb1c6ba..000000000000
> --- a/include/net/tc_act/tc_ipt.h
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __NET_TC_IPT_H
> -#define __NET_TC_IPT_H
> -
> -#include <net/act_api.h>
> -
> -struct xt_entry_target;
> -
> -struct tcf_ipt {
> -	struct tc_action	common;
> -	u32			tcfi_hook;
> -	char			*tcfi_tname;
> -	struct xt_entry_target	*tcfi_t;
> -};
> -#define to_ipt(a) ((struct tcf_ipt *)a)
> -
> -#endif /* __NET_TC_IPT_H */
> diff --git a/include/net/tc_wrapper.h b/include/net/tc_wrapper.h
> index a6d481b5bcbc..a608546bcefc 100644
> --- a/include/net/tc_wrapper.h
> +++ b/include/net/tc_wrapper.h
> @@ -117,10 +117,6 @@ static inline int tc_act(struct sk_buff *skb, const struct tc_action *a,
>   	if (a->ops->act == tcf_ife_act)
>   		return tcf_ife_act(skb, a, res);
>   #endif
> -#if IS_BUILTIN(CONFIG_NET_ACT_IPT)
> -	if (a->ops->act == tcf_ipt_act)
> -		return tcf_ipt_act(skb, a, res);
> -#endif
>   #if IS_BUILTIN(CONFIG_NET_ACT_SIMP)
>   	if (a->ops->act == tcf_simp_act)
>   		return tcf_simp_act(skb, a, res);
> diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
> index c7082cc60d21..2fec9b51d28d 100644
> --- a/include/uapi/linux/pkt_cls.h
> +++ b/include/uapi/linux/pkt_cls.h
> @@ -99,7 +99,7 @@ enum {
>    * versions.
>    */
>   #define TCA_ACT_GACT 5
> -#define TCA_ACT_IPT 6
> +#define TCA_ACT_IPT 6 /* obsoleted, can be reused */
>   #define TCA_ACT_PEDIT 7
>   #define TCA_ACT_MIRRED 8
>   #define TCA_ACT_NAT 9
> @@ -120,7 +120,7 @@ enum tca_id {
>   	TCA_ID_UNSPEC = 0,
>   	TCA_ID_POLICE = 1,
>   	TCA_ID_GACT = TCA_ACT_GACT,
> -	TCA_ID_IPT = TCA_ACT_IPT,
> +	TCA_ID_IPT = TCA_ACT_IPT, /* Obsoleted, can be reused */
>   	TCA_ID_PEDIT = TCA_ACT_PEDIT,
>   	TCA_ID_MIRRED = TCA_ACT_MIRRED,
>   	TCA_ID_NAT = TCA_ACT_NAT,
> diff --git a/include/uapi/linux/tc_act/tc_ipt.h b/include/uapi/linux/tc_act/tc_ipt.h
> deleted file mode 100644
> index c48d7da6750d..000000000000
> --- a/include/uapi/linux/tc_act/tc_ipt.h
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#ifndef __LINUX_TC_IPT_H
> -#define __LINUX_TC_IPT_H
> -
> -#include <linux/pkt_cls.h>
> -
> -enum {
> -	TCA_IPT_UNSPEC,
> -	TCA_IPT_TABLE,
> -	TCA_IPT_HOOK,
> -	TCA_IPT_INDEX,
> -	TCA_IPT_CNT,
> -	TCA_IPT_TM,
> -	TCA_IPT_TARG,
> -	TCA_IPT_PAD,
> -	__TCA_IPT_MAX
> -};
> -#define TCA_IPT_MAX (__TCA_IPT_MAX - 1)
> -
> -#endif

Sorry I missed this, wouldn't this break compilation in userspace?

> diff --git a/net/sched/Makefile b/net/sched/Makefile
> index b5fd49641d91..82c3f78ca486 100644
> --- a/net/sched/Makefile
> +++ b/net/sched/Makefile
> @@ -13,7 +13,6 @@ obj-$(CONFIG_NET_ACT_POLICE)	+= act_police.o
>   obj-$(CONFIG_NET_ACT_GACT)	+= act_gact.o
>   obj-$(CONFIG_NET_ACT_MIRRED)	+= act_mirred.o
>   obj-$(CONFIG_NET_ACT_SAMPLE)	+= act_sample.o
> -obj-$(CONFIG_NET_ACT_IPT)	+= act_ipt.o
>   obj-$(CONFIG_NET_ACT_NAT)	+= act_nat.o
>   obj-$(CONFIG_NET_ACT_PEDIT)	+= act_pedit.o
>   obj-$(CONFIG_NET_ACT_SIMP)	+= act_simple.o
> diff --git a/net/sched/act_ipt.c b/net/sched/act_ipt.c
> deleted file mode 100644
> index 598d6e299152..000000000000
> --- a/net/sched/act_ipt.c
> +++ /dev/null
> @@ -1,464 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * net/sched/act_ipt.c		iptables target interface
> - *
> - *TODO: Add other tables. For now we only support the ipv4 table targets
> - *
> - * Copyright:	Jamal Hadi Salim (2002-13)
> - */
> -
> -#include <linux/types.h>
> -#include <linux/kernel.h>
> -#include <linux/string.h>
> -#include <linux/errno.h>
> -#include <linux/skbuff.h>
> -#include <linux/rtnetlink.h>
> -#include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/slab.h>
> -#include <net/netlink.h>
> -#include <net/pkt_sched.h>
> -#include <linux/tc_act/tc_ipt.h>
> -#include <net/tc_act/tc_ipt.h>
> -#include <net/tc_wrapper.h>
> -#include <net/ip.h>
> -
> -#include <linux/netfilter_ipv4/ip_tables.h>
> -
> -
> -static struct tc_action_ops act_ipt_ops;
> -static struct tc_action_ops act_xt_ops;
> -
> -static int ipt_init_target(struct net *net, struct xt_entry_target *t,
> -			   char *table, unsigned int hook)
> -{
> -	struct xt_tgchk_param par;
> -	struct xt_target *target;
> -	struct ipt_entry e = {};
> -	int ret = 0;
> -
> -	target = xt_request_find_target(AF_INET, t->u.user.name,
> -					t->u.user.revision);
> -	if (IS_ERR(target))
> -		return PTR_ERR(target);
> -
> -	t->u.kernel.target = target;
> -	memset(&par, 0, sizeof(par));
> -	par.net       = net;
> -	par.table     = table;
> -	par.entryinfo = &e;
> -	par.target    = target;
> -	par.targinfo  = t->data;
> -	par.hook_mask = 1 << hook;
> -	par.family    = NFPROTO_IPV4;
> -
> -	ret = xt_check_target(&par, t->u.target_size - sizeof(*t), 0, false);
> -	if (ret < 0) {
> -		module_put(t->u.kernel.target->me);
> -		return ret;
> -	}
> -	return 0;
> -}
> -
> -static void ipt_destroy_target(struct xt_entry_target *t, struct net *net)
> -{
> -	struct xt_tgdtor_param par = {
> -		.target   = t->u.kernel.target,
> -		.targinfo = t->data,
> -		.family   = NFPROTO_IPV4,
> -		.net      = net,
> -	};
> -	if (par.target->destroy != NULL)
> -		par.target->destroy(&par);
> -	module_put(par.target->me);
> -}
> -
> -static void tcf_ipt_release(struct tc_action *a)
> -{
> -	struct tcf_ipt *ipt = to_ipt(a);
> -
> -	if (ipt->tcfi_t) {
> -		ipt_destroy_target(ipt->tcfi_t, a->idrinfo->net);
> -		kfree(ipt->tcfi_t);
> -	}
> -	kfree(ipt->tcfi_tname);
> -}
> -
> -static const struct nla_policy ipt_policy[TCA_IPT_MAX + 1] = {
> -	[TCA_IPT_TABLE]	= { .type = NLA_STRING, .len = IFNAMSIZ },
> -	[TCA_IPT_HOOK]	= NLA_POLICY_RANGE(NLA_U32, NF_INET_PRE_ROUTING,
> -					   NF_INET_NUMHOOKS),
> -	[TCA_IPT_INDEX]	= { .type = NLA_U32 },
> -	[TCA_IPT_TARG]	= { .len = sizeof(struct xt_entry_target) },
> -};
> -
> -static int __tcf_ipt_init(struct net *net, unsigned int id, struct nlattr *nla,
> -			  struct nlattr *est, struct tc_action **a,
> -			  const struct tc_action_ops *ops,
> -			  struct tcf_proto *tp, u32 flags)
> -{
> -	struct tc_action_net *tn = net_generic(net, id);
> -	bool bind = flags & TCA_ACT_FLAGS_BIND;
> -	struct nlattr *tb[TCA_IPT_MAX + 1];
> -	struct tcf_ipt *ipt;
> -	struct xt_entry_target *td, *t;
> -	char *tname;
> -	bool exists = false;
> -	int ret = 0, err;
> -	u32 hook = 0;
> -	u32 index = 0;
> -
> -	if (nla == NULL)
> -		return -EINVAL;
> -
> -	err = nla_parse_nested_deprecated(tb, TCA_IPT_MAX, nla, ipt_policy,
> -					  NULL);
> -	if (err < 0)
> -		return err;
> -
> -	if (tb[TCA_IPT_INDEX] != NULL)
> -		index = nla_get_u32(tb[TCA_IPT_INDEX]);
> -
> -	err = tcf_idr_check_alloc(tn, &index, a, bind);
> -	if (err < 0)
> -		return err;
> -	exists = err;
> -	if (exists && bind)
> -		return 0;
> -
> -	if (tb[TCA_IPT_HOOK] == NULL || tb[TCA_IPT_TARG] == NULL) {
> -		if (exists)
> -			tcf_idr_release(*a, bind);
> -		else
> -			tcf_idr_cleanup(tn, index);
> -		return -EINVAL;
> -	}
> -
> -	td = (struct xt_entry_target *)nla_data(tb[TCA_IPT_TARG]);
> -	if (nla_len(tb[TCA_IPT_TARG]) != td->u.target_size) {
> -		if (exists)
> -			tcf_idr_release(*a, bind);
> -		else
> -			tcf_idr_cleanup(tn, index);
> -		return -EINVAL;
> -	}
> -
> -	if (!exists) {
> -		ret = tcf_idr_create(tn, index, est, a, ops, bind,
> -				     false, flags);
> -		if (ret) {
> -			tcf_idr_cleanup(tn, index);
> -			return ret;
> -		}
> -		ret = ACT_P_CREATED;
> -	} else {
> -		if (bind)/* dont override defaults */
> -			return 0;
> -
> -		if (!(flags & TCA_ACT_FLAGS_REPLACE)) {
> -			tcf_idr_release(*a, bind);
> -			return -EEXIST;
> -		}
> -	}
> -
> -	err = -EINVAL;
> -	hook = nla_get_u32(tb[TCA_IPT_HOOK]);
> -	switch (hook) {
> -	case NF_INET_PRE_ROUTING:
> -		break;
> -	case NF_INET_POST_ROUTING:
> -		break;
> -	default:
> -		goto err1;
> -	}
> -
> -	if (tb[TCA_IPT_TABLE]) {
> -		/* mangle only for now */
> -		if (nla_strcmp(tb[TCA_IPT_TABLE], "mangle"))
> -			goto err1;
> -	}
> -
> -	tname = kstrdup("mangle", GFP_KERNEL);
> -	if (unlikely(!tname))
> -		goto err1;
> -
> -	t = kmemdup(td, td->u.target_size, GFP_KERNEL);
> -	if (unlikely(!t))
> -		goto err2;
> -
> -	err = ipt_init_target(net, t, tname, hook);
> -	if (err < 0)
> -		goto err3;
> -
> -	ipt = to_ipt(*a);
> -
> -	spin_lock_bh(&ipt->tcf_lock);
> -	if (ret != ACT_P_CREATED) {
> -		ipt_destroy_target(ipt->tcfi_t, net);
> -		kfree(ipt->tcfi_tname);
> -		kfree(ipt->tcfi_t);
> -	}
> -	ipt->tcfi_tname = tname;
> -	ipt->tcfi_t     = t;
> -	ipt->tcfi_hook  = hook;
> -	spin_unlock_bh(&ipt->tcf_lock);
> -	return ret;
> -
> -err3:
> -	kfree(t);
> -err2:
> -	kfree(tname);
> -err1:
> -	tcf_idr_release(*a, bind);
> -	return err;
> -}
> -
> -static int tcf_ipt_init(struct net *net, struct nlattr *nla,
> -			struct nlattr *est, struct tc_action **a,
> -			struct tcf_proto *tp,
> -			u32 flags, struct netlink_ext_ack *extack)
> -{
> -	return __tcf_ipt_init(net, act_ipt_ops.net_id, nla, est,
> -			      a, &act_ipt_ops, tp, flags);
> -}
> -
> -static int tcf_xt_init(struct net *net, struct nlattr *nla,
> -		       struct nlattr *est, struct tc_action **a,
> -		       struct tcf_proto *tp,
> -		       u32 flags, struct netlink_ext_ack *extack)
> -{
> -	return __tcf_ipt_init(net, act_xt_ops.net_id, nla, est,
> -			      a, &act_xt_ops, tp, flags);
> -}
> -
> -static bool tcf_ipt_act_check(struct sk_buff *skb)
> -{
> -	const struct iphdr *iph;
> -	unsigned int nhoff, len;
> -
> -	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
> -		return false;
> -
> -	nhoff = skb_network_offset(skb);
> -	iph = ip_hdr(skb);
> -	if (iph->ihl < 5 || iph->version != 4)
> -		return false;
> -
> -	len = skb_ip_totlen(skb);
> -	if (skb->len < nhoff + len || len < (iph->ihl * 4u))
> -		return false;
> -
> -	return pskb_may_pull(skb, iph->ihl * 4u);
> -}
> -
> -TC_INDIRECT_SCOPE int tcf_ipt_act(struct sk_buff *skb,
> -				  const struct tc_action *a,
> -				  struct tcf_result *res)
> -{
> -	char saved_cb[sizeof_field(struct sk_buff, cb)];
> -	int ret = 0, result = 0;
> -	struct tcf_ipt *ipt = to_ipt(a);
> -	struct xt_action_param par;
> -	struct nf_hook_state state = {
> -		.net	= dev_net(skb->dev),
> -		.in	= skb->dev,
> -		.hook	= ipt->tcfi_hook,
> -		.pf	= NFPROTO_IPV4,
> -	};
> -
> -	if (skb_protocol(skb, false) != htons(ETH_P_IP))
> -		return TC_ACT_UNSPEC;
> -
> -	if (skb_unclone(skb, GFP_ATOMIC))
> -		return TC_ACT_UNSPEC;
> -
> -	if (!tcf_ipt_act_check(skb))
> -		return TC_ACT_UNSPEC;
> -
> -	if (state.hook == NF_INET_POST_ROUTING) {
> -		if (!skb_dst(skb))
> -			return TC_ACT_UNSPEC;
> -
> -		state.out = skb->dev;
> -	}
> -
> -	memcpy(saved_cb, skb->cb, sizeof(saved_cb));
> -
> -	spin_lock(&ipt->tcf_lock);
> -
> -	tcf_lastuse_update(&ipt->tcf_tm);
> -	bstats_update(&ipt->tcf_bstats, skb);
> -
> -	/* yes, we have to worry about both in and out dev
> -	 * worry later - danger - this API seems to have changed
> -	 * from earlier kernels
> -	 */
> -	par.state    = &state;
> -	par.target   = ipt->tcfi_t->u.kernel.target;
> -	par.targinfo = ipt->tcfi_t->data;
> -
> -	memset(IPCB(skb), 0, sizeof(struct inet_skb_parm));
> -
> -	ret = par.target->target(skb, &par);
> -
> -	switch (ret) {
> -	case NF_ACCEPT:
> -		result = TC_ACT_OK;
> -		break;
> -	case NF_DROP:
> -		result = TC_ACT_SHOT;
> -		ipt->tcf_qstats.drops++;
> -		break;
> -	case XT_CONTINUE:
> -		result = TC_ACT_PIPE;
> -		break;
> -	default:
> -		net_notice_ratelimited("tc filter: Bogus netfilter code %d assume ACCEPT\n",
> -				       ret);
> -		result = TC_ACT_OK;
> -		break;
> -	}
> -	spin_unlock(&ipt->tcf_lock);
> -
> -	memcpy(skb->cb, saved_cb, sizeof(skb->cb));
> -
> -	return result;
> -
> -}
> -
> -static int tcf_ipt_dump(struct sk_buff *skb, struct tc_action *a, int bind,
> -			int ref)
> -{
> -	unsigned char *b = skb_tail_pointer(skb);
> -	struct tcf_ipt *ipt = to_ipt(a);
> -	struct xt_entry_target *t;
> -	struct tcf_t tm;
> -	struct tc_cnt c;
> -
> -	/* for simple targets kernel size == user size
> -	 * user name = target name
> -	 * for foolproof you need to not assume this
> -	 */
> -
> -	spin_lock_bh(&ipt->tcf_lock);
> -	t = kmemdup(ipt->tcfi_t, ipt->tcfi_t->u.user.target_size, GFP_ATOMIC);
> -	if (unlikely(!t))
> -		goto nla_put_failure;
> -
> -	c.bindcnt = atomic_read(&ipt->tcf_bindcnt) - bind;
> -	c.refcnt = refcount_read(&ipt->tcf_refcnt) - ref;
> -	strcpy(t->u.user.name, ipt->tcfi_t->u.kernel.target->name);
> -
> -	if (nla_put(skb, TCA_IPT_TARG, ipt->tcfi_t->u.user.target_size, t) ||
> -	    nla_put_u32(skb, TCA_IPT_INDEX, ipt->tcf_index) ||
> -	    nla_put_u32(skb, TCA_IPT_HOOK, ipt->tcfi_hook) ||
> -	    nla_put(skb, TCA_IPT_CNT, sizeof(struct tc_cnt), &c) ||
> -	    nla_put_string(skb, TCA_IPT_TABLE, ipt->tcfi_tname))
> -		goto nla_put_failure;
> -
> -	tcf_tm_dump(&tm, &ipt->tcf_tm);
> -	if (nla_put_64bit(skb, TCA_IPT_TM, sizeof(tm), &tm, TCA_IPT_PAD))
> -		goto nla_put_failure;
> -
> -	spin_unlock_bh(&ipt->tcf_lock);
> -	kfree(t);
> -	return skb->len;
> -
> -nla_put_failure:
> -	spin_unlock_bh(&ipt->tcf_lock);
> -	nlmsg_trim(skb, b);
> -	kfree(t);
> -	return -1;
> -}
> -
> -static struct tc_action_ops act_ipt_ops = {
> -	.kind		=	"ipt",
> -	.id		=	TCA_ID_IPT,
> -	.owner		=	THIS_MODULE,
> -	.act		=	tcf_ipt_act,
> -	.dump		=	tcf_ipt_dump,
> -	.cleanup	=	tcf_ipt_release,
> -	.init		=	tcf_ipt_init,
> -	.size		=	sizeof(struct tcf_ipt),
> -};
> -
> -static __net_init int ipt_init_net(struct net *net)
> -{
> -	struct tc_action_net *tn = net_generic(net, act_ipt_ops.net_id);
> -
> -	return tc_action_net_init(net, tn, &act_ipt_ops);
> -}
> -
> -static void __net_exit ipt_exit_net(struct list_head *net_list)
> -{
> -	tc_action_net_exit(net_list, act_ipt_ops.net_id);
> -}
> -
> -static struct pernet_operations ipt_net_ops = {
> -	.init = ipt_init_net,
> -	.exit_batch = ipt_exit_net,
> -	.id   = &act_ipt_ops.net_id,
> -	.size = sizeof(struct tc_action_net),
> -};
> -
> -static struct tc_action_ops act_xt_ops = {
> -	.kind		=	"xt",
> -	.id		=	TCA_ID_XT,
> -	.owner		=	THIS_MODULE,
> -	.act		=	tcf_ipt_act,
> -	.dump		=	tcf_ipt_dump,
> -	.cleanup	=	tcf_ipt_release,
> -	.init		=	tcf_xt_init,
> -	.size		=	sizeof(struct tcf_ipt),
> -};
> -
> -static __net_init int xt_init_net(struct net *net)
> -{
> -	struct tc_action_net *tn = net_generic(net, act_xt_ops.net_id);
> -
> -	return tc_action_net_init(net, tn, &act_xt_ops);
> -}
> -
> -static void __net_exit xt_exit_net(struct list_head *net_list)
> -{
> -	tc_action_net_exit(net_list, act_xt_ops.net_id);
> -}
> -
> -static struct pernet_operations xt_net_ops = {
> -	.init = xt_init_net,
> -	.exit_batch = xt_exit_net,
> -	.id   = &act_xt_ops.net_id,
> -	.size = sizeof(struct tc_action_net),
> -};
> -
> -MODULE_AUTHOR("Jamal Hadi Salim(2002-13)");
> -MODULE_DESCRIPTION("Iptables target actions");
> -MODULE_LICENSE("GPL");
> -MODULE_ALIAS("act_xt");
> -
> -static int __init ipt_init_module(void)
> -{
> -	int ret1, ret2;
> -
> -	ret1 = tcf_register_action(&act_xt_ops, &xt_net_ops);
> -	if (ret1 < 0)
> -		pr_err("Failed to load xt action\n");
> -
> -	ret2 = tcf_register_action(&act_ipt_ops, &ipt_net_ops);
> -	if (ret2 < 0)
> -		pr_err("Failed to load ipt action\n");
> -
> -	if (ret1 < 0 && ret2 < 0) {
> -		return ret1;
> -	} else
> -		return 0;
> -}
> -
> -static void __exit ipt_cleanup_module(void)
> -{
> -	tcf_unregister_action(&act_ipt_ops, &ipt_net_ops);
> -	tcf_unregister_action(&act_xt_ops, &xt_net_ops);
> -}
> -
> -module_init(ipt_init_module);
> -module_exit(ipt_cleanup_module);
> diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
> index 012aa33b341b..c60acba951c2 100644
> --- a/tools/testing/selftests/tc-testing/config
> +++ b/tools/testing/selftests/tc-testing/config
> @@ -82,7 +82,6 @@ CONFIG_NET_ACT_GACT=m
>   CONFIG_GACT_PROB=y
>   CONFIG_NET_ACT_MIRRED=m
>   CONFIG_NET_ACT_SAMPLE=m
> -CONFIG_NET_ACT_IPT=m
>   CONFIG_NET_ACT_NAT=m
>   CONFIG_NET_ACT_PEDIT=m
>   CONFIG_NET_ACT_SIMP=m
> diff --git a/tools/testing/selftests/tc-testing/tdc.sh b/tools/testing/selftests/tc-testing/tdc.sh
> index 407fa53822a0..c53ede8b730d 100755
> --- a/tools/testing/selftests/tc-testing/tdc.sh
> +++ b/tools/testing/selftests/tc-testing/tdc.sh
> @@ -20,7 +20,6 @@ try_modprobe act_ct
>   try_modprobe act_ctinfo
>   try_modprobe act_gact
>   try_modprobe act_gate
> -try_modprobe act_ipt
>   try_modprobe act_mirred
>   try_modprobe act_mpls
>   try_modprobe act_nat


