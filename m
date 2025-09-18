Return-Path: <netdev+bounces-224461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EECFB854B1
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADF1169FC0
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3613721FF28;
	Thu, 18 Sep 2025 14:35:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385FF1714B7;
	Thu, 18 Sep 2025 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206119; cv=none; b=Z7zLfNy6h86+7t/HPRroj8sQWWeFpIUCfX7b6bVttP0h6hcdKgx4abjc0IH6NTz/Hx7e/O4+6sWHa94M+i0sSv9AJKC1lTqRBW6wnCdqs5k8wwi+ACTvBASF8AbbZ+drsuget3dChR0+71qAszRFSvjMnSykfwBFMbNRs/enia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206119; c=relaxed/simple;
	bh=VIfbwCXNDWDtTlUVZsn0jjASoSkdpxOCjZdzdj1LESQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7FLBNAP4d3ztd0cEud+ZEjISj7+wXxBjiu8x1B3zX2+K+Y4AiwWRrKoyVI/fvEA23Abbfht+q1pfYhnt2YepqYEr/VW6KIVlF1Xlm22qumEBVPX+6PJN6+y427Bl+TrJZJTLWDHWI4Keltzg+U+I+WghASRNQ9obfIeSM+Jrpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cSJ635XHDz6GDDt;
	Thu, 18 Sep 2025 22:33:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AD5291400C8;
	Thu, 18 Sep 2025 22:35:07 +0800 (CST)
Received: from localhost (10.47.69.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Sep
 2025 16:35:07 +0200
Date: Thu, 18 Sep 2025 15:35:03 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v18 09/20] cxl: Define a driver interface for HPA free
 space enumeration
Message-ID: <20250918153503.00004800@huawei.com>
In-Reply-To: <20250918091746.2034285-10-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
	<20250918091746.2034285-10-alejandro.lucero-palau@amd.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 18 Sep 2025 10:17:35 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> CXL region creation involves allocating capacity from Device Physical Address
> (DPA) and assigning it to decode a given Host Physical Address (HPA). Before
> determining how much DPA to allocate the amount of available HPA must be
> determined. Also, not all HPA is created equal, some HPA targets RAM, some
> targets PMEM, some is prepared for device-memory flows like HDM-D and HDM-DB,
> and some is HDM-H (host-only).
> 
> In order to support Type2 CXL devices, wrap all of those concerns into
> an API that retrieves a root decoder (platform CXL window) that fits the
> specified constraints and the capacity available for a new region.
> 
> Add a complementary function for releasing the reference to such root
> decoder.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Either I was half asleep or a few things have snuck in.

See below.

> +
> +/**
> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
> + * @endpoint: the endpoint requiring the HPA

The parameter seems to have changed.  Make sure to point scripts/kernel-doc at each
file to check for stuff like this.

> + * @interleave_ways: number of entries in @host_bridges
> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
> + * @max_avail_contig: output parameter of max contiguous bytes available in the
> + *		      returned decoder
> + *
> + * Returns a pointer to a struct cxl_root_decoder
> + *
> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
> + * caller goes to use this root decoder's capacity the capacity is reduced then
> + * caller needs to loop and retry.
> + *
> + * The returned root decoder has an elevated reference count that needs to be
> + * put with cxl_put_root_decoder(cxlrd).
> + */
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max_avail_contig)
> +{
> +	struct cxl_root *root __free(put_cxl_root) = NULL;

Nope to this.  See the stuff in cleanup.h on why not.

> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxlrd_max_context ctx = {
> +		.host_bridges = &endpoint->host_bridge,
> +		.flags = flags,
> +	};
> +	struct cxl_port *root_port;
> +
> +	if (!endpoint) {
> +		dev_dbg(&cxlmd->dev, "endpoint not linked to memdev\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	root  = find_cxl_root(endpoint);

extra space, but should be 
	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
anyway.

> +	if (!root) {
> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	root_port = &root->port;
> +	scoped_guard(rwsem_read, &cxl_rwsem.region)
> +		device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
> +
> +	if (!ctx.cxlrd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*max_avail_contig = ctx.max_hpa;
> +	return ctx.cxlrd;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
> +
> +/*
> + * TODO: those references released here should avoid the decoder to be
> + * unregistered.

That is an ominous sounding TODO for a v18.  Perhaps add more on why this
is still here. 

> + */
> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd)
> +{
> +	put_device(cxlrd_dev(cxlrd));
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_put_root_decoder, "CXL");



