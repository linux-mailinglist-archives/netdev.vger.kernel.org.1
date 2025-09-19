Return-Path: <netdev+bounces-224891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FA3B8B432
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 22:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D3C07BE843
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FB32D027F;
	Fri, 19 Sep 2025 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbDsrV9r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946C929BDAD;
	Fri, 19 Sep 2025 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758315569; cv=none; b=D/BAEAq3ulSGlk+7Rn4J0PP+2TaSa6BPmGMch+yQtkD9ExGPsSxVwaPDwefS7QXr4HpLY1QPXz4kTQMlrJA8WgADVROSHHM2SSMnHNhPdiVe5RKhckTpKHx9kkHluB/YdWW9WJL+VCSUjld8gt/Mhe3Akq7ikX0pwZZdYaOIeo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758315569; c=relaxed/simple;
	bh=9R5qXLBsa1OIgflRsA7GyQ58PE8RACKR3/XPPICy1TY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2UEX0kIT2hw2VCcFut/YWoCZfH3PEd20lfKaP95ZSvWS2JOhKyKBL0HiCeLDTCMutcGzzB8lD4SODGOXnZC+0iFwUt4Xw86paNKZMygG15I/PZce0+KyDGajhKfR5hOpCHcWAJ41Y0uU/O4VXmrGVaJdlLQjUZuNS1E7q+CDSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbDsrV9r; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758315568; x=1789851568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9R5qXLBsa1OIgflRsA7GyQ58PE8RACKR3/XPPICy1TY=;
  b=VbDsrV9r3WsHrK0bVJRJ+oZoWTu5rTyNv/gZVts2fH7VghqTQb7K2hWd
   H6VgSNsRMIYfvDl4x0QAi+qMGk1ro0GFh126HbcdaTsiuDrItv0wvptNg
   CAjXMCxZiIq73Zy1UXy0up5NMG1W/djEA3VsS8hYcphjmWK26a5tmo7gV
   F4K4/bRk5IxAx0dVoOBGBrFPQw+LK4YJGnSHJf2vNU+ck98HVzp2qizJo
   PlNTbF9KQxaN39805VHsGjlcaPYNsEP1Kf89rJaBNiuMPU/PgVlZUEQx7
   LJ6NHm6pDpxnjqqoJfyNebVqQQxFndaHTgtL1bLYo0mxOM6RkHWtBgFhV
   w==;
X-CSE-ConnectionGUID: 3/S/NiC6R2qipGSEHGlpjQ==
X-CSE-MsgGUID: TEQI19KpRfSidWouTwcDrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60586283"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60586283"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 13:59:27 -0700
X-CSE-ConnectionGUID: nb16oaEWQ52kk0Wdpn2J1w==
X-CSE-MsgGUID: 47JaJn4LTAC4a+wLdcKdMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,279,1751266800"; 
   d="scan'208";a="175547226"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.58]) ([10.125.108.58])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 13:59:25 -0700
Message-ID: <a3138cd0-455c-4247-be4e-c8f4f2c71e33@intel.com>
Date: Fri, 19 Sep 2025 13:59:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 16/20] cxl: Allow region creation by type2 drivers
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-17-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250918091746.2034285-17-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/25 2:17 AM, alejandro.lucero-palau@amd.com wrote:
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
> ---
>  drivers/cxl/core/region.c | 154 ++++++++++++++++++++++++++++++++++++--
>  drivers/cxl/port.c        |   5 +-
>  include/cxl/cxl.h         |   4 +
>  3 files changed, 154 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 7b05e41e8fad..20bd0c82806c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2379,6 +2379,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
>  	}
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_decoder_detach, "CXL");
>  
>  static int __attach_target(struct cxl_region *cxlr,
>  			   struct cxl_endpoint_decoder *cxled, int pos,
> @@ -2864,6 +2865,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
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
> @@ -3592,14 +3601,12 @@ static int __construct_region(struct cxl_region *cxlr,
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
> @@ -3608,13 +3615,24 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
>  
>  	rc = __construct_region(cxlr, cxlrd, cxled);
>  	if (rc) {
> @@ -3625,6 +3643,126 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	return cxlr;
>  }
>  
> +static struct cxl_region *
> +__construct_new_region(struct cxl_root_decoder *cxlrd,
> +		       struct cxl_endpoint_decoder **cxled, int ways)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> +	struct cxl_region_params *p;
> +	resource_size_t size = 0;
> +	struct cxl_region *cxlr;
> +	int rc, i;
> +
> +	cxlr = construct_region_begin(cxlrd, cxled[0]);
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
> +		rc = -EBUSY;
> +		goto err;
> +	}
> +
> +	rc = set_interleave_ways(cxlr, ways);
> +	if (rc)
> +		goto err;
> +
> +	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
> +	if (rc)
> +		goto err;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
> +		for (i = 0; i < ways; i++) {
> +			if (!cxled[i]->dpa_res)
> +				break;
> +			size += resource_size(cxled[i]->dpa_res);
> +		}
> +	}

Does the dpa read lock needs to be held from the first one to this one? Is there concern that the cxled may change during the time the lock is released and acquired again?

DJ

> +
> +	if (i < ways)
> +		goto err;
> +
> +	rc = alloc_hpa(cxlr, size);
> +	if (rc)
> +		goto err;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
> +		for (i = 0; i < ways; i++) {
> +			rc = cxl_region_attach(cxlr, cxled[i], 0);
> +			if (rc)
> +				goto err;
> +		}
> +	}
> +
> +	if (rc)
> +		goto err;
> +
> +	rc = cxl_region_decode_commit(cxlr);
> +	if (rc)
> +		goto err;
> +
> +	p->state = CXL_CONFIG_COMMIT;
> +
> +	return cxlr;
> +err:
> +	drop_region(cxlr);
> +	return ERR_PTR(rc);
> +}
> +
> +/**
> + * cxl_create_region - Establish a region given an endpoint decoder
> + * @cxlrd: root decoder to allocate HPA
> + * @cxled: endpoint decoder with reserved DPA capacity
> + * @ways: interleave ways required
> + * @action: driver function to be called on region removal
> + * @data: pointer to data structure for the action execution
> + *
> + * Returns a fully formed region in the commit state and attached to the
> + * cxl_region driver.
> + */
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder **cxled,
> +				     int ways, void (*action)(void *),
> +				     void *data)
> +{
> +	struct cxl_region *cxlr;
> +	int rc;
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
> +	if (action) {
> +		rc = devm_add_action_or_reset(&cxlr->dev, action, data);
> +		if (rc) {
> +			drop_region(cxlr);
> +			return ERR_PTR(rc);
> +		}
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
> index 0a607710340d..dbacefff8d60 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -278,4 +278,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>  					     enum cxl_partition_mode mode,
>  					     resource_size_t alloc);
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder **cxled,
> +				     int ways, void (*action)(void *),
> +				     void *data);
>  #endif /* __CXL_CXL_H__ */


