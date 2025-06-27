Return-Path: <netdev+bounces-201848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E532EAEB2FA
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E37857AE391
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 09:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F68514A82;
	Fri, 27 Jun 2025 09:32:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898D41DE2C9;
	Fri, 27 Jun 2025 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751016752; cv=none; b=Y8pOwCsK+pVHD81mmtcLM4VB+z5stPGvt+oxO4hoJzkc0ok36ZSLU7+5IKAeDKtLEY6lBvKh3wRZkUAAXZ00CcB/HAqndZfOtQrJ9imiHoJpaPUuEGhe5E6HFtGnrtT/XXf/hbea3M3CgCzc/UCCKZ2rNLR6l9lWiAc8q3MjfyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751016752; c=relaxed/simple;
	bh=1SQmu5PAB3emty92mrQ+ovRgDUkhWNNNVnMKaoyGwGU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/DRMtS4RY2JgBZp/tQzYtn21Hrx5EBe32aBbUXb16/YZsGEsLKjlr4yJ1CdWtJLLY7Bv14+4mT+HsmWb0p56Gbp7EvhrfFbT9Xu7MGE6rYvLgFRBX20fgEXPPPhiS8cSu5GpBOEF+tKlZTFGzvu52rWqIrllI6FVGC7KUkl+0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bT9Hx0kfMz6K99b;
	Fri, 27 Jun 2025 17:29:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 25DC314038F;
	Fri, 27 Jun 2025 17:32:27 +0800 (CST)
Received: from localhost (10.48.153.213) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 27 Jun
 2025 11:32:26 +0200
Date: Fri, 27 Jun 2025 10:32:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v17 18/22] cxl: Allow region creation by type2 drivers
Message-ID: <20250627103223.00007e43@huawei.com>
In-Reply-To: <20250624141355.269056-19-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
	<20250624141355.269056-19-alejandro.lucero-palau@amd.com>
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

On Tue, 24 Jun 2025 15:13:51 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Creating a CXL region requires userspace intervention through the cxl
> sysfs files. Type2 support should allow accelerator drivers to create
> such cxl region from kernel code.
> 
> Adding that functionality and integrating it with current support for
> memory expanders.
> 
> Support an action by the type2 driver to be linked to the created region
> for unwinding the resources allocated properly.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
One question in here for others (probably Dan). When does it makes sense to
manually request devm region cleanup and when should we let if flow out
as we are failing the CXL creation anyway and it's one of many things to
clean up if that happens.

> ---
>  drivers/cxl/core/region.c | 152 ++++++++++++++++++++++++++++++++++++--
>  drivers/cxl/port.c        |   5 +-
>  include/cxl/cxl.h         |   5 ++
>  3 files changed, 153 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 21cf8c11efe3..4ca5ade54ad9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2319,6 +2319,12 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>  	return rc;
>  }
>  
> +/**
> + * cxl_decoder_kill_region - detach a region from device
> + *
> + * @cxled: endpoint decoder to detach the region from.
> + *

Stray blank line.

> + */
>  void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>  {
>  	down_write(&cxl_region_rwsem);
> @@ -2326,6 +2332,7 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>  	cxl_region_detach(cxled);
>  	up_write(&cxl_region_rwsem);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_decoder_kill_region, "CXL");

> +/**
> + * cxl_create_region - Establish a region given an endpoint decoder
> + * @cxlrd: root decoder to allocate HPA
> + * @cxled: endpoint decoder with reserved DPA capacity
> + * @ways: interleave ways required
> + *
> + * Returns a fully formed region in the commit state and attached to the
> + * cxl_region driver.
> + */
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder **cxled,
> +				     int ways, void (*action)(void *),
> +				     void *data)
> +{
> +	struct cxl_region *cxlr;
> +
> +	scoped_guard(mutex, &cxlrd->range_lock) {
> +		cxlr = __construct_new_region(cxlrd, cxled, ways);
> +		if (IS_ERR(cxlr))
> +			return cxlr;
> +	}
> +
> +	if (device_attach(&cxlr->dev) <= 0) {
> +		dev_err(&cxlr->dev, "failed to create region\n");
> +		drop_region(cxlr);

I'm in two minds about this.  If we were to have wrapped the whole thing
up in a devres group and on failure (so carrying  on without cxl support)
we tidy that group up, then we'd not need to clean this up here.
However we do some local devm cleanup in construct_region today so maybe
keeping this local makes sense...  Dan, maybe you have a better view of
whether cleaning up here is sensible or not?

> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	if (action)
> +		devm_add_action_or_reset(&cxlr->dev, action, data);

This is a little odd looking (and can fail so should be error checkeD)
I'd push the devm registration to the caller.


> +
> +	return cxlr;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
> +
>  int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);


