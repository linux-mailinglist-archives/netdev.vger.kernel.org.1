Return-Path: <netdev+bounces-179233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9197A7B705
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 07:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B4C189873C
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 05:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4726D145B25;
	Fri,  4 Apr 2025 05:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8t4H8Pe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4513F2E62B2;
	Fri,  4 Apr 2025 05:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743743250; cv=none; b=P52ZSSvo5eemq4CbRPf/o0Rh20UbSPUOcrXUsUqsGMNhqpXxxV9P0YMZqrUzNL2S3ClmUFBE1nXZrV1uHIsrJ+OxuFvbIf7V+Ve40sVVF/uCvhL3zQx//N+sK+cfmICfnRF1SjQlDi8XoR3rZQ7k01w0WlxkkLCQzGyUhm3nDxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743743250; c=relaxed/simple;
	bh=28QBX3i1zLNBff2ID9RVsF3iS9Ffh33atW62jlWw69k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBhhNP3MjYAID2/+ksPjXYEKTnYNpNOTBNFGH81qS8ZJwi2PYKx1uqeaAfoSr+NVjiCO+tW5kAqQFGn7MsgvgqW8/IbUL2RmugDadP+WwJIiuzq6HADUEQEwP/z9gHFBm2A8Ouyj3OLMmKNUwDyPDRDeVpnpMZQ1hDSYjpFo/XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8t4H8Pe; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743743248; x=1775279248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=28QBX3i1zLNBff2ID9RVsF3iS9Ffh33atW62jlWw69k=;
  b=T8t4H8PeWT6ATZUlCCn/a+WDWxb5sXNcLVZM26NrtR/HJ29KLtR6/tsy
   Mh7Ed6eD3CJBcigUogiJkV119rqJ5UxyyRBAn7NYqX0XyrK+uc3KiYCKv
   OxDq5BWTXZ8hllpQs+QkbWx5uCbktqmpRpdiGGdHIuQJVg65xlnIpGsBy
   XTjRJSu/SFX7qh7Ukqmip+c55Vtirlo37I1qSfX2J3/8trqn3i90QWcib
   RWvkXSSMKTsxsMA/mQW2/j9PWUZI8d9LDgs0JCWC2XPT387aCmS7Zmn4x
   aPBNTgUdtC1z+/zqdfxlzqoK3DRzZlmEdLdy7CL9akuiGhiqqwJWgdM9i
   Q==;
X-CSE-ConnectionGUID: wSyF17IvQv+EER0kvS5zog==
X-CSE-MsgGUID: zrVGXuyBRFWI8NoZ+2ozEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="45350678"
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="45350678"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 22:07:27 -0700
X-CSE-ConnectionGUID: HyesBfsQRJ2cWVkBgxByeA==
X-CSE-MsgGUID: My1e6VapS+6ARNkVGgBb9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="158204028"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 22:07:25 -0700
Date: Fri, 4 Apr 2025 07:07:13 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] octeontx2-pf:  Add error handling for
 cn10k_map_unmap_rq_policer().
Message-ID: <Z+9pAZTV2AE53lrY@mev-dev.igk.intel.com>
References: <20250403151303.2280-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403151303.2280-1-vulab@iscas.ac.cn>

On Thu, Apr 03, 2025 at 11:13:03PM +0800, Wentao Liang wrote:
> The cn10k_free_matchall_ipolicer() calls the cn10k_map_unmap_rq_policer()
> for each queue in a for loop without checking for any errors. A proper
> implementation can be found in cn10k_set_matchall_ipolicer_rate().
> 
> Check the return value of the cn10k_map_unmap_rq_policer() function during
> each loop. Jump to unlock function and return the error code if the
> funciton fails to unmap policer.
> 
> Fixes: 2ca89a2c3752 ("octeontx2-pf: TC_MATCHALL ingress ratelimiting offload")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> index a15cc86635d6..ce58ad61198e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> @@ -353,11 +353,13 @@ int cn10k_free_matchall_ipolicer(struct otx2_nic *pfvf)
>  
>  	/* Remove RQ's policer mapping */
>  	for (qidx = 0; qidx < hw->rx_queues; qidx++)
> -		cn10k_map_unmap_rq_policer(pfvf, qidx,
> -					   hw->matchall_ipolicer, false);
> +		rc = cn10k_map_unmap_rq_policer(pfvf, qidx, hw->matchall_ipolicer, false);
> +		if (rc)
> +			goto out;

Didn't you forget about braces around for?

>  
>  	rc = cn10k_free_leaf_profile(pfvf, hw->matchall_ipolicer);
>  
> +out:
>  	mutex_unlock(&pfvf->mbox.lock);
>  	return rc;
>  }
> -- 
> 2.42.0.windows.2

