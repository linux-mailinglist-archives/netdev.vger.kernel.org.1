Return-Path: <netdev+bounces-224400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE309B844C7
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319BD7AE08C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28472301002;
	Thu, 18 Sep 2025 11:08:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4FB2FE575;
	Thu, 18 Sep 2025 11:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193726; cv=none; b=C0NVGHMh4a0Y3XM+vQIltEBRooW3MiYVPSzUKbi/h6boRRbKJzc/OqsQAMw5XQ3pzN+lvSJ9Np67f1/x7xRuAif0BTBA+hIDZzGr6YeUV8pcjivCRy/xq87KW1GyziecOj+yFAp/LItXPFY95kK479I0y3dinjhan5DT5OdT4NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193726; c=relaxed/simple;
	bh=wqb6menlIl/Mvi1y9tRBk2IxpyhfKE5R3PcPvmhLGv4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDWUGg7qxX0TXDGF3UbSGVlC7BVzaFyHpRZKkA6sRr9a4aqlmfCTuj3pyZbG7vwLBG72TMR+8ZQ8owUKVp9NuzkSPhNWc8yhPfKU8KS50NmKgxsZMOf3WlQo7Uf8OWRB/J/jT97BUMH2l7zQ86aKTJY4BMTJWczX/mvPPGTO5iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cSCWr0HCYz6GD6h;
	Thu, 18 Sep 2025 19:07:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D18114025A;
	Thu, 18 Sep 2025 19:08:39 +0800 (CST)
Received: from localhost (10.47.69.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Sep
 2025 13:08:38 +0200
Date: Thu, 18 Sep 2025 12:08:35 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>, Edward Cree
	<ecree.xilinx@gmail.com>
Subject: Re: [PATCH v18 07/20] sfc: create type2 cxl memdev
Message-ID: <20250918120835.000045f8@huawei.com>
In-Reply-To: <20250918091746.2034285-8-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
	<20250918091746.2034285-8-alejandro.lucero-palau@amd.com>
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

On Thu, 18 Sep 2025 10:17:33 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl API for creating a cxl memory device using the type2
> cxl_dev_state struct.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 651d26aa68dc..177c60b269d6 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -82,6 +82,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return dev_err_probe(&pci_dev->dev, -ENODEV,
>  				     "dpa capacity setup failed\n");
>  
> +	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, &cxl->cxlds, NULL);
> +	if (IS_ERR(cxl->cxlmd)) {
> +		pci_err(pci_dev, "CXL accel memdev creation failed");

Throwing a pci_err() in here seems to be a further bit of inconsistency.

> +		return PTR_ERR(cxl->cxlmd);
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;


