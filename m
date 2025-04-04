Return-Path: <netdev+bounces-179349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88580A7C153
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 18:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617D73BCA52
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0B8207A2B;
	Fri,  4 Apr 2025 16:11:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF511FECAA;
	Fri,  4 Apr 2025 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743783113; cv=none; b=TU1Lz0G0qMlRC5gQBLMGSWyRFdm+pz8dZPQNgE7Yw9/Eh+eB/K8RKKBC/ZrrXOSzDB1KyOT+kMbaU+naahg5PCpMTp+k1wTNZg27QXcvxgUasmOGd3tCmk9LcolPHmoVjhTvBYdSBq13Ibklz9fnbdPB2fnS0pJJyoyHjr27+so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743783113; c=relaxed/simple;
	bh=ts6Xz5JVxLVI1LnZaTcHDlIv50PBNbXROd2XjaEGt6o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+7ACg8iDv7SO8sV0Lr5XDdHuXnZLGWUqs39FTFf1iFltTn9P0/1LxJj+O9P/GBOqs3rY1GpU1GMXUxpHjbPBO8PxCJy6312Qv1ti6GLaVEqYOYLiuYlHqU/g/nlOa+TjSoT4eqKM7PfgHxKHbpq6W28fBStjhMSWseT5Xym3+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTk6H6qVPz6K9Hg;
	Sat,  5 Apr 2025 00:08:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E23551402C7;
	Sat,  5 Apr 2025 00:11:48 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 18:11:48 +0200
Date: Fri, 4 Apr 2025 17:11:46 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 07/23] cxl: support dpa initialization without a
 mailbox
Message-ID: <20250404171146.00003258@huawei.com>
In-Reply-To: <20250331144555.1947819-8-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
	<20250331144555.1947819-8-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 31 Mar 2025 15:45:39 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
> memdev state params which end up being used for dma initialization.
> 
> Allow a Type2 driver to initialize dpa simply by giving the size of its
> volatile and/or non-volatile hardware partitions.
> 
> Export cxl_dpa_setup as well for initializing those added dpa partitions
> with the proper resources.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/cxl/core/mbox.c | 17 ++++++++++++++---
>  drivers/cxl/cxlmem.h    | 13 -------------
>  include/cxl/cxl.h       | 14 ++++++++++++++
>  3 files changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index ab994d459f46..e4610e778723 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1284,6 +1284,18 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
>  	info->nr_partitions++;
>  }
>  
> +void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
> +		      u64 persistent_bytes)
> +{
> +	if (!info->size)
> +		info->size = volatile_bytes + persistent_bytes;
> +
> +	add_part(info, 0, volatile_bytes, CXL_PARTMODE_RAM);
> +	add_part(info, volatile_bytes, persistent_bytes,
> +		 CXL_PARTMODE_PMEM);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_init, "CXL");
> +
>  int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  {
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
> @@ -1298,9 +1310,8 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  	info->size = mds->total_bytes;
>  
>  	if (mds->partition_align_bytes == 0) {
> -		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
> -		add_part(info, mds->volatile_only_bytes,
> -			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
> +		cxl_mem_dpa_init(info, mds->volatile_only_bytes,
> +				 mds->persistent_only_bytes);

Why use this here but not a few lines later where the variant with
active_*_bytes are used?

>  		return 0;
>  	}
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index e7cd31b9f107..e47f51025efd 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -98,19 +98,6 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			 resource_size_t base, resource_size_t len,
>  			 resource_size_t skipped);
>  
> -#define CXL_NR_PARTITIONS_MAX 2
> -
> -struct cxl_dpa_info {
> -	u64 size;
> -	struct cxl_dpa_part_info {
> -		struct range range;
> -		enum cxl_partition_mode mode;
> -	} part[CXL_NR_PARTITIONS_MAX];
> -	int nr_partitions;
> -};
> -
> -int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
> -
>  static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>  					 struct cxl_memdev *cxlmd)
>  {
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index a3cbf3a620e4..74f03773baed 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -213,6 +213,17 @@ struct cxl_dev_state {
>  #endif
>  };
>  
> +#define CXL_NR_PARTITIONS_MAX 2
> +
> +struct cxl_dpa_info {
> +	u64 size;
> +	struct cxl_dpa_part_info {
> +		struct range range;
> +		enum cxl_partition_mode mode;
> +	} part[CXL_NR_PARTITIONS_MAX];
> +	int nr_partitions;
> +};
> +
>  struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
>  					    enum cxl_devtype type, u64 serial,
>  					    u16 dvsec, size_t size,
> @@ -231,4 +242,7 @@ struct pci_dev;
>  struct cxl_memdev_state;
>  int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
>  			     unsigned long *caps);
> +void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
> +		      u64 persistent_bytes);
> +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
>  #endif


