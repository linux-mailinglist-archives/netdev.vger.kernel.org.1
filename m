Return-Path: <netdev+bounces-115557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A22946FFA
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 19:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5351C2091D
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 17:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AB86BFA5;
	Sun,  4 Aug 2024 17:10:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA4B6026A;
	Sun,  4 Aug 2024 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722791455; cv=none; b=kvskHnUWoMVd9HbaAutOJ3SuHUEsUy2bpsx8edcWRWI7QstqtHIVRd7yN2PZAEQVDMXdrnnB8IQUl365oN8XM/qK4pyALb7v2mTzutr/PWj08MvqyXBpoZttEYtx+BKuGUuSimLbdKCfrkFkhCY711uUm0WZ9roXYJSeS57j8bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722791455; c=relaxed/simple;
	bh=ECa8I4p9RGAZkPds6u++HJiDtVMLM+MhAz3qBPiHkTA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzjaOFAZ4rg1Qf08G0xq+LZTZ2IIp2/S/Stjdmkp4RRb+0ihw+BpkyDzBfdaRMPiOLib583TqovpZfATl/dwfMyaPh+GXpD07SBhYp5lhkpU0Xma/RDQJa6kjBZp7hCiyLZ4v8wZ4hbJdWnmphLOsCdJeGfYn6L0QqeKfldcZ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WcQyG1lkQz67gJd;
	Mon,  5 Aug 2024 01:08:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 41D391401DC;
	Mon,  5 Aug 2024 01:10:49 +0800 (CST)
Received: from localhost (10.195.244.131) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 4 Aug
 2024 18:10:48 +0100
Date: Sun, 4 Aug 2024 18:10:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 01/15] cxl: add type2 device basic support
Message-ID: <20240804181045.000009dc@Huawei.com>
In-Reply-To: <20240715172835.24757-2-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-2-alejandro.lucero-palau@amd.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 15 Jul 2024 18:28:21 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differientiate Type3, aka memory expanders, from Type2, aka device
> accelerators, with a new function for initializing cxl_dev_state.
> 
> Create opaque struct to be used by accelerators relying on new access
> functions in following patches.
> 
> Add SFC ethernet network driver as the client.
> 
> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m52543f85d0e41ff7b3063fdb9caa7e845b446d0e
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Hi Alejandro,

Various comments inline. Mostly minor detail as I need to get my head
around the whole thing which will take a while yet!

Some will seem very fussy given the stage we are at (and fairly
long way to go), but cleaner code will generally be easier to read
so may help move the bigger stuff forwards quicker.
+ I had my review brain in gear so couldn't ignore things.

Jonathan

> ---
>  drivers/cxl/core/memdev.c             | 52 ++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/Makefile     |  2 +-
>  drivers/net/ethernet/sfc/efx.c        |  4 ++
>  drivers/net/ethernet/sfc/efx_cxl.c    | 53 +++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    | 29 +++++++++++++++
>  drivers/net/ethernet/sfc/net_driver.h |  4 ++
>  include/linux/cxl_accel_mem.h         | 22 +++++++++++
>  include/linux/cxl_accel_pci.h         | 23 ++++++++++++
>  8 files changed, 188 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>  create mode 100644 include/linux/cxl_accel_mem.h
>  create mode 100644 include/linux/cxl_accel_pci.h
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 0277726afd04..61b5d35b49e7 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c

