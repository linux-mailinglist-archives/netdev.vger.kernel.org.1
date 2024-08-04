Return-Path: <netdev+bounces-115563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A4694700B
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 19:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80E31C2091B
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 17:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3669541A80;
	Sun,  4 Aug 2024 17:31:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D0B79C2;
	Sun,  4 Aug 2024 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722792705; cv=none; b=Um6xPVPlAwUR48WV/gR+ppHZHBUwsJkyvKaHrZ4t20cPqtGsRH5Hi7DJ2qq4x8t4SM/WK6vYjRG/liwwW6txz/qkUpIXMlyi4ZxlqSu4Cv9IZ279zb6g1s+VcIJEHAcBZ9/7XQ1oSnq25K0vkJb/glpZL3VNbeK02u/IHhD1AQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722792705; c=relaxed/simple;
	bh=H6Fb4zNnwWKLC2xfcmHf3LD5nyBmHxU/6cjmBvhyYN0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Of4mr3vo/4pEESWleT9Ofsb/wXdnVdcIj65TeSb0DxZRzFVo2ahecCRC3F89yUVXaZzxY7wP4tjSeK1wYjn3dZCoBXjJjSE36kTpbIFxVuJeLLFgXnOQImjnZyflMGLNmUOg/Sq9LtD4xM2AzJ7pLYpx3JKlrzvOwzWKGt4S81o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WcRPl74Kxz6K8pm;
	Mon,  5 Aug 2024 01:28:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 99B291400C9;
	Mon,  5 Aug 2024 01:31:40 +0800 (CST)
Received: from localhost (10.195.244.131) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 4 Aug
 2024 18:31:39 +0100
Date: Sun, 4 Aug 2024 18:31:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 07/15] cxl: support type2 memdev creation
Message-ID: <20240804183139.000019e2@Huawei.com>
In-Reply-To: <20240715172835.24757-8-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-8-alejandro.lucero-palau@amd.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 15 Jul 2024 18:28:27 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add memdev creation from sfc driver.
> 
> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
> creating a memdev leading to problems when obtaining cxl_memdev_state
> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
> managed by a specific vendor driver and does not need same sysfs files
> since not userspace intervention is expected. This patch checks for the
> right device type in those functions using cxl_memdev_state.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Same general comment about treating failure to get things you expect
as proper driver probe errors.  Very unlikely we'd ever want to carry
on if these fail. If we do want to, that should be a high level decision
and the chances are the driver needs to know that the error occurred
so it can take some mitigating measures (using some alternative mechanisms
etc).

> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index a84fe7992c53..0abe66490ef5 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -57,10 +57,16 @@ void efx_cxl_init(struct efx_nic *efx)
>  	if (cxl_accel_request_resource(cxl->cxlds, true))
>  		pci_info(pci_dev, "CXL accel resource request failed");
>  
> -	if (!cxl_await_media_ready(cxl->cxlds))
> +	if (!cxl_await_media_ready(cxl->cxlds)) {
>  		cxl_accel_set_media_ready(cxl->cxlds);
> -	else
> +	} else {
>  		pci_info(pci_dev, "CXL accel media not active");
> +		return;
Once you are returning an error in this path you can just have
		return -ETIMEDOUT; or similar here adn avoid
this code changing in this patch.
> +	}
> +
> +	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
> +	if (IS_ERR(cxl->cxlmd))
> +		pci_info(pci_dev, "CXL accel memdev creation failed");

I'd treat this one as fatal as well.

People argue in favor of muddling on to allow firmware upgrade etc.
That is fine, but pass up the errors then decide to ignore them
at the higher levels.

>  }
>  
>  



