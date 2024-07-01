Return-Path: <netdev+bounces-108168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD1491E0B0
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 15:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58AA0B275D7
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 13:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB03C15E5BA;
	Mon,  1 Jul 2024 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOVcqJNo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9746E15532E
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840468; cv=none; b=kQhNIHFiSZ2V7Aqht8mvtyosgAI2H6qOsqoRlo3BZaBiAgN53UndK6XzLsGnIWBp/MicPWto83BICq0JOZ5IybO8lh/LiyuLRD8l6mnCcoerLxyqVLYrzCKswb/B8zrfhr74OkZVHkZbxhdS0nBix/xKcbDJ4qWyY/UtPksThWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840468; c=relaxed/simple;
	bh=Wc7mFZvn0u9+Zvext7s5db/yx1Q+Lm5Q2VfaWZq1on0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldSLWHf8AG3Fm7UxQOwVtBckGt4FOGA2CzCpisCX8hne14PqZFBPXoZ6MqV996FCGVSaNOXm6S9/okxrDE3Jw3W5RA4PpB2oFlKvfI0V+0rylCQ2FPh6mommDHd/PPtzjSTUadcD4gMPbn3YwK/FXThNRCndrpvjfcobc0gO3sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOVcqJNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC26C116B1;
	Mon,  1 Jul 2024 13:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719840468;
	bh=Wc7mFZvn0u9+Zvext7s5db/yx1Q+Lm5Q2VfaWZq1on0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FOVcqJNo/32H30H6gANFWMvpZOXdmfDPNXdeZc/tnwO1RQvPIIIh0qvDQaGZbXa+5
	 C2+zorTbrQ09SE2kRAPEKyw44SX7PVIDMSfhOD72aI0LK/oKWbDsRaB7p3MwNSQRu2
	 lQPh8gyDCbCJ0kktd4Ym1fWzAvtRTd6AgSDi1sxT0E9m9FybyIUFEfqLpZotmoBHky
	 KC1ClyhA7ssQigWmr3Qv3sUQWBGXFg0Xjtqe6oYzWg+3nIOksN1GNB20EqqEEZnmw9
	 7fZ+S3BxHEQH4X74dT0+xcZbHocFOZaIa9Fpz/L1xr0fM20EzcaIaircLV+ifsibbI
	 qKab9PdMtOhOg==
Date: Mon, 1 Jul 2024 14:27:44 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH iwl-next 7/7] ice: Enable 1PPS out from CGU for E825C
 products
Message-ID: <20240701132744.GD17134@kernel.org>
References: <20240627151127.284884-9-karol.kolacinski@intel.com>
 <20240627151127.284884-16-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627151127.284884-16-karol.kolacinski@intel.com>

On Thu, Jun 27, 2024 at 05:09:31PM +0200, Karol Kolacinski wrote:
> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> 
> Implement 1PPS signal enabling/disabling in CGU. The amplitude is
> always the maximum in this implementation
> 
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 07ecf2a86742..fa7cf8453b88 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -661,6 +661,27 @@ static int ice_cfg_cgu_pll_e825c(struct ice_hw *hw,
>  	return 0;
>  }
>  
> +#define ICE_ONE_PPS_OUT_AMP_MAX 3
> +
> +/**
> + * ice_cgu_ena_pps_out - Enable/disable 1PPS output
> + * @hw: pointer to the HW struct
> + * @ena: Enable/disable 1PPS output

Please include a "Returns: " or "Return: " section in the kernel doc
for functions that have a return value.

NIPA has recently got more picky about this.
Flagged by kernel-doc -none --Warn

> + */
> +int ice_cgu_ena_pps_out(struct ice_hw *hw, bool ena)
> +{
> +	union nac_cgu_dword9 dw9;
> +	int err;
> +
> +	err = ice_read_cgu_reg_e82x(hw, NAC_CGU_DWORD9, &dw9.val);
> +	if (err)
> +		return err;
> +
> +	dw9.one_pps_out_en = ena;
> +	dw9.one_pps_out_amp = ena * ICE_ONE_PPS_OUT_AMP_MAX;
> +	return ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD9, dw9.val);
> +}
> +
>  /**
>   * ice_cfg_cgu_pll_dis_sticky_bits_e82x - disable TS PLL sticky bits
>   * @hw: pointer to the HW struct

...

