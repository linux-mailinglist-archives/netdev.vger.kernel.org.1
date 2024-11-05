Return-Path: <netdev+bounces-141829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D11949BC71A
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 08:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626F91F21B34
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 07:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9206F06D;
	Tue,  5 Nov 2024 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYgk54NN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA775383
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791975; cv=none; b=l8/JBLNZXQuBGPk1GC/slsQb8l21NZ3OXCC0naPVNW1bLqPP4oyvnO52waGGGzIwDxSYebkr7r9RQUTzBg4XWcrkOMQsy4LEvBwg7D/B+tOMI1/8v/D8nVE5pNNsM8MxuaCU2NUrS3sdO+OYWl38dpU1CYj27u4rWU7VgXg/T4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791975; c=relaxed/simple;
	bh=iSnTcVv8xx3iW0J7hIovo2ZBrioU5ZLs6QaNG5MD98s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVMqjHCnrP8E584YGGx32wGYiTHmMFM10vS/9gRNw3Qp10nfz8UrBiUJ5KsW2+VfXTd1bZvehLwZPISlibQtnC+2FSwxFptAk1JVHAjEOyjbZ1Rnd4EAyIrd4akOKMvFaCv4Vh+mTBPwsWYgGCQThNmDyNQwMYv0wM0am3U4MUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYgk54NN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7711C4CECF;
	Tue,  5 Nov 2024 07:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730791975;
	bh=iSnTcVv8xx3iW0J7hIovo2ZBrioU5ZLs6QaNG5MD98s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kYgk54NNdgO518DErRKJpU7qDWCcfzn67Bgal8ZxuQKPqzCRhDeZbmexSfIeMS4C5
	 SHQH2qyIF0TkDBU9GHKauS4Rpuhtsg0lKfWJQ0s0Wwx+sxEp5lutv8gban7vS4a/Zz
	 xg4uvnhisWidGAPR+5zng+ZWRGRXZo3qD2Va+deSMcR5KmNqhTTVU3zZ/IGOw8kt7H
	 /W31RZ8pCawb5YPwkQAY9eYzb5MQyw+WzKL+clOaBCpLUONao6cRsU+eGv0uAeCYkx
	 yQf4gf72BhPPBa5HZRE2UoIwofSD6ui0/V2cJxzxzkgRaQeXLqlwAyMdsBir2q3hjt
	 bwSgr1/ZKUo2A==
Date: Tue, 5 Nov 2024 09:32:48 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Feng Wang <wangfe@google.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	antony.antony@secunet.com
Subject: Re: [PATCH 1/2] xfrm: add SA information to the offloaded packet
Message-ID: <20241105073248.GC311159@unreal>
References: <20241104233251.3387719-1-wangfe@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104233251.3387719-1-wangfe@google.com>

On Mon, Nov 04, 2024 at 03:32:51PM -0800, Feng Wang wrote:
> From: wangfe <wangfe@google.com>
> 
> In packet offload mode, append Security Association (SA) information
> to each packet, replicating the crypto offload implementation.
> The XFRM_XMIT flag is set to enable packet to be returned immediately
> from the validate_xmit_xfrm function, thus aligning with the existing
> code path for packet offload mode.
> 
> This SA info helps HW offload match packets to their correct security
> policies. The XFRM interface ID is included, which is used in setups
> with multiple XFRM interfaces where source/destination addresses alone
> can't pinpoint the right policy.
> 
> Enable packet offload mode on netdevsim and add code to check the XFRM
> interface ID.
> 
> Signed-off-by: wangfe <wangfe@google.com>

Something wrong with your git setup, lore shows only one patch.
https://lore.kernel.org/all/20241104233251.3387719-1-wangfe@google.com/

> ---
> v3: https://lore.kernel.org/all/20240822200252.472298-1-wangfe@google.com/
>   - Add XFRM interface ID checking on netdevsim in the packet offload
>     mode.
> v2:
>   - Add why HW offload requires the SA info to the commit message
> v1: https://lore.kernel.org/all/20240812182317.1962756-1-wangfe@google.com/
> ---
> ---
>  drivers/net/netdevsim/ipsec.c     | 24 +++++++++++++++++++++++-
>  drivers/net/netdevsim/netdevsim.h |  1 +
>  net/xfrm/xfrm_output.c            | 21 +++++++++++++++++++++
>  3 files changed, 45 insertions(+), 1 deletion(-)

Don't you need to update current drivers who support packet offload with
if(x->if_id) check in their SA/policy validator to return an error to
the user? They don't support that flow.

