Return-Path: <netdev+bounces-139117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0BE9B0480
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3431F23FEB
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 13:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995F7139D04;
	Fri, 25 Oct 2024 13:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40B54A1B;
	Fri, 25 Oct 2024 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864224; cv=none; b=nhG54AxrCzpi8K1gX8kJHRZHjclRGdcVFEAzH+V7cyQ0yVKTDFo5gw9DFB2kg1cNemoSxdXujRgrfhtzLnw9q2/QOgUjhFO/63VE0AZLEfEM18MlVdYAHYLoLf6bH8ea7pWVDWG+pNOX8aZLyasiIZt31h3Le/ulT8hRSt0FUGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864224; c=relaxed/simple;
	bh=ca3lspRoDIQs+M0+tz7gWcjJnUTqqxG88tpJs1C60QQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+BSCt3lLmV0H01jCvoaDGT4/2aolCBl+HVpmp5YUjAXe3pU3WglW+2DMuI80hYQFeXlpxRCF4ec5hjLzfTZVH1FrutAXKaauYZNxvvIqEznsseDsoaFYpHKb4bggg4Mipd6H1O0gY9v3lc6jp4avjVCvsFIZrZhogxg5tQ8xWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZkd12wG9z6K6JY;
	Fri, 25 Oct 2024 21:48:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 11A3E1400F4;
	Fri, 25 Oct 2024 21:50:15 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Oct
 2024 15:50:14 +0200
Date: Fri, 25 Oct 2024 14:50:12 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v4 01/26] cxl: add type2 device basic support
Message-ID: <20241025145012.00002d64@Huawei.com>
In-Reply-To: <20241017165225.21206-2-alejandro.lucero-palau@amd.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
	<20241017165225.21206-2-alejandro.lucero-palau@amd.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Oct 2024 17:52:00 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differentiate Type3, aka memory expanders, from Type2, aka device
> accelerators, with a new function for initializing cxl_dev_state.
> 
> Create accessors to cxl_dev_state to be used by accel drivers.
> 
> Based on previous work by Dan Williams [1]
> 
> Link: [1] https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Hi Alejandro,

A couple of trivial comments inline on things that that would be good to tidy up.

> ---
>  drivers/cxl/core/memdev.c | 52 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/pci.c    |  1 +
>  drivers/cxl/cxlpci.h      | 16 ------------
>  drivers/cxl/pci.c         | 13 +++++++---
>  include/linux/cxl/cxl.h   | 21 ++++++++++++++++
>  include/linux/cxl/pci.h   | 23 +++++++++++++++++
>  6 files changed, 106 insertions(+), 20 deletions(-)
>  create mode 100644 include/linux/cxl/cxl.h
>  create mode 100644 include/linux/cxl/pci.h
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 0277726afd04..94b8a7b53c92 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c

> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> +		     enum cxl_resource type)
> +{
> +	switch (type) {
> +	case CXL_RES_DPA:
> +		cxlds->dpa_res = res;
> +		return 0;
> +	case CXL_RES_RAM:
> +		cxlds->ram_res = res;
> +		return 0;
> +	case CXL_RES_PMEM:
> +		cxlds->pmem_res = res;
> +		return 0;
> +	}
> +
> +	dev_err(cxlds->dev, "unknown resource type (%u)\n", type);

Given it's an enum and only enum values are ever passed to it, we should never
get here as they are all handled above.

So maybe drop?  Then if an another type is added we will get a build
warning.

> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
> +
>  static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>  {
>  	struct cxl_memdev *cxlmd =

> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> new file mode 100644
> index 000000000000..c06ca750168f
> --- /dev/null
> +++ b/include/linux/cxl/cxl.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
> +
> +#ifndef __CXL_H
> +#define __CXL_H
> +
> +#include <linux/device.h>

I'd avoid this if possible and use a forwards definition for
struct device;
Also needed for 
struct cxl_dev_state;
And an include needed for linux/ioport.h for the struct
resource.


> +
> +enum cxl_resource {
> +	CXL_RES_DPA,
> +	CXL_RES_RAM,
> +	CXL_RES_PMEM,
> +};
> +
> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
> +
> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> +		     enum cxl_resource);
> +#endif


