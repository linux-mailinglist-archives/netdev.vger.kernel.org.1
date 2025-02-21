Return-Path: <netdev+bounces-168668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86796A401F4
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 22:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7C319C7AAF
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 21:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0330E255E41;
	Fri, 21 Feb 2025 21:16:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D640254B18
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740172595; cv=none; b=oR1NBT9YUUy65ijTKwrsH8HZZZib5u7FuJoauAtWYH/boY8d+g1NkPhYtSRbfEjTtywwvUgsiwRj4wu9WvfJoJdHRnHe2i/mOfILyH43sFr8ThrMc+9/lvqQLPrAGVQtxFOlwaqJKPEQwmRg5fDDYnUVdhbgs3Nrg0bI/2bbj1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740172595; c=relaxed/simple;
	bh=01PPfr8pTmK9HLef/82tm4Z12bBRSoNBzfHTLxmst0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJNrvbOXtCmPSZsKf+Q1K6umWjf74/tIkCm8ZSu7anCL7V7w0afha+oi763tq37b9pSk3YfU6b0reGQ70+M9Ex/KluYUyQ551RI7anEgjjEcvkpuF/AmRv1D8DK7NUdfvIVZU6goNUlxYvepbC7l10x7p+giBj7a82bo+0Ffjmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af2a2.dynamic.kabel-deutschland.de [95.90.242.162])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C596B61E64783;
	Fri, 21 Feb 2025 22:16:09 +0100 (CET)
Message-ID: <aecd919b-fbb8-4790-af1f-69b50cc78438@molgen.mpg.de>
Date: Fri, 21 Feb 2025 22:16:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 1/3] ice: remove SW side
 band access workaround for E825
To: Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
References: <20250221123123.2833395-1-grzegorz.nitka@intel.com>
 <20250221123123.2833395-2-grzegorz.nitka@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250221123123.2833395-2-grzegorz.nitka@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Grzegorz, dear Karol,


Thank you for your patch.

Am 21.02.25 um 13:31 schrieb Grzegorz Nitka:
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> Due to the bug in FW/NVM autoload mechanism (wrong default
> SB_REM_DEV_CTL register settings), the access to peer PHY and CGU
> clients was disabled by default.

I’d add a blank line between the paragraphs.

> As the workaround solution, the register value was overwritten by the
> driver at the probe or reset handling.
> Remove workaround as it's not needed anymore. The fix in autoload
> procedure has been provided with NVM 3.80 version.

Is this compatible with Linux’ no regression policy? People might only 
update the Linux kernel and not the firmware.

How did you test this, and how can others test this?

> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 23 ---------------------
>   1 file changed, 23 deletions(-)


Kind regards,

Paul


> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 89bb8461284a..a5df081ffc19 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -2630,25 +2630,6 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
>   	return 0;
>   }
>   
> -/**
> - * ice_sb_access_ena_eth56g - Enable SB devices (PHY and others) access
> - * @hw: pointer to HW struct
> - * @enable: Enable or disable access
> - *
> - * Enable sideband devices (PHY and others) access.
> - */
> -static void ice_sb_access_ena_eth56g(struct ice_hw *hw, bool enable)
> -{
> -	u32 val = rd32(hw, PF_SB_REM_DEV_CTL);
> -
> -	if (enable)
> -		val |= BIT(eth56g_phy_0) | BIT(cgu) | BIT(eth56g_phy_1);
> -	else
> -		val &= ~(BIT(eth56g_phy_0) | BIT(cgu) | BIT(eth56g_phy_1));
> -
> -	wr32(hw, PF_SB_REM_DEV_CTL, val);
> -}
> -
>   /**
>    * ice_ptp_init_phc_e825 - Perform E825 specific PHC initialization
>    * @hw: pointer to HW struct
> @@ -2659,8 +2640,6 @@ static void ice_sb_access_ena_eth56g(struct ice_hw *hw, bool enable)
>    */
>   static int ice_ptp_init_phc_e825(struct ice_hw *hw)
>   {
> -	ice_sb_access_ena_eth56g(hw, true);
> -
>   	/* Initialize the Clock Generation Unit */
>   	return ice_init_cgu_e82x(hw);
>   }
> @@ -2747,8 +2726,6 @@ static void ice_ptp_init_phy_e825(struct ice_hw *hw)
>   	params->num_phys = 2;
>   	ptp->ports_per_phy = 4;
>   	ptp->num_lports = params->num_phys * ptp->ports_per_phy;
> -
> -	ice_sb_access_ena_eth56g(hw, true);
>   }
>   
>   /* E822 family functions

