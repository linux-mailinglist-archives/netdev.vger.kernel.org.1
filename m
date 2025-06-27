Return-Path: <netdev+bounces-201844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB079AEB277
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D12F560522
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 09:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40146293C67;
	Fri, 27 Jun 2025 09:11:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D1125F985;
	Fri, 27 Jun 2025 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751015481; cv=none; b=SxlIsyuoexSJZl7pWChZH7hxFQqk1RTQKXeJinmM04XYM8vWXm5rl1Z9rFod0PiaokQo28i+Ksl5lM6Ll4pnBIKFP/LGlGz2z1DSpYWH4Z6elFougU78jQiFYGLnTTWJtkNh9IBELg9u1JWf7i0bpA3ekCJtC3FmnvHHrhZE0Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751015481; c=relaxed/simple;
	bh=e3hP2N3t0Ieihq9lcC3QcCEEBpiUnNWfjYc9jNwJNtg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mv+0X6j1zWCogwaTUpMHdCCzzlTvyZT4R5GQlbC9FYodlrij8yzgSx1WPtdjsNwZbjRhCQSHMUDnySE99Ma5pR8HV2MNOzc+bhGuPJAaoyXSYCS2NXw5Mn14cpaJIUxGno4SISnVQfUqBHEBPYRFVN1Xu7nKdsRS5b0g3lIJkPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bT8qW4Gj1z6L5Jn;
	Fri, 27 Jun 2025 17:08:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9318E1404C6;
	Fri, 27 Jun 2025 17:11:17 +0800 (CST)
Received: from localhost (10.48.153.213) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 27 Jun
 2025 11:11:16 +0200
Date: Fri, 27 Jun 2025 10:11:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>
Subject: Re: [PATCH v17 14/22] sfc: get endpoint decoder
Message-ID: <20250627101115.00005c40@huawei.com>
In-Reply-To: <20250624141355.269056-15-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
	<20250624141355.269056-15-alejandro.lucero-palau@amd.com>
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

On Tue, 24 Jun 2025 15:13:47 +0100
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
>  drivers/net/ethernet/sfc/efx_cxl.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index c0adfd99cc78..ffbf0e706330 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -108,6 +108,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto put_root_decoder;
>  	}
>  
> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
> +				     EFX_CTPIO_BUFFER_SIZE);
> +	if (IS_ERR(cxl->cxled)) {
> +		pci_err(pci_dev, "CXL accel request DPA failed");
> +		rc = PTR_ERR(cxl->cxled);
> +		goto put_root_decoder;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	goto endpoint_release;
> @@ -121,8 +129,10 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
> -	if (probe_data->cxl)
> +	if (probe_data->cxl) {
Given this is going to get more complex I'd be tempted to go with early exist
approach for !cxl

	if (!probe_data->cxl)
		return;

	cxl_dpa_free()
etc.

> +		cxl_dpa_free(probe_data->cxl->cxled);
>  		cxl_put_root_decoder(probe_data->cxl->cxlrd);
> +	}
>  }
>  
>  MODULE_IMPORT_NS("CXL");


