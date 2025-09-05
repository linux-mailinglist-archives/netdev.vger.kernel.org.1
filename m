Return-Path: <netdev+bounces-220325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A969B456CA
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 13:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056B61C28205
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 11:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41A9322C94;
	Fri,  5 Sep 2025 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXGu8hwq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8322DC334
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072807; cv=none; b=rgZshmAQKIQUHSlxIng3GKdbOHjyWizL2Ve1ObUq9Rkd6o9XGZWyU1F56etxq5XMn/PwnEKBxAqSSe9DUCmjjAQE+CIFuX7vd+amJWxH5/y7/pQA1GioNj5VRz2tvabaPaAEhit0EM6ZFzaybtsTWQTB8pNCUbV9tdzDpT8/mT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072807; c=relaxed/simple;
	bh=CQXpXgZZAjbSz/XACaaYW80rCegWQbY8lTjj3A2yTbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hA2Ofi3YlwDGxWMBWZuIKYSlO7Zqo7xH5TSXZg9T1IWgikkCIq4ixooGSkEWRRDz55WW2YPEK1K1ifQZiqRxAK72jIlbRYZGRI8uQGX0wxyCmsCo9v7LQNUinablT+dQavKNtnGAxCqZMXYNrvVw7TWpm4OaRDPgVlW+d9z2OXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXGu8hwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EB3C4CEF1;
	Fri,  5 Sep 2025 11:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757072807;
	bh=CQXpXgZZAjbSz/XACaaYW80rCegWQbY8lTjj3A2yTbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JXGu8hwq8INQAbNsAe6XM5RbpbVLA5z8WHVWtn8B7X7ijBTwIVtQlo8lcpSX2vycC
	 S3UWQtU4dwgzIiqapTJ3wv80M6+XcW2bn+3XM+V3Y9HSoaNg7MVVoZsaHVYAdrHPaT
	 KQeTec3DtRD9FcYR/BRKOLs+xEGsabTqgVY0IDvcWVS13oY44N6Y8VJnMe7oZBR0Ap
	 e8acNoNJKjY53fsCd2/YvrfJoJFMsNgvvSdft13KW2QGlnpGYPBB6A0JfsTke9xhfT
	 A1O757AFU/oW9VqkyWzA276iH4COhRDPMSwfNvJZEHMw/xeNFLuxZzxVFYWk9zwrAG
	 dLIGiOoFK+U1Q==
Date: Fri, 5 Sep 2025 12:46:42 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: mheib@redhat.com, intel-wired-lan@lists.osuosl.org,
	przemyslawx.patynowski@intel.com, jiri@resnulli.us,
	netdev@vger.kernel.org, aleksandr.loktionov@intel.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net-next,v3,2/2] i40e: support generic devlink param
 "max_mac_per_vf"
Message-ID: <20250905114642.GA551420@horms.kernel.org>
References: <20250903214305.57724-1-mheib@redhat.com>
 <20250903214305.57724-2-mheib@redhat.com>
 <efb80605-187f-4b80-8ba9-8065d1b9e9d0@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efb80605-187f-4b80-8ba9-8065d1b9e9d0@intel.com>

On Wed, Sep 03, 2025 at 03:25:40PM -0700, Jacob Keller wrote:
> 
> 
> On 9/3/2025 2:43 PM, mheib@redhat.com wrote:
> > From: Mohammad Heib <mheib@redhat.com>
> > 
> > Currently the i40e driver enforces its own internally calculated per-VF MAC
> > filter limit, derived from the number of allocated VFs and available
> > hardware resources. This limit is not configurable by the administrator,
> > which makes it difficult to control how many MAC addresses each VF may
> > use.
> > 
> > This patch adds support for the new generic devlink runtime parameter
> > "max_mac_per_vf" which provides administrators with a way to cap the
> > number of MAC addresses a VF can use:
> > 
> > - When the parameter is set to 0 (default), the driver continues to use
> >   its internally calculated limit.
> > 
> > - When set to a non-zero value, the driver applies this value as a strict
> >   cap for VFs, overriding the internal calculation.
> > 
> > Important notes:
> > 
> > - The configured value is a theoretical maximum. Hardware limits may
> >   still prevent additional MAC addresses from being added, even if the
> >   parameter allows it.
> > 
> > - Since MAC filters are a shared hardware resource across all VFs,
> >   setting a high value may cause resource contention and starve other
> >   VFs.
> > 
> > - This change gives administrators predictable and flexible control over
> >   VF resource allocation, while still respecting hardware limitations.
> > 
> > - Previous discussion about this change:
> >   https://lore.kernel.org/netdev/20250805134042.2604897-2-dhill@redhat.com
> >   https://lore.kernel.org/netdev/20250823094952.182181-1-mheib@redhat.com
> > 
> > Signed-off-by: Mohammad Heib <mheib@redhat.com>
> > ---
> 
> This version looks good to me. With or without minor nits relating to
> rate limiting and adding mac_add_max to the untrusted message:
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks, I'm very pleased to see this one coming together.

