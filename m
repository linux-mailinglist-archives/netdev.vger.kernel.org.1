Return-Path: <netdev+bounces-178726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B126A7878A
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 07:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2513516E761
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 05:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E534A207E05;
	Wed,  2 Apr 2025 05:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vw1LlETx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046052F4A
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 05:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743571036; cv=none; b=nnoNEt5gG8Yat3Kk0Az0RrdLAS6r07hSolKeuQUhlGQdl5Nu6B5lKVZIgBvmvDBeu+ca5YVL1B7ei/A80eImNby1waofOtye+vMmgusurtLB90L/4M/ZbdpO2BnqJbbjS3AikQoh79rNp1Ipa2R6UWkEBpL7jSkVxl2tcwm63L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743571036; c=relaxed/simple;
	bh=f/mTU65/JW9fjgOXPQIjFFmmS2JfKwOh/I4on60hsoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmvir75FJdRe71KKy9DpA69WD9WyTUz7AKOa5c/YFg9AK2VNZhsi7M0Dd2If0k6ZP53cNaI0CurOrimrwvA7MpGiJU9VZudh55ECgG8Hkx4KdSo7qMl2hdK2PenMWx411Q4EGaCcxwuDgwkhdLgQitRjWgATlvoQoykF4TXw/94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vw1LlETx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743571035; x=1775107035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f/mTU65/JW9fjgOXPQIjFFmmS2JfKwOh/I4on60hsoU=;
  b=Vw1LlETxdJKQ3oOb0zhdL+s2gor9ELHiyNHh7Me3HUcDp2vWCR0/72aC
   yXldogokkYWgrDIHpJ/wY53eIXf/hZg2o+GoF2GEQVo2lP+GuL37NgNNO
   6ScgyGEqc063I9Twg3HtBJUt0XpRLTlSfMQ61h80L/lOSIyQY/f4bxvM+
   Zf2noYxfOBf/gYHixKMsT78XxtQt/dp//A4uGhGAMQ7p7SqHmrlwxYJOt
   ufIiHRhXFxdvxgs/5hjzIgyuM1BQY5NZYtXhVq7USHVhXCUG8zWL9LnX8
   JOO9ue4ANbQastp0guwOdRHc0iy5MoH90ggs5bGu+ASxw4BKYmfamP/JE
   w==;
X-CSE-ConnectionGUID: yIbMmB9BQyODfUhOSl0bVw==
X-CSE-MsgGUID: kF8XP3yGRtKEaZoxAQjQHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="67386112"
X-IronPort-AV: E=Sophos;i="6.14,295,1736841600"; 
   d="scan'208";a="67386112"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 22:17:14 -0700
X-CSE-ConnectionGUID: Cmg4GD9TSx21Zqm5UlB1ig==
X-CSE-MsgGUID: t3wdfDJASGqBUEjh59bLLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,295,1736841600"; 
   d="scan'208";a="131449190"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 22:17:12 -0700
Date: Wed, 2 Apr 2025 07:17:00 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	andrew+netdev@lunn.ch, Edward Cree <ecree.xilinx@gmail.com>,
	netdev@vger.kernel.org, Kyungwook Boo <bookyungwook@gmail.com>
Subject: Re: [PATCH net] sfc: fix NULL dereferences in
 ef100_process_design_param()
Message-ID: <Z+zITLJ4wB2Mhk8h@mev-dev.igk.intel.com>
References: <20250401225439.2401047-1-edward.cree@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401225439.2401047-1-edward.cree@amd.com>

On Tue, Apr 01, 2025 at 11:54:39PM +0100, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Since cited commit, ef100_probe_main() and hence also
>  ef100_check_design_params() run before efx->net_dev is created;
>  consequently, we cannot netif_set_tso_max_size() or _segs() at this
>  point.
> Move those netif calls to ef100_probe_netdev(), and also replace
>  netif_err within the design params code with pci_err.
> 
> Reported-by: Kyungwook Boo <bookyungwook@gmail.com>
> Fixes: 98ff4c7c8ac7 ("sfc: Separate netdev probe/remove from PCI probe/remove")
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  drivers/net/ethernet/sfc/ef100_netdev.c |  6 ++--
>  drivers/net/ethernet/sfc/ef100_nic.c    | 47 +++++++++++--------------
>  2 files changed, 24 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/ef100_netdev.c b/drivers/net/ethernet/sfc/ef100_netdev.c
> index d941f073f1eb..3a06e3b1bd6b 100644
> --- a/drivers/net/ethernet/sfc/ef100_netdev.c
> +++ b/drivers/net/ethernet/sfc/ef100_netdev.c
> @@ -450,8 +450,9 @@ int ef100_probe_netdev(struct efx_probe_data *probe_data)
>  	net_dev->hw_enc_features |= efx->type->offload_features;
>  	net_dev->vlan_features |= NETIF_F_HW_CSUM | NETIF_F_SG |
>  				  NETIF_F_HIGHDMA | NETIF_F_ALL_TSO;
> -	netif_set_tso_max_segs(net_dev,
> -			       ESE_EF100_DP_GZ_TSO_MAX_HDR_NUM_SEGS_DEFAULT);
> +	nic_data = efx->nic_data;
> +	netif_set_tso_max_size(efx->net_dev, nic_data->tso_max_payload_len);
> +	netif_set_tso_max_segs(efx->net_dev, nic_data->tso_max_payload_num_segs);

Is it fine to drop default value for max segs? Previously if somehow
this value wasn't read from HW it was set to default, now it will be 0.

At the beggining of ef100_probe_main() default values for nic_data are
set. Maybe it is worth to set also this default for max segs?

>  
>  	rc = efx_ef100_init_datapath_caps(efx);
>  	if (rc < 0)
> @@ -477,7 +478,6 @@ int ef100_probe_netdev(struct efx_probe_data *probe_data)
>  	/* Don't fail init if RSS setup doesn't work. */
>  	efx_mcdi_push_default_indir_table(efx, efx->n_rx_channels);
>  
> -	nic_data = efx->nic_data;
>  	rc = ef100_get_mac_address(efx, net_dev->perm_addr, CLIENT_HANDLE_SELF,
>  				   efx->type->is_vf);
>  	if (rc)

[...]

