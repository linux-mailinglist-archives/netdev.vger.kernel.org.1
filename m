Return-Path: <netdev+bounces-201987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB26AAEBDB6
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 18:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C0F37A5225
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 16:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E784629E115;
	Fri, 27 Jun 2025 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LwpLaiAq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F98213245;
	Fri, 27 Jun 2025 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751042620; cv=none; b=cQgl5DAYofxJTZW3khZL6vHgu9BccJRLi8hmO66mmJgGMAv7ilXDcMbgsksSroCSKI2Sv6yabJyRtEvYwpuQU1wrqf7gKBsJB4NV9Q1e1x9JW429CX5D/pfqmWdMheI0r6mX5AOmT9bSkfJ1V0kMoRJyUQi2sh7qwAqeF+DI1oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751042620; c=relaxed/simple;
	bh=w0Qvb5gaHtm51GC76JQELFJhsNqUPR2AjuWI1DWdcXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8TKhaZKA5zVORzmtQF64RGUHgnmaOgX7Kq/q3gJKSB0C2z7ycp4K9b7dGbn1SsMRQuVL0ghNSqaZ3RnGcBnqe/Ro7tbB4E4lzZRkMG93zvLtwW5P3lRbo3WeudkqsB4iVNjIBkgzZnwULx40YNvtv99abUjQOAbx7oP4gFlVPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LwpLaiAq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751042620; x=1782578620;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w0Qvb5gaHtm51GC76JQELFJhsNqUPR2AjuWI1DWdcXw=;
  b=LwpLaiAq/AnFgPvYikDjz+oFjPdCN9ahaSYTZHRO9CAZTBSPwg/MlmHl
   uibkdb2eANeyZwLavNYuoIsZqUNRLAeGb1DCiXlVQ/KRWhuiYfSUQDSyK
   Ki1xHJgThbb+1d0vsoKTVXoVtq8YbKAIuanxtWQ+3F+w42zir46HaruMw
   GYr7PdzRd/aIPNtcbTuSm6HLB/jf0mC1PR/vhBOVNCGj1Sy79yUaOSLnC
   7M3o0k4eQ3iDvWLpP5KStTZsxSujkrzzKiQvdkIG9u9MPAMVDlpBDAhtb
   WteILNkxU38iG3MHILModvZtXL2RUUvGve+stgeqV4GSpB65Zqp8MTJGN
   w==;
X-CSE-ConnectionGUID: mzesbOdnRE2iY0xVZCmsKQ==
X-CSE-MsgGUID: GOmoWzH+QES59g3LDwkPHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="63617817"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="63617817"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 09:43:38 -0700
X-CSE-ConnectionGUID: Om7lJGA1RVGaqHnTCss+Hg==
X-CSE-MsgGUID: v8GaP8DNT++Zq3c0zael/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="152583283"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.77]) ([10.125.109.77])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 09:43:37 -0700
Message-ID: <42a0fe0b-a936-4688-a061-76b37e841ce6@intel.com>
Date: Fri, 27 Jun 2025 09:43:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 06/22] cxl: Support dpa initialization without a
 mailbox
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 Alejandro Lucero <alucerop@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-7-alejandro.lucero-palau@amd.com>
 <20250627094214.000036e6@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250627094214.000036e6@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/27/25 1:42 AM, Jonathan Cameron wrote:
> On Tue, 24 Jun 2025 15:13:39 +0100
> alejandro.lucero-palau@amd.com wrote:
> 
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
>> memdev state params which end up being used for DPA initialization.
>>
>> Allow a Type2 driver to initialize DPA simply by giving the size of its
>> volatile hardware partition.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> º
> 
> ?  Looks like an accidental degree symbol.
> 
>> ---
>>  drivers/cxl/core/mbox.c | 17 +++++++++++++++++
> Location make sense?   I'd like some reasoning text for that in the patch
> description.  After all whole point is this isn't a mailbox thing!
> 
> Maybe moving add_part and this to somewhere more general makes sense?

core/memdev.c? Seems like a memdev type of thing.

DJ

> 
>>  include/cxl/cxl.h       |  1 +
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index d78f6039f997..d3b4ba5214d5 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1284,6 +1284,23 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
>>  	info->nr_partitions++;
>>  }
>>  
>> +/**
>> + * cxl_set_capacity: initialize dpa by a driver without a mailbox.
>> + *
>> + * @cxlds: pointer to cxl_dev_state
>> + * @capacity: device volatile memory size
>> + */
>> +void cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
>> +{
>> +	struct cxl_dpa_info range_info = {
>> +		.size = capacity,
>> +	};
>> +
>> +	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM);
>> +	cxl_dpa_setup(cxlds, &range_info);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_set_capacity, "CXL");
>> +
>>  int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>>  {
>>  	struct cxl_dev_state *cxlds = &mds->cxlds;
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 0810c18d7aef..4975ead488b4 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -231,4 +231,5 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>>  int cxl_map_component_regs(const struct cxl_register_map *map,
>>  			   struct cxl_component_regs *regs,
>>  			   unsigned long map_mask);
>> +void cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>>  #endif /* __CXL_CXL_H__ */
> 
> 


