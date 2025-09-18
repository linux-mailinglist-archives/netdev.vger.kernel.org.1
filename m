Return-Path: <netdev+bounces-224650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77663B8761F
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 01:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31293A2A72
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 23:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDC92FB97A;
	Thu, 18 Sep 2025 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8+t1YdW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9F02F2910;
	Thu, 18 Sep 2025 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758237906; cv=none; b=ndAfNRFlThumLONr4+1R/U4xBrE1IilQz+FVc4l2i4viUXeCSsZ1L+MCbxB5/++UCvz3qrDBkAmc94iX72y2hpRtbvb/JyaDL6BPCOhydFJl/yyqWRSs2BxNomHcGAAsvw051YmTlr+1Eo0fsWoe02Z3eR6R8gLpDtyo8kU90Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758237906; c=relaxed/simple;
	bh=pZ1cZ3oCKKYXvzEoVeuLb6fbzd9YUJCwH64+ARDb18U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5HhBQbIA+d08GZmyEBT/T5uuA5lIUTdlqAbxd1t7uRIKs16jlzc81hjRoAnxobmzoQr7FTSWAJNV00E+FzZBFbIYkZW0tVRv2FNRepJ5EyGZ4Cqf4b0DI28gseVzTsbjOPYUh+ssS1rppcx5NtQI91XJgQ8ewHVTRpNNgxAOqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8+t1YdW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758237904; x=1789773904;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pZ1cZ3oCKKYXvzEoVeuLb6fbzd9YUJCwH64+ARDb18U=;
  b=W8+t1YdWV3tol+7BGG0pLJ6bSvzdgqTshycuh5EGfogbXLlxJEAY4auI
   bUNgFOSidf3+dPNj0gzjDQdasqjyNvAG2epcirq6L8joDrW9EVyN6xfPx
   KWVoYke07evZoyEtq2cnW6izmIeunqxwCPcfH0dEDwXLy3UHazuW2o4eq
   borFUR4JfMSby/AlpDOmu7Hn3+CaZ9A69/MlS1BcgM0qWSqcwIPEEUwvt
   C6/gpWOyDsS8tfwbURi98/Vza5S8uOo+lbH/hzOPmL9++L27vtRFLuF7h
   CVRceaafkyJMxCHj9/BTWexwXZkY4Pr7FW3Fr0P3wcwZ256mZDBgZZjgj
   A==;
