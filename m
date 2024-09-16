Return-Path: <netdev+bounces-128565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F4597A5C2
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 18:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E4F1F22ABC
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 16:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F66D158A1F;
	Mon, 16 Sep 2024 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYDFk2N8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAF2155335;
	Mon, 16 Sep 2024 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726503115; cv=none; b=fOB4yfyBh7h6BPkXoABb+pqHKQf+d7z3YbWPqG9SSvseN3xtWXuQ2AuIKh6DJ4t/3eqQblmq+eLORiwMQKBKwD6rAyEeYVYH6nC3T7gDmKNjSURPsdOujCkjlE7tZ0uzN9WIExseSlFmL/xBUJb4PxTd4zr+f8MO1lM+ubzB7wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726503115; c=relaxed/simple;
	bh=IU7jMOmWGeqeiPg0oHkdcAMdq2OOToSXn7vJdSgPg4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NHfAiBrSjM3VHTTSGGbg3x+9n8ONPnWB4knE1faYUS7gfqR6GVHn1IwcTSbPmTgq/xgLh8DO94IpnpDn60vH43dYZ71hye5OeNVgDDs51bczYTQ36tDr0aTnmHTsogtcuJVUHmD0nONssjTgFwlzZ0McLwJbw8ZUotHj0qAY7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SYDFk2N8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726503114; x=1758039114;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=IU7jMOmWGeqeiPg0oHkdcAMdq2OOToSXn7vJdSgPg4s=;
  b=SYDFk2N88mvrn7lKmhJ881ye7kPbfcKJ7b6mhg6G4K82bbbZHrR6KZsr
   qugCGKNvmKY1eSkqpH6bq5hX3HrS37uyN7IW3zQmVCMAUEgqMlY7HGS54
   jMIFqdsN7If709weCplg3EE6kpaVArTK4hTx0WUm35DhNWcUKX2RXIlSI
   oxqwBELdu7bZyvklEh1RWVM7GuL3yz0lpb5D3CTQm4zxnv+zeDFj8tyMn
   UZLzDCGSbZcUD6XoEh1r+KClv/X2sXNT7cbnDSPevoIxGcuk1zbSOLpp1
   JJ7w9m4wD3QQc1YIWKNgzafGGbiuCpHzqVym6QeFL4w+308k0BUzbR2n6
   g==;
X-CSE-ConnectionGUID: yCeNfxYcQpSXI3RsDaVNYA==
X-CSE-MsgGUID: 6KjuUHJvRZGuzQm536Z3IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="29083091"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="29083091"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 09:11:53 -0700
X-CSE-ConnectionGUID: 3Xw4JU1GSYKs+bFmCNhyag==
X-CSE-MsgGUID: UsXanHudReiLCFKB8nx6mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="68784031"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.18]) ([10.125.109.18])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 09:11:53 -0700
Message-ID: <cc2ef39f-97fd-471f-b2e9-5950cdb42fd1@intel.com>
Date: Mon, 16 Sep 2024 09:11:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/20] cxl/pci: add check for validating capabilities
To: Alejandro Lucero Palau <alucerop@amd.com>,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-4-alejandro.lucero-palau@amd.com>
 <18ce82cd-e5cc-44c3-ad87-f735f5dc4263@intel.com>
 <0db3b805-8c09-516b-c62c-8637c6a90da0@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0db3b805-8c09-516b-c62c-8637c6a90da0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/16/24 1:56 AM, Alejandro Lucero Palau wrote:
