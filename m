Return-Path: <netdev+bounces-146696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4B79D50BF
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 17:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B2D28395E
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 16:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F3B14A4FB;
	Thu, 21 Nov 2024 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lru/rGMw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D53310A3E;
	Thu, 21 Nov 2024 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206705; cv=none; b=JGxHD5Zy1elOU/VU0rmEtlDbS/1UqnE3XqOCdUkboT/zXIl/rzUf9OGJ60aCacmNNiQmyX+2CBvBRSoSc5buEDzo7jdOiyohLBtMipj8idFBwHN2p/rb5O9wO9EjkVbj+j64gUCIxZ5LeyplHE5GcCZckBJUdkv0DepMn2Q5Rsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206705; c=relaxed/simple;
	bh=KAF9bEyre5NHjdh2UhRFrv5pzpjkr/MHSDumIfunvfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HR7ZB43spZbdy/eiM50ebOro964QAcjMQK87XZ9jB4EWbt4dX1ZNPetkmvZj1SerPCmfNQ1tUYGol+H96ubMRTdP4WUXzLi3+bZVYpqxGQdcXjqbCf2vtsEXX5bOP39AutB6qCCYVS1Sj682TS7CcAF/DiPXy6/0s7mLD2/uJ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lru/rGMw; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732206704; x=1763742704;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KAF9bEyre5NHjdh2UhRFrv5pzpjkr/MHSDumIfunvfg=;
  b=Lru/rGMw1d/mB+JjJi/2Rm80LIW7lHi/jU2SQu+/sxOt2j14y6sDSkeJ
   /IZH6hTVai3csQtyOG5WOtq+lLnZ+kct2t/TLlqTnYm1dPunsbleT0zFJ
   8EKL6vWR40I0ECXi65VyXMbetXfEFdB4bTpuq/ZyzJa35HpexZO1rGNTd
   8vxG3p6kMBU+xcXkwnCNOyI0AQYAmFo4dyUw+flkxDMhDR0ib9IYCAna8
   3sXAU0EkFcUymyuzdvZVdpzUYTB3Vv+Q76kxrpZlEFWi7pyADjdF8vuni
   E5sd5u26ibGeuMbkD3JPKPcGfvZiMkk0MSPxwR8HQsI6aXDh3e23XPxYC
   g==;
X-CSE-ConnectionGUID: a0CQwT3eQXitzRo8MTcQ3w==
X-CSE-MsgGUID: dmjmnVBuTcSASRBPf4teGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="42843606"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="42843606"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 08:31:43 -0800
X-CSE-ConnectionGUID: 7nUNTIgVT6KvW78+0svK+w==
X-CSE-MsgGUID: lPkF5iIOQf2t9TsgPwZB5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="90285224"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.109.245]) ([10.125.109.245])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 08:31:43 -0800
Message-ID: <57c05646-0d69-45d6-a20b-9447accc9c85@intel.com>
Date: Thu, 21 Nov 2024 09:31:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 26/27] cxl: add function for obtaining params from a
 region
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-27-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241118164434.7551-27-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/24 9:44 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A CXL region struct contains the physical address to work with.
> 
> Add a function for given a opaque cxl region struct returns the params
> to be used for mapping such memory range.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c | 16 ++++++++++++++++
>  drivers/cxl/cxl.h         |  2 ++
>  include/cxl/cxl.h         |  2 ++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index eff3ad788077..fa44a60549f7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2663,6 +2663,22 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	return ERR_PTR(rc);
>  }
>  
> +int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
> +			  resource_size_t *end)

Maybe just pass in a 'struct range' ptr and call it cxl_get_region_range()?

DJ

> +{
> +	if (!region)
> +		return -ENODEV;
> +
> +	if (!region->params.res)
> +		return -ENOSPC;
> +
> +	*start = region->params.res->start;
> +	*end = region->params.res->end;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_region_params, CXL);
> +
>  static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
>  {
>  	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ee3385db5663..7b46d313e581 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -913,6 +913,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  
> +int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
> +			  resource_size_t *end);
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 2a8ebabfc1dd..f14a3f292ad8 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -77,4 +77,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>  				     bool avoid_dax);
>  
>  int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
> +int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
> +			  resource_size_t *end);
>  #endif


