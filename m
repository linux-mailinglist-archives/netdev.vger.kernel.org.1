Return-Path: <netdev+bounces-224384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B30C1B8441C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2273AEF85
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE402C21C5;
	Thu, 18 Sep 2025 11:03:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B7123ABA0;
	Thu, 18 Sep 2025 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193434; cv=none; b=KUdWaJrTYztmVC2M/WGbnA4EqYoXimE1YXOQzO2CW5detJdiU1eEee10KoQmpwX1BOme2Ii4Bui8YtHwq+mA/8iGD+9P1t8BoK/6calYKpDBFgvBPQGNJSYyfX6uSgjCfluwNt8JlzpDy8gVKNVFNzE2cTcO4T/jRYRFG0EY5J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193434; c=relaxed/simple;
	bh=vZ27UZSOdjZFV9ZhpwWDMn+XX4Te/OeGtMFC7KZh1qE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPR4uEO5Ne81+sWy1Hw9BWC8JGAhfmTZo/48z8fFWMWyNdFCV8v+1kLyifHqCysYBekkHNGYRPHcNkxCt34UcTMG+/ep2SgOpXzVlBGa+ID5tyOQ8/UwSYxuzQAbogDrR4ntp8OzcjGjTa9MgJpEkLuSSfwd+qxQ5RtTqaIvNUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cSCNr0qR3z6M56b;
	Thu, 18 Sep 2025 19:01:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E78A140114;
	Thu, 18 Sep 2025 19:03:50 +0800 (CST)
Received: from localhost (10.47.69.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Sep
 2025 13:03:49 +0200
Date: Thu, 18 Sep 2025 12:03:48 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v18 04/20] cxl: allow Type2 drivers to map cxl component
 regs
Message-ID: <20250918120348.000028a5@huawei.com>
In-Reply-To: <20250918091746.2034285-5-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
	<20250918091746.2034285-5-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
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

On Thu, 18 Sep 2025 10:17:30 +0100
alejandro.lucero-palau@amd.com wrote:

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

Why the mix of dev_err() and dev_err_probe()?
I'd prefer dev_err_probe() for all these, but we definitely don't
want a mix.

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

> +/**
> + * cxl_map_component_regs - map cxl component registers
> + *

Why 2 blank lines?

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
		       struct cxl_register_map *map);


