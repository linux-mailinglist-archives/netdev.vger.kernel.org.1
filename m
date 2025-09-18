Return-Path: <netdev+bounces-224486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A674AB8573D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69912188DD1B
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED1922A7E9;
	Thu, 18 Sep 2025 15:03:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F5030C62E;
	Thu, 18 Sep 2025 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207814; cv=none; b=CwnTIrKcsfaKs29KT6jnXCqyWbgPrRAz6QN7lpUc8drx/QBxWqSFI1boFTXcXWvAk+3uEjYdhSesBQ/LnK1CKlAwpQHy4ltfiDfkn3JlSxLYVyZaxcZaC3GkEY5+fikFvJD+D1hwFpf2icp0fkyaHEIyx0Rq48Q/bz/GieVtqWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207814; c=relaxed/simple;
	bh=zlDuh3tG1DpzAOYfHBZStERI8a51DTOMCr8xiek56jQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FRpULSdVjbWyPrnZerMwhEJVqfNbEvXWt2ZDlEo/0M8r3cHXH/434LhQd2KblS26Od47K8mj7511BvusNCBuvrL8SfhFeFYlTuSjb4o42oOQjFpk/k8wM0/6GahZMECUxA7o/n45JIsnBUhxehiaoI0uoxJWlcmVs6/JcPifpdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cSJkn3slFz6GDDv;
	Thu, 18 Sep 2025 23:01:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 853D81402F5;
	Thu, 18 Sep 2025 23:03:29 +0800 (CST)
Received: from localhost (10.47.69.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Sep
 2025 17:03:28 +0200
Date: Thu, 18 Sep 2025 16:03:25 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v18 18/20] sfc: create cxl region
Message-ID: <20250918160325.00005261@huawei.com>
In-Reply-To: <20250918091746.2034285-19-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
	<20250918091746.2034285-19-alejandro.lucero-palau@amd.com>
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

On Thu, 18 Sep 2025 10:17:44 +0100
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
>  drivers/cxl/core/core.h            |  5 -----
>  drivers/net/ethernet/sfc/efx_cxl.c | 22 ++++++++++++++++++++++
>  include/cxl/cxl.h                  |  8 ++++++++
>  3 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index c4dddbec5d6e..83abaca9f418 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -14,11 +14,6 @@ extern const struct device_type cxl_pmu_type;
>  
>  extern struct attribute_group cxl_base_attribute_group;
>  
> -enum cxl_detach_mode {
> -	DETACH_ONLY,
> -	DETACH_INVALIDATE,
> -};
Seems like a stray move that should have been in the earlier patch.

> -
>  #ifdef CONFIG_CXL_REGION
>  extern struct device_attribute dev_attr_create_pmem_region;
>  extern struct device_attribute dev_attr_create_ram_region;
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 4461b7a4dc2c..85490afc7930 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c

> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index dbacefff8d60..e82f94921b5b 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -282,4 +282,12 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>  				     struct cxl_endpoint_decoder **cxled,
>  				     int ways, void (*action)(void *),
>  				     void *data);
> +enum cxl_detach_mode {
> +	DETACH_ONLY,
> +	DETACH_INVALIDATE,
> +};
> +
> +int cxl_decoder_detach(struct cxl_region *cxlr,
> +		       struct cxl_endpoint_decoder *cxled, int pos,
> +		       enum cxl_detach_mode mode);
Is this change in the right patch?  It's not a code move here
as there isn't a declaration of this being removed.
I'd rather expect this in patch 16, along with removal of the declaration currently
in core/core.h

>  #endif /* __CXL_CXL_H__ */


