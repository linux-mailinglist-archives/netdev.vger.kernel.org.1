Return-Path: <netdev+bounces-139121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AB59B04F1
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E451F240C8
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCDD212182;
	Fri, 25 Oct 2024 14:03:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4870802;
	Fri, 25 Oct 2024 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865003; cv=none; b=ijZSGT0BF7D38c6VaViZrF9Jg28HvGiG751ounyhEENA3EOB8/dpucsa+lwnsZPsYI5KlzgIqKR23tWhfgO83kpfgwGHdjcwk+SxF7ul6vBOhxUW+IM30oMY47Cr0lccTWGiDvJYe9joKF2YGxqgbn3YSeGQ2HwS93j1dDblgZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865003; c=relaxed/simple;
	bh=7KdLLBNmHlfow7jc2w4LMAmtaU2NNzxtm4u50VHQsos=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LrKNCLJJoyQMnaN47kI0o/wFOHs/IwIGHGhbzpb7eF6PSAEZkY3nVCTQSDS88bvRlRJ6ocHVDJorChwO9U/0DtszotqDX6zbYo8ZtBDubH1lVejP35tupQ7Oc3kkyQzuU/9MWKRH93zNBa1cL/DIlfFS/zdDwyxDb6Rat+VRuZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZks52DrKz6LDCx;
	Fri, 25 Oct 2024 21:58:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id ACA89140390;
	Fri, 25 Oct 2024 22:03:16 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Oct
 2024 16:03:16 +0200
Date: Fri, 25 Oct 2024 15:03:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v4 02/26] sfc: add cxl support using new CXL API
Message-ID: <20241025150314.00007122@Huawei.com>
In-Reply-To: <20241017165225.21206-3-alejandro.lucero-palau@amd.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
	<20241017165225.21206-3-alejandro.lucero-palau@amd.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Oct 2024 17:52:01 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add CXL initialization based on new CXL API for accel drivers and make
> it dependable on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/Kconfig      |  1 +
>  drivers/net/ethernet/sfc/Makefile     |  2 +-
>  drivers/net/ethernet/sfc/efx.c        | 16 +++++
>  drivers/net/ethernet/sfc/efx_cxl.c    | 92 +++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    | 29 +++++++++
>  drivers/net/ethernet/sfc/net_driver.h |  6 ++
>  6 files changed, 145 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
> 
> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
> index 3eb55dcfa8a6..b308a6f674b2 100644
> --- a/drivers/net/ethernet/sfc/Kconfig
> +++ b/drivers/net/ethernet/sfc/Kconfig
> @@ -20,6 +20,7 @@ config SFC
>  	tristate "Solarflare SFC9100/EF100-family support"
>  	depends on PCI
>  	depends on PTP_1588_CLOCK_OPTIONAL
> +	depends on CXL_BUS && CXL_BUS=m && m

 Do some makefile magic and stubs to only support efx_cxl.c
being built at all if necessary conditions met.
Doesn't necessarily need a visible control.

config SFC9100_CXL
	boolean

then here have
select SFC9100_CXL if CXL_BUS


>  	select MDIO
>  	select CRC32
>  	select NET_DEVLINK

> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> new file mode 100644
> index 000000000000..fb3eef339b34
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -0,0 +1,92 @@
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
> +#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
> +
> +int efx_cxl_init(struct efx_nic *efx)
> +{
> +#if IS_ENABLED(CONFIG_CXL_BUS)

If it can't do anything useful, make the build depend on this
and provide stubs for when it isn't enabled.

I'd not expect to see any ifdef stuff for basic CXL in this file
as it should build unless they are all configured.

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
> +	if (!dvsec)
> +		return 0;
> +
> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
> +
> +	cxl = kzalloc(sizeof(*cxl), GFP_KERNEL);

__free magic here.
Assuming later changes don't make that a bad idea - I've not
read the whole set for a while.


> +	if (!cxl)
> +		return -ENOMEM;
> +
> +	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);