X-CSE-ConnectionGUID: kFAS2dghTIG0+PoKsP1Tvg==
X-CSE-MsgGUID: ivANTj2bQmGb8G7gTXbziA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="70832011"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="70832011"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 16:25:03 -0700
X-CSE-ConnectionGUID: /H1QK8SoTPum0IX1vVWbFA==
X-CSE-MsgGUID: JA4R+twNRKirnJu+1dQgzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="176089608"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.28]) ([10.125.108.28])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 16:25:01 -0700
Message-ID: <276c41a7-f61c-4f9e-8cf1-4a458c3fe9bd@intel.com>
Date: Thu, 18 Sep 2025 16:25:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 02/20] sfc: add cxl support
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Alison Schofield <alison.schofield@intel.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-3-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250918091746.2034285-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/25 2:17 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add CXL initialization based on new CXL API for accel drivers and make
> it dependent on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/net/ethernet/sfc/Kconfig      |  9 +++++
>  drivers/net/ethernet/sfc/Makefile     |  1 +
>  drivers/net/ethernet/sfc/efx.c        | 15 ++++++-
>  drivers/net/ethernet/sfc/efx_cxl.c    | 57 +++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    | 40 +++++++++++++++++++
>  drivers/net/ethernet/sfc/net_driver.h | 10 +++++
>  6 files changed, 131 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
> 
> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
> index c4c43434f314..979f2801e2a8 100644
> --- a/drivers/net/ethernet/sfc/Kconfig
> +++ b/drivers/net/ethernet/sfc/Kconfig
> @@ -66,6 +66,15 @@ config SFC_MCDI_LOGGING
>  	  Driver-Interface) commands and responses, allowing debugging of
>  	  driver/firmware interaction.  The tracing is actually enabled by
>  	  a sysfs file 'mcdi_logging' under the PCI device.
> +config SFC_CXL
> +	bool "Solarflare SFC9100-family CXL support"
> +	depends on SFC && CXL_BUS >= SFC
> +	default SFC
> +	help
> +	  This enables SFC CXL support if the kernel is configuring CXL for
> +	  using CTPIO with CXL.mem. The SFC device with CXL support and
> +	  with a CXL-aware firmware can be used for minimizing latencies
> +	  when sending through CTPIO.
>  
>  source "drivers/net/ethernet/sfc/falcon/Kconfig"
>  source "drivers/net/ethernet/sfc/siena/Kconfig"
> diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
> index d99039ec468d..bb0f1891cde6 100644
> --- a/drivers/net/ethernet/sfc/Makefile
> +++ b/drivers/net/ethernet/sfc/Makefile
> @@ -13,6 +13,7 @@ sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
>                             mae.o tc.o tc_bindings.o tc_counters.o \
>                             tc_encap_actions.o tc_conntrack.o
>  
> +sfc-$(CONFIG_SFC_CXL)	+= efx_cxl.o
>  obj-$(CONFIG_SFC)	+= sfc.o
>  
>  obj-$(CONFIG_SFC_FALCON) += falcon/
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index 112e55b98ed3..537668278375 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -34,6 +34,7 @@
>  #include "selftest.h"
>  #include "sriov.h"
>  #include "efx_devlink.h"
> +#include "efx_cxl.h"
>  
>  #include "mcdi_port_common.h"
>  #include "mcdi_pcol.h"
> @@ -981,12 +982,15 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>  	efx_pci_remove_main(efx);
>  
>  	efx_fini_io(efx);
> +
> +	probe_data = container_of(efx, struct efx_probe_data, efx);
> +	efx_cxl_exit(probe_data);
> +
>  	pci_dbg(efx->pci_dev, "shutdown successful\n");
>  
>  	efx_fini_devlink_and_unlock(efx);
>  	efx_fini_struct(efx);
>  	free_netdev(efx->net_dev);
> -	probe_data = container_of(efx, struct efx_probe_data, efx);
>  	kfree(probe_data);
>  };
>  
> @@ -1190,6 +1194,15 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>  	if (rc)
>  		goto fail2;
>  
> +	/* A successful cxl initialization implies a CXL region created to be
> +	 * used for PIO buffers. If there is no CXL support, or initialization
> +	 * fails, efx_cxl_pio_initialised will be false and legacy PIO buffers
> +	 * defined at specific PCI BAR regions will be used.
> +	 */
> +	rc = efx_cxl_init(probe_data);
> +	if (rc)
> +		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
> +
>  	rc = efx_pci_probe_post_io(efx);
>  	if (rc) {
>  		/* On failure, retry once immediately.
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> new file mode 100644
> index 000000000000..56d148318636
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/****************************************************************************
> + *
> + * Driver for AMD network controllers and boards
> + * Copyright (C) 2025, Advanced Micro Devices, Inc.
> + */
> +
> +#include <cxl/pci.h>
> +#include <linux/pci.h>
> +
> +#include "net_driver.h"
> +#include "efx_cxl.h"
> +
> +#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
> +
> +int efx_cxl_init(struct efx_probe_data *probe_data)
> +{
> +	struct efx_nic *efx = &probe_data->efx;
> +	struct pci_dev *pci_dev = efx->pci_dev;
> +	struct efx_cxl *cxl;
> +	u16 dvsec;
> +
> +	probe_data->cxl_pio_initialised = false;
> +
> +	/* Is the device configured with and using CXL? */
> +	if (!pcie_is_cxl(pci_dev))
> +		return 0;
> +
> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +	if (!dvsec) {
> +		pci_err(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability not found\n");
> +		return 0;
> +	}
> +
> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
> +
> +	/* Create a cxl_dev_state embedded in the cxl struct using cxl core api
> +	 * specifying no mbox available.
> +	 */
> +	cxl = devm_cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
> +					pci_dev->dev.id, dvsec, struct efx_cxl,
> +					cxlds, false);
> +
> +	if (!cxl)
> +		return -ENOMEM;
> +
> +	probe_data->cxl = cxl;
> +
> +	return 0;
> +}
> +
> +void efx_cxl_exit(struct efx_probe_data *probe_data)
> +{
> +}
> +
> +MODULE_IMPORT_NS("CXL");
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
> new file mode 100644
> index 000000000000..961639cef692
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/****************************************************************************
> + * Driver for AMD network controllers and boards
> + * Copyright (C) 2025, Advanced Micro Devices, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation, incorporated herein by reference.
> + */
> +
> +#ifndef EFX_CXL_H
> +#define EFX_CXL_H
> +
> +#ifdef CONFIG_SFC_CXL
> +
> +#include <cxl/cxl.h>
> +
> +struct cxl_root_decoder;
> +struct cxl_port;
> +struct cxl_endpoint_decoder;
> +struct cxl_region;
> +struct efx_probe_data;
> +
> +struct efx_cxl {
> +	struct cxl_dev_state cxlds;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_port *endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *efx_region;
> +	void __iomem *ctpio_cxl;
> +};
> +
> +int efx_cxl_init(struct efx_probe_data *probe_data);
> +void efx_cxl_exit(struct efx_probe_data *probe_data);
> +#else
> +static inline int efx_cxl_init(struct efx_probe_data *probe_data) { return 0; }
> +static inline void efx_cxl_exit(struct efx_probe_data *probe_data) {}
> +#endif
> +#endif
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index 5c0f306fb019..0e685b8a9980 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -1199,14 +1199,24 @@ struct efx_nic {
>  	atomic_t n_rx_noskb_drops;
>  };
>  
> +#ifdef CONFIG_SFC_CXL
> +struct efx_cxl;
> +#endif
> +
>  /**
>   * struct efx_probe_data - State after hardware probe
>   * @pci_dev: The PCI device
>   * @efx: Efx NIC details
> + * @cxl: details of related cxl objects
> + * @cxl_pio_initialised: cxl initialization outcome.
>   */
>  struct efx_probe_data {
>  	struct pci_dev *pci_dev;
>  	struct efx_nic efx;
> +#ifdef CONFIG_SFC_CXL
> +	struct efx_cxl *cxl;
> +	bool cxl_pio_initialised;
> +#endif
>  };
>  
>  static inline struct efx_nic *efx_netdev_priv(struct net_device *dev)


