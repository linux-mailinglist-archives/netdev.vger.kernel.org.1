Return-Path: <netdev+bounces-108163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 746AA91E08A
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 15:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55A51C212D9
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 13:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3B915DBD5;
	Mon,  1 Jul 2024 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o23CYvBM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB8215E5AB
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840220; cv=none; b=CizBoyiy/ID8fpJwWhtvc+CENFyZLJi6FXrIDJPNNbXXf/jAgqSbg26pgJEeBiu9v+g7DQ2UjZkg9w6oloHQ3botpgBOdlvoLBOaM1btHCp/r2ZyW9Egw2TGilPkrBFzm9ZsWzg9TwYu3o81c7zEobx1YqcwPgYc0bzV++Usil8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840220; c=relaxed/simple;
	bh=FPJ8KET8/Tdqej9XMy5mfpa1pEQ4LY66OQ3EA9V60Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R79YHLdvHEI5TIAKM9GcXiR2fRviNEvjBRj5Z74ntDab9kMrtDtuoGurO/QsfPhhIMFggWRztl+YTcR414nrJNdA7LRwcxTB535wumtKNfhswpFNdKLuxWBgYmRovRIPNzh7yUoNwBQMHsV4XhcchlJMwL93Av9zEuH88T/jFH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o23CYvBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B29C2BD10;
	Mon,  1 Jul 2024 13:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719840220;
	bh=FPJ8KET8/Tdqej9XMy5mfpa1pEQ4LY66OQ3EA9V60Ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o23CYvBMKTBPIkHYDeh6ZLWtGOTOCivnIzDjtH4iFxg8odPK+lMhGcTGztAiJ5pf3
	 lQkVpe3pgkARsYyKWTusrLBZ/ZN/NvLWDFmESwKhln8bjt43J35OXFtWUFOeP2IKLt
	 8ltlk+27uvTC0NSgWX/zDPuCLnpk6+Xh/uT5X8oKLvwTqi5I2/4qQ9NaLOLARDcJw7
	 00XLg05gjCk+cKtMfxAxg8U2p2wu3CG8B4WJLTZVbsHfGKASCxVgmBCPmkTNi9Dw+N
	 Et3cjEkDQ1r1mo9i6Uops36/N1RAX+BKNrqo4/ux04BnvA4x0ySRU3kiINxb3sAKIb
	 tdO1X3D8UoNqw==
Date: Mon, 1 Jul 2024 14:23:36 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH iwl-next 1/7] ice: Implement ice_ptp_pin_desc
Message-ID: <20240701132336.GY17134@kernel.org>
References: <20240627151127.284884-9-karol.kolacinski@intel.com>
 <20240627151127.284884-10-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627151127.284884-10-karol.kolacinski@intel.com>

On Thu, Jun 27, 2024 at 05:09:25PM +0200, Karol Kolacinski wrote:
> Add a new internal structure describing PTP pins.
> Use the new structure for all non-E810T products.
> 
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 271 ++++++++++++++++-------
>  drivers/net/ethernet/intel/ice/ice_ptp.h |  65 ++++--
>  2 files changed, 229 insertions(+), 107 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c

...

> +/**
> + * ice_ptp_gpio_enable - Enable/disable ancillary features of PHC
> + * @info: The driver's PTP info structure
>   * @rq: The requested feature to change
>   * @on: Enable/disable flag
> + *
> + * Return: 0 on success, -EOPNOTSUPP when request type is not supported
>   */
> -static int ice_ptp_gpio_enable_e823(struct ptp_clock_info *info,
> -				    struct ptp_clock_request *rq, int on)
> +static int ice_ptp_gpio_enable(struct ptp_clock_info *info,
> +			       struct ptp_clock_request *rq, int on)
>  {
>  	struct ice_pf *pf = ptp_info_to_pf(info);
> +	int err;

nit: This appears to be resolved by a subsequent patch in this series,
     but err is unused in this function.

     Flagged by W=1 allmodconfig builds on x86_64 with gcc-13 and clang-18.

>  
>  	switch (rq->type) {
> -	case PTP_CLK_REQ_PPS:
> +	case PTP_CLK_REQ_PEROUT:
>  	{
> -		struct ice_perout_channel clk_cfg = {};
> +		struct ice_perout_channel clk_cfg;
> +		int pin_desc_idx;
> +
> +		pin_desc_idx = ice_ptp_find_pin_idx(pf, PTP_PF_PEROUT,
> +						    rq->perout.index);
> +		if (pin_desc_idx < 0)
> +			return -EIO;
> +
>  
>  		clk_cfg.flags = rq->perout.flags;
> -		clk_cfg.gpio_pin = PPS_PIN_INDEX;
> -		clk_cfg.period = NSEC_PER_SEC;
> +		clk_cfg.gpio_pin = pf->ptp.ice_pin_desc[pin_desc_idx].gpio[1];
> +		clk_cfg.period = rq->perout.period.sec * NSEC_PER_SEC +
> +				 rq->perout.period.nsec;
> +		clk_cfg.start_time = rq->perout.start.sec * NSEC_PER_SEC +
> +				     rq->perout.start.nsec;
>  		clk_cfg.ena = !!on;
>  
> -		return ice_ptp_cfg_clkout(pf, PPS_CLK_GEN_CHAN, &clk_cfg, true);
> +		return ice_ptp_cfg_clkout(pf, rq->perout.index, &clk_cfg, true);
>  	}
>  	case PTP_CLK_REQ_EXTTS:
>  	{
>  		struct ice_extts_channel extts_cfg = {};
> +		int pin_desc_idx;
> +
> +		pin_desc_idx = ice_ptp_find_pin_idx(pf, PTP_PF_EXTTS,
> +						    rq->extts.index);
> +		if (pin_desc_idx < 0)
> +			return -EIO;
>  
>  		extts_cfg.flags = rq->extts.flags;
> -		extts_cfg.gpio_pin = TIME_SYNC_PIN_INDEX;
> +		extts_cfg.gpio_pin = pf->ptp.ice_pin_desc[pin_desc_idx].gpio[0];
>  		extts_cfg.ena = !!on;
>  
>  		return ice_ptp_cfg_extts(pf, rq->extts.index, &extts_cfg, true);

...

