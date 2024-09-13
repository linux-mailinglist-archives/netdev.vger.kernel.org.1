Return-Path: <netdev+bounces-128207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A12797878C
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 20:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFCE28A72A
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 18:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9478F6A;
	Fri, 13 Sep 2024 18:08:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76644132117;
	Fri, 13 Sep 2024 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250896; cv=none; b=WV0YAlRm1J054c+V9QnK42XnmTEsGaL3EqjGGD9VN0cYixspRvyW5g55SA9fNdD6EfmMcctM6udph4iVL94rZw+XPwtQ/nZv/SkPYIADzK6fAvaZ7bwzKYL2uYNNSho62s1PSZa1d2VVplTFRzKFg8ZpGTHb6sdSPXRN/vcyOcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250896; c=relaxed/simple;
	bh=DksrWtmDsvnuE000nzAvcl6FqrVUSZyUSb3lRWm2a5o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ad+IXS+4f8LE5+FceIUGf9ASLYoTKsActqUjKy2RCU7ka019jkjVjfS5eCsXg8SRd6Q51v3zxMtUNd6FE34Ndyl615BTiMAG0MktVowXOk7QbyBck5uiRTc9bPJNsGpR/30dTVeGG/CQgkoKfRJqSXTG286d1oI9MjLUxo7JKVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X52Gr3Zp2z6K60F;
	Sat, 14 Sep 2024 02:03:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B4B214038F;
	Sat, 14 Sep 2024 02:08:11 +0800 (CST)
Received: from localhost (10.48.150.243) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Sep
 2024 20:08:10 +0200
Date: Fri, 13 Sep 2024 19:08:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v3 17/20] cxl: allow region creation by type2 drivers
Message-ID: <20240913190808.000010d0@Huawei.com>
In-Reply-To: <20240907081836.5801-18-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
	<20240907081836.5801-18-alejandro.lucero-palau@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 7 Sep 2024 09:18:33 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Creating a CXL region requires userspace intervention through the cxl
> sysfs files. Type2 support should allow accelerator drivers to create
> such cxl region from kernel code.
> 
> Adding that functionality and integrating it with current support for
> memory expanders.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Sign off doesn't make sense given Dan didn't sent the mail. Co-developed missing?


Minor stuff inline,

Jonathan

> +static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
> +						 struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
> -	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
> -	struct resource *res;
> -	int rc;
> +	int err = 0;
>  
>  	do {
>  		cxlr = __create_region(cxlrd, cxled->mode,
> @@ -3404,8 +3414,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>  
>  	if (IS_ERR(cxlr)) {
> -		dev_err(cxlmd->dev.parent,
> -			"%s:%s: %s failed assign region: %ld\n",
> +		dev_err(cxlmd->dev.parent, "%s:%s: %s failed assign region: %ld\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			__func__, PTR_ERR(cxlr));
>  		return cxlr;
> @@ -3415,19 +3424,41 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	p = &cxlr->params;
>  	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>  		dev_err(cxlmd->dev.parent,
> -			"%s:%s: %s autodiscovery interrupted\n",
> +			"%s:%s: %s region setup interrupted\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			__func__);
> -		rc = -EBUSY;
> -		goto err;
> +		err = -EBUSY;
>  	}
>  
> +	if (err) {
> +		construct_region_end();

Here I'd just release the semaphore not call this warpper as it's taken within this
function I think?

> +		drop_region(cxlr);
> +		return ERR_PTR(err);
> +	}
> +	return cxlr;
> +}
> +

>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
> @@ -3444,6 +3475,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  			 __func__, dev_name(&cxlr->dev));
>  	}
>  
> +	p = &cxlr->params;
>  	p->res = res;
>  	p->interleave_ways = cxled->cxld.interleave_ways;
>  	p->interleave_granularity = cxled->cxld.interleave_granularity;
> @@ -3451,24 +3483,106 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
>  	if (rc)
> -		goto err;
> +		goto out;
>  
>  	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
> -		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
> -		dev_name(&cxlr->dev), p->res, p->interleave_ways,
> -		p->interleave_granularity);
> +				   dev_name(&cxlmd->dev),
> +				   dev_name(&cxled->cxld.dev), __func__,
Avoid reformatting unless necessary. Hard to tell what changed
if anything.
> +				   dev_name(&cxlr->dev), p->res,
> +				   p->interleave_ways,
> +				   p->interleave_granularity);
>  
>  	/* ...to match put_device() in cxl_add_to_region() */
>  	get_device(&cxlr->dev);
>  	up_write(&cxl_region_rwsem);
>  
> +out:
> +	construct_region_end();

As below. I'd have separate error handling path.
Same in the other paths.

> +	if (rc) {
> +		drop_region(cxlr);
> +		return ERR_PTR(rc);
> +	}
>  	return cxlr;
> +}
>  
> -err:
> -	up_write(&cxl_region_rwsem);
> -	devm_release_action(port->uport_dev, unregister_region, cxlr);
> -	return ERR_PTR(rc);
> +static struct cxl_region *
> +__construct_new_region(struct cxl_root_decoder *cxlrd,
> +		       struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> +	struct cxl_region_params *p;
> +	resource_size_t size = 0;
set in all paths that use it.

> +	struct cxl_region *cxlr;
> +	int rc;
> +
> +	cxlr = construct_region_begin(cxlrd, cxled);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +
> +	rc = set_interleave_ways(cxlr, 1);
> +	if (rc)
> +		goto out;
> +
> +	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
> +	if (rc)
> +		goto out;
> +
> +	size = resource_size(cxled->dpa_res);
> +
only used once
	rc = alloc_hpa(cxlr, resource_size(cxled->dpa_res));

> +	rc = alloc_hpa(cxlr, size);
> +	if (rc)
> +		goto out;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	rc = cxl_region_attach(cxlr, cxled, 0);
> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (rc)
> +		goto out;
> +
> +	rc = cxl_region_decode_commit(cxlr);
> +	if (rc)
> +		goto out;
> +
> +	p = &cxlr->params;
> +	p->state = CXL_CONFIG_COMMIT;
> +out:

I'd break out a separate error handling path and
just duplicate the next line.

> +	construct_region_end();
> +	if (rc) {
> +		drop_region(cxlr);
> +		return ERR_PTR(rc);
> +	}
> +	return cxlr;
> +}

