Return-Path: <netdev+bounces-179346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B09A7C135
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 18:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0743A80A1
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B977A202987;
	Fri,  4 Apr 2025 16:03:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87C18F40;
	Fri,  4 Apr 2025 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743782617; cv=none; b=EEDl8yOeLRZSEUg+hsPWl/XdlO92UJ8EA4nHtEliextpnq2OZtPFPHyu8LpIxw6q115gkDNpCBKR4Lp+dlJouvTZEnnouaERey08YSkSVPDMzFhfVjkZ7fX9BvGdFSuZFlNWoSB1oSPOZlzyXUAcOfZMcrDmJDdSh7tf64mjsEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743782617; c=relaxed/simple;
	bh=LB0+aQivlJstFj1AeTFb88pnHKFXp1QfCPKZ3HMMlOE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKiACEL9Gfp7ScLgDSS6rSGm8jmMQtPbXylMm+SVM+KsUvuP20tzpx3k7jQFfAqv4HxRlHrGi31eLygfxv31kiGAsjh0SOUf8eyHmNuL/vfnXgJUtkXkAj4mAUH1HYhVaNZ1w+L0sYNNfof5nOQyNY1sf6OhXgtKK+bQXcn4lTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTjwk6JXwz6K5qq;
	Fri,  4 Apr 2025 23:59:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CD0E514050C;
	Sat,  5 Apr 2025 00:03:31 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 18:03:31 +0200
Date: Fri, 4 Apr 2025 17:03:29 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 05/23] cxl: add function for type2 cxl regs setup
Message-ID: <20250404170329.00000401@huawei.com>
In-Reply-To: <20250331144555.1947819-6-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
	<20250331144555.1947819-6-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 31 Mar 2025 15:45:37 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create a new function for a type2 device initialising
> cxl_dev_state struct regarding cxl regs setup and mapping.
> 
> Export the capabilities found for checking them against the
> expected ones by the driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/cxl/core/pci.c | 52 ++++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h      |  5 ++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 05399292209a..e48320e16a4f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1095,6 +1095,58 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>  
> +static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
> +				     struct cxl_dev_state *cxlds,
> +				     unsigned long *caps)
> +{
> +	struct cxl_register_map map;
> +	int rc;
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map, caps);
> +	/*
> +	 * This call can return -ENODEV if regs not found. This is not an error
> +	 * for Type2 since these regs are not mandatory. If they do exist then
> +	 * mapping them should not fail. If they should exist, it is with driver
> +	 * calling cxl_pci_check_caps where the problem should be found.

Good to put () on end of functions when mentioned in comments.

> +	 */
> +	if (rc == -ENODEV)
> +		return 0;

Hmm. I don't mind hugely but I'd expect the -ENODEV handler in the
clearly accelerator specific code that follows not here.

That would require cxl_map_device_regs() to definitely not return
-ENODEV though which is a bit ugly so I guess this is ok.

I'm not entirely convinced this helper makes sense though given
the 2 parts of the component regs are just done inline in 
cxl_pci_accel_setup_regs() and if you did that then this
accelerator specific 'carry on anyway' would be in the function
with accel in the name.

	You'd need a
	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map, caps);
	if (rc) {
		if (rc != -ENODEV)
			return rc;
	} else {
		rc = cxl_map_device_regs();
		if (rc)
			return rc;	
	}	
though which is a little messy.

> +
> +	if (rc)
> +		return rc;
> +
> +	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
> +}
> +
> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds,
> +			      unsigned long *caps)
> +{
> +	int rc;
> +
> +	rc = cxl_pci_setup_memdev_regs(pdev, cxlds, caps);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> +				&cxlds->reg_map, caps);
> +	if (rc) {
> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	if (!caps || !test_bit(CXL_CM_CAP_CAP_ID_RAS, caps))

As before. Why not just mandate caps?  If someone really doesn't
care they can provide a bitmap and ignore it.  Seems like a simpler
interface to me.

> +		return 0;
> +
> +	rc = cxl_map_component_regs(&cxlds->reg_map,
> +				    &cxlds->regs.component,
> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
> +	if (rc)
> +		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, "CXL");


