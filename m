Return-Path: <netdev+bounces-47242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF197E924E
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 20:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB632280A78
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 19:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B58168C1;
	Sun, 12 Nov 2023 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="M1XsnmLm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC44171B7
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 19:44:28 +0000 (UTC)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4489E2139
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 11:44:26 -0800 (PST)
X-KPN-MessageId: d7d7f522-8193-11ee-a148-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d7d7f522-8193-11ee-a148-005056abad63;
	Sun, 12 Nov 2023 20:44:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=z8CeK2qn35c/cKwVTtRVX+fXPSMX9h36E6ugfipkplI=;
	b=M1XsnmLm67IIYczZBbPRwf1p8QmgxXX6OhvtptpSvPGjPzfECELLgcXDIR41U+Y0XuFkVzfUTEXrg
	 3RUaD3sxd78QIkuZho92kaY3iEH+8JLEERGAlwg6ljlYcTJOpOPw4Iv/Oy0Fc8DcyH3MLZsC3Cnkva
	 gXlsWX0DLBOFLiNI=
X-KPN-MID: 33|NlNFOYu6pFnf2K+AiPs2h+Geo0DsPLqrH/vdxCuplxfm+fUZ14s22TGLMl7pA3V
 iuR3d3vAQFVMD1juABsvv0NXYcKknFkAQL/lq8MKePNo=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|ln1kbnQ1Fa7lwY/QIj2CBzmcE8nck1Id1nshA5olEoMG6AWoSV17v0/3qdFBrxT
 CAM419vFn0LDzs6wxxFo1dA==
X-Originating-IP: 213.10.186.43
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id e0c4bca7-8193-11ee-8249-005056ab1411;
	Sun, 12 Nov 2023 20:44:23 +0100 (CET)
Date: Sun, 12 Nov 2023 20:44:22 +0100
From: Antony Antony <antony@phenome.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, netdev@vger.kernel.org,
	Christian Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [RFC ipsec-next 7/8] iptfs: xfrm: add generic
 iptfs defines and functionality
Message-ID: <ZVErFh72plGBUNK0@Antony2201.local>
References: <20231110113719.3055788-1-chopps@chopps.org>
 <20231110113719.3055788-8-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110113719.3055788-8-chopps@chopps.org>

