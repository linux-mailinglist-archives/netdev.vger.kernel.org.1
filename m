Return-Path: <netdev+bounces-201795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D09AEB174
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A6E5679C2
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5404321D3DB;
	Fri, 27 Jun 2025 08:39:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12F52A8D0;
	Fri, 27 Jun 2025 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751013571; cv=none; b=jFGLYaFstEt280NXKtXlqmMqWMDdA0fbsqSakNkQn4SNFHlqL6xIdz4FiX/dMg2KXOq/HHl/WIvwEauOJJTLCzwoQAVVgiPsSnMJtC+LN3GpoBeMRzE6PGFn+1qQstemPpz8h3bFCVDgZFHdmhVpn8tTX4U4Eo6Ojx0t9szD5vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751013571; c=relaxed/simple;
	bh=0p85hQNZyi4HJJLiNMCP7IBA/gEpAohWJLqAfN3+mT0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVviOUcOWktIvQ9vH8NUyNy8ZfPJqNXQP7Ze/zR6a5AP6rN0j343yGCk8t+tnxI7VSLHnGaqRZLLcFJZDymxqCuAH1MuMLLXjOzmltjHROf2tgDFJIz7NDzpsiIoHe1Nqo10Aw2uq7BOM9uiwYKb2zXHi2NMR3imjfeUj/Dungk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bT89d1gHQz6L5hF;
	Fri, 27 Jun 2025 16:39:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 485211404C5;
	Fri, 27 Jun 2025 16:39:26 +0800 (CST)
Received: from localhost (10.48.153.213) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 27 Jun
 2025 10:39:25 +0200
Date: Fri, 27 Jun 2025 09:39:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v17 05/22] sfc: setup cxl component regs and set media
 ready
Message-ID: <20250627093923.00004930@huawei.com>
In-Reply-To: <20250624141355.269056-6-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
	<20250624141355.269056-6-alejandro.lucero-palau@amd.com>
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

On Tue, 24 Jun 2025 15:13:38 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl code for registers discovery and mapping regarding cxl component
> regs and validate registers found are as expected.
> 
> Set media ready explicitly as there is no means for doing so without
> a mailbox, and without the related cxl register, not mandatory for type2.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Perhaps add a brief note to the description on why you decided on the
mix of warn vs err messages in the different conditions.

Superficially there is a call in here that can defer.  If it can't
add a comment on why as if it can you should be failing the main
driver probe until it doesn't defer (or adding a bunch of descriptive
comments on why that doesn't make sense!)

> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 34 ++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index f1db7284dee8..ea02eb82b73c 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -9,6 +9,7 @@
>   * by the Free Software Foundation, incorporated herein by reference.
>   */
>  
> +#include <cxl/cxl.h>
>  #include <cxl/pci.h>
>  #include <linux/pci.h>
>  
> @@ -23,6 +24,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	struct pci_dev *pci_dev = efx->pci_dev;
>  	struct efx_cxl *cxl;
>  	u16 dvsec;
> +	int rc;
>  
>  	probe_data->cxl_pio_initialised = false;
>  
> @@ -43,6 +45,38 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	if (!cxl)
>  		return -ENOMEM;
>  
> +	rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
> +				&cxl->cxlds.reg_map);
> +	if (rc) {
> +		dev_warn(&pci_dev->dev, "No component registers (err=%d)\n", rc);
> +		return rc;

I haven't checked the code paths to see if we might hit them but this might
defer.  In which case
		return dev_err_probe() is appropriate as it stashes away the
cause of deferral for debugging purposes and doesn't print if that's what
happened as we'll be back later.

If we can hit the deferral then you should catch that at the caller of efx_cxl_init()
and fail the probe (we'll be back a bit later and should then succeed).


> +	}
> +
> +	if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
> +		dev_err(&pci_dev->dev, "Expected HDM component register not found\n");
> +		return -ENODEV;

Trivial but given this is new code maybe differing from style of existing sfc
and using
		return dev_err_probe(&pci->dev, "Expected HDM component register not found\n");
would be a nice to have.  Given deferral isn't a thing for this call, it just saves on about
2 lines of code for each use.

or use pci_err() and pci_warn()?

 
> +	}
> +
> +	if (!cxl->cxlds.reg_map.component_map.ras.valid) {
> +		dev_err(&pci_dev->dev, "Expected RAS component register not found\n");
> +		return -ENODEV;
> +	}
> +
> +	rc = cxl_map_component_regs(&cxl->cxlds.reg_map,
> +				    &cxl->cxlds.regs.component,
> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
> +	if (rc) {
> +		dev_err(&pci_dev->dev, "Failed to map RAS capability.\n");
> +		return rc;

> +	}
> +
> +	/*
> +	 * Set media ready explicitly as there are neither mailbox for checking
> +	 * this state nor the CXL register involved, both not mandatory for
> +	 * type2.
> +	 */
> +	cxl->cxlds.media_ready = true;
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;


