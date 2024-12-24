Return-Path: <netdev+bounces-154210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFD29FC118
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 18:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1FB165B5F
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 17:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EAE1FF7AC;
	Tue, 24 Dec 2024 17:53:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550126ACB;
	Tue, 24 Dec 2024 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735062814; cv=none; b=J69zGd0NGIGjKV1RH8l5Ufm/EKw2TMk7wy1/cJupDQzKCKp2SptBfsCmk1u/QDGDuy38SC8P36xOs3GHmaNzPVm8KkN0ZJOZKfRYmIIxVYLmepgr080Gvgyvxij+yIqBlAcHSW6oWN5uWfAPrLeFt21cPzoyScTwFy5TU9MMO0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735062814; c=relaxed/simple;
	bh=Ec9Ii/gRBoaDU/G4wKXMriguZxD+WBVZ945HIJJGpy4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wm6hNHr17kLmePDE37eMqG/X9r+7rFphAZB0W0wRphWZFoXuRPyQhiFpR4rCdGbY91/vQqD18DJZLip4Hnv1NYmbfFsX+gP+1qgDYKN66gGKWPPvdEQxEGMTStrDZ5pNCVQovqxQRnDEWvBYkgInW/J1zs+1H/DhU/wgjhj08ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHjC2724Lz6L6xf;
	Wed, 25 Dec 2024 01:52:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9548E140736;
	Wed, 25 Dec 2024 01:53:28 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 18:53:27 +0100
Date: Tue, 24 Dec 2024 17:53:24 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>, Alejandro
 Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 17/27] cxl: define a driver interface for DPA
 allocation
Message-ID: <20241224175324.00001cad@huawei.com>
In-Reply-To: <20241216161042.42108-18-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
	<20241216161042.42108-18-alejandro.lucero-palau@amd.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 16 Dec 2024 16:10:32 +0000
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation involves finding available DPA (device-physical-address)
> capacity to map into HPA (host-physical-address) space. Given the HPA
> capacity constraint, define an API, cxl_request_dpa(), that has the
> flexibility to  map the minimum amount of memory the driver needs to

Bonus space before map.

> operate vs the total possible that can be mapped given HPA availability.
> 
> Factor out the core of cxl_dpa_alloc, that does free space scanning,
> into a cxl_dpa_freespace() helper, and use that to balance the capacity
> available to map vs the @min and @max arguments to cxl_request_dpa.
> 
> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Comments inline.

> ---
>  drivers/cxl/core/hdm.c | 154 +++++++++++++++++++++++++++++++++++------
>  include/cxl/cxl.h      |   5 ++
>  2 files changed, 138 insertions(+), 21 deletions(-)
> 

> +int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> +{
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct device *dev = &cxled->cxld.dev;
> +	resource_size_t start, avail, skip;
> +	int rc;
> +
> +	down_write(&cxl_dpa_rwsem);
> +	if (cxled->cxld.region) {
> +		dev_dbg(dev, "EBUSY, decoder attached to %s\n",
> +			dev_name(&cxled->cxld.region->dev));
> +		rc = -EBUSY;
> +		goto out;
> +	}
> +
> +	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
> +		dev_dbg(dev, "EBUSY, decoder enabled\n");
> +		rc = -EBUSY;
>  		goto out;
>  	}
>  
> +	avail = cxl_dpa_freespace(cxled, &start, &skip);
> +
>  	if (size > avail) {
>  		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
> -			cxl_decoder_mode_name(cxled->mode), &avail);
> +			     cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
This is reverting an earlier change. I guess accidental?

> +			     &avail);
>  		rc = -ENOSPC;
>  		goto out;
>  	}
> @@ -538,6 +557,99 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }

> +/**
> + * cxl_request_dpa - search and reserve DPA given input constraints
> + * @cxlmd: memdev with an endpoint port with available decoders
> + * @is_ram: DPA operation mode (ram vs pmem)
> + * @min: the minimum amount of capacity the call needs
> + * @max: extra capacity to allocate after min is satisfied

Includes the extra capacity. Otherwise capacity allocated as documented
is min + max which seems unlikely.

> + *
> + * Given that a region needs to allocate from limited HPA capacity it
> + * may be the case that a device has more mappable DPA capacity than
> + * available HPA. So, the expectation is that @min is a driver known
> + * value for how much capacity is needed, and @max is based the limit of
> + * how much HPA space is available for a new region.
> + *
> + * Returns a pinned cxl_decoder with at least @min bytes of capacity
> + * reserved, or an error pointer. The caller is also expected to own the
> + * lifetime of the memdev registration associated with the endpoint to
> + * pin the decoder registered as well.
> + */
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
> +					     bool is_ram,
> +					     resource_size_t min,
> +					     resource_size_t max)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	enum cxl_decoder_mode mode;
> +	struct device *cxled_dev;
> +	resource_size_t alloc;
> +	int rc;
> +
> +	if (!IS_ALIGNED(min | max, SZ_256M))
> +		return ERR_PTR(-EINVAL);
> +
> +	down_read(&cxl_dpa_rwsem);
> +	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (!cxled_dev)
> +		cxled = ERR_PTR(-ENXIO);
	if (!cxled_dev)
		return ERR_PTR(-ENXIO);

	cxled = to...
	if (!cxled) //assuming this has any way to fail in which 
case I think you would need to put the device...
		put_device(cxled_dev);
		return NULL;

Though do you actualy want to return an error in this case?

> +	else
> +		cxled = to_cxl_endpoint_decoder(cxled_dev);
> +
> +	if (!cxled || IS_ERR(cxled))
> +		return cxled;
Drop this with changes above.

> +
> +	if (is_ram)
> +		mode = CXL_DECODER_RAM;
> +	else
> +		mode = CXL_DECODER_PMEM;
> +
> +	rc = cxl_dpa_set_mode(cxled, mode);
> +	if (rc)
> +		goto err;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	alloc = cxl_dpa_freespace(cxled, NULL, NULL);
> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (max)
> +		alloc = min(max, alloc);
> +	if (alloc < min) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}
> +
> +	rc = cxl_dpa_alloc(cxled, alloc);
> +	if (rc)
> +		goto err;
> +
> +	return cxled;
> +err:
> +	put_device(cxled_dev);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");

