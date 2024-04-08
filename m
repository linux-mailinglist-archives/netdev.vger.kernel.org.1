Return-Path: <netdev+bounces-85774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 571BA89C189
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36ED1F226B1
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9DA7E59F;
	Mon,  8 Apr 2024 13:17:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA497E59A
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582260; cv=none; b=BwPA/+dKp9To0tLb35aHVogogbWnSF1uhbO9laNucjJsMZ/dVhr4g8xVvZhwzoV5duTr7CpaHMQsTE7ttxp/jGnAl2wB7ImIQWEZX9v1X2mrs46SvTmpRTQfiKrL3jYhuc6AQHWLlqwRbUK4Io6cd33c2Z+j6hMh9qplfMVsNWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582260; c=relaxed/simple;
	bh=P3zk1/6k2t6jHMu2C+zJQkPkLoMnlfKdrzleF71UXes=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jnOcicTjwa7/KKsOHtI2TnsJwcVM5mw+Ap3Ss0Cx21rAbDuUkyiet58aIaMyBpDg+WoUupqPDkjH828F+ahb6SE+RDKa/GZv5/IuMS47dtAaIzvSG4O69c/5Rn94lxCmMwOb9VJUXwC6GgLGYpujizclvycPDcqwVCXEnLJ2qnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=ovn.org; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4026D240004;
	Mon,  8 Apr 2024 13:17:35 +0000 (UTC)
Message-ID: <2b79ebe9-4e83-418a-ae40-93024a3fb433@ovn.org>
Date: Mon, 8 Apr 2024 15:18:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 cmi@nvidia.com, yotam.gi@gmail.com, aconole@redhat.com, echaudro@redhat.com,
 horms@kernel.org
Subject: Re: [RFC net-next v2 2/5] net: psample: add multicast filtering on
 group_id
Content-Language: en-US
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
References: <20240408125753.470419-1-amorenoz@redhat.com>
 <20240408125753.470419-3-amorenoz@redhat.com>
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20240408125753.470419-3-amorenoz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org

[copying my previous reply since this version actually has netdev@ in Cc]

