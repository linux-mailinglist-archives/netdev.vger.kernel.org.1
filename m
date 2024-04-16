Return-Path: <netdev+bounces-88489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF638A770A
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 23:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4421C20B80
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 21:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE3B69946;
	Tue, 16 Apr 2024 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Or5P+iXs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="niaOnC+f"
X-Original-To: netdev@vger.kernel.org
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926306EB53
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713304323; cv=none; b=MSnz08PAq6JRk45kIqXtchuZoZk0jvpGQhlUSSIngr26txRNUZeL776vjIH/sks7ERsQ+WRiiir+hXZZF/4qjER2VPFU958ch7IbeKwQ7ICfDSDBWobaK97R22Srj1kVGEbyNXwhiamhywH6+RNK45SsQ+2lIwBGF31xmr82HBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713304323; c=relaxed/simple;
	bh=kPvb9zNqPz0h6TMrVyCehHMMGglWwMr3Ehf22wt/DA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRXF3XGPJ1p51zSfKrLOfxCUO1B6zihdF/3tAo3uJviSvZmsUN2z+/WiWvkbh2mucI0t720/Zv92Cufp0QaP7T8NynpmsCxeFcGMVW4ovaVVhpSzo/Fm+1RKt35Qg5N9KLFF9tBd2tWv6LolzMK6VpcUhwjdoVY6ROGJyeIA6Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=Or5P+iXs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=niaOnC+f; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 07EC31800109;
	Tue, 16 Apr 2024 17:51:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 16 Apr 2024 17:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1713304319; x=1713390719; bh=JRHLIFejyL
	U3HJfCEAmJmo0+rFRT2xv0EYRDAGyXaxA=; b=Or5P+iXsNtuqWQNHVA0a1MZ398
	t7q8mivlssemUlVK/tx5iEj0MuZf0K9FbOwQHrH4GGwB+JhCHD1A0eChezNztgwp
	OFdcAQTFx++HnoixBZ7PYrQ486wIXcGDEhueaKtgDy7Bahg5FU4hhK0MuzUClTzh
	JIgRILXAbGCMqen5uaslJsZPlNSwWUiFPkMjpweiMsReLgw8UGHZGfKRzVq+Fmw9
	7Y+i6e1XcUvAkCvyHNRS5h+zI5rTHIEROLB1MKszpuZTB3idBcpCcIof8fvvmEET
	1gjNYY//W2g7lA1e1sBhp0zagvB97GppcOrQbkHOfRhjAPAlHFBeZI7W0VgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713304319; x=1713390719; bh=JRHLIFejyLU3HJfCEAmJmo0+rFRT
	2xv0EYRDAGyXaxA=; b=niaOnC+fzXQJUR9TXtlV/l0FrNRFp2gxvChmsbt/B0Ew
	kpR402Ao92RAZXxrM8vDqoA5nWHmL4oHPoIZbg4GtCQmXfYkVQa5gUctPcaxgaEi
	SF6zEyYpek06swtCtJ7LocbrN75/Vy8Kr8ejMu8rmOssG2u8CDMcEpsSEqFHpmT4
	xzoo1kAvKuwl7aZwbZsSRyF8gRPLyjxwrJnH+wjpEOK94w/p6d7V/43YumFbubAy
	l1zPSABIG6sUO5QcOSQ/DZTw8k36A6vdrzTyeemr+AxJxzqhQAsRCjaWXPpoROyO
	uPZV8D2rs4kBcE6GWEzxG+D/iFyZ55zp8/+4q6sfSA==
X-ME-Sender: <xms:_vIeZi8Bm5ZeM_0hMDsS-EcVHzYR9sAKxYXrUGFEMOBohS1L_KaACw>
    <xme:_vIeZivXWYR69h1h2WjUufaJOkjhsjskPSw1b3M7FgYHrS3xTrTfHfiRdSqWwY00L
    p1FWUmoF5RF_GnkiA>
