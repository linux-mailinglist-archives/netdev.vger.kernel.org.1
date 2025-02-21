Return-Path: <netdev+bounces-168406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 873FBA3ED55
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 08:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA0B189CBDA
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 07:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D425A1FBCB4;
	Fri, 21 Feb 2025 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eweAMIAb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520C118C936
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 07:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740123017; cv=none; b=rBXLpLzudxmKjnCXze9Z0aUYYCpPd7V7iZ/FfDOESdxBGE2RMbangI8kQpqe6hTciZ0lIcssLqN4trvg/ocxdBKEKULFQrtC1j/lai0IG5LJ1mfugSWe334XTYJzL139cdzyslrZ2glf6IL36+QIj2tNELG3Hbq916Sf+LiPWcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740123017; c=relaxed/simple;
	bh=AhHfBgKRtGZMAum8xb/RZz7VZsGhWi8VZDiqiEf3x8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CERAOIMmMm5PZUubEBoiGluU/0SeYgxgEqA0rJAhJUo5nQmytk8Ym8nTbso+vrauu8HmSBq4TyLSfSFKgQvkpHIwD3zELl+xVRbRcDBlpJ2ouDmR/dz527pzkW7ux8s1lCgZdnVdTUsZl+0CCM1ZP0+ZM85ULEMzn1sEsUTeFTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eweAMIAb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740123016; x=1771659016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AhHfBgKRtGZMAum8xb/RZz7VZsGhWi8VZDiqiEf3x8s=;
  b=eweAMIAbl+aH4jRN4oeo+gjzkAHG468PrQzaREWs5pGmWT+JZVKqSPMi
   p/4uv2a1cgSG8CdSUOrkNM3rtp65WIvQdsCRArGpR+eYsQVU0g97rw7wd
   S27IG/cTfyDFrZYMteKMQs8KMc8Q5p5z8ja4QeuIb0d/5cmxpX5AgRmrg
   rP+J9NOiPWZCsnTGeXWsRa30zoeCm+Evr5xmuP+y3NHBSlMUkAKwX5eS9
   n6vMC7uY03NIV4Pw3LVsC45YHPCGm2nLEXIOTGHYDmnPBuKBmb93zULfR
   IZjEEe10cPI3Z5EifdnJ+5ftoqx+zX/j44bFHJ4w0FjgAGJkYq/Z5JVxd
   g==;
X-CSE-ConnectionGUID: PihqlG5/Q32gSpq/Vwuy6A==
X-CSE-MsgGUID: pinUreMvT1eG9itD0k+uzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40788831"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="40788831"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 23:30:15 -0800
X-CSE-ConnectionGUID: no4GszDkSUSH2NH7XELefg==
X-CSE-MsgGUID: IA/h4Um2SV25LL2h3Z01XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115138465"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 23:30:13 -0800
Date: Fri, 21 Feb 2025 08:26:36 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: Re: [PATCH iwl-net v2] ice: fix Get Tx Topology AQ command error on
 E830
Message-ID: <Z7gqrJkNSNrRg6IK@mev-dev.igk.intel.com>
References: <20250220-jk-e830-ddp-loading-fix-v2-1-7c9663a442c1@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220-jk-e830-ddp-loading-fix-v2-1-7c9663a442c1@intel.com>

On Thu, Feb 20, 2025 at 03:15:24PM -0800, Jacob Keller wrote:
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> The Get Tx Topology AQ command (opcode 0x0418) has different read flag
> requriements depending on the hardware/firmware. For E810, E822, and E823
> firmware the read flag must be set, and for newer hardware (E825 and E830)
> it must not be set.
> 
> This results in failure to configure Tx topology and the following warning
> message during probe:
> 
>   DDP package does not support Tx scheduling layers switching feature -
>   please update to the latest DDP package and try again
> 
> The current implementation only handles E825-C but not E830. It is
> confusing as we first check ice_is_e825c() and then set the flag in the set
> case. Finally, we check ice_is_e825c() again and set the flag for all other
> hardware in both the set and get case.
> 
> Instead, notice that we always need the read flag for set, but only need
> the read flag for get on E810, E822, and E823 firmware. Fix the logic to
> check the MAC type and set the read flag in get only on the older devices
> which require it.
> 
> Fixes: ba1124f58afd ("ice: Add E830 device IDs, MAC type and registers")
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> Changes in v2:
> - Update commit message to include the warning users see
> - Rework code to set the flag for E810 and E822 instead of to *not* set it
>   for E825-C and E830. We anticipate that future hardware and firmware
>   versions will behave like E830.
> - Link to v1: https://lore.kernel.org/r/20250218-jk-e830-ddp-loading-fix-v1-1-47dc8e8d4ab5@intel.com
> ---
>  drivers/net/ethernet/intel/ice/ice_ddp.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
> index 03988be03729b76e96188864896527060c8c4d5b..59323c019544fc1f75dcb8a5d31e0b0c82932fe1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ddp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
> @@ -2345,15 +2345,15 @@ ice_get_set_tx_topo(struct ice_hw *hw, u8 *buf, u16 buf_size,
>  			cmd->set_flags |= ICE_AQC_TX_TOPO_FLAGS_SRC_RAM |
>  					  ICE_AQC_TX_TOPO_FLAGS_LOAD_NEW;
>  
> -		if (ice_is_e825c(hw))
> -			desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
> +		desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
>  	} else {
>  		ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_tx_topo);
>  		cmd->get_flags = ICE_AQC_TX_TOPO_GET_RAM;
> -	}
>  
> -	if (!ice_is_e825c(hw))
> -		desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
> +		if (hw->mac_type == ICE_MAC_E810 ||
> +		    hw->mac_type == ICE_MAC_GENERIC)
> +			desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
> +	}
>  
>  	status = ice_aq_send_cmd(hw, &desc, buf, buf_size, cd);
>  	if (status)
> 

Thanks for fixing
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> ---
> base-commit: 992ee3ed6e9fdd0be83a7daa5ff738e3cf86047f
> change-id: 20250218-jk-e830-ddp-loading-fix-9efdbdfc270a
> 
> Best regards,
> -- 
> Jacob Keller <jacob.e.keller@intel.com>
> 

