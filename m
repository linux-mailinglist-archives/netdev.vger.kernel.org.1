Return-Path: <netdev+bounces-43040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573E57D1194
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 16:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12CEE28200A
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4321D69D;
	Fri, 20 Oct 2023 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="E4vhIFOt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CFE1D54D
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:28:11 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A55D46
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 07:28:10 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5a9d8f4388bso557356a12.3
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 07:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697812089; x=1698416889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KNIldaP6dGH6fW7mflhfYV57Ti5cupkMZt+LwhjnSho=;
        b=E4vhIFOttetC01XyunM9CY03bWxEuH8bFbcROhtqfsFusxzXerFbVpjhR5IObn4oyb
         RsI1qzx/aGXYcEDa8v7D2Nv3H0TCFgmaGi1o39QJHahu1FJx8DTP6iM+WTYnZipaSiHG
         wtvrB1peUl+x5jqSURncii4/x1JNQ4s9ZJFzeed6Q4Z/mZWQ7HiD623hMFAZwfEioHNP
         AofTdbcDVj2ngEwx+DkEoRsyJNzUhDWi5brryGKpZAoE69nPns4UwADvqktCJ/yVxmDb
         strAB23+NJlbojOJNydDmj38wvH8q8LN1CvkvNMFTBHsK/IuCTmIkv9zsn8hUwKb8Zty
         svAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697812089; x=1698416889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KNIldaP6dGH6fW7mflhfYV57Ti5cupkMZt+LwhjnSho=;
        b=bvk7/TG+GkvsCJlmn7t0SAj1ZYaff2g9SdRq43aS7qeQnTqA3zM84zhs0lx3ND0Xrs
         U7f7MaDTHdK064fzdudedX+lWoXADWsHHSN741AV735bLQsiR3uwR3xMO4hwht+WmYXU
         1IiwaJWtC4b0r53G5b+oAssWGWKpiZbEsD+Fy47X63PY97XJ2WlrpISzHKHpFxjTIqnt
         ml740v1/L+M43jCjNjPwBuBtq9Yae3+SHnQwsGj7ZxoQqOg3KstA07QiKwWIyGLb9vma
         D/S/lYEKEARw8V2Cpj54jYTKu7+QCenDDRx78Rs1JIB6C5aopEgDjtkwAqKBg7EzIX9K
         BOJw==
X-Gm-Message-State: AOJu0YzgCiIPqKIzcIKmZoTwQ7t3alYo2L9qPwC/3RVoNdTN+CydGHmD
	ySXYsccGFDFQYDzAZdx0mrICKTAEY7mfum6d458=
X-Google-Smtp-Source: AGHT+IHoOjF3baM+niuh84n4gp8OixBneRGVPSUnvejudzNS2Ea8E1gZ7fjR6kBxM3hXUyx1eGouKg==
X-Received: by 2002:a05:6a20:432c:b0:17b:1696:e5ea with SMTP id h44-20020a056a20432c00b0017b1696e5eamr2283269pzk.14.1697812089399;
        Fri, 20 Oct 2023 07:28:09 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:1ae7:ff4d:7ac7:3fe0? ([2804:14d:5c5e:44fb:1ae7:ff4d:7ac7:3fe0])
        by smtp.gmail.com with ESMTPSA id p22-20020a1709028a9600b001c9bca1d705sm1582087plo.242.2023.10.20.07.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 07:28:09 -0700 (PDT)
Message-ID: <6bd93499-97d1-4a43-ac8e-1432f2799b3b@mojatatu.com>
Date: Fri, 20 Oct 2023 11:28:04 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] sched: act_ct: switch to per-action label
 counting
