Return-Path: <netdev+bounces-250528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8931AD31B91
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 188A33029F9E
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 13:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B132475E3;
	Fri, 16 Jan 2026 13:18:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703397260A
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569493; cv=none; b=G2UabAhut4zMuASWsEnefVNvA2Sk0+JlLWZoaxYkxT3E6wVI1BJMXJ6+GP+E26cskC0CprGQttt8/pDKB1am/HUO/N/3LAE4hjXSQS3J40BdDAe63vZ/T++AciyCc4+vyAhPsGyZDWuHavIDwC5shHuXCDIHwYAEjGjA2DA+OLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569493; c=relaxed/simple;
	bh=tzTSdOBZ0DpTikGLNjMUnRIK/wvXnKqXQddphD+OdNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwAPExhTOrjhLH2PdM0VHRbamF/TUuI10gXYD2rmzD4Dsgj8jvdR0oEobFwmrF5IeJ0qxnGgQNAxl5LxG/Soz3dHMt5qkpidkdZLz8uDQUANcK2gD+1O3ZeL1hurEmx8UJ5OntmAHaLZH+ihi6guw4XY0TFqdc+GreqDf3mEpe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7FCDB4C442FC79;
	Fri, 16 Jan 2026 14:17:31 +0100 (CET)
Message-ID: <c2a61a49-e84a-447e-a45a-61a44a5393d0@molgen.mpg.de>
Date: Fri, 16 Jan 2026 14:17:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 1/2] ixgbe: e610: add missing
 endianness conversion
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 dan.carpenter@linaro.org, horms@kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260116122353.78235-1-piotr.kwapulinski@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260116122353.78235-1-piotr.kwapulinski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Piotr,


Thank you for your patch.

Am 16.01.26 um 13:23 schrieb Piotr Kwapulinski:
> Fix a possible ACI issue on big-endian platforms.

Please elaborate, why this is needed, and `raw_desc[i]` needs to be 
converted.

For the summary/title, you could also be more specific. Something like:

 > ixgbe: e610: Convert ACI descriptor buffer(?) to little endian

> Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command Interface")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index c2f8189..f494e90 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -113,7 +113,8 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>   
>   	/* Descriptor is written to specific registers */
>   	for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
> -		IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i), raw_desc[i]);
> +		IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i),
> +				le32_to_cpu(raw_desc[i]));
>   
>   	/* SW has to set PF_HICR.C bit and clear PF_HICR.SV and
>   	 * PF_HICR_EV
> @@ -145,7 +146,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>   	if ((hicr & IXGBE_PF_HICR_SV)) {
>   		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
>   			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
> -			raw_desc[i] = raw_desc[i];
> +			raw_desc[i] = cpu_to_le32(raw_desc[i]);
>   		}
>   	}
>   
> @@ -153,7 +154,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>   	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
>   		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
>   			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
> -			raw_desc[i] = raw_desc[i];
> +			raw_desc[i] = cpu_to_le32(raw_desc[i]);
>   		}
>   	}


Kind regards,

Paul

