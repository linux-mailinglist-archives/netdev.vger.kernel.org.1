Return-Path: <netdev+bounces-154750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4409FFAA2
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 15:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269AE162C82
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 14:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B0F192D70;
	Thu,  2 Jan 2025 14:55:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7157462;
	Thu,  2 Jan 2025 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735829748; cv=none; b=ebN0cS8YH0GypblDj0VKEeS6nxnbfNfUOk0W0FyqGCwMQbWLjbEVqf0dP+M0zYylFHGbudU+sind7vs6FGEQJWn3BinLa9OqkxVPHk/Z1yemZWnjXMHMpb8Fmr1yrBu1rERG2Y8R+nX/RshAnLXmseLjap+zusXgoVxCBwqZ6Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735829748; c=relaxed/simple;
	bh=h+RaiMu43ATTKYxq8XeD0KS5ptSVYuOyuj7fJ5PNjcw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=clR+kA75PgJNUqBv6UCZUng5vvjqYmXm+omaFPxsToWoO4DzU0eW6EQokrMRhH1w2GwZ9Xz1ML3GG7FG8VU/gyXF2y0JSq2HfsKR3IYzn95y4WzXyjLyw9J1EWikxX4K5SPg87BC+uPZbaMvQUNF/j8UqG8UWThl6k3tdSe5e/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YP8qZ71zKz6M4yM;
	Thu,  2 Jan 2025 22:54:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E16C7140A9C;
	Thu,  2 Jan 2025 22:55:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 2 Jan
 2025 15:55:44 +0100
Date: Thu, 2 Jan 2025 14:55:42 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v9 12/27] sfc: set cxl media ready
Message-ID: <20250102145542.00005ccf@huawei.com>
In-Reply-To: <20241230214445.27602-13-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
	<20241230214445.27602-13-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 30 Dec 2024 21:44:30 +0000
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api accessor for explicitly set media ready as hardware design
> implies it is ready and there is no device register for stating so.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
FWIW 

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 2031f08ee689..911f29b91bd3 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -91,6 +91,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err_resource_set;
>  	}
>  
> +	/* We do not have the register about media status. Hardware design
> +	 * implies it is ready.
> +	 */
> +	cxl_set_media_ready(cxl->cxlds);
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;


