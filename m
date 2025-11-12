Return-Path: <netdev+bounces-238061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CC8C53944
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 18:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 763344F79AA
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 16:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA2A2D3217;
	Wed, 12 Nov 2025 16:19:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71F4277CB8;
	Wed, 12 Nov 2025 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964389; cv=none; b=oAxRw2Kgpc6rwsFraUZDgCW5vktHRaIbqtB5ol4g3CeruNVzuj6I4SUHAPdHagj28KuCF7QXcsyzzEnBINn/pCj9tJkka9qrw07PvP5sL2+XC01KbDRK6Ccd/vo/ddWI95AF7bfhkURrvl0bzHRwsf2gmnNY98+gdMMzdgoXEtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964389; c=relaxed/simple;
	bh=h4mtztuT7JJ9t83m7s+GfpGWTDim0wIc2iMmg0IYp7o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M54mAlKh0S7kdI2+OWjx24wsvyPAZ9JQ/EXFosyfmGJHCtxqeYEGyCchfPqa3MMotK1p5paQrZP7fbLyveffqbMY9tq/0bFXshKN9hFJkC3lc/VmCiDGQEyWwqJQwLPMhs7fzFrpCveO56Pcgf9I/XSl52GpSG2f2cOMPmhHmpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d67rc0gcnzJ46F9;
	Thu, 13 Nov 2025 00:19:12 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id CB1EC1400D9;
	Thu, 13 Nov 2025 00:19:44 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 12 Nov
 2025 16:19:44 +0000
Date: Wed, 12 Nov 2025 16:19:42 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v20 18/22] cxl: Allow region creation by type2 drivers
Message-ID: <20251112161942.00001012@huawei.com>
In-Reply-To: <20251110153657.2706192-19-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
	<20251110153657.2706192-19-alejandro.lucero-palau@amd.com>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 10 Nov 2025 15:36:53 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Creating a CXL region requires userspace intervention through the cxl
> sysfs files. Type2 support should allow accelerator drivers to create
> such cxl region from kernel code.
> 
> Adding that functionality and integrating it with current support for
> memory expanders. Only support uncommitted CXL_DECODER_DEVMEM decoders.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
One minor suggestion that I made very late in v19 thread.
Either way:
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 2424d1b35cee..63c9c5f92252 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

...

> +static struct cxl_region *
> +__construct_new_region(struct cxl_root_decoder *cxlrd,
> +		       struct cxl_endpoint_decoder **cxled, int ways)
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

I came in late on v19 thread with a comment on this.


		for (i = 0; i < ways; i++) {
			if (!cxled[i]->dpa_res)
				return ERR_PTR(-EINVAL);
			size += resource_size(cxled[i]->dpa_res);
		}
Is the same but simpler.

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
> +}


