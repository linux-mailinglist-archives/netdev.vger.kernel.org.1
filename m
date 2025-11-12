Return-Path: <netdev+bounces-238063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DD5C536B7
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 17:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1915A352050
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 16:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B3233B6F3;
	Wed, 12 Nov 2025 16:24:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CADA2D3233;
	Wed, 12 Nov 2025 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964685; cv=none; b=sJKeIxih2Mdkgxp3ZZ2yOiJLKM2p6Jr+a7aykiYlyA0SRZtfG4y4CDnfTlAksAeLdiFYbF18nfkmNiPCdlwijZgqp/J1S7lDiGmLSlcpulYuwGEtW6KPXmsVm0dKngVIWh/QnrHULeEluKhf64rqoFzIXuS0bzJsRB+wm9yUN+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964685; c=relaxed/simple;
	bh=JE3oMv4YnUFo9jCU6sfzYuoxpQAjOfKoehpW0EECicg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPYLYtc3t2JK9F2gycx6cKtlqIi99LpdzSqwJFk7pp+H7TqdWunpseQ8rLZxysxS+3pmBeUgivb/ABMTKjAU6QaV3m6zyupnk+V+NQsrllkzNJ/QvKJ3218iKgxpDx0Luh/6B7Q3PmKLmsV23l3RiQSzMr6bEavjyHpX9/31nco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d67yX3GM9zHnGhQ;
	Thu, 13 Nov 2025 00:24:20 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id C96E31400FD;
	Thu, 13 Nov 2025 00:24:39 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 12 Nov
 2025 16:24:39 +0000
Date: Wed, 12 Nov 2025 16:24:37 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v20 22/22] sfc: support pio mapping based on cxl
Message-ID: <20251112162437.00001859@huawei.com>
In-Reply-To: <20251110153657.2706192-23-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
	<20251110153657.2706192-23-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 10 Nov 2025 15:36:57 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> A PIO buffer is a region of device memory to which the driver can write a
> packet for TX, with the device handling the transmit doorbell without
> requiring a DMA for getting the packet data, which helps reducing latency
> in certain exchanges. With CXL mem protocol this latency can be lowered
> further.
> 
> With a device supporting CXL and successfully initialised, use the cxl
> region to map the memory range and use this mapping for PIO buffers.
> 
> Add the disabling of those CXL-based PIO buffers if the callback for
> potential cxl endpoint removal by the CXL code happens.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
One comment on something I thought you meant you were changing for v20
but haven't.  Not important, so either way:
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 79fe99d83f9f..a84ce45398c1 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -11,6 +11,7 @@
>  #include <cxl/pci.h>
>  #include "net_driver.h"
>  #include "efx_cxl.h"
> +#include "efx.h"
>  
>  #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
>  
> @@ -20,6 +21,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	struct pci_dev *pci_dev = efx->pci_dev;
>  	resource_size_t max_size;
>  	struct efx_cxl *cxl;
> +	struct range range;
>  	u16 dvsec;
>  	int rc;
>  
> @@ -119,19 +121,40 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	cxl->efx_region = cxl_create_region(cxl->cxlrd, &cxl->cxled, 1);
>  	if (IS_ERR(cxl->efx_region)) {
>  		pci_err(pci_dev, "CXL accel create region failed");
> -		cxl_put_root_decoder(cxl->cxlrd);
> -		cxl_dpa_free(cxl->cxled);
> -		return PTR_ERR(cxl->efx_region);
> +		rc = PTR_ERR(cxl->efx_region);
> +		goto err_dpa;

I thought you agreed with moving this err_dpa path into the earlier patch to
reduce churn.  Maybe you already had v20 ready when you replied to the late
v19 feedback on this.  I don't mind much either way as its just a really
minor patch churn thing.

> +	}
> +
> +	rc = cxl_get_region_range(cxl->efx_region, &range);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL getting regions params failed");
> +		goto err_detach;
> +	}
> +
> +	cxl->ctpio_cxl = ioremap(range.start, range.end - range.start + 1);
> +	if (!cxl->ctpio_cxl) {
> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
> +		rc = -ENOMEM;
> +		goto err_detach;
>  	}
>  
>  	probe_data->cxl = cxl;
> +	probe_data->cxl_pio_initialised = true;
>  
>  	return 0;
> +
> +err_detach:
> +	cxl_decoder_detach(NULL, cxl->cxled, 0, DETACH_INVALIDATE);
> +err_dpa:
> +	cxl_put_root_decoder(cxl->cxlrd);
> +	cxl_dpa_free(cxl->cxled);
> +	return rc;
>  }