X-ME-Received: <xmr:_vIeZoCXla583cCfk-LWQLPCCTht4NSCMSWcfZ00ojoMPac2fTAGAoNja2LWcAnSYnuC_YpDWUFdufZt5EpwuNskTJzXkz8b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejiedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdt
    tddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeuudekheduffduffff
    gfegiedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:_vIeZqftsap1AQ8DoqddRy9IxioURCduZ1AmOx3HgggC6jcpobgdmA>
    <xmx:_vIeZnP-fa0WRMzNqDluwVPxJa8IvBx1Jllqcdgouy8XMqWxNu8Z0w>
    <xmx:_vIeZklFK969u8ARdP_IchSXXAw1tSIVSEj0UG2WK8qVI8zxQegpyQ>
    <xmx:_vIeZpunlRh2jyALe-A-lcvW4QcrLhM9-5zr881JOifg8n7aEZNPvw>
    <xmx:__IeZjAQF0jOzNupjvfzHCF_NIMIxXrbwyCcYf6ykiQGhnaD2f4MyseO>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Apr 2024 17:51:57 -0400 (EDT)
Date: Tue, 16 Apr 2024 15:51:55 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, devel@linux-ipsec.org, 
	Paul Wouters <paul@nohats.ca>, Antony Antony <antony.antony@secunet.com>, 
	Tobias Brunner <tobias@strongswan.org>
Subject: Re: [PATCH ipsec-next 2/3] xfrm: Cache used outbound xfrm states at
 the policy.
Message-ID: <3qa7guzmpne5sc6etdeoh7juinmio5w57qr37v7if4t63jdqdv@r2vmpdzcpst4>
References: <20240412060553.3483630-1-steffen.klassert@secunet.com>
 <20240412060553.3483630-3-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412060553.3483630-3-steffen.klassert@secunet.com>

Hi Steffen,

