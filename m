Return-Path: <netdev+bounces-190216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AE6AB5951
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 18:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00153A8FA8
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 16:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62232BE114;
	Tue, 13 May 2025 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUl4waiv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437F514A8B;
	Tue, 13 May 2025 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152357; cv=none; b=FZswjCap0uUPMcc0lAehdal0UOsele9nqQEfZDOhmIN7h9XYKF9PFNijZVYoYfJBeyMj7QgOArb2+vA6Qd3WHNLlUIrffmuAb9o4O9BZDp8fDgLm93aGUjHRwBdLMPKEnR/J1D/mV91TmEC9g9YYCvN7ur1l1eKzryCNZQkhDmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152357; c=relaxed/simple;
	bh=eVdnQMEBkBMCI++PQT7YT54GYeboHrathj3/kTWlNss=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=axdDes2uR2UzXp7d2VIBNTrrAQtlybyk74Nbk32cwUyXFIl6EZk5Z/TchaP1fA2w8BfbbfJVViDaiYy9a3dRTNfGZkuztkDQpOYNAz2GutxMcjls2b8GTAIcUnkWMkfWYIPZXEe0F5ZHFZB6poAf1tfBgG7Qx56fA8gnbIeKxBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUl4waiv; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747152355; x=1778688355;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=eVdnQMEBkBMCI++PQT7YT54GYeboHrathj3/kTWlNss=;
  b=WUl4waivO0HhQ0xWyYq+llwoZZwrRpffM3Fwu7VS2lljvGUhPGdYEu0D
   Z+aARplOGF4LM57u+XDVSxhecWjXTiLFq29GYyUFtPbt1HlonmpQo0mnk
   RIJtaLlI89X+/XYbfDNEG84Gmq9F/eEXFZ3Ymy9qvPX0zAkwkdmnwKAOR
   Idi57FyJrnedMMGAr5F5CFNixaKNj4X9lZ1KDt6ktBWBJJEaF0zvDQ3dC
   gg+S6taSo+iSsYX4lNbXFgY847lfTOivBtfLn/+s2roXxyLt0tjDxVeMg
   WZiU5CuIQTdWogDl45N9uaPl6uWMzs8K9doSt6QRYHSmEbZXQyANde3KK
   Q==;
X-CSE-ConnectionGUID: LeNKNN4vSDe2GuhCL5RCYg==
X-CSE-MsgGUID: NmyqPJRERYuIEtkhHJxyFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="60408185"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="60408185"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 09:05:54 -0700
X-CSE-ConnectionGUID: dD2+x82pThip2HRr4KPB9A==
X-CSE-MsgGUID: hITv0yC4Qaam/Gpwm+543w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="137790948"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.109.12]) ([10.125.109.12])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 09:04:31 -0700
Message-ID: <7447008e-3579-47d4-9f90-28d18429d532@intel.com>
Date: Tue, 13 May 2025 09:04:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/22] Type2 device basic support
To: Alejandro Lucero Palau <alucerop@amd.com>,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
 <59fa7e55-f563-40f9-86aa-1873806e76cc@intel.com>
 <8342ea50-ea07-4ae8-8607-be48936bcd11@amd.com>
 <ef2782e6-74d1-48e8-8159-069317bf6737@intel.com>
 <fd9888f1-ee5d-4943-89fa-32d6e0fb61a5@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <fd9888f1-ee5d-4943-89fa-32d6e0fb61a5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/13/25 8:24 AM, Alejandro Lucero Palau wrote:
> 
> On 5/13/25 16:13, Dave Jiang wrote:
>>
>> On 5/13/25 1:12 AM, Alejandro Lucero Palau wrote:
>>> On 5/12/25 23:36, Dave Jiang wrote:
>>>> On 5/12/25 9:10 AM, alejandro.lucero-palau@amd.com wrote:
>>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>>
>>>>> v15 changes:
>>>>>    - remove reference to unused header file (Jonathan Cameron)
>>>>>    - add proper kernel docs to exported functions (Alison Schofield)
>>>>>    - using an array to map the enums to strings (Alison Schofield)
>>>>>    - clarify comment when using bitmap_subset (Jonathan Cameron)
>>>>>    - specify link to type2 support in all patches (Alison Schofield)
>>>>>
>>>>>     Patches changed (minor): 4, 11
>>>>>
>>>> Hi Alejandro,
>>>> Tried to pull this series using b4. Noticed couple things.
>>>> 1. Can you run checkpatch on the entire series and fix any issues?
>>>> 2. Can you rebase against v6.15-rc4? I think there are some conflicts against the fixes went in rc4.
>>>>
>>>> Thanks!
>>>>    
>>>
>>> Hi Dave, I'm afraid I do not know what you mean with b4. Tempted to say it was a typo, but in any case, better if you can clarify.
>> I use the tool b4 to pull patches off the mailing list. As you can see, your series fail on rc4 apply for patch 18.
> 
> 
> But your head is not what the base for the patchset states. I did work on v15 for working with the last patches in cxl-next so the HEAD should be:
> 
> 
> commit a223ce195741ca4f1a0e1a44f3e75ce5662b6c06 (origin/next)
> Author: Dan Carpenter <dan.carpenter@linaro.org>
> Date:   Thu Feb 22 09:14:02 2024 +0300
> 
>     cxl/hdm: Clean up a debug printk
> 

