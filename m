Return-Path: <netdev+bounces-48173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75BC7ECAFA
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 20:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B21B280A4B
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5AE2C861;
	Wed, 15 Nov 2023 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="HqWnpIRz"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AFAFA
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 11:04:55 -0800 (PST)
X-KPN-MessageId: d1750cdb-83e9-11ee-a148-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d1750cdb-83e9-11ee-a148-005056abad63;
	Wed, 15 Nov 2023 20:04:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=j1ew/7OGdB9oAiuu120nCYXk48i/IYV8imjG9KRQsGY=;
	b=HqWnpIRztok0W3OKsUIET6UwiyDyMokgdAM+EYx9EaZXJl3f06EvUCPNWObZsFOqM3s++J1YoF4fZ
	 vucSOmPz1DYP6OQBAq354QstJ5WwdjSUVcVDZ/O0HeLSs0EK5WDp/Hq+Oy3Xxmozm1T6K2ErlNV3og
	 cL7BiFhR0pVgvHkc=
X-KPN-MID: 33|Kka1u52nTKhati2HZklGdzlCrAK6dJUAtCY9TtMkv0YZyXaSJVjm5ONRI4eQYp9
 GT1ZkmUvGhZteqsu6A7XpSQJv6LhSTbJgOiioaz2QdaA=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|E+xve0HHCd5q8Joug4c70FktoAa5xDw6zkPWOt3jmxfKaO6sIGFuYCbJPSKPxRV
 Edlh5TO7fNR4Wqi63Wywb6A==
X-Originating-IP: 213.10.186.43
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id db2d713b-83e9-11ee-8249-005056ab1411;
	Wed, 15 Nov 2023 20:04:53 +0100 (CET)
Date: Wed, 15 Nov 2023 20:04:52 +0100
From: Antony Antony <antony@phenome.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, netdev@vger.kernel.org,
	Christian Hopps <chopps@labn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [devel-ipsec] [RFC ipsec-next v2 6/8] iptfs: xfrm: Add mode_cbs
 module functionality
Message-ID: <ZVUWVO-c6Sq-188h@Antony2201.local>
References: <20231113035219.920136-1-chopps@chopps.org>
 <20231113035219.920136-7-chopps@chopps.org>
 <ZVItv0C5ilXGvgW6@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="JOmFblaPWscOC16+"
Content-Disposition: inline
In-Reply-To: <ZVItv0C5ilXGvgW6@Antony2201.local>
X-Spam-Level: *


--JOmFblaPWscOC16+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Chris,

