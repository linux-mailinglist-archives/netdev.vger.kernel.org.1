Return-Path: <netdev+bounces-179359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A9DA7C1A4
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 18:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66CD63B71FC
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA25E27702;
	Fri,  4 Apr 2025 16:38:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F046620C478;
	Fri,  4 Apr 2025 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743784725; cv=none; b=PJ80lVmZDhgDrq7dsyoR9fiUrJZGoABGPoktZvH6aJznh/QuqDhDvfWv7ndIdpf1MZB4aIMAv9Y2lgmmQUsWfnK1/JSrJGMigrxlEjP5gWc1cGGXllh/TnzO26Cn8xXAsmlQGedq4IxUhJmW1FeFwotoMzG0BRZVJMgNlRcm5dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743784725; c=relaxed/simple;
	bh=yP/ZjayRXnT7af03ohUV8grz/7rZ0jo1uAt/J0gc0cg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFUP9lW2minZycBp6nya/HPEg0WrZPPuKaiCZIWxb/KAyUeUShiBWTxwl8mRlLrDt8mQZh4dLWgOxJJixfBBXgdlXM2NItCRgqOmH7SqNqgtuNqxfCkvVkRdL8nVihm+uz4eIgIfZsN8BHMXcoLgmrdM+kFtaqBsHJ5rkZYpYgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTkjH5MPJz6K9GF;
	Sat,  5 Apr 2025 00:34:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BD4D614062A;
	Sat,  5 Apr 2025 00:38:40 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 18:38:40 +0200
Date: Fri, 4 Apr 2025 17:38:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>
Subject: Re: [PATCH v12 12/23] sfc: obtain root decoder with enough HPA free
 space
Message-ID: <20250404173838.00002ebb@huawei.com>
In-Reply-To: <20250331144555.1947819-13-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
	<20250331144555.1947819-13-alejandro.lucero-palau@amd.com>
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

On Mon, 31 Mar 2025 15:45:44 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Asking for available HPA space is the previous step to try to obtain
> an HPA range suitable to accel driver purposes.
> 
> Add this call to efx cxl initialization.
> 
> Make sfc cxl build dependent on CXL region.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/net/ethernet/sfc/Kconfig   |  1 +
>  drivers/net/ethernet/sfc/efx_cxl.c | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
> index c5fb71e601e7..7a23d6d6d85f 100644
> --- a/drivers/net/ethernet/sfc/Kconfig
> +++ b/drivers/net/ethernet/sfc/Kconfig
> @@ -68,6 +68,7 @@ config SFC_MCDI_LOGGING
>  config SFC_CXL
>  	bool "Solarflare SFC9100-family CXL support"
>  	depends on SFC && CXL_BUS >= SFC
> +	depends on CXL_REGION
>  	default SFC
>  	help
>  	  This enables SFC CXL support if the kernel is configuring CXL for
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 5a08a2306784..4395435af576 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -24,6 +24,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	struct pci_dev *pci_dev = efx->pci_dev;
>  	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
>  	DECLARE_BITMAP(found, CXL_MAX_CAPS);
> +	resource_size_t max_size;
>  	struct efx_cxl *cxl;
>  	u16 dvsec;
>  	int rc;
> @@ -89,6 +90,24 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return rc;
>  	}
>  
> +	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
> +					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
> +					   &max_size);
> +
> +	if (IS_ERR(cxl->cxlrd)) {
> +		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
> +		rc = PTR_ERR(cxl->cxlrd);
> +		return rc;

		return PTR_ERR(cxl->cxlrd);

> +	}
> +
> +	if (max_size < EFX_CTPIO_BUFFER_SIZE) {
> +		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
> +			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
> +		rc = -ENOSPC;
> +		cxl_put_root_decoder(cxl->cxlrd);
> +		return rc;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> @@ -96,6 +115,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
> +	if (probe_data->cxl)
> +		cxl_put_root_decoder(probe_data->cxl->cxlrd);
>  }
>  
>  MODULE_IMPORT_NS("CXL");


