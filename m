Return-Path: <netdev+bounces-224652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF57B87649
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 01:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9D23B954C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 23:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F46D217F27;
	Thu, 18 Sep 2025 23:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EkBNIf0j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97C61B394F;
	Thu, 18 Sep 2025 23:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758238710; cv=none; b=o3iiIAId9PBZR4fdqFY+pJuvWnLFpA8P/l34Q1JgOW+BTNLJztNZZ1R51mG7OyzapsQYJ5atHw9G3Lsc3HTTsrYaCcauiQl810k23zB4rvK56V618gaP6XbNBmspoQ4bIQDyg1gT7poWrHOEtW7PNAQUI2HS98cECbYWy91tPEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758238710; c=relaxed/simple;
	bh=BIJ50VI/cn7czLTh92iouJIZCAg/NKy/WN2v3DfkezU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fEHjRpJlPHgDS4zzpY3/owgwwISYS8igKYNgRPuKGhCN9Pe+UyGq8T4O9zN8z/Zz2l7Cl8Yvw0LE+SSrPTWTwRfYKXNZ049l01/gbcNkTd2lpjMPH7PBQVSk6VDw3EL2ybwWFG1zQPA3+R3pm7FZN4r/wK6f0ntkZNKcE/9UZWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EkBNIf0j; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758238707; x=1789774707;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BIJ50VI/cn7czLTh92iouJIZCAg/NKy/WN2v3DfkezU=;
  b=EkBNIf0jprJDqGIx09pl08xJcIvDac9aHduDnNYjNjrrdMbsiwZobSmr
   JU5ATHc97K1R9EItAxnaDYfUOOigq2CVWwrDlp9YtZD3GAvY6MjmaaRb0
   uf8zg5IVF2KVbFZ6F4egoso3Hu4RfElrTPBUcS6iG1gKWrcgqOAYexZ7+
   4jgZqa4LzjSqqncD1fnCIRVFJHk3gVobso60eu+qj5sUIGxf226gjrCo6
   55ZQHcwSbwaD/6zbUoYW+SsYcMD/ifjoktZAe/57KGH9De6jm7wWUwOKs
   VmdT+z+8Kjz7+onleLKzEV3AHPtByHDybGt77Iptz8auNLsvJgon/WTpf
   w==;