Ah yeah it's better to rebase against Linus's RC series rather than what cxl/next is for me to pull things. Otherwise it gets messy if something has to change in the cxl/next series and your code is based on that. So if you don't mind please rebase against upstream rc4 and I'll attempt to resolve the conflicts your code has against Robert's cleanups. Thank you. Sorry about the confusion. That is the lesson I learned last merge window with all the fun with the 'Features' code.   

DJ


> 
>>
>> ✔ ~/git/cxl-for-next [for-6.16/cxl-type2 L|…138]
>> 08:08 $ git reset --hard v6.15-rc4
>> HEAD is now at b4432656b36e Linux 6.15-rc4
>> ✔ ~/git/cxl-for-next [for-6.16/cxl-type2 L|…138]
>> 08:08 $ b4 shazam -sltSk https://lore.kernel.org/linux-cxl/20250512161055.4100442-1-alejandro.lucero-palau@amd.com/T/#m25a578eb83108678737bf14fdba0d2e5da7f76bd
>> Grabbing thread from lore.kernel.org/all/20250512161055.4100442-1-alejandro.lucero-palau@amd.com/t.mbox.gz
>> Checking for newer revisions
>> Grabbing search results from lore.kernel.org
>> Analyzing 25 messages in the thread
>> Looking for additional code-review trailers on lore.kernel.org
>> Analyzing 955 code-review messages
>> Checking attestation on all messages, may take a moment...
>> ---
>>    [PATCH v15 1/22] cxl: Add type2 device basic support
>>      + Link: https://patch.msgid.link/20250512161055.4100442-2-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: 563: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>>      ● checkpatch.pl: 773: ERROR: trailing whitespace
>>    [PATCH v15 2/22] sfc: add cxl support
>>      + Link: https://patch.msgid.link/20250512161055.4100442-3-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: 213: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>>    [PATCH v15 3/22] cxl: Move pci generic code
>>      + Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>>      + Link: https://patch.msgid.link/20250512161055.4100442-4-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: passed all checks
>>    [PATCH v15 4/22] cxl: Move register/capability check to driver
>>      + Link: https://patch.msgid.link/20250512161055.4100442-5-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: passed all checks
>>    [PATCH v15 5/22] cxl: Add function for type2 cxl regs setup
>>      + Link: https://patch.msgid.link/20250512161055.4100442-6-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: passed all checks
>>    [PATCH v15 6/22] sfc: make regs setup with checking and set media ready
>>      + Link: https://patch.msgid.link/20250512161055.4100442-7-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: passed all checks
>>    [PATCH v15 7/22] cxl: Support dpa initialization without a mailbox
>>      + Link: https://patch.msgid.link/20250512161055.4100442-8-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: passed all checks
>>    [PATCH v15 8/22] sfc: initialize dpa
>>      + Link: https://patch.msgid.link/20250512161055.4100442-9-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: passed all checks
>>    [PATCH v15 9/22] cxl: Prepare memdev creation for type2
>>      + Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>>      + Link: https://patch.msgid.link/20250512161055.4100442-10-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: passed all checks
>>    [PATCH v15 10/22] sfc: create type2 cxl memdev
>>      + Link: https://patch.msgid.link/20250512161055.4100442-11-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: passed all checks
>>    [PATCH v15 11/22] cxl: Define a driver interface for HPA free space enumeration
>>      + Link: https://patch.msgid.link/20250512161055.4100442-12-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: 133: WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
>>    [PATCH v15 12/22] sfc: obtain root decoder with enough HPA free space
>>      + Link: https://patch.msgid.link/20250512161055.4100442-13-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: passed all checks
>>    [PATCH v15 13/22] cxl: Define a driver interface for DPA allocation
>>      + Link: https://patch.msgid.link/20250512161055.4100442-14-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: 127: WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
>>    [PATCH v15 14/22] sfc: get endpoint decoder
>>      + Link: https://patch.msgid.link/20250512161055.4100442-15-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: passed all checks
>>    [PATCH v15 15/22] cxl: Make region type based on endpoint type
>>      + Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>>      + Link: https://patch.msgid.link/20250512161055.4100442-16-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: passed all checks
>>    [PATCH v15 16/22] cxl/region: Factor out interleave ways setup
>>      + Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>>      + Link: https://patch.msgid.link/20250512161055.4100442-17-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: passed all checks
>>    [PATCH v15 17/22] cxl/region: Factor out interleave granularity setup
>>      + Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>>      + Link: https://patch.msgid.link/20250512161055.4100442-18-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: passed all checks
>>    [PATCH v15 18/22] cxl: Allow region creation by type2 drivers
>>      + Link: https://patch.msgid.link/20250512161055.4100442-19-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: 126: WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
>>    [PATCH v15 19/22] cxl: Add region flag for precluding a device memory to be used for dax
>>      + Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>>      + Link: https://patch.msgid.link/20250512161055.4100442-20-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: passed all checks
>>    [PATCH v15 20/22] sfc: create cxl region
>>      + Link: https://patch.msgid.link/20250512161055.4100442-21-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: passed all checks
>>    [PATCH v15 21/22] cxl: Add function for obtaining region range
>>      + Link: https://patch.msgid.link/20250512161055.4100442-22-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: passed all checks
>>    [PATCH v15 22/22] sfc: support pio mapping based on cxl
>>      + Link: https://patch.msgid.link/20250512161055.4100442-23-alejandro.lucero-palau@amd.com
>>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>      ● checkpatch.pl: 219: CHECK: Unbalanced braces around else statement
>>    ---
>>    NOTE: install dkimpy for DKIM signature verification
>> ---
>> Total patches: 22
>> ---
>>   Base: using specified base-commit a223ce195741ca4f1a0e1a44f3e75ce5662b6c06
>> Applying: cxl: Add type2 device basic support
>> Applying: sfc: add cxl support
>> Applying: cxl: Move pci generic code
>> Applying: cxl: Move register/capability check to driver
>> Applying: cxl: Add function for type2 cxl regs setup
>> Applying: sfc: make regs setup with checking and set media ready
>> Applying: cxl: Support dpa initialization without a mailbox
>> Applying: sfc: initialize dpa
>> Applying: cxl: Prepare memdev creation for type2
>> Applying: sfc: create type2 cxl memdev
>> Applying: cxl: Define a driver interface for HPA free space enumeration
>> Applying: sfc: obtain root decoder with enough HPA free space
>> Applying: cxl: Define a driver interface for DPA allocation
>> Applying: sfc: get endpoint decoder
>> Applying: cxl: Make region type based on endpoint type
>> Applying: cxl/region: Factor out interleave ways setup
>> Applying: cxl/region: Factor out interleave granularity setup
>> Applying: cxl: Allow region creation by type2 drivers
>> Patch failed at 0018 cxl: Allow region creation by type2 drivers
>> /home/djiang5/git/linux-kernel/.git/worktrees/cxl-for-next/rebase-apply/patch:644: trailing whitespace.
>>   * @type: CXL device type
>> warning: 1 line adds whitespace errors.
>> error: patch failed: drivers/cxl/core/region.c:3607
>> error: drivers/cxl/core/region.c: patch does not apply
>> error: patch failed: drivers/cxl/port.c:33
>> error: drivers/cxl/port.c: patch does not apply
>> hint: Use 'git am --show-current-patch=diff' to see the failed patch
>> hint: When you have resolved this problem, run "git am --continue".
>> hint: If you prefer to skip this patch, run "git am --skip" instead.
>> hint: To restore the original branch and stop patching, run "git am --abort".
>> hint: Disable this message with "git config set advice.mergeConflict false"
>>
>>
>>>
>>> The patchset is against the last cxl-next commit as it it stated at the end, and that is based on v6.15.0-rc4. I had to solve some issues from v14 as last changes in core/region.c from Robert Richter required so.
>>>
>>>
>>> About checkpatch, I did so but I have just done it again for being sure before this email, and I do not seen any issue except a trailing space in patch 1. That same patch has also warnings I do not think are a problem. Some are related to moved code and other on the new macro. FWIW, I'm running those with "checkpatch --strict".
>>>
>>>
>>>>>
>>>>> base-commit: a223ce195741ca4f1a0e1a44f3e75ce5662b6c06


