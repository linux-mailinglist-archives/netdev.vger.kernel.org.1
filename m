Return-Path: <netdev+bounces-128191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EED9786D2
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B016B20908
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F596BFC7;
	Fri, 13 Sep 2024 17:32:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B9D4F883;
	Fri, 13 Sep 2024 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726248767; cv=none; b=NzQjfMPl/HjYYSGG2NxzKHfThPQy+n4dc/y9e3pbpG9agOxgdIqPEtfc+dLSXVO7TUzqud8M323v0QgTFPtFTSPXcGQ3Hc1WAbw3x7WWPHpVEYIXsuZdiePthObWVLeIYWrN08NlqRezJFawR0o1wTCSug69M2swY8rCe8sVNBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726248767; c=relaxed/simple;
	bh=MP2Lh/lGUwDXXPNq3Xztqvw9OMMXMBtX5PWzs8f0GDc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IriEG8Sf8ecn5lJT0Rs1bGdwJKkvFpLBVCnX9k2WEzC6pg7/0GBfZkDVcRkc62wEvtZ3yYdTyu1GNeZ2q2P6LSPBGmRvnnrEzZPHyz7z5pVlKIfiPPwUGSeIrdjq3ghs7vrudbafTmvWamscxfpE74fyy1ysXn9rEbT2KgYzjxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X51WL0mMTz6L6sV;
	Sat, 14 Sep 2024 01:29:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 703BA140122;
	Sat, 14 Sep 2024 01:32:42 +0800 (CST)
Received: from localhost (10.48.150.243) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Sep
 2024 19:32:41 +0200
Date: Fri, 13 Sep 2024 18:32:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v3 05/20] cxl: add function for type2 cxl regs setup
Message-ID: <20240913183240.0000371b@Huawei.com>
In-Reply-To: <20240907081836.5801-6-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
	<20240907081836.5801-6-alejandro.lucero-palau@amd.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 7 Sep 2024 09:18:21 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create a new function for a type2 device initialising
> cxl_dev_state struct regarding cxl regs setup and mapping.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/pci.c             | 30 ++++++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.c |  6 ++++++
>  include/linux/cxl/cxl.h            |  2 ++
>  3 files changed, 38 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index bf57f081ef8f..9afcdd643866 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1142,6 +1142,36 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);
>  
> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_register_map map;
> +	int rc;
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
> +				&cxlds->capabilities);
> +	if (!rc) {

I'd be tempted to wrap these two up in a separate function called
from here as the out of line good path is less than ideal from
readability point of view.

> +		rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> +				&cxlds->reg_map, &cxlds->capabilities);
> +	if (rc)
> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
> +
> +	if (cxlds->capabilities & BIT(CXL_CM_CAP_CAP_ID_RAS)) {

If there are no component registers this isn't going to work yet this
tries anyway?

> +		rc = cxl_map_component_regs(&cxlds->reg_map,
> +					    &cxlds->regs.component,
> +					    BIT(CXL_CM_CAP_CAP_ID_RAS));
> +		if (rc)
> +			dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, CXL);
> +


