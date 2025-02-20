Return-Path: <netdev+bounces-168277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6723A3E5A5
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 21:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92863AFEB3
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 20:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCB9214A8B;
	Thu, 20 Feb 2025 20:11:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE729264610
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082311; cv=none; b=pttJaPRNHWW48ymDv4nZ1k4PlXaJr7Fr2uOmIWFyRj2mKeT089IjWkMeQ48ZkkN9J6r1pOnV3GRAc4GHnmEXJU1rLQw1DlqmHr1wNd9azomfs6hkwHyDlCgVn9mc29EpZ+DurB3SFvQ3LdK2x6IBReQ62f/7AN4UrgB6b6jYltc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082311; c=relaxed/simple;
	bh=p7x5xdC4rIH5/glKQmg4UEIV7RBoE6145C1l9P7saOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTBZ0oR7A+c4kGCNHbTua3TaX4XJdIj59J4TxtSwBN2hi9EyJdlr55PF27kDja0sTKqh04YZLcAa1VUduHOnMNQkkEvU/IMg/yPVggBkyjOeynw/xR50UYb4CKdGpZ5C/IiWbx/6LBvikYY73emVlIPxfKgs8k+4XYsfT+SRj78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af4e3.dynamic.kabel-deutschland.de [95.90.244.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6F3D461E6479C;
	Thu, 20 Feb 2025 21:11:02 +0100 (CET)
Message-ID: <eb5e8d47-30ba-4b95-9b34-ba2de829e131@molgen.mpg.de>
Date: Thu, 20 Feb 2025 21:11:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: fix fwlog after driver
 reinit
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20250220150438.352642-3-martyna.szapar-mudlaw@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250220150438.352642-3-martyna.szapar-mudlaw@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Martyna,


Thank you for your patch.

Am 20.02.25 um 16:04 schrieb Martyna Szapar-Mudlaw:
> Fix an issue when firmware logging stops after devlink reload action
> driver_reinit or driver reset. Fix it by restoring fw logging when

Maybe elaborate, why/how driver reinit or reset disables fwlog.

> it was previously registered before these events.

I’d add a blank line between paragraphs.

> Restoring fw logging in these cases was faultily removed with new
> debugfs fw logging implementation.
> Failure to init fw logging is not a critical error so it is safely
> ignored.

How can this be tested?

> Fixes: 73671c3162c8 ("ice: enable FW logging")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_main.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index a03e1819e6d5..6d6873003bcb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5151,6 +5151,13 @@ int ice_load(struct ice_pf *pf)
>   
>   	devl_assert_locked(priv_to_devlink(pf));
>   
> +	if (pf->hw.fwlog_cfg.options & ICE_FWLOG_OPTION_IS_REGISTERED) {
> +		err = ice_fwlog_register(&pf->hw);
> +		if (err)
> +			pf->hw.fwlog_cfg.options &=
> +				~ICE_FWLOG_OPTION_IS_REGISTERED;

Should an error be logged in the failure case?

> +	}
> +
>   	vsi = ice_get_main_vsi(pf);
>   
>   	/* init channel list */
> @@ -7701,6 +7708,13 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
>   		goto err_init_ctrlq;
>   	}
>   
> +	if (hw->fwlog_cfg.options & ICE_FWLOG_OPTION_IS_REGISTERED) {
> +		err = ice_fwlog_register(hw);
> +		if (err)
> +			hw->fwlog_cfg.options &=
> +				~ICE_FWLOG_OPTION_IS_REGISTERED;
> +	}

Ditto.

> +
>   	/* if DDP was previously loaded successfully */
>   	if (!ice_is_safe_mode(pf)) {
>   		/* reload the SW DB of filter tables */


Kind regards,

Paul

