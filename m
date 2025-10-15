Return-Path: <netdev+bounces-229792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5792BBE0D45
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 23:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAEF54F5E1F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCED2FFDDC;
	Wed, 15 Oct 2025 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NoetWYNc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7BB3019B0;
	Wed, 15 Oct 2025 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760564218; cv=none; b=pC9IB8XCcpO5rI7DpwhbpHIEiFTo2mwlPP8YQDWVyEhVXIbgrnN6IGu0z5LKczXcxzTD2Q4i5BXR5Tfl2awDHqywZSm2UjYVf6qb/82LQloAimAhyKNiRE3jHdfsfQQhiXEfg1rLu2UKg7Z5A/tttpfvohTUO8lmeAYUBAwFlZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760564218; c=relaxed/simple;
	bh=H5mlyqvS1Ad3EJVAIrjdvOOAYYQPd+bI9/M38NZpxOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRJhOuMYBSDJjOeayYYMQhJDwqykOOlzkRlgMaEhDL9AWX2MOVk63GQVu0BWQMTfEEkwYGQ9uu5AMdh2utda3+4GJHoJgcEtqkNza4LXoqNrJ5f734q5An5mRAPbXYwUf5iXy8ZuHi5MIcW6JbCbiLNJWeD1ETXdJ4a/G3KIT+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NoetWYNc; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760564217; x=1792100217;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H5mlyqvS1Ad3EJVAIrjdvOOAYYQPd+bI9/M38NZpxOM=;
  b=NoetWYNcgziIgRzuxhTMDpyXIFG0RleF8li35tDpM3Gzd62LJIKBiovM
   OoXwnfaUJquBl/OrCGgAAdAda6EKeRK05PLJ9dOvhSKTGt8jULIqaHwUJ
   gsB6t2v9kyQjCfRA0IwHvRWhmcnw2xD0pH52SajtXyf/zMUM4iClXM+Jb
   fU0XxozskhbxPLchH8la81kULtw/tnWBO99/MvCC78dU4azp5TCKOWn6y
   BvY09paDVetzQAM1k3lWVG/uSN6zEs262tTQCop0bYGTPbkgHXhyW9Wds
   t1tj9JOwCdG9H05J+/xCseQh0d/PvYpcMNBCjBfavwKiaaz6roeehXjqN
   w==;
X-CSE-ConnectionGUID: 0WohYYUGRpaSD+6vXOnjVQ==
X-CSE-MsgGUID: 5ylbh28lRhGd5f+HI8Agfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="61781231"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="61781231"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 14:36:56 -0700
X-CSE-ConnectionGUID: j3i84VZSQnCc7aLIjlTWew==
X-CSE-MsgGUID: oop3XZavSFmcaADIgPQSFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="205984637"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.221]) ([10.125.111.221])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 14:36:55 -0700
Message-ID: <477bdadf-b249-4e45-a57f-fb323ca4c923@intel.com>
Date: Wed, 15 Oct 2025 14:36:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 18/22] cxl: Allow region creation by type2 drivers
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-19-alejandro.lucero-palau@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251006100130.2623388-19-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/6/25 3:01 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Creating a CXL region requires userspace intervention through the cxl
> sysfs files. Type2 support should allow accelerator drivers to create
> such cxl region from kernel code.
> 
> Adding that functionality and integrating it with current support for
> memory expanders.
> 
> Support an action by the type2 driver to be linked to the created region
> for unwinding the resources allocated properly.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/core.h   |   5 --
>  drivers/cxl/core/region.c | 134 +++++++++++++++++++++++++++++++++++---
>  drivers/cxl/port.c        |   5 +-
>  include/cxl/cxl.h         |  11 ++++
>  4 files changed, 141 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index c4dddbec5d6e..83abaca9f418 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -14,11 +14,6 @@ extern const struct device_type cxl_pmu_type;
>  
>  extern struct attribute_group cxl_base_attribute_group;
>  
> -enum cxl_detach_mode {
> -	DETACH_ONLY,
> -	DETACH_INVALIDATE,
> -};
> -
>  #ifdef CONFIG_CXL_REGION
>  extern struct device_attribute dev_attr_create_pmem_region;
>  extern struct device_attribute dev_attr_create_ram_region;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 26dfc15e57cd..e3b6d85cd43e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2375,6 +2375,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
>  	}
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_decoder_detach, "CXL");
>  
>  static int __attach_target(struct cxl_region *cxlr,
>  			   struct cxl_endpoint_decoder *cxled, int pos,
> @@ -2860,6 +2861,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>  	return to_cxl_region(region_dev);
>  }
>  
> +static void drop_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +
> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +}
> +
>  static ssize_t delete_region_store(struct device *dev,
>  				   struct device_attribute *attr,
>  				   const char *buf, size_t len)
> @@ -3588,14 +3597,12 @@ static int __construct_region(struct cxl_region *cxlr,
>  	return 0;
>  }
>  
> -/* Establish an empty region covering the given HPA range */
> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> -					   struct cxl_endpoint_decoder *cxled)
> +static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
> +						 struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	int rc, part = READ_ONCE(cxled->part);
> +	int part = READ_ONCE(cxled->part);
>  	struct cxl_region *cxlr;
>  
>  	do {
> @@ -3604,13 +3611,24 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  				       cxled->cxld.target_type);
>  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>  
> -	if (IS_ERR(cxlr)) {
> +	if (IS_ERR(cxlr))
>  		dev_err(cxlmd->dev.parent,
>  			"%s:%s: %s failed assign region: %ld\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			__func__, PTR_ERR(cxlr));
> -		return cxlr;
> -	}
> +
> +	return cxlr;
> +}
> +
> +/* Establish an empty region covering the given HPA range */
> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> +					   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +	struct cxl_region *cxlr;
> +	int rc;
> +
> +	cxlr = construct_region_begin(cxlrd, cxled);

