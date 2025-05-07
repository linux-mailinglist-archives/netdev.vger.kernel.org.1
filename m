Return-Path: <netdev+bounces-188691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A760AAE387
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 16:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3672188D51C
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD403289813;
	Wed,  7 May 2025 14:49:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BD9186E2E;
	Wed,  7 May 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629390; cv=none; b=FicY5s6TOdFEDtOZjC2N1QJ8Pzoh0dILe9nK/xH4ynHWtUl9asy8YgFEORXOwoP7iNqh6V91mtxPa4DA29tfh2ueNxq4kEOx/KIpl38j5z5oJ8Ih8Zl9LSIcHpQ85OZG2nVtbmRrrWqD40KJXrdD3Yn43TI48QhBo1VW8gcB8pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629390; c=relaxed/simple;
	bh=82+jNoF4uaBhvi99rruPAlvCgQU4cQQMWErQqladn/U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijAnFWF9uFQ8ZBsChkgY5ZJ8uaaT+XYhUqNsP5dX9xeHxt6G12H7B4HEyi5rX3hPAd2XSD/RUwPRV4ugvHznFGllrh/lG5ZwHjjwXOMpkgpAhrqy3t1yxzRqOz5PCfO+boTZSrX8WRxzsq3HbL61xAFCvmSSvm+kPcT+u/coTW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zsyln71HLz6L4yD;
	Wed,  7 May 2025 22:47:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5448C1402F5;
	Wed,  7 May 2025 22:49:45 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 7 May
 2025 16:49:44 +0200
Date: Wed, 7 May 2025 15:49:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v14 08/22] sfc: initialize dpa
Message-ID: <20250507154943.000062eb@huawei.com>
In-Reply-To: <20250417212926.1343268-9-alejandro.lucero-palau@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
	<20250417212926.1343268-9-alejandro.lucero-palau@amd.com>
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

On Thu, 17 Apr 2025 22:29:11 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use hardcoded values for defining and initializing dpa as there is no
> mbox available.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

SFC / net.  If this might go through the CXL tree we need some tags
to say it looks good to you.

> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 79427a85a1b7..e8bfaf7641e4 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -23,6 +23,9 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	DECLARE_BITMAP(found, CXL_MAX_CAPS) = {};
>  	struct efx_nic *efx = &probe_data->efx;
>  	struct pci_dev *pci_dev = efx->pci_dev;
> +	struct cxl_dpa_info sfc_dpa_info = {
> +		.size = EFX_CTPIO_BUFFER_SIZE
> +	};
>  	struct efx_cxl *cxl;
>  	u16 dvsec;
>  	int rc;
> @@ -70,6 +73,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	 */
>  	cxl->cxlds.media_ready = true;
>  
> +	cxl_mem_dpa_init(&sfc_dpa_info, EFX_CTPIO_BUFFER_SIZE, 0);
> +	rc = cxl_dpa_setup(&cxl->cxlds, &sfc_dpa_info);
> +	if (rc)
> +		return rc;
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;


