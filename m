Return-Path: <netdev+bounces-244756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC95CBE261
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DA553016CC6
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793262E6CA8;
	Mon, 15 Dec 2025 13:53:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBADD1A9FAB;
	Mon, 15 Dec 2025 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765806790; cv=none; b=BI/67IHCKG0ebDdbhni8HJeXJ7Gw/5DxiIfNYixsBS15MSLRheWTorIacdjMbHa7B3l695JH6PC5PYC7jnw9Nb4wpkOZPV2ZLJ057Z559vP7X4mSDBiv1gmh0oqBl7QafZajh5ieEuxrTPRlFgESI/zFBdjtLAlZ50zmrLn3R3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765806790; c=relaxed/simple;
	bh=+j7h9Aa4JImIpAvLJN7t+JilAgQ63TcRlXkNuuQt4sg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmIDj9RF/C6yaZ9r15dE1hxQKzPSDNTpUjNdgVIoQqwaki3P9d4DRbHIu4271NwQtC9N+tVo0G35LQGXPcRX7bCdBO1JWQTZP0LrDFDMOrM/BVMQHY7V9xztaZZ2AXbuPqr0KkwmXhZknFafBlmwesOrzFyUCNiTQVrI2Oehq7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dVM2N4Ll5zHnHCd;
	Mon, 15 Dec 2025 21:52:44 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id F02FA40539;
	Mon, 15 Dec 2025 21:53:05 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 15 Dec
 2025 13:53:05 +0000
Date: Mon, 15 Dec 2025 13:53:03 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v22 13/25] cxl: Export functions for unwinding cxl by
 accelerators
Message-ID: <20251215135303.00002f63@huawei.com>
In-Reply-To: <20251205115248.772945-14-alejandro.lucero-palau@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
	<20251205115248.772945-14-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 5 Dec 2025 11:52:36 +0000
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add unregister_region() and cxl_decoder_detach() to the accelerator
> driver API for a clean exit.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
In general seems fine but comment on type safety inline.

Jonathan

> ---
>  drivers/cxl/core/core.h   | 5 -----
>  drivers/cxl/core/region.c | 4 +++-
>  include/cxl/cxl.h         | 9 +++++++++
>  3 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1c1726856139..9a6775845afe 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -15,11 +15,6 @@ extern const struct device_type cxl_pmu_type;
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
> index 8166a402373e..104caa33b7bb 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2199,6 +2199,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
>  	}
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_decoder_detach, "CXL");
>  
>  static int __attach_target(struct cxl_region *cxlr,
>  			   struct cxl_endpoint_decoder *cxled, int pos,
> @@ -2393,7 +2394,7 @@ static struct cxl_region *to_cxl_region(struct device *dev)
>  	return container_of(dev, struct cxl_region, dev);
>  }
>  
> -static void unregister_region(void *_cxlr)
> +void unregister_region(void *_cxlr)
>  {
>  	struct cxl_region *cxlr = _cxlr;
>  	struct cxl_region_params *p = &cxlr->params;
> @@ -2412,6 +2413,7 @@ static void unregister_region(void *_cxlr)
>  	cxl_region_iomem_release(cxlr);
>  	put_device(&cxlr->dev);
>  }
> +EXPORT_SYMBOL_NS_GPL(unregister_region, "CXL");
>  
>  static struct lock_class_key cxl_region_key;
>  
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index f02dd817b40f..b8683c75dfde 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -255,4 +255,13 @@ struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
>  						       struct cxl_region **cxlr);
>  struct range;
>  int cxl_get_region_range(struct cxl_region *region, struct range *range);
> +enum cxl_detach_mode {
> +	DETACH_ONLY,
> +	DETACH_INVALIDATE,
> +};
> +
> +int cxl_decoder_detach(struct cxl_region *cxlr,
> +		       struct cxl_endpoint_decoder *cxled, int pos,
> +		       enum cxl_detach_mode mode);
> +void unregister_region(void *_cxlr);

I'd wrap this for an exposed interface that isn't going to be used
as a devm callback so we can make it type safe.  Maybe making the
existing devm callback the one doing wrapping is cleanest route.


>  #endif /* __CXL_CXL_H__ */


