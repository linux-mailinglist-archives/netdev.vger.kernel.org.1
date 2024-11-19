Return-Path: <netdev+bounces-146292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B43719D2A31
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 16:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467E41F2149A
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C621CF2BD;
	Tue, 19 Nov 2024 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQYNS8vV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689841CF2B6;
	Tue, 19 Nov 2024 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031589; cv=none; b=RFdViUPoP6+otauH+7jDkVAWeanr+z/D0xg1Z0CmKcY7lW9eUH/gukM/fEwb0iVhW4EQBNy8ANns2IAaqCkFXF7znykHYHiGXkTSag2J1D/uAgsSsL/kM1dX45/+CYZ5loGkVQfzd6WUe/KmMYDqEGTIwk2BMI0kR+ZaWVEgexM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031589; c=relaxed/simple;
	bh=kUezhExMJkBnLgvZ/DWF6MPKz29TCzkHmsuAPCYcnho=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ka7YuBOp3BW1v0J6AQ/P3NKTbZYMrTc0jXFUSPSRTN60sYqeW3VLt3oPINW+z/MpqMhnzCtX40vdsbfrHdcYn1BhIFe4y491UjZLdE6XFZY/hPZL5MQiw/smIphmACq6PAzBA1Zu6S9OnXiKf3kSKAu2OXbTh37FtZy5SK3iIVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQYNS8vV; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732031587; x=1763567587;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=kUezhExMJkBnLgvZ/DWF6MPKz29TCzkHmsuAPCYcnho=;
  b=eQYNS8vVWFtDYnTlL1Wn6znFfH5qF5US1kbHmCNeiA72nvcTmRs8+a5K
   wjhBIqmpI3rkKO9Z5CryFkzYVOX430ky/gGBKe6fWvrVTIde2ydRhViNO
   wfDU847iVRnmtqVIp8XV4YW4WhcRnm/oNQrmIzwjzRCstt7RrkVdQXbSM
   t73KmrPmMDUhIoBKR7KIg6Lm/kjHTURafp8+VL696MB9gF8RF6RJkp53f
   MzA4WTPg65T+EzDFTIa2CIwnpyXi8Rc7E48Ah9nTlWk4oT+VumplPUaCx
   vTIJVdPjlXgtAA8QNz9gv+kvNydEH32cVXCTce6zvN7NcXb9m+AMcm3h9
   Q==;
X-CSE-ConnectionGUID: HtFAUaUAS1ekk7VLJaGkPg==
X-CSE-MsgGUID: sM6E06YQQIO7qlC3O+oSyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="32191758"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="32191758"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 07:53:06 -0800
X-CSE-ConnectionGUID: vvfNnoJHTJmo4XRVh6O0Mg==
X-CSE-MsgGUID: bR+bmpt4T8CJz7+K3s6VQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="89759152"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.109.91]) ([10.125.109.91])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 07:53:05 -0800
Message-ID: <bfd5e93f-6250-42d5-bf13-b0d57c26acfd@intel.com>
Date: Tue, 19 Nov 2024 08:53:03 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/27] cxl: add capabilities field to cxl_dev_state and
 cxl_port
To: Alejandro Lucero Palau <alucerop@amd.com>,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-4-alejandro.lucero-palau@amd.com>
 <0ca7d9ba-2d01-4678-b109-ca49091266f4@intel.com>
 <7c988754-fb25-bd8b-49bf-b0dae845e81c@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <7c988754-fb25-bd8b-49bf-b0dae845e81c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/19/24 5:28 AM, Alejandro Lucero Palau wrote:
> 
> On 11/18/24 22:52, Dave Jiang wrote:
>>
>> On 11/18/24 9:44 AM, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Type2 devices have some Type3 functionalities as optional like an mbox
>>> or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
>>> implements.
>>>
>>> Add a new field to cxl_dev_state for keeping device capabilities as discovered
>>> during initialization. Add same field to cxl_port as registers discovery
>>> is also used during port initialization.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> ---
>>>   drivers/cxl/core/port.c | 11 +++++++----
>>>   drivers/cxl/core/regs.c | 21 ++++++++++++++-------
>>>   drivers/cxl/cxl.h       |  9 ++++++---
>>>   drivers/cxl/cxlmem.h    |  2 ++
>>>   drivers/cxl/pci.c       | 10 ++++++----
>>>   include/cxl/cxl.h       | 30 ++++++++++++++++++++++++++++++
>>>   6 files changed, 65 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>>> index af92c67bc954..5bc8490a199c 100644
>>> --- a/drivers/cxl/core/port.c
>>> +++ b/drivers/cxl/core/port.c
>>> @@ -749,7 +749,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>>>   }
>>>     static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map,
>>> -                   resource_size_t component_reg_phys)
>>> +                   resource_size_t component_reg_phys, unsigned long *caps)
>>>   {
>>>       *map = (struct cxl_register_map) {
>>>           .host = host,
>>> @@ -763,7 +763,7 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
>>>       map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>>>       map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>>>   -    return cxl_setup_regs(map);
>>> +    return cxl_setup_regs(map, caps);
>>>   }
>>>     static int cxl_port_setup_regs(struct cxl_port *port,
>>> @@ -772,7 +772,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
>>>       if (dev_is_platform(port->uport_dev))
>>>           return 0;
>>>       return cxl_setup_comp_regs(&port->dev, &port->reg_map,
>>> -                   component_reg_phys);
>>> +                   component_reg_phys, port->capabilities);
>>>   }
>>>     static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>>> @@ -789,7 +789,8 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>>>        * NULL.
>>>        */
>>>       rc = cxl_setup_comp_regs(dport->dport_dev, &dport->reg_map,
>>> -                 component_reg_phys);
>>> +                 component_reg_phys,
>>> +                 dport->port->capabilities);
>>>       dport->reg_map.host = host;
>>>       return rc;
>>>   }
>>> @@ -851,6 +852,8 @@ static int cxl_port_add(struct cxl_port *port,
>>>           port->reg_map = cxlds->reg_map;
>>>           port->reg_map.host = &port->dev;
>>>           cxlmd->endpoint = port;
>>> +        bitmap_copy(port->capabilities, cxlds->capabilities,
>>> +                CXL_MAX_CAPS);
>>>       } else if (parent_dport) {
>>>           rc = dev_set_name(dev, "port%d", port->id);
>>>           if (rc)
>>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>>> index e1082e749c69..8287ec45b018 100644
>>> --- a/drivers/cxl/core/regs.c
>>> +++ b/drivers/cxl/core/regs.c
>>> @@ -4,6 +4,7 @@
>>>   #include <linux/device.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/pci.h>
>>> +#include <cxl/cxl.h>
>>>   #include <cxlmem.h>
>>>   #include <cxlpci.h>
>>>   #include <pmu.h>
>>> @@ -36,7 +37,8 @@
>>>    * Probe for component register information and return it in map object.
>>>    */
>>>   void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>> -                  struct cxl_component_reg_map *map)
>>> +                  struct cxl_component_reg_map *map,
>>> +                  unsigned long *caps)
>>>   {
>>>       int cap, cap_count;
>>>       u32 cap_array;
>>> @@ -84,6 +86,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>>               decoder_cnt = cxl_hdm_decoder_count(hdr);
>>>               length = 0x20 * decoder_cnt + 0x10;
>>>               rmap = &map->hdm_decoder;
>>> +            *caps |= BIT(CXL_DEV_CAP_HDM);
>>>               break;
>>>           }
>>>           case CXL_CM_CAP_CAP_ID_RAS:
>>> @@ -91,6 +94,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>>                   offset);
>>>               length = CXL_RAS_CAPABILITY_LENGTH;
>>>               rmap = &map->ras;
>>> +            *caps |= BIT(CXL_DEV_CAP_RAS);
>>>               break;
>>>           default:
>>>               dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
>>> @@ -117,7 +121,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, CXL);
>>>    * Probe for device register information and return it in map object.
>>>    */
>>>   void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>> -               struct cxl_device_reg_map *map)
>>> +               struct cxl_device_reg_map *map, unsigned long *caps)
>>>   {
>>>       int cap, cap_count;
>>>       u64 cap_array;
>>> @@ -146,10 +150,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>>           case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
>>>               dev_dbg(dev, "found Status capability (0x%x)\n", offset);
>>>               rmap = &map->status;
>>> +            *caps |= BIT(CXL_DEV_CAP_DEV_STATUS);
>>>               break;
>>>           case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
>>>               dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
>>>               rmap = &map->mbox;
>>> +            *caps |= BIT(CXL_DEV_CAP_MAILBOX_PRIMARY);
>>>               break;
>>>           case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
>>>               dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
>>> @@ -157,6 +163,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>>           case CXLDEV_CAP_CAP_ID_MEMDEV:
>>>               dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
>>>               rmap = &map->memdev;
>>> +            *caps |= BIT(CXL_DEV_CAP_MEMDEV);
>>>               break;
>>>           default:
>>>               if (cap_id >= 0x8000)
>>> @@ -421,7 +428,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
>>>       map->base = NULL;
>>>   }
>>>   -static int cxl_probe_regs(struct cxl_register_map *map)
>>> +static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
>>>   {
>>>       struct cxl_component_reg_map *comp_map;
>>>       struct cxl_device_reg_map *dev_map;
>>> @@ -431,12 +438,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>>>       switch (map->reg_type) {
>>>       case CXL_REGLOC_RBI_COMPONENT:
>>>           comp_map = &map->component_map;
>>> -        cxl_probe_component_regs(host, base, comp_map);
>>> +        cxl_probe_component_regs(host, base, comp_map, caps);
>>>           dev_dbg(host, "Set up component registers\n");
>>>           break;
>>>       case CXL_REGLOC_RBI_MEMDEV:
>>>           dev_map = &map->device_map;
>>> -        cxl_probe_device_regs(host, base, dev_map);
>>> +        cxl_probe_device_regs(host, base, dev_map, caps);
>>>           if (!dev_map->status.valid || !dev_map->mbox.valid ||
>>>               !dev_map->memdev.valid) {
>>>               dev_err(host, "registers not found: %s%s%s\n",
>>> @@ -455,7 +462,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>>>       return 0;
>>>   }
>>>   -int cxl_setup_regs(struct cxl_register_map *map)
>>> +int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps)
>>>   {
>>>       int rc;
>>>   @@ -463,7 +470,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
>>>       if (rc)
>>>           return rc;
>>>   -    rc = cxl_probe_regs(map);
>>> +    rc = cxl_probe_regs(map, caps);
>>>       cxl_unmap_regblock(map);
>>>         return rc;
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index a2be05fd7aa2..e5f918be6fe4 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -4,6 +4,7 @@
>>>   #ifndef __CXL_H__
>>>   #define __CXL_H__
>>>   +#include <cxl/cxl.h>
>>>   #include <linux/libnvdimm.h>
>>>   #include <linux/bitfield.h>
>>>   #include <linux/notifier.h>
>>> @@ -284,9 +285,9 @@ struct cxl_register_map {
>>>   };
>>>     void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>> -                  struct cxl_component_reg_map *map);
>>> +                  struct cxl_component_reg_map *map, unsigned long *caps);
>>>   void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>> -               struct cxl_device_reg_map *map);
>>> +               struct cxl_device_reg_map *map, unsigned long *caps);
>>>   int cxl_map_component_regs(const struct cxl_register_map *map,
>>>                  struct cxl_component_regs *regs,
>>>                  unsigned long map_mask);
>>> @@ -300,7 +301,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>>>                      struct cxl_register_map *map, int index);
>>>   int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>>>                 struct cxl_register_map *map);
>>> -int cxl_setup_regs(struct cxl_register_map *map);
>>> +int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps);
>>>   struct cxl_dport;
>>>   resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>>>                          struct cxl_dport *dport);
>>> @@ -600,6 +601,7 @@ struct cxl_dax_region {
>>>    * @cdat: Cached CDAT data
>>>    * @cdat_available: Should a CDAT attribute be available in sysfs
>>>    * @pci_latency: Upstream latency in picoseconds
>>> + * @capabilities: those capabilities as defined in device mapped registers
>>>    */
>>>   struct cxl_port {
>>>       struct device dev;
>>> @@ -623,6 +625,7 @@ struct cxl_port {
>>>       } cdat;
>>>       bool cdat_available;
>>>       long pci_latency;
>>> +    DECLARE_BITMAP(capabilities, CXL_MAX_CAPS);
>>>   };
>>>     /**
>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>> index 2a25d1957ddb..4c1c53c29544 100644
>>> --- a/drivers/cxl/cxlmem.h
>>> +++ b/drivers/cxl/cxlmem.h
>>> @@ -428,6 +428,7 @@ struct cxl_dpa_perf {
>>>    * @serial: PCIe Device Serial Number
>>>    * @type: Generic Memory Class device or Vendor Specific Memory device
>>>    * @cxl_mbox: CXL mailbox context
>>> + * @capabilities: those capabilities as defined in device mapped registers
>>>    */
>>>   struct cxl_dev_state {
>>>       struct device *dev;
>>> @@ -443,6 +444,7 @@ struct cxl_dev_state {
>>>       u64 serial;
>>>       enum cxl_devtype type;
>>>       struct cxl_mailbox cxl_mbox;
>>> +    DECLARE_BITMAP(capabilities, CXL_MAX_CAPS);
>>>   };
>>>     static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>>> index 0b910ef52db7..528d4ca79fd1 100644
>>> --- a/drivers/cxl/pci.c
>>> +++ b/drivers/cxl/pci.c
>>> @@ -504,7 +504,8 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>>>   }
>>>     static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>> -                  struct cxl_register_map *map)
>>> +                  struct cxl_register_map *map,
>>> +                  unsigned long *caps)
>>>   {
>>>       int rc;
>>>   @@ -521,7 +522,7 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>>       if (rc)
>>>           return rc;
>>>   -    return cxl_setup_regs(map);
>>> +    return cxl_setup_regs(map, caps);
>>>   }
>>>     static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>> @@ -848,7 +849,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>         cxl_set_dvsec(cxlds, dvsec);
>>>   -    rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>>> +    rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
>>> +                cxlds->capabilities);
>>>       if (rc)
>>>           return rc;
>>>   @@ -861,7 +863,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>        * still be useful for management functions so don't return an error.
>>>        */
>>>       rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>>> -                &cxlds->reg_map);
>>> +                &cxlds->reg_map, cxlds->capabilities);
>>>       if (rc)
>>>           dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>>>       else if (!cxlds->reg_map.component_map.ras.valid)
>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>>> index 19e5d883557a..dcc9ec8a0aec 100644
>>> --- a/include/cxl/cxl.h
>>> +++ b/include/cxl/cxl.h
>>> @@ -12,6 +12,36 @@ enum cxl_resource {
>>>       CXL_RES_PMEM,
>>>   };
>>>   +/* Capabilities as defined for:
>>> + *
>>> + *    Component Registers (Table 8-22 CXL 3.1 specification)
>>> + *    Device Registers (8.2.8.2.1 CXL 3.1 specification)
>>> + */
>>> +
>>> +enum cxl_dev_cap {
>>> +    /* capabilities from Component Registers */
>>> +    CXL_DEV_CAP_RAS,
>>> +    CXL_DEV_CAP_SEC,
>> There are a few caps that does not seem to be used yet. Should we not bother defining them until they are being used?
> 
> 
> Jonathan Cameron did suggest it as well, but I think, only when dealing with capabilities discovery and checking.
> 
> It is weird to me to mention the specs here and just list a few of the capabilities defined, but I will remove those not used yet if that is the general view.

I think that is perfectly fine not to define them all. In general we want to avoid "dead code" in the kernel if there's no usage yet. When a cap is needed later we can add intentionally. Given this is just enum that is not tied specifically to hardware positions, defining them later on when needed should not impact the current code. 

> 
> 
>>> +    CXL_DEV_CAP_LINK,
>>> +    CXL_DEV_CAP_HDM,
>>> +    CXL_DEV_CAP_SEC_EXT,
>>> +    CXL_DEV_CAP_IDE,
>>> +    CXL_DEV_CAP_SNOOP_FILTER,
>>> +    CXL_DEV_CAP_TIMEOUT_AND_ISOLATION,
>>> +    CXL_DEV_CAP_CACHEMEM_EXT,
>>> +    CXL_DEV_CAP_BI_ROUTE_TABLE,
>>> +    CXL_DEV_CAP_BI_DECODER,
>>> +    CXL_DEV_CAP_CACHEID_ROUTE_TABLE,
>>> +    CXL_DEV_CAP_CACHEID_DECODER,
>>> +    CXL_DEV_CAP_HDM_EXT,
>>> +    CXL_DEV_CAP_METADATA_EXT,
>>> +    /* capabilities from Device Registers */
>>> +    CXL_DEV_CAP_DEV_STATUS,
>>> +    CXL_DEV_CAP_MAILBOX_PRIMARY,
>>> +    CXL_DEV_CAP_MEMDEV,
>>> +    CXL_MAX_CAPS = 32
>> This is changed to 64 in the next patch. Should it just be set to 64 here? I assume you just wanted a bitmap that's u64 long?
> 
> 
> Oh, yes, I should change it here.
> 
>  It was suggested to use CXL_MAX_CAPS for clearing/zeroing new allocated bitmaps instead of BITS_PER_TYPE(unsigned long) as in v4, and for that to work, CXL_MAX_CAPS needs to be defined taking into account the size of unsigned long, which is the minimum unit for BITMAP. For x86_64 that is 8 bytes. Otherwise the clearing would leave the upper 32 bits untouched.
> 
> Thanks!
> 
> 
>> DJ
>>
>>> +};
>>> +
>>>   struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>>>     void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>>


