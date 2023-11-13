Return-Path: <netdev+bounces-47379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FCA7E9E2A
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 15:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A1B1F214AF
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 14:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A9C20B2C;
	Mon, 13 Nov 2023 14:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="IPBzmo3T"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0B9200AB
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 14:08:05 +0000 (UTC)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBEED4C
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 06:08:02 -0800 (PST)
X-KPN-MessageId: 098a9b3e-822e-11ee-a95f-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 098a9b3e-822e-11ee-a95f-005056abbe64;
	Mon, 13 Nov 2023 15:07:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=56FYcUwj8H/kJoeUfHUm7X+tO8RrCsmxbb1B3TYD5Jg=;
	b=IPBzmo3Tq+Prk9LswpHS9HL/hTFWuSl8QooDcvyTKBq7uhGvEfO9EFG5iCpDOQeMiP7PQQPfpi69c
	 XuWV94ni06X08q5ApZBwhoOlM05fCeKSRhoFcgtfIRIT2yhyGKiCuPQGoAgqmjRe+SnwTOhA8GwvFh
	 tBUbFvSYYXL79Q1s=
X-KPN-MID: 33|0DS9dj2JpMEpQytfcz1r2p8QBiuQojsMaHPlgPWAPiNz/A75U/3QkLltqiFlOOP
 mO9DkdOiuBYOA5cn/VRYL7XHzpExufu9syH4WnsZFYYw=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|4MWnDnNSKazeN1IFN+ZKH7iIBN8Ke2ic20SMCHBdzaDfnhdxjZW1i+5ObqXKWrQ
 SfmlsbAoqLikdTrBWzl5XVw==
X-Originating-IP: 213.10.186.43
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 0cef4f96-822e-11ee-9f03-005056ab7584;
	Mon, 13 Nov 2023 15:08:00 +0100 (CET)
Date: Mon, 13 Nov 2023 15:07:59 +0100
From: Antony Antony <antony@phenome.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, netdev@vger.kernel.org,
	Christian Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [RFC ipsec-next v2 6/8] iptfs: xfrm: Add mode_cbs
 module functionality
Message-ID: <ZVItv0C5ilXGvgW6@Antony2201.local>
References: <20231113035219.920136-1-chopps@chopps.org>
 <20231113035219.920136-7-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="i4QFmUCPLQHOhq2W"
Content-Disposition: inline
In-Reply-To: <20231113035219.920136-7-chopps@chopps.org>


--i4QFmUCPLQHOhq2W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Chris,

I got couple of more questions. I am trying flush them out. Here is one. And 
I am still formulating another question.