Stash this in a local cxl_dev_state for now and use __free() for that.

> +	if (IS_ERR(cxl->cxlds)) {
> +		pci_err(pci_dev, "CXL accel device state failed");
> +		rc = -ENOMEM;
> +		goto err1;
> +	}
> +
> +	cxl_set_dvsec(cxl->cxlds, dvsec);
> +	cxl_set_serial(cxl->cxlds, pci_dev->dev.id);
> +
> +	res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
> +	if (cxl_set_resource(cxl->cxlds, res, CXL_RES_DPA)) {
> +		pci_err(pci_dev, "cxl_set_resource DPA failed\n");
> +		rc = -EINVAL;
> +		goto err2;
> +	}
> +
> +	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
> +	if (cxl_set_resource(cxl->cxlds, res, CXL_RES_RAM)) {
> +		pci_err(pci_dev, "cxl_set_resource RAM failed\n");
> +		rc = -EINVAL;
> +		goto err2;
> +	}
> +
	cxl->cxlds = no_free_ptr(cxlds);
	efx->cxl = no_free_ptr(cxl);

> +	efx->cxl = cxl;
> +#endif
> +
> +	return 0;
> +
> +#if IS_ENABLED(CONFIG_CXL_BUS)
With __free changes suggest above, no need to do anything here
and can return directly from the error checks above.

> +err2:
> +	kfree(cxl->cxlds);
> +err1:
> +	kfree(cxl);
> +	return rc;
> +
> +#endif
> +}
> +
> +void efx_cxl_exit(struct efx_nic *efx)
> +{
> +#if IS_ENABLED(CONFIG_CXL_BUS)

IS_REACHABLE() maybe, so if this driver is built in but CXL_BUS
is not then this will go away.

> +	if (efx->cxl) {
> +		kfree(efx->cxl->cxlds);
> +		kfree(efx->cxl);
> +	}
> +#endif
> +}
> +
> +MODULE_IMPORT_NS(CXL);
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
> new file mode 100644
> index 000000000000..f57fb2afd124
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
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
> +#define EFX_CXL_H
> +
> +struct efx_nic;
> +struct cxl_dev_state;

struct cxl_memdev;
struct cxl_root_decoder;
struct cxl_port;
...

> +
> +struct efx_cxl {
> +	struct cxl_dev_state *cxlds;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_port *endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *efx_region;
> +	void __iomem *ctpio_cxl;
> +};
> +
> +int efx_cxl_init(struct efx_nic *efx);
> +void efx_cxl_exit(struct efx_nic *efx);
> +#endif
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index b85c51cbe7f9..77261de65e63 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -817,6 +817,8 @@ enum efx_xdp_tx_queues_mode {
>  
>  struct efx_mae;
>  
> +struct efx_cxl;
> +
>  /**
>   * struct efx_nic - an Efx NIC
>   * @name: Device name (net device name or bus id before net device registered)
> @@ -963,6 +965,8 @@ struct efx_mae;
>   * @tc: state for TC offload (EF100).
>   * @devlink: reference to devlink structure owned by this device
>   * @dl_port: devlink port associated with the PF
> + * @cxl: details of related cxl objects
> + * @efx_cxl_pio_initialised: clx initialization outcome.

cxl

Also, it's in a struct called efx_nic, so is the efx_ prefix
useful?

>   * @mem_bar: The BAR that is mapped into membase.
>   * @reg_base: Offset from the start of the bar to the function control window.
>   * @monitor_work: Hardware monitor workitem
> @@ -1148,6 +1152,8 @@ struct efx_nic {
>  
>  	struct devlink *devlink;
>  	struct devlink_port *dl_port;
> +	struct efx_cxl *cxl;
> +	bool efx_cxl_pio_initialised;
>  	unsigned int mem_bar;
>  	u32 reg_base;
>  