On Fri, Nov 10, 2023 at 06:37:18AM -0500, Christian Hopps via Devel wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Define `XFRM_MODE_IPTFS` and `IPSEC_MODE_IPTFS` constants, and add these to
> switch case and conditionals adjacent with the existing TUNNEL modes.
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
>  include/net/xfrm.h         |  1 +
>  include/uapi/linux/ipsec.h |  3 ++-
>  include/uapi/linux/snmp.h  |  2 ++
>  include/uapi/linux/xfrm.h  |  3 ++-
>  net/ipv4/esp4.c            |  3 ++-
>  net/ipv6/esp6.c            |  3 ++-
>  net/netfilter/nft_xfrm.c   |  3 ++-
>  net/xfrm/xfrm_device.c     |  1 +
>  net/xfrm/xfrm_output.c     |  4 ++++
>  net/xfrm/xfrm_policy.c     |  8 ++++++--
>  net/xfrm/xfrm_proc.c       |  2 ++
>  net/xfrm/xfrm_state.c      | 12 ++++++++++++
>  net/xfrm/xfrm_user.c       |  3 +++
>  13 files changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index aeeadadc9545..a6e0e848918d 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -37,6 +37,7 @@
>  #define XFRM_PROTO_COMP		108
>  #define XFRM_PROTO_IPIP		4
>  #define XFRM_PROTO_IPV6		41
> +#define XFRM_PROTO_IPTFS	IPPROTO_AGGFRAG
>  #define XFRM_PROTO_ROUTING	IPPROTO_ROUTING
>  #define XFRM_PROTO_DSTOPTS	IPPROTO_DSTOPTS
>  
> diff --git a/include/uapi/linux/ipsec.h b/include/uapi/linux/ipsec.h
> index 50d8ee1791e2..696b790f4346 100644
> --- a/include/uapi/linux/ipsec.h
> +++ b/include/uapi/linux/ipsec.h
> @@ -14,7 +14,8 @@ enum {
>  	IPSEC_MODE_ANY		= 0,	/* We do not support this for SA */
>  	IPSEC_MODE_TRANSPORT	= 1,
>  	IPSEC_MODE_TUNNEL	= 2,
> -	IPSEC_MODE_BEET         = 3
> +	IPSEC_MODE_BEET         = 3,
> +	IPSEC_MODE_IPTFS        = 4

Consider using 'IPSEC_MODE_IPTFS_TUNNEL' for a more descriptive name? 

I imagine IPSEC_MODE_BEET could support IPTFS, resulting in 'iptfs-beet.' 

In applications like iproute2, using 
'ip xfrm state add ...  mode iptfs-tunnel' might be clearer than 'iptfs' 
alone, especially with possibility of IPTF 'Congestion Control' and  
'Non-Congestion-Controlled'. Would be seperate modes? Or attributes of 
"iptfs" mode?


>  };
>  
>  enum {
> diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
> index 26f33a4c253d..d0b45f4c22c7 100644
> --- a/include/uapi/linux/snmp.h
> +++ b/include/uapi/linux/snmp.h
> @@ -331,6 +331,8 @@ enum
>  	LINUX_MIB_XFRMFWDHDRERROR,		/* XfrmFwdHdrError*/
>  	LINUX_MIB_XFRMOUTSTATEINVALID,		/* XfrmOutStateInvalid */
>  	LINUX_MIB_XFRMACQUIREERROR,		/* XfrmAcquireError */
> +	LINUX_MIB_XFRMINIPTFSERROR,		/* XfrmInIptfsError */
> +	LINUX_MIB_XFRMOUTNOQSPACE,		/* XfrmOutNoQueueSpace */
>  	__LINUX_MIB_XFRMMAX
>  };
>  
> diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> index fa6d264f2ad1..2e7ffc9b7309 100644
> --- a/include/uapi/linux/xfrm.h
> +++ b/include/uapi/linux/xfrm.h
> @@ -153,7 +153,8 @@ enum {
>  #define XFRM_MODE_ROUTEOPTIMIZATION 2
>  #define XFRM_MODE_IN_TRIGGER 3
>  #define XFRM_MODE_BEET 4
> -#define XFRM_MODE_MAX 5
> +#define XFRM_MODE_IPTFS 5

same here XFRM_MODE_IPTFS_TUNNEL 

I wonder if the patches are in the right order. While XFRM_MODE_IPTFS is 
defined in 7/8 it is already used in 5/8. May be Simon Horman pointed out 
the same.


> +#define XFRM_MODE_MAX 6
>  
>  /* Netlink configuration messages.  */
>  enum {
> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index 2be2d4922557..b7047c0dd7ea 100644
> --- a/net/ipv4/esp4.c
> +++ b/net/ipv4/esp4.c
> @@ -816,7 +816,8 @@ int esp_input_done2(struct sk_buff *skb, int err)
>  	}
>  
>  	skb_pull_rcsum(skb, hlen);
> -	if (x->props.mode == XFRM_MODE_TUNNEL)
> +	if (x->props.mode == XFRM_MODE_TUNNEL ||
> +	    x->props.mode == XFRM_MODE_IPTFS)
>  		skb_reset_transport_header(skb);
>  	else
>  		skb_set_transport_header(skb, -ihl);
> diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
> index fddd0cbdede1..10f2190207a8 100644
> --- a/net/ipv6/esp6.c
> +++ b/net/ipv6/esp6.c
> @@ -865,7 +865,8 @@ int esp6_input_done2(struct sk_buff *skb, int err)
>  	skb_postpull_rcsum(skb, skb_network_header(skb),
>  			   skb_network_header_len(skb));
>  	skb_pull_rcsum(skb, hlen);
> -	if (x->props.mode == XFRM_MODE_TUNNEL)
> +	if (x->props.mode == XFRM_MODE_TUNNEL ||
> +	    x->props.mode == XFRM_MODE_IPTFS)
>  		skb_reset_transport_header(skb);
>  	else
>  		skb_set_transport_header(skb, -hdr_len);
> diff --git a/net/netfilter/nft_xfrm.c b/net/netfilter/nft_xfrm.c
> index 452f8587adda..291b029391cd 100644
> --- a/net/netfilter/nft_xfrm.c
> +++ b/net/netfilter/nft_xfrm.c
> @@ -112,7 +112,8 @@ static bool xfrm_state_addr_ok(enum nft_xfrm_keys k, u8 family, u8 mode)
>  		return true;
>  	}
>  
> -	return mode == XFRM_MODE_BEET || mode == XFRM_MODE_TUNNEL;
> +	return mode == XFRM_MODE_BEET || mode == XFRM_MODE_TUNNEL ||
> +	       mode == XFRM_MODE_IPTFS;
>  }
>  
>  static void nft_xfrm_state_get_key(const struct nft_xfrm *priv,
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 8b848540ea47..a40f5e09829e 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -69,6 +69,7 @@ static void __xfrm_mode_beet_prep(struct xfrm_state *x, struct sk_buff *skb,
>  static void xfrm_outer_mode_prep(struct xfrm_state *x, struct sk_buff *skb)
>  {
>  	switch (x->outer_mode.encap) {
> +	case XFRM_MODE_IPTFS:
>  	case XFRM_MODE_TUNNEL:
>  		if (x->outer_mode.family == AF_INET)
>  			return __xfrm_mode_tunnel_prep(x, skb,
> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> index 4390c111410d..16c981ca61ca 100644
> --- a/net/xfrm/xfrm_output.c
> +++ b/net/xfrm/xfrm_output.c
> @@ -680,6 +680,10 @@ static void xfrm_get_inner_ipproto(struct sk_buff *skb, struct xfrm_state *x)
>  
>  		return;
>  	}
> +	if (x->outer_mode.encap == XFRM_MODE_IPTFS) {
> +		xo->inner_ipproto = IPPROTO_AGGFRAG;
> +		return;
> +	}
>  
>  	/* non-Tunnel Mode */
>  	if (!skb->encapsulation)
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 3220b01121f3..94e5889a77d6 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -2468,6 +2468,7 @@ xfrm_tmpl_resolve_one(struct xfrm_policy *policy, const struct flowi *fl,
>  		struct xfrm_tmpl *tmpl = &policy->xfrm_vec[i];
>  
>  		if (tmpl->mode == XFRM_MODE_TUNNEL ||
> +		    tmpl->mode == XFRM_MODE_IPTFS ||
>  		    tmpl->mode == XFRM_MODE_BEET) {
>  			remote = &tmpl->id.daddr;
>  			local = &tmpl->saddr;
> @@ -3252,7 +3253,8 @@ struct dst_entry *xfrm_lookup_with_ifid(struct net *net,
>  ok:
>  	xfrm_pols_put(pols, drop_pols);
>  	if (dst && dst->xfrm &&
> -	    dst->xfrm->props.mode == XFRM_MODE_TUNNEL)
> +	    (dst->xfrm->props.mode == XFRM_MODE_TUNNEL ||
> +	     dst->xfrm->props.mode == XFRM_MODE_IPTFS))
>  		dst->flags |= DST_XFRM_TUNNEL;
>  	return dst;
>  
> @@ -4353,6 +4355,7 @@ static int migrate_tmpl_match(const struct xfrm_migrate *m, const struct xfrm_tm
>  		switch (t->mode) {
>  		case XFRM_MODE_TUNNEL:
>  		case XFRM_MODE_BEET:
> +		case XFRM_MODE_IPTFS:
>  			if (xfrm_addr_equal(&t->id.daddr, &m->old_daddr,
>  					    m->old_family) &&
>  			    xfrm_addr_equal(&t->saddr, &m->old_saddr,
> @@ -4395,7 +4398,8 @@ static int xfrm_policy_migrate(struct xfrm_policy *pol,
>  				continue;
>  			n++;
>  			if (pol->xfrm_vec[i].mode != XFRM_MODE_TUNNEL &&
> -			    pol->xfrm_vec[i].mode != XFRM_MODE_BEET)
> +			    pol->xfrm_vec[i].mode != XFRM_MODE_BEET &&
> +			    pol->xfrm_vec[i].mode != XFRM_MODE_IPTFS)
>  				continue;
>  			/* update endpoints */
>  			memcpy(&pol->xfrm_vec[i].id.daddr, &mp->new_daddr,
> diff --git a/net/xfrm/xfrm_proc.c b/net/xfrm/xfrm_proc.c
> index fee9b5cf37a7..d92b1b760749 100644
> --- a/net/xfrm/xfrm_proc.c
> +++ b/net/xfrm/xfrm_proc.c
> @@ -41,6 +41,8 @@ static const struct snmp_mib xfrm_mib_list[] = {
>  	SNMP_MIB_ITEM("XfrmFwdHdrError", LINUX_MIB_XFRMFWDHDRERROR),
>  	SNMP_MIB_ITEM("XfrmOutStateInvalid", LINUX_MIB_XFRMOUTSTATEINVALID),
>  	SNMP_MIB_ITEM("XfrmAcquireError", LINUX_MIB_XFRMACQUIREERROR),
> +	SNMP_MIB_ITEM("XfrmInIptfsError", LINUX_MIB_XFRMINIPTFSERROR),
> +	SNMP_MIB_ITEM("XfrmOutNoQueueSpace", LINUX_MIB_XFRMOUTNOQSPACE),
>  	SNMP_MIB_SENTINEL
>  };
>  
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index f5e1a17ebf74..786f3fc0d428 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -465,6 +465,11 @@ static const struct xfrm_mode xfrm4_mode_map[XFRM_MODE_MAX] = {
>  		.flags = XFRM_MODE_FLAG_TUNNEL,
>  		.family = AF_INET,
>  	},
> +	[XFRM_MODE_IPTFS] = {
> +		.encap = XFRM_MODE_IPTFS,
> +		.flags = XFRM_MODE_FLAG_TUNNEL,
> +		.family = AF_INET,
> +	},
>  };
>  
>  static const struct xfrm_mode xfrm6_mode_map[XFRM_MODE_MAX] = {
> @@ -486,6 +491,11 @@ static const struct xfrm_mode xfrm6_mode_map[XFRM_MODE_MAX] = {
>  		.flags = XFRM_MODE_FLAG_TUNNEL,
>  		.family = AF_INET6,
>  	},
> +	[XFRM_MODE_IPTFS] = {
> +		.encap = XFRM_MODE_IPTFS,
> +		.flags = XFRM_MODE_FLAG_TUNNEL,
> +		.family = AF_INET6,
> +	},
>  };
>  
>  static const struct xfrm_mode *xfrm_get_mode(unsigned int encap, int family)
> @@ -2083,6 +2093,7 @@ static int __xfrm6_state_sort_cmp(const void *p)
>  #endif
>  	case XFRM_MODE_TUNNEL:
>  	case XFRM_MODE_BEET:
> +	case XFRM_MODE_IPTFS:
>  		return 4;
>  	}
>  	return 5;
> @@ -2109,6 +2120,7 @@ static int __xfrm6_tmpl_sort_cmp(const void *p)
>  #endif
>  	case XFRM_MODE_TUNNEL:
>  	case XFRM_MODE_BEET:
> +	case XFRM_MODE_IPTFS:
>  		return 3;
>  	}
>  	return 4;
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 8a504331e369..389656056326 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -353,6 +353,7 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
>  	case XFRM_MODE_TUNNEL:
>  	case XFRM_MODE_ROUTEOPTIMIZATION:
>  	case XFRM_MODE_BEET:
> +	case XFRM_MODE_IPTFS:
>  		break;
>  
>  	default:
> @@ -1830,6 +1831,8 @@ static int validate_tmpl(int nr, struct xfrm_user_tmpl *ut, u16 family,
>  				return -EINVAL;
>  			}
>  			break;
> +		case XFRM_MODE_IPTFS:
> +			break;
>  		default:
>  			if (ut[i].family != prev_family) {
>  				NL_SET_ERR_MSG(extack, "Mode in template doesn't support a family change");
> -- 
> 2.42.0
> 
> -- 
> Devel mailing list
> Devel@linux-ipsec.org
> https://linux-ipsec.org/mailman/listinfo/devel

