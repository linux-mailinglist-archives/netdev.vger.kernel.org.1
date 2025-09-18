Return-Path: <netdev+bounces-224651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EB2B8762E
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 01:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFCB167927
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 23:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA6D2EB843;
	Thu, 18 Sep 2025 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1nTjPxx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00C72C327E;
	Thu, 18 Sep 2025 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758238227; cv=none; b=Yb7/bds0cGL7kT41lDNYZEKrF5cOmB1pGcnS3nI0Jj7P+rS9XbWfBlTQoICPUVqsKZL7h1G5iCOAJM71mtB05ResT8HM1O6AQk0MCRRaSdF17Vq9l5q0ji+nCRSvCra72EmliYxUez2gwdiZ+H/GKwPjhdsGYiJQeJZvaPwsxCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758238227; c=relaxed/simple;
	bh=qx85QEG79r8LfkDW72gXWwAqaw1uRaHKZVKNTMRHzIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lviNkuwHlnylL5p2/tHWBfaRVmTFKG/kUW7G5/Huz8iiINuxkprWJ5oFFBcUmzTzgPCYmVUNKj9XAYICRrdKIy6j6NInUbv1erFeFCnHAR5PVLWWDdSpHxmBEJG3o49IRXlw4iqPMik5/rIByGs3Qv5WgPbKB46qs/9bJY1H938=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1nTjPxx; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758238226; x=1789774226;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qx85QEG79r8LfkDW72gXWwAqaw1uRaHKZVKNTMRHzIE=;
  b=H1nTjPxxO4ZTDiuWy1uCdoz544yp8TNyrsEccqw001C11Fs4uqU+fsCL
   yhT4MhZo7PpBoN1uHsRMUH5smNrJGI5I6TqOOkah1oTAsjgVRayoqtDqi
   SzrGgwXF1qz0u2i7AXhDKjhO5Wbx6vSG4e0dW+U58e+PXZCUBdCCXBWAy
   zCfuSBf06hGp2UlJIYIUPQOWSdvMPdOPxB94+OHSQ4aM6MnmlTcJ2jJmN
   CcKewtbDLsV5zq2otHqWJ/3X+FnM8VWe0MNCiOMqE0PK+STNLp3KNp2qu
   67THIdjFRMv4FrL7ojXmZgFXN95QeYwIR8/LNDDyRJfXhXM06b86DUhhp
   Q==;
X-CSE-ConnectionGUID: bXu1Q5zLTSyiqtImjwTqeg==
X-CSE-MsgGUID: /gIWQEHqQvi4rBROzgu1mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60530449"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60530449"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 16:30:25 -0700
X-CSE-ConnectionGUID: gSt311jSTPKkuRtU1HJ+8Q==
X-CSE-MsgGUID: WW+U6VNESLabJvoS0REKLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="175293433"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.28]) ([10.125.108.28])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 16:30:21 -0700
Message-ID: <7a101e59-85cb-482b-b892-cc85989f27a6@intel.com>
Date: Thu, 18 Sep 2025 16:30:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 04/20] cxl: allow Type2 drivers to map cxl component
 regs
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-5-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250918091746.2034285-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/25 2:17 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Export cxl core functions for a Type2 driver being able to discover and
> map the device component registers.
> 
> Use it in sfc driver cxl initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

