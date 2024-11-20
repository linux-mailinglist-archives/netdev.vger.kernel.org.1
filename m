Return-Path: <netdev+bounces-146539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F72A9D40ED
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 18:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E301F2207A
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 17:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DE613C3D3;
	Wed, 20 Nov 2024 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fx1RSNNo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64DF762F7;
	Wed, 20 Nov 2024 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732122965; cv=none; b=ESomZzRA7Qh+1INm3Dntk5SeMkNSU2XkV0HGjZP6pWb4BiFNd4MCr3M0ls/L4KybxBrZC9qqAHsOKVlO+pxvUruq/GOyXLfoXHo7wClXcw4VxBCSiVv+iKLfLyn4qAI+vgNOF6JPUKBc8opd/+mGahTuGBvnXUqKdHs7ei48wHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732122965; c=relaxed/simple;
	bh=FuXUjzZrOK3Oo5713C/mQ/5VHWIoRWxN+NW2E1aO92A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UI0hhmMQhamBfMfGV7jnaWFJLVLQ2NQKFypmwqPe+OXIDi/uTfVkoFohLfoFww3U9cIgMlLYZf+VrNCAgBQZmHh3d2ULt32L3O2xPJ3P81e8rkjaUi2S5vITilQsc/vNHNwMss9XdXwBJxr6trQ1OYQqkXFwxELLhdkSvxB+QLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fx1RSNNo; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732122962; x=1763658962;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FuXUjzZrOK3Oo5713C/mQ/5VHWIoRWxN+NW2E1aO92A=;
  b=fx1RSNNomvLTlhXMmUFLgOUfp6UoEnBoNOEGgYKPiMk0Ug2hUY1x7heJ
   plk0LaukU9vSeU1PSIbGIO+AXc27a54VdkfgxTn47fWoJ5Du/kBPpiSWg
   3oMutaL+AAwMjFU4p8huRF/f4i3tfOQhYqI27aBIV3h092T+NhEux/vCz
   LP8G8rQD4++1GXZdi/peLas6X0KU/swDmRF4WJEiS+XZWQwqcHpfsaZG3
   y4+3gHgq09EXxtiNvoR+gCVxvgolqiZCuB8cwXNuZ60Ls5xxm9Qd0b0XH
   g+Qnzqnaky2ZEFwSqhDEDdfvNT5TzhA4nMCWrCUVmVIbaDjJ6PFVDsAIH
   Q==;
X-CSE-ConnectionGUID: /B1Rsf71St2ALjHnfpx0nQ==
X-CSE-MsgGUID: W5Ns517aSrO1IYhqNJv8ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="32351551"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="32351551"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 09:16:01 -0800
X-CSE-ConnectionGUID: eDDg74a6SzyNNWPg8tgtsw==
X-CSE-MsgGUID: ck18wf3WSaCQDlCni+vnmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="94046472"
Received: from bmurrell-mobl.amr.corp.intel.com (HELO [10.125.109.160]) ([10.125.109.160])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 09:16:00 -0800
Message-ID: <1a788b8b-48b8-4853-906f-97af5952ce21@intel.com>
Date: Wed, 20 Nov 2024 10:15:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/27] cxl: prepare memdev creation for type2
To: Alejandro Lucero Palau <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-14-alejandro.lucero-palau@amd.com>
 <75e8c64e-5d0c-4ebf-843e-e5e4dd0aa5ec@intel.com>
 <20241119220605.00005808@nvidia.com>
 <4fc8fd99-f349-47f9-8f5e-d4c393370ada@intel.com>
 <e2e4136c-87ec-7e4a-d576-8c0002572893@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <e2e4136c-87ec-7e4a-d576-8c0002572893@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/20/24 6:57 AM, Alejandro Lucero Palau wrote:
