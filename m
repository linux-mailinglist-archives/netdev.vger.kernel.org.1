Return-Path: <netdev+bounces-238721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A23DC5E369
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 17:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0A73A9980
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692172620DE;
	Fri, 14 Nov 2025 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Orv+XU13"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10885258CDA;
	Fri, 14 Nov 2025 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136919; cv=none; b=Jc6mzdfu9Q88Ic2c5anf5xsTidBOMmz+70AXFYSarp4nqJdVBUA1A44CVW28MafedSxQs/9oxeal6T5imKpmsLb239ykJIWd/YeAMOg2A7h3OYaV26w/66DBMoSr9yqyOY9VoqCdaQfgiq9rNK8W1oCLA7qrPZnWMXRdXN3UmHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136919; c=relaxed/simple;
	bh=e5aUWmKoJ/GDDVDKCdlQagVxdoKcDmzMr4HHGHsJUcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHUJubgs3oq19AgI5VsSuFZPJHHy2H3MY0Aw6gmla/2b1L8C6T0dHSB2fkChtv5UK23gG/X77s8We7uCcMKWGBEyKFruXEv/bwfSUNlaUpKXPxmK7WzCKDlK/MPYL07yp5JogJI+tv7OO/nd476lRsslaPKzsaqTAtXiv/acfxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Orv+XU13; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763136918; x=1794672918;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e5aUWmKoJ/GDDVDKCdlQagVxdoKcDmzMr4HHGHsJUcM=;
  b=Orv+XU138jKsAVEf5+FJvQ42cdCboqlMen5/6F+swo2mMQdghHwUvlCD
   pZ948iAHDDonGPK/6c/79RrfNTLBg6BLj8tXAFzWjoxWQH+bCPOFyLSBQ
   AvgwiWcMiL99Lg+bTSXdL2p+jADvseVlCi7PZIWlmYuOWcOHhFhzIKRax
   LDYx1OIhUQK2YEqmni0rw4o8fJrs8ciKv5AD/Aeace2j25InJlPSC1MWI
   RlLPCdq9l1l4qr9CJgqvAR42WsmI3c6EjmGTCjA+t/KLTO5IkeA7lXzcR
   cO2YEJfYrmXRI63kuEU5X+7L8Bj4CLc3o7rt0j0YVqgtKce+KlnBEKLRI
   A==;
X-CSE-ConnectionGUID: jzGIvZRRQPSwMFv+yBEeig==
X-CSE-MsgGUID: qA9Np/NDRry7wIpb8h96pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="75555408"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="75555408"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 08:15:17 -0800
X-CSE-ConnectionGUID: 1z7yMVmwSSiJDqX1d+XrQg==
X-CSE-MsgGUID: mIl5FuzOQM6X+/PQUczpQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="189651184"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.108.188]) ([10.125.108.188])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 08:15:15 -0800
Message-ID: <712b09ac-53e0-4674-a3e2-d126f27c524f@intel.com>
Date: Fri, 14 Nov 2025 09:15:14 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 06/22] cxl: Move pci generic code
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
 <benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
 <20251110153657.2706192-7-alejandro.lucero-palau@amd.com>
 <aRZ25zHGGDyhqUlS@aschofie-mobl2.lan>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <aRZ25zHGGDyhqUlS@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/25 5:25 PM, Alison Schofield wrote:
