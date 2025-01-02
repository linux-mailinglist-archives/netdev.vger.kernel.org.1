Return-Path: <netdev+bounces-154754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9444F9FFADB
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 16:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5396188221B
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 15:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C896B1B415C;
	Thu,  2 Jan 2025 15:16:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5D61B423C;
	Thu,  2 Jan 2025 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735830962; cv=none; b=FhmwSrzdg/71Ver4j4P986Ay1kNAcyFt+qIT72SEk150+Zhn4ihi2DO6jDL+tZhfmZiLqWaoWiilvF5cv2pR8MjW0nDYINF5BmZlBCXyydoPHG+k91MCtO69UhLjqWPQ7KEZzK2mGWOu0djBA809rIM2OovV7FYYV/6N7w51bPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735830962; c=relaxed/simple;
	bh=wzf+sMOhlMnWJ7zynW5QOn4XvspvzZbpNDkgiV5dkEo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edODN/vFba/q9wWqlAsAo8Eyz35YzWTv7BAUQhBi/79/J2Z9Wa9KKMp5ZYW1KBJsVsCQ0jgpWJUyoVhyGn7YF5wf85ZRBIkC5pCXqY3BD8R1s5eLljK+GyUk24Vgbt5f92Bo83q1UIjFxKL07GMvH5bI7c6YdEegW3+lwU7eaUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YP9Hc55TSz6K6vF;
	Thu,  2 Jan 2025 23:15:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A8E78140A77;
	Thu,  2 Jan 2025 23:15:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 2 Jan
 2025 16:15:57 +0100
Date: Thu, 2 Jan 2025 15:15:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v9 17/27] cxl: define a driver interface for DPA
 allocation
Message-ID: <20250102151555.000072fd@huawei.com>
In-Reply-To: <20241230214445.27602-18-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
	<20241230214445.27602-18-alejandro.lucero-palau@amd.com>
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

On Mon, 30 Dec 2024 21:44:35 +0000
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation involves finding available DPA (device-physical-address)
> capacity to map into HPA (host-physical-address) space. Given the HPA
> capacity constraint, define an API, cxl_request_dpa(), that has the
> flexibility to map the minimum amount of memory the driver needs to
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

A couple of really minor things inline. Either way

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> +/**
> + * cxl_request_dpa - search and reserve DPA given input constraints
> + * @cxlmd: memdev with an endpoint port with available decoders
> + * @is_ram: DPA operation mode (ram vs pmem)
> + * @min: the minimum amount of capacity the call needs
> + * @max: HPA capacity available
> + *
> + * Given that a region needs to allocate from limited HPA capacity it
> + * may be the case that a device has more mappable DPA capacity than
> + * available HPA. So, the expectation is that @min is a driver known
> + * value for how much capacity is needed, and @max is based the limit of

is the limit? Not sure what the "is based" means


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
> +		return ERR_PTR(-ENXIO);
> +
> +	cxled = to_cxl_endpoint_decoder(cxled_dev);
> +
> +	if (!cxled) {
> +		put_device(cxled_dev);
> +		return ERR_PTR(-ENODEV);

Ah. My suggestion on v8 missed that there is an error block
below. More consistent with rest of the code as

		rc = -ENODEV;
		goto err;

> +	}
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