With the changes asked by Jonathan,
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/port.c            |  1 +
>  drivers/cxl/cxl.h                  |  7 -------
>  drivers/cxl/cxlpci.h               | 12 -----------
>  drivers/net/ethernet/sfc/efx_cxl.c | 33 ++++++++++++++++++++++++++++++
>  include/cxl/cxl.h                  | 20 ++++++++++++++++++
>  include/cxl/pci.h                  | 15 ++++++++++++++
>  6 files changed, 69 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index bb326dc95d5f..240c3c5bcdc8 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -11,6 +11,7 @@
>  #include <linux/idr.h>
>  #include <linux/node.h>
>  #include <cxl/einj.h>
> +#include <cxl/pci.h>
>  #include <cxlmem.h>
>  #include <cxlpci.h>
>  #include <cxl.h>
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index e197c36c7525..793d4dfe51a2 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -38,10 +38,6 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>  #define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
>  #define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
>  
> -#define   CXL_CM_CAP_CAP_ID_RAS 0x2
> -#define   CXL_CM_CAP_CAP_ID_HDM 0x5
> -#define   CXL_CM_CAP_CAP_HDM_VERSION 1
> -
>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
>  #define CXL_HDM_DECODER_CAP_OFFSET 0x0
>  #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
> @@ -205,9 +201,6 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			      struct cxl_component_reg_map *map);
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  			   struct cxl_device_reg_map *map);
> -int cxl_map_component_regs(const struct cxl_register_map *map,
> -			   struct cxl_component_regs *regs,
> -			   unsigned long map_mask);
>  int cxl_map_device_regs(const struct cxl_register_map *map,
>  			struct cxl_device_regs *regs);
>  int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs);
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 4b11757a46ab..2247823acf6f 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -13,16 +13,6 @@
>   */
>  #define CXL_PCI_DEFAULT_MAX_VECTORS 16
>  
> -/* Register Block Identifier (RBI) */
> -enum cxl_regloc_type {
> -	CXL_REGLOC_RBI_EMPTY = 0,
> -	CXL_REGLOC_RBI_COMPONENT,
> -	CXL_REGLOC_RBI_VIRT,
> -	CXL_REGLOC_RBI_MEMDEV,
> -	CXL_REGLOC_RBI_PMU,
> -	CXL_REGLOC_RBI_TYPES
> -};
> -
>  /*
>   * Table Access DOE, CDAT Read Entry Response
>   *
> @@ -90,6 +80,4 @@ struct cxl_dev_state;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  			struct cxl_endpoint_dvsec_info *info);
>  void read_cdat_data(struct cxl_port *port);
> -int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> -		       struct cxl_register_map *map);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 56d148318636..cdfbe546d8d8 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2025, Advanced Micro Devices, Inc.
>   */
>  
> +#include <cxl/cxl.h>
>  #include <cxl/pci.h>
>  #include <linux/pci.h>
>  
> @@ -19,6 +20,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	struct pci_dev *pci_dev = efx->pci_dev;
>  	struct efx_cxl *cxl;
>  	u16 dvsec;
> +	int rc;
>  
>  	probe_data->cxl_pio_initialised = false;
>  
> @@ -45,6 +47,37 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	if (!cxl)
>  		return -ENOMEM;
>  
> +	rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
> +				&cxl->cxlds.reg_map);
> +	if (rc) {
> +		dev_err(&pci_dev->dev, "No component registers (err=%d)\n", rc);
> +		return rc;
> +	}
> +
> +	if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
> +		dev_err(&pci_dev->dev, "Expected HDM component register not found\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!cxl->cxlds.reg_map.component_map.ras.valid)
> +		return dev_err_probe(&pci_dev->dev, -ENODEV,
> +				     "Expected RAS component register not found\n");
> +
> +	rc = cxl_map_component_regs(&cxl->cxlds.reg_map,
> +				    &cxl->cxlds.regs.component,
> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
> +	if (rc) {
> +		dev_err(&pci_dev->dev, "Failed to map RAS capability.\n");
> +		return rc;
> +	}
> +
> +	/*
> +	 * Set media ready explicitly as there are neither mailbox for checking
> +	 * this state nor the CXL register involved, both not mandatory for
> +	 * type2.
> +	 */
> +	cxl->cxlds.media_ready = true;
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 13d448686189..3b9c8cb187a3 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -70,6 +70,10 @@ struct cxl_regs {
>  	);
>  };
>  
> +#define   CXL_CM_CAP_CAP_ID_RAS 0x2
> +#define   CXL_CM_CAP_CAP_ID_HDM 0x5
> +#define   CXL_CM_CAP_CAP_HDM_VERSION 1
> +
>  struct cxl_reg_map {
>  	bool valid;
>  	int id;
> @@ -223,4 +227,20 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>  		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
>  						      sizeof(drv_struct), mbox);	\
>  	})
> +
> +/**
> + * cxl_map_component_regs - map cxl component registers
> + *
> + *
> + * @map: cxl register map to update with the mappings
> + * @regs: cxl component registers to work with
> + * @map_mask: cxl component regs to map
> + *
> + * Returns integer: success (0) or error (-ENOMEM)
> + *
> + * Made public for Type2 driver support.
> + */
> +int cxl_map_component_regs(const struct cxl_register_map *map,
> +			   struct cxl_component_regs *regs,
> +			   unsigned long map_mask);
>  #endif /* __CXL_CXL_H__ */
> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> index d31e1363e1fd..bd12e29bcdc9 100644
> --- a/include/cxl/pci.h
> +++ b/include/cxl/pci.h
> @@ -23,3 +23,18 @@
>  #define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
>  
>  #endif
> +
> +/* Register Block Identifier (RBI) */
> +enum cxl_regloc_type {
> +	CXL_REGLOC_RBI_EMPTY = 0,
> +	CXL_REGLOC_RBI_COMPONENT,
> +	CXL_REGLOC_RBI_VIRT,
> +	CXL_REGLOC_RBI_MEMDEV,
> +	CXL_REGLOC_RBI_PMU,
> +	CXL_REGLOC_RBI_TYPES
> +};
> +
> +struct cxl_register_map;
> +
> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		       struct cxl_register_map *map);