> On Mon, Nov 10, 2025 at 03:36:41PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
>> meanwhile cxl/pci.c implements the functionality for a Type3 device
>> initialization.
> 
> Hi Alejandro,
> 
> I'v been looking at Terry's set and the cxl-test build circular
> dependencies. I think this patch may be 'stale', at least in
> the comments, maybe in the wrapped function it removes.
> 
>>
>> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
>> exported and shared with CXL Type2 device initialization.
> 
> Terry moves the whole file cxl/pci.c to cxl/core/pci_drv.c.
> That is reflected in what you actually do below, but not in this
> comment.
> 
>>
>> Fix cxl mock tests affected by the code move, deleting a function which
>> indeed was not being used since commit 733b57f262b0("cxl/pci: Early
>> setup RCH dport component registers from RCRB").
> 
> This I'm having trouble figuring out. I see __wrap_cxl_rcd_component_reg_phys()
> deleted below. Why is that OK? The func it wraps is still in use below, ie it's
> one you move from core/pci_drv.c to core/pci.c.
> 
> For my benefit, what is the intended difference between what will be
> in core/pci.c and core/pci_drv.c ?

I can answer this part since I asked Terry to do this. core/pci_drv.c contains everything that was in drivers/cxl/pci.c originally. It got moved in order to be able to access 'cxl_pci_drv' for the RAS component to check if the expected PCI driver is bound before handling the CXL RAS. And core/pci.c contains the core PCI lib calls and nothing changed there.

DJ
 > 
> --Alison
> 
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  drivers/cxl/core/core.h       |  3 ++
>>  drivers/cxl/core/pci.c        | 62 +++++++++++++++++++++++++++++++
>>  drivers/cxl/core/pci_drv.c    | 70 -----------------------------------
>>  drivers/cxl/core/regs.c       |  1 -
>>  drivers/cxl/cxl.h             |  2 -
>>  drivers/cxl/cxlpci.h          | 13 +++++++
>>  tools/testing/cxl/Kbuild      |  1 -
>>  tools/testing/cxl/test/mock.c | 17 ---------
>>  8 files changed, 78 insertions(+), 91 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index a7a0838c8f23..2b2d3af0b5ec 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -232,4 +232,7 @@ static inline bool cxl_pci_drv_bound(struct pci_dev *pdev) { return false; };
>>  static inline int cxl_pci_driver_init(void) { return 0; }
>>  static inline void cxl_pci_driver_exit(void) { }
>>  #endif
>> +
>> +resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>> +					   struct cxl_dport *dport);
>>  #endif /* __CXL_CORE_H__ */
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index a66f7a84b5c8..566d57ba0579 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -775,6 +775,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, "CXL");
>>  
>> +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>> +				  struct cxl_register_map *map,
>> +				  struct cxl_dport *dport)
>> +{
>> +	resource_size_t component_reg_phys;
>> +
>> +	*map = (struct cxl_register_map) {
>> +		.host = &pdev->dev,
>> +		.resource = CXL_RESOURCE_NONE,
>> +	};
>> +
>> +	struct cxl_port *port __free(put_cxl_port) =
>> +		cxl_pci_find_port(pdev, &dport);
>> +	if (!port)
>> +		return -EPROBE_DEFER;
>> +
>> +	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
>> +	if (component_reg_phys == CXL_RESOURCE_NONE)
>> +		return -ENXIO;
>> +
>> +	map->resource = component_reg_phys;
>> +	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>> +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>> +
>> +	return 0;
>> +}
>> +
>> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> +			      struct cxl_register_map *map)
>> +{
>> +	int rc;
>> +
>> +	rc = cxl_find_regblock(pdev, type, map);
>> +
>> +	/*
>> +	 * If the Register Locator DVSEC does not exist, check if it
>> +	 * is an RCH and try to extract the Component Registers from
>> +	 * an RCRB.
>> +	 */
>> +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
>> +		struct cxl_dport *dport;
>> +		struct cxl_port *port __free(put_cxl_port) =
>> +			cxl_pci_find_port(pdev, &dport);
>> +		if (!port)
>> +			return -EPROBE_DEFER;
>> +
>> +		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
>> +		if (rc)
>> +			return rc;
>> +
>> +		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
>> +		if (rc)
>> +			return rc;
>> +
>> +	} else if (rc) {
>> +		return rc;
>> +	}
>> +
>> +	return cxl_setup_regs(map);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>> +
>>  int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>>  {
>>  	int speed, bw;
>> diff --git a/drivers/cxl/core/pci_drv.c b/drivers/cxl/core/pci_drv.c
>> index 18ed819d847d..a35e746e6303 100644
>> --- a/drivers/cxl/core/pci_drv.c
>> +++ b/drivers/cxl/core/pci_drv.c
>> @@ -467,76 +467,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>>  	return 0;
>>  }
>>  
>> -/*
>> - * Assume that any RCIEP that emits the CXL memory expander class code
>> - * is an RCD
>> - */
>> -static bool is_cxl_restricted(struct pci_dev *pdev)
>> -{
>> -	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
>> -}
>> -
>> -static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>> -				  struct cxl_register_map *map,
>> -				  struct cxl_dport *dport)
>> -{
>> -	resource_size_t component_reg_phys;
>> -
>> -	*map = (struct cxl_register_map) {
>> -		.host = &pdev->dev,
>> -		.resource = CXL_RESOURCE_NONE,
>> -	};
>> -
>> -	struct cxl_port *port __free(put_cxl_port) =
>> -		cxl_pci_find_port(pdev, &dport);
>> -	if (!port)
>> -		return -EPROBE_DEFER;
>> -
>> -	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
>> -	if (component_reg_phys == CXL_RESOURCE_NONE)
>> -		return -ENXIO;
>> -
>> -	map->resource = component_reg_phys;
>> -	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>> -	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>> -
>> -	return 0;
>> -}
>> -
>> -static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> -			      struct cxl_register_map *map)
>> -{
>> -	int rc;
>> -
>> -	rc = cxl_find_regblock(pdev, type, map);
>> -
>> -	/*
>> -	 * If the Register Locator DVSEC does not exist, check if it
>> -	 * is an RCH and try to extract the Component Registers from
>> -	 * an RCRB.
>> -	 */
>> -	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
>> -		struct cxl_dport *dport;
>> -		struct cxl_port *port __free(put_cxl_port) =
>> -			cxl_pci_find_port(pdev, &dport);
>> -		if (!port)
>> -			return -EPROBE_DEFER;
>> -
>> -		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
>> -		if (rc)
>> -			return rc;
>> -
>> -		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
>> -		if (rc)
>> -			return rc;
>> -
>> -	} else if (rc) {
>> -		return rc;
>> -	}
>> -
>> -	return cxl_setup_regs(map);
>> -}
>> -
>>  static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>  {
>>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index fb70ffbba72d..fc7fbd4f39d2 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -641,4 +641,3 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>>  		return CXL_RESOURCE_NONE;
>>  	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
>>  }
>> -EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 1517250b0ec2..536c9d99e0e6 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -222,8 +222,6 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>>  		      struct cxl_register_map *map);
>>  int cxl_setup_regs(struct cxl_register_map *map);
>>  struct cxl_dport;
>> -resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>> -					   struct cxl_dport *dport);
>>  int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>>  
>>  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 3526e6d75f79..24aba9ff6d2e 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -74,6 +74,17 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
>>  	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
>>  }
>>  
>> +/*
>> + * Assume that the caller has already validated that @pdev has CXL
>> + * capabilities, any RCiEP with CXL capabilities is treated as a
>> + * Restricted CXL Device (RCD) and finds upstream port and endpoint
>> + * registers in a Root Complex Register Block (RCRB).
>> + */
>> +static inline bool is_cxl_restricted(struct pci_dev *pdev)
>> +{
>> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
>> +}
>> +
>>  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>>  struct cxl_dev_state;
>>  void read_cdat_data(struct cxl_port *port);
>> @@ -89,4 +100,6 @@ static inline void cxl_uport_init_ras_reporting(struct cxl_port *port,
>>  						struct device *host) { }
>>  #endif
>>  
>> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> +		       struct cxl_register_map *map);
>>  #endif /* __CXL_PCI_H__ */
>> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
>> index d8b8272ef87b..d422c81cefa3 100644
>> --- a/tools/testing/cxl/Kbuild
>> +++ b/tools/testing/cxl/Kbuild
>> @@ -7,7 +7,6 @@ ldflags-y += --wrap=nvdimm_bus_register
>>  ldflags-y += --wrap=devm_cxl_port_enumerate_dports
>>  ldflags-y += --wrap=cxl_await_media_ready
>>  ldflags-y += --wrap=devm_cxl_add_rch_dport
>> -ldflags-y += --wrap=cxl_rcd_component_reg_phys
>>  ldflags-y += --wrap=cxl_endpoint_parse_cdat
>>  ldflags-y += --wrap=cxl_dport_init_ras_reporting
>>  ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
>> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
>> index 995269a75cbd..92fd5c69bef3 100644
>> --- a/tools/testing/cxl/test/mock.c
>> +++ b/tools/testing/cxl/test/mock.c
>> @@ -226,23 +226,6 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
>>  
>> -resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
>> -						  struct cxl_dport *dport)
>> -{
>> -	int index;
>> -	resource_size_t component_reg_phys;
>> -	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>> -
>> -	if (ops && ops->is_mock_port(dev))
>> -		component_reg_phys = CXL_RESOURCE_NONE;
>> -	else
>> -		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
>> -	put_cxl_mock_ops(index);
>> -
>> -	return component_reg_phys;
>> -}
>> -EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, "CXL");
>> -
>>  void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
>>  {
>>  	int index;
>> -- 
>> 2.34.1
>>


