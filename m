Return-Path: <netdev+bounces-181824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 553C0A86848
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CA41BA6A8E
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EC221ABD1;
	Fri, 11 Apr 2025 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLaIIYHG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC50290BC8;
	Fri, 11 Apr 2025 21:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744407010; cv=none; b=Am4oG7eWa7PQW1q68I0SVVEf/Ahjc1llCwZn90oNt1KbTngjUDWq9b8AD4fxl9Uzauzj6CBqaY23fLUo8nFiRun4DckzIeVm3VIliGYbXf/9uTc8MzN1+wSZJWfp/tb/m7DF0tCoYGd4nTtM65JJc/OmVlw3wOSqSIeLFPwqrIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744407010; c=relaxed/simple;
	bh=16AN0PwhT3zy40FLAWbdFe3A11IpNitpGq21Wp6ufLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOLaZk180l/34sATRitDxJkZQcO+zUKEy5/diCt1tFsrOw35wUK/LIdZNHXbdkYb7IAxHpfeXyBRoYKRkx5usQRymt1Jo2gDchsMVrfwVJiTnhOVRG0gPwwknRjfszgCDr+lqeyAOvb4aldetlgrXwwiMdF0uUBSOfLdbnM44rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLaIIYHG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744407008; x=1775943008;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=16AN0PwhT3zy40FLAWbdFe3A11IpNitpGq21Wp6ufLk=;
  b=PLaIIYHGAxw4nKcKc1kx9maIVD3rDMqdcrN++wWKadyJcpepYQ7yNr8j
   BcCj98kJEZT47sQ5VrNKMJa1EMDKQh0jJ0ssv2ZY+rzTb8AFiWLXgjUTo
   MG7NAgYiuqs0mhtMzfVE6iY7EF2ZLrB9yL0PworZA1R7zbd3hP1RN/Xbf
   JLkeGWj65W5mMkULCihacb2AcLhHQMxQhwrRsO7QxGW1wXq0knXPZ2UOp
   QtNnixymvFDMfYrkVGbltyZ8+ugSSNE/Xkh03hnoW61Gf61BUhTmurWKD
   qIsY0VfkpsmVozel+//2JX9cVFASIwvAecAvBkIyGjq+rDLkZkn/I6Fr+
   w==;
