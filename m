Return-Path: <netdev+bounces-228120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FE6BC1CD0
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 16:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CE73C600D
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 14:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0752E22AA;
	Tue,  7 Oct 2025 14:48:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A381F3BA4;
	Tue,  7 Oct 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759848533; cv=none; b=AgE1Z0cvuL1SZnYuMQUKQgpPPdzx81D0qw1W4NiGPRmbHKZx7Mp853b/ijwPFN56J1BcaFgOE3luH39OKBf17f+XmHAhah73XXrHkqkOI2lq9LIsHwxOQnC3Wn9mrVYVQhtwndXsMeXYL3rE2KfKhpLM5Skfda9BcxjDoccpBlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759848533; c=relaxed/simple;
	bh=GbohJzvoF/RWStEEwW0bxrrygeXPuLEjKhqDVIx54AA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHc0uMXl0CZpnT9pjD/RwU5ErlNwZJGREQcvduwVP7ehvx464X2nijFl/mLzQv834qHbna+JT6MoIwKYPcliJLW78GEBZkieZBtB/MxkDLJfo4kuI3jiORuJqEYhhWKax2w/Lbo7sYD9PyP2Rsc7L6qL2S1iBBZsX2HvBbWxjnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cgzXC5Qx7z6L4vv;
	Tue,  7 Oct 2025 22:48:11 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3AC54140159;
	Tue,  7 Oct 2025 22:48:48 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 7 Oct
 2025 15:48:47 +0100
Date: Tue, 7 Oct 2025 15:48:45 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v19 22/22] sfc: support pio mapping based on cxl
Message-ID: <20251007154845.00001afa@huawei.com>
In-Reply-To: <20251006100130.2623388-23-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
	<20251006100130.2623388-23-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 6 Oct 2025 11:01:30 +0100
<alejandro.lucero-palau@amd.com> wrote:

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

A few minor things inline.  The ifdef complexity in here is moderately
nasty though.  Might be worth seeing if any of that can be moved
to stubs or IS_ENABLED() checks.


> diff --git a/drivers/net/ethernet/sfc/efx.h b/drivers/net/ethernet/sfc/efx.h
> index 45e191686625..057d30090894 100644
> --- a/drivers/net/ethernet/sfc/efx.h
> +++ b/drivers/net/ethernet/sfc/efx.h
> @@ -236,5 +236,4 @@ static inline bool efx_rwsem_assert_write_locked(struct rw_semaphore *sem)
>  
>  int efx_xdp_tx_buffers(struct efx_nic *efx, int n, struct xdp_frame **xdpfs,
>  		       bool flush);
> -

stray change that you should clean out.

>  #endif /* EFX_EFX_H */
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

It's a somewhat trivial thing but you could reduce churn by
moving the err_dpa block introduction back to where this lot
was first added. 

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
>  
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
> -	if (probe_data->cxl) {
> +	if (probe_data->cxl_pio_initialised) {
> +		iounmap(probe_data->cxl->ctpio_cxl);
>  		cxl_decoder_detach(NULL, probe_data->cxl->cxled, 0,
>  				   DETACH_INVALIDATE);
>  		cxl_dpa_free(probe_data->cxl->cxled);

