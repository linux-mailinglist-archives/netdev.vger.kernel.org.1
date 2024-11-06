Return-Path: <netdev+bounces-142312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD609BE336
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8CF01F22891
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7976F1DB360;
	Wed,  6 Nov 2024 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSfFNmNQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507271DC046
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886834; cv=none; b=je41mA+9NnLQ2InWAV6z4vPB6ftxi5GZECzrmcy4g9yk0VnqbMa9+IDQ5xj3FoC8Lg/6Mc152Qzs62pzm6yW+sl6pPSUxUa2gYot6adjbauZrtLjohSztLaafeEXp+jXXfufvUMKKwIIk5f4+mvB4gcm/ekE9LN0g8vOSPtX2+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886834; c=relaxed/simple;
	bh=bPepb+/BgfiR6bYytxcaRaPssEkGU1xCaygb9x+TGik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxOCDJRmJQekRBXKwQJkXYA9O0U4D/0dnYzA9u6sJrqcVW7E3lv4PU/PmBmw9/z39CTeJll7I1rQGPO+1cVpIOG7IHbZCM/7edKfVvUDwTw54WOrgxjIDAxqAd7ATJPGQ/4rT+3/afDU3lBafqYdH7zfWfuOt5bOzLxYjWJ/Kpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSfFNmNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE18C4CECD;
	Wed,  6 Nov 2024 09:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730886833;
	bh=bPepb+/BgfiR6bYytxcaRaPssEkGU1xCaygb9x+TGik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JSfFNmNQN6bbBo3K1K4YytOYVWdAtrS2O0ewxrIUQ3317WiNL0A+gzKNNkoIsYSwJ
	 OGpH6H0oGG9PXsjl/vj6sq3+iwLJKECncsGT5vgW4TWwmcjHrk4u6yjpY9ZWkJu3PC
	 jYW4z5Jku1drRdlMqAwjgwVv2eRyTOyrVuojSK+2b8IXV+vbY43kjCzcu8C7FFlHCp
	 YFetnctpz/B5n+V1RLKMV7DC/9/52CCkjI4Alj3Zq3Xpbyhdv96Ehf3p6Cg4PIet5e
	 G0LCOFPTQfwu2igLqfty4Ad08YPP68QSzs1V13hkGq5oSJ+ks29BFl2lPiN9acC3Wu
	 SvzOedS2KvHyA==
Date: Wed, 6 Nov 2024 09:53:50 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	sridhar.samudrala@intel.com
Subject: Re: [iwl-next v1 1/3] ice: support max_io_eqs for subfunction
Message-ID: <20241106095350.GJ4507@kernel.org>
References: <20241031060009.38979-1-michal.swiatkowski@linux.intel.com>
 <20241031060009.38979-2-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031060009.38979-2-michal.swiatkowski@linux.intel.com>

On Thu, Oct 31, 2024 at 07:00:07AM +0100, Michal Swiatkowski wrote:
> Implement get and set for the maximum IO event queues for SF.
> It is used to derive the maximum number of Rx/Tx queues on subfunction
> device.
> 
> If the value isn't set when activating set it to the low default value.
> 
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/devlink/port.c | 37 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice.h          |  2 +
>  2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/port.c b/drivers/net/ethernet/intel/ice/devlink/port.c

...

> @@ -548,6 +575,14 @@ ice_activate_dynamic_port(struct ice_dynamic_port *dyn_port,
>  	if (dyn_port->active)
>  		return 0;
>  
> +	if (!dyn_port->vsi->max_io_eqs) {
> +		err = ice_devlink_port_fn_max_io_eqs_set(&dyn_port->devlink_port,
> +							 ICE_SF_DEFAULT_EQS,
> +							 extack);

Hi Michal,

I am a little confused about the relationship between this,
where ICE_SF_DEFAULT_EQS is 8, and the following check in
ice_devlink_port_fn_max_io_eqs_set().

	if (max_io_eqs > num_online_cpus()) {
		NL_SET_ERR_MSG_MOD(extack, "Supplied value out of range");
		return -EINVAL;
	}

What is the behaviour on systems with more than 8 online CPUs?

> +		if (err)
> +			return err;
> +	}
> +
>  	err = ice_sf_eth_activate(dyn_port, extack);
>  	if (err)
>  		return err;

...

> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 70d5294a558c..ca0739625d3b 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -109,6 +109,7 @@
>  #define ICE_Q_WAIT_MAX_RETRY	(5 * ICE_Q_WAIT_RETRY_LIMIT)
>  #define ICE_MAX_LG_RSS_QS	256
>  #define ICE_INVAL_Q_INDEX	0xffff
> +#define ICE_SF_DEFAULT_EQS	8
>  
>  #define ICE_MAX_RXQS_PER_TC		256	/* Used when setting VSI context per TC Rx queues */
>  

...