> 
> diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
> index f0d58092e7e9..1ce7447dd269 100644
> --- a/drivers/net/netdevsim/ipsec.c
> +++ b/drivers/net/netdevsim/ipsec.c
> @@ -149,7 +149,8 @@ static int nsim_ipsec_add_sa(struct xfrm_state *xs,
>  		return -EINVAL;
>  	}
>  
> -	if (xs->xso.type != XFRM_DEV_OFFLOAD_CRYPTO) {
> +	if (xs->xso.type != XFRM_DEV_OFFLOAD_CRYPTO &&
> +	    xs->xso.type != XFRM_DEV_OFFLOAD_PACKET) {
>  		NL_SET_ERR_MSG_MOD(extack, "Unsupported ipsec offload type");
>  		return -EINVAL;
>  	}
> @@ -165,6 +166,7 @@ static int nsim_ipsec_add_sa(struct xfrm_state *xs,
>  	memset(&sa, 0, sizeof(sa));
>  	sa.used = true;
>  	sa.xs = xs;
> +	sa.if_id = xs->if_id;
>  
>  	if (sa.xs->id.proto & IPPROTO_ESP)
>  		sa.crypt = xs->ealg || xs->aead;
> @@ -224,10 +226,24 @@ static bool nsim_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
>  	return true;
>  }
>  
> +static int nsim_ipsec_add_policy(struct xfrm_policy *policy,
> +				 struct netlink_ext_ack *extack)
> +{
> +	return 0;
> +}
> +
> +static void nsim_ipsec_del_policy(struct xfrm_policy *policy)
> +{
> +}
> +
>  static const struct xfrmdev_ops nsim_xfrmdev_ops = {
>  	.xdo_dev_state_add	= nsim_ipsec_add_sa,
>  	.xdo_dev_state_delete	= nsim_ipsec_del_sa,
>  	.xdo_dev_offload_ok	= nsim_ipsec_offload_ok,
> +
> +	.xdo_dev_policy_add     = nsim_ipsec_add_policy,
> +	.xdo_dev_policy_delete  = nsim_ipsec_del_policy,
> +
>  };
>  
>  bool nsim_ipsec_tx(struct netdevsim *ns, struct sk_buff *skb)
> @@ -272,6 +288,12 @@ bool nsim_ipsec_tx(struct netdevsim *ns, struct sk_buff *skb)
>  		return false;
>  	}
>  
> +	if (xs->if_id != tsa->if_id) {

if_id exists in policy and state, but you are checking only state.

> +		netdev_err(ns->netdev, "unmatched if_id %d %d\n",
> +			   xs->if_id, tsa->if_id);
> +		return false;
> +	}

It is worth to add check for having XFRM_XMIT flag here.

> +
>  	ipsec->tx++;
>  
>  	return true;
> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
> index bf02efa10956..4941b6e46d0a 100644
> --- a/drivers/net/netdevsim/netdevsim.h
> +++ b/drivers/net/netdevsim/netdevsim.h
> @@ -41,6 +41,7 @@ struct nsim_sa {
>  	__be32 ipaddr[4];
>  	u32 key[4];
>  	u32 salt;
> +	u32 if_id;
>  	bool used;
>  	bool crypt;
>  	bool rx;
> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> index e5722c95b8bb..a12588e7b060 100644
> --- a/net/xfrm/xfrm_output.c
> +++ b/net/xfrm/xfrm_output.c
> @@ -706,6 +706,8 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
>  	struct xfrm_state *x = skb_dst(skb)->xfrm;
>  	int family;
>  	int err;
> +	struct xfrm_offload *xo;
> +	struct sec_path *sp;
>  
>  	family = (x->xso.type != XFRM_DEV_OFFLOAD_PACKET) ? x->outer_mode.family
>  		: skb_dst(skb)->ops->family;
> @@ -728,6 +730,25 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
>  			kfree_skb(skb);
>  			return -EHOSTUNREACH;
>  		}

I think that code below should be set under "if (x->if_id)".

Thanks

> +		sp = secpath_set(skb);
> +		if (!sp) {
> +			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> +			kfree_skb(skb);
> +			return -ENOMEM;
> +		}
> +
> +		sp->olen++;
> +		sp->xvec[sp->len++] = x;
> +		xfrm_state_hold(x);
> +
> +		xo = xfrm_offload(skb);
> +		if (!xo) {
> +			secpath_reset(skb);
> +			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> +			kfree_skb(skb);
> +			return -EINVAL;
> +		}
> +		xo->flags |= XFRM_XMIT;
>  
>  		return xfrm_output_resume(sk, skb, 0);
>  	}
> -- 
> 2.47.0.199.ga7371fff76-goog
> 
> 

