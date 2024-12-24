Return-Path: <netdev+bounces-154216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8869FC125
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 19:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D1918841F5
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 18:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F461BC9FF;
	Tue, 24 Dec 2024 18:06:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E57E1B87FF;
	Tue, 24 Dec 2024 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735063569; cv=none; b=cRrEN5CZRLdPE/UHSi1+et3b+lEY2Tpp7haX8muSccIVpRh3vLhoWnxOyCRumUde5HYEtFYQPU52niwLiHlyNuxHx2cgeUUYRpwJkCQJwdbYni1H5QOX+mrOh0yBmpNOtxW2H32Heo1xPpysLBbzpIZF2RSp3fljuMC0wiDPm9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735063569; c=relaxed/simple;
	bh=Myoou16ns28P6TpPCXf2DN3kM7+OtN9VJtU493Ilu8k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3ICNEWrU6PgmUMuodu9mNyzlFKPVK0enMOBXL+uFEmNu93ykYgB6dnI7Zto9qiffs7Xv6QEMDldn52EZpSziDICLxF/zCimwC5/RRXDxEXLyUchfCSXgfzkAW7+7Ml7wtHC4bBonnYpEMUfAM9HvWqLK6Ml7zZZ0NVkgdKv0yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHjVY0BHsz6K6kK;
	Wed, 25 Dec 2024 02:05:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C01A140AE5;
	Wed, 25 Dec 2024 02:06:01 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 19:06:00 +0100
Date: Tue, 24 Dec 2024 18:05:58 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>, Alejandro
 Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 24/27] sfc: create cxl region
Message-ID: <20241224180558.00004715@huawei.com>
In-Reply-To: <20241216161042.42108-25-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
	<20241216161042.42108-25-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 16 Dec 2024 16:10:39 +0000
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for creating a region using the endpoint decoder related to
> a DPA range specifying no DAX device should be created.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Other than the question of whether the no_dax flag is useful
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 724bca59b4d4..7367ba28a40f 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -129,10 +129,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err_memdev;
>  	}
>  
> +	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled, true);
> +	if (IS_ERR(cxl->efx_region)) {
> +		pci_err(pci_dev, "CXL accel create region failed");
> +		rc = PTR_ERR(cxl->efx_region);
> +		goto err_region;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
>  
> +err_region:
> +	cxl_dpa_free(cxl->cxled);
>  err_memdev:
>  	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
>  err_resource_set:
> @@ -145,6 +154,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
>  	if (probe_data->cxl) {
> +		cxl_accel_region_detach(probe_data->cxl->cxled);
>  		cxl_dpa_free(probe_data->cxl->cxled);
>  		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
>  		kfree(probe_data->cxl->cxlds);


