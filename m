Return-Path: <netdev+bounces-154194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B9C9FC05F
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 17:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20A118845CB
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 16:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3AE212B10;
	Tue, 24 Dec 2024 16:35:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32FE2AE6C;
	Tue, 24 Dec 2024 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735058158; cv=none; b=YjRMa6ZqU4ry9PQSCBmtOKQefQMhh1l1o+Pp9UaUhHJtX9rwJRgUoT8AZJ+PDtOzFAdcngePp1M4HDgL6xEEa42/4G/IwJva9t7T69M4IIyhp9jXZIWrHsrBycBjhrfYd2crBMVsJvMR8bUCtG8+FdsyTy5WtAgLYyY5S7TX1tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735058158; c=relaxed/simple;
	bh=EHHACquJO1sO3cz+AUfVD0o6Bg51bgbcGmeoIYBIipM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4thx/MJZQ5obm7k/FgJSwj7sL/swesbtpM6iJUOYCupNGyIGLGbC75QssdJzZH+tbgaePcbI9AFoaE5x9KcsH6a8w3MEXPuX4i7Q0Kegxd0bfq/7VKYrAuQtJlVYZ+sg9LTC+zPGPvxORh2h+Uf+cdIl+ExkHHjBdrrEZ1kGqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHgTW6d97z6L6xf;
	Wed, 25 Dec 2024 00:34:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 744AE140133;
	Wed, 25 Dec 2024 00:35:53 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 17:35:52 +0100
Date: Tue, 24 Dec 2024 16:35:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>, Alejandro
 Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 01/27] cxl: add type2 device basic support
Message-ID: <20241224163549.00006154@huawei.com>
In-Reply-To: <20241216161042.42108-2-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
	<20241216161042.42108-2-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 16 Dec 2024 16:10:16 +0000
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differentiate CXL memory expanders (type 3) from CXL device accelerators
> (type 2) with a new function for initializing cxl_dev_state.
> 
> Create accessors to cxl_dev_state to be used by accel drivers.
> 
> Based on previous work by Dan Williams [1]
> 
> Link: [1] https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>

Hi, I've missed a few versions due to busy end of year.
Anyhow, catch up day!

A few comments inline - with those tweaked (or ignored for the "meh"
one :)
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> new file mode 100644
> index 000000000000..19e5d883557a
> --- /dev/null
> +++ b/include/cxl/cxl.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
> +
> +#ifndef __CXL_H
> +#define __CXL_H
> +
> +#include <linux/ioport.h>
> +
> +enum cxl_resource {
> +	CXL_RES_DPA,
> +	CXL_RES_RAM,
> +	CXL_RES_PMEM,
> +};
Need a few forwards defs to avoid chance of future header reorg
biting you.

struct cxl_dev_state;
struct device;
Should do I think.

> +
> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
> +
> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> +		     enum cxl_resource);
> +#endif
> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> new file mode 100644
> index 000000000000..ad63560caa2c
> --- /dev/null
> +++ b/include/cxl/pci.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +
> +#ifndef __CXL_ACCEL_PCI_H
> +#define __CXL_ACCEL_PCI_H
> +
> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> +#define CXL_DVSEC_PCIE_DEVICE					0
> +#define   CXL_DVSEC_CAP_OFFSET		0xA
> +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
> +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> +#define   CXL_DVSEC_CTRL_OFFSET		0xC
> +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + ((i) * 0x10))
> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + ((i) * 0x10))

The brackets around the multiplication seem like overkill but meh,
they are harmless :)

> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
> +
> +#endif


