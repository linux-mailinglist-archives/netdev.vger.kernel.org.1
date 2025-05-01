Return-Path: <netdev+bounces-187211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27A6AA5AAF
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 07:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F743AC793
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 05:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DC8230BD2;
	Thu,  1 May 2025 05:49:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5E917A2F5
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 05:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746078578; cv=none; b=pRmhjqSGpJZOgrTUBfeiJ3WGShB1Zhm9vef0c6B1YESatdM25oUTaKL1W4/sF/htMk5ucrULSN1AnS7SmecjQA6cvLRz1d/0W5PIRI20+4Le90c3lVuNPdL2fYQU1h+gsE+2meROIyWqELekA3GdOQij877pCI3wuKA4B9I0LvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746078578; c=relaxed/simple;
	bh=irANtT+cdgRhfl6ey+bv+iQsajZtY90nbQm3P/q6MQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBgg4x3u4czzI3yIKeVb6kOBsPoB9zJooNgUST4L7KUGuPMFCwNy5WFYHCdZ8NwkEzXxHTGsRMxGYG0xWJbs8IwKAjnz7cuZaiaLtRkv2/pCQ8v2tl6c4uAfVP7KttRficlkcOlFI1OmwvhFB2ofCGIqgx0q8tRcXDgyyx9jsbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aea87.dynamic.kabel-deutschland.de [95.90.234.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6F60F61E6478F;
	Thu, 01 May 2025 07:49:06 +0200 (CEST)
Message-ID: <6b4ddead-ab12-4dea-9b02-1943d6330c01@molgen.mpg.de>
Date: Thu, 1 May 2025 07:49:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v3 15/15] ice: change default clock
 source for E825-C
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Anthony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Milena Olech <milena.olech@intel.com>,
 Michal Kubiak <michal.kubiak@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>
References: <20250430-kk-tspll-improvements-alignment-v3-0-ab8472e86204@intel.com>
 <20250430-kk-tspll-improvements-alignment-v3-15-ab8472e86204@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250430-kk-tspll-improvements-alignment-v3-15-ab8472e86204@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Jacob,


Thank you for the patch. For the summary, I suggest the more specific:

ice: Default to clock source TIME_REF for E825-C over TCXO

or

ice: E825-C: Default to clock source TIME_REF over TCXO

Am 01.05.25 um 00:51 schrieb Jacob Keller:
> The driver currently defaults to the internal oscillator as the clock
> source for E825-C hardware. While this clock source is labeled TCXO,
> indicating a temperature compensated oscillator, this is only true for some
> board designs. Many board designs have a less capable oscillator. The
> E825-C hardware may also have its clock source set to the TIME_REF pin.
> This pin is connected to the DPLL and is often a more stable clock source.
> The choice of the internal oscillator is not suitable for all systems,
> especially those which want to enable SyncE support.
> 
> There is currently no interface available for users to configure the clock
> source. Other variants of the E82x board have the clock source configured
> in the NVM, but E825-C lacks this capability, so different board designs
> cannot select a different default clock via firmware.
> 
> In most setups, the TIME_REF is a suitable default clock source.
> Additionally, we now fall back to the internal oscillator automatically if
> the TIME_REF clock source cannot be locked.
> 
> Change the default clock source for E825-C to TIME_REF. Longer term, a
> proper interface (perhaps through dpll subsystem?) to introspect and
> configure the clock source should be designed.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index e5099a3ccb854424f98c5fb1524f49bde1ca4534..bfa3f58c1104def9954073501012bb58a13e8821 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -2302,7 +2302,7 @@ ice_parse_1588_func_caps(struct ice_hw *hw, struct ice_hw_func_caps *func_p,
>   		info->clk_src = ((number & ICE_TS_CLK_SRC_M) != 0);
>   	} else {
>   		info->clk_freq = ICE_TSPLL_FREQ_156_250;
> -		info->clk_src = ICE_CLK_SRC_TCXO;
> +		info->clk_src = ICE_CLK_SRC_TIME_REF;
>   	}
>   
>   	if (info->clk_freq < NUM_ICE_TSPLL_FREQ) {

As there are now Linux kernels configured with different clock sources, 
and there is apparently no way to introspect it from a running system, 
does it make sense to log it?


Kind regards,

Paul


