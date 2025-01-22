Return-Path: <netdev+bounces-160282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA44A19211
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05FF17A166C
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4F720FA8A;
	Wed, 22 Jan 2025 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/I7kkDx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692D91EF1D
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737551320; cv=none; b=r9g8VdaNNaFgyM71YO9muXhe/CA7KtEjnCb2/mCaeVlavmRv27H7OulgphPD3jOBpaYkwRBWQUVRTg0df+g1H2vcf7SNVZk4U9pKiKcSfulogukbuXSeXuCURqUzW3q1ng2QoT0q/ZP7SeUYOJpVLyeV3TV6pBG2OJCp6l7sS1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737551320; c=relaxed/simple;
	bh=KY8RDlVvwE2D2yJCB3S4j0y1lDKm2fK/PfgdxfU9Aic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGFbL7I6wtobUnUZevJIzOSaiXRUXS6E3YGwJgdbmPRib4JTEnzEAEAcNlREWT3BSh3e1RdhEBgrDKckLw89I1OTz/qRnWswAgXyF7DMnkHezWqzHnRoXsyqdRMG6ZpCBeOg16kI7CXvfQ+r6BB/iSeNz6A9/K36IZulZqy3w/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/I7kkDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F4FC4CED6;
	Wed, 22 Jan 2025 13:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737551319;
	bh=KY8RDlVvwE2D2yJCB3S4j0y1lDKm2fK/PfgdxfU9Aic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P/I7kkDxQjicuCPkx0EXWy+z0SamNA/oJP1JewBNW5tSJ2bUigdvG6OXNWauZNkX2
	 qZB5KmNXv10KsHY5u9k6V0r3HknPvCwqJ5UJapLxikZaztKVML1tzzt1PB3X2VnEa+
	 zrnXSBrqpafDnprjgfpw95ajmUjx++pdJ+EPyMsqe+izU1wTvCCiiPU1FFox7DPsLk
	 q8CJMJQe5eod++wsRfEvFiqFG0CVJ+CppN932I4L8674SvIGc3QoOXpI5YGorzryLr
	 5b7MaKJcKSHjaulkDMXZgimrSPnpk+s60a8J1MJNIGOOUNP5vGnDdKeMJ/1ia/O5vb
	 AkwbaX6J6VuUA==
Date: Wed, 22 Jan 2025 13:08:36 +0000
From: Simon Horman <horms@kernel.org>
To: Chiachang Wang <chiachangwang@google.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, leonro@nvidia.com,
	yumike@google.com, stanleyjhu@google.com
Subject: Re: [PATCH ipsec v1 1/2] xfrm: Update offload configuration during
 SA updates
Message-ID: <20250122130836.GF390877@kernel.org>
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
> Signed-off-by: Chiachang Wang <chiachangwang@google.com>
> ---
>  net/xfrm/xfrm_state.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c

...

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
>  
> +			if (err) {
> +				netdev_put(xso->dev, &xso->dev_tracker);
> +				goto fail;
> +			}
> +		}
> +	}
> +#endif

For consistency, it looks like all of the code above should be indented by
one more tabstop.

>  		err = 0;
>  		x->km.state = XFRM_STATE_DEAD;
>  		__xfrm_state_put(x);

