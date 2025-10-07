Return-Path: <netdev+bounces-228117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5682DBC1AA4
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 16:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CF93C35FB
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 14:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE99225785;
	Tue,  7 Oct 2025 14:13:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF62D5A0C;
	Tue,  7 Oct 2025 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846423; cv=none; b=WuogLXHuziFtG311vBGXn/EQtnwfs3wDwqeQeOBYVWdfCWgGXJx2Lb3K6KUxa5HuGKMPpcox44OkI+/bbOhd768bMa2F4BMw8P2OFJc+/QReg61H/iowG0CLDIW2svjI4GAcjz0Rq2UZKmwYp4SIx4gJ1aqwZxFOXqadPsSR/hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846423; c=relaxed/simple;
	bh=8cm5JC30SqgFnQ5eP1t5j7lLzHLnv8qZ9s7g7D6AfDE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIYtDvQEkodNdjdkbmD1WHv9YgjHFNEX+rbleJ70mGcYUd2QlHVs5BC8kuw+BWIDmB65Ob5vKHMwsl87+w1A57TgIk6XUbPX3DK89RCSKn4NUCsT6nCHFGD5XJr1sZKuyjAePcUFzEvzt7poP/K/oq5aAG42Gc3nPehUaP5JWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cgyjS3ZmCz6L4wR;
	Tue,  7 Oct 2025 22:11:08 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9902C140159;
	Tue,  7 Oct 2025 22:13:38 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 7 Oct
 2025 15:13:37 +0100
Date: Tue, 7 Oct 2025 15:13:36 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v19 20/22] sfc: create cxl region
Message-ID: <20251007151336.00003dc3@huawei.com>
In-Reply-To: <20251006100130.2623388-21-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
	<20251006100130.2623388-21-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 6 Oct 2025 11:01:28 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for creating a region using the endpoint decoder related to
> a DPA range.
> 
> Add a callback for unwinding sfc cxl initialization when the endpoint port
> is destroyed by potential cxl_acpi or cxl_mem modules removal.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 1a50bb2c0913..79fe99d83f9f 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -116,6 +116,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return PTR_ERR(cxl->cxled);
>  	}
>  
> +	cxl->efx_region = cxl_create_region(cxl->cxlrd, &cxl->cxled, 1);

This follows from earlier comment on patch 18.  I think cxl->cxled is the right
thing to pass in here rather than pretending it's an array by passing
in a pointer to that.

> +	if (IS_ERR(cxl->efx_region)) {
> +		pci_err(pci_dev, "CXL accel create region failed");
> +		cxl_put_root_decoder(cxl->cxlrd);
> +		cxl_dpa_free(cxl->cxled);
> +		return PTR_ERR(cxl->efx_region);
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> @@ -124,6 +132,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
>  	if (probe_data->cxl) {
> +		cxl_decoder_detach(NULL, probe_data->cxl->cxled, 0,
> +				   DETACH_INVALIDATE);
>  		cxl_dpa_free(probe_data->cxl->cxled);
>  		cxl_put_root_decoder(probe_data->cxl->cxlrd);
>  	}


