Return-Path: <netdev+bounces-146937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA959D6D17
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 09:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6017616172F
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 08:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6DB13BADF;
	Sun, 24 Nov 2024 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZPB0rp+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5E31F95A
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732436154; cv=none; b=Cpodauyn+Uy3dDs2DW8dMw2PNW0TPcdR2P+5F8OAss+r71S9oLFUcCBvgRN7JR6zKoQVBfcT0JeX6GKFuM2Kg4rSjY9JSrQj3OpwHU0SZo7Xvm1PPa1jfjcjDAmBE9gZ4JVjrXh65Xx4Iq1Tc1XPSkD6THYx298xrzNrLLKP/xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732436154; c=relaxed/simple;
	bh=yiKuvWs6Sk8moKhXA4kLgU7rr/Lz1gPeWMnu7OXhVGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzEFdfNNhSVrHORRvEkrMbQTzlbOh/mePF+HPpCIm/jX+wAb/KfxkSTg43lDQlKzkRbnQrIMKVp39YHkA0gI5ucpN+eASZetJw+ge+qVsXxNE7GNOyYEBLX0fe7qbWZT/LsA/StseCP2c46+QQSOA1GiYBrVvwBu21CIYePNXtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZPB0rp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA27FC4CECF;
	Sun, 24 Nov 2024 08:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732436154;
	bh=yiKuvWs6Sk8moKhXA4kLgU7rr/Lz1gPeWMnu7OXhVGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZPB0rp+YZYA0yHVArZe24iTiJ2f7+d7M9I8RfXE3KlgeNz4QFX+kT8lzYRcfsJU+
	 sEyS9uX684NBx1XgOOSaBOQ5N0DMehRnAq5rOKs63QbQN7uekflK0QyD2NprOayXh5
	 +m6oK2q/t8FQ7YrCiTsosFFlQ7yqupA0c3vdlnOUVp7W1+2Mg8mhbZ5J0aFfwBuO32
	 WS5wU+bP/Fi+tzxUOvWmH6dypioj2nKUX5ZDexPQBFgnjQZyFZYsQ2/xbVQgb4bgP3
	 214rQdyZOHuCDuHJOXFDhLTUX3eToZ8pX7lNGtrIwJQx8kCuXNsguWmOHfQ6hAc8LM
	 wEYIXUGYsL1Zg==
Date: Sun, 24 Nov 2024 10:15:49 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Feng Wang <wangfe@google.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	antony.antony@secunet.com, pabeni@redhat.com
Subject: Re: [PATCH v6] xfrm: add SA information to the offloaded packet when
 if_id is set
Message-ID: <20241124081549.GD160612@unreal>
References: <20241121215257.3879343-2-wangfe@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241121215257.3879343-2-wangfe@google.com>

On Thu, Nov 21, 2024 at 09:52:58PM +0000, Feng Wang wrote:
> In packet offload mode, append Security Association (SA) information
> to each packet, replicating the crypto offload implementation.

Please write explicitly WHY "replicating ..." is right thing to do and
why current code is not enough.

The best thing will be to see how packet traversal in the netdev stack
till it gets to the wire.

> 
> The XFRM_XMIT flag is set to enable packet to be returned immediately
> from the validate_xmit_xfrm function, thus aligning with the existing
> code path for packet offload mode.

This chunk was dropped mysteriously. It doesn't exist in the current patch.
What type of testing did you perform? Can you please add it to the
commit message?

According to the strongswan documentation https://docs.strongswan.org/docs/5.9/features/routeBasedVpn.html,
"Traffic that’s routed to an XFRM interface, while no policies and SAs with matching interface ID exist,
will be dropped by the kernel."

It looks like the current code doesn't handle this case, does it?

> 
> This SA info helps HW offload match packets to their correct security
> policies. The XFRM interface ID is included, which is used in setups
> with multiple XFRM interfaces where source/destination addresses alone
> can't pinpoint the right policy.

Please add an examples of iproute2 commands on how it is achieved,
together with tcprdump examples of before and after.

> 
> Enable packet offload mode on netdevsim and add code to check the XFRM
> interface ID.

You still need to add checks in existing drivers to make sure that SAs
with if_id won't be offloaded.

IMHO, netdevsim implementation is not a replacement to support
out-of-tree code, but a way to help testing features without need to
have complex HW, but still for the code which is in-tree.

Thanks

