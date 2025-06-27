Return-Path: <netdev+bounces-201843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE30AEB275
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7487641162
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 09:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4CD293C44;
	Fri, 27 Jun 2025 09:10:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E44225F787;
	Fri, 27 Jun 2025 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751015431; cv=none; b=oN6LMgFYR97+BSUhGbcRMRCt6EF+OC8zs+XACa+OJOEevbezYBkk56vzzKLhiG7QrvJNK9IAJhKiI779QCCphTJ6dgpDwE15I4DDT/Q5n9bJB1broCAgyvjU6nVFbeL+iiMXqJVmiqatW02bINumITSfp5/5bVFBzcH5u9Vdxso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751015431; c=relaxed/simple;
	bh=x1qlRLAUX2JfC3QK4PWPHOZELj9cF1OUPK7Twf9axK0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pl80/X9uOu0gXPj5gIuHdr5aqObye+EPdUgFv5Xx80zio79YVotME83NotgBDSLeS9vx5gfAbTxNYwfaI2LpEjtpbNSorJtydnZtZErz7Y0dXvJ5RD+STXPUwGfPRhz3KjZJQZaoVfagUZgsCc59yzCqo3qvXzI/Brqb9D94Pk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bT8sP3Cccz67g19;
	Fri, 27 Jun 2025 17:10:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DE9E14011D;
	Fri, 27 Jun 2025 17:10:26 +0800 (CST)
Received: from localhost (10.48.153.213) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 27 Jun
 2025 11:10:25 +0200
Date: Fri, 27 Jun 2025 10:10:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>
Subject: Re: [PATCH v17 12/22] sfc: get endpoint decoder
Message-ID: <20250627101024.00002585@huawei.com>
In-Reply-To: <20250624141355.269056-13-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
	<20250624141355.269056-13-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 24 Jun 2025 15:13:45 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for getting DPA (Device Physical Address) to use through an
> endpoint decoder.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/net/ethernet/sfc/Kconfig   |  1 +
>  drivers/net/ethernet/sfc/efx_cxl.c | 32 +++++++++++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
> index 979f2801e2a8..e959d9b4f4ce 100644
> --- a/drivers/net/ethernet/sfc/Kconfig
> +++ b/drivers/net/ethernet/sfc/Kconfig
> @@ -69,6 +69,7 @@ config SFC_MCDI_LOGGING
>  config SFC_CXL
>  	bool "Solarflare SFC9100-family CXL support"
>  	depends on SFC && CXL_BUS >= SFC
> +	depends on CXL_REGION
>  	default SFC
>  	help
>  	  This enables SFC CXL support if the kernel is configuring CXL for
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index e2d52ed49535..c0adfd99cc78 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -22,6 +22,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  {
>  	struct efx_nic *efx = &probe_data->efx;
>  	struct pci_dev *pci_dev = efx->pci_dev;
> +	resource_size_t max_size;
>  	struct efx_cxl *cxl;
>  	u16 dvsec;
>  	int rc;
> @@ -86,13 +87,42 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return PTR_ERR(cxl->cxlmd);
>  	}
>  
> +	cxl->endpoint = cxl_acquire_endpoint(cxl->cxlmd);
> +	if (IS_ERR(cxl->endpoint))
> +		return PTR_ERR(cxl->endpoint);
> +
> +	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
> +					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
> +					   &max_size);
> +
> +	if (IS_ERR(cxl->cxlrd)) {
> +		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
> +		rc = PTR_ERR(cxl->cxlrd);
> +		goto endpoint_release;
> +	}
> +
> +	if (max_size < EFX_CTPIO_BUFFER_SIZE) {
> +		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
> +			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
> +		rc = -ENOSPC;
> +		goto put_root_decoder;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
> -	return 0;
> +	goto endpoint_release;
I'd avoid the spiders nest here and just duplicate the release
or if you really want to avoid that duplication, factor out everything where
it is held into another function and have aqcuire/function/release as all that
is seen here.


> +
> +put_root_decoder:
> +	cxl_put_root_decoder(cxl->cxlrd);
> +endpoint_release:
> +	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
> +	return rc;
>  }
>  
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
> +	if (probe_data->cxl)
> +		cxl_put_root_decoder(probe_data->cxl->cxlrd);
>  }
>  
>  MODULE_IMPORT_NS("CXL");


