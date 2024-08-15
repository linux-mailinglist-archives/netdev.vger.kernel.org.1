Return-Path: <netdev+bounces-118926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692C0953877
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0392BB2473B
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC4819E7E8;
	Thu, 15 Aug 2024 16:40:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30061B4C2D;
	Thu, 15 Aug 2024 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723740047; cv=none; b=gOp/udYqYGi6UoTjkwTkUP85GGzBtrXPkDmDJJ3NCecU6wrDxkPy4CYgzK/+gzuuaoiQ5FZonZcytMOWeliQR8xsKHrRTJFWu3bSx1czWWI8GQ1KUFytGRdcjr3gDQtocrAb9nXTRARJ2uvg91zHhFuvpEGbTRp6rxesOFGpO2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723740047; c=relaxed/simple;
	bh=sv6PdVVlm7tbr0UuPHCEZZey6A1hPyaBMpr3lsc1k/o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcljUjGT8BNvRU62jGdMEBorE+Vq70seRIId4ESa51lVgaASuTJuCxJosdHEHe4HQRkxJqgg9EhTCpTb35K5wOqjbX+SlV0Bt+snI75akMWEE5hWxL8wPMbbksGgdvgmVd+BzT1rR3qJoQaGGKWQSdfDx+cNW2CmqUV3TAX9y64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wl9ll428Cz6K9B4;
	Fri, 16 Aug 2024 00:37:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CC221400DB;
	Fri, 16 Aug 2024 00:40:37 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 15 Aug
 2024 17:40:36 +0100
Date: Thu, 15 Aug 2024 17:40:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<richard.hughes@amd.com>
Subject: Re: [PATCH v2 02/15] cxl: add function for type2 cxl regs setup
Message-ID: <20240815174035.00005bb0@Huawei.com>
In-Reply-To: <5d8f8771-8e43-6559-c510-0b8b26171c05@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-3-alejandro.lucero-palau@amd.com>
	<20240804181529.00004aa9@Huawei.com>
	<5d8f8771-8e43-6559-c510-0b8b26171c05@amd.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 14 Aug 2024 08:56:35 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 8/4/24 18:15, Jonathan Cameron wrote:
> > On Mon, 15 Jul 2024 18:28:22 +0100
> > alejandro.lucero-palau@amd.com wrote:
> >  
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> Create a new function for a type2 device initialising the opaque
> >> cxl_dev_state struct regarding cxl regs setup and mapping.
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> ---
> >>   drivers/cxl/pci.c                  | 28 ++++++++++++++++++++++++++++
> >>   drivers/net/ethernet/sfc/efx_cxl.c |  3 +++
> >>   include/linux/cxl_accel_mem.h      |  1 +
> >>   3 files changed, 32 insertions(+)
> >>
> >> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> >> index e53646e9f2fb..b34d6259faf4 100644
> >> --- a/drivers/cxl/pci.c
> >> +++ b/drivers/cxl/pci.c
> >> @@ -11,6 +11,7 @@
> >>   #include <linux/pci.h>
> >>   #include <linux/aer.h>
> >>   #include <linux/io.h>
> >> +#include <linux/cxl_accel_mem.h>
> >>   #include "cxlmem.h"
> >>   #include "cxlpci.h"
> >>   #include "cxl.h"
> >> @@ -521,6 +522,33 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> >>   	return cxl_setup_regs(map);
> >>   }
> >>   
> >> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
> >> +{
> >> +	struct cxl_register_map map;
> >> +	int rc;
> >> +
> >> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> >> +	if (rc)
> >> +		return rc;
> >> +
> >> +	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
> >> +	if (rc)
> >> +		return rc;
> >> +
> >> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> >> +				&cxlds->reg_map);
> >> +	if (rc)
> >> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);  
> > Not fatal?  If we think it will happen on real devices, then dev_warn
> > is too strong.  
> 
> 
> This is more complex than what it seems, and it is not properly handled 
> with the current code.
> 
> I will cover it in another patch in more detail, but the fact is those 
> calls to cxl_pci_setup_regs need to be handled better, because Type2 has 
> some of these registers as optional.

I'd argue you don't have to support all type 2 devices with your
first code.  Things like optionality of registers can come in when
a device shows up where they aren't present.

Jonathan

