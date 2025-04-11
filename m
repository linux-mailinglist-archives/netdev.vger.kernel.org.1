Return-Path: <netdev+bounces-181845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B77A86920
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 01:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 080477B2520
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76802BD58F;
	Fri, 11 Apr 2025 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UPgmnSHK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C894224888;
	Fri, 11 Apr 2025 23:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744413920; cv=none; b=jb34No0NBPh3zNG9LtRX7ePNW0vH/wk+2lIEXaoboHFUo/obcnN5TDs3TgdvRopUqPiOeWGUZU3TQ2qF2NJJ0mMSEWz4y8nL2s+EesoerngEBM+DfA9Me9Unx665ee5F9AaSc1CYTz67grbLZTrmgYCG8Oi3Ing3r98YBjyxzd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744413920; c=relaxed/simple;
	bh=CcTRNqRRCDiOvRLcT8mQ205IvIar2bvfPHumzYtbttQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xi5uuLR4TFCqMSSoRkYLz4IWokXcSUCAOYnNeW+o6gGKLIl80I4GhhwwZSwH31EI7yl8dEg/p9YTxJdaVKlRHfoEVmYf7qzAL4y0lW/dWzn/uHh+/qJuL8nPD1QPqCeCINqaOU6P9cUxa0UNmQ906wgspKXvj8yfp7XzAf1opuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UPgmnSHK; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744413919; x=1775949919;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CcTRNqRRCDiOvRLcT8mQ205IvIar2bvfPHumzYtbttQ=;
  b=UPgmnSHKjyTsKYFwQbuAs0K9AFCKJAppgyTnFE5ChoVVy8pP8wwuSFJM
   JWmSsOap9/2HMexQhf65DMvzjYjregf/u1GW8ErgHlaQodabE0LCCgUn2
   hknRW41S8IWZSQ3fk/3x5p8SA6LhqUpu4qWyTxReXhC9H2F3I2uMIvvxN
   mUJWg4A3OZ3c60ctijnO8PlWZfdNwDebEhfHJm+nTApznqrOBt7vR0ftI
   IyE0bbbSWnuin1i/33EZeT1x1I+t8hUUoFiwgBTWIyZQzIJZfm/RwOym6
   V63Re5LylnZOn1vJD3qaIqgttpD3cO6lkpoKLjKiUMt/fdGdZGOmBEBBU
   Q==;
X-CSE-ConnectionGUID: m5MlhD8PR1SRXxNcuW6uUA==
X-CSE-MsgGUID: m/MrTPZiR0ax6weB5doqUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="33589127"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="33589127"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 16:25:16 -0700
X-CSE-ConnectionGUID: Aqg5XoqoTqKfv+j2Qg+N7Q==
X-CSE-MsgGUID: B8/Iiw+jTyOP+6KeEIVnIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="129171813"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.170]) ([10.125.108.170])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 16:25:14 -0700
Message-ID: <9b7d9ea4-fd7e-4351-82ea-af56b246ff0a@intel.com>
Date: Fri, 11 Apr 2025 16:25:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 19/23] cxl: add region flag for precluding a device
 memory to be used for dax
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-20-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250331144555.1947819-20-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/31/25 7:45 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> By definition a type2 cxl device will use the host managed memory for
> specific functionality, therefore it should not be available to other
> uses. However, a dax interface could be just good enough in some cases.
> 
> Add a flag to a cxl region for specifically state to not create a dax
> device. Allow a Type2 driver to set that flag at region creation time.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 10 +++++++++-
>  drivers/cxl/cxl.h         |  3 +++
>  include/cxl/cxl.h         |  3 ++-
>  3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f2e1d5719a70..58b68baf2bf3 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3646,12 +3646,14 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
>   * @cxlrd: root decoder to allocate HPA
>   * @cxled: endpoint decoder with reserved DPA capacity
>   * @ways: interleave ways required
> + * @no_dax: if true no DAX device should be created
>   *
>   * Returns a fully formed region in the commit state and attached to the
>   * cxl_region driver.
>   */
>  struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> -				     struct cxl_endpoint_decoder *cxled, int ways)
> +				     struct cxl_endpoint_decoder *cxled, int ways,
> +				     bool no_dax)
>  {
>  	struct cxl_region *cxlr;
>  
> @@ -3668,6 +3670,9 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>  		return ERR_PTR(-ENODEV);
>  	}
>  
> +	if (no_dax)
> +		set_bit(CXL_REGION_F_NO_DAX, &cxlr->flags);
> +
>  	return cxlr;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
> @@ -3831,6 +3836,9 @@ static int cxl_region_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> +	if (test_bit(CXL_REGION_F_NO_DAX, &cxlr->flags))
> +		return 0;
> +
>  	switch (cxlr->mode) {
>  	case CXL_PARTMODE_PMEM:
>  		return devm_cxl_add_pmem_region(cxlr);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c35620c24c8f..2eb927c9229c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -405,6 +405,9 @@ struct cxl_region_params {
>   */
>  #define CXL_REGION_F_NEEDS_RESET 1
>  
> +/* Allow Type2 drivers to specify if a dax region should not be created. */
> +#define CXL_REGION_F_NO_DAX 2
> +
>  /**
>   * struct cxl_region - CXL region
>   * @dev: This region's device
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 133d6db3a70a..2bb495f78239 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -262,7 +262,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>  					     resource_size_t alloc);
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>  struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> -				     struct cxl_endpoint_decoder *cxled, int ways);
> +				     struct cxl_endpoint_decoder *cxled, int ways,
> +				     bool no_dax);
>  
>  int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
>  #endif