> 
> Signed-off-by: wangfe <wangfe@google.com>
> ---
> v6: https://lore.kernel.org/all/20241119220411.2961121-1-wangfe@google.com/
>   - Fix code style to follow reverse x-mas tree order declaration.
> v5: https://lore.kernel.org/all/20241112192249.341515-1-wangfe@google.com/
>   - Add SA information only when XFRM interface ID is non-zero.
> v4: https://lore.kernel.org/all/20241104233251.3387719-1-wangfe@google.com/
>   - Add offload flag check and only doing check when XFRM interface
>     ID is non-zero.
> v3: https://lore.kernel.org/all/20240822200252.472298-1-wangfe@google.com/
>   - Add XFRM interface ID checking on netdevsim in the packet offload
>     mode.
> v2:
>   - Add why HW offload requires the SA info to the commit message
> v1: https://lore.kernel.org/all/20240812182317.1962756-1-wangfe@google.com/
> ---
> ---
>  drivers/net/netdevsim/ipsec.c     | 32 ++++++++++++++++++++++++++++++-
>  drivers/net/netdevsim/netdevsim.h |  1 +
>  net/xfrm/xfrm_output.c            | 22 +++++++++++++++++++++
>  3 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
> index 88187dd4eb2d..5677b2acf9c0 100644
> --- a/drivers/net/netdevsim/ipsec.c
> +++ b/drivers/net/netdevsim/ipsec.c
> @@ -153,7 +153,8 @@ static int nsim_ipsec_add_sa(struct xfrm_state *xs,
>  		return -EINVAL;
>  	}
>  
> -	if (xs->xso.type != XFRM_DEV_OFFLOAD_CRYPTO) {
> +	if (xs->xso.type != XFRM_DEV_OFFLOAD_CRYPTO &&
> +	    xs->xso.type != XFRM_DEV_OFFLOAD_PACKET) {
>  		NL_SET_ERR_MSG_MOD(extack, "Unsupported ipsec offload type");
>  		return -EINVAL;
>  	}
> @@ -169,6 +170,7 @@ static int nsim_ipsec_add_sa(struct xfrm_state *xs,
>  	memset(&sa, 0, sizeof(sa));
>  	sa.used = true;
>  	sa.xs = xs;
> +	sa.if_id = xs->if_id;
>  
>  	if (sa.xs->id.proto & IPPROTO_ESP)
>  		sa.crypt = xs->ealg || xs->aead;
> @@ -227,16 +229,31 @@ static bool nsim_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
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
>  {
>  	struct sec_path *sp = skb_sec_path(skb);
>  	struct nsim_ipsec *ipsec = &ns->ipsec;
> +	struct xfrm_offload *xo;
>  	struct xfrm_state *xs;
>  	struct nsim_sa *tsa;
>  	u32 sa_idx;
> @@ -275,6 +292,19 @@ bool nsim_ipsec_tx(struct netdevsim *ns, struct sk_buff *skb)
>  		return false;
>  	}
>  
> +	if (xs->if_id) {
> +		if (xs->if_id != tsa->if_id) {
> +			netdev_err(ns->netdev, "unmatched if_id %d %d\n",
> +				   xs->if_id, tsa->if_id);
> +			return false;
> +		}
> +		xo = xfrm_offload(skb);
> +		if (!xo || !(xo->flags & XFRM_XMIT)) {
> +			netdev_err(ns->netdev, "offload flag missing or wrong\n");
> +			return false;
> +		}
> +	}
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
> index e5722c95b8bb..3e9a1b17f37e 100644
> --- a/net/xfrm/xfrm_output.c
> +++ b/net/xfrm/xfrm_output.c
> @@ -704,6 +704,8 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
>  {
>  	struct net *net = dev_net(skb_dst(skb)->dev);
>  	struct xfrm_state *x = skb_dst(skb)->xfrm;
> +	struct xfrm_offload *xo;
> +	struct sec_path *sp;
>  	int family;
>  	int err;
>  
> @@ -728,7 +730,27 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
>  			kfree_skb(skb);
>  			return -EHOSTUNREACH;
>  		}
> +		if (x->if_id) {
> +			sp = secpath_set(skb);
> +			if (!sp) {
> +				XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> +				kfree_skb(skb);
> +				return -ENOMEM;
> +			}
> +
> +			sp->olen++;
> +			sp->xvec[sp->len++] = x;
> +			xfrm_state_hold(x);
>  
> +			xo = xfrm_offload(skb);
> +			if (!xo) {
> +				secpath_reset(skb);
> +				XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> +				kfree_skb(skb);
> +				return -EINVAL;
> +			}
> +			xo->flags |= XFRM_XMIT;
> +		}
>  		return xfrm_output_resume(sk, skb, 0);
>  	}
>  
> -- 
> 2.47.0.371.ga323438b13-goog
> 
> 

