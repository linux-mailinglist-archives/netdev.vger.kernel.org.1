Return-Path: <netdev+bounces-189051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B639AB0151
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 19:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703A1A01519
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 17:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C2228B51A;
	Thu,  8 May 2025 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRcr+f/7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D3028B4EE;
	Thu,  8 May 2025 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746724848; cv=none; b=bAU+Apqop1M+stsap0L7E4+TGmM51Y5TGWFGgmHOONuHswQ6fvInkYC/sRRvs4tFLABOdZY5cF+FolmMOMwijBllSMVdU2qiZPdXlRhO3V6NBYFHvhdQD3tbN1m2wt1DLeJPJYKVmul3MS1cA/IPKfbd/XaA8hFotBqfYgKbABY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746724848; c=relaxed/simple;
	bh=S7kZWuD0/Cl26OGh3sc5rUtoX3/eoIhdRtuRgmHwI/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMyfwuuSiP2NpNO9vB9x082dD/4nMwmTx1C0aMrU2zB8GalzAvKamfEcKdxyQhkb3nB/JdhK1kZJcgwLK86ULIetm+8LNjRFk5mVKB+G9omk0g26f/W2lw+nqv8FR4Rhb1wtyMVG8KydOfnytaZjxBgthDrOUP/JlSWIitEhjSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRcr+f/7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746724846; x=1778260846;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S7kZWuD0/Cl26OGh3sc5rUtoX3/eoIhdRtuRgmHwI/8=;
  b=cRcr+f/7RfqvCGjriyUbHl80M0uY/MVhSnpFPOkpVWlJ0CIWgW/Jcp+7
   IEtDIf12ortgZfPxlYjLB749rhDQxEpjl4DnY/memIl5OzM/rp+U16MUN
   7fIaTjLV1dHQYcK8E7d17xffGoEv4Io31+WXC20sucm6uegssmSL4aaNf
   CByeFY1u/HmT70X+f1ue6OngRFFPX1QsDo/0oQVUlu4aSnmP5q6xWljTw
   xMHnRg/s8oPXbVddErQBMkCfWy9eYcd2x3Q3ZgBUFYlPlAGMedT03691K
   Sn1FOcUX5EnVk/QmOwCHyp2FaDIY7fLy6n9pjrR5RWvA71l5YRE3Cx9P6
   A==;
X-CSE-ConnectionGUID: 2B6K4EepT4uKfQYp528D4A==
X-CSE-MsgGUID: irVPnTWEQFu5USgMJvBfbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="52176489"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="52176489"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 10:20:46 -0700
X-CSE-ConnectionGUID: 60sHhrFoTzSEyv3EMg0+nA==
X-CSE-MsgGUID: y0+hh25nS+u0BwZIYlvMRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="141481385"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.108.128]) ([10.125.108.128])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 10:20:45 -0700
Message-ID: <2f7ec84e-9df0-4753-97d2-91e6ee773091@intel.com>
Date: Thu, 8 May 2025 10:20:44 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 03/22] cxl: move pci generic code
To: Alejandro Lucero Palau <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 Ben Cheatham <benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-4-alejandro.lucero-palau@amd.com>
 <aBv8iyReoXruSaA7@aschofie-mobl2.lan>
 <92ff6f90-3b32-490e-9b62-0f516cb89ef4@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <92ff6f90-3b32-490e-9b62-0f516cb89ef4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/8/25 5:45 AM, Alejandro Lucero Palau wrote:
> 
> On 5/8/25 01:36, Alison Schofield wrote:
>> On Thu, Apr 17, 2025 at 10:29:06PM +0100, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
>>> meanwhile cxl/pci.c implements the functionality for a Type3 device
>>> initialization.
>>>
>>> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
>>> exported and shared with CXL Type2 device initialization.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>>   drivers/cxl/core/core.h       |  2 +
>>>   drivers/cxl/core/pci.c        | 62 +++++++++++++++++++++++++++++++
>>>   drivers/cxl/core/regs.c       |  1 -
>>>   drivers/cxl/cxl.h             |  2 -
>>>   drivers/cxl/cxlpci.h          |  2 +
>>>   drivers/cxl/pci.c             | 70 -----------------------------------
>>>   include/cxl/pci.h             | 13 +++++++
>>>   tools/testing/cxl/Kbuild      |  1 -
>>>   tools/testing/cxl/test/mock.c | 17 ---------
>> The commit log doesn't mention these cxl/test changes.
>> Why are these done?
> 
> 
> If I recall this right, moving the code has the effect of not requiring this code anymore.
> 
> 
> This comes from Dan's work for fixing the problem with that code moving.

I think what Alison is hinting at is to add a blurb in the commit log for the purpose of the cxl_test changes so a patch reader later on will have context of those changes.

DJ

> 
> 
>>
>>> index af2594e4f35d..3c6a071fbbe3 100644
>>> --- a/tools/testing/cxl/test/mock.c
>>> +++ b/tools/testing/cxl/test/mock.c
>>> @@ -268,23 +268,6 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
>>>   }
>>>   EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
>>>   -resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
>>> -                          struct cxl_dport *dport)
>>> -{
>>> -    int index;
>>> -    resource_size_t component_reg_phys;
>>> -    struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>>> -
>>> -    if (ops && ops->is_mock_port(dev))
>>> -        component_reg_phys = CXL_RESOURCE_NONE;
>>> -    else
>>> -        component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
>>> -    put_cxl_mock_ops(index);
>>> -
>>> -    return component_reg_phys;
>>> -}
>>> -EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, "CXL");
>>> -
>>>   void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
>>>   {
>>>       int index;
>>> -- 
>>> 2.34.1
>>>
>>>