> 
> On 9/12/24 00:06, Dave Jiang wrote:
>>
>> On 9/7/24 1:18 AM, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> During CXL device initialization supported capabilities by the device
>>> are discovered. Type3 and Type2 devices have different mandatory
>>> capabilities and a Type2 expects a specific set including optional
>>> capabilities.
>>>
>>> Add a function for checking expected capabilities against those found
>>> during initialization.
>>>
>>> Rely on this function for validating capabilities instead of when CXL
>>> regs are probed.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> ---
>>>   drivers/cxl/core/pci.c  | 17 +++++++++++++++++
>>>   drivers/cxl/core/regs.c |  9 ---------
>>>   drivers/cxl/pci.c       | 12 ++++++++++++
>>>   include/linux/cxl/cxl.h |  2 ++
>>>   4 files changed, 31 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>> index 3d6564dbda57..57370d9beb32 100644
>>> --- a/drivers/cxl/core/pci.c
>>> +++ b/drivers/cxl/core/pci.c
>>> @@ -7,6 +7,7 @@
>>>   #include <linux/pci.h>
>>>   #include <linux/pci-doe.h>
>>>   #include <linux/aer.h>
>>> +#include <linux/cxl/cxl.h>
>>>   #include <linux/cxl/pci.h>
>>>   #include <cxlpci.h>
>>>   #include <cxlmem.h>
>>> @@ -1077,3 +1078,19 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>>>                        __cxl_endpoint_decoder_reset_detected);
>>>   }
>>>   EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
>>> +
>>> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
>>> +            u32 *current_caps)
>>> +{
>>> +    if (current_caps)
>>> +        *current_caps = cxlds->capabilities;
>>> +
>>> +    dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08x vs expected caps 0x%08x\n",
>>> +        cxlds->capabilities, expected_caps);
>>> +
>>> +    if ((cxlds->capabilities & expected_caps) != expected_caps)
>>> +        return false;
>>> +
>>> +    return true;
>>
>> I think you can just do
>> return (cxlds->capabilities & expected_caps) == expected_caps;
> 
> 
> Yes. I'll do.
> 
> 
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, CXL);
>>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>>> index 8b8abcadcb93..35f6dc97be6e 100644
>>> --- a/drivers/cxl/core/regs.c
>>> +++ b/drivers/cxl/core/regs.c
>>> @@ -443,15 +443,6 @@ static int cxl_probe_regs(struct cxl_register_map *map, u32 *caps)
>>>       case CXL_REGLOC_RBI_MEMDEV:
>>>           dev_map = &map->device_map;
>>>           cxl_probe_device_regs(host, base, dev_map, caps);
>>> -        if (!dev_map->status.valid || !dev_map->mbox.valid ||
>>> -            !dev_map->memdev.valid) {
>>> -            dev_err(host, "registers not found: %s%s%s\n",
>>> -                !dev_map->status.valid ? "status " : "",
>>> -                !dev_map->mbox.valid ? "mbox " : "",
>>> -                !dev_map->memdev.valid ? "memdev " : "");
>>> -            return -ENXIO;
>>> -        }
>>> -
>>>           dev_dbg(host, "Probing device registers...\n");
>>>           break;
>>>       default:
>>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>>> index 58f325019886..bec660357eec 100644
>>> --- a/drivers/cxl/pci.c
>>> +++ b/drivers/cxl/pci.c
>>> @@ -796,6 +796,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>       struct cxl_register_map map;
>>>       struct cxl_memdev *cxlmd;
>>>       int i, rc, pmu_count;
>>> +    u32 expected, found;
>>>       bool irq_avail;
>>>       u16 dvsec;
>>>   @@ -852,6 +853,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>       if (rc)
>>>           dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>>>   +    /* These are the mandatory capabilities for a Type3 device */
>>> +    expected = BIT(CXL_DEV_CAP_HDM) | BIT(CXL_DEV_CAP_DEV_STATUS) |
>>> +           BIT(CXL_DEV_CAP_MAILBOX_PRIMARY) | BIT(CXL_DEV_CAP_MEMDEV);
>> Maybe we can create a static mask for the expected mandatory type3 caps.
>>
>> I also wonder if cxl_pci_check_caps() can key on pci device type or class type and know which expected mask to use and no need to pass in the expected mask. Or since the driver is being attached to a certain device type, it should know what it is already, maybe we can attach static driver data to it that can be retrieved as the expected_caps:
>>
>> struct cxl_driver_data {
>>     u32 expected_caps;
>> };
>>
>> static struct cxl_driver_data cxl_driver_data = {
>>     .expected_caps = BIT(CXL_DEV_CAP_HDM) | BIT(CXL_DEV_CAP_DEV_STATUS) |
>>              BIT(CXL_DEV_CAP_MAILBOX_PRIMARY) | BIT(CXL_DEV_CAP_MEMDEV),
>> };
>>
>> static const struct pci_device_id cxl_mem_pci_tbl[] = {
>> /* Maybe need a new PCI_DEVICE_CLASS_DATA() macro */
>>     {
>>         .class = (PCI_CLASS_MEMORY_CXL << 8  | CXL_MEMORY_PROGIF),
>>         .class_mask = ~0,
>>         .vendor = PCI_ANY_ID,
>>         .device = PCI_ANY_ID,
>>         .sub_vendor = PCI_ANY_ID,
>>         .subdevice = PCI_ANY_ID,
>>         .driver_data = (kernel_ulong_t)&cxl_driver_data,
>>     },
>>     {},
>> };
>> MODULE_DEVICE_TABLE(pci, cxl_mem_pci_tbl);
>>
>> static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>> {
>>     struct cxl_driver_data *data = (struct cxl_driver_data *)id->driver_data;
>>
>>     rc = cxl_pci_check_caps(cxlds, data->expected_caps, &found);
>> ....
>> }
> 
> 
> I do not think this requires so much plumbing, but maybe using a macro for type3 mandatory caps makes sense.

ok sure.
> 
> About accel drivers, I'm not sure a macro is suitable because, I think, when hopefully CXL designs become mainstream, the caps will likely be needed to be extracted from the device somehow, other than what the CXL regs tell themselves, just for the sake of double checking. Thinking here of same base device with some changes regarding CXL in different device models/flavors.

I can see type2 have very different mandatory bits depending on the device. Maybe there's a small set of must haves for all.

> 
> 
>>> +
>>> +    if (!cxl_pci_check_caps(cxlds, expected, &found)) {
>>> +        dev_err(&pdev->dev,
>>> +            "Expected capabilities not matching with found capabilities: (%08x - %08x)\n",
>>> +            expected, found);
>>> +        return -ENXIO;
>>> +    }
>>> +
>>>       rc = cxl_await_media_ready(cxlds);
>>>       if (rc == 0)
>>>           cxlds->media_ready = true;
>>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>>> index 930b1b9c1d6a..4a57bf60403d 100644
>>> --- a/include/linux/cxl/cxl.h
>>> +++ b/include/linux/cxl/cxl.h
>>> @@ -48,4 +48,6 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>>>   void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>>>   int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>>                enum cxl_resource);
>>> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
>>> +            u32 *current_caps);
>>>   #endif
> 

