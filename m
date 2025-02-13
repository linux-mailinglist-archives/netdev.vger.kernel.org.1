Return-Path: <netdev+bounces-165805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDF2A3369C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 05:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44AB73A4A71
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A31205512;
	Thu, 13 Feb 2025 04:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ia24f1WC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0119A2054FD;
	Thu, 13 Feb 2025 04:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419752; cv=none; b=Y7Hma1Bn1h0bUf/CxekeLeWwquYhhFyH7ISJ2AH8dEC1ZtXbKJJ1C9K2pABx09wrN+eTEsbs0Y98yX0DVUSaxIffWaLvkOlzYRU4IWpP3kEUXgSiuiP84XbOsvhseCuVO4rOlBwk/ARB2JuVk9Nx5qmLIuw3AGNNZIAw1jp3BOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419752; c=relaxed/simple;
	bh=I83c3TZ8PInC74LiUfr9cW6b0WIPQOEr+Izbf2Pmmps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6VjopC/0bi2t46wRN3gSMfRfc4o+N0a530g8b2Eg6+kNEGJ8NO+34RVmK1Rx/th4aCefszYNtHqdLGuVibDn9EVOTJZYEeunH7eYfd8I3jF8dMwCs3OdEqq0W8FB5TfQfDzgDhfjcuheU9hPO2vtIt88wD/A7tjSQUy5Hm6D+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ia24f1WC; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739419751; x=1770955751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I83c3TZ8PInC74LiUfr9cW6b0WIPQOEr+Izbf2Pmmps=;
  b=Ia24f1WCccK/+0MM2S/x0a9nDuN2IhmYTDLj0VpZjJzMXAdtXWuJ+9Fr
   yOznVtM3DtUIvImqnTZugTpG5i5Hf/n+p+EunnopoLEj4DP/dfGjRG/rX
   ixpXUerKPDxvWUrbUHbXp5NVD/j+lacOu1FcrsmJ1RMBWaZdYWKKL3ibp
   /WhZNVAYmEGQCJ38JxzeXduSEaDgd+6jPPtp/wnypbK8K0uXtdhyMHwBC
   E+HWUPBZ3jaYGLRLA92r2icXhzhhAhZLyvv5KLIOlTev0dhyGW1N8gx1J
   T9xX4waXdrXZ0p7vpNEpUP4wuW17b5lFxViT8T4l6CNg5HPJVjKUjaOPD
   w==;
X-CSE-ConnectionGUID: BsLtvw1MT/KRZn/Bg1UXZQ==
X-CSE-MsgGUID: IF57e7U0RjOXeQEYj8ZC/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="51092167"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="51092167"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 20:09:03 -0800
X-CSE-ConnectionGUID: VAFTU3a8SzyPtmxHQnHoog==
X-CSE-MsgGUID: WAuKoi1hQGSXmzBtgXi7Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="113689720"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.167])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 20:09:01 -0800
Date: Wed, 12 Feb 2025 20:08:58 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: alucerop@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Subject: Re: [PATCH v10 14/26] cxl: define a driver interface for HPA free
 space enumeration
Message-ID: <Z61wWucUQnzjcEh3@aschofie-mobl2.lan>
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-15-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205151950.25268-15-alucerop@amd.com>

On Wed, Feb 05, 2025 at 03:19:38PM +0000, alucerop@amd.com wrote:
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
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>

Checkpatch WARNS on more than one of these in the set.
Dan's SOB goes after his Co-dev tag.

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/region.c | 160 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   3 +
>  include/cxl/cxl.h         |  10 +++
>  3 files changed, 173 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 84ce625b8591..69ff00154298 100644
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
> +	int found;
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
> +	for (int i = 0; i < ctx->interleave_ways; i++)
> +		for (int j = 0; j < ctx->interleave_ways; j++)
> +			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
> +				found++;
> +				break;
> +			}
> +
Above deserves another bracket at least on the outer for loop:
https://www.kernel.org/doc/html/latest/process/coding-style.html
"Also, use braces when a loop contains more than a single simple
statement"


> +	if (found != ctx->interleave_ways) {

Adding on to Simons feedback: Even if found is OK as 0, prefer it be
initialized so we don't have to think about it on every static report.


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
> +		dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n",
> +			&max);
> +	}
> +	return 0;
> +}
> +
> +/**
> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
> + * @cxlmd: the CXL memory device with an endpoint that is mapped by the returned
> + *	    decoder
> + * @interleave_ways: number of entries in @host_bridges
> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
> + * @max_avail_contig: output parameter of max contiguous bytes available in the
> + *		      returned decoder
> + *
> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
> + * caller goes to use this root decoder's capacity the capacity is reduced then
> + * caller needs to loop and retry.
> + *
> + * The returned root decoder has an elevated reference count that needs to be
> + * put with put_device(CXLRD_DEV(cxlrd)).
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
> +	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
> +	up_read(&cxl_region_rwsem);
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
> index 3faba6c9dbfb..e1a8e3d786af 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -759,6 +759,9 @@ struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>  struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
> +
> +#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
> +
>  bool is_root_decoder(struct device *dev);
>  bool is_switch_decoder(struct device *dev);
>  bool is_endpoint_decoder(struct device *dev);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 592aa5e75bc2..3b72dc7ce8cf 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -39,6 +39,10 @@ enum cxl_devtype {
>  	CXL_DEVTYPE_CLASSMEM,
>  };
>  
> +#define CXL_DECODER_F_RAM   BIT(0)
> +#define CXL_DECODER_F_PMEM  BIT(1)
> +#define CXL_DECODER_F_TYPE2 BIT(2)
> +
>  /*
>   * struct for an accel driver giving partition data when Type2 device without a
>   * mailbox.
> @@ -80,4 +84,10 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
>  int cxl_dpa_setup(struct cxl_memdev_state *cxlmds, const struct cxl_dpa_info *info);
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  				       struct cxl_memdev_state *cxlmds);
> +struct cxl_port;
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max);
> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
>  #endif
> -- 
> 2.17.1
> 
> 

