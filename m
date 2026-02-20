Return-Path: <netdev+bounces-259735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YElZB/+AmGlMJQMAu9opvQ
	(envelope-from <netdev+bounces-259735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 16:42:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B287A168FC2
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 16:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B2D23004DD9
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CDF3451BA;
	Fri, 20 Feb 2026 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBDFY5Xs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122E03164D4;
	Fri, 20 Feb 2026 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771602171; cv=none; b=tn25LsY4AfIqHXiG+JFgMRhN3dyTChKLoVxkKzDIim36dUfGLUaG+vpAJtz7+3jdqYDxyaH3NdAIS0WifW4iuGLkT0ukSYl6mscCesIQMTrRE3oibwUTt0LRI5t3+g2fG4V5vBBLP8+PPrmShNN+G1yP68rGkq3u/5T7L9mdutA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771602171; c=relaxed/simple;
	bh=c/0F3Zcs/ajAPs7LR68zL4Fd8Ke5e+LE0K35AHav2hE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lm8m5deRFD30Dup9jsEWJpokI99M6r+4CeSWNrenZfu1aosr6J7i+n+4xY95CD2wysAp9z6pf1TsyryXyXfFCa9ToPi8I32pwAGn56roHzAyWXkg23oOYLFKIpAgSFkRzj9jRprXSlNyxlYuVJDh0dVU1iS6TyEOMKVzVAj5GVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBDFY5Xs; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771602169; x=1803138169;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c/0F3Zcs/ajAPs7LR68zL4Fd8Ke5e+LE0K35AHav2hE=;
  b=BBDFY5XsSl1s8i1DruwmHByDLRy0+6uVADryc8SUXgX2iKQfVawFNH5A
   8c77nwWcwwvCv9uMh3fYbUTTAfezD/QgsfFs1dPsciQj4pgeS+ALDWImj
   Fjv1HSF9ZvJJiIzBQefdamLpXTij2KEXhdSh5WwVBGIR8si6IQm3UUGZz
   3PNTrbdZSqsoKswuAmCyckugWQi5h0+0R/ZgJPKqp/FH1/5CwR693M13D
   r+69GEs3Bzteh04UO+JxXzoTH1Ezya2SmOMIdz5NVcL4jKLvj2xPB0AUJ
   aes/ygDX4eCeAG0zjFnALaQfW1dUf5LYqjM09X19NN4Qdz1iGY5g4j9QE
   w==;
X-CSE-ConnectionGUID: cPWtHafgSzip8tkccjMtCw==
X-CSE-MsgGUID: ldYXF0NQQpGF9NJcRwdSDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="71721754"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="71721754"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 07:42:48 -0800
X-CSE-ConnectionGUID: 9z4j3WoPRByXRBneFiGB+A==
X-CSE-MsgGUID: YwKunrxmT8KsXe79qObBjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="212637935"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.83]) ([10.125.110.83])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 07:42:47 -0800
Message-ID: <341c6e75-e027-4fa0-bb5e-f8091efd3130@intel.com>
Date: Fri, 20 Feb 2026 08:42:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 12/22] cxl: Define a driver interface for HPA free
 space enumeration
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-13-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260201155438.2664640-13-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259735-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,huawei.com:email,amd.com:email]
X-Rspamd-Queue-Id: B287A168FC2
X-Rspamd-Action: no action



