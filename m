Return-Path: <netdev+bounces-201850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAD6AEB317
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32411BC4B41
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 09:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B37127F002;
	Fri, 27 Jun 2025 09:38:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87228233714;
	Fri, 27 Jun 2025 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751017116; cv=none; b=iYkDm/Dj7lyLURuhzt+v3C8Smh+8tscnFkBcvFX6ISOISNoaMWJbc9Ku3eev6SNjzXQgR+xDQDhLyBYzGtun7ltfUPpftrdEpM6SMrBt4pMBhy/YtKr+6Pu0eZuSmydosxrGW+tuHIQK1njG5sP3wjM/qkt2RrP/fzdo9KBg6nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751017116; c=relaxed/simple;
	bh=1eUisCKFTwEUjSa26MUDrt/BGeEigHFy838+cr/QNhs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GpwWfCa4oi5g4e150eF3MyEBlpckNMJ0wL9hvwgYp7P7nj7g5TPTB0eVRnPEb1avjnhcyq+DQPvDLMKfnWxddDnWekPkCS3g5Sq+tvIwCLGrh5Vpu4tKQ3IiGzRZClCfTzbIDl569pPIDlkyxv+GPH6F9ICeAEnPMPz0kXAjlKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bT9T256Ycz6M57j;
	Fri, 27 Jun 2025 17:37:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2FD2314011D;
	Fri, 27 Jun 2025 17:38:31 +0800 (CST)
Received: from localhost (10.48.153.213) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 27 Jun
 2025 11:38:30 +0200
Date: Fri, 27 Jun 2025 10:38:28 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v17 20/22] sfc: create cxl region
Message-ID: <20250627103828.000000c7@huawei.com>
In-Reply-To: <20250624141355.269056-21-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
	<20250624141355.269056-21-alejandro.lucero-palau@amd.com>
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

On Tue, 24 Jun 2025 15:13:53 +0100
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
>  drivers/net/ethernet/sfc/efx_cxl.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index ffbf0e706330..7365effe974e 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -18,6 +18,16 @@
>  
>  #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
>  
> +static void efx_release_cxl_region(void *priv_cxl)
> +{
> +	struct efx_probe_data *probe_data = priv_cxl;
> +	struct efx_cxl *cxl = probe_data->cxl;
> +
> +	iounmap(cxl->ctpio_cxl);
> +	cxl_put_root_decoder(cxl->cxlrd);
> +	probe_data->cxl_pio_initialised = false;
> +}
> +
>  int efx_cxl_init(struct efx_probe_data *probe_data)
>  {
>  	struct efx_nic *efx = &probe_data->efx;
> @@ -116,10 +126,21 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto put_root_decoder;
>  	}
>  
> +	cxl->efx_region = cxl_create_region(cxl->cxlrd, &cxl->cxled, 1,
> +					    efx_release_cxl_region,

As per earlier comment - given when it's released, I'd register the devm callback
out here not in cxl_create_region(). Might irritate the net maintainers though
as it would be a devm callback registered in non CXL code, but I don't think
that is a reason to jump through the hoops you currently have.


> +					    &probe_data);
> +	if (IS_ERR(cxl->efx_region)) {
> +		pci_err(pci_dev, "CXL accel create region failed");
> +		rc = PTR_ERR(cxl->efx_region);
> +		goto err_region;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	goto endpoint_release;
>  
> +err_region:
> +	cxl_dpa_free(cxl->cxled);
>  put_root_decoder:
>  	cxl_put_root_decoder(cxl->cxlrd);
>  endpoint_release:
> @@ -129,7 +150,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
> -	if (probe_data->cxl) {
> +	if (probe_data->cxl_pio_initialised) {

Doesn't make sense yet because it's never true yet.  I assume the code
doesn't always fail in a way it didn't until now?

> +		cxl_decoder_kill_region(probe_data->cxl->cxled);
>  		cxl_dpa_free(probe_data->cxl->cxled);
>  		cxl_put_root_decoder(probe_data->cxl->cxlrd);
>  	}


