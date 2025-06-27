Return-Path: <netdev+bounces-201823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB52AEB21D
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632EA56206E
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 09:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D5C295528;
	Fri, 27 Jun 2025 09:06:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C61829550F;
	Fri, 27 Jun 2025 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751015208; cv=none; b=c5b9wkVr6Suf8lgmgtuIiHOBuVCXmA+YOzLEkZNwo6lIdVaCDV+In/lyp5lu6GqPTlf3qYyuNv7pp5Vg4C7+VkbM2jlLF0w75SsvwG4QfZlLNDc+YbCdL5ZyVG6Vd/gknGIce9dKbajtAZDnhduPeanpSBTu+s8veUqwbMnrjTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751015208; c=relaxed/simple;
	bh=ZZG46HvlfGM/2p8zveWD6ysnP0vgSgCfJBB/mvCm1AA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mikwof9e9VIWOuk0ZcfxTBZymhs8ga2h9vjN1ucrv5XyqllT5EeHM3faI7mAtPSlO6dyZq0tYpNOP9BAMleX1WCwfJcrBdz6bOBLFcgE++TheNPFWvmvzs8zq4sfD678if3WExnE7c3cCczDcfv5AG4O7N9oxHYylHq9FehK+qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bT8kD54fbz6L5JM;
	Fri, 27 Jun 2025 17:04:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AED54140427;
	Fri, 27 Jun 2025 17:06:42 +0800 (CST)
Received: from localhost (10.48.153.213) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 27 Jun
 2025 11:06:41 +0200
Date: Fri, 27 Jun 2025 10:06:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH v17 13/22] cxl: Define a driver interface for DPA
 allocation
Message-ID: <20250627100638.0000456f@huawei.com>
In-Reply-To: <20250624141355.269056-14-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
	<20250624141355.269056-14-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 24 Jun 2025 15:13:46 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation involves finding available DPA (device-physical-address)
> capacity to map into HPA (host-physical-address) space.
> 
> In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
> that tries to allocate the DPA memory the driver requires to operate.The
> memory requested should not be bigger than the max available HPA obtained
> previously with cxl_get_hpa_freespace.
> 
> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hmm. I wouldn't trust this last guy not to have missed a few things.
See below.


> +static struct cxl_endpoint_decoder *
> +cxl_find_free_decoder(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct device *dev;
> +
> +	scoped_guard(rwsem_read, &cxl_dpa_rwsem) {
> +		dev = device_find_child(&endpoint->dev, NULL,
> +					find_free_decoder);
> +	}
> +	if (dev)
> +		return to_cxl_endpoint_decoder(dev);
> +
> +	return NULL;

If this code isn't going to get modified later, could be simpler as

	guard(rwsem_read)(&cxl_dpa_rwsem) {
	dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
	if (!dev)
		return NULL

	return to_cxl_endpoint_decoder(dev);
		
> +}
> +
> +/**
> + * cxl_request_dpa - search and reserve DPA given input constraints
> + * @cxlmd: memdev with an endpoint port with available decoders
> + * @mode: DPA operation mode (ram vs pmem)
> + * @alloc: dpa size required
> + *
> + * Returns a pointer to a cxl_endpoint_decoder struct or an error
> + *
> + * Given that a region needs to allocate from limited HPA capacity it
> + * may be the case that a device has more mappable DPA capacity than
> + * available HPA. The expectation is that @alloc is a driver known
> + * value based on the device capacity but it could not be available
> + * due to HPA constraints.
> + *
> + * Returns a pinned cxl_decoder with at least @alloc bytes of capacity
> + * reserved, or an error pointer. The caller is also expected to own the
> + * lifetime of the memdev registration associated with the endpoint to
> + * pin the decoder registered as well.
> + */
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
> +					     enum cxl_partition_mode mode,
> +					     resource_size_t alloc)
> +{
> +	struct cxl_endpoint_decoder *cxled __free(put_cxled) =
> +				cxl_find_free_decoder(cxlmd);
> +	struct device *cxled_dev;
> +	int rc;
> +
> +	if (!IS_ALIGNED(alloc, SZ_256M))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!cxled) {
> +		rc = -ENODEV;
> +		goto err;
> +	}
> +
> +	rc = cxl_dpa_set_part(cxled, mode);
> +	if (rc)
> +		goto err;
> +
> +	rc = cxl_dpa_alloc(cxled, alloc);
> +	if (rc)
> +		goto err;
> +
> +	return cxled;

I was kind of expecting us to disable the put above wuth a return_ptr()
here.  If there is a reason why not, add a comment as it is not obvious
to me anyway!


> +err:
> +	put_device(cxled_dev);

It's not been assigned.  I'm surprised if none of the standard tooling
(sparse, smatch etc screamed about this one).
For complex series like this it's worth running them on each patch just to
avoid possible bot warnings later!


> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
__CXL_CXL_H__ */


