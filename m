Return-Path: <netdev+bounces-229700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEAABDFF29
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 380C234F483
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 17:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78332FFF94;
	Wed, 15 Oct 2025 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lmPrJiAl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CF12FF14D;
	Wed, 15 Oct 2025 17:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760550740; cv=none; b=KblNQ3rO6/b/2MLKXuQ+JNbx7ag7q4M2YvMAJgqCMIhk4doGgdVmVesR55S4uMUApL2DH/7bvkzA5IKBfgeOzyxH7Qpa2umaxLmw0DQmETFtt0rhtmUjhaYFJlhEO4g98azPZVMyz4UzcSVBBV8aDl9tiF9ufjgrImcI3eO7i0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760550740; c=relaxed/simple;
	bh=d9agSZ0ZSq6WZr0i5wHcSmu6LVuxNO6aHPh2pbCSlXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhitXKjp5sxn8OwnZHCLYAtCzJmYxKwPrmThOhlyBa9sDXD6Tr54eBhUymq8iWktpBBuazeF4vGAtIX+BK57LwhI2ZMLIpdfOwLhReSzINbpCGSDFJuRnZwIuast9X38kejmut9j9xoo8mIb8ZGw5FuHHKdUqi+4mPrTQqHtuks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lmPrJiAl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760550738; x=1792086738;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d9agSZ0ZSq6WZr0i5wHcSmu6LVuxNO6aHPh2pbCSlXg=;
  b=lmPrJiAlPQjTP8Fh0/TUwRdzKlac60M0+yWZDGNU1s/j5lUYe59qWuBE
   4WoVqmHi3ubToW7WLisJ1CjQGcWmE9Vu7l/QxJ4lBQYd5jhEroowmQ2YM
   2tva0sBCZ/xRPdMgBRQ3/ckNDTo1OBPmnptEx3wmm1Uptgwd/iOGHMMUi
   ihv+YSY1T0ZH0ECbSQlixoEcuOZ+rdh1j87qvzHMUUqYVccX9Z6Kx56ts
   9WW87As0qwhGrstc2nPLDdRI6EowiVSo/3I374RMd8G9AVUCMSzHedf2n
   QUXYIwrDdKr2ferUK7NBkdoNtrKS19j66aYbK+Z1M3WpSX94AimYyZlBO
   w==;
X-CSE-ConnectionGUID: 7zqcN2N7RL2dP3b42zwVXg==
X-CSE-MsgGUID: dIninP6YQRKpxNFip2FNTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="73846070"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="73846070"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 10:52:17 -0700
X-CSE-ConnectionGUID: EfS9n4iBRkWkXRD4OfNexg==
X-CSE-MsgGUID: 4vaOPRHyTOa4hfcx8ytzFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="205938745"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.221]) ([10.125.111.221])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 10:52:16 -0700
Message-ID: <9b62e7cc-0b58-4354-b4ed-3538a536bd42@intel.com>
Date: Wed, 15 Oct 2025 10:52:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 11/22] cxl: Define a driver interface for HPA free
 space enumeration
To: Alejandro Lucero Palau <alucerop@amd.com>,
 "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-12-alejandro.lucero-palau@amd.com>
 <7a3d3249-ee08-4fe0-a016-829ece6f7b8e@amd.com>
 <6fb97a7e-d39b-42e0-9443-8ea9271f277e@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <6fb97a7e-d39b-42e0-9443-8ea9271f277e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/10/25 4:16 AM, Alejandro Lucero Palau wrote:
