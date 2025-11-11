Return-Path: <netdev+bounces-237641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7377EC4E4BB
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 15:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E4A189CA92
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96FC306B39;
	Tue, 11 Nov 2025 14:04:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5633AA195;
	Tue, 11 Nov 2025 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869854; cv=none; b=OR0rlnJBWOiA9JN8JPCRfeSGyQzHfG2w2OOQBwv7u8tJ8puTEah7lDDoQGjuq3yJaBGiCV3xyjcBFjqgGNrrQeeFlopQGK4EY9r3WCyRBl8IBRKWpru74F0+Sa44k0qXkH7KFQ08kPBLnV72F6zWwcsmdRPzcDDvhmkufrjLKuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869854; c=relaxed/simple;
	bh=oLEnxvvSaPexgS7NhMmrdnD/n/WjQ3Mj9OySRi7BuDk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRchWB3kWzsNi5RkV6OsmVLM3EWj5HrbqGtP6i+j/LCfatl1d09IdgDrqVLSt2JxJE+xfLIvXUYTU9q8IfHg0SdJPusw2ZbDzDGgR+p7Fo/rmhfkEIs1eaba49MiElOGPUGb9eevibx/vaekx1AbRLlRMO9xeotDbgAMKmjgx1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5Stv4BcZzHnGcR;
	Tue, 11 Nov 2025 22:03:51 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id C4E51140136;
	Tue, 11 Nov 2025 22:04:08 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 14:04:08 +0000
Date: Tue, 11 Nov 2025 14:04:06 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v19 18/22] cxl: Allow region creation by type2 drivers
Message-ID: <20251111140406.000026f6@huawei.com>
In-Reply-To: <5f09f8d3-5bc1-40a1-a9fa-1ffe14bf2eaa@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
	<20251006100130.2623388-19-alejandro.lucero-palau@amd.com>
	<20251007151143.0000744f@huawei.com>
	<5f09f8d3-5bc1-40a1-a9fa-1ffe14bf2eaa@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 10 Nov 2025 13:47:40 +0000
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 10/7/25 15:11, Jonathan Cameron wrote:
> > On Mon, 6 Oct 2025 11:01:26 +0100
> > <alejandro.lucero-palau@amd.com> wrote:
> >  
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> Creating a CXL region requires userspace intervention through the cxl
> >> sysfs files. Type2 support should allow accelerator drivers to create
> >> such cxl region from kernel code.
> >>
> >> Adding that functionality and integrating it with current support for
> >> memory expanders.
> >>
> >> Support an action by the type2 driver to be linked to the created region
> >> for unwinding the resources allocated properly.
> >>
> >> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> > One new question below (and a trivial thing beyond that).
> >
> > If you adopt one of the suggested ways of tidying that up, then keep the RB
> > if not I'll want to take another look so drop it.
> >  
> 
> I will drop your RB since it is not clear to me if your suggestion below 
> makes sense.
> 
> 
> >>   #ifdef CONFIG_CXL_REGION
> >>   extern struct device_attribute dev_attr_create_pmem_region;
> >>   extern struct device_attribute dev_attr_create_ram_region;
> >> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> >> index 26dfc15e57cd..e3b6d85cd43e 100644
> >> --- a/drivers/cxl/core/region.c
> >> +++ b/drivers/cxl/core/region.c
> >> +
> >> +/* Establish an empty region covering the given HPA range */
> >> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> >> +					   struct cxl_endpoint_decoder *cxled)
> >> +{
> >> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> >> +	struct cxl_region *cxlr;
> >> +	int rc;
> >> +
> >> +	cxlr = construct_region_begin(cxlrd, cxled);
> >>   
> >>   	rc = __construct_region(cxlr, cxlrd, cxled);
> >>   	if (rc) {
> >> @@ -3621,6 +3639,106 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> >>   	return cxlr;
> >>   }
> >>   
> >> +DEFINE_FREE(cxl_region_drop, struct cxl_region *, if (_T) drop_region(_T))
> >> +
> >> +static struct cxl_region *
> >> +__construct_new_region(struct cxl_root_decoder *cxlrd,
> >> +		       struct cxl_endpoint_decoder **cxled, int ways)  
> > Why pass in an array of struct cxl_endpoint_decoder * if this is only
> > ever going to use the first element?
> >
> > I think we need to indicate that somehow.  Could just pass in the
> > relevant decoder (I assume there is only one?)  Or pass the array
> > and an index (here 0).  
> 
> 
> Just the first one is use for creating the region, what means the 
> struct/object which will be initialised with the attaching phase later on.

OK. I think I now see what this is doing.

> 
> The region will be created with the target type and mode of the first 
> decoder used, but the attaching implies to check the other decoders 
> align with this. And all the decoders are used for that and for 
> calculating the hpa size to request.
I'd missed the indexing over decoders later in the function.

One minor thing inline noticed whilst walking through your explanation.
> 
> So I do not think there is a problem here, at least regarding your concern.
> 
> 
> >  
> >> +{
> >> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
> >> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> >> +	struct cxl_region_params *p;
> >> +	resource_size_t size = 0;
> >> +	int rc, i;
> >> +
> >> +	struct cxl_region *cxlr __free(cxl_region_drop) =
> >> +		construct_region_begin(cxlrd, cxled[0]);
> >> +	if (IS_ERR(cxlr))
> >> +		return cxlr;
> >> +
> >> +	guard(rwsem_write)(&cxl_rwsem.region);
> >> +
> >> +	/*
> >> +	 * Sanity check. This should not happen with an accel driver handling
> >> +	 * the region creation.
> >> +	 */
> >> +	p = &cxlr->params;
> >> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
> >> +		dev_err(cxlmd->dev.parent,
> >> +			"%s:%s: %s  unexpected region state\n",
> >> +			dev_name(&cxlmd->dev), dev_name(&cxled[0]->cxld.dev),
> >> +			__func__);
> >> +		return ERR_PTR(-EBUSY);
> >> +	}
> >> +
> >> +	rc = set_interleave_ways(cxlr, ways);
> >> +	if (rc)
> >> +		return ERR_PTR(rc);
> >> +
> >> +	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
> >> +	if (rc)
> >> +		return ERR_PTR(rc);
> >> +
> >> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
> >> +		for (i = 0; i < ways; i++) {
> >> +			if (!cxled[i]->dpa_res)
> >> +				break;
> >> +			size += resource_size(cxled[i]->dpa_res);
> >> +		}
> >> +		if (i < ways)
> >> +			return ERR_PTR(-EINVAL);
I'll try and remember to point this out in the v20 review, but
whilst I was looking at your reply here, I wondered why this isn't

		for (i = 0; i < ways; i++) {
			if (!cxled[i]->dpa_res)
				return ERR_PTR(-EINVAL);
			size += resource_size(cxled[i]->dpa_res);
		}

Given that's the only way we can get if (i < ways) true. The loop
has to have exited before the final post increment.

> >> +
> >> +		rc = alloc_hpa(cxlr, size);
> >> +		if (rc)
> >> +			return ERR_PTR(rc);
> >> +
> >> +		for (i = 0; i < ways; i++) {
> >> +			rc = cxl_region_attach(cxlr, cxled[i], 0);
> >> +			if (rc)
> >> +				return ERR_PTR(rc);
> >> +		}
> >> +	}
> >> +
> >> +	rc = cxl_region_decode_commit(cxlr);
> >> +	if (rc)
> >> +		return ERR_PTR(rc);
> >> +
> >> +	p->state = CXL_CONFIG_COMMIT;
> >> +
> >> +	return no_free_ptr(cxlr);  
> > return_ptr()  
> >> +}  
> 


