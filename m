Return-Path: <netdev+bounces-154215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 596869FC124
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 19:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17FF18840B9
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 18:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41531FF7AC;
	Tue, 24 Dec 2024 18:05:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB3717BD6;
	Tue, 24 Dec 2024 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735063506; cv=none; b=lMzZMTxuEiNX3i2FSTW2n99yIi95ojR/V9QZhBMacHjrziN4EWI2FBAkfUYtggKIEJxFXI2jgG6KuzqFIoEmyr22HSWac5HcrgdwA9SwGpJxpPHz2eqDAyNuZOZ7Wn6F1LlrZxdvg/uLndkPteH3gWGAhpsppjVFQhi0DV+gIDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735063506; c=relaxed/simple;
	bh=5rNDAebZorNmMEbUxTQeTy0WXdkIBFLGPb0Q34nfihg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t56qUonQENE02o90KVzGQaYOKtQgY0Iv+IioUXq2W4jnYc7rtqSe5KL3uMQGbCmrTokQnX8Dc430j/PTCrwLWi/aNgm5FruvaYijerBnET8RJJYxr9T/22WcexoJwRzp02eJLtyMjNEGgT2gwKEnei0JqZAlZnxLEDIuc5Nwqs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHjPJ4ZJmz6K9LR;
	Wed, 25 Dec 2024 02:01:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 25E66140D1D;
	Wed, 25 Dec 2024 02:05:02 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 19:05:01 +0100
Date: Tue, 24 Dec 2024 18:04:58 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>, Alejandro
 Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 23/27] cxl: add region flag for precluding a device
 memory to be used for dax
Message-ID: <20241224180458.00001812@huawei.com>
In-Reply-To: <20241216161042.42108-24-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
	<20241216161042.42108-24-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 16 Dec 2024 16:10:38 +0000
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> By definition a type2 cxl device will use the host managed memory for
> specific functionality, therefore it should not be available to other
> uses. However, a dax interface could be just good enough in some cases.
> 
> Add a flag to a cxl region for specifically state to not create a dax
> device. Allow a Type2 driver to set that flag at region creation time.

So this is presented as something a type 2 driver would chose to set
or not. That feels premature if for now they are all going to set
it? 
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  drivers/cxl/core/region.c | 11 ++++++++++-
>  drivers/cxl/cxl.h         |  3 +++
>  drivers/cxl/cxlmem.h      |  3 ++-
>  include/cxl/cxl.h         |  3 ++-
>  4 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a24d8678e8dc..aeaa6868e556 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3557,12 +3557,14 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
>   * cxl_create_region - Establish a region given an endpoint decoder
>   * @cxlrd: root decoder to allocate HPA
>   * @cxled: endpoint decoder with reserved DPA capacity
> + * @no_dax: if true no DAX device should be created
>   *
>   * Returns a fully formed region in the commit state and attached to the
>   * cxl_region driver.
>   */
>  struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> -				     struct cxl_endpoint_decoder *cxled)
> +				     struct cxl_endpoint_decoder *cxled,
> +				     bool no_dax)
>  {
>  	struct cxl_region *cxlr;
>  
> @@ -3578,6 +3580,10 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>  		drop_region(cxlr);
>  		return ERR_PTR(-ENODEV);
>  	}
> +
> +	if (no_dax)
> +		set_bit(CXL_REGION_F_NO_DAX, &cxlr->flags);
> +
>  	return cxlr;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
> @@ -3713,6 +3719,9 @@ static int cxl_region_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> +	if (test_bit(CXL_REGION_F_NO_DAX, &cxlr->flags))
> +		return 0;
> +
>  	switch (cxlr->mode) {
>  	case CXL_DECODER_PMEM:
>  		return devm_cxl_add_pmem_region(cxlr);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 57d6dda3fb4a..cc9e3d859fa6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -521,6 +521,9 @@ struct cxl_region_params {
>   */
>  #define CXL_REGION_F_NEEDS_RESET 1
>  
> +/* Allow Type2 drivers to specify if a dax region should not be created. */
> +#define CXL_REGION_F_NO_DAX 2
> +
>  /**
>   * struct cxl_region - CXL region
>   * @dev: This region's device
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 9d874f1cb3bf..712f25f494e0 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -875,5 +875,6 @@ struct seq_file;
>  struct dentry *cxl_debugfs_create_dir(const char *dir);
>  void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
>  struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> -				     struct cxl_endpoint_decoder *cxled);
> +				     struct cxl_endpoint_decoder *cxled,
> +				     bool no_dax);
>  #endif /* __CXL_MEM_H__ */
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index e0ea5b801a2e..14be26358f9c 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -61,7 +61,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>  					     resource_size_t max);
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>  struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> -				     struct cxl_endpoint_decoder *cxled);
> +				     struct cxl_endpoint_decoder *cxled,
> +				     bool no_dax);
>  
>  int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
>  #endif


