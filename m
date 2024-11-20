Return-Path: <netdev+bounces-146537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFEC9D40E8
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 18:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073BA1F222AE
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 17:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC8B156F21;
	Wed, 20 Nov 2024 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nh2d7bSf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2071024B28;
	Wed, 20 Nov 2024 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732122820; cv=none; b=BoCdedQvxlnwHsK4hOV7UhKVieVn3NMBUdBQ15uwZFCdoHGLcI9XGUA8nM/P9Xo+yruZxp8b+XWYTAHU/+JUWBj05cq//zvB5+vNaeTqOfPI5Iz9rO0jW9jsQREM2k50eSoML9c1FhQaVU4nwut0zumeP9j5pETEFHMyfwsvSFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732122820; c=relaxed/simple;
	bh=/1hZo+1vKMNvcfwFv9WQw8lUg2hIjCFIbJikQXtqLTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VC71HMoVduQFDb9XPvI7Z5rwyl84tJt923eBZvIwVdLHrvXZKpRwg4kgP84u/waP7gLvl1fRtwEZp2FeMUZpCiAM/iGIw8s+KsM9LmLiPI1fzcElBAmX3fsK21ltmVi9d5t/JQgMzczaA8U5QND8WtgECM/1B+1rmACkBeGqHI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nh2d7bSf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732122818; x=1763658818;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=/1hZo+1vKMNvcfwFv9WQw8lUg2hIjCFIbJikQXtqLTc=;
  b=Nh2d7bSfKZzXntSrBOoiurh+h9PVaOyqF7hvhpJUbl0ZpthrPidtMQ2I
   6kwxNcS1ViQyzTxKLfAibu+kasP+YzkbJ7nIWhrQWnbt7XrWZVnft5NnE
   Erv2MpyQhKtNSn2l6VyGviF6KV26jllFhdcLGYl7AgF6uOJWOQiMjxT3P
   AKFZVsXwBdsa/mMmdgtFPyCJijMaO8kCN20heS05jwJs6/dZaTuY6JbqQ
   eg7sXlO/90FL1oHuMd84DgI5X9mh8xyTZvv/rDNNXbJY2WxVLgMhs9as1
   BhY3HaMJcoo3mPo6h7MF434FG7bvlUP2BZJz2b+22NdBT2C+wnONqj/Nq
   g==;
X-CSE-ConnectionGUID: ZXy7kK1kTg2uYG8aKWTCjA==
X-CSE-MsgGUID: XqbFbB4PTJSw/DjCnENlNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="36109802"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="36109802"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 09:13:11 -0800
X-CSE-ConnectionGUID: nixXk+oPStyJnMT/xeWwMQ==
X-CSE-MsgGUID: eWiXwDYRR9KnLo8uEJpnOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="94794513"
Received: from bmurrell-mobl.amr.corp.intel.com (HELO [10.125.109.160]) ([10.125.109.160])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 09:13:09 -0800
Message-ID: <5624f840-0496-40bd-b6ec-8fb253565a84@intel.com>
Date: Wed, 20 Nov 2024 10:13:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should the CXL Type2 support patchset be split up?
To: Alejandro Lucero Palau <alucerop@amd.com>, Paolo Abeni
 <pabeni@redhat.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <fb2d7565-b895-4109-b027-92275e086268@redhat.com>
 <86522c97-350c-9319-6930-01f97a490578@amd.com>
 <f14777c1-9a38-86e5-df39-c52b7df2f300@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <f14777c1-9a38-86e5-df39-c52b7df2f300@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/20/24 9:50 AM, Alejandro Lucero Palau wrote:
> Hi all,
> 
> 
> Facing Paolo's question again trying to involve CXL and (more) netdev maintainers.
> 
> 
> Next v6 could have two different patchsets, one for cxl, one for netdev. The current patchset has already cleanly isolated sfc netdev patches, so it is trivial.
> 
> The main question is if CXL maintainers will be happy with this change as the sfc is the client justifying the CXL core changes. Also, the split could be delayed until all the patches get the Reviewed-by tag what is now only ~75% of them (sfc related patches without the public approval yet but internally obtained).

Given that the series is dominantly CXL patches, my suggestion would be get the acks from netdev side and CXL can take the whole series without doing any splitting. That's been typically how it has been done with cross subsystem changes. i.e. ACPI+CXL etc. 

DJ 

> 
> Thanks,
> 
> Alejandro
> 
> 
> On 10/23/24 10:38, Alejandro Lucero Palau wrote:
>>
>> On 10/23/24 09:46, Paolo Abeni wrote:
>>> I'm sorry for the late feedback, but which is the merge plan here?
>>>
>>> The series spawns across 2 different subsystems and could cause conflicts.
>>>
>>> Could the network device change be separated and send (to netdev) after
>>> the clx ones land into Linus' tree?
>>
>>
>> Hi Paolo,
>>
>>
>> With v4 all sfc changes are different patches than those modifying CXL core, so I guess this is good for what you suggest.
>>
>>
>> Not sure the implications for merging only some patches into the CXL tree.
>>
>>
>> Thanks,
>>
>> Alejandro
>>
>>
>>> Thanks,
>>>
>>> Paolo
>>>