> @@ -692,6 +712,38 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +
> +void cxl_accel_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
> +{
> +	cxlds->cxl_dvsec = dvsec;

Nothing to do with accel. If these make sense promote to cxl
core and a linux/cxl/ header.  Also we may want the type3 driver to
switch to them long term. If nothing else, making that handle the
cxl_dev_state as more opaque will show up what is still directly
accessed and may need to be wrapped up for a future accelerator driver
to use.


> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_dvsec, CXL);
> +
> +void cxl_accel_set_serial(struct cxl_dev_state *cxlds, u64 serial)
> +{
> +	cxlds->serial= serial;

Run checkpatch over this series before v3 with --strict and fix the
warnings. Probably would have spotted missing space before =

Sure it's a series that is kind of RFC ish at the moment but clean
code means you don't get nitpickers like me pointing this stuff out!

> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_serial, CXL);
> +
> +void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> +			    enum accel_resource type)
> +{
> +	switch (type) {
> +	case CXL_ACCEL_RES_DPA:
> +		cxlds->dpa_res = res;
> +		return;
> +	case CXL_ACCEL_RES_RAM:
> +		cxlds->ram_res = res;
> +		return;
> +	case CXL_ACCEL_RES_PMEM:
> +		cxlds->pmem_res = res;
> +		return;
> +	default:
> +		dev_err(cxlds->dev, "unkown resource type (%u)\n", type);
typo. Plus I'd let this return an error as we may well have more types
in future and not handle them all.

> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_resource, CXL);
> +
>  static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>  {
>  	struct cxl_memdev *cxlmd =

> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index e9d9de8e648a..cb3f74d30852 100644
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
> @@ -899,6 +900,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>  	efx_pci_remove_main(efx);
>  
>  	efx_fini_io(efx);
> +

Make sure you don't add noisy whitespace changes in v3. Slows down
review and makes a patch set look bigger than it is.

>  	pci_dbg(efx->pci_dev, "shutdown successful\n");
>  
>  	efx_fini_devlink_and_unlock(efx);
> @@ -1109,6 +1111,8 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>  	if (rc)
>  		goto fail2;
>  
> +	efx_cxl_init(efx);
> +
As below, have an error code. This is not something we want to fail
and have the driver carry on.

>  	rc = efx_pci_probe_post_io(efx);
>  	if (rc) {
>  		/* On failure, retry once immediately.
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> new file mode 100644
> index 000000000000..4554dd7cca76
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/****************************************************************************
> + * Driver for AMD network controllers and boards
> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation, incorporated herein by reference.
> + */
> +
> +
> +#include <linux/pci.h>
> +#include <linux/cxl_accel_mem.h>
> +#include <linux/cxl_accel_pci.h>
> +
> +#include "net_driver.h"
> +#include "efx_cxl.h"
> +
> +#define EFX_CTPIO_BUFFER_SIZE	(1024*1024*256)
> +
> +void efx_cxl_init(struct efx_nic *efx)
> +{
> +	struct pci_dev *pci_dev = efx->pci_dev;
> +	struct efx_cxl *cxl = efx->cxl;
> +	struct resource res;
> +	u16 dvsec;
> +
> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +
> +	if (!dvsec)
> +		return;
> +
> +	pci_info(pci_dev, "CXL CXL_DVSEC_PCIE_DEVICE capability found");

pci_dbg();  

> +
> +	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
> +	if (IS_ERR(cxl->cxlds)) {
> +		pci_info(pci_dev, "CXL accel device state failed");
> +		return;

Return an error.  A driver calling CXL stuff that fails is going to
want to know

> +	}
> +
> +	cxl_accel_set_dvsec(cxl->cxlds, dvsec);
> +	cxl_accel_set_serial(cxl->cxlds, pci_dev->dev.id);
> +
> +	res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
> +	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_DPA);
> +
> +	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
> +	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM);
> +}
> +
> +
> +MODULE_IMPORT_NS(CXL);
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
> new file mode 100644
> index 000000000000..76c6794c20d8
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/****************************************************************************
> + * Driver for AMD network controllers and boards
> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation, incorporated herein by reference.
> + */
> +
> +#ifndef EFX_CXL_H
> +#define EFX_CLX_H
> +
> +#include <linux/cxl_accel_mem.h>

Maybe, or maybe just some more forward defines to keep all the header
nice an separate.

> +
> +struct efx_nic;
> +
> +struct efx_cxl {
> +	cxl_accel_state *cxlds;
There are other ways to keep this opaque that let you embed the structure
into one you do know about.  Usually involve allocating a
cxl_device_state + your structure and some cxl_devstate_private()
accessors to get to the data placed after the cxlds part.

May not be worth bothering here though, particularly as the CXL-ness
of the device may not be the most important part and you may well be
doing similar tricks anyway to hid some other subsystem specific driver.

So for now this looks like a sensible approach to me.

> +	struct cxl_memdev *cxlmd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_port *endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *efx_region;
> +	void __iomem *ctpio_cxl;
> +};
> +
> +void efx_cxl_init(struct efx_nic *efx);
> +#endif

> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
> new file mode 100644
> index 000000000000..daf46d41f59c
> --- /dev/null
> +++ b/include/linux/cxl_accel_mem.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
> +
> +#include <linux/cdev.h>
> +
> +#ifndef __CXL_ACCEL_MEM_H
> +#define __CXL_ACCEL_MEM_H
> +
> +enum accel_resource{
> +	CXL_ACCEL_RES_DPA,
> +	CXL_ACCEL_RES_RAM,
> +	CXL_ACCEL_RES_PMEM,
> +};
> +
> +typedef struct cxl_dev_state cxl_accel_state;

A forwards def would work like you do for struct efx_cxl
above. Keeps the structure opaque unless code actually needs
to know what is in it. That code can including the header
that defines it.  In many cases it will be an opaque pointer
passed to code in the CXL core.

struct cxl_dev_state;

Then use pointers to that in these functions.

> +cxl_accel_state *cxl_accel_state_create(struct device *dev);
> +
> +void cxl_accel_set_dvsec(cxl_accel_state *cxlds, u16 dvsec);
> +void cxl_accel_set_serial(cxl_accel_state *cxlds, u64 serial);
> +void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> +			    enum accel_resource);
> +#endif
> diff --git a/include/linux/cxl_accel_pci.h b/include/linux/cxl_accel_pci.h
> new file mode 100644
> index 000000000000..c337ae8797e6
> --- /dev/null
> +++ b/include/linux/cxl_accel_pci.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
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
> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)

As I think Dave suggested, pull any defs you need to linux/cxl/pci.h or whatever
makes sense and make the exiting code look for them there.

Ideally do that in a patch that does nothing else as simple
moves are easier to review quickly than ones mixed with real changes.


> +
> +#endif