X-CSE-ConnectionGUID: e39GmjjQRCSduOqXWn0Wuw==
X-CSE-MsgGUID: I2pCXru+Q4mCXvVkGe7TOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="46098088"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="46098088"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 14:30:07 -0700
X-CSE-ConnectionGUID: 5YgXsH2CSq2NlObun17HIA==
X-CSE-MsgGUID: 4j+S+jkSQXGbEdwmt0VFnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="129248895"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.170]) ([10.125.108.170])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 14:30:07 -0700
Message-ID: <8b954086-a896-4787-aa0b-cdf796e6d3bc@intel.com>
Date: Fri, 11 Apr 2025 14:30:03 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 11/23] cxl: define a driver interface for HPA free
 space enumeration
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-12-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250331144555.1947819-12-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/31/25 7:45 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> CXL region creation involves allocating capacity from device DPA
> (device-physical-address space) and assigning it to decode a given HPA
> (host-physical-address space). Before determining how much DPA to
> allocate the amount of available HPA must be determined. Also, not all
> HPA is created equal, some specifically targets RAM, some target PMEM,
> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
> is host-only (HDM-H).
> 
> Wrap all of those concerns into an API that retrieves a root decoder
> (platform CXL window) that fits the specified constraints and the
> capacity available for a new region.
> 
> Add a complementary function for releasing the reference to such root
> decoder.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c | 160 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   3 +
>  include/cxl/cxl.h         |  11 ++-
>  3 files changed, 173 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c3f4dc244df7..59fb51ff8922 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -695,6 +695,166 @@ static int free_hpa(struct cxl_region *cxlr)
>  	return 0;
>  }
>  
> +struct cxlrd_max_context {
> +	struct device * const *host_bridges;
> +	int interleave_ways;
> +	unsigned long flags;
> +	resource_size_t max_hpa;
> +	struct cxl_root_decoder *cxlrd;
> +};
> +
> +static int find_max_hpa(struct device *dev, void *data)
> +{
> +	struct cxlrd_max_context *ctx = data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct resource *res, *prev;
> +	struct cxl_decoder *cxld;
> +	resource_size_t max;
> +	int found = 0;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	cxlsd = &cxlrd->cxlsd;
> +	cxld = &cxlsd->cxld;
> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
> +		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
> +			cxld->flags, ctx->flags);
> +		return 0;
> +	}
> +
> +	for (int i = 0; i < ctx->interleave_ways; i++) {
> +		for (int j = 0; j < ctx->interleave_ways; j++) {
> +			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
> +				found++;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (found != ctx->interleave_ways) {
> +		dev_dbg(dev, "Not enough host bridges found(%d) for interleave ways requested (%d)\n",
> +			found, ctx->interleave_ways);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
> +	 * preclude sibling arrival/departure and find the largest free space
> +	 * gap.
> +	 */
> +	lockdep_assert_held_read(&cxl_region_rwsem);
> +	max = 0;
> +	res = cxlrd->res->child;
> +
> +	/* With no resource child the whole parent resource is available */
> +	if (!res)
> +		max = resource_size(cxlrd->res);
> +	else
> +		max = 0;
> +
> +	for (prev = NULL; res; prev = res, res = res->sibling) {
> +		struct resource *next = res->sibling;
> +		resource_size_t free = 0;
> +
> +		/*
> +		 * Sanity check for preventing arithmetic problems below as a
> +		 * resource with size 0 could imply using the end field below
> +		 * when set to unsigned zero - 1 or all f in hex.
> +		 */
> +		if (prev && !resource_size(prev))
> +			continue;
> +
> +		if (!prev && res->start > cxlrd->res->start) {
> +			free = res->start - cxlrd->res->start;
> +			max = max(free, max);
> +		}
> +		if (prev && res->start > prev->end + 1) {
> +			free = res->start - prev->end + 1;
> +			max = max(free, max);
> +		}
> +		if (next && res->end + 1 < next->start) {
> +			free = next->start - res->end + 1;
> +			max = max(free, max);
> +		}
> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
> +			free = cxlrd->res->end + 1 - res->end + 1;
> +			max = max(free, max);
> +		}
> +	}
> +
> +	dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);
> +	if (max > ctx->max_hpa) {
> +		if (ctx->cxlrd)
> +			put_device(CXLRD_DEV(ctx->cxlrd));
> +		get_device(CXLRD_DEV(cxlrd));
> +		ctx->cxlrd = cxlrd;
> +		ctx->max_hpa = max;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
> + * @cxlmd: the CXL memory device with an endpoint that is mapped by the returned
> + *	    decoder
> + * @interleave_ways: number of entries in @host_bridges
> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
> + * @max_avail_contig: output parameter of max contiguous bytes available in the
> + *		      returned decoder
> + *
> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
> + * caller goes to use this root decoder's capacity the capacity is reduced then
> + * caller needs to loop and retry.
> + *
> + * The returned root decoder has an elevated reference count that needs to be
> + * put with cxl_put_root_decoder(cxlrd).
> + */
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max_avail_contig)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxlrd_max_context ctx = {
> +		.host_bridges = &endpoint->host_bridge,
> +		.flags = flags,
> +	};
> +	struct cxl_port *root_port;
> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
> +
> +	if (!is_cxl_endpoint(endpoint)) {
> +		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (!root) {
> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	root_port = &root->port;
> +	down_read(&cxl_region_rwsem);
> +	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);> +	up_read(&cxl_region_rwsem);

Since we are moving new code to guard(),

scoped_guard(rwsem_read, &cxl_region_rwsem)
	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);

DJ

> +
> +	if (!ctx.cxlrd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*max_avail_contig = ctx.max_hpa;
> +	return ctx.cxlrd;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
> +
> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd)
> +{
> +	put_device(CXLRD_DEV(cxlrd));
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_put_root_decoder, "CXL");
> +
>  static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>  			  const char *buf, size_t len)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 4523864eebd2..c35620c24c8f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -672,6 +672,9 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>  struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
> +
> +#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
> +
>  bool is_switch_decoder(struct device *dev);
>  bool is_endpoint_decoder(struct device *dev);
>  struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 3686a9532d55..a098b4e26980 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -25,6 +25,9 @@ enum cxl_devtype {
>  
>  struct device;
>  
> +#define CXL_DECODER_F_RAM   BIT(0)
> +#define CXL_DECODER_F_PMEM  BIT(1)
> +#define CXL_DECODER_F_TYPE2 BIT(2)
>  
>  /* Capabilities as defined for:
>   *
> @@ -246,5 +249,11 @@ void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
>  		      u64 persistent_bytes);
>  int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> -				       struct cxl_dev_state *cxlmds);
> +				       struct cxl_dev_state *cxlds);
> +struct cxl_port;
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max);
> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
>  #endif