Need to check the returned cxlr.

DJ

>  
>  	rc = __construct_region(cxlr, cxlrd, cxled);
>  	if (rc) {
> @@ -3621,6 +3639,106 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	return cxlr;
>  }
>  
> +DEFINE_FREE(cxl_region_drop, struct cxl_region *, if (_T) drop_region(_T))
> +
> +static struct cxl_region *
> +__construct_new_region(struct cxl_root_decoder *cxlrd,
> +		       struct cxl_endpoint_decoder **cxled, int ways)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> +	struct cxl_region_params *p;
> +	resource_size_t size = 0;
> +	int rc, i;
> +
> +	struct cxl_region *cxlr __free(cxl_region_drop) =
> +		construct_region_begin(cxlrd, cxled[0]);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +
> +	guard(rwsem_write)(&cxl_rwsem.region);
> +
> +	/*
> +	 * Sanity check. This should not happen with an accel driver handling
> +	 * the region creation.
> +	 */
> +	p = &cxlr->params;
> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
> +		dev_err(cxlmd->dev.parent,
> +			"%s:%s: %s  unexpected region state\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled[0]->cxld.dev),
> +			__func__);
> +		return ERR_PTR(-EBUSY);
> +	}
> +
> +	rc = set_interleave_ways(cxlr, ways);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
> +		for (i = 0; i < ways; i++) {
> +			if (!cxled[i]->dpa_res)
> +				break;
> +			size += resource_size(cxled[i]->dpa_res);
> +		}
> +		if (i < ways)
> +			return ERR_PTR(-EINVAL);
> +
> +		rc = alloc_hpa(cxlr, size);
> +		if (rc)
> +			return ERR_PTR(rc);
> +
> +		for (i = 0; i < ways; i++) {
> +			rc = cxl_region_attach(cxlr, cxled[i], 0);
> +			if (rc)
> +				return ERR_PTR(rc);
> +		}
> +	}
> +
> +	rc = cxl_region_decode_commit(cxlr);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	p->state = CXL_CONFIG_COMMIT;
> +
> +	return no_free_ptr(cxlr);
> +}
> +
> +/**
> + * cxl_create_region - Establish a region given an endpoint decoder
> + * @cxlrd: root decoder to allocate HPA
> + * @cxled: endpoint decoders with reserved DPA capacity
> + * @ways: interleave ways required
> + *
> + * Returns a fully formed region in the commit state and attached to the
> + * cxl_region driver.
> + */
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder **cxled,
> +				     int ways)
> +{
> +	struct cxl_region *cxlr;
> +
> +	mutex_lock(&cxlrd->range_lock);
> +	cxlr = __construct_new_region(cxlrd, cxled, ways);
> +	mutex_unlock(&cxlrd->range_lock);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +
> +	if (device_attach(&cxlr->dev) <= 0) {
> +		dev_err(&cxlr->dev, "failed to create region\n");
> +		drop_region(cxlr);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	return cxlr;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
> +
>  static struct cxl_region *
>  cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
>  {
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 83f5a09839ab..e6c0bd0fc9f9 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -35,6 +35,7 @@ static void schedule_detach(void *cxlmd)
>  static int discover_region(struct device *dev, void *unused)
>  {
>  	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_memdev *cxlmd;
>  	int rc;
>  
>  	if (!is_endpoint_decoder(dev))
> @@ -44,7 +45,9 @@ static int discover_region(struct device *dev, void *unused)
>  	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
>  		return 0;
>  
> -	if (cxled->state != CXL_DECODER_STATE_AUTO)
> +	cxlmd = cxled_to_memdev(cxled);
> +	if (cxled->state != CXL_DECODER_STATE_AUTO ||
> +	    cxlmd->cxlds->type == CXL_DEVTYPE_DEVMEM)
>  		return 0;
>  
>  	/*
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 1cbe53ad0416..c6fd8fbd36c4 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -275,4 +275,15 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>  					     enum cxl_partition_mode mode,
>  					     resource_size_t alloc);
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder **cxled,
> +				     int ways);
> +enum cxl_detach_mode {
> +	DETACH_ONLY,
> +	DETACH_INVALIDATE,
> +};
> +
> +int cxl_decoder_detach(struct cxl_region *cxlr,
> +		       struct cxl_endpoint_decoder *cxled, int pos,
> +		       enum cxl_detach_mode mode);
>  #endif /* __CXL_CXL_H__ */


