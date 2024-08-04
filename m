Return-Path: <netdev+bounces-115566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2E494703C
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 20:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C556B20D43
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 18:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5D41EEFC;
	Sun,  4 Aug 2024 18:07:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282B413A3E6;
	Sun,  4 Aug 2024 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722794849; cv=none; b=FJgj+dp3C+4e/VCAKFOy+yQuGsSDOLbCzPWYYdfpkaOe2dVkpJPoUmhJmifJ3euh4Qwy2Kxuo7uxzXYGmgzc/h+xTLgNlq7YGWh1oIxHvcJfirI6/x1swDOynIl1OzMRdPz9Z/HcSsPl+3eQxmnq6P7Y4KQUC6yEfKF5JnR/coo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722794849; c=relaxed/simple;
	bh=r4of5t/kADTJHJltqPb4kalaWEqLSKW6WheXLsyAl8k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqlIs/O8Na2vRMd2cpK7wtuODR9tdfD9ALBaVwQcdLllKiKQsGc4l5TFHQQ3d1+9QSiGetSZ3UkUYbC+UOEMq2Mifr8FCJu4I9tObaR5vyegWyEyRZChXN5AlIuBeqvhQkywBd1+GKbEaWXuv1cB5bRDiwEIjxzdypcwWj3cxTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WcSCS5Dhvz6K5cH;
	Mon,  5 Aug 2024 02:05:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D5801140C72;
	Mon,  5 Aug 2024 02:07:19 +0800 (CST)
Received: from localhost (10.195.244.131) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 4 Aug
 2024 19:07:19 +0100
Date: Sun, 4 Aug 2024 19:07:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 10/15] cxl: define a driver interface for DPA
 allocation
Message-ID: <20240804190718.0000361c@Huawei.com>
In-Reply-To: <20240715172835.24757-11-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-11-alejandro.lucero-palau@amd.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 15 Jul 2024 18:28:30 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation involves finding available DPA (device-physical-address)
> capacity to map into HPA (host-physical-address) space. Given the HPA
> capacity constraint, define an API, cxl_request_dpa(), that has the
> flexibility to  map the minimum amount of memory the driver needs to
> operate vs the total possible that can be mapped given HPA availability.
> 
> Factor out the core of cxl_dpa_alloc, that does free space scanning,
> into a cxl_dpa_freespace() helper, and use that to balance the capacity
> available to map vs the @min and @max arguments to cxl_request_dpa.
> 
> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m4271ee49a91615c8af54e3ab20679f8be3099393
> 
Use the permalink link under these to get shorter links.
https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
goes to the same patch.


> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>


> +
> +int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> +{
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct device *dev = &cxled->cxld.dev;
> +	resource_size_t start, avail, skip;
> +	int rc;
> +
> +	down_write(&cxl_dpa_rwsem);

Some cleanup.h magic would help here by allowing early returns.
Needs the scoped lock though to ensure it's released before the
devm_add_action_or_reset() as I'd guess we will deadlock otherwise
if that fails.

> +	if (cxled->cxld.region) {
> +		dev_dbg(dev, "EBUSY, decoder attached to %s\n",
> +			     dev_name(&cxled->cxld.region->dev));
> +		rc = -EBUSY;
>  		goto out;
>  	}
>  
> +	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
> +		dev_dbg(dev, "EBUSY, decoder enabled\n");
> +		rc = -EBUSY;
> +		goto out;
> +	}
> +
> +	avail = cxl_dpa_freespace(cxled, &start, &skip);
> +
>  	if (size > avail) {
>  		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
> -			cxl_decoder_mode_name(cxled->mode), &avail);
> +			     cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
> +			     &avail);
>  		rc = -ENOSPC;
>  		goto out;
>  	}
> @@ -550,6 +570,99 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> +static int find_free_decoder(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	port = cxled_to_port(cxled);
> +
> +	if (cxled->cxld.id != port->hdm_end + 1) {
> +		return 0;

No brackets

> +	}
> +	return 1;
> +}
> +
> +/**
> + * cxl_request_dpa - search and reserve DPA given input constraints
> + * @endpoint: an endpoint port with available decoders
> + * @mode: DPA operation mode (ram vs pmem)
> + * @min: the minimum amount of capacity the call needs
> + * @max: extra capacity to allocate after min is satisfied
> + *
> + * Given that a region needs to allocate from limited HPA capacity it
> + * may be the case that a device has more mappable DPA capacity than
> + * available HPA. So, the expectation is that @min is a driver known
> + * value for how much capacity is needed, and @max is based the limit of
> + * how much HPA space is available for a new region.
We are going to need a policy control on the max value.
Otherwise, if you have two devices that support huge capacity and
not enough space, who gets it will just be a race.

Not a problem for now though!

> + *
> + * Returns a pinned cxl_decoder with at least @min bytes of capacity
> + * reserved, or an error pointer. The caller is also expected to own the
> + * lifetime of the memdev registration associated with the endpoint to
> + * pin the decoder registered as well.
> + */




