Return-Path: <netdev+bounces-91825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4630E8B40EF
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 22:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE061F22836
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 20:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D284428E0F;
	Fri, 26 Apr 2024 20:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4C3ZdsV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2252907
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 20:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714164066; cv=none; b=q4j0o8rT25siuJ6rTbm8x8T22GoosDWxO+2aiVAIVwPcQe/H8KPSYiK0HuC+c2ajUO0Jdx1qEGYNGKw2xrtXHHi27jWAvnAfnOujZL34dSmHmc1jPsyn5LGfr7Op0zI4Z61k5iAA/SNfg1NY3fbveDKWI+Ig1nfhReHuIVdDEms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714164066; c=relaxed/simple;
	bh=bCraOuDIRPIljUSsTmNAX3TXv07dRawoCyAPOhrMyEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWXAsCJCQbyTYxHIXfNOEoQWXYnw4znpN3PfwT55/MWtTRbK+/cOdov8I/jY8Vb6rw/SVzJ8Kp2S6ZagXR93jlWZIOmFq8sbyLyKAuyO12BV7UPtiUVWkpLZs4ba5g12eD6cG3ZBw1vH12SrZSD3+dSGGWHu6u5qbJ0CwpljHwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4C3ZdsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32E9C113CD;
	Fri, 26 Apr 2024 20:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714164066;
	bh=bCraOuDIRPIljUSsTmNAX3TXv07dRawoCyAPOhrMyEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4C3ZdsVjwxILC262cEpRB6IaYlHw9h1RByqeOwAeQx9+bfP1h5IQnvxa52ku858b
	 ciOq5u60c0KJxha+D2cWVtJHoVCPVdUnrU6GYBpqPW4U0m5E6UTdZntuW5hRN5KOe3
	 fQxi/XNg40wxGqjX5ly6sDNYEiPgaCrgcCUgru+YJ2a4tU4Qtg7rlYPh0hkvHmUXok
	 HkUfXoe6bJa+qQ0DUjEy9yAdlMHy8fegukVkBFjczfAYyQLyWrI0jjmVIUvodoljXP
	 xtjthv4lmwkJqfeUwTigDxI+TqfND1W10zt//r1WSq5oMMi7q0WOWWzR7/FGJoSYF8
	 ino21sNhoFc9g==
Date: Fri, 26 Apr 2024 21:41:01 +0100
From: Simon Horman <horms@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, laforge@osmocom.org,
	pespin@sysmocom.de, osmith@sysmocom.de, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, fw@strlen.de
Subject: Re: [PATCH net-next 04/12] gtp: add IPv6 support
Message-ID: <20240426204101.GE516117@kernel.org>
References: <20240425105138.1361098-1-pablo@netfilter.org>
 <20240425105138.1361098-5-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425105138.1361098-5-pablo@netfilter.org>

On Thu, Apr 25, 2024 at 12:51:30PM +0200, Pablo Neira Ayuso wrote:
> Add new iflink attributes to configure in-kernel UDP listener socket
> address: IFLA_GTP_LOCAL and IFLA_GTP_LOCAL6. If none of these attributes
> are specified, default is still to IPv4 INADDR_ANY for backward
> compatibility.
> 
> Add new attributes to set up family and IPv6 address of GTP tunnels:
> GTPA_FAMILY, GTPA_PEER_ADDR6 and GTPA_MS_ADDR6. If no GTPA_FAMILY is
> specified, AF_INET is assumed for backward compatibility.
> 
> setsockopt IPV6_ADDRFORM allows to downgrade socket from IPv6 to IPv4
> after socket is bound. Assumption is that socket listener that is
> attached to the gtp device needs to be either IPv4 or IPv6. Therefore,
> GTP socket listener does not allow for IPv4-mapped-IPv6 listener.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  drivers/net/gtp.c            | 390 ++++++++++++++++++++++++++++++++---
>  include/uapi/linux/gtp.h     |   3 +
>  include/uapi/linux/if_link.h |   2 +
>  3 files changed, 368 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> index 1c4429d24cfc..69d865e592df 100644
> --- a/drivers/net/gtp.c
> +++ b/drivers/net/gtp.c
> @@ -24,6 +24,7 @@
>  #include <net/net_namespace.h>
>  #include <net/protocol.h>
>  #include <net/ip.h>
> +#include <net/ipv6.h>
>  #include <net/udp.h>
>  #include <net/udp_tunnel.h>
>  #include <net/icmp.h>
> @@ -52,9 +53,11 @@ struct pdp_ctx {
>  
>  	union {
>  		struct in_addr	addr;
> +		struct in6_addr	addr6;
>  	} ms;
>  	union {
>  		struct in_addr	addr;
> +		struct in6_addr	addr6;
>  	} peer;
>  
>  	struct sock		*sk;
> @@ -131,6 +134,11 @@ static inline u32 ipv4_hashfn(__be32 ip)
>  	return jhash_1word((__force u32)ip, gtp_h_initval);
>  }
>  
> +static inline u32 ipv6_hashfn(const struct in6_addr *ip6)
> +{
> +	return jhash(ip6, sizeof(*ip6), gtp_h_initval);
> +}
> +