X-CSE-ConnectionGUID: dFhHvo8+QHu810rCsBwy4w==
X-CSE-MsgGUID: vkiLgRPyQy6GJav4etQrvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="64220707"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="64220707"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 16:38:27 -0700
X-CSE-ConnectionGUID: ku8j8IvwTFOTJCD2Vl7tGg==
X-CSE-MsgGUID: kya63OCoQIadcfLEGQFbEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="180965590"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.28]) ([10.125.108.28])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 16:38:25 -0700
Message-ID: <b6b145e5-d3be-4eb1-b280-c2b7f2274c7d@intel.com>
Date: Thu, 18 Sep 2025 16:38:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 05/20] cxl: Support dpa initialization without a
 mailbox
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-6-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250918091746.2034285-6-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/25 2:17 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
> memdev state params which end up being used for DPA initialization.
> 
> Allow a Type2 driver to initialize DPA simply by giving the size of its
> volatile hardware partition.
> 
> Move related functions to memdev.
> 
> Add sfc driver as the client.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/core.h            |  2 +
>  drivers/cxl/core/mbox.c            | 51 +----------------------
>  drivers/cxl/core/memdev.c          | 66 ++++++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.c |  4 ++
>  include/cxl/cxl.h                  |  1 +
>  5 files changed, 74 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index d96213c02fd6..c4dddbec5d6e 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -90,6 +90,8 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  struct dentry *cxl_debugfs_create_dir(const char *dir);
>  int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>  		     enum cxl_partition_mode mode);
> +struct cxl_memdev_state;
> +int cxl_mem_get_partition_info(struct cxl_memdev_state *mds);
>  int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size);
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>  resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index bee84d0101d1..d57a0c2d39fb 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1144,7 +1144,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
>   *
>   * See CXL @8.2.9.5.2.1 Get Partition Info
>   */
> -static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
> +int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_get_partition_info pi;
> @@ -1300,55 +1300,6 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>  	return -EBUSY;
>  }
>  
> -static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
> -{
> -	int i = info->nr_partitions;
> -
> -	if (size == 0)
> -		return;
> -
> -	info->part[i].range = (struct range) {
> -		.start = start,
> -		.end = start + size - 1,
> -	};
> -	info->part[i].mode = mode;
> -	info->nr_partitions++;
> -}
> -
> -int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
> -{
> -	struct cxl_dev_state *cxlds = &mds->cxlds;
> -	struct device *dev = cxlds->dev;
> -	int rc;
> -
> -	if (!cxlds->media_ready) {
> -		info->size = 0;
> -		return 0;
> -	}
> -
> -	info->size = mds->total_bytes;
> -
> -	if (mds->partition_align_bytes == 0) {
> -		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
> -		add_part(info, mds->volatile_only_bytes,
> -			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
> -		return 0;
> -	}
> -
> -	rc = cxl_mem_get_partition_info(mds);
> -	if (rc) {
> -		dev_err(dev, "Failed to query partition information\n");
> -		return rc;
> -	}
> -
> -	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
> -	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
> -		 CXL_PARTMODE_PMEM);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
> -
>  int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 97127d6067c4..d148a0c942aa 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -556,6 +556,72 @@ bool is_cxl_memdev(const struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
>  
> +static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
> +{
> +	int i = info->nr_partitions;
> +
> +	if (size == 0)
> +		return;
> +
> +	info->part[i].range = (struct range) {
> +		.start = start,
> +		.end = start + size - 1,
> +	};
> +	info->part[i].mode = mode;
> +	info->nr_partitions++;
> +}
> +
> +int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
> +{
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct device *dev = cxlds->dev;
> +	int rc;
> +
> +	if (!cxlds->media_ready) {
> +		info->size = 0;
> +		return 0;
> +	}
> +
> +	info->size = mds->total_bytes;
> +
> +	if (mds->partition_align_bytes == 0) {
> +		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
> +		add_part(info, mds->volatile_only_bytes,
> +			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
> +		return 0;
> +	}
> +
> +	rc = cxl_mem_get_partition_info(mds);
> +	if (rc) {
> +		dev_err(dev, "Failed to query partition information\n");
> +		return rc;
> +	}
> +
> +	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
> +	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
> +		 CXL_PARTMODE_PMEM);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
> +
> +/**
> + * cxl_set_capacity: initialize dpa by a driver without a mailbox.
> + *
> + * @cxlds: pointer to cxl_dev_state
> + * @capacity: device volatile memory size
> + */
> +int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
> +{
> +	struct cxl_dpa_info range_info = {
> +		.size = capacity,
> +	};
> +
> +	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM);
> +	return cxl_dpa_setup(cxlds, &range_info);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_capacity, "CXL");
> +
>  /**
>   * set_exclusive_cxl_commands() - atomically disable user cxl commands
>   * @mds: The device state to operate on
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index cdfbe546d8d8..651d26aa68dc 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -78,6 +78,10 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	 */
>  	cxl->cxlds.media_ready = true;
>  
> +	if (cxl_set_capacity(&cxl->cxlds, EFX_CTPIO_BUFFER_SIZE))
> +		return dev_err_probe(&pci_dev->dev, -ENODEV,
> +				     "dpa capacity setup failed\n");
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 3b9c8cb187a3..88dea6ac3769 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -243,4 +243,5 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>  int cxl_map_component_regs(const struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
>  			   unsigned long map_mask);
> +int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>  #endif /* __CXL_CXL_H__ */


