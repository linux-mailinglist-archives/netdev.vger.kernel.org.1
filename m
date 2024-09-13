Return-Path: <netdev+bounces-128208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A81978798
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 20:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5787628A86E
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 18:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214D7126C01;
	Fri, 13 Sep 2024 18:10:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5346A1369AA;
	Fri, 13 Sep 2024 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726251017; cv=none; b=kAx0Rx/UL5k8k/s4XVZVZQ928laWNh1RexEIhb2/j52pE6KIsd3WaZ1ZYkz5kRNg0Zfish4gLIWM/TP1G015yieZupM8uHB35CSyv+5+PnPP0gSOlvXKfTGnaji4uZUmf0BkSYHI6tZJH/DTV8g1OHnDjsTYzAVr28F/wP9191o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726251017; c=relaxed/simple;
	bh=O8scwiWyAnwSXutpVNoqI/DhWOLcnKhK8KKLUO66aLo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCQ0/erAU8EVHATxexOsJmzoJMxY1Nb5JKWFndD3bFw94HhgklLrcHetWUD1gvBsDJ+3UPWmXCYz88yYZCTefqB85Yhjfa9VK7KPm/SBizMUTMWFUvIOXRKxDliVD8pYRq3zFxhYtPFSFe3TdCjfYVIo3+awIdayG3gNEss2qyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X52L73fccz6K5nT;
	Sat, 14 Sep 2024 02:06:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2BBDE140B3C;
	Sat, 14 Sep 2024 02:10:12 +0800 (CST)
Received: from localhost (10.48.150.243) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Sep
 2024 20:10:11 +0200
Date: Fri, 13 Sep 2024 19:10:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v3 20/20] efx: support pio mapping based on cxl
Message-ID: <20240913191009.00001eec@Huawei.com>
In-Reply-To: <20240907081836.5801-21-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
	<20240907081836.5801-21-alejandro.lucero-palau@amd.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 7 Sep 2024 09:18:36 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> With a device supporting CXL and successfully initialised, use the cxl
> region to map the memory range and use this mapping for PIO buffers.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
One trivial thing.

> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index dd2dbfb8ba15..ef57f833b8a7 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -21,9 +21,9 @@
>  int efx_cxl_init(struct efx_nic *efx)
>  {
>  	struct pci_dev *pci_dev = efx->pci_dev;
> +	resource_size_t start, end, max = 0;
>  	struct efx_cxl *cxl;
>  	struct resource res;
> -	resource_size_t max;
>  	u16 dvsec;
>  	int rc;
>  
> @@ -132,10 +132,27 @@ int efx_cxl_init(struct efx_nic *efx)
>  		goto err_region;
>  	}
>  
> +	rc = cxl_get_region_params(cxl->efx_region, &start, &end);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL getting regions params failed");
> +		goto err_map;
> +	}
> +
> +	cxl->ctpio_cxl = ioremap(start, end - start);
> +	if (!cxl->ctpio_cxl) {
> +		pci_err(pci_dev, "CXL ioremap region failed");
> +		rc = -EIO;
> +		goto err_map;
> +	}
> +
> +	efx->efx_cxl_pio_initialised = true;
> +
>  	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>  
>  	return 0;
>  
> +err_map:
> +		cxl_region_detach(cxl->cxled);

Odd looking indent.

>  err_region:
>  	cxl_dpa_free(efx->cxl->cxled);
>  err_release:

