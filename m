Return-Path: <netdev+bounces-228116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1B2BC1A9E
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 16:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293B43BF051
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28842E1F0A;
	Tue,  7 Oct 2025 14:11:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1C62DFA27;
	Tue,  7 Oct 2025 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846311; cv=none; b=ahynhHxSvZSZFwItErFdoyAQfg84bxgaVy/YF2OlHVRr0mbR9+bx4UhtJZ/GvEDj3jhElFm5o4cOo25GbB3Ece7wFwuHCJsYNFLGTmZVZGC5SdMtjOOZHS7faTffnhPPkjarl+bTWd7+T2PwOYsycX169EFxM853X3S2b4BwUVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846311; c=relaxed/simple;
	bh=cIFWtrDHZ4h/ktkyNnW3/LYA5b9ZXR9OJ3yL+l+Xv4s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oN9+lUqPB8kn9XcNkk7kyVSL/483MrQ60PZRw3QDqtrpUr4/3aQ5Fov137ltGJ+8snPKlPVRm/sMMxo4vX4z+euKtXgBH8xsToaulqQp9OTQjTZqKUK0hojoOnBp/HW7IaTKyOJIgbZzmxnIOymskyJuoBrDR+wzzf8cD90PTS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cgygJ03qYz6L4tn;
	Tue,  7 Oct 2025 22:09:16 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 2059E1400D9;
	Tue,  7 Oct 2025 22:11:46 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 7 Oct
 2025 15:11:45 +0100
Date: Tue, 7 Oct 2025 15:11:43 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v19 18/22] cxl: Allow region creation by type2 drivers
Message-ID: <20251007151143.0000744f@huawei.com>
In-Reply-To: <20251006100130.2623388-19-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
	<20251006100130.2623388-19-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 6 Oct 2025 11:01:26 +0100
<alejandro.lucero-palau@amd.com> wrote:

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

One new question below (and a trivial thing beyond that).

If you adopt one of the suggested ways of tidying that up, then keep the RB
if not I'll want to take another look so drop it.

>  #ifdef CONFIG_CXL_REGION
>  extern struct device_attribute dev_attr_create_pmem_region;
>  extern struct device_attribute dev_attr_create_ram_region;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 26dfc15e57cd..e3b6d85cd43e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

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
> @@ -3621,6 +3639,106 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	return cxlr;
>  }
>  
> +DEFINE_FREE(cxl_region_drop, struct cxl_region *, if (_T) drop_region(_T))
> +
> +static struct cxl_region *
> +__construct_new_region(struct cxl_root_decoder *cxlrd,
> +		       struct cxl_endpoint_decoder **cxled, int ways)

Why pass in an array of struct cxl_endpoint_decoder * if this is only
ever going to use the first element?

I think we need to indicate that somehow.  Could just pass in the
relevant decoder (I assume there is only one?)  Or pass the array
and an index (here 0).


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

return_ptr() 
> +}