Hi Pablo,

I'm would naively expect that the compiler can work out if this needs to
be inline.

>  /* Resolve a PDP context structure based on the 64bit TID. */
>  static struct pdp_ctx *gtp0_pdp_find(struct gtp_dev *gtp, u64 tid)
>  {

...

> @@ -878,6 +951,20 @@ static inline void gtp_set_pktinfo_ipv4(struct gtp_pktinfo *pktinfo,
>  	pktinfo->dev	= dev;
>  }
>  
> +static inline void gtp_set_pktinfo_ipv6(struct gtp_pktinfo *pktinfo,
> +					struct sock *sk, struct ipv6hdr *ip6h,
> +					struct pdp_ctx *pctx, struct rt6_info *rt6,
> +					struct flowi6 *fl6,
> +					struct net_device *dev)
> +{
> +	pktinfo->sk	= sk;
> +	pktinfo->ip6h	= ip6h;
> +	pktinfo->pctx	= pctx;
> +	pktinfo->rt6	= rt6;
> +	pktinfo->fl6	= *fl6;
> +	pktinfo->dev	= dev;
> +}

Here too.

...

> @@ -1441,7 +1736,14 @@ static struct pdp_ctx *gtp_pdp_add(struct gtp_dev *gtp, struct sock *sk,
>  		if (!pctx)
>  			pctx = pctx_tid;
>  
> -		ipv4_pdp_fill(pctx, info);
> +		switch (pctx->af) {
> +		case AF_INET:
> +			ipv4_pdp_fill(pctx, info);
> +			break;
> +		case AF_INET6:
> +			ipv6_pdp_fill(pctx, info);
> +			break;
> +		}
>  
>  		if (pctx->gtp_version == GTP_V0)
>  			netdev_dbg(dev, "GTPv0-U: update tunnel id = %llx (pdp %p)\n",

The code just before the following hunk is:

	pctx = kmalloc(sizeof(*pctx), GFP_ATOMIC);
	if (pctx == NULL)
		return ERR_PTR(-ENOMEM);


> @@ -1461,7 +1763,24 @@ static struct pdp_ctx *gtp_pdp_add(struct gtp_dev *gtp, struct sock *sk,
>  	sock_hold(sk);
>  	pctx->sk = sk;
>  	pctx->dev = gtp->dev;
> -	ipv4_pdp_fill(pctx, info);
> +	pctx->af = family;
> +
> +	switch (pctx->af) {
> +	case AF_INET:
> +		if (!info->attrs[GTPA_MS_ADDRESS] ||
> +		    !info->attrs[GTPA_PEER_ADDRESS])
> +			return ERR_PTR(-EINVAL);

So this appears to leak pctx.

> +
> +		ipv4_pdp_fill(pctx, info);
> +		break;
> +	case AF_INET6:
> +		if (!info->attrs[GTPA_MS_ADDR6] ||
> +		    !info->attrs[GTPA_PEER_ADDR6])
> +			return ERR_PTR(-EINVAL);

Likewise here.

Flagged by Smatch.

> +
> +		ipv6_pdp_fill(pctx, info);
> +		break;
> +	}
>  	atomic_set(&pctx->tx_seq, 0);
>  
>  	switch (pctx->gtp_version) {

...