On Fri, Apr 12, 2024 at 08:05:52AM +0200, Steffen Klassert wrote:
> Now that we can have percpu xfrm states, the number of active
> states might increase. To get a better lookup performance,
> we cache the used xfrm states at the policy for outbound
> IPsec traffic.
> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> ---
>  include/net/xfrm.h     |  3 +++
>  net/xfrm/xfrm_policy.c | 12 ++++++++++
>  net/xfrm/xfrm_state.c  | 54 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+)
> 
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index 2ba4c077ccf9..49c85bcd9fd9 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -181,6 +181,7 @@ struct xfrm_state {
>  	struct hlist_node	bysrc;
>  	struct hlist_node	byspi;
>  	struct hlist_node	byseq;
> +	struct hlist_node	state_cache;
>  
>  	refcount_t		refcnt;
>  	spinlock_t		lock;
> @@ -524,6 +525,8 @@ struct xfrm_policy {
>  	struct hlist_node	bydst;
>  	struct hlist_node	byidx;
>  
> +	struct hlist_head	state_cache_list;
> +
>  	/* This lock only affects elements except for entry. */
>  	rwlock_t		lock;
>  	refcount_t		refcnt;
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 6affe5cd85d8..6a7f1d40d5f6 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -410,6 +410,7 @@ struct xfrm_policy *xfrm_policy_alloc(struct net *net, gfp_t gfp)
>  	if (policy) {
>  		write_pnet(&policy->xp_net, net);
>  		INIT_LIST_HEAD(&policy->walk.all);
> +		INIT_HLIST_HEAD(&policy->state_cache_list);
>  		INIT_HLIST_NODE(&policy->bydst_inexact_list);
>  		INIT_HLIST_NODE(&policy->bydst);
>  		INIT_HLIST_NODE(&policy->byidx);
> @@ -452,6 +453,9 @@ EXPORT_SYMBOL(xfrm_policy_destroy);
>  
>  static void xfrm_policy_kill(struct xfrm_policy *policy)
>  {
> +	struct net *net = xp_net(policy);
> +	struct xfrm_state *x;
> +
>  	write_lock_bh(&policy->lock);
>  	policy->walk.dead = 1;
>  	write_unlock_bh(&policy->lock);
> @@ -465,6 +469,13 @@ static void xfrm_policy_kill(struct xfrm_policy *policy)
>  	if (del_timer(&policy->timer))
>  		xfrm_pol_put(policy);
>  
> +	/* XXX: Flush state cache */
> +	spin_lock_bh(&net->xfrm.xfrm_state_lock);
> +	hlist_for_each_entry_rcu(x, &policy->state_cache_list, state_cache) {
> +		hlist_del_init_rcu(&x->state_cache);
> +	}
> +	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
> +
>  	xfrm_pol_put(policy);
>  }
>  
> @@ -3253,6 +3264,7 @@ struct dst_entry *xfrm_lookup_with_ifid(struct net *net,
>  		dst_release(dst);
>  		dst = dst_orig;
>  	}
> +
>  ok:
>  	xfrm_pols_put(pols, drop_pols);
>  	if (dst && dst->xfrm &&
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index b41b5dd72d8e..ff2b0fc0b206 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -663,6 +663,7 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
>  		refcount_set(&x->refcnt, 1);
>  		atomic_set(&x->tunnel_users, 0);
>  		INIT_LIST_HEAD(&x->km.all);
> +		INIT_HLIST_NODE(&x->state_cache);
>  		INIT_HLIST_NODE(&x->bydst);
>  		INIT_HLIST_NODE(&x->bysrc);
>  		INIT_HLIST_NODE(&x->byspi);
> @@ -707,12 +708,15 @@ int __xfrm_state_delete(struct xfrm_state *x)
>  
>  	if (x->km.state != XFRM_STATE_DEAD) {
>  		x->km.state = XFRM_STATE_DEAD;
> +
>  		spin_lock(&net->xfrm.xfrm_state_lock);
>  		list_del(&x->km.all);
>  		hlist_del_rcu(&x->bydst);
>  		hlist_del_rcu(&x->bysrc);
>  		if (x->km.seq)
>  			hlist_del_rcu(&x->byseq);
> +		if (!hlist_unhashed(&x->state_cache))
> +			hlist_del_rcu(&x->state_cache);
>  		if (x->id.spi)
>  			hlist_del_rcu(&x->byspi);
>  		net->xfrm.state_num--;
> @@ -1160,6 +1164,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
>  	unsigned short encap_family = tmpl->encap_family;
>  	unsigned int sequence;
>  	struct km_event c;
> +	bool cached = false;
>  	unsigned int pcpu_id = get_cpu();
>  	put_cpu();
>  
> @@ -1168,6 +1173,45 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
>  	sequence = read_seqcount_begin(&net->xfrm.xfrm_state_hash_generation);
>  
>  	rcu_read_lock();
> +	hlist_for_each_entry_rcu(x, &pol->state_cache_list, state_cache) {
> +		if (x->props.family == encap_family &&
> +		    x->props.reqid == tmpl->reqid &&
> +		    (mark & x->mark.m) == x->mark.v &&
> +		    x->if_id == if_id &&
> +		    !(x->props.flags & XFRM_STATE_WILDRECV) &&
> +		    xfrm_state_addr_check(x, daddr, saddr, encap_family) &&
> +		    tmpl->mode == x->props.mode &&
> +		    tmpl->id.proto == x->id.proto &&
> +		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
> +			xfrm_state_look_at(pol, x, fl, encap_family,
> +					   &best, &acquire_in_progress, &error);
> +	}
> +
> +	if (best)
> +		goto cached;
> +
> +	hlist_for_each_entry_rcu(x, &pol->state_cache_list, state_cache) {
> +		if (x->props.family == encap_family &&
> +		    x->props.reqid == tmpl->reqid &&
> +		    (mark & x->mark.m) == x->mark.v &&
> +		    x->if_id == if_id &&
> +		    !(x->props.flags & XFRM_STATE_WILDRECV) &&
> +		    xfrm_addr_equal(&x->id.daddr, daddr, encap_family) &&
> +		    tmpl->mode == x->props.mode &&
> +		    tmpl->id.proto == x->id.proto &&
> +		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
> +			xfrm_state_look_at(pol, x, fl, family,
> +					   &best, &acquire_in_progress, &error);
> +	}
> +
> +cached:
> +	if (best)

Need to set `cached = true` here otherwise slowpath will always be
taken.

[...]

Thanks,
Daniel

