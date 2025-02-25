Return-Path: <netdev+bounces-169504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F88A443D1
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 16:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA61A1888EC4
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 15:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5AD26738C;
	Tue, 25 Feb 2025 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+CUWmar"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8EF3A27B
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495883; cv=none; b=c+fFy7vaLpBoOCliD7zv4JhFMdrbaybF5MQk6gdLi4Tm/25X8WKgMTokILSG5nzLksewHMMeJAU7Tz2FP47D6ppIUlWiYsdsY1ufxcraZ20uMNTJdQvqpamenN9cyZTnxZdsiqKafaEL74JJqq142lsTdhXo6c1VLcjT0G1AA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495883; c=relaxed/simple;
	bh=RJR1EUVHjlTZ5+MP+tYw7diWPjES5MIeECT7TrlRV+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCM41zUZzYinpAbRQcEZtfOF0uZz++E0L1aFmutGscxpO0lAUaOth3yP2ckuB97Re5zEk9U3nAcjFFXXl2ZR3HqHJlkTESJXPjQutpzfu0kHjVyVwhqXcTr/gMpM9xul8TBooSsuP8p9u3ENETt/nzC5E5vCCwQ/UZ/y+P/H2Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+CUWmar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35935C4CEDD;
	Tue, 25 Feb 2025 15:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740495883;
	bh=RJR1EUVHjlTZ5+MP+tYw7diWPjES5MIeECT7TrlRV+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+CUWmarkOf3Jev++Vm3ho9RN/pvolh50nMWPja+nWtY1DG4j03xdGNRooyKKToWY
	 ADVv46eg8odXO2IQEa99gCS5V4jHneUwDbtt7gT54726ImjQDd/9zKJSCKD4oEhTiQ
	 FZU0hGZL1vwhEr1B6IxTy3raASp00HWPZc9K/Kt8iEzuF9p5iFbjbG0SyKageoa38o
	 K3ugMRv3GitPiJTuyXdDyB2JOSEbDnf7CcGeZGhKJ6AMkJMjvRf/2YjpcjkroO9tpM
	 5PF1OdeikJSA6YGPbZxWA2a3JESDIAUo9zIxZwVik20H6DNM7ni00iLz9deD2CIEEx
	 8qHiXTcG9BUzg==
Date: Tue, 25 Feb 2025 15:04:40 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v1 3/3] ice: enable timesync operation on 2xNAC
 E825 devices
Message-ID: <20250225150440.GZ1615191@kernel.org>
References: <20250221123123.2833395-1-grzegorz.nitka@intel.com>
 <20250221123123.2833395-4-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221123123.2833395-4-grzegorz.nitka@intel.com>

On Fri, Feb 21, 2025 at 01:31:23PM +0100, Grzegorz Nitka wrote:
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> According to the E825C specification, SBQ address for ports on a single
> complex is device 2 for PHY 0 and device 13 for PHY1.
> For accessing ports on a dual complex E825C (so called 2xNAC mode),
> the driver should use destination device 2 (referred as phy_0) for
> the current complex PHY and device 13 (referred as phy_0_peer) for
> peer complex PHY.
> 
> Differentiate SBQ destination device by checking if current PF port
> number is on the same PHY as target port number.
> 
> Adjust 'ice_get_lane_number' function to provide unique port number for
> ports from PHY1 in 'dual' mode config (by adding fixed offset for PHY1
> ports). Cache this value in ice_hw struct.
> 
> Introduce ice_get_primary_hw wrapper to get access to timesync register
> not available from second NAC.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h        | 60 ++++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_common.c |  6 ++-
>  drivers/net/ethernet/intel/ice/ice_ptp.c    | 49 ++++++++++++-----
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 39 +++++++++++---
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  5 --
>  drivers/net/ethernet/intel/ice/ice_type.h   |  1 +
>  6 files changed, 134 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 53b990e2e850..d80ab48402f1 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -193,8 +193,6 @@
>  
>  #define ice_pf_to_dev(pf) (&((pf)->pdev->dev))
>  
> -#define ice_pf_src_tmr_owned(pf) ((pf)->hw.func_caps.ts_func_info.src_tmr_owned)
> -
>  enum ice_feature {
>  	ICE_F_DSCP,
>  	ICE_F_PHY_RCLK,
> @@ -1049,4 +1047,62 @@ static inline void ice_clear_rdma_cap(struct ice_pf *pf)
>  }
>  
>  extern const struct xdp_metadata_ops ice_xdp_md_ops;
> +
> +/**
> + * ice_is_dual - Check if given config is multi-NAC
> + * @hw: pointer to HW structure
> + *
> + * Return: true if the device is running in mutli-NAC (Network
> + * Acceleration Complex) configuration variant, false otherwise
> + * (always false for non-E825 devices).
> + */
> +static inline bool ice_is_dual(struct ice_hw *hw)
> +{
> +	return hw->mac_type == ICE_MAC_GENERIC_3K_E825 &&
> +	       (hw->dev_caps.nac_topo.mode & ICE_NAC_TOPO_DUAL_M);
> +}

Thanks for the complete Kernel doc, and not adding unnecessary () around
the value returned. Overall these helpers seem nice and clean to me.

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index ed7ef8608cbb..4ff4c99d0872 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -1135,6 +1135,8 @@ int ice_init_hw(struct ice_hw *hw)
>  		}
>  	}
>  
> +	hw->lane_num = ice_get_phy_lane_number(hw);
> +

Unfortunately there seems to be a bit of a problem here:

The type of hw->lane number is u8.
But ice_get_phy_lane_number returns an int,
which may be a negative error value...

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c

...

> @@ -3177,17 +3203,16 @@ void ice_ptp_init(struct ice_pf *pf)
>  {
>  	struct ice_ptp *ptp = &pf->ptp;
>  	struct ice_hw *hw = &pf->hw;
> -	int lane_num, err;
> +	int err;
>  
>  	ptp->state = ICE_PTP_INITIALIZING;
>  
> -	lane_num = ice_get_phy_lane_number(hw);
> -	if (lane_num < 0) {
> -		err = lane_num;
> +	if (hw->lane_num < 0) {

... which is checked here.

But because hw->lane_num is unsigned, this condition is always false.

FWIIW, I think it is nice that that hw->lane is a u8.
But error handling seems broken here.

> +		err = hw->lane_num;
>  		goto err_exit;
>  	}
> +	ptp->port.port_num = hw->lane_num;
>  
> -	ptp->port.port_num = (u8)lane_num;
>  	ice_ptp_init_hw(hw);
>  
>  	ice_ptp_init_tx_interrupt_mode(pf);

...

