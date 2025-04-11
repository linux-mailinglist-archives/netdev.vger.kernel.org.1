Return-Path: <netdev+bounces-181627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0F8A85D61
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 14:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196471BA7BEB
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 12:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B3A221FC7;
	Fri, 11 Apr 2025 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iycIUIfY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32E3221FBF
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375019; cv=none; b=XJ2M7c0v0sZ5FK6S/MuFuZcoffc2GYipyt1myTzaKpNRsjZfRKfF3QjXDVMsyrsiw0X7m3MWhM3Oggp77hJjr3TW0uRFCIyLTS8f5PWMkdquq5mPBA/odAcsYSUhorXjQGwfdtjq+V4uhfH0lP+Bci4bHSxNg0wf7vG7hg13Eq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375019; c=relaxed/simple;
	bh=KnsVY9sZXhd6B4Lr+cWrYHT+qQpOxeZV9n2BSY5yzQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUvVjEDosU/vGx0zrd4GpN5am69El+xSQkBAvyo1KkY9CFypbzNYKU34wNCIUptrDXDScLvCDpGdok/SaNaldlU16Y9YVwPa2mAmr3+hsov+v30Pyi/VwmDGCjjjaYIzmmO9ix1rHBArNUeXIvq+DltQQCK7GcGIeVyDzU9U/IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iycIUIfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B48C4CEE8;
	Fri, 11 Apr 2025 12:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744375019;
	bh=KnsVY9sZXhd6B4Lr+cWrYHT+qQpOxeZV9n2BSY5yzQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iycIUIfYtY9JOui2TvKnm6XF4OcI453O76KcvoWb2Thw2frzIIcjny4BhaYrz6mEK
	 pOjJrJiMcLawF/jbWBiZyge2n0mKsp0sqfNbzGUXJBJvEyBK8WJkQx3sDsJh5L9M3q
	 Va187xejr4Xnexl3e3chSx9dfoR/WEa/IAKXqFRxqF8in6+tJjv9uisiOwX2frS7cQ
	 5ZVpc10qZ/gPRsVtm9Jjx878OKmQFReYfe/ZidBHuOADFtVG52wR0GwqHkPSO9c/nn
	 2n3Kc1UkaHP74dEMETl5+TgqO3FnI+6KXTYHU84OY7DtaT7WcforsJ8LQXLcbQ7sL/
	 UXevDsg78v4uQ==
Date: Fri, 11 Apr 2025 13:36:55 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Michal Kubiak <michal.kubiak@intel.com>,
	Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH v2 iwl-next 02/10] ice: rename TSPLL and CGU functions
 and definitions
Message-ID: <20250411123655.GC395307@horms.kernel.org>
References: <20250409122830.1977644-12-karol.kolacinski@intel.com>
 <20250409122830.1977644-14-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409122830.1977644-14-karol.kolacinski@intel.com>

On Wed, Apr 09, 2025 at 02:24:59PM +0200, Karol Kolacinski wrote:
> Rename TSPLL and CGU functions, definitions etc. to match the file name
> and have consistent naming scheme.
> 
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.h b/drivers/net/ethernet/intel/ice/ice_tspll.h
> index 181ca24a2739..0e28e97e09be 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tspll.h
> +++ b/drivers/net/ethernet/intel/ice/ice_tspll.h
> @@ -2,16 +2,16 @@
>  #define _ICE_TSPLL_H_
>  
>  /**
> - * struct ice_cgu_pll_params_e82x - E82X CGU parameters
> + * struct ice_tspll_params_e82x

nit: tooling expects a short description here.

Flagged by ./scripts/kernel-doc -none

>   * @refclk_pre_div: Reference clock pre-divisor
>   * @feedback_div: Feedback divisor
>   * @frac_n_div: Fractional divisor
>   * @post_pll_div: Post PLL divisor
>   *
>   * Clock Generation Unit parameters used to program the PLL based on the
> - * selected TIME_REF frequency.
> + * selected TIME_REF/TCXO frequency.
>   */
> -struct ice_cgu_pll_params_e82x {
> +struct ice_tspll_params_e82x {
>  	u32 refclk_pre_div;
>  	u32 feedback_div;
>  	u32 frac_n_div;
> @@ -19,25 +19,25 @@ struct ice_cgu_pll_params_e82x {
>  };
>  
>  /**
> - * struct ice_cgu_pll_params_e825c - E825C CGU parameters
> - * @tspll_ck_refclkfreq: tspll_ck_refclkfreq selection
> - * @tspll_ndivratio: ndiv ratio that goes directly to the pll
> - * @tspll_fbdiv_intgr: TS PLL integer feedback divide
> - * @tspll_fbdiv_frac:  TS PLL fractional feedback divide
> - * @ref1588_ck_div: clock divider for tspll ref
> + * struct ice_tspll_params_e825c

Ditto.

> + * @ck_refclkfreq: ck_refclkfreq selection
> + * @ndivratio: ndiv ratio that goes directly to the PLL
> + * @fbdiv_intgr: TSPLL integer feedback divisor
> + * @fbdiv_frac: TSPLL fractional feedback divisor
> + * @ref1588_ck_div: clock divisor for tspll ref
>   *
>   * Clock Generation Unit parameters used to program the PLL based on the
>   * selected TIME_REF/TCXO frequency.
>   */
> -struct ice_cgu_pll_params_e825c {
> -	u32 tspll_ck_refclkfreq;
> -	u32 tspll_ndivratio;
> -	u32 tspll_fbdiv_intgr;
> -	u32 tspll_fbdiv_frac;
> +struct ice_tspll_params_e825c {
> +	u32 ck_refclkfreq;
> +	u32 ndivratio;
> +	u32 fbdiv_intgr;
> +	u32 fbdiv_frac;
>  	u32 ref1588_ck_div;
>  };

...

