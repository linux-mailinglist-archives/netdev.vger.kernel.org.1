Return-Path: <netdev+bounces-155715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F53DA03787
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4E1B1882BB5
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 05:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04076198E78;
	Tue,  7 Jan 2025 05:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bELOLaFX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9097017C9E8
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 05:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736229291; cv=none; b=VM4p0ujAP1vvLsbDy3chhmH8CtFpPCWqrBDGYW0TvfiPqO2r/phd42ans1dv8k8kxQ72FI383bWZfXTthKVTSbLSLqyl+Dly2ZfMRMdSqJfDZpsZu5TfezYKWnNzzpiyvFw2l8P253qMpnR3+ga9yARivCAA5zCiVudnUES1a+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736229291; c=relaxed/simple;
	bh=t6G+vm1T13dstwv+YuzVT8NVvlx0nJXLEVAuQb6y9so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AD7zvI2RHDEahJ9EX5vG2YsDzhOLLwJx2ykd7/4xe6REM+w4vuMoTXDZ58DomlTBVx/ti89pA33xoMWhbnfEsLsUOooIvPKiNl9O6ztW7IeETm6hnW7ji05TGwYUTBHPVBMQ4L4Rv7ZXeRxNDaGkxakKiCRF0x7Y33YgX6fs3HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bELOLaFX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736229289; x=1767765289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t6G+vm1T13dstwv+YuzVT8NVvlx0nJXLEVAuQb6y9so=;
  b=bELOLaFXC4T9zHmqTOCmw22ODJSPCe3C6WM4l+R7H2e+9o8OWsvwUbA3
   J29GpeLm1GX0AX0V0k+/aMqMMs5QBD861PHQxRNyLJJ8SrKmhuxuOYhyC
   pHOTR0840g8IqXkYnTUyb3QgyU4PJhwX9T0S08AQCODQMn6sinapxRvKi
   rEUKOibXlMQ5Z/+/TboEaHLfpDoGbdCdDG80nC+sKw5Ti+SN6CHMNZYwi
   30SYdBZxfbagBtc2Msm5mWJhcl+GlTAkJ0yZISyexegWRyGcUEvhKPOIf
   3coaOS3BKSSrD/fPZDoQUpYYuIQRh1W7NNrdoTLTnmpf6Y0sLsDBH4Fkd
   A==;
X-CSE-ConnectionGUID: vvWqd4hhRTiUJAacgCA/qw==
X-CSE-MsgGUID: UJ8JUKRNR6m91tOhi6H8rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="46974147"
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="46974147"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 21:54:48 -0800
X-CSE-ConnectionGUID: xNWAO7JXSrKTSItVeMzhnw==
X-CSE-MsgGUID: uNds+hH7SgStMHtseGbzqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103163994"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 21:54:45 -0800
Date: Tue, 7 Jan 2025 06:51:28 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: John Daley <johndale@cisco.com>
Cc: benve@cisco.com, satishkh@cisco.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	Nelson Escobar <neescoba@cisco.com>
Subject: Re: [PATCH net-next 1/2] enic: Move RX coalescing set function
Message-ID: <Z3zA4LJD0Eak0kZt@mev-dev.igk.intel.com>
References: <20250107025135.15167-1-johndale@cisco.com>
 <20250107025135.15167-2-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107025135.15167-2-johndale@cisco.com>

On Mon, Jan 06, 2025 at 06:51:34PM -0800, John Daley wrote:
> Move the function used for setting the RX coalescing range to before
> the function that checks the link status. It needs to be called from
> there instead of from the probe function.
> 
> There is no functional change.
> 
> Co-developed-by: Nelson Escobar <neescoba@cisco.com>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>
> Co-developed-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> ---
>  drivers/net/ethernet/cisco/enic/enic_main.c | 60 ++++++++++-----------
>  1 file changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 9913952ccb42..957efe73e41a 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c
> @@ -428,6 +428,36 @@ static void enic_mtu_check(struct enic *enic)
>  	}
>  }
>  
> +static void enic_set_rx_coal_setting(struct enic *enic)
> +{
> +	unsigned int speed;
> +	int index = -1;
> +	struct enic_rx_coal *rx_coal = &enic->rx_coalesce_setting;
> +
> +	/* 1. Read the link speed from fw
> +	 * 2. Pick the default range for the speed
> +	 * 3. Update it in enic->rx_coalesce_setting
> +	 */
> +	speed = vnic_dev_port_speed(enic->vdev);
> +	if (speed > ENIC_LINK_SPEED_10G)
> +		index = ENIC_LINK_40G_INDEX;
> +	else if (speed > ENIC_LINK_SPEED_4G)
> +		index = ENIC_LINK_10G_INDEX;
> +	else
> +		index = ENIC_LINK_4G_INDEX;
> +
> +	rx_coal->small_pkt_range_start = mod_range[index].small_pkt_range_start;
> +	rx_coal->large_pkt_range_start = mod_range[index].large_pkt_range_start;
> +	rx_coal->range_end = ENIC_RX_COALESCE_RANGE_END;
> +
> +	/* Start with the value provided by UCSM */
> +	for (index = 0; index < enic->rq_count; index++)
> +		enic->cq[index].cur_rx_coal_timeval =
> +				enic->config.intr_timer_usec;
> +
> +	rx_coal->use_adaptive_rx_coalesce = 1;
> +}
> +
>  static void enic_link_check(struct enic *enic)
>  {
>  	int link_status = vnic_dev_link_status(enic->vdev);
> @@ -1901,36 +1931,6 @@ static void enic_synchronize_irqs(struct enic *enic)
>  	}
>  }
>  
> -static void enic_set_rx_coal_setting(struct enic *enic)
> -{
> -	unsigned int speed;
> -	int index = -1;
> -	struct enic_rx_coal *rx_coal = &enic->rx_coalesce_setting;
> -
> -	/* 1. Read the link speed from fw
> -	 * 2. Pick the default range for the speed
> -	 * 3. Update it in enic->rx_coalesce_setting
> -	 */
> -	speed = vnic_dev_port_speed(enic->vdev);
> -	if (ENIC_LINK_SPEED_10G < speed)
> -		index = ENIC_LINK_40G_INDEX;
> -	else if (ENIC_LINK_SPEED_4G < speed)
> -		index = ENIC_LINK_10G_INDEX;
> -	else
> -		index = ENIC_LINK_4G_INDEX;
> -
> -	rx_coal->small_pkt_range_start = mod_range[index].small_pkt_range_start;
> -	rx_coal->large_pkt_range_start = mod_range[index].large_pkt_range_start;
> -	rx_coal->range_end = ENIC_RX_COALESCE_RANGE_END;
> -
> -	/* Start with the value provided by UCSM */
> -	for (index = 0; index < enic->rq_count; index++)
> -		enic->cq[index].cur_rx_coal_timeval =
> -				enic->config.intr_timer_usec;
> -
> -	rx_coal->use_adaptive_rx_coalesce = 1;
> -}
> -
>  static int enic_dev_notify_set(struct enic *enic)
>  {
>  	int err;
> -- 
> 2.35.2

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

