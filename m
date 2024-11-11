Return-Path: <netdev+bounces-143757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2290F9C3FE4
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 14:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D4F1F22B5A
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 13:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D50419D8BC;
	Mon, 11 Nov 2024 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YA5O1gyQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1401B19C552;
	Mon, 11 Nov 2024 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333201; cv=none; b=ZqFn/cbRmGux40+oyYV5C1xYXhEIgTXZZhpLuFC4TN6OYY73TkrXmnYXrX0vgNAWWrByMJIqoPZvADG+OcIazJGbbnWHDyn3Y3zE3puVL+DYLw1YG90qfpGao25aLNCJZhWLMOpFLuejut2eB8nYuSX/6/j/YVEEZF0kze9bS6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333201; c=relaxed/simple;
	bh=ge5oa0wYzEMJ7QB+lZ6ggej9jKDVWgoVDWlv5rzge9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PhAk1yr6pZ4kJGFpDHcUmJzsungf1hS5ULTBYJ7ps/CSVCm19f6ZbfTCRT4/ZMaSM5i3xesNecL2+DzIYoIHFQXxDf+5TSdgvvp3Q/+ruTZyXi57R1GKMY/O2qgQkr0GVhZiml0YSS48Wl3T9/rfaTzFtOyGR/x+sWLdH+5JGqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YA5O1gyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7E2C4CECF;
	Mon, 11 Nov 2024 13:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731333200;
	bh=ge5oa0wYzEMJ7QB+lZ6ggej9jKDVWgoVDWlv5rzge9E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YA5O1gyQh3kljoc/vTndzAudVh7CVjwqrznl4tjWw+sqAaO/LLIHElV1SQhhU84fj
	 YL1FSkeoCXx3frSZHkns7PtW0sjBiUYcL3zojU3q4Rsb/Li1YJTqXthbhaZmvaVJNe
	 NJjMaNWrneeLWHvfh8kyPSZBtU33OiuO0FdHevrcylMKN3PZVBFYCdkSTKGP2dX4j+
	 g2oGkXJkBtC/GiwJp3gjJ/pRNZvlaRWap0PkEI8rd83GYidhwuP+SGpJPqXW11nezi
	 9zIDMVCkPKfVtpyokm2+mTPzeykcjQ1vjKq6HlgjO9SEBTqvbb0kuVXNf5LRBfcRzg
	 0cdTK+ay0TnTw==
Message-ID: <f28bf97c-783d-489c-9549-0dd0f576497e@kernel.org>
Date: Mon, 11 Nov 2024 15:53:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: ti: icssg-prueth: Fix clearing of
 IEP_CMP_CFG registers during iep_init
To: Meghana Malladi <m-malladi@ti.com>, vigneshr@ti.com, m-karicheri2@ti.com,
 jan.kiszka@siemens.com, javier.carrasco.cruz@gmail.com,
 jacob.e.keller@intel.com, horms@kernel.org, diogo.ivo@siemens.com,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, danishanwar@ti.com
References: <20241106074040.3361730-1-m-malladi@ti.com>
 <20241106074040.3361730-3-m-malladi@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241106074040.3361730-3-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 06/11/2024 09:40, Meghana Malladi wrote:
> When ICSSG interfaces are brought down and brought up again, the
> pru cores are shut down and booted again, flushing out all the memories
> and start again in a clean state. Hence it is expected that the
> IEP_CMP_CFG register needs to be flushed during iep_init() to ensure
> that the existing residual configuration doesn't cause any unusual
> behavior. If the register is not cleared, existing IEP_CMP_CFG set for
> CMP1 will result in SYNC0_OUT signal based on the SYNC_OUT register values.
> 
> After bringing the interface up, calling PPS enable doesn't work as
> the driver believes PPS is already enabled, (iep->pps_enabled is not
> cleared during interface bring down) and driver  will just return true
> even though there is no signal. Fix this by setting the iep->pps_enable
> and iep->perout_enable flags to false during the link down.
> 
> Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
>  drivers/net/ethernet/ti/icssg/icss_iep.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
> index 5d6d1cf78e93..03abc25ced12 100644
> --- a/drivers/net/ethernet/ti/icssg/icss_iep.c
> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
> @@ -195,6 +195,12 @@ static void icss_iep_enable_shadow_mode(struct icss_iep *iep)
>  
>  	icss_iep_disable(iep);
>  
> +	/* clear compare config */
> +	for (cmp = IEP_MIN_CMP; cmp < IEP_MAX_CMP; cmp++) {
> +		regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
> +				   IEP_CMP_CFG_CMP_EN(cmp), 0);
> +	}
> +

A bit later we are clearing compare status. Can clearing CMP be done in same for loop?

>  	/* disable shadow mode */
>  	regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
>  			   IEP_CMP_CFG_SHADOW_EN, 0);
> @@ -778,6 +784,10 @@ int icss_iep_exit(struct icss_iep *iep)
>  		ptp_clock_unregister(iep->ptp_clock);
>  		iep->ptp_clock = NULL;
>  	}
> +
> +	iep->pps_enabled = false;
> +	iep->perout_enabled = false;
> +

But how do you keep things in sync with user space?
User might have enabled PPS or PEROUT and then put SLICE0 interface down.
Then if SLICE0 is brought up should PPS/PEROUT keep working like before?
We did call ptp_clock_unregister() so it should unregister the PPS as well.
What I'm not sure is if it calls the ptp->enable() hook to disable the PPS/PEROUT.

If yes then that should take care of the flags as well.

If not then you need to call the relevant hooks explicitly but just after
ptp_clock_unregister().
e.g.
	if (iep->pps_enabled)
		icss_iep_pps_enable(iep, false);
	else if (iep->perout_enabled)
		icss_iep_perout_enable(iep, NULL, false);

But this means that user has to again setup PPS/PEROUT.	

>  	icss_iep_disable(iep);
>  
>  	return 0;

-- 
cheers,
-roger

