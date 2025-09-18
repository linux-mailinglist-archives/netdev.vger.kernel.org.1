Return-Path: <netdev+bounces-224472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFBBB8560B
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512EB1896AF3
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB1D2236E0;
	Thu, 18 Sep 2025 14:53:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DE4223702;
	Thu, 18 Sep 2025 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207231; cv=none; b=D4jDDPMpKFph77Z8vZ90GFImpT80v8KjWig2Zr2K07NyWNeoDDZJXIHXugdkpXBliZ7CP8L+2L0HjSLXDOMoUChpR25DllOJlpItUsx+QGb3IoEBASTm0GN8hsoLxEMN9kDBj3f4VnIFI+Cd0LipHpb9Zh3UhUZAhFDGZzKZKVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207231; c=relaxed/simple;
	bh=9uweKD5nptRoV8TQF3BhFreSe9aWWZOS3tbSqP8xL2k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTbosIK8C4MxhjzgBNcd2ri+NmjTFyBsmrdsgRbl4pGrTSXvoO8/0vbEbys7GXmjTy+9iQtPaRZldgSEBzSQJVZ+XEUQuEgg7ZzQLu0s1yZzs96vsLfqmOAcmF0l/52+ZPtTwvhwtAJgi3iDD/TK6/2ymQk2XUt6mETD6WenpB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cSJWZ2cp3z6GDCk;
	Thu, 18 Sep 2025 22:52:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 55B8E1402F5;
	Thu, 18 Sep 2025 22:53:46 +0800 (CST)
Received: from localhost (10.47.69.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Sep
 2025 16:53:45 +0200
Date: Thu, 18 Sep 2025 15:53:44 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>
Subject: Re: [PATCH v18 12/20] sfc: get endpoint decoder
Message-ID: <20250918155344.00000483@huawei.com>
In-Reply-To: <20250918091746.2034285-13-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
	<20250918091746.2034285-13-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 18 Sep 2025 10:17:38 +0100
alejandro.lucero-palau@amd.com wrote:

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
>  drivers/net/ethernet/sfc/efx_cxl.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index d29594e71027..4461b7a4dc2c 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -99,16 +99,23 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  
>  	if (IS_ERR(cxl->cxlrd)) {
>  		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
> -		cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
> -		return PTR_ERR(cxl->cxlrd);
> +		rc = PTR_ERR(cxl->cxlrd);
> +		goto err_release;

Push back into patch 10.  I was wondering why you didn't do this there, thn
found it here.


>  	}
>  
>  	if (max_size < EFX_CTPIO_BUFFER_SIZE) {
>  		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
>  			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
> -		cxl_put_root_decoder(cxl->cxlrd);
> -		cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
> -		return -ENOSPC;
> +		rc = -ENOSPC;
> +		goto err_decoder;
> +	}
> +
> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
> +				     EFX_CTPIO_BUFFER_SIZE);
> +	if (IS_ERR(cxl->cxled)) {
> +		pci_err(pci_dev, "CXL accel request DPA failed");
> +		rc = PTR_ERR(cxl->cxled);
> +		goto err_decoder;
>  	}
>  
>  	probe_data->cxl = cxl;
> @@ -116,12 +123,21 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>  
>  	return 0;
> +
> +err_decoder:
> +	cxl_put_root_decoder(cxl->cxlrd);
> +err_release:
> +	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
> +
> +	return rc;
>  }
>  
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
> -	if (probe_data->cxl)
> +	if (probe_data->cxl) {
> +		cxl_dpa_free(probe_data->cxl->cxled);
>  		cxl_put_root_decoder(probe_data->cxl->cxlrd);
> +	}
>  }
>  
>  MODULE_IMPORT_NS("CXL");


