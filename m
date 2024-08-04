Return-Path: <netdev+bounces-115568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B05947041
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 20:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885071C209FA
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 18:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D831EF1D;
	Sun,  4 Aug 2024 18:29:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B048493;
	Sun,  4 Aug 2024 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722796172; cv=none; b=ExjvCZG6xMxafkHRcuGcUR5z5JG8vNGOA2r0LxznuNzf8i5fdN/izRuHMKeUBIbeYAfCxNX1sfVo0BzcJ32H2cSDbLDuBPN8SEWYwMTE2/pS729hx7F0XgmkLoO+CwbbjTEz0bsF4jIBZCuRtDCXm2XhjZ6zYEGkhNLZPiaxBN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722796172; c=relaxed/simple;
	bh=rQ9ZDKKrKTgcOEE4cWsxb9zo6VTWo0G8/ILTLbcJoCw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQYoh82iu7Um04Zar2mobb32Z/PeOsaq/yqpL20FRlbCjxv9VsDtyzGYbIDnZTFiRkyhRdgR2InnYdyxVOTGc4V2rBP05xYPJQjg+s7llVe3hKLdXYuRVcmvjMc3FLBwhgKCQEyvbjE7J1eWp19l+BM89VjPI0EwskSiwRs5CiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WcShK5vWhz6K5pj;
	Mon,  5 Aug 2024 02:26:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D376E140C72;
	Mon,  5 Aug 2024 02:29:26 +0800 (CST)
Received: from localhost (10.195.244.131) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 4 Aug
 2024 19:29:26 +0100
Date: Sun, 4 Aug 2024 19:29:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 12/15] cxl: allow region creation by type2 drivers
Message-ID: <20240804192923.000035bd@Huawei.com>
In-Reply-To: <20240715172835.24757-13-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-13-alejandro.lucero-palau@amd.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 15 Jul 2024 18:28:32 +0100
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
> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m84598b534cc5664f5bb31521ba6e41c7bc213758
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Needs a co-developed or similar given Dan didn't email this patch
(which this sign off list suggests he did).

I'll take another look at the locking, but my main comment is
that it is really confusing so I have no idea if it's right.
Consider different ways of breaking up the code you need
to try and keep the locking obvious.

Jonathan

> +
> +static ssize_t interleave_ways_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	unsigned int val;
> +	int rc;
> +
> +	rc = kstrtouint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	rc = down_write_killable(&cxl_region_rwsem);
> +	if (rc)
> +		return rc;
> +
> +	rc = set_interleave_ways(cxlr, val);
>  	up_write(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
>  	return len;
>  }
> +
This was probably intentional. Common to group a macro like this
with the function it is using by not having a blank line.
>  static DEVICE_ATTR_RW(interleave_ways);
>  
>  static ssize_t interleave_granularity_show(struct device *dev,
> @@ -547,21 +556,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
>  	return rc;
>  }

> +static ssize_t interleave_granularity_store(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	int rc, val;
> +
> +	rc = kstrtoint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
>  	rc = down_write_killable(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
> -	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
> -		rc = -EBUSY;
> -		goto out;
> -	}
>  
> -	p->interleave_granularity = val;
> -out:
> +	rc = set_interleave_granularity(cxlr, val);
>  	up_write(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
>  	return len;
>  }
> +

grump.

>  static DEVICE_ATTR_RW(interleave_granularity);

> +/* Establish an empty region covering the given HPA range */
> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> +					   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct range *hpa = &cxled->cxld.hpa_range;
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +	struct resource *res;
> +	int rc;
> +
> +	cxlr = construct_region_begin(cxlrd, cxled);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
>  
>  	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
>  
>  	res = kmalloc(sizeof(*res), GFP_KERNEL);
>  	if (!res) {
>  		rc = -ENOMEM;
> -		goto err;
> +		goto out;
>  	}
>  
>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>  				    dev_name(&cxlr->dev));
> +
>  	rc = insert_resource(cxlrd->res, res);
>  	if (rc) {
>  		/*
> @@ -3412,6 +3462,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  			 __func__, dev_name(&cxlr->dev));
>  	}
>  
> +	p = &cxlr->params;
>  	p->res = res;
>  	p->interleave_ways = cxled->cxld.interleave_ways;
>  	p->interleave_granularity = cxled->cxld.interleave_granularity;
> @@ -3419,24 +3470,124 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
> +				   dev_name(&cxlr->dev), p->res,
> +				   p->interleave_ways,
> +				   p->interleave_granularity);
>  
>  	/* ...to match put_device() in cxl_add_to_region() */
>  	get_device(&cxlr->dev);
>  	up_write(&cxl_region_rwsem);
> +out:
> +	construct_region_end();

two calls to up_write(&cxl_region_rwsem) next to each other?

> +	if (rc) {
> +		drop_region(cxlr);
> +		return ERR_PTR(rc);
> +	}
> +	return cxlr;
> +}
> +
> +static struct cxl_region *
> +__construct_new_region(struct cxl_root_decoder *cxlrd,
> +		       struct cxl_endpoint_decoder **cxled, int ways)
> +{
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> +	struct cxl_region_params *p;
> +	resource_size_t size = 0;
> +	struct cxl_region *cxlr;
> +	int rc, i;
> +
> +	/* If interleaving is not supported, why does ways need to be at least 1? */

I think 1 means no interleave. It's simpler to do this than have 0 and 1 both 
mean no interleave because 1 works for programmable decoders.

> +	if (ways < 1)
> +		return ERR_PTR(-EINVAL);
> +
> +	cxlr = construct_region_begin(cxlrd, cxled[0]);

rethink how this broken up.  Taking the cxl_dpa_rwsem
inside this function and is really hard to follow.  Ideally
manage it with scoped_guard()


> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +
> +	rc = set_interleave_ways(cxlr, ways);
> +	if (rc)
> +		goto out;
> +
> +	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
> +	if (rc)
here I think cxl_dpa_rwsem is held.
> +		goto out;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	for (i = 0; i < ways; i++) {
> +		if (!cxled[i]->dpa_res)
> +			break;
> +		size += resource_size(cxled[i]->dpa_res);
> +	}
> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (i < ways)

but not here and they go to the same place.

> +		goto out;
> +
> +	rc = alloc_hpa(cxlr, size);
> +	if (rc)
> +		goto out;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	for (i = 0; i < ways; i++) {
> +		rc = cxl_region_attach(cxlr, cxled[i], i);
> +		if (rc)
> +			break;
> +	}
> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (rc)
> +		goto out;
> +
> +	rc = cxl_region_decode_commit(cxlr);
> +	if (rc)
> +		goto out;
>  
> +	p = &cxlr->params;
> +	p->state = CXL_CONFIG_COMMIT;
> +out:
> +	construct_region_end();
> +	if (rc) {
> +		drop_region(cxlr);
> +		return ERR_PTR(rc);
> +	}
>  	return cxlr;
> +}

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index a0e0795ec064..377bb3cd2d47 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -881,5 +881,7 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
>  					       int interleave_ways,
>  					       unsigned long flags,
>  					       resource_size_t *max);
> -
Avoid whitespace noise.

> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder **cxled,
> +				     int ways);
>  #endif /* __CXL_MEM_H__ */

