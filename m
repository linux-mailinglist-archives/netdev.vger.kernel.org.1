Return-Path: <netdev+bounces-154203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F359FC0F0
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 18:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3263518836BB
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 17:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3800B14D433;
	Tue, 24 Dec 2024 17:27:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B71FF5F3;
	Tue, 24 Dec 2024 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735061231; cv=none; b=BwM66nqMjggqQ6HhH1WI/e4Z2QEMclI2BKyJOrw3YkAwS+N1lKjNwu4Wb4tVHPlECirUbtfEgegMqVo+6javzrY6XfrjcOhrDt4oqvv7bkBbsUF5ZcaRiNP9Unw+JfoSvmYNvpCoP4pwxF9k98mFxKx/DfhRHlwolA8BptuMefk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735061231; c=relaxed/simple;
	bh=m6sn8TeXARmQhXOGWHJu/d002DcnquA5UOiVcMF67E0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8287Zw3OJwBBIPMYoN+EW49JpqfuNUhWk+Kys0MoqcKcWvLEmmCTpIqnVtCpCladyB3iY7JTNveRtbx4zthnwGNGdfqEVqAUcJ3318Cduk7cEf2KIwKh+k++mkF4bV03XVHRDt/glORGICqtMxxU08OCl/P4+e61gQBgXwuK28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHhYY0N3nz6K983;
	Wed, 25 Dec 2024 01:23:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 79356140736;
	Wed, 25 Dec 2024 01:27:06 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 18:27:05 +0100
Date: Tue, 24 Dec 2024 17:27:03 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>, Alejandro
 Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 09/27] sfc: request cxl ram resource
Message-ID: <20241224172703.00004fa3@huawei.com>
In-Reply-To: <20241216161042.42108-10-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
	<20241216161042.42108-10-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 16 Dec 2024 16:10:24 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl accessor for obtaining the ram resource the device advertises.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index d9a52343553a..eaa46ddb50e3 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -85,6 +85,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err_resource_set;
>  	}
>  
> +	rc = cxl_request_resource(cxl->cxlds, CXL_RES_RAM);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL request resource failed");
> +		goto err_resource_set;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> @@ -99,6 +105,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
>  	if (probe_data->cxl) {
> +		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
>  		kfree(probe_data->cxl->cxlds);
>  		kfree(probe_data->cxl);
>  	}