Reviewed-by: Simon Horman <horms@kernel.org>

> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> > index 081a4526a2f0..6e154a8aa474 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> > @@ -2935,33 +2935,48 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
> >  		if (!f)
> >  			++mac_add_cnt;
> >  	}
> > -
> > -	/* If this VF is not privileged, then we can't add more than a limited
> > -	 * number of addresses.
> > +	/* Determine the maximum number of MAC addresses this VF may use.
> > +	 *
> > +	 * - For untrusted VFs: use a fixed small limit.
> > +	 *
> > +	 * - For trusted VFs: limit is calculated by dividing total MAC
> > +	 *  filter pool across all VFs/ports.
> >  	 *
> > -	 * If this VF is trusted, it can use more resources than untrusted.
> > -	 * However to ensure that every trusted VF has appropriate number of
> > -	 * resources, divide whole pool of resources per port and then across
> > -	 * all VFs.
> > +	 * - User can override this by devlink param "max_mac_per_vf".
> > +	 *   If set its value is used as a strict cap for both trusted and
> > +	 *   untrusted VFs.
> > +	 *   Note:
> > +	 *    even when overridden, this is a theoretical maximum; hardware
> > +	 *    may reject additional MACs if the absolute HW limit is reached.
> >  	 */
> 
> Good. I think this is better and allows users to also increase limit for
> untrusted VFs without requiring them to become fully "trusted" with the
> all-or-nothing approach. Its more flexible in that regard, and avoids
> the confusion of the parameter not working because a VF is untrusted.

+1

> >  	if (!vf_trusted)
> >  		mac_add_max = I40E_VC_MAX_MAC_ADDR_PER_VF;
> >  	else
> >  		mac_add_max = I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs, hw->num_ports);
> >  
> > +	if (pf->max_mac_per_vf > 0)
> > +		mac_add_max = pf->max_mac_per_vf;
> > +
> 
> Nice, a clean way to edit the maximum without needing too much special
> casing.
> 
> >  	/* VF can replace all its filters in one step, in this case mac_add_max
> >  	 * will be added as active and another mac_add_max will be in
> >  	 * a to-be-removed state. Account for that.
> >  	 */
> >  	if ((i40e_count_active_filters(vsi) + mac_add_cnt) > mac_add_max ||
> >  	    (i40e_count_all_filters(vsi) + mac_add_cnt) > 2 * mac_add_max) {
> > +		if (pf->max_mac_per_vf == mac_add_max && mac_add_max > 0) {
> > +			dev_err(&pf->pdev->dev,
> > +				"Cannot add more MAC addresses: VF reached its maximum allowed limit (%d)\n",
> > +				mac_add_max);
> > +				return -EPERM;
> > +		}
> 
> Good, having the specific error message will aid system administrators
> in debugging.

Also, +1.

> One thought I had, which isn't a knock on your code as we did the same
> before.. should these be rate limited to prevent VF spamming MAC filter
> adds clogging up the dmesg buffer?
> 
> Given that we didn't do it before, I think its reasonable to not hold
> this patch up for such a cleanup.
> 
> >  		if (!vf_trusted) {
> >  			dev_err(&pf->pdev->dev,
> >  				"Cannot add more MAC addresses, VF is not trusted, switch the VF to trusted to add more functionality\n");
> >  			return -EPERM;
> >  		} else {
> 
> We didn't rate limit it before. I am not sure how fast the VF can
> actually send messages, so I'm not sure if that change would be required.
> 
> You could optionally also report the mac_add_max for the untrusted
> message as well, but I think its fine to leave as-is in that case as well.

I'm not sure either. I'm more used to rate limits in the datapath,
where network traffic can result in a log.

I think that if we want to go down the path you suggest then we should
look at what other logs fall into the same category: generated by VM admin
actions. And perhaps start by looking in the i40e driver for such cases.

Just my 2c worth on this one.

> 
> >  			dev_err(&pf->pdev->dev,
> > -				"Cannot add more MAC addresses, trusted VF exhausted it's resources\n");
> > +				"Cannot add more MAC addresses: trusted VF reached its maximum allowed limit (%d)\n",
> > +				mac_add_max);
> >  			return -EPERM;
> >  		}
> >  	}
> 




