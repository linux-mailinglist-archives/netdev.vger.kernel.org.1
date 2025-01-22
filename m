Return-Path: <netdev+bounces-160279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08307A19204
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91A63A07FB
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716031BD014;
	Wed, 22 Jan 2025 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tuc+gMl3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7A483CC7
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737551120; cv=none; b=keL2jRxE4GLQnLnz2WlsNYzEGHceXgHGGDB0K8sML7DiQiRazslgc0wbCjOj5DB8oqPE2a7n/JuAv9cJRITIWMCvhpCy7duqeSS8+hm2PIyiBVC6vY5+fUZrGSOQHZw0bedDgE/LSJwuWQ6mj1FNStQe2VEOhIxa45e0kZaNoeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737551120; c=relaxed/simple;
	bh=3ddHmj0VyhkqpU6tcowrZRlWxXMyZnhYrgizFhnboJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5GgRUQYkOyWInTCYtrxh0P8036ZBklNGuScrZRxToXRblQjxU+K0kyFVWbeMkPBTJmZ8i2OjO1FH+nguhT6eRw1BogHFttv/UMObGubArLd7+8BgTTl9oSlW5LciySCDDLPCIK+c2hdVuhgdRpCAypiCZRbEWwvV+cIFgs2oPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tuc+gMl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7684AC4CED6;
	Wed, 22 Jan 2025 13:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737551118;
	bh=3ddHmj0VyhkqpU6tcowrZRlWxXMyZnhYrgizFhnboJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tuc+gMl3/v46W7XmrM0+y/kpjd8DmiXFTmFQr5UL3Q//DwhF2vIrqjSbO8TYaPdq8
	 pGGAUSQ+RsChf0+kghXNHg+y/MSyW8IyuaiAWrAAUdjQFwcRxTHz5RglI5lHaDtuxI
	 fKJgiJe61p32ypekWR5WTG4dXx6vuhREn+s5ir316IHsJpTq3KDPTrM6BDvFxDTneG
	 2mgPOmnORKCgRjKdmngmojKIAyvx2JZ+IWAev6dwfvTN1FNWiCskfzU0mAo5+F9ab+
	 deg2uprS/HV0HPTejrSJO41AoWuOQNDgq6jtIXXKZ+0k5Tk9Yey0sIdA4aAmyCiNFf
	 LCgxXQy6JkMXg==
Date: Wed, 22 Jan 2025 13:05:15 +0000
From: Simon Horman <horms@kernel.org>
To: Chiachang Wang <chiachangwang@google.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, leonro@nvidia.com,
	yumike@google.com, stanleyjhu@google.com
Subject: Re: [PATCH ipsec v1 2/2] xfrm: Migrate offload configuration
Message-ID: <20250122130515.GE390877@kernel.org>
References: <20250122120941.2634198-1-chiachangwang@google.com>
 <20250122120941.2634198-3-chiachangwang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122120941.2634198-3-chiachangwang@google.com>

On Wed, Jan 22, 2025 at 12:09:41PM +0000, Chiachang Wang wrote:
> If the SA contains offload configuration, the migration
> path should update the SA as well.
> 
> This change supports SA migration with the offload attribute
> configured. This allows the device to migrate with offload
> configuration.
> 
> Test: Endable both in/out IPSec crypto offload, and verify
>       with Android device on both WiFi/cellular network,
>       including:
>       1. WiFi + offload -> Cellular + offload
>       2. WiFi + offload -> Cellular + no offload
>       3. WiFi + no offload -> Cellular + offload
>       4. Wifi + no offload -> Cellular + no offload
>       5. Cellular + offload -> WiFi + offload
>       6. Cellular + no offload -> WiFi + offload
>       7. Cellular + offload -> WiFi + no offload
>       8. Cell + no offload -> WiFi + no offload
> Signed-off-by: Chiachang Wang <chiachangwang@google.com>

...

> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 46d75980eb2e..2fdb4ea97844 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -2007,22 +2007,30 @@ EXPORT_SYMBOL(xfrm_migrate_state_find);
>  
>  struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
>  				      struct xfrm_migrate *m,
> -				      struct xfrm_encap_tmpl *encap)
> +				      struct xfrm_encap_tmpl *encap,
> +				      struct net *net,
> +				      struct xfrm_user_offload *xuo,
> +				      struct netlink_ext_ack *extack)
>  {
>  	struct xfrm_state *xc;
> -
> +	bool offload = (xuo);
>  	xc = xfrm_state_clone(x, encap);
>  	if (!xc)
>  		return NULL;
>  
>  	xc->props.family = m->new_family;
>  
> -	if (xfrm_init_state(xc) < 0)
> +	if (__xfrm_init_state(xc, true, offload, NULL) < 0)
>  		goto error;
>  
> +	x->km.state = XFRM_STATE_VALID;
>  	memcpy(&xc->id.daddr, &m->new_daddr, sizeof(xc->id.daddr));
>  	memcpy(&xc->props.saddr, &m->new_saddr, sizeof(xc->props.saddr));
>  
> +	/* configure the hardware if offload is requested */
> +	if (offload & xfrm_dev_state_add(net, xc, xuo, extack))

Hi Chiachang Wang,

This looks like it is intended to be a logical and (&&)
rather than a bitwise and (&).

Flagged by Smatch.

> +		goto error;
> +
>  	/* add state */
>  	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
>  		/* a care is needed when the destination address of the