On 4/8/24 14:57, Adrian Moreno wrote:
> Packet samples can come from several places (e.g: different tc sample
> actions), typically using the sample group (PSAMPLE_ATTR_SAMPLE_GROUP)
> to differentiate them.
> 
> Likewise, sample consumers that listen on the multicast group may only
> be interested on a single group. However, they are currently forced to
> receive all samples and discard the ones that are not relevant, causing
> unnecessary overhead.
> 
> Allow users to filter on the desired group_id by adding a new command
> SAMPLE_FILTER_SET that can be used to pass the desired group id.
> Store this filter on the per-socket private pointer and use it for
> filtering multicasted samples.
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  include/uapi/linux/psample.h |   1 +
>  net/psample/psample.c        | 127 +++++++++++++++++++++++++++++++++--
>  2 files changed, 122 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/psample.h b/include/uapi/linux/psample.h
> index e585db5bf2d2..5e0305b1520d 100644
> --- a/include/uapi/linux/psample.h
> +++ b/include/uapi/linux/psample.h
> @@ -28,6 +28,7 @@ enum psample_command {
>  	PSAMPLE_CMD_GET_GROUP,
>  	PSAMPLE_CMD_NEW_GROUP,
>  	PSAMPLE_CMD_DEL_GROUP,
> +	PSAMPLE_CMD_SAMPLE_FILTER_SET,
Other commands are names as PSAMPLE_CMD_VERB_NOUN, so this new one
should be PSAMPLE_CMD_SET_FILTER.  (The SAMPLE part seems unnecessary.)
Some functions/structures need to be renamed accordingly.

>  };
>  
>  enum psample_tunnel_key_attr {
> diff --git a/net/psample/psample.c b/net/psample/psample.c
> index a5d9b8446f77..a0cef63dfdec 100644
> --- a/net/psample/psample.c
> +++ b/net/psample/psample.c
> @@ -98,13 +98,84 @@ static int psample_nl_cmd_get_group_dumpit(struct sk_buff *msg,
>  	return msg->len;
>  }
>  
> -static const struct genl_small_ops psample_nl_ops[] = {
> +struct psample_obj_desc {
> +	struct rcu_head rcu;
> +	u32 group_num;
> +	bool group_num_valid;
> +};
> +
> +struct psample_nl_sock_priv {
> +	struct psample_obj_desc __rcu *flt;

Can we call it 'fileter' ?  I find it hard to read the code with
this unnecessary abbreviation.  Same for the lock below.

> +	spinlock_t flt_lock; /* Protects flt. */
> +};
> +
> +static void psample_nl_sock_priv_init(void *priv)
> +{
> +	struct psample_nl_sock_priv *sk_priv = priv;
> +
> +	spin_lock_init(&sk_priv->flt_lock);
> +}
> +
> +static void psample_nl_sock_priv_destroy(void *priv)
> +{
> +	struct psample_nl_sock_priv *sk_priv = priv;
> +	struct psample_obj_desc *flt;
> +
> +	flt = rcu_dereference_protected(sk_priv->flt, true);
> +	kfree_rcu(flt, rcu);
> +}
> +
> +static int psample_nl_sample_filter_set_doit(struct sk_buff *skb,
> +					     struct genl_info *info)
> +{
> +	struct psample_nl_sock_priv *sk_priv;
> +	struct nlattr **attrs = info->attrs;
> +	struct psample_obj_desc *flt;
> +
> +	flt = kzalloc(sizeof(*flt), GFP_KERNEL);
> +
> +	if (attrs[PSAMPLE_ATTR_SAMPLE_GROUP]) {
> +		flt->group_num = nla_get_u32(attrs[PSAMPLE_ATTR_SAMPLE_GROUP]);
> +		flt->group_num_valid = true;
> +	}
> +
> +	if (!flt->group_num_valid) {
> +		kfree(flt);

Might be better to not allocate it in the first place.

> +		flt = NULL;
> +	}
> +
> +	sk_priv = genl_sk_priv_get(&psample_nl_family, NETLINK_CB(skb).sk);
> +	if (IS_ERR(sk_priv)) {
> +		kfree(flt);
> +		return PTR_ERR(sk_priv);
> +	}
> +
> +	spin_lock(&sk_priv->flt_lock);
> +	flt = rcu_replace_pointer(sk_priv->flt, flt,
> +				  lockdep_is_held(&sk_priv->flt_lock));
> +	spin_unlock(&sk_priv->flt_lock);
> +	kfree_rcu(flt, rcu);
> +	return 0;
> +}
> +
> +static const struct nla_policy
> +	psample_sample_filter_set_policy[PSAMPLE_ATTR_SAMPLE_GROUP + 1] = {
> +	[PSAMPLE_ATTR_SAMPLE_GROUP] = { .type = NLA_U32, },

This indentation is confusing, though I'm not sure what's a better way.

> +};
> +
> +static const struct genl_ops psample_nl_ops[] = {
>  	{
>  		.cmd = PSAMPLE_CMD_GET_GROUP,
>  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>  		.dumpit = psample_nl_cmd_get_group_dumpit,
>  		/* can be retrieved by unprivileged users */
> -	}
> +	},
> +	{
> +		.cmd		= PSAMPLE_CMD_SAMPLE_FILTER_SET,
> +		.doit		= psample_nl_sample_filter_set_doit,
> +		.policy		= psample_sample_filter_set_policy,
> +		.flags		= 0,
> +	},
>  };
>  
>  static struct genl_family psample_nl_family __ro_after_init = {
> @@ -114,10 +185,13 @@ static struct genl_family psample_nl_family __ro_after_init = {
>  	.netnsok	= true,
>  	.module		= THIS_MODULE,
>  	.mcgrps		= psample_nl_mcgrps,
> -	.small_ops	= psample_nl_ops,
> -	.n_small_ops	= ARRAY_SIZE(psample_nl_ops),
> +	.ops		= psample_nl_ops,
> +	.n_ops		= ARRAY_SIZE(psample_nl_ops),
>  	.resv_start_op	= PSAMPLE_CMD_GET_GROUP + 1,
>  	.n_mcgrps	= ARRAY_SIZE(psample_nl_mcgrps),
> +	.sock_priv_size		= sizeof(struct psample_nl_sock_priv),
> +	.sock_priv_init		= psample_nl_sock_priv_init,
> +	.sock_priv_destroy	= psample_nl_sock_priv_destroy,
>  };
>  
>  static void psample_group_notify(struct psample_group *group,
> @@ -360,6 +434,42 @@ static int psample_tunnel_meta_len(struct ip_tunnel_info *tun_info)
>  }
>  #endif
>  
> +static inline void psample_nl_obj_desc_init(struct psample_obj_desc *desc,
> +					    u32 group_num)
> +{
> +	memset(desc, 0, sizeof(*desc));
> +	desc->group_num = group_num;
> +	desc->group_num_valid = true;
> +}
> +
> +static bool psample_obj_desc_match(struct psample_obj_desc *desc,
> +				   struct psample_obj_desc *flt)
> +{
> +	if (desc->group_num_valid && flt->group_num_valid &&
> +	    desc->group_num != flt->group_num)
> +		return false;
> +	return true;

This fucntion returns 'true' if one of the arguments is not valid.
I'd not expect such behavior from a 'match' function.

I understand the intention that psample should sample everything
to sockets that do not request filters, but that should not be part
of the 'match' logic, or more appropriate function name should be
chosen.  Also, if the group is not initialized, but the filter is,
it should not match, logically.  The validity on filter and the
current sample is not symmetric.

And I'm not really sure if the 'group_num_valid' is actually needed.
Can the NULL pointer be used as an indicator?  If so, then maybe
the whole psample_obj_desc structure is not needed as it will
contain a single field.

> +}
> +
> +static int psample_nl_sample_filter(struct sock *dsk, struct sk_buff *skb,
> +				    void *data)
> +{
> +	struct psample_obj_desc *desc = data;
> +	struct psample_nl_sock_priv *sk_priv;
> +	struct psample_obj_desc *flt;
> +	int ret = 0;
> +
> +	rcu_read_lock();
> +	sk_priv = __genl_sk_priv_get(&psample_nl_family, dsk);
> +	if (!IS_ERR_OR_NULL(sk_priv)) {
> +		flt = rcu_dereference(sk_priv->flt);
> +		if (flt)
> +			ret = !psample_obj_desc_match(desc, flt);
> +	}
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
>  void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>  			   u32 sample_rate, const struct psample_metadata *md)
>  {
> @@ -370,6 +480,7 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>  #ifdef CONFIG_INET
>  	struct ip_tunnel_info *tun_info;
>  #endif
> +	struct psample_obj_desc desc;
>  	struct sk_buff *nl_skb;
>  	int data_len;
>  	int meta_len;
> @@ -487,8 +598,12 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>  #endif
>  
>  	genlmsg_end(nl_skb, data);
> -	genlmsg_multicast_netns(&psample_nl_family, group->net, nl_skb, 0,
> -				PSAMPLE_NL_MCGRP_SAMPLE, GFP_ATOMIC);
> +	psample_nl_obj_desc_init(&desc, group->group_num);
> +	genlmsg_multicast_netns_filtered(&psample_nl_family,
> +					 group->net, nl_skb, 0,
> +					 PSAMPLE_NL_MCGRP_SAMPLE,
> +					 GFP_ATOMIC, psample_nl_sample_filter,
> +					 &desc);
>  
>  	return;
>  error:


