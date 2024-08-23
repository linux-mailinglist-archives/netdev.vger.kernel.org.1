Return-Path: <netdev+bounces-121501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A71B095D7B2
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E54B1F24D79
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5571A193433;
	Fri, 23 Aug 2024 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSsXpCKn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312A214386D
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444109; cv=none; b=HR7ZnuBewrwpB1pOLJ1WALuwuHhEaxDSNyyDcsP/cWIWyqY976hnZ9s9yZj4AmE4eDlOZfiWSnU0YokORlwVDqTsPrz6ndX5DdF/De5tWzPnfg9S7KFVLgKSFHVCnsJsktdbvBl+jBfdlKxGNq4L7C7W77KROxbJPCfZ9t7L/9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444109; c=relaxed/simple;
	bh=iPCZmFyxZGyShQRLGlDs5tAUzSyhdDeC+x9yUkoqnBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAikHA4GIPkTZgZ7TO4wTdYXd/SXE2LvRoPJBKU8KCWM3yChv7BumVRtjCRYhokvh6vzbTA+PBi/I6uAOvD/EEyp0U1RlMmRUzSZPC7/0UBTvKY+NNxJh9ovVMiNcwEEChPzXq5NCfqwh8ldeToi9bIlDwBZ5jvWjqni0x4e3+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSsXpCKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793EEC32786;
	Fri, 23 Aug 2024 20:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724444108;
	bh=iPCZmFyxZGyShQRLGlDs5tAUzSyhdDeC+x9yUkoqnBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HSsXpCKnBh5dsnY1H4n+dqJ6K5SdnHdeorEPgez1L/13KDi362DBSHYLbZkh2r7kJ
	 0j3lD+sXA0NC3T/q+nchPLdXp/5as7bY+QvR9YEMIANONX0ta5jTu0LxMPsbjO0Nta
	 WBchHo7srJX2941HfsAt1W7OYmOShzoSel9sodEo5gslSyD4SX2rP92P9M2GflORsW
	 5rbWKYhZ3Vk1LKlaqAot1RSyIoo1NS9zemN2MRAMiqjshb6isb3Tl7Fp3nvVQVq0bN
	 zcxJq7IrmQdVQk5nofZ954gCm6X7+rI/BA588GzIKil/2SUmymM7dyYkxBOKgBFrjp
	 w0V2Sl10OTGOg==
Date: Fri, 23 Aug 2024 21:15:05 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v7 iwl-next 1/6] ice: Remove unncecessary ice_is_e8xx()
 functions
Message-ID: <20240823201505.GE2164@kernel.org>
References: <20240820102402.576985-8-karol.kolacinski@intel.com>
 <20240820102402.576985-9-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820102402.576985-9-karol.kolacinski@intel.com>

On Tue, Aug 20, 2024 at 12:21:48PM +0200, Karol Kolacinski wrote:
> Remove unnecessary ice_is_e8xx() functions and PHY model. Instead, use
> MAC type where applicable.
> 
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

Hi Karol,

Sorry for waiting until v7 until raising this. But I feel that this patch
is doing a bit more than what is set out in patch description. So I'd like
to suggest some combination of splitting the patch and enhancing the patch
description.

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
> index f02e8ca55375..dd65b2db9856 100644
> --- a/drivers/net/ethernet/intel/ice/ice_gnss.c
> +++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
> @@ -386,27 +386,22 @@ void ice_gnss_exit(struct ice_pf *pf)
>   */
>  bool ice_gnss_is_gps_present(struct ice_hw *hw)
>  {
> +#if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
> +	int err;
> +	u8 data;
> +
>  	if (!hw->func_caps.ts_func_info.src_tmr_owned)
>  		return false;
>  
>  	if (!ice_is_gps_in_netlist(hw))
>  		return false;
>  
> -#if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
> -	if (ice_is_e810t(hw)) {
> -		int err;
> -		u8 data;
> -
> -		err = ice_read_pca9575_reg(hw, ICE_PCA9575_P0_IN, &data);
> -		if (err || !!(data & ICE_P0_GNSS_PRSNT_N))
> -			return false;
> -	} else {
> +	err = ice_read_pca9575_reg(hw, ICE_PCA9575_P0_IN, &data);
> +	if (err || !!(data & ICE_P0_GNSS_PRSNT_N))
>  		return false;
> -	}
> -#else
> -	if (!ice_is_e810t(hw))
> -		return false;
> -#endif /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
>  
>  	return true;
> +#else
> +	return false;
> +#endif /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
>  }

I understand that the above relates to the patch description in the sense
that it removes calls to ice_is_e810t(), a function that is removed
entirely by this patch. But the above is not a simple substitution of one
check for E810T for another. Indeed, it seems far more complex than that.

I think that warrants an explanation, e.g. why is it ok to always return
false if CONFIG_PTP_1588_CLOCK. Perhaps a separate patch is appropriate for
this change.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c

...

> @@ -2759,7 +2766,7 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
>  	bool trigger_oicr = false;
>  	unsigned int i;
>  
> -	if (ice_is_e810(hw))
> +	if (!pf->ptp.port.tx.has_ready_bitmap)
>  		return;
>  
>  	if (!ice_pf_src_tmr_owned(pf))

Likewise, this doesn't really match the patch description.
Sure it is a simple change. And yes, after scanning the code,
I agree that has_ready_bitmap is set other than for E810.
But it is not a check against the MAC type as described in the patch
description.

A separate patch would be nice. Or, if not, an enhanced patch description.


> @@ -2898,14 +2905,12 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
>  	 */
>  	ice_ptp_flush_all_tx_tracker(pf);
>  
> -	if (!ice_is_e810(hw)) {
> -		/* Enable quad interrupts */
> -		err = ice_ptp_cfg_phy_interrupt(pf, true, 1);
> -		if (err)
> -			return err;
> +	/* Enable quad interrupts */
> +	err = ice_ptp_cfg_phy_interrupt(pf, true, 1);
> +	if (err)
> +		return err;
>  
> -		ice_ptp_restart_all_phy(pf);
> -	}
> +	ice_ptp_restart_all_phy(pf);
>  
>  	/* Re-enable all periodic outputs and external timestamp events */
>  	ice_ptp_enable_all_perout(pf);

Here too. Why is it ok to unconditionally enable quad interrupts?

...

