Return-Path: <netdev+bounces-224469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F124B855BA
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33EF3A60BD
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2176306B28;
	Thu, 18 Sep 2025 14:52:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8876A2D322C;
	Thu, 18 Sep 2025 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207151; cv=none; b=D+WqFYNUwjVktuomvb6lI4L0eKQ9brdi3trpA8Li7CprMc27xOBorE6eZ+QHTuFqYt+bAEc03H17rn944BRkkTAj1OlFIGpQl2XeqDoqSQKjmS4Gvwg8TYNoitz0Oroum3owJjp1HjzPcFLpiWozUyYSPxvSwWX2La0XImm200o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207151; c=relaxed/simple;
	bh=LrYZ0PtGj44iHaLhXoD2DWvCaG4J1kMF1c/bf9IlQQo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7HBlhCwWudlsMyKHtueyPTpPH1eGY2JRxT8k6fRZUdc/6zORwvmy7S+sIbAsa3WteyFnlfX/ibQFCoUgv87pqNnVjXk5XZqG5MBB2RQRqwjh9DJ2ath5nAvFdSlmoYhbo4F594OrLM1ifprnMP90KgyJOvCHx5Oa8VcLvy/oec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cSJQZ3jHqz6K63M;
	Thu, 18 Sep 2025 22:47:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CD971402F5;
	Thu, 18 Sep 2025 22:52:26 +0800 (CST)
Received: from localhost (10.47.69.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Sep
 2025 16:52:25 +0200
Date: Thu, 18 Sep 2025 15:52:22 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v18 11/20] cxl: Define a driver interface for DPA
 allocation
Message-ID: <20250918155222.00003bdb@huawei.com>
In-Reply-To: <20250918091746.2034285-12-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
	<20250918091746.2034285-12-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 18 Sep 2025 10:17:37 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation involves finding available DPA (device-physical-address)
> capacity to map into HPA (host-physical-address) space.
> 
> In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
> that tries to allocate the DPA memory the driver requires to operate.The
> memory requested should not be bigger than the max available HPA obtained
> previously with cxl_get_hpa_freespace().
> 
> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

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
> +					cxl_find_free_decoder(cxlmd);
I've no idea where this style comes from. Local style in this file seems to be
the more common (I think?)
	struct cxl_endpoint_decoder *cxled __free(put_cxled) =
		cxl_find_free_decoder(cxlmd);

> +	int rc;
> +
> +	if (!IS_ALIGNED(alloc, SZ_256M))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!cxled)
> +		return ERR_PTR(-ENODEV);
> +
> +	rc = cxl_dpa_set_part(cxled, mode);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	rc = cxl_dpa_alloc(cxled, alloc);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	return no_free_ptr(cxled);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");