> 
> On 11/19/24 21:27, Dave Jiang wrote:
>>
>> On 11/19/24 1:06 PM, Zhi Wang wrote:
>>> On Tue, 19 Nov 2024 11:24:44 -0700
>>> Dave Jiang <dave.jiang@intel.com> wrote:
>>>
>>>>
>>>> On 11/18/24 9:44 AM, alejandro.lucero-palau@amd.com wrote:
>>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>>
>>>>> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device
>>>>> when creating a memdev leading to problems when obtaining
>>>>> cxl_memdev_state references from a CXL_DEVTYPE_DEVMEM type. This
>>>>> last device type is managed by a specific vendor driver and does
>>>>> not need same sysfs files since not userspace intervention is
>>>>> expected.
>>>>>
>>>>> Create a new cxl_mem device type with no attributes for Type2.
>>>>>
>>>>> Avoid debugfs files relying on existence of clx_memdev_state.
>>>>>
>>>>> Make devm_cxl_add_memdev accesible from a accel driver.
>>>>>
>>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>>> ---
>>>>>   drivers/cxl/core/cdat.c   |  3 +++
>>>>>   drivers/cxl/core/memdev.c | 15 +++++++++++++--
>>>>>   drivers/cxl/core/region.c |  3 ++-
>>>>>   drivers/cxl/mem.c         | 25 +++++++++++++++++++------
>>>>>   include/cxl/cxl.h         |  2 ++
>>>>>   5 files changed, 39 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>>>>> index e9cd7939c407..192cff18ea25 100644
>>>>> --- a/drivers/cxl/core/cdat.c
>>>>> +++ b/drivers/cxl/core/cdat.c
>>>>> @@ -577,6 +577,9 @@ static struct cxl_dpa_perf
>>>>> *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxle struct
>>>>> cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds); struct
>>>>> cxl_dpa_perf *perf;
>>>>> +    if (!mds)
>>>>> +        return ERR_PTR(-EINVAL);
>>>>> +
>>>>>       switch (mode) {
>>>>>       case CXL_DECODER_RAM:
>>>>>           perf = &mds->ram_perf;
>>>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>>>> index d746c8a1021c..df31eea0c06b 100644
>>>>> --- a/drivers/cxl/core/memdev.c
>>>>> +++ b/drivers/cxl/core/memdev.c
>>>>> @@ -547,9 +547,17 @@ static const struct device_type
>>>>> cxl_memdev_type = { .groups = cxl_memdev_attribute_groups,
>>>>>   };
>>>>>   +static const struct device_type cxl_accel_memdev_type = {
>>>>> +    .name = "cxl_memdev",
>>>>> +    .release = cxl_memdev_release,
>>>>> +    .devnode = cxl_memdev_devnode,
>>>>> +};
>>>>> +
>>>>>   bool is_cxl_memdev(const struct device *dev)
>>>>>   {
>>>>> -    return dev->type == &cxl_memdev_type;
>>>>> +    return (dev->type == &cxl_memdev_type ||
>>>>> +        dev->type == &cxl_accel_memdev_type);
>>>>> +
>>>>>   }
>>>>>   EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, CXL);
>>>> Does type2 device also exports a CDAT?
>>>>
>>> Yes. Type2 can also export a CDAT.
>> Thanks! Probably should have the split out helpers regardless.
> 
> 
> Maybe, but should not we wait until that is required? I did not see the need for adding them with this patchset.

Sure. I think my concern is with paths that apply only to one type but not the other. If you have not encountered any then we can wait.

DJ

