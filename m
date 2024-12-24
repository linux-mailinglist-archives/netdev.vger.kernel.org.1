Return-Path: <netdev+bounces-154200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0DB9FC0E6
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 18:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81A2163EC7
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 17:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517CD1FF5F3;
	Tue, 24 Dec 2024 17:22:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6873914D433;
	Tue, 24 Dec 2024 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735060963; cv=none; b=GnOpS7MGRhthdXbx5OzglACIwQvGSZrLlX0jv0mfi0R5cpwBaWR4U/scw6bPKeVe5mjTOBJOKRnLyP2V3GTddpc8QQ1lu09ii2EEM2gYq9nGYy1gE1YrBo5ow8piRvaZePlqw53+fFhMdPSPhADjIe+9Z/uXUiKhk0baZrynJQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735060963; c=relaxed/simple;
	bh=Adl3Ut8gf+vt7V0MhkUuAQtdgr74XgznaMRGacAxd48=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqnYWF1V2RSK0IU+uobjnP18zfQ0W1hDZJSMSuaVEqg7Ow8V3MA/s3ibyBaiKDeK0aE1LmnkWK3Z+n4Zwl4FeAkDiQZpFgIBXm4NujOcv0YKAOaY+axVc4mavmIvXsh2wx9xiM6T32b6QkXaczzdsHNX4ZfJtwGFU7TNw+5e074=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHhXV5Jnjz6K6J9;
	Wed, 25 Dec 2024 01:22:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 02F07140520;
	Wed, 25 Dec 2024 01:22:39 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 18:22:38 +0100
Date: Tue, 24 Dec 2024 17:22:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>, Alejandro
 Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 06/27] cxl: add function for type2 cxl regs setup
Message-ID: <20241224172236.00007c6c@huawei.com>
In-Reply-To: <20241216161042.42108-7-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
	<20241216161042.42108-7-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 16 Dec 2024 16:10:21 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create a new function for a type2 device initialising
> cxl_dev_state struct regarding cxl regs setup and mapping.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
Comments below.

J
> ---
>  drivers/cxl/core/pci.c | 47 ++++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h      |  2 ++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 3cca3ae438cd..0b578ff14cc3 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1096,6 +1096,53 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>  
> +static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
> +				     struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_register_map map;
> +	int rc;
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
> +				cxlds->capabilities);
> +	/*
> +	 * This call returning a non-zero value is not considered an error since

Error code perhaps rather than non-zero value?

> +	 * these regs are not mandatory for Type2. If they do exist then mapping
> +	 * them should not fail.
> +	 */
> +	if (rc)
> +		return 0;
> +
> +	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
> +}
> +
> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
> +{
> +	int rc;
> +
> +	rc = cxl_pci_setup_memdev_regs(pdev, cxlds);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> +				&cxlds->reg_map, cxlds->capabilities);
> +	if (rc) {
> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	if (!test_bit(CXL_CM_CAP_CAP_ID_RAS, cxlds->capabilities))

rc is 0.  I doubt that's the intent - if it is, return 0;


> +		return rc;
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

> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 05f06bfd2c29..18fb01adcf19 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -5,6 +5,7 @@
>  #define __CXL_H
>  
>  #include <linux/ioport.h>
> +#include <linux/pci.h>

Use a forwards def if all you need is
struct pci_dev;


>  
>  enum cxl_resource {
>  	CXL_RES_DPA,
> @@ -40,4 +41,5 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>  			unsigned long *expected_caps,
>  			unsigned long *current_caps);
> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>  #endif


