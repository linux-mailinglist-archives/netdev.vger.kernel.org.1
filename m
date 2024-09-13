Return-Path: <netdev+bounces-128176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A550E9785FC
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 18:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B351C2214A
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 16:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897C8768E7;
	Fri, 13 Sep 2024 16:41:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B861E4D8BB;
	Fri, 13 Sep 2024 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726245689; cv=none; b=pwBSKBgtv1yyBXIOuPD14Mrz+S57IEDWJH7zSw1zdgbxouMvs64NjStygbhRk2EKqwxlVBeixY0cLIMyvcXZQtj0FE3dPb+th29mG6ABw27IN7oyUWC3uTmjtXBDT7bR1g+DUjsrRrl31Pq2kk54qX24S3BMLS96tSVsourPuGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726245689; c=relaxed/simple;
	bh=BDbBBqrzJmb7LnBDJnXOg+7UUzIDHNoPBhOCiNOIhIY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ly+GOP63KSkfrAbAM9oDfie+JoK8H0fol1GbbTgR1i4HHhFPAiw4jq2BjI0uLmUaLvo4jWXG6sqq/rr3cvAXGP7cRD71oTXUsf68TiRFjDA9IaNxgGAiUSPbf/4S1U3u8M/HjlT5Tlhly+u1Ut84brOXkF8Dph+F2MiAR8s5g88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X50N55hbfz6L6pc;
	Sat, 14 Sep 2024 00:37:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 18010140519;
	Sat, 14 Sep 2024 00:41:22 +0800 (CST)
Received: from localhost (10.126.174.208) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Sep
 2024 18:41:13 +0200
Date: Fri, 13 Sep 2024 17:41:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v3 01/20] cxl: add type2 device basic support
Message-ID: <20240913174103.000034ee@Huawei.com>
In-Reply-To: <20240907081836.5801-2-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-2-alejandro.lucero-palau@amd.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 7 Sep 2024 09:18:17 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>

Hi Alejandro,

I'm mainly looking at these to get my head back into this support
for discussions next week but will probably leave
lots of trivial review feedback as I go.

And to advertise that:
https://lpc.events/event/18/contributions/1828/

> 
> Differientiate Type3, aka memory expanders, from Type2, aka device

Spell check. Differentiate.

> accelerators, with a new function for initializing cxl_dev_state.
> 
> Create accessors to cxl_dev_state to be used by accel drivers.
> 
> Add SFC ethernet network driver as the client.
Minor thing (And others may disagree) but I'd split this to be nice
to others who might want to backport the type2 support but not
the sfc changes (as they are supporting some other hardware).
> 
> Based on https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
Maybe make that a link tag Link: .... # [1]
and have
Based on [1] here.

> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>


> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> +		     enum cxl_resource type)
> +{
> +	switch (type) {
> +	case CXL_ACCEL_RES_DPA:
> +		cxlds->dpa_res = res;
> +		return 0;
> +	case CXL_ACCEL_RES_RAM:
> +		cxlds->ram_res = res;
> +		return 0;
> +	case CXL_ACCEL_RES_PMEM:
> +		cxlds->pmem_res = res;
> +		return 0;
> +	default:
> +		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);

It's an enum, do we need the default?  Hence do we need the return value?

> +		return -EINVAL;
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
> +
>  static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>  {
>  	struct cxl_memdev *cxlmd =

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4be35dc22202..742a7b2a1be5 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -11,6 +11,8 @@
>  #include <linux/pci.h>
>  #include <linux/aer.h>
>  #include <linux/io.h>
> +#include <linux/cxl/cxl.h>
> +#include <linux/cxl/pci.h>
>  #include "cxlmem.h"
>  #include "cxlpci.h"
>  #include "cxl.h"
> @@ -795,6 +797,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	struct cxl_memdev *cxlmd;
>  	int i, rc, pmu_count;
>  	bool irq_avail;
> +	u16 dvsec;
>  
>  	/*
>  	 * Double check the anonymous union trickery in struct cxl_regs
> @@ -815,12 +818,14 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	pci_set_drvdata(pdev, cxlds);
>  
>  	cxlds->rcd = is_cxl_restricted(pdev);
> -	cxlds->serial = pci_get_dsn(pdev);
> -	cxlds->cxl_dvsec = pci_find_dvsec_capability(
> -		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
> -	if (!cxlds->cxl_dvsec)
> +	cxl_set_serial(cxlds, pci_get_dsn(pdev));
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +	if (!dvsec)
>  		dev_warn(&pdev->dev,
>  			 "Device DVSEC not present, skip CXL.mem init\n");
> +	else
> +		cxl_set_dvsec(cxlds, dvsec);

Set it unconditionally perhaps.  If it's NULL that's fine and then it corresponds
directly to the previous 

>  
>  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>  	if (rc)

> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index 6f1a01ded7d4..3a7406aa950c 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -33,6 +33,7 @@
>  #include "selftest.h"
>  #include "sriov.h"
>  #include "efx_devlink.h"
> +#include "efx_cxl.h"
>  
>  #include "mcdi_port_common.h"
>  #include "mcdi_pcol.h"
> @@ -899,6 +900,9 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>  	efx_pci_remove_main(efx);
>  
>  	efx_fini_io(efx);
> +
> +	efx_cxl_exit(efx);
> +
>  	pci_dbg(efx->pci_dev, "shutdown successful\n");
>  
>  	efx_fini_devlink_and_unlock(efx);
> @@ -1109,6 +1113,15 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>  	if (rc)
>  		goto fail2;
>  
> +	/* A successful cxl initialization implies a CXL region created to be
> +	 * used for PIO buffers. If there is no CXL support, or initialization
> +	 * fails, efx_cxl_pio_initialised wll be false and legacy PIO buffers
> +	 * defined at specific PCI BAR regions will be used.
> +	 */
> +	rc = efx_cxl_init(efx);
> +	if (rc)
> +		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);

If you are carrying on anyway is pci_info() more appropriate?
Personally I dislike muddling on in error cases, but understand
it can be useful on occasion at the cost of more complex flows.


> +
>  	rc = efx_pci_probe_post_io(efx);
>  	if (rc) {
>  		/* On failure, retry once immediately.
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> new file mode 100644
> index 000000000000..bba36cbbab22
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/****************************************************************************
> + *
> + * Driver for AMD network controllers and boards
> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation, incorporated herein by reference.
> + */
> +
> +#include <linux/cxl/cxl.h>
> +#include <linux/cxl/pci.h>
> +#include <linux/pci.h>
> +
> +#include "net_driver.h"
> +#include "efx_cxl.h"
> +
> +#define EFX_CTPIO_BUFFER_SIZE	(1024 * 1024 * 256)
> +
> +int efx_cxl_init(struct efx_nic *efx)
> +{
> +	struct pci_dev *pci_dev = efx->pci_dev;
> +	struct efx_cxl *cxl;
> +	struct resource res;
> +	u16 dvsec;
> +	int rc;
> +
> +	efx->efx_cxl_pio_initialised = false;
> +
> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +

Trivial but probably no blank line here. Keeps the error condition tightly
grouped with the call.

> +	if (!dvsec)
> +		return 0;
> +
> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
> +
> +	efx->cxl = kzalloc(sizeof(*cxl), GFP_KERNEL);
> +	if (!efx->cxl)
> +		return -ENOMEM;
> +
> +	cxl = efx->cxl;
Rather than setting it back to zero in some error paths I'd
suggest keeping it as local only until you know everything
succeeded. 

	cxl = kzalloc(...)
	
//maybe also cxlds as then you can use __free() to handle the
//cleanup paths for both allowing early returns instead
//of gotos.

	...

	efx->cxl = cxl;

	return 0;

> +
> +	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
> +	if (IS_ERR(cxl->cxlds)) {
> +		pci_err(pci_dev, "CXL accel device state failed");
> +		kfree(efx->cxl);

Use the a separate label below.  Error blocks in a given function
should probably do one or the other between going to labels
or handling locally.  Mixture is harder to read.

> +		return -ENOMEM;
> +	}
> +
> +	cxl_set_dvsec(cxl->cxlds, dvsec);
> +	cxl_set_serial(cxl->cxlds, pci_dev->dev.id);
> +
> +	res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
> +	if (cxl_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_DPA)) {
> +		pci_err(pci_dev, "cxl_set_resource DPA failed\n");
> +		rc = -EINVAL;
> +		goto err;
> +	}
> +
> +	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
> +	if (cxl_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM)) {
> +		pci_err(pci_dev, "cxl_set_resource RAM failed\n");
> +		rc = -EINVAL;
> +		goto err;
> +	}
> +
> +	return 0;
> +err:
> +	kfree(cxl->cxlds);
> +	kfree(cxl);
> +	efx->cxl = NULL;
> +
> +	return rc;
> +}
> +
> +void efx_cxl_exit(struct efx_nic *efx)
> +{
> +	if (efx->cxl) {
> +		kfree(efx->cxl->cxlds);
> +		kfree(efx->cxl);
> +	}
> +}
> +
> +MODULE_IMPORT_NS(CXL);
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
> new file mode 100644
> index 000000000000..f57fb2afd124
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.h

...


> +struct efx_cxl {
> +	struct cxl_dev_state *cxlds;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_port *endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *efx_region;

Why is the region efx_ prefixed but nothing else?
Feels a little random.

> +	void __iomem *ctpio_cxl;
> +};
> +
> +int efx_cxl_init(struct efx_nic *efx);
> +void efx_cxl_exit(struct efx_nic *efx);
> +#endif

> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> new file mode 100644
> index 000000000000..e78eefa82123
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
> +
> +enum cxl_resource {
> +	CXL_ACCEL_RES_DPA,
> +	CXL_ACCEL_RES_RAM,
> +	CXL_ACCEL_RES_PMEM,
> +};
> +
> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
> +
> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> +		     enum cxl_resource);
> +#endif
> diff --git a/include/linux/cxl/pci.h b/include/linux/cxl/pci.h
> new file mode 100644
> index 000000000000..c337ae8797e6
> --- /dev/null
> +++ b/include/linux/cxl/pci.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */

Bit bold to claim sole copyright of a cut and paste blob.
Fine to add AMD one, but keep the original copyright as well.

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
> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))

Brackets around (i) to protect against stupid use of the macro.
This is general kernel convention rather than a real problem here.
Sure original code didn't do it but if we are touching the code
might as well fix it ;)


> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
> +
> +#endif


