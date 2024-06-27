Return-Path: <netdev+bounces-107380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0BD91AB91
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E039828495D
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68864198A2B;
	Thu, 27 Jun 2024 15:38:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ABD198A32
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502700; cv=none; b=BI1GjoARQ9EUW8C1DjEHyjgKgQ6RrESDmCFQYTMNaUffo4DGrzuxRsksfLk9Le9CH0Bt7ER/ZBfkxmrED/0x0NyKuyR5oVPlBy9FGuvricPJ5jqe3QmX1wc5GujO9WFzrRhJV6UW0WyqW4p3EPpYO5JuVMXmIn92Yw9GwmKOcgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502700; c=relaxed/simple;
	bh=0+7pz+zqDSvfiJLvROSdFSi/xKbtbLDqdi4ER+o8QFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pP4rT2JYUikb3dFRYF8kvV708urHqgcChUQPXohm/dw6SAkXUAZKq9YlKvQR5FnZi1V5Hs6gCU6i9tOB1bAcnUAgB80dLPwH3BJAN1SXt+tmra8oPZB4dSntZbfS80OgF80Vy7jGIBTxOXXTrWvvQvWwwV7TyFRmSM8gGSZLdfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5BBFE61E5FE01;
	Thu, 27 Jun 2024 17:37:51 +0200 (CEST)
Message-ID: <1039bcb9-c390-495c-b5c5-aca03a5a6ba4@molgen.mpg.de>
Date: Thu, 27 Jun 2024 17:37:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 7/7] ice: Enable 1PPS out from
 CGU for E825C products
To: Karol Kolacinski <karol.kolacinski@intel.com>,
 Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
References: <20240627151127.284884-9-karol.kolacinski@intel.com>
 <20240627151127.284884-16-karol.kolacinski@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240627151127.284884-16-karol.kolacinski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Karol, dear Sergey,


Thank you for the patch.


Am 27.06.24 um 17:09 schrieb Karol Kolacinski:
> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> 
> Implement 1PPS signal enabling/disabling in CGU. The amplitude is
> always the maximum in this implementation

(Please add a dot/period at the end of sentences.)

Could you please elaborate why using the maximum is alright, that means 
what are the downsides, and what is the alternative approahc.

> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp.c    | 10 ++++++++++
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 21 +++++++++++++++++++++
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  1 +
>   3 files changed, 32 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index d9ff94a4b293..b97ea2b61e5c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -4,6 +4,7 @@
>   #include "ice.h"
>   #include "ice_lib.h"
>   #include "ice_trace.h"
> +#include "ice_cgu_regs.h"
>   
>   static const char ice_pin_names[][64] = {
>   	"SDP0",
> @@ -1708,6 +1709,15 @@ static int ice_ptp_write_perout(struct ice_hw *hw, unsigned int chan,
>   	/* 0. Reset mode & out_en in AUX_OUT */
>   	wr32(hw, GLTSYN_AUX_OUT(chan, tmr_idx), 0);
>   
> +	if (ice_is_e825c(hw)) {
> +		int err;
> +
> +		/* Enable/disable CGU 1PPS output for E825C */
> +		err = ice_cgu_ena_pps_out(hw, !!period);
> +		if (err)
> +			return err;
> +	}

Does only E825C products support this feature?

> +
>   	/* 1. Write perout with half of required period value.
>   	 * HW toggles output when source clock hits the TGT and then adds
>   	 * GLTSYN_CLKO value to the target, so it ends up with 50% duty cycle.
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 07ecf2a86742..fa7cf8453b88 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -661,6 +661,27 @@ static int ice_cfg_cgu_pll_e825c(struct ice_hw *hw,
>   	return 0;
>   }
>   
> +#define ICE_ONE_PPS_OUT_AMP_MAX 3
> +
> +/**
> + * ice_cgu_ena_pps_out - Enable/disable 1PPS output
> + * @hw: pointer to the HW struct
> + * @ena: Enable/disable 1PPS output
> + */
> +int ice_cgu_ena_pps_out(struct ice_hw *hw, bool ena)

Is `ena` short for enable?

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
>   /**
>    * ice_cfg_cgu_pll_dis_sticky_bits_e82x - disable TS PLL sticky bits
>    * @hw: pointer to the HW struct
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> index ff98f76969e3..382e84568256 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> @@ -331,6 +331,7 @@ extern const struct ice_vernier_info_e82x e822_vernier[NUM_ICE_PTP_LNK_SPD];
>   
>   /* Device agnostic functions */
>   u8 ice_get_ptp_src_clock_index(struct ice_hw *hw);
> +int ice_cgu_ena_pps_out(struct ice_hw *hw, bool ena);

If *ena* means “enable”, I do not like this pattern very much, and I’d 
prefer an enable and a disable function.

>   bool ice_ptp_lock(struct ice_hw *hw);
>   void ice_ptp_unlock(struct ice_hw *hw);
>   void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd);


Kind regards,

Paul

