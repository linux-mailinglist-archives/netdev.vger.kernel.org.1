Return-Path: <netdev+bounces-229759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F92BE0940
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D831819C4F8C
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAB6325480;
	Wed, 15 Oct 2025 20:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FrpahKS+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBAE41C71;
	Wed, 15 Oct 2025 20:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558835; cv=none; b=KExOA4quwclGJ8U37uV5/j1Hqy23NFMjGmwD61omOO3RrO33E2aQlzNxDclLnJ/zuwHRp6TO1zsWg8Q8AKWvQHwSN54miBJQnkqSYHLW4fSVCQG6OITfpElu9Ml6T8tO83XfTGqNryHBd3ahpMPN19eMhpx91nuUKFH2awQbiE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558835; c=relaxed/simple;
	bh=5hmCK9XAs7hWX0+arub8SLkO3NtM+JXmrjgbDnHFKmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W11mPQqlCF7at5OUkhT9VDElmmLzkjWS140uqcfhfVXkHP4fd57lLfy9LXzjYC7CMW/mJ1JfbEtAmSMtd7DQ4qBkQcswDa50g3x7DnCy15E4GCVakt2KAs2rn3YEKV5avYHRPVKSf/gltr5VkEU1RkEeHGUWVUzWTb5oYwjLBM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FrpahKS+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760558834; x=1792094834;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5hmCK9XAs7hWX0+arub8SLkO3NtM+JXmrjgbDnHFKmc=;
  b=FrpahKS+9sHutrsXFCdK5ntcSTIPTugqhmNNzhe2G1vIFQMa5PP5pZM0
   19EInlMv1A2YS6YLfMaP7lhIFgv9D5fzK/CR5UjSJBRw0jNVHIlqqbQ9e
   g5+rDXgEEVsudE3vgjioQaBTgq+PSPz2/yIoDt3mgxNMyVcnS2XM4Rw4l
   2SxcAa646IhgZbujl/hPcYik28ZyepPN4uo2n8ZcnjQnWG6ArooZy0G6j
   VioKUXWeLIzmxuk/ZAwjKd3aN8/SD28ZJa7Wy1ndjLv0H33hiBv0BoWqt
   vaIN4M30X/rnJ0cMAfYUtTD2rHZZ1vK9ec8jaX4M4KtIgDzGNLHYRFaxW
   g==;
X-CSE-ConnectionGUID: mt8OvSm9QCCUUTMAAmjk7A==
X-CSE-MsgGUID: A0bh0003SnGOVNb3v+sAGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="66395508"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="66395508"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 13:07:12 -0700
X-CSE-ConnectionGUID: 5GrwTF/9TE+vhWTBo3njwA==
X-CSE-MsgGUID: mX6dU508SoOIK84XHgCTYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="182672311"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.221]) ([10.125.111.221])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 13:07:11 -0700
Message-ID: <959f3103-9073-4d24-a51e-e6fe48e5e798@intel.com>
Date: Wed, 15 Oct 2025 13:07:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 13/22] cxl: Define a driver interface for DPA
 allocation
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 Alejandro Lucero <alucerop@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-14-alejandro.lucero-palau@amd.com>
 <20251007145251.0000526a@huawei.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251007145251.0000526a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/7/25 6:52 AM, Jonathan Cameron wrote:
> On Mon, 6 Oct 2025 11:01:21 +0100
> <alejandro.lucero-palau@amd.com> wrote:
> 
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation involves finding available DPA (device-physical-address)
>> capacity to map into HPA (host-physical-address) space.
>>
>> In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
>> that tries to allocate the DPA memory the driver requires to operate.The
>> memory requested should not be bigger than the max available HPA obtained
>> previously with cxl_get_hpa_freespace().
>>
>> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> 
> A few minor things inline.  Depending on how much this changed
> from the 'Based on' it might be appropriate to keep a SoB / author
> set to Dan, but I'll let him request that if he feels appropriate
> (or you can make that decision if Dan is busy).
> 
> A few things inline.  All trivial
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
>>  int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>>  		     enum cxl_partition_mode mode)
>> @@ -613,6 +622,82 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>>  	return 0;
>>  }
>>  
>> +static int find_free_decoder(struct device *dev, const void *data)
>> +{
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_endpoint_decoder(dev))
>> +		return 0;
>> +
>> +	cxled = to_cxl_endpoint_decoder(dev);
>> +	port = cxled_to_port(cxled);
>> +
>> +	return cxled->cxld.id == (port->hdm_end + 1);
>> +}
>> +
>> +static struct cxl_endpoint_decoder *
>> +cxl_find_free_decoder(struct cxl_memdev *cxlmd)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct device *dev;
>> +
>> +	guard(rwsem_read)(&cxl_rwsem.dpa);
>> +	dev = device_find_child(&endpoint->dev, NULL,
>> +				find_free_decoder);
>> +	if (dev)
>> +		return to_cxl_endpoint_decoder(dev);
>> +
>> +	return NULL;
> Trivial but I'd prefer to see the 'error' like thing out of line
> 
> 	if (!dev)
> 		return NULL;
> 
> 	return to_cxl_endpoint_decoder(dev);
> 
>> +}
>> +
>> +/**
>> + * cxl_request_dpa - search and reserve DPA given input constraints
>> + * @cxlmd: memdev with an endpoint port with available decoders
>> + * @mode: CXL partition mode (ram vs pmem)
>> + * @alloc: dpa size required
>> + *
>> + * Returns a pointer to a 'struct cxl_endpoint_decoder' on success or
>> + * an errno encoded pointer on failure.
>> + *
>> + * Given that a region needs to allocate from limited HPA capacity it
>> + * may be the case that a device has more mappable DPA capacity than
>> + * available HPA. The expectation is that @alloc is a driver known
>> + * value based on the device capacity but which could not be fully
>> + * available due to HPA constraints.
>> + *
>> + * Returns a pinned cxl_decoder with at least @alloc bytes of capacity
>> + * reserved, or an error pointer. The caller is also expected to own the
>> + * lifetime of the memdev registration associated with the endpoint to
>> + * pin the decoder registered as well.
>> + */
>> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>> +					     enum cxl_partition_mode mode,
>> +					     resource_size_t alloc)
>> +{
>> +	int rc;
>> +
>> +	if (!IS_ALIGNED(alloc, SZ_256M))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	struct cxl_endpoint_decoder *cxled __free(put_cxled) =
>> +		cxl_find_free_decoder(cxlmd);
>> +
>> +	if (!cxled)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	rc = cxl_dpa_set_part(cxled, mode);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	rc = cxl_dpa_alloc(cxled, alloc);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	return no_free_ptr(cxled);
> 
> return_ptr() (it's exactly the same implementation).

I don't care either way. But as I recall Dan preferred the 'return no_free_ptr()' version to make it obvious.

DJ

> 
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
> 