To: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
References: <20231020124551.10764-1-fw@strlen.de>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20231020124551.10764-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/10/2023 09:45, Florian Westphal wrote:
> net->ct.labels_used was meant to convey 'number of ip/nftables rules
> that need the label extension allocated'.
> 
> act_ct enables this for each net namespace, which voids all attempts
> to avoid ct->ext allocation when possible.
> 
> Move this increment to the control plane to request label extension
> space allocation only when its needed.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>   "tdc.py -c ct" still passes with this applied.
> 
>   include/net/tc_act/tc_ct.h |  1 +
>   net/sched/act_ct.c         | 41 +++++++++++++++++---------------------
>   2 files changed, 19 insertions(+), 23 deletions(-)
> 
> diff --git a/include/net/tc_act/tc_ct.h b/include/net/tc_act/tc_ct.h
> index b24ea2d9400b..8a6dbfb23336 100644
> --- a/include/net/tc_act/tc_ct.h
> +++ b/include/net/tc_act/tc_ct.h
> @@ -22,6 +22,7 @@ struct tcf_ct_params {
>   
>   	struct nf_nat_range2 range;
>   	bool ipv4_range;
> +	bool put_labels;
>   
>   	u16 ct_action;
>   
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index 7c652d14528b..9422686f73b0 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -690,7 +690,6 @@ static struct tc_action_ops act_ct_ops;
>   
>   struct tc_ct_action_net {
>   	struct tc_action_net tn; /* Must be first */
> -	bool labels;
>   };
>   
>   /* Determine whether skb->_nfct is equal to the result of conntrack lookup. */
> @@ -829,8 +828,13 @@ static void tcf_ct_params_free(struct tcf_ct_params *params)
>   	}
>   	if (params->ct_ft)
>   		tcf_ct_flow_table_put(params->ct_ft);
> -	if (params->tmpl)
> +	if (params->tmpl) {
> +		if (params->put_labels)
> +			nf_connlabels_put(nf_ct_net(params->tmpl));
> +
>   		nf_ct_put(params->tmpl);
> +	}
> +
>   	kfree(params);
>   }
>   
> @@ -1154,10 +1158,10 @@ static int tcf_ct_fill_params(struct net *net,
>   			      struct nlattr **tb,
>   			      struct netlink_ext_ack *extack)
>   {
> -	struct tc_ct_action_net *tn = net_generic(net, act_ct_ops.net_id);
>   	struct nf_conntrack_zone zone;
>   	int err, family, proto, len;
>   	struct nf_conn *tmpl;
> +	bool put_labels = false;

Shouldn't this be after `struct nf_conntrack_zone zone` to conform to 
rev-xmas-tree?

Other than that,
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>

>   	char *name;
>   
>   	p->zone = NF_CT_DEFAULT_ZONE_ID;
> @@ -1186,15 +1190,20 @@ static int tcf_ct_fill_params(struct net *net,
>   	}
>   
>   	if (tb[TCA_CT_LABELS]) {
> +		unsigned int n_bits = sizeof_field(struct tcf_ct_params, labels) * 8;
> +
>   		if (!IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS)) {
>   			NL_SET_ERR_MSG_MOD(extack, "Conntrack labels isn't enabled.");
>   			return -EOPNOTSUPP;
>   		}
>   
> -		if (!tn->labels) {
> +		if (nf_connlabels_get(net, n_bits - 1)) {
>   			NL_SET_ERR_MSG_MOD(extack, "Failed to set connlabel length");
>   			return -EOPNOTSUPP;
> +		} else {
> +			put_labels = true;
>   		}
> +
>   		tcf_ct_set_key_val(tb,
>   				   p->labels, TCA_CT_LABELS,
>   				   p->labels_mask, TCA_CT_LABELS_MASK,
> @@ -1238,10 +1247,15 @@ static int tcf_ct_fill_params(struct net *net,
>   		}
>   	}
>   
> +	p->put_labels = put_labels;
> +
>   	if (p->ct_action & TCA_CT_ACT_COMMIT)
>   		__set_bit(IPS_CONFIRMED_BIT, &tmpl->status);
>   	return 0;
>   err:
> +	if (put_labels)
> +		nf_connlabels_put(net);
> +
>   	nf_ct_put(p->tmpl);
>   	p->tmpl = NULL;
>   	return err;
> @@ -1542,32 +1556,13 @@ static struct tc_action_ops act_ct_ops = {
>   
>   static __net_init int ct_init_net(struct net *net)
>   {
> -	unsigned int n_bits = sizeof_field(struct tcf_ct_params, labels) * 8;
>   	struct tc_ct_action_net *tn = net_generic(net, act_ct_ops.net_id);
>   
> -	if (nf_connlabels_get(net, n_bits - 1)) {
> -		tn->labels = false;
> -		pr_err("act_ct: Failed to set connlabels length");
> -	} else {
> -		tn->labels = true;
> -	}
> -
>   	return tc_action_net_init(net, &tn->tn, &act_ct_ops);
>   }
>   
>   static void __net_exit ct_exit_net(struct list_head *net_list)
>   {
> -	struct net *net;
> -
> -	rtnl_lock();
> -	list_for_each_entry(net, net_list, exit_list) {
> -		struct tc_ct_action_net *tn = net_generic(net, act_ct_ops.net_id);
> -
> -		if (tn->labels)
> -			nf_connlabels_put(net);
> -	}
> -	rtnl_unlock();
> -
>   	tc_action_net_exit(net_list, act_ct_ops.net_id);
>   }
>   


