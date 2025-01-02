Return-Path: <netdev+bounces-154677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745179FF67E
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 07:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E88E3A25CD
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 06:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BAE18FC70;
	Thu,  2 Jan 2025 06:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J17R9Ihj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDEF2AF1D
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 06:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735800279; cv=none; b=VDWbqOqQtUz2G3ui0OCn2DFgAdTfRWk5LShwZyJGve2V5rp6IjemSlIw7Rdu/mXqiGCl207KZDfq6Ls6v6lcNiIYq05RHjhu2TqjS/QfQzv4/XzT0e6ZSDSpx61lb0piJJmFuw8ZVa1oX72CoRUtSFcuU58RKzI3G5hK4tE3m1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735800279; c=relaxed/simple;
	bh=geOnRNQ3Qtavp0m1Yc8+qBkg2cu607vROJKrQgPFj54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRuPev3R3pmm8mMRnnR8fouV+V/S5eX5D89vAGM9aTHefkIJjNGWOQ+OQKoegiOGOt/Jp/j1NdRdGjIJCNkvv+M2RAP+xVVItJJSLLgqff1+svhfk9ky4IgRnLIjvbjyVOejua3Z3UMcoAzsPVbRmMMopo9jjklB6zk1mZ+gh3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J17R9Ihj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735800277; x=1767336277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=geOnRNQ3Qtavp0m1Yc8+qBkg2cu607vROJKrQgPFj54=;
  b=J17R9IhjI29haitHLaA6B5MzpGxuhqM6v14zAfBFLWZJINIHtI3eJ2OP
   Ksx/7DgLe7lG47JBpfVO/i8dKhoYG4VaJznD2aDHOloEBuLOnmU6PktaV
   vN31VOLB0vVkLSnwy6MCwhD9p9lAMXWKPIcHM1vFzCGKvZQslEgCtLOVp
   SjqxHnm2PTBhHX0kVlJbk60GnBG58V0jy7xI5Wlb2bZ1RKeBN9bOmzsXp
   Lon8jlQdmdbsqcdTbMjMciul4+dBTXsiPbQ97kwwkaZVz+US5XeP6sLTB
   q78QaI5nJ3uz0SxPhiKMT9JVLqEenMIRg1egxGv2h5hO0QkVuPvbqtw+l
   A==;
X-CSE-ConnectionGUID: Pw1QC6QQTUmSuFr0ivaJ5g==
X-CSE-MsgGUID: K+HKNwF7SZCLU0kEO5jYog==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36185544"
X-IronPort-AV: E=Sophos;i="6.12,284,1728975600"; 
   d="scan'208";a="36185544"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 22:44:36 -0800
X-CSE-ConnectionGUID: r8b08wThQVqDfAzLwiPYCg==
X-CSE-MsgGUID: fnwxhpjpRmq/Y4AqIahmyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106432577"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 22:44:35 -0800
Date: Thu, 2 Jan 2025 07:41:19 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ice: remove invalid
 parameter of equalizer
Message-ID: <Z3Y1D1LRPUR6gT0Z@mev-dev.igk.intel.com>
References: <20241231095044.433940-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231095044.433940-1-mateusz.polchlopek@intel.com>

On Tue, Dec 31, 2024 at 10:50:44AM +0100, Mateusz Polchlopek wrote:
> It occurred that in the commit 70838938e89c ("ice: Implement driver
> functionality to dump serdes equalizer values") the invalid DRATE parameter
> for reading has been added. The output of the command:
> 
>   $ ethtool -d <ethX>
> 
> returns the garbage value in the place where DRATE value should be
> stored.
> 
> Remove mentioned parameter to prevent return of corrupted data to
> userspace.
> 
> Fixes: 70838938e89c ("ice: Implement driver functionality to dump serdes equalizer values")
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 1 -
>  drivers/net/ethernet/intel/ice/ice_ethtool.c    | 1 -
>  drivers/net/ethernet/intel/ice/ice_ethtool.h    | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> index 3bf05b135b35..73756dbfc77f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> @@ -1498,7 +1498,6 @@ struct ice_aqc_dnl_equa_param {
>  #define ICE_AQC_RX_EQU_POST1 (0x12 << ICE_AQC_RX_EQU_SHIFT)
>  #define ICE_AQC_RX_EQU_BFLF (0x13 << ICE_AQC_RX_EQU_SHIFT)
>  #define ICE_AQC_RX_EQU_BFHF (0x14 << ICE_AQC_RX_EQU_SHIFT)
> -#define ICE_AQC_RX_EQU_DRATE (0x15 << ICE_AQC_RX_EQU_SHIFT)
>  #define ICE_AQC_RX_EQU_CTLE_GAINHF (0x20 << ICE_AQC_RX_EQU_SHIFT)
>  #define ICE_AQC_RX_EQU_CTLE_GAINLF (0x21 << ICE_AQC_RX_EQU_SHIFT)
>  #define ICE_AQC_RX_EQU_CTLE_GAINDC (0x22 << ICE_AQC_RX_EQU_SHIFT)
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 3072634bf049..f241493a6ac8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -710,7 +710,6 @@ static int ice_get_tx_rx_equa(struct ice_hw *hw, u8 serdes_num,
>  		{ ICE_AQC_RX_EQU_POST1, rx, &ptr->rx_equ_post1 },
>  		{ ICE_AQC_RX_EQU_BFLF, rx, &ptr->rx_equ_bflf },
>  		{ ICE_AQC_RX_EQU_BFHF, rx, &ptr->rx_equ_bfhf },
> -		{ ICE_AQC_RX_EQU_DRATE, rx, &ptr->rx_equ_drate },
>  		{ ICE_AQC_RX_EQU_CTLE_GAINHF, rx, &ptr->rx_equ_ctle_gainhf },
>  		{ ICE_AQC_RX_EQU_CTLE_GAINLF, rx, &ptr->rx_equ_ctle_gainlf },
>  		{ ICE_AQC_RX_EQU_CTLE_GAINDC, rx, &ptr->rx_equ_ctle_gaindc },
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.h b/drivers/net/ethernet/intel/ice/ice_ethtool.h
> index 8f2ad1c172c0..23b2cfbc9684 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.h
> @@ -15,7 +15,6 @@ struct ice_serdes_equalization_to_ethtool {
>  	int rx_equ_post1;
>  	int rx_equ_bflf;
>  	int rx_equ_bfhf;
> -	int rx_equ_drate;
>  	int rx_equ_ctle_gainhf;
>  	int rx_equ_ctle_gainlf;
>  	int rx_equ_ctle_gaindc;
> -- 
> 2.38.1

Thanks for fixing
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

