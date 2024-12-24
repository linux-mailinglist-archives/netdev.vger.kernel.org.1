Return-Path: <netdev+bounces-154199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A29C9FC0E4
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 18:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E5C1628B4
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 17:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4989814D433;
	Tue, 24 Dec 2024 17:19:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9AF26ACB;
	Tue, 24 Dec 2024 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735060790; cv=none; b=UwNSxtiu3hze/jLNi9D3it+Hor/PEr6pjx2t8fPnqlWVRDLWNGcqUekER6mOjt17uyOhlSuIgpJkGhf4mXNnr4mmwFSJkcyH6gBt0pDtitUoRtmztI/Btp8SigfgR9Sj9uvEFrC2EnGkKDzUtEUCDL050aU2DRVgdFd7EggmKoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735060790; c=relaxed/simple;
	bh=bbv+4DUtNMy9UMfsWh3TAY27hdfn9sgp0pGfcnx2UqQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tW5wugUIfqICUX061eNrgXhy1e9qmxvVt+JTnUvGZgsV8vqTUpv4cHcGGupEXIMWES4pJ5Ar9Nmh3oXu/CYV4CNzR8wu/XFUkQl8t8TaKbUNvB4vMoYwX80toibwGKFtdkFehHWxR35ggM7DF9A+Cdwr0m0pT66ohjUysAXivTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHhP40rRgz6K5qN;
	Wed, 25 Dec 2024 01:15:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 88B8A140391;
	Wed, 25 Dec 2024 01:19:45 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 18:19:44 +0100
Date: Tue, 24 Dec 2024 17:19:43 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>, Alejandro
 Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 05/27] cxl: move pci generic code
Message-ID: <20241224171943.00000bec@huawei.com>
In-Reply-To: <20241216161042.42108-6-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
	<20241216161042.42108-6-alejandro.lucero-palau@amd.com>
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

On Mon, 16 Dec 2024 16:10:20 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
> meanwhile cxl/pci.c implements the functionality for a Type3 device
> initialization.
> 
> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
> exported and shared with CXL Type2 device initialization.

Rebase gone wrong?  What happened to call of 
cxl_dport_map_rcd_linkcap() in the original code for instance.

Jonathan


> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> ---
>  drivers/cxl/core/pci.c | 62 ++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h   |  3 ++
>  drivers/cxl/pci.c      | 71 ------------------------------------------
>  3 files changed, 65 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index bc098b2ce55d..3cca3ae438cd 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1034,6 +1034,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, "CXL");
>  
> +/*
> + * Assume that any RCIEP that emits the CXL memory expander class code
> + * is an RCD
> + */
> +bool is_cxl_restricted(struct pci_dev *pdev)
> +{
> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> +}
> +EXPORT_SYMBOL_NS_GPL(is_cxl_restricted, "CXL");
> +
> +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> +				  struct cxl_register_map *map)
> +{
> +	struct cxl_port *port;
> +	struct cxl_dport *dport;
> +	resource_size_t component_reg_phys;
> +
> +	*map = (struct cxl_register_map) {
> +		.host = &pdev->dev,
> +		.resource = CXL_RESOURCE_NONE,
> +	};
> +
> +	port = cxl_pci_find_port(pdev, &dport);
> +	if (!port)
> +		return -EPROBE_DEFER;
> +
> +	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
> +
> +	put_device(&port->dev);
> +
> +	if (component_reg_phys == CXL_RESOURCE_NONE)
> +		return -ENXIO;
> +
> +	map->resource = component_reg_phys;
> +	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> +
> +	return 0;
> +}
> +
> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		       struct cxl_register_map *map, unsigned long *caps)
> +{
> +	int rc;
> +
> +	rc = cxl_find_regblock(pdev, type, map);
> +
> +	/*
> +	 * If the Register Locator DVSEC does not exist, check if it
> +	 * is an RCH and try to extract the Component Registers from
> +	 * an RCRB.
> +	 */
> +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
> +		rc = cxl_rcrb_get_comp_regs(pdev, map);
> +
> +	if (rc)
> +		return rc;
> +
> +	return cxl_setup_regs(map, caps);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
> +
>  int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  {
>  	int speed, bw;
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index eb59019fe5f3..985cca3c3350 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -113,4 +113,7 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +bool is_cxl_restricted(struct pci_dev *pdev);
> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		       struct cxl_register_map *map, unsigned long *caps);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 1fcc53df1217..89056449625f 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -467,77 +467,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>  	return 0;
>  }
>  
> -/*
> - * Assume that any RCIEP that emits the CXL memory expander class code
> - * is an RCD
> - */
> -static bool is_cxl_restricted(struct pci_dev *pdev)
> -{
> -	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> -}
> -
> -static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> -				  struct cxl_register_map *map,
> -				  struct cxl_dport *dport)
> -{
> -	resource_size_t component_reg_phys;
> -
> -	*map = (struct cxl_register_map) {
> -		.host = &pdev->dev,
> -		.resource = CXL_RESOURCE_NONE,
> -	};
> -
> -	struct cxl_port *port __free(put_cxl_port) =
> -		cxl_pci_find_port(pdev, &dport);
> -	if (!port)
> -		return -EPROBE_DEFER;
> -
> -	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
> -	if (component_reg_phys == CXL_RESOURCE_NONE)
> -		return -ENXIO;
> -
> -	map->resource = component_reg_phys;
> -	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> -	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> -
> -	return 0;
> -}
> -
> -static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> -			      struct cxl_register_map *map,
> -			      unsigned long *caps)
> -{
> -	int rc;
> -
> -	rc = cxl_find_regblock(pdev, type, map);
> -
> -	/*
> -	 * If the Register Locator DVSEC does not exist, check if it
> -	 * is an RCH and try to extract the Component Registers from
> -	 * an RCRB.
> -	 */
> -	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
> -		struct cxl_dport *dport;
> -		struct cxl_port *port __free(put_cxl_port) =
> -			cxl_pci_find_port(pdev, &dport);
> -		if (!port)
> -			return -EPROBE_DEFER;
> -
> -		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
> -		if (rc)
> -			return rc;
> -
> -		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
> -		if (rc)
> -			return rc;
> -
> -	} else if (rc) {
> -		return rc;
> -	}
> -
> -	return cxl_setup_regs(map, caps);
> -}
> -
>  static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  {
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);