On Sun, Nov 12, 2023 at 10:52:17PM -0500, Christian Hopps via Devel wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Add a set of callbacks xfrm_mode_cbs to xfrm_state. These callbacks
> enable the addition of new xfrm modes, such as IP-TFS to be defined
> in modules.
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
>  include/net/xfrm.h     | 36 ++++++++++++++++++++++++++++++++++++
>  net/xfrm/xfrm_device.c |  3 ++-
>  net/xfrm/xfrm_input.c  | 14 ++++++++++++--
>  net/xfrm/xfrm_output.c |  9 +++++++--
>  net/xfrm/xfrm_policy.c | 18 +++++++++++-------
>  net/xfrm/xfrm_state.c  | 41 +++++++++++++++++++++++++++++++++++++++++
>  net/xfrm/xfrm_user.c   | 10 ++++++++++
>  7 files changed, 119 insertions(+), 12 deletions(-)
> 
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index d2e87344d175..aeeadadc9545 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -204,6 +204,7 @@ struct xfrm_state {
>  		u16		family;
>  		xfrm_address_t	saddr;
>  		int		header_len;
> +		int		enc_hdr_len;
>  		int		trailer_len;
>  		u32		extra_flags;
>  		struct xfrm_mark	smark;
> @@ -289,6 +290,9 @@ struct xfrm_state {
>  	/* Private data of this transformer, format is opaque,
>  	 * interpreted by xfrm_type methods. */
>  	void			*data;
> +
> +	const struct xfrm_mode_cbs	*mode_cbs;
> +	void				*mode_data;
>  };
>  
>  static inline struct net *xs_net(struct xfrm_state *x)
> @@ -441,6 +445,38 @@ struct xfrm_type_offload {
>  int xfrm_register_type_offload(const struct xfrm_type_offload *type, unsigned short family);
>  void xfrm_unregister_type_offload(const struct xfrm_type_offload *type, unsigned short family);
>  
> +struct xfrm_mode_cbs {
> +	struct module	*owner;
> +	/* Add/delete state in the new xfrm_state in `x`. */
> +	int	(*create_state)(struct xfrm_state *x);
> +	void	(*delete_state)(struct xfrm_state *x);
> +
> +	/* Called while handling the user netlink options. */
> +	int	(*user_init)(struct net *net, struct xfrm_state *x,
> +			     struct nlattr **attrs);
> +	int	(*copy_to_user)(struct xfrm_state *x, struct sk_buff *skb);


I'm curious about how xfrm_state_clone() is supported, particularly when 
it's called in this sequence:


XFRM_MSG_MIGRATE
xfrm_do_migrate()
   xfrm_migrate()
     xfrm_state_migrate()
        xfrm_state_clone()

I've been pondering if perhaps IP-TFS is missing clone support?
It seems like something along the lines of the attached fragment might be 
needed.

And speaking of clone, it got me thinking: could there be packet drops when 
XFRM_MSG_UPDSA triggers iptfs_delete_state()? Given that an update creates a 
new state and deletes the old one, it's possible there might be some packet 
loss. Maybe it's unavoidable?

Also, I've been wondering state timers or limits expire. What happens when 
the byte or packet limit exceeds and the state gets deleted? Could that lead 
to packet loss? The same question applies to rekeying from userspace IKEd.  
Users are often very sensitive to packet loss during rekeying, and a lot of 
effort has gone into minimizing it. I'm curious if this has been carefully 
handled, or if there are considerations we should be aware of."

> +
> +	u32	(*get_inner_mtu)(struct xfrm_state *x, int outer_mtu);
> +
> +	/* Called to handle received xfrm (egress) packets. */
> +	int	(*input)(struct xfrm_state *x, struct sk_buff *skb);
> +
> +	/* Placed in dst_output of the dst when an xfrm_state is bound. */
> +	int	(*output)(struct net *net, struct sock *sk, struct sk_buff *skb);
> +
> +	/**
> +	 * Prepare the skb for output for the given mode. Returns:
> +	 *    Error value, if 0 then skb values should be as follows:
> +	 *    transport_header should point at ESP header
> +	 *    network_header should point at Outer IP header
> +	 *    mac_header should point at protocol/nexthdr of the outer IP
> +	 */
> +	int	(*prepare_output)(struct xfrm_state *x, struct sk_buff *skb);
> +};
> +
> +int xfrm_register_mode_cbs(u8 mode, const struct xfrm_mode_cbs *mode_cbs);
> +void xfrm_unregister_mode_cbs(u8 mode);
> +
>  static inline int xfrm_af2proto(unsigned int family)
>  {
>  	switch(family) {
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 3784534c9185..8b848540ea47 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -42,7 +42,8 @@ static void __xfrm_mode_tunnel_prep(struct xfrm_state *x, struct sk_buff *skb,
>  		skb->transport_header = skb->network_header + hsize;
>  
>  	skb_reset_mac_len(skb);
> -	pskb_pull(skb, skb->mac_len + x->props.header_len);
> +	pskb_pull(skb,
> +		  skb->mac_len + x->props.header_len - x->props.enc_hdr_len);
>  }
>  
>  static void __xfrm_mode_beet_prep(struct xfrm_state *x, struct sk_buff *skb,
> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index bd4ce21d76d7..824f7b7f90e0 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -437,6 +437,9 @@ static int xfrm_inner_mode_input(struct xfrm_state *x,
>  		WARN_ON_ONCE(1);
>  		break;
>  	default:
> +		if (x->mode_cbs && x->mode_cbs->input)
> +			return x->mode_cbs->input(x, skb);
> +
>  		WARN_ON_ONCE(1);
>  		break;
>  	}
> @@ -479,6 +482,10 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  
>  		family = x->props.family;
>  
> +		/* An encap_type of -3 indicates reconstructed inner packet */
> +		if (encap_type == -3)
> +			goto resume_decapped;
> +
>  		/* An encap_type of -1 indicates async resumption. */
>  		if (encap_type == -1) {
>  			async = 1;
> @@ -660,11 +667,14 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  
>  		XFRM_MODE_SKB_CB(skb)->protocol = nexthdr;
>  
> -		if (xfrm_inner_mode_input(x, skb)) {
> +		err = xfrm_inner_mode_input(x, skb);
> +		if (err == -EINPROGRESS)
> +			return 0;
> +		else if (err) {
>  			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEMODEERROR);
>  			goto drop;
>  		}
> -
> +resume_decapped:
>  		if (x->outer_mode.flags & XFRM_MODE_FLAG_TUNNEL) {
>  			decaps = 1;
>  			break;
> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> index 662c83beb345..4390c111410d 100644
> --- a/net/xfrm/xfrm_output.c
> +++ b/net/xfrm/xfrm_output.c
> @@ -280,7 +280,9 @@ static int xfrm4_tunnel_encap_add(struct xfrm_state *x, struct sk_buff *skb)
>  	skb_set_inner_network_header(skb, skb_network_offset(skb));
>  	skb_set_inner_transport_header(skb, skb_transport_offset(skb));
>  
> -	skb_set_network_header(skb, -x->props.header_len);
> +	/* backup to add space for the outer encap */
> +	skb_set_network_header(skb,
> +			       -x->props.header_len + x->props.enc_hdr_len);
>  	skb->mac_header = skb->network_header +
>  			  offsetof(struct iphdr, protocol);
>  	skb->transport_header = skb->network_header + sizeof(*top_iph);
> @@ -325,7 +327,8 @@ static int xfrm6_tunnel_encap_add(struct xfrm_state *x, struct sk_buff *skb)
>  	skb_set_inner_network_header(skb, skb_network_offset(skb));
>  	skb_set_inner_transport_header(skb, skb_transport_offset(skb));
>  
> -	skb_set_network_header(skb, -x->props.header_len);
> +	skb_set_network_header(skb,
> +			       -x->props.header_len + x->props.enc_hdr_len);
>  	skb->mac_header = skb->network_header +
>  			  offsetof(struct ipv6hdr, nexthdr);
>  	skb->transport_header = skb->network_header + sizeof(*top_iph);
> @@ -472,6 +475,8 @@ static int xfrm_outer_mode_output(struct xfrm_state *x, struct sk_buff *skb)
>  		WARN_ON_ONCE(1);
>  		break;
>  	default:
> +		if (x->mode_cbs->prepare_output)
> +			return x->mode_cbs->prepare_output(x, skb);
>  		WARN_ON_ONCE(1);
>  		break;
>  	}
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index d2dddc570f4f..3220b01121f3 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -2707,13 +2707,17 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
>  
>  		dst1->input = dst_discard;
>  
> -		rcu_read_lock();
> -		afinfo = xfrm_state_afinfo_get_rcu(inner_mode->family);
> -		if (likely(afinfo))
> -			dst1->output = afinfo->output;
> -		else
> -			dst1->output = dst_discard_out;
> -		rcu_read_unlock();
> +		if (xfrm[i]->mode_cbs && xfrm[i]->mode_cbs->output) {
> +			dst1->output = xfrm[i]->mode_cbs->output;
> +		} else {
> +			rcu_read_lock();
> +			afinfo = xfrm_state_afinfo_get_rcu(inner_mode->family);
> +			if (likely(afinfo))
> +				dst1->output = afinfo->output;
> +			else
> +				dst1->output = dst_discard_out;
> +			rcu_read_unlock();
> +		}
>  
>  		xdst_prev = xdst;
>  
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index bda5327bf34d..f5e1a17ebf74 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -513,6 +513,36 @@ static const struct xfrm_mode *xfrm_get_mode(unsigned int encap, int family)
>  	return NULL;
>  }
>  
> +static struct xfrm_mode_cbs xfrm_mode_cbs_map[XFRM_MODE_MAX];
> +
> +int xfrm_register_mode_cbs(u8 mode, const struct xfrm_mode_cbs *mode_cbs)
> +{
> +	if (mode >= XFRM_MODE_MAX)
> +		return -EINVAL;
> +
> +	xfrm_mode_cbs_map[mode] = *mode_cbs;
> +	return 0;
> +}
> +EXPORT_SYMBOL(xfrm_register_mode_cbs);
> +
> +void xfrm_unregister_mode_cbs(u8 mode)
> +{
> +	if (mode >= XFRM_MODE_MAX)
> +		return;
> +
> +	memset(&xfrm_mode_cbs_map[mode], 0, sizeof(xfrm_mode_cbs_map[mode]));
> +}
> +EXPORT_SYMBOL(xfrm_unregister_mode_cbs);
> +
> +static const struct xfrm_mode_cbs *xfrm_get_mode_cbs(u8 mode)
> +{
> +	if (mode >= XFRM_MODE_MAX)
> +		return NULL;
> +	if (mode == XFRM_MODE_IPTFS && !xfrm_mode_cbs_map[mode].create_state)
> +		request_module("xfrm-iptfs");
> +	return &xfrm_mode_cbs_map[mode];
> +}
> +
>  void xfrm_state_free(struct xfrm_state *x)
>  {
>  	kmem_cache_free(xfrm_state_cache, x);
> @@ -521,6 +551,8 @@ EXPORT_SYMBOL(xfrm_state_free);
>  
>  static void ___xfrm_state_destroy(struct xfrm_state *x)
>  {
> +	if (x->mode_cbs && x->mode_cbs->delete_state)
> +		x->mode_cbs->delete_state(x);
>  	hrtimer_cancel(&x->mtimer);
>  	del_timer_sync(&x->rtimer);
>  	kfree(x->aead);
> @@ -2765,6 +2797,9 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
>  	case XFRM_MODE_TUNNEL:
>  		break;
>  	default:
> +		if (x->mode_cbs && x->mode_cbs->get_inner_mtu)
> +			return x->mode_cbs->get_inner_mtu(x, mtu);
> +
>  		WARN_ON_ONCE(1);
>  		break;
>  	}
> @@ -2850,6 +2885,12 @@ int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool offload,
>  			goto error;
>  	}
>  
> +	x->mode_cbs = xfrm_get_mode_cbs(x->props.mode);
> +	if (x->mode_cbs && x->mode_cbs->create_state) {
> +		err = x->mode_cbs->create_state(x);
> +		if (err)
> +			goto error;
> +	}
>  error:
>  	return err;
>  }
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index fa2059de51f5..795da945fbc2 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -779,6 +779,12 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
>  			goto error;
>  	}
>  
> +	if (x->mode_cbs && x->mode_cbs->user_init) {
> +		err = x->mode_cbs->user_init(net, x, attrs);
> +		if (err)
> +			goto error;
> +	}
> +
>  	return x;
>  
>  error:
> @@ -1192,6 +1198,10 @@ static int copy_to_user_state_extra(struct xfrm_state *x,
>  		if (ret)
>  			goto out;
>  	}
> +	if (x->mode_cbs && x->mode_cbs->copy_to_user)
> +		ret = x->mode_cbs->copy_to_user(x, skb);
> +	if (ret)
> +		goto out;
>  	if (x->mapping_maxage)
>  		ret = nla_put_u32(skb, XFRMA_MTIMER_THRESH, x->mapping_maxage);
>  out:
> -- 
> 2.42.0
> 
> -- 
> Devel mailing list
> Devel@linux-ipsec.org
> https://linux-ipsec.org/mailman/listinfo/devel

--i4QFmUCPLQHOhq2W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-xfrm-iptfs-migrate-poc.patch"

From 00fc5af96f90846f1e1882b141699fb62a9f0a73 Mon Sep 17 00:00:00 2001
From: Antony Antony <antony.antony@secunet.com>
Date: Mon, 13 Nov 2023 14:20:45 +0100
Subject: [PATCH] xfrm iptfs migrate poc

proof of concept for IP-TFS migrate support
---
 include/net/xfrm.h    |  1 +
 net/xfrm/xfrm_iptfs.c | 20 ++++++++++++++++++++
 net/xfrm/xfrm_state.c |  6 ++++++
 3 files changed, 27 insertions(+)

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
index 65f7acdbe6a8..cef269a02b11 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2613,6 +2613,25 @@ static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
 	return ret;
 }
 
+static int iptfs_clone(struct xfrm_state *orig,  struct xfrm_state *x)
+{
+
+	x->mode_data = kmemdup(orig->mode_data, sizeof(*x->mode_data),
+			       GFP_KERNEL);
+	/**  may be some values, such as the following, should not be copied ??
+	 * and need different handling ?
+	 * xtfs->iptfs_timer;
+	 * xtfs->drop_timer
+         * xtfs->drop_lock
+         * xtfs->w_saved
+         * xtfs;
+	 */
+
+	if (!x->mode_data)
+		return -ENOMEM;
+
+	return 0;
+}
 static int iptfs_create_state(struct xfrm_state *x)
 {
 	struct xfrm_iptfs_data *xtfs;
@@ -2667,6 +2686,7 @@ static const struct xfrm_mode_cbs iptfs_mode_cbs = {
 	.delete_state = iptfs_delete_state,
 	.user_init = iptfs_user_init,
 	.copy_to_user = iptfs_copy_to_user,
+	.clone = iptfs_clone,
 	.get_inner_mtu = iptfs_get_inner_mtu,
 	.input = iptfs_input,
 	.output = iptfs_output_collect,
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 786f3fc0d428..c56d3be56229 100644
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
 
+	if (x->mode_cbs && x->mode_cbs->clone && orig->mode_data) {
+		if (!x->mode_cbs->clone(x,orig))
+			goto error;
+	}
+
 	return x;
 
  error:
-- 
2.42.0


--i4QFmUCPLQHOhq2W--

