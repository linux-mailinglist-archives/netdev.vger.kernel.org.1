Return-Path: <netdev+bounces-203834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD57AF7690
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 16:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFBD4E7AAC
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 14:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1582E7BD6;
	Thu,  3 Jul 2025 14:01:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C622DE6E2
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551263; cv=none; b=WcjaOsjEBiZFGULYDJtFNfpg3Y2VeFOViKwkcyEvF45rR6/tvZCclOQsee+tCidFPFO4KaV7EGBg5QsPOmwYu6rQfpgZSLiVvv4avQ1xRoKV2zvzj+UbdOcv+2daxyg4Aqw7DywqWoBaPGUQEPvCJAHTYY7z7R4pMxfzHM/jrmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551263; c=relaxed/simple;
	bh=ANJTRIqlr6OWG/iKdPB4n+XAWhmqAVcl4wQBz814+Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYfcjw3whPnRrzZgcOMlsqRM4i9Q7z/b4ffgfNnNnrJjE3bs0/qnetwzYoRjeMzUZN+ZG3t0mtLAm9O+EQA7StqQ4MxQ9ONYR2/3jz3UASe35OG1F0JXgfVJ22bKStYImuVmcp/xSf2itAf1IbszKjB5HNKSJTM9HKPIFviKpbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id F230E601F9C7D;
	Thu, 03 Jul 2025 16:00:34 +0200 (CEST)
Message-ID: <4290ec59-645d-4675-9c98-f59246796f3c@molgen.mpg.de>
Date: Thu, 3 Jul 2025 16:00:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [iwl-next] ixgbe: add the 2.5G and 5G speed in
 auto-negotiation for E610
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, andrew@lunn.ch,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20250703140918.287365-1-piotr.kwapulinski@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250703140918.287365-1-piotr.kwapulinski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Piotr,


Thank you for your patch.

Am 03.07.25 um 16:09 schrieb Piotr Kwapulinski:
> Enable the 2.5G and 5G speed in auto-negotiation for E610 at driver load.

The removed comment says there were incompatibilities with “certain 
switches“. What changed? Please elaborate in the commit message.


Kind regards,

Paul


> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 35 +++++++------------
>   1 file changed, 12 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index d741164..b202639 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -1953,6 +1953,16 @@ int ixgbe_identify_phy_e610(struct ixgbe_hw *hw)
>   	    phy_type_low  & IXGBE_PHY_TYPE_LOW_1G_SGMII    ||
>   	    phy_type_high & IXGBE_PHY_TYPE_HIGH_1G_USXGMII)
>   		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_1GB_FULL;
> +	if (phy_type_low  & IXGBE_PHY_TYPE_LOW_2500BASE_T   ||
> +	    phy_type_low  & IXGBE_PHY_TYPE_LOW_2500BASE_X   ||
> +	    phy_type_low  & IXGBE_PHY_TYPE_LOW_2500BASE_KX  ||
> +	    phy_type_high & IXGBE_PHY_TYPE_HIGH_2500M_SGMII ||
> +	    phy_type_high & IXGBE_PHY_TYPE_HIGH_2500M_USXGMII)
> +		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_2_5GB_FULL;
> +	if (phy_type_low  & IXGBE_PHY_TYPE_LOW_5GBASE_T  ||
> +	    phy_type_low  & IXGBE_PHY_TYPE_LOW_5GBASE_KR ||
> +	    phy_type_high & IXGBE_PHY_TYPE_HIGH_5G_USXGMII)
> +		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_5GB_FULL;
>   	if (phy_type_low  & IXGBE_PHY_TYPE_LOW_10GBASE_T       ||
>   	    phy_type_low  & IXGBE_PHY_TYPE_LOW_10G_SFI_DA      ||
>   	    phy_type_low  & IXGBE_PHY_TYPE_LOW_10GBASE_SR      ||
> @@ -1963,31 +1973,10 @@ int ixgbe_identify_phy_e610(struct ixgbe_hw *hw)
>   	    phy_type_high & IXGBE_PHY_TYPE_HIGH_10G_USXGMII)
>   		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_10GB_FULL;
>   
> -	/* 2.5 and 5 Gbps link speeds must be excluded from the
> -	 * auto-negotiation set used during driver initialization due to
> -	 * compatibility issues with certain switches. Those issues do not
> -	 * exist in case of E610 2.5G SKU device (0x57b1).
> -	 */
> -	if (!hw->phy.autoneg_advertised &&
> -	    hw->device_id != IXGBE_DEV_ID_E610_2_5G_T)
> +	/* Initialize autoneg speeds */
> +	if (!hw->phy.autoneg_advertised)
>   		hw->phy.autoneg_advertised = hw->phy.speeds_supported;
>   
> -	if (phy_type_low  & IXGBE_PHY_TYPE_LOW_2500BASE_T   ||
> -	    phy_type_low  & IXGBE_PHY_TYPE_LOW_2500BASE_X   ||
> -	    phy_type_low  & IXGBE_PHY_TYPE_LOW_2500BASE_KX  ||
> -	    phy_type_high & IXGBE_PHY_TYPE_HIGH_2500M_SGMII ||
> -	    phy_type_high & IXGBE_PHY_TYPE_HIGH_2500M_USXGMII)
> -		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_2_5GB_FULL;
> -
> -	if (!hw->phy.autoneg_advertised &&
> -	    hw->device_id == IXGBE_DEV_ID_E610_2_5G_T)
> -		hw->phy.autoneg_advertised = hw->phy.speeds_supported;
> -
> -	if (phy_type_low  & IXGBE_PHY_TYPE_LOW_5GBASE_T  ||
> -	    phy_type_low  & IXGBE_PHY_TYPE_LOW_5GBASE_KR ||
> -	    phy_type_high & IXGBE_PHY_TYPE_HIGH_5G_USXGMII)
> -		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_5GB_FULL;
> -
>   	/* Set PHY ID */
>   	memcpy(&hw->phy.id, pcaps.phy_id_oui, sizeof(u32));
>   