> 
> 
>>>> I'm also wondering if we should have distinctive helpers:
>>>> is_cxl_type3_memdev()
>>>> is_cxl_type2_memdev()
>>>>
>>>> and is_cxl_memdev() is just calling those two helpers above.
>>>>
>>>> And if no CDAT is exported, we should change the is_cxl_memdev() to
>>>> is_cxl_type3_memdev() in read_cdat_data().
>>>>
>>>> DJ
>>>>
>>>>>   @@ -660,7 +668,10 @@ static struct cxl_memdev
>>>>> *cxl_memdev_alloc(struct cxl_dev_state *cxlds, dev->parent =
>>>>> cxlds->dev; dev->bus = &cxl_bus_type;
>>>>>       dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>>>>> -    dev->type = &cxl_memdev_type;
>>>>> +    if (cxlds->type == CXL_DEVTYPE_DEVMEM)
>>>>> +        dev->type = &cxl_accel_memdev_type;
>>>>> +    else
>>>>> +        dev->type = &cxl_memdev_type;
>>>>>       device_set_pm_not_required(dev);
>>>>>       INIT_WORK(&cxlmd->detach_work, detach_memdev);
>>>>>   diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>>> index dff618c708dc..622e3bb2e04b 100644
>>>>> --- a/drivers/cxl/core/region.c
>>>>> +++ b/drivers/cxl/core/region.c
>>>>> @@ -1948,7 +1948,8 @@ static int cxl_region_attach(struct
>>>>> cxl_region *cxlr, return -EINVAL;
>>>>>       }
>>>>>   -    cxl_region_perf_data_calculate(cxlr, cxled);
>>>>> +    if (cxlr->type == CXL_DECODER_HOSTONLYMEM)
>>>>> +        cxl_region_perf_data_calculate(cxlr, cxled);
>>>>>         if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>>>>>           int i;
>>>>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>>>>> index a9fd5cd5a0d2..cb771bf196cd 100644
>>>>> --- a/drivers/cxl/mem.c
>>>>> +++ b/drivers/cxl/mem.c
>>>>> @@ -130,12 +130,18 @@ static int cxl_mem_probe(struct device *dev)
>>>>>       dentry = cxl_debugfs_create_dir(dev_name(dev));
>>>>>       debugfs_create_devm_seqfile(dev, "dpamem", dentry,
>>>>> cxl_mem_dpa_show);
>>>>> -    if (test_bit(CXL_POISON_ENABLED_INJECT,
>>>>> mds->poison.enabled_cmds))
>>>>> -        debugfs_create_file("inject_poison", 0200, dentry,
>>>>> cxlmd,
>>>>> -                    &cxl_poison_inject_fops);
>>>>> -    if (test_bit(CXL_POISON_ENABLED_CLEAR,
>>>>> mds->poison.enabled_cmds))
>>>>> -        debugfs_create_file("clear_poison", 0200, dentry,
>>>>> cxlmd,
>>>>> -                    &cxl_poison_clear_fops);
>>>>> +    /*
>>>>> +     * Avoid poison debugfs files for Type2 devices as they
>>>>> rely on
>>>>> +     * cxl_memdev_state.
>>>>> +     */
>>>>> +    if (mds) {
>>>>> +        if (test_bit(CXL_POISON_ENABLED_INJECT,
>>>>> mds->poison.enabled_cmds))
>>>>> +            debugfs_create_file("inject_poison", 0200,
>>>>> dentry, cxlmd,
>>>>> +
>>>>> &cxl_poison_inject_fops);
>>>>> +        if (test_bit(CXL_POISON_ENABLED_CLEAR,
>>>>> mds->poison.enabled_cmds))
>>>>> +            debugfs_create_file("clear_poison", 0200,
>>>>> dentry, cxlmd,
>>>>> +
>>>>> &cxl_poison_clear_fops);
>>>>> +    }
>>>>>         rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>>>>>       if (rc)
>>>>> @@ -219,6 +225,13 @@ static umode_t cxl_mem_visible(struct kobject
>>>>> *kobj, struct attribute *a, int n) struct cxl_memdev *cxlmd =
>>>>> to_cxl_memdev(dev); struct cxl_memdev_state *mds =
>>>>> to_cxl_memdev_state(cxlmd->cxlds);
>>>>> +    /*
>>>>> +     * Avoid poison sysfs files for Type2 devices as they rely
>>>>> on
>>>>> +     * cxl_memdev_state.
>>>>> +     */
>>>>> +    if (!mds)
>>>>> +        return 0;
>>>>> +
>>>>>       if (a == &dev_attr_trigger_poison_list.attr)
>>>>>           if (!test_bit(CXL_POISON_ENABLED_LIST,
>>>>>                     mds->poison.enabled_cmds))
>>>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>>>>> index 6033ce84b3d3..5608ed0f5f15 100644
>>>>> --- a/include/cxl/cxl.h
>>>>> +++ b/include/cxl/cxl.h
>>>>> @@ -57,4 +57,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev
>>>>> *pdev, struct cxl_dev_state *cxlds); int
>>>>> cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource
>>>>> type); int cxl_release_resource(struct cxl_dev_state *cxlds, enum
>>>>> cxl_resource type); void cxl_set_media_ready(struct cxl_dev_state
>>>>> *cxlds); +struct cxl_memdev *devm_cxl_add_memdev(struct device
>>>>> *host,
>>>>> +                       struct cxl_dev_state
>>>>> *cxlds); #endif
>>>>