On 2/1/26 8:54 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> CXL region creation involves allocating capacity from Device Physical
> Address (DPA) and assigning it to decode a given Host Physical Address
> (HPA). Before determining how much DPA to allocate the amount of available
> HPA must be determined. Also, not all HPA is created equal, some HPA
> targets RAM, some targets PMEM, some is prepared for device-memory flows
> like HDM-D and HDM-DB, and some is HDM-H (host-only).
> 
> In order to support Type2 CXL devices, wrap all of those concerns into
> an API that retrieves a root decoder (platform CXL window) that fits the
> specified constraints and the capacity available for a new region.
> 
> Add a complementary function for releasing the reference to such root
> decoder.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/region.c | 164 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   3 +
>  include/cxl/cxl.h         |   6 ++
>  3 files changed, 173 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 954b8fcdbac6..bdefd088f5f1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -705,6 +705,170 @@ static int free_hpa(struct cxl_region *cxlr)
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
> +	resource_size_t free = 0;
> +	resource_size_t max;
> +	int found = 0;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	cxlsd = &cxlrd->cxlsd;
> +	cxld = &cxlsd->cxld;
> +
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
> +		dev_dbg(dev,
> +			"Not enough host bridges. Found %d for %d interleave ways requested\n",
> +			found, ctx->interleave_ways);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Walk the root decoder resource range relying on cxl_rwsem.region to
> +	 * preclude sibling arrival/departure and find the largest free space
> +	 * gap.
> +	 */
> +	lockdep_assert_held_read(&cxl_rwsem.region);
> +	res = cxlrd->res->child;
> +
> +	/* With no resource child the whole parent resource is available */
> +	if (!res)
> +		max = resource_size(cxlrd->res);
> +	else
> +		max = 0;
> +
> +	for (prev = NULL; res; prev = res, res = res->sibling) {
> +		if (!prev && res->start == cxlrd->res->start &&
> +		    res->end == cxlrd->res->end) {
> +			max = resource_size(cxlrd->res);
> +			break;
> +		}

Can this block be pulled out of the for loop so it only needs to run once?

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
> +	}
> +
> +	if (prev && prev->end + 1 < cxlrd->res->end + 1) {
> +		free = cxlrd->res->end + 1 - prev->end + 1;
> +		max = max(free, max);
> +	}
> +
> +	dev_dbg(cxlrd_dev(cxlrd), "found %pa bytes of free space\n", &max);
> +	if (max > ctx->max_hpa) {
> +		if (ctx->cxlrd)
> +			put_device(cxlrd_dev(ctx->cxlrd));
> +		get_device(cxlrd_dev(cxlrd));
> +		ctx->cxlrd = cxlrd;
> +		ctx->max_hpa = max;

Is there any chance that ctx->cxlrd == cxlrd? Maybe you can do:

if (ctx->cxlrd && ctx->cxlrd != cxlrd) {
	put_device(cxlrd_dev(ctx->cxlrd));
	get_device(cxlrd_dev(cxlrd));
	ctx->cxlrd = cxlrd;
}
ctx->max_hpa = max;

DJ

> +	}
> +	return 0;
> +}
> +
> +/**
> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
> + * @cxlmd: the mem device requiring the HPA
> + * @interleave_ways: number of entries in @host_bridges
> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
> + * @max_avail_contig: output parameter of max contiguous bytes available in the
> + *		      returned decoder
> + *
> + * Returns a pointer to a struct cxl_root_decoder
> + *
> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
> + * caller goes to use this decoder and its capacity is reduced then caller needs
> + * to loop and retry.
> + *
> + * The returned root decoder has an elevated reference count that needs to be
> + * put with cxl_put_root_decoder(cxlrd).
> + */
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max_avail_contig)
> +{
> +	struct cxlrd_max_context ctx = {
> +		.flags = flags,
> +		.interleave_ways = interleave_ways,
> +	};
> +	struct cxl_port *root_port;
> +	struct cxl_port *endpoint;
> +
> +	endpoint = cxlmd->endpoint;
> +	if (!endpoint) {
> +		dev_dbg(&cxlmd->dev, "endpoint not linked to memdev\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	ctx.host_bridges = &endpoint->host_bridge;
> +
> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
> +	if (!root) {
> +		dev_dbg(&endpoint->dev, "endpoint is not related to a root port\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	root_port = &root->port;
> +	scoped_guard(rwsem_read, &cxl_rwsem.region)
> +		device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
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
> +	put_device(cxlrd_dev(cxlrd));
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_put_root_decoder, "CXL");
> +
>  static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>  			  const char *buf, size_t len)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 944c5d1ccceb..c7d9b2c2908f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -706,6 +706,9 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>  struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
> +
> +#define cxlrd_dev(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
> +
>  bool is_switch_decoder(struct device *dev);
>  bool is_endpoint_decoder(struct device *dev);
>  struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 92880c26b2d5..834dc7e78934 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -255,4 +255,10 @@ struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
>  struct range;
>  int cxl_get_region_range(struct cxl_region *region, struct range *range);
>  void cxl_unregister_region(struct cxl_region *cxlr);
> +struct cxl_port;
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max);
> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
>  #endif /* __CXL_CXL_H__ */


