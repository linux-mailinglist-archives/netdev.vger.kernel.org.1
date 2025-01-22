Return-Path: <netdev+bounces-160280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA94A19208
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE0D162AD9
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381CC20FABB;
	Wed, 22 Jan 2025 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcRa7Hnm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139DC1DF26F
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737551228; cv=none; b=nNmGtqJS7jR7pTuAAC/7yf8HDwxNHClxK4qDuYIjjWXDVHDtGZJ+VKlwh5AYgriBZf2RA722CxKUc/UgA00D52OHQgNoupz/BaXva+jQhf+hRN7EZTAhXsT0SkQoPEF2T4vnmgCacYGVYOQTtTKkInpTkp8wD04fHnz0lZGj83Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737551228; c=relaxed/simple;
	bh=xeVhkR+97YvkbL2LkJ+j6qk4nli2kQPfuHNi4ZAX8tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnvXsZHNVgTWR2SSCB90OeP6RoIHnv6ChXc7Eg8i7UX81thgMHFWP0nQOGyymNMuNYwRg7TCUeBQ+rIXLo/ZMPsJQ/KYBsfFcr+3cmyJUyQAKiEKYgKU82yVbbC4S01clinjXEg7rq4HiZcFIJQV8qrIcDZOPrF+4QhUL/1hDPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcRa7Hnm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B4DC4CED6;
	Wed, 22 Jan 2025 13:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737551227;
	bh=xeVhkR+97YvkbL2LkJ+j6qk4nli2kQPfuHNi4ZAX8tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TcRa7Hnm+nzt/GQn85zvpN+ff53qSMhPtwUya/lbyxxqYw2xT/0L9xPAaBSzzUTAR
	 cf6qBABmB/wRhLuA0V8JRn+Tk9wZeVEA+zI41nzTuA6lyc4e8ztqzumrGb2BmVYbNQ
	 F4s2mJ2A78QLlX/S/5E2TQtyB4/nXa4BboYZcSx2tzLswjcq5g1HELZ4M/t6wQL6zR
	 ndFIpp35CkSWL1/w4a1ixj9yVp86J2k1GylMWkLrd7RF5yP0e9EmYnoZdPxrNcy1PC
	 AYYHVbSqGPokaIOc8iziUCWH8KBGYTVFxcJdt4TRus/JfJ3hUulYYkH+oZ6qzAUQi+
	 9/YzbhabqTGmg==
Date: Wed, 22 Jan 2025 15:07:02 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Chiachang Wang <chiachangwang@google.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, yumike@google.com,
	stanleyjhu@google.com
Subject: Re: [PATCH ipsec v1 1/2] xfrm: Update offload configuration during
 SA updates
Message-ID: <20250122130702.GD10702@unreal>
References: <20250122120941.2634198-1-chiachangwang@google.com>
 <20250122120941.2634198-2-chiachangwang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122120941.2634198-2-chiachangwang@google.com>

On Wed, Jan 22, 2025 at 12:09:40PM +0000, Chiachang Wang wrote:
> The offload setting is set to HW when the ipsec session is
> initialized but cannot be changed until the session is torn
> down. The session administrator should be able to update
> the SA via netlink message.
> 
> This patch ensures that when a SA is updated, the associated
> offload configuration is also updated. This is necessary to
> maintain consistency between the SA and the offload device,
> especially when the device is configured for IPSec offload.
> 
> Any offload changes to the SA are reflected in the kernel
> and offload device.
> 
> Test: Enable both in/out crypto offload, and verify with
>       Android device on WiFi/cellular network, including
>       1. WiFi + crypto offload -> WiFi + no offload
>       2. WiFi + no offload -> WiFi + crypto offload
>       3. Cellular + crypto offload -> Cellular + no offload
>       4. Cellular + no offload -> Cellular + crypto offload

Can you please provide iproute2/*swan commands here?
I would like to test it too and not rely on rely on vague "Android device"
thing.

> Signed-off-by: Chiachang Wang <chiachangwang@google.com>
> ---
>  net/xfrm/xfrm_state.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 67ca7ac955a3..46d75980eb2e 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -2047,7 +2047,8 @@ int xfrm_state_update(struct xfrm_state *x)
>  	int err;
>  	int use_spi = xfrm_id_proto_match(x->id.proto, IPSEC_PROTO_ANY);
>  	struct net *net = xs_net(x);
> -
> +	struct xfrm_dev_offload *xso;
> +	struct net_device *old_dev;
>  	to_put = NULL;
>  
>  	spin_lock_bh(&net->xfrm.xfrm_state_lock);
> @@ -2124,7 +2125,28 @@ int xfrm_state_update(struct xfrm_state *x)
>  			__xfrm_state_bump_genids(x1);
>  			spin_unlock_bh(&net->xfrm.xfrm_state_lock);
>  		}
> +#ifdef CONFIG_XFRM_OFFLOAD
> +	x1->type_offload = x->type_offload;
> +
> +	if (memcmp(&x1->xso, &x->xso, sizeof(x1->xso))) {
> +		old_dev = x1->xso.dev;
> +		memcpy(&x1->xso, &x->xso, sizeof(x1->xso));
> +
> +		if (old_dev)
> +			old_dev->xfrmdev_ops->xdo_dev_state_delete(x1);
> +
> +		if (x1->xso.dev) {
> +			xso = &x1->xso;
> +			netdev_hold(xso->dev, &xso->dev_tracker, GFP_ATOMIC);
> +			err = xso->dev->xfrmdev_ops->xdo_dev_state_add(x1, NULL);

You should perform whole delete/free/add cycle. Can we have X with
offload while x1 without offload?

>  
> +			if (err) {
> +				netdev_put(xso->dev, &xso->dev_tracker);
> +				goto fail;

In such case, you deleted offload from x1 and left "broken" system.

> +			}
> +		}
> +	}
> +#endif
>  		err = 0;
>  		x->km.state = XFRM_STATE_DEAD;
>  		__xfrm_state_put(x);
> -- 
> 2.48.1.262.g85cc9f2d1e-goog
> 
> 