On Mon, Nov 13, 2023 at 03:07:59PM +0100, Antony Antony wrote:
> Hi Chris,
> 
> I got couple of more questions. I am trying flush them out. Here is one. And 
> I am still formulating another question.
> 
> On Sun, Nov 12, 2023 at 10:52:17PM -0500, Christian Hopps via Devel wrote:
> > From: Christian Hopps <chopps@labn.net>
> > 
> > Add a set of callbacks xfrm_mode_cbs to xfrm_state. These callbacks
> > enable the addition of new xfrm modes, such as IP-TFS to be defined
> > in modules.
> > 
> > Signed-off-by: Christian Hopps <chopps@labn.net>
> > ---
> >  include/net/xfrm.h     | 36 ++++++++++++++++++++++++++++++++++++
> >  net/xfrm/xfrm_device.c |  3 ++-
> >  net/xfrm/xfrm_input.c  | 14 ++++++++++++--
> >  net/xfrm/xfrm_output.c |  9 +++++++--
> >  net/xfrm/xfrm_policy.c | 18 +++++++++++-------
> >  net/xfrm/xfrm_state.c  | 41 +++++++++++++++++++++++++++++++++++++++++
> >  net/xfrm/xfrm_user.c   | 10 ++++++++++
> >  7 files changed, 119 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> > index d2e87344d175..aeeadadc9545 100644
> > --- a/include/net/xfrm.h
> > +++ b/include/net/xfrm.h
> > @@ -204,6 +204,7 @@ struct xfrm_state {
> >  		u16		family;
> >  		xfrm_address_t	saddr;
> >  		int		header_len;
> > +		int		enc_hdr_len;
> >  		int		trailer_len;
> >  		u32		extra_flags;
> >  		struct xfrm_mark	smark;
> > @@ -289,6 +290,9 @@ struct xfrm_state {
> >  	/* Private data of this transformer, format is opaque,
> >  	 * interpreted by xfrm_type methods. */
> >  	void			*data;
> > +
> > +	const struct xfrm_mode_cbs	*mode_cbs;
> > +	void				*mode_data;
> >  };
> >  
> >  static inline struct net *xs_net(struct xfrm_state *x)
> > @@ -441,6 +445,38 @@ struct xfrm_type_offload {
> >  int xfrm_register_type_offload(const struct xfrm_type_offload *type, unsigned short family);
> >  void xfrm_unregister_type_offload(const struct xfrm_type_offload *type, unsigned short family);
> >  
> > +struct xfrm_mode_cbs {
> > +	struct module	*owner;
> > +	/* Add/delete state in the new xfrm_state in `x`. */
> > +	int	(*create_state)(struct xfrm_state *x);
> > +	void	(*delete_state)(struct xfrm_state *x);
> > +
> > +	/* Called while handling the user netlink options. */
> > +	int	(*user_init)(struct net *net, struct xfrm_state *x,
> > +			     struct nlattr **attrs);
> > +	int	(*copy_to_user)(struct xfrm_state *x, struct sk_buff *skb);
> 
> 
> I'm curious about how xfrm_state_clone() is supported, particularly when 
> it's called in this sequence:
> 
> 
> XFRM_MSG_MIGRATE
> xfrm_do_migrate()
>    xfrm_migrate()
>      xfrm_state_migrate()
>         xfrm_state_clone()
> 
> I've been pondering if perhaps IP-TFS is missing clone support?
> It seems like something along the lines of the attached fragment might be 
> needed.

Here's a tested fix that supports XFRM_MSG_MIGRATE with iptfs. I tested it 
using IPv4, and it's working. I included some memset with zeros to be sure 
those timers are initialized properly. May be it is not necessary!

> And speaking of clone, it got me thinking: could there be packet drops 
> when XFRM_MSG_UPDSA triggers iptfs_delete_state()? Given that an update 
> creates a new state and deletes the old one, it's possible there might be 
> some packet loss. Maybe it's unavoidable?
> 
> Also, I've been wondering state timers or limits expire. What happens when 
> the byte or packet limit exceeds and the state gets deleted? Could that lead 
> to packet loss? The same question applies to rekeying from userspace IKEd.  
> Users are often very sensitive to packet loss during rekeying, and a lot of 
> effort has gone into minimizing it. I'm curious if this has been carefully 
> handled, or if there are considerations we should be aware of."
> 
> > +
> > +	u32	(*get_inner_mtu)(struct xfrm_state *x, int outer_mtu);
> > +
> > +	/* Called to handle received xfrm (egress) packets. */
> > +	int	(*input)(struct xfrm_state *x, struct sk_buff *skb);
> > +
> > +	/* Placed in dst_output of the dst when an xfrm_state is bound. */
> > +	int	(*output)(struct net *net, struct sock *sk, struct sk_buff *skb);
> > +
> > +	/**
> > +	 * Prepare the skb for output for the given mode. Returns:
> > +	 *    Error value, if 0 then skb values should be as follows:
> > +	 *    transport_header should point at ESP header
> > +	 *    network_header should point at Outer IP header
> > +	 *    mac_header should point at protocol/nexthdr of the outer IP
> > +	 */
> > +	int	(*prepare_output)(struct xfrm_state *x, struct sk_buff *skb);
> > +};
> > +
> > +int xfrm_register_mode_cbs(u8 mode, const struct xfrm_mode_cbs *mode_cbs);
> > +void xfrm_unregister_mode_cbs(u8 mode);
> > +
> >  static inline int xfrm_af2proto(unsigned int family)
> >  {
> >  	switch(family) {
> > diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> > index 3784534c9185..8b848540ea47 100644
> > --- a/net/xfrm/xfrm_device.c
> > +++ b/net/xfrm/xfrm_device.c
> > @@ -42,7 +42,8 @@ static void __xfrm_mode_tunnel_prep(struct xfrm_state *x, struct sk_buff *skb,
> >  		skb->transport_header = skb->network_header + hsize;
> >  
> >  	skb_reset_mac_len(skb);
> > -	pskb_pull(skb, skb->mac_len + x->props.header_len);
> > +	pskb_pull(skb,
> > +		  skb->mac_len + x->props.header_len - x->props.enc_hdr_len);
> >  }
> >  
> >  static void __xfrm_mode_beet_prep(struct xfrm_state *x, struct sk_buff *skb,
> > diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> > index bd4ce21d76d7..824f7b7f90e0 100644
> > --- a/net/xfrm/xfrm_input.c
> > +++ b/net/xfrm/xfrm_input.c
> > @@ -437,6 +437,9 @@ static int xfrm_inner_mode_input(struct xfrm_state *x,
> >  		WARN_ON_ONCE(1);
> >  		break;
> >  	default:
> > +		if (x->mode_cbs && x->mode_cbs->input)
> > +			return x->mode_cbs->input(x, skb);
> > +
> >  		WARN_ON_ONCE(1);
> >  		break;
> >  	}
> > @@ -479,6 +482,10 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
> >  
> >  		family = x->props.family;
> >  
> > +		/* An encap_type of -3 indicates reconstructed inner packet */
> > +		if (encap_type == -3)
> > +			goto resume_decapped;
> > +
> >  		/* An encap_type of -1 indicates async resumption. */
> >  		if (encap_type == -1) {
> >  			async = 1;
> > @@ -660,11 +667,14 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
> >  
> >  		XFRM_MODE_SKB_CB(skb)->protocol = nexthdr;
> >  
> > -		if (xfrm_inner_mode_input(x, skb)) {
> > +		err = xfrm_inner_mode_input(x, skb);
> > +		if (err == -EINPROGRESS)
> > +			return 0;
> > +		else if (err) {
> >  			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEMODEERROR);
> >  			goto drop;
> >  		}
> > -
> > +resume_decapped:
> >  		if (x->outer_mode.flags & XFRM_MODE_FLAG_TUNNEL) {
> >  			decaps = 1;
> >  			break;
> > diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> > index 662c83beb345..4390c111410d 100644
> > --- a/net/xfrm/xfrm_output.c
> > +++ b/net/xfrm/xfrm_output.c
> > @@ -280,7 +280,9 @@ static int xfrm4_tunnel_encap_add(struct xfrm_state *x, struct sk_buff *skb)
> >  	skb_set_inner_network_header(skb, skb_network_offset(skb));
> >  	skb_set_inner_transport_header(skb, skb_transport_offset(skb));
> >  
> > -	skb_set_network_header(skb, -x->props.header_len);
> > +	/* backup to add space for the outer encap */
> > +	skb_set_network_header(skb,
> > +			       -x->props.header_len + x->props.enc_hdr_len);
> >  	skb->mac_header = skb->network_header +
> >  			  offsetof(struct iphdr, protocol);
> >  	skb->transport_header = skb->network_header + sizeof(*top_iph);
> > @@ -325,7 +327,8 @@ static int xfrm6_tunnel_encap_add(struct xfrm_state *x, struct sk_buff *skb)
> >  	skb_set_inner_network_header(skb, skb_network_offset(skb));
> >  	skb_set_inner_transport_header(skb, skb_transport_offset(skb));
> >  
> > -	skb_set_network_header(skb, -x->props.header_len);
> > +	skb_set_network_header(skb,
> > +			       -x->props.header_len + x->props.enc_hdr_len);
> >  	skb->mac_header = skb->network_header +
> >  			  offsetof(struct ipv6hdr, nexthdr);
> >  	skb->transport_header = skb->network_header + sizeof(*top_iph);
> > @@ -472,6 +475,8 @@ static int xfrm_outer_mode_output(struct xfrm_state *x, struct sk_buff *skb)
> >  		WARN_ON_ONCE(1);
> >  		break;
> >  	default:
> > +		if (x->mode_cbs->prepare_output)
> > +			return x->mode_cbs->prepare_output(x, skb);
> >  		WARN_ON_ONCE(1);
> >  		break;
> >  	}
> > diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> > index d2dddc570f4f..3220b01121f3 100644
> > --- a/net/xfrm/xfrm_policy.c
> > +++ b/net/xfrm/xfrm_policy.c
> > @@ -2707,13 +2707,17 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
> >  
> >  		dst1->input = dst_discard;
> >  
> > -		rcu_read_lock();
> > -		afinfo = xfrm_state_afinfo_get_rcu(inner_mode->family);
> > -		if (likely(afinfo))
> > -			dst1->output = afinfo->output;
> > -		else
> > -			dst1->output = dst_discard_out;
> > -		rcu_read_unlock();
> > +		if (xfrm[i]->mode_cbs && xfrm[i]->mode_cbs->output) {
> > +			dst1->output = xfrm[i]->mode_cbs->output;
> > +		} else {
> > +			rcu_read_lock();
> > +			afinfo = xfrm_state_afinfo_get_rcu(inner_mode->family);
> > +			if (likely(afinfo))
> > +				dst1->output = afinfo->output;
> > +			else
> > +				dst1->output = dst_discard_out;
> > +			rcu_read_unlock();
> > +		}
> >  
> >  		xdst_prev = xdst;
> >  
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index bda5327bf34d..f5e1a17ebf74 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -513,6 +513,36 @@ static const struct xfrm_mode *xfrm_get_mode(unsigned int encap, int family)
> >  	return NULL;
> >  }
> >  
> > +static struct xfrm_mode_cbs xfrm_mode_cbs_map[XFRM_MODE_MAX];
> > +
> > +int xfrm_register_mode_cbs(u8 mode, const struct xfrm_mode_cbs *mode_cbs)
> > +{
> > +	if (mode >= XFRM_MODE_MAX)
> > +		return -EINVAL;
> > +
> > +	xfrm_mode_cbs_map[mode] = *mode_cbs;
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(xfrm_register_mode_cbs);
> > +
> > +void xfrm_unregister_mode_cbs(u8 mode)
> > +{
> > +	if (mode >= XFRM_MODE_MAX)
> > +		return;
> > +
> > +	memset(&xfrm_mode_cbs_map[mode], 0, sizeof(xfrm_mode_cbs_map[mode]));
> > +}
> > +EXPORT_SYMBOL(xfrm_unregister_mode_cbs);
> > +
> > +static const struct xfrm_mode_cbs *xfrm_get_mode_cbs(u8 mode)
> > +{
> > +	if (mode >= XFRM_MODE_MAX)
> > +		return NULL;
> > +	if (mode == XFRM_MODE_IPTFS && !xfrm_mode_cbs_map[mode].create_state)
> > +		request_module("xfrm-iptfs");
> > +	return &xfrm_mode_cbs_map[mode];
> > +}
> > +
> >  void xfrm_state_free(struct xfrm_state *x)
> >  {
> >  	kmem_cache_free(xfrm_state_cache, x);
> > @@ -521,6 +551,8 @@ EXPORT_SYMBOL(xfrm_state_free);
> >  
> >  static void ___xfrm_state_destroy(struct xfrm_state *x)
> >  {
> > +	if (x->mode_cbs && x->mode_cbs->delete_state)
> > +		x->mode_cbs->delete_state(x);
> >  	hrtimer_cancel(&x->mtimer);
> >  	del_timer_sync(&x->rtimer);
> >  	kfree(x->aead);
> > @@ -2765,6 +2797,9 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
> >  	case XFRM_MODE_TUNNEL:
> >  		break;
> >  	default:
> > +		if (x->mode_cbs && x->mode_cbs->get_inner_mtu)
> > +			return x->mode_cbs->get_inner_mtu(x, mtu);
> > +
> >  		WARN_ON_ONCE(1);
> >  		break;
> >  	}
> > @@ -2850,6 +2885,12 @@ int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool offload,
> >  			goto error;
> >  	}
> >  
> > +	x->mode_cbs = xfrm_get_mode_cbs(x->props.mode);
> > +	if (x->mode_cbs && x->mode_cbs->create_state) {
> > +		err = x->mode_cbs->create_state(x);
> > +		if (err)
> > +			goto error;
> > +	}
> >  error:
> >  	return err;
> >  }
> > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> > index fa2059de51f5..795da945fbc2 100644
> > --- a/net/xfrm/xfrm_user.c
> > +++ b/net/xfrm/xfrm_user.c
> > @@ -779,6 +779,12 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
> >  			goto error;
> >  	}
> >  
> > +	if (x->mode_cbs && x->mode_cbs->user_init) {
> > +		err = x->mode_cbs->user_init(net, x, attrs);
> > +		if (err)
> > +			goto error;
> > +	}
> > +
> >  	return x;
> >  
> >  error:
> > @@ -1192,6 +1198,10 @@ static int copy_to_user_state_extra(struct xfrm_state *x,
> >  		if (ret)
> >  			goto out;
> >  	}
> > +	if (x->mode_cbs && x->mode_cbs->copy_to_user)
> > +		ret = x->mode_cbs->copy_to_user(x, skb);
> > +	if (ret)
> > +		goto out;
> >  	if (x->mapping_maxage)
> >  		ret = nla_put_u32(skb, XFRMA_MTIMER_THRESH, x->mapping_maxage);
> >  out:
> > -- 
> > 2.42.0
> > 
> > -- 
> > Devel mailing list
> > Devel@linux-ipsec.org
> > https://linux-ipsec.org/mailman/listinfo/devel

> From 00fc5af96f90846f1e1882b141699fb62a9f0a73 Mon Sep 17 00:00:00 2001
> From: Antony Antony <antony.antony@secunet.com>
> Date: Mon, 13 Nov 2023 14:20:45 +0100
> Subject: [PATCH] xfrm iptfs migrate poc
> 
> proof of concept for IP-TFS migrate support
> ---
>  include/net/xfrm.h    |  1 +
>  net/xfrm/xfrm_iptfs.c | 20 ++++++++++++++++++++
>  net/xfrm/xfrm_state.c |  6 ++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index a6e0e848918d..176ab5ac436e 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -456,6 +456,7 @@ struct xfrm_mode_cbs {
>  	int	(*user_init)(struct net *net, struct xfrm_state *x,
>  			     struct nlattr **attrs);
>  	int	(*copy_to_user)(struct xfrm_state *x, struct sk_buff *skb);
> +	int     (*clone)(struct xfrm_state *orig, struct xfrm_state *x);
>  
>  	u32	(*get_inner_mtu)(struct xfrm_state *x, int outer_mtu);
>  
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 65f7acdbe6a8..cef269a02b11 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -2613,6 +2613,25 @@ static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
>  	return ret;
>  }
>  
> +static int iptfs_clone(struct xfrm_state *orig,  struct xfrm_state *x)
> +{
> +
> +	x->mode_data = kmemdup(orig->mode_data, sizeof(*x->mode_data),
> +			       GFP_KERNEL);
> +	/**  may be some values, such as the following, should not be copied ??
> +	 * and need different handling ?
> +	 * xtfs->iptfs_timer;
> +	 * xtfs->drop_timer
> +         * xtfs->drop_lock
> +         * xtfs->w_saved
> +         * xtfs;
> +	 */
> +
> +	if (!x->mode_data)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
>  static int iptfs_create_state(struct xfrm_state *x)
>  {
>  	struct xfrm_iptfs_data *xtfs;
> @@ -2667,6 +2686,7 @@ static const struct xfrm_mode_cbs iptfs_mode_cbs = {
>  	.delete_state = iptfs_delete_state,
>  	.user_init = iptfs_user_init,
>  	.copy_to_user = iptfs_copy_to_user,
> +	.clone = iptfs_clone,
>  	.get_inner_mtu = iptfs_get_inner_mtu,
>  	.input = iptfs_input,
>  	.output = iptfs_output_collect,
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 786f3fc0d428..c56d3be56229 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -720,6 +720,7 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
>  		x->replay_maxage = 0;
>  		x->replay_maxdiff = 0;
>  		spin_lock_init(&x->lock);
> +		x->mode_data = NULL;
>  	}
>  	return x;
>  }
> @@ -1787,6 +1788,11 @@ static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
>  	x->new_mapping = 0;
>  	x->new_mapping_sport = 0;
>  
> +	if (x->mode_cbs && x->mode_cbs->clone && orig->mode_data) {
> +		if (!x->mode_cbs->clone(x,orig))
> +			goto error;
> +	}
> +
>  	return x;
>  
>   error:
> -- 
> 2.42.0
> 


--JOmFblaPWscOC16+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-xfrm-iptfs-migrate-poc.patch"

From 6d1ec5adddbe3a904591f465ff8487bc694de139 Mon Sep 17 00:00:00 2001
In-Reply-To: <20231113035219.920136-7-chopps@chopps.org>
References: <20231113035219.920136-7-chopps@chopps.org>
From: Antony Antony <antony@phenome.org>
Date: Mon, 13 Nov 2023 14:20:45 +0100
Subject: [PATCH] xfrm iptfs migrate poc
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org,
    netdev@vger.kernel.org,
    Christian Hopps <chopps@labn.net>,
    Steffen Klassert via Devel <devel@linux-ipsec.org>

From: Antony Antony <antony.antony@secunet.com>

proof of concept for IP-TFS migrate support

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 include/net/xfrm.h    |  1 +
 net/xfrm/xfrm_iptfs.c | 42 ++++++++++++++++++++++++++++++++++++------
 net/xfrm/xfrm_state.c |  6 ++++++
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index a6e0e848918d..176ab5ac436e 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -456,6 +456,7 @@ struct xfrm_mode_cbs {
 	int	(*user_init)(struct net *net, struct xfrm_state *x,
 			     struct nlattr **attrs);
 	int	(*copy_to_user)(struct xfrm_state *x, struct sk_buff *skb);
+	int     (*clone)(struct xfrm_state *orig, struct xfrm_state *x);
 
 	u32	(*get_inner_mtu)(struct xfrm_state *x, int outer_mtu);
 
diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 65f7acdbe6a8..910c5e060931 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2617,12 +2617,15 @@ static int iptfs_create_state(struct xfrm_state *x)
 {
 	struct xfrm_iptfs_data *xtfs;
 
-	xtfs = kzalloc(sizeof(*xtfs), GFP_KERNEL);
-	if (!xtfs)
-		return -ENOMEM;
-	x->mode_data = xtfs;
-
-	xtfs->x = x;
+	if (!x->mode_data) {
+		xtfs = kzalloc(sizeof(*xtfs), GFP_KERNEL);
+		if (!xtfs)
+			return -ENOMEM;
+		x->mode_data = xtfs;
+		xtfs->x = x;
+	} else { /* this is a cloned state */
+		xtfs = (struct xfrm_iptfs_data *) x->mode_data;
+	}
 
 	__skb_queue_head_init(&xtfs->queue);
 	xtfs->init_delay_ns = xtfs->cfg.init_delay_us * NSECS_IN_USEC;
@@ -2661,12 +2664,39 @@ static void iptfs_delete_state(struct xfrm_state *x)
 	kfree_sensitive(xtfs);
 }
 
+static int iptfs_clone(struct xfrm_state *orig,  struct xfrm_state *x)
+{
+	struct xfrm_iptfs_data *xtfs;
+	struct xfrm_iptfs_config *xc;
+
+	x->mode_data = kmemdup(orig->mode_data, sizeof(struct xfrm_iptfs_data),
+			       GFP_KERNEL);
+	if (IS_ERR_OR_NULL(x->mode_data))
+		return -ENOMEM;
+
+	xtfs = (struct xfrm_iptfs_data *)x->mode_data;
+	xtfs->x = x;
+	xc = &xtfs->cfg;
+	if (xc->reorder_win_size)
+		xtfs->w_saved = kcalloc(xc->reorder_win_size, sizeof(*xtfs->w_saved),
+					GFP_KERNEL);
+	xtfs->ra_newskb = NULL;
+	memset(&xtfs->iptfs_timer, 0, sizeof(xtfs->iptfs_timer));
+	memset(&xtfs->drop_timer, 0,sizeof(xtfs->drop_timer));
+	memset(&xtfs->drop_lock, 0, sizeof(xtfs->drop_lock));
+
+	/* x->mode_cbs->create_state(x) will initialize the rest of xtfs */
+
+	return 0;
+}
+
 static const struct xfrm_mode_cbs iptfs_mode_cbs = {
 	.owner = THIS_MODULE,
 	.create_state = iptfs_create_state,
 	.delete_state = iptfs_delete_state,
 	.user_init = iptfs_user_init,
 	.copy_to_user = iptfs_copy_to_user,
+	.clone = iptfs_clone,
 	.get_inner_mtu = iptfs_get_inner_mtu,
 	.input = iptfs_input,
 	.output = iptfs_output_collect,
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 786f3fc0d428..fd592bf4d311 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -720,6 +720,7 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 		x->replay_maxage = 0;
 		x->replay_maxdiff = 0;
 		spin_lock_init(&x->lock);
+		x->mode_data = NULL;
 	}
 	return x;
 }
@@ -1787,6 +1788,11 @@ static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
 	x->new_mapping = 0;
 	x->new_mapping_sport = 0;
 
+	if (orig->mode_cbs && orig->mode_cbs->clone && orig->mode_data) {
+		if (orig->mode_cbs->clone(orig, x))
+			goto error;
+	}
+
 	return x;
 
  error:
-- 
2.42.0


--JOmFblaPWscOC16+--

