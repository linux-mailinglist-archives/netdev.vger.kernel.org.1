Return-Path: <netdev+bounces-181847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF88EA86935
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 01:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A5818956E2
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F024F2BEC48;
	Fri, 11 Apr 2025 23:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aq9ng3dT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC9C2BD5A1;
	Fri, 11 Apr 2025 23:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744414334; cv=none; b=WJMx7tGroKwX0Wt/IdMMOk2ds966YwgefDwh1IV7EyxSqoX++u9PtopLmfwmTmRziv8qN1hBhBgU9mf82DBeFE9Dw4JHe0z+CppGVnIg1Lsia/2L1i/BkoNM7XP2tPcsh2hPcC2Yph+TJdBQKL4zVrQILTXOW+gj9HtXB0aU7Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744414334; c=relaxed/simple;
	bh=7vPZytCQz66xXtN+vTacf9qplssMJSGNyCSW40FkdLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9OgYNHIRX/Sb14Q+PoKVwuG/bz55We78wnLN1iKP/4kI4hI6VRgdq7h3/QXbJXa4GWIrv3kberTNXYjl5KRKoJn1VTPt5mpTiEMIRLrUDzE4YtyP1Hxx9whxOQvGtSuvBm/lSVcXU9FLy8UhGQ+T2TB0gEqQ3DYLlzggElcF/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aq9ng3dT; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744414333; x=1775950333;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7vPZytCQz66xXtN+vTacf9qplssMJSGNyCSW40FkdLM=;
  b=aq9ng3dTuSKdoGft4X3861ubbr2GS/6e9ugd2rDN3b+LGpH3R7+jjxU6
   ZOPkidmnu+nTzwyfd3kJlAwCSppnibMq70p6www2iKR+1Y15kxbXGDGKt
   Gs4TGmsH2Di+SwrHz91r41chgmcfwU7SK8Rme9Zu9ZpEw2Fo57cHFBv3W
   bUTHLHvVLf3yGN3w/RuK+25Xr3KKn0tVkqTVB1kPPYQBkIe3mtRbyoESw
   wohGAaApv6q0zkZrAAAHjt3TVJIqKyL9+yGQMQNg4nuKXcVW10t1lat+6
   t9VhI8E5EVqtOzLgc1MpSc34ZnwCKzHn5RJ7PtD327H51bpvSK4ncz2Md
   w==;
X-CSE-ConnectionGUID: pw5EEYNrQHSGCAVkMNNdUQ==
X-CSE-MsgGUID: 8DPOs85BQDyNe2mPpdzX/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45214424"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="45214424"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 16:32:12 -0700
X-CSE-ConnectionGUID: DpCZrw0eTL+vLJC4yN1TkA==
X-CSE-MsgGUID: PX1CG7YxRy+4lsnnhpfzaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="134177265"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.170]) ([10.125.108.170])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 16:32:11 -0700
Message-ID: <54660950-979c-45d6-8beb-22117b3ba610@intel.com>
Date: Fri, 11 Apr 2025 16:32:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 21/23] cxl: add function for obtaining region range
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-22-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250331144555.1947819-22-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/31/25 7:45 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A CXL region struct contains the physical address to work with.
> 
> Add a function for getting the cxl region range to be used for mapping
> such memory range.
Consider replace the commit log with:
Add a helper function to retrieve the physical address range of a CXL region for mapping.


> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 15 +++++++++++++++
>  include/cxl/cxl.h         |  2 ++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 58b68baf2bf3..12aa5bd346ca 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2716,6 +2716,21 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	return ERR_PTR(rc);
>  }
>  
> +int cxl_get_region_range(struct cxl_region *region, struct range *range)
> +{
> +	if (WARN_ON_ONCE(!region))
> +		return -ENODEV;
> +
> +	if (!region->params.res)
> +		return -ENOSPC;
> +
> +	range->start = region->params.res->start;
> +	range->end = region->params.res->end;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_region_range, "CXL");
> +
>  static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
>  {
>  	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 2bb495f78239..23f467ed2f2e 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -266,4 +266,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>  				     bool no_dax);
>  
>  int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
> +struct range;
> +int cxl_get_region_range(struct cxl_region *region, struct range *range);
>  #endif


