Return-Path: <netdev+bounces-228569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2430BCEBE7
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 01:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D025446D5
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 23:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040B627D770;
	Fri, 10 Oct 2025 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAFKFgh9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E4527CB0A;
	Fri, 10 Oct 2025 23:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760137920; cv=none; b=WzPDMZjm2PaXznCaDhNDDEvcK6Vi+6SmklJZbu61wm4NrSBGE3Pd16/GI1PHa5ZUk6RJWvR8/QnG0aL+1pcFOYVLDSezmhP3UGLyeqoy8UBAmz610gvp2F7ZeRhtL98ktQtUVnadwAj3++PGWB/E4jYJLwaxUUTLm9tCvtt5U3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760137920; c=relaxed/simple;
	bh=isJRgSZgIMnI8AN5tFMEfEqvLfjToJiGXx3/7CuGFIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4jzKh7RBXpfXoVo4i2mNpn966IoN+D7yOoauODgM/11QScPHs7i8nHNQixFDEmupmCSaurJ5DJpN7KaekddKp3vFL07LXSZgIOFClMhtnxKMLJisIlOC4OaSrtOn4Pp94aKvvaT/j0mdjrA0VbMQ3gGR17z5JV6PhOPN73e2dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAFKFgh9; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760137919; x=1791673919;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=isJRgSZgIMnI8AN5tFMEfEqvLfjToJiGXx3/7CuGFIc=;
  b=AAFKFgh9l2VBIb8T+UzZYmRt1ca5nQS4wV/tl3tlg20tMKPTfmj+7p/r
   ax0W2pC0haSaj8YIA9tFiBImDZVgeMHI4KEUvKPJOIct4mQxK7sH2RpuI
   lxPsrKjWbVZuc8k8QXtggd9/z5nIh5X92einrz142sdDY2RAmgkaOTIwu
   ZGUafDe2mi3AvTzyQ6w6XBrPPnZas1PqUdaRw8Ct/LlaM0glSldm0gK9E
   LDLZOkdBFE/8PdenSODXCAMPLmIXVeH85HeOWgZGf3vvrcF71miBd4Kvz
   MwnyBJHBE6ZdlokxeBD6CgesaxfKYGWn4HB9FKVIdM7TuXtpm0e5mIbXz
   Q==;
X-CSE-ConnectionGUID: Gt3U0fYHTOuVljjBQvsJAA==
X-CSE-MsgGUID: /SDuW3X0SYKDJBtIgREkOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62401739"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="62401739"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 16:11:58 -0700
X-CSE-ConnectionGUID: c3MRgroETPqUtiBkiSDblw==
X-CSE-MsgGUID: DyQrwcL2TGKf7DBVsTDWwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="211737327"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.111.66]) ([10.125.111.66])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 16:11:58 -0700
Message-ID: <fef7947c-c897-4b27-bd45-8364cb6fdf2d@intel.com>
Date: Fri, 10 Oct 2025 16:11:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 01/22] cxl/mem: Arrange for always-synchronous memdev
 attach
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 Alejandro Lucero <alucerop@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-2-alejandro.lucero-palau@amd.com>
 <20251007134053.00000dd3@huawei.com> <20251007134224.0000502a@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20251007134224.0000502a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/7/25 5:42 AM, Jonathan Cameron wrote:
> On Tue, 7 Oct 2025 13:40:53 +0100
> Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> 
>> On Mon, 6 Oct 2025 11:01:09 +0100
>> <alejandro.lucero-palau@amd.com> wrote:
>>
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> In preparation for CXL accelerator drivers that have a hard dependency on
>>> CXL capability initialization, arrange for the endpoint probe result to be
>>> conveyed to the caller of devm_cxl_add_memdev().
>>>
>>> As it stands cxl_pci does not care about the attach state of the cxl_memdev
>>> because all generic memory expansion functionality can be handled by the
>>> cxl_core. For accelerators, that driver needs to know perform driver
>>> specific initialization if CXL is available, or exectute a fallback to PCIe
>>> only operation.
>>>
>>> By moving devm_cxl_add_memdev() to cxl_mem.ko it removes async module
>>> loading as one reason that a memdev may not be attached upon return from
>>> devm_cxl_add_memdev().
>>>
>>> The diff is busy as this moves cxl_memdev_alloc() down below the definition
>>> of cxl_memdev_fops and introduces devm_cxl_memdev_add_or_reset() to
>>> preclude needing to export more symbols from the cxl_core.
>>>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>
>> Alejandro, SoB chain broken here which makes this currently unmergeable.
>>
>> Should definitely have your SoB as you sent the patch to the list and need
>> to make a statement that you believe it to be fine to do so (see the Certificate
>> of origin stuff in the docs).  Also, From should always be one of the authors.
>> If Dan wrote this as the SoB suggests then From should be set to him..
>>
>> git commit --amend --author="Dan Williams <dan.j.williams@intel.com>"
>>
>> Will fix that up.  Then either you add your SoB on basis you just 'handled'
>> the patch but didn't make substantial changes, or your SoB and a Codeveloped-by
>> if you did make major changes.  If it is minor stuff you can an
>> a sign off with # what changed 
>> comment next to it.
>>
>> A few minor comments inline.
> 
> oops. I see this was part of Dan's series that has merged by now...

Dan's changes has not been merged AFAIK.

DJ

