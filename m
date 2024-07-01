Return-Path: <netdev+bounces-108164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5023A91E092
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 15:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8981F216DE
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 13:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FC015532E;
	Mon,  1 Jul 2024 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNrE6wyt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F07713B597
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840309; cv=none; b=Zwky2r3CaXZxGK1DsT6KJZcUqhnxDSlwLgmSRaIldJQCwJKcllT1UXDHmYrDCY1G+lvN5+EApw68S9e+RGhJCKwZoDTczKrCCzGzc+FewBDopfQ4UBtvVViEmzVZaPIPA4whtvnJadKJTgIpqt1SXXasPBJIt8qOazsAT8MFO1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840309; c=relaxed/simple;
	bh=D0/CEWGuvJGscf/vD5LTGqz5DliN0mtBJpu5nzWNAZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALuJmledVlaxeBbyw2AV6dv5yETk+uT/dRaKDNTi+uTqcZJgirg5zJ2C8Cki6nerAaYzpcKeH47uorEZTMjU6vWGfCkCGo9eyCLk7aCYc4UJvHVUdDCiKQHgc9LotiDGIys4IoUd5coSMjvCDFSMPTMxhG7YysvbSFrq5RoPxQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNrE6wyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A2DC32786;
	Mon,  1 Jul 2024 13:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719840309;
	bh=D0/CEWGuvJGscf/vD5LTGqz5DliN0mtBJpu5nzWNAZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LNrE6wytoUV/09ibIITG72zc0LjbS/U4Ce3PCRFa4hs3ruq04Tuob6Z3LgP4NfnRr
	 9/3cayn5GqkOhXGsj9A+Rq8mvyrHB3ZIFS2yNW/aeHSHJkg0myOfyYtuIuiCs7b+ME
	 S2RsVJjpf8cOZpTADp8t7y+NysoMQETRTywj7zfVrLJUKK3UEs6ORM/o6ywRNWwRpz
	 eEeuvUzFP3MqaVgW38WFLip9VVxVRSD+1ix9shY1TeOAJZnyW6YlMfmu8DHbmIfZIM
	 JwoDeeUhMtebl+GsJYjYG76VB/B6sLCgbf6/+yfTChlhIlf3Cku+5MP2ATUfgiwixf
	 LjqjEQ0gZSI/A==
Date: Mon, 1 Jul 2024 14:25:05 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH iwl-next 2/7] ice: Add SDPs support for E825C
Message-ID: <20240701132505.GZ17134@kernel.org>
References: <20240627151127.284884-9-karol.kolacinski@intel.com>
 <20240627151127.284884-11-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627151127.284884-11-karol.kolacinski@intel.com>

On Thu, Jun 27, 2024 at 05:09:26PM +0200, Karol Kolacinski wrote:
> Add support of PTP SDPs (Software Definable Pins) for E825C products.
> 
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

...

> @@ -2623,9 +2633,13 @@ static void ice_ptp_set_funcs_e82x(struct ice_pf *pf)
>  		pf->ptp.info.getcrosststamp = ice_ptp_getcrosststamp_e82x;
>  
>  #endif /* CONFIG_ICE_HWTS */
> -	pf->ptp.info.enable = ice_ptp_gpio_enable;
> -	pf->ptp.info.verify = ice_verify_pin;
> -	pf->ptp.ice_pin_desc = ice_pin_desc_e82x;
> +	if (ice_is_e825c(&pf->hw)) {
> +		pf->ptp.ice_pin_desc = ice_pin_desc_e825c;
> +		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e825c);
> +	} else {
> +		pf->ptp.ice_pin_desc = ice_pin_desc_e82x;
> +		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e82x);
> +	}
>  	pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e82x);

Hi Karol,

Maybe I'm reading it wrong, but should the line immediately
above be remove to avoid overwriting the value for pf->ptp.info.n_pins
set in the new if/else condition above?

>  	ice_ptp_setup_pin_cfg(pf);
>  }
> @@ -2673,6 +2687,8 @@ static void ice_ptp_set_caps(struct ice_pf *pf)
>  	info->settime64 = ice_ptp_settime64;
>  	info->n_per_out = GLTSYN_TGT_H_IDX_MAX;
>  	info->n_ext_ts = GLTSYN_EVNT_H_IDX_MAX;
> +	info->enable = ice_ptp_gpio_enable;
> +	info->verify = ice_verify_pin;
>  
>  	if (ice_is_e810(&pf->hw))
>  		ice_ptp_set_funcs_e810(pf, info);

Moving these assignments seems unnecessary, but ok.