> 
> On 10/9/25 21:55, Cheatham, Benjamin wrote:
>> On 10/6/2025 5:01 AM, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> CXL region creation involves allocating capacity from Device Physical Address
>>> (DPA) and assigning it to decode a given Host Physical Address (HPA). Before
>>> determining how much DPA to allocate the amount of available HPA must be
>>> determined. Also, not all HPA is created equal, some HPA targets RAM, some
>>> targets PMEM, some is prepared for device-memory flows like HDM-D and HDM-DB,
>>> and some is HDM-H (host-only).
>>>
>>> In order to support Type2 CXL devices, wrap all of those concerns into
>>> an API that retrieves a root decoder (platform CXL window) that fits the
>>> specified constraints and the capacity available for a new region.
>>>
>>> Add a complementary function for releasing the reference to such root
>>> decoder.
>>>
>>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>> Hey Alejandro,
> 
> 
> Hi Ben,
> 
> 
>> I've been testing this on my setup and noticed a few issues when BIOS sets up the HDM decoders. It came down to 2 issues:
>>     1) Enabling "Specific Purpose Memory" added a Soft Reserve resource below the CXL window resource and broke
>>     this patch (more below)
> 
> 
> Maybe we should talk (first) about this internally as it is about AMD BIOS (I guess). I have been talking with the BIOS team about this EFI_MEMORY_SP vs EFI_RESERVED_MEMORY, and I'm afraid the discussion is not over yet :-).
> 
> 
>>     2) The endpoint decoder was already set up which broke DPA allocation and then CXL region creation (see my response
>>     to patch 18/22 for fix and explanation)
> 
> 
> Yes, if the BIOS configures the device HDM decoder, the current patchset does not do the right thing. As I said in the cover letter, my expectation at the time, and hopefully in the future as well, although I'm not sure about it, was the BIOS not doing so. Most of the implementation is based on QEMU, so I found this problem when dealing with a real system with a Type2 aware BIOS ... . I was tempted to include support for this case, but I did not do so for several reasons:
> 
> 
> 1) I want to think the patchset is close to being accepted and changes at this state could delay it further. After more than a year, and because this patchset is about "initial Type2 support", I think it is better to do so in a follow-up work, and when there is a client requiring it.
> 
> 2) Because that conversation with BIOS guys, I prefer to be sure what to do, as there are other things we need to clarify and in my opinion, far more important than current Type2 support.
> 
> 3) CXL is a fast moving part of the kernel and I bet we will find another case which the current patchset is not dealing with properly. In fact there is another report of devices with the BAR with CXL information being also used by the driver for other purposes and existing a problem when mapping the CXL registers after the driver did map the whole BAR.
> 
> 
> So, I think the current patchset where most of the API for Type2 drivers is implemented should go as soon as possible, which will facilitate those follow-up works for the case you describe and the other one about BAR mappings. If not, even if retirement is still far away for me, I'll be concerned about the impending future of this work ... but of course, this is my suggestion, so let's see other opinions about it.
>

My 2 cents is that if the current code set works as intended for the hardware/user you have then lets get that enabled and we can deal with the other cases as next iterations.

Are there any use cases where the BIOS need to pre-commit the type2 decoders instead of allowing the driver/OS to do so?

DJ 
> 
> Thank you.
> 
> 
>>
>> The fix I did for 1 is a bit hacky but it's essentially checking none of the resources below the CXL window are onlined as
>> system memory. It's roughly equivalent to what's being done in the CXL_PARTMODE_RAM case of cxl_region_probe(), but
>> I'm restricting the resources to "Soft Reserved" to be safe.
>>
>> The diff for 2 is pretty big. If you don't want to take it at this point I can send it as a follow up. In that case I'd definitely
>> add that auto regions won't work in at least the cover letter (and in the description of 18/22 as well?).
>>
>> ---
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index acaca64764bf..2d60131edff3 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -784,6 +784,19 @@ static int find_max_hpa(struct device *dev, void *data)
>>          lockdep_assert_held_read(&cxl_rwsem.region);
>>          res = cxlrd->res->child;
>>
>> +       /*
>> +        * BIOS may have marked the CXL window as soft reserved. Make sure it's
>> +        * free to use.
>> +        */
>> +       while (res && resource_size(res) == resource_size(cxlrd->res)) {
>> +               if ((res->flags & IORESOURCE_BUSY) ||
>> +                   (res->flags & IORESOURCE_SYSRAM) ||
>> +                   strcmp(res->name, "Soft Reserved") != 0)
>> +                       return 0;
>> +
>> +               res = res->child;
>> +       }
>> +
>>          /* With no resource child the whole parent resource is available */
>>          if (!res)
>>                  max = resource_size(cxlrd->res);