> 
> Never mind unless you want to take any of the suggested tweaks forwards.
> 
> J
>>
>> Thanks,
>>
>> Jonathan
>>
>>
>>> ---
>>>  drivers/cxl/Kconfig       |  2 +-
>>>  drivers/cxl/core/memdev.c | 97 ++++++++++++++++-----------------------
>>>  drivers/cxl/mem.c         | 30 ++++++++++++
>>>  drivers/cxl/private.h     | 11 +++++
>>>  4 files changed, 82 insertions(+), 58 deletions(-)
>>>  create mode 100644 drivers/cxl/private.h
>>>
>>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>>> index 028201e24523..111e05615f09 100644
>>> --- a/drivers/cxl/Kconfig
>>> +++ b/drivers/cxl/Kconfig
>>> @@ -22,6 +22,7 @@ if CXL_BUS
>>>  config CXL_PCI
>>>  	tristate "PCI manageability"
>>>  	default CXL_BUS
>>> +	select CXL_MEM
>>>  	help
>>>  	  The CXL specification defines a "CXL memory device" sub-class in the
>>>  	  PCI "memory controller" base class of devices. Device's identified by
>>> @@ -89,7 +90,6 @@ config CXL_PMEM
>>>  
>>>  config CXL_MEM
>>>  	tristate "CXL: Memory Expansion"
>>> -	depends on CXL_PCI
>>>  	default CXL_BUS
>>>  	help
>>>  	  The CXL.mem protocol allows a device to act as a provider of "System
>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>> index c569e00a511f..2bef231008df 100644
>>> --- a/drivers/cxl/core/memdev.c
>>> +++ b/drivers/cxl/core/memdev.c
>>
>>> -
>>> -err:
>>> -	kfree(cxlmd);
>>> -	return ERR_PTR(rc);
>>>  }
>>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_add_or_reset, "CXL");
>>>  
>>>  static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
>>>  			       unsigned long arg)
>>> @@ -1023,50 +1012,44 @@ static const struct file_operations cxl_memdev_fops = {
>>>  	.llseek = noop_llseek,
>>>  };
>>>  
>>> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>> -				       struct cxl_dev_state *cxlds)
>>> +struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
>>>  {
>>>  	struct cxl_memdev *cxlmd;
>>>  	struct device *dev;
>>>  	struct cdev *cdev;
>>>  	int rc;
>>>  
>>> -	cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
>>> -	if (IS_ERR(cxlmd))
>>> -		return cxlmd;
>>> +	cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
>>
>> It's a little bit non obvious due to the device initialize mid way
>> through this, but given there are no error paths after that you can
>> currently just do.
>> 	struct cxl_memdev *cxlmd __free(kfree) =
>> 		cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
>> and
>> 	return_ptr(cxlmd);
>>
>> in the good path.  That lets you then just return rather than having
>> the goto err: handling for the error case that currently frees this
>> manually.
>>
>> Unlike the change below, this one I think is definitely worth making.
>>
>>
>>> +	if (!cxlmd)
>>> +		return ERR_PTR(-ENOMEM);
>>>  
>>> -	dev = &cxlmd->dev;
>>> -	rc = dev_set_name(dev, "mem%d", cxlmd->id);
>>> -	if (rc)
>>> +	rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, GFP_KERNEL);
>>> +	if (rc < 0)
>>>  		goto err;
>>> -
>>> -	/*
>>> -	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
>>> -	 * needed as this is ordered with cdev_add() publishing the device.
>>> -	 */
>>> +	cxlmd->id = rc;
>>> +	cxlmd->depth = -1;
>>>  	cxlmd->cxlds = cxlds;
>>>  	cxlds->cxlmd = cxlmd;
>>>  
>>> -	cdev = &cxlmd->cdev;
>>> -	rc = cdev_device_add(cdev, dev);
>>> -	if (rc)
>>> -		goto err;
>>> +	dev = &cxlmd->dev;
>>> +	device_initialize(dev);
>>> +	lockdep_set_class(&dev->mutex, &cxl_memdev_key);
>>> +	dev->parent = cxlds->dev;
>>> +	dev->bus = &cxl_bus_type;
>>> +	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>>> +	dev->type = &cxl_memdev_type;
>>> +	device_set_pm_not_required(dev);
>>> +	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>>>  
>>> -	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
>>> -	if (rc)
>>> -		return ERR_PTR(rc);
>>> +	cdev = &cxlmd->cdev;
>>> +	cdev_init(cdev, &cxl_memdev_fops);
>>>  	return cxlmd;
>>>  
>>>  err:
>>> -	/*
>>> -	 * The cdev was briefly live, shutdown any ioctl operations that
>>> -	 * saw that state.
>>> -	 */
>>> -	cxl_memdev_shutdown(dev);
>>> -	put_device(dev);
>>> +	kfree(cxlmd);
>>>  	return ERR_PTR(rc);
>>>  }
>>> -EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
>>> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_alloc, "CXL");
>>>  
>>>  static void sanitize_teardown_notifier(void *data)
>>>  {
>>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>>> index f7dc0ba8905d..144749b9c818 100644
>>> --- a/drivers/cxl/mem.c
>>> +++ b/drivers/cxl/mem.c
>>> @@ -7,6 +7,7 @@
>>>  
>>>  #include "cxlmem.h"
>>>  #include "cxlpci.h"
>>> +#include "private.h"
>>>  #include "core/core.h"
>>>  
>>>  /**
>>> @@ -203,6 +204,34 @@ static int cxl_mem_probe(struct device *dev)
>>>  	return devm_add_action_or_reset(dev, enable_suspend, NULL);
>>>  }
>>>  
>>> +/**
>>> + * devm_cxl_add_memdev - Add a CXL memory device
>>> + * @host: devres alloc/release context and parent for the memdev
>>> + * @cxlds: CXL device state to associate with the memdev
>>> + *
>>> + * Upon return the device will have had a chance to attach to the
>>> + * cxl_mem driver, but may fail if the CXL topology is not ready
>>> + * (hardware CXL link down, or software platform CXL root not attached)
>>> + */
>>> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>> +				       struct cxl_dev_state *cxlds)
>>> +{
>>> +	struct cxl_memdev *cxlmd = cxl_memdev_alloc(cxlds);
>>
>> Bit marginal but you could do a DEFINE_FREE() for cxlmd 
>> similar to the one that exists for put_cxl_port
>>
>> You would then need to steal the pointer for the devm_ call at the
>> end of this function.
>>
>>
>>> +	int rc;
>>> +
>>> +	if (IS_ERR(cxlmd))
>>> +		return cxlmd;
>>> +
>>> +	rc = dev_set_name(&cxlmd->dev, "mem%d", cxlmd->id);
>>> +	if (rc) {
>>> +		put_device(&cxlmd->dev);
>>> +		return ERR_PTR(rc);
>>> +	}
>>> +
>>> +	return devm_cxl_memdev_add_or_reset(host, cxlmd);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
> 


