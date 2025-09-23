Return-Path: <netdev+bounces-225702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5881FB97315
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 20:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12ED93AA3B6
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E297E2FF142;
	Tue, 23 Sep 2025 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djd8ehe3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC49272E6D;
	Tue, 23 Sep 2025 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758652110; cv=none; b=OheC747+l9BrSnctvCl3PLs6XWGFZCFkdK1ujggmEycnZPPxOdGTzjaI0+qErgKQ9w1708sEYmD8pdBG9Defk7qjrCUh1JPVLp3EtgMYAftkGcGLIAyEsoXIdyJu2QUWb+4boUkSa5zVtL6u1QJfJtq0V9hxKKqu4L6MMpaCuQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758652110; c=relaxed/simple;
	bh=XzK8Ur5LPNCRLf4lx/sAri5lGTsfFnYyGyivCU1zyio=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HAc0Ib3BxXQbN05VsJ4ePQo7kxNCwW/TJogTSW43gZJzwepgj+jsFbYXveSesRQttF6AUiE/vK67b0JmtGM+QSo1kPc5DpSyTKFB+ybuplp9zNPZ9H91uXuxQET1LVZyifTU1FDNBau/oD8Fav8sdAKLfY+53vXntcpsVOK7qBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djd8ehe3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758652109; x=1790188109;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=XzK8Ur5LPNCRLf4lx/sAri5lGTsfFnYyGyivCU1zyio=;
  b=djd8ehe3+hIelt+hjNDOfw8gyXKq+3UrJ9Sxg47oZEYpoqp6ntXfgBr1
   AFflGbwdDbZ/d1dpmnPUFB7akXICUjJfQuP4+jVgN1/maqcuifiK31e2S
   c63A+QnlYnn94bHZmVcpWLCQLoSaG+ctQPlUH7IRFwBHElVvmfQaWG24F
   3IbsW9PYVJK0LPik4jskMkCNlQSz1lEyx9PVcEH5x3n6tAVR2M/0jdsrM
   U8u8ylCJ2XfoG8sHaUqOVuRUq1EpuZ2wQ9wFeFlFw2sjIxsPkwl9ULWHn
   D7+htlY+gBYBCnZhV0fuG628ZIWPl7fSNdG2btxRHTDlrowlOuA+wUc5w
   g==;
X-CSE-ConnectionGUID: HQC8ioNyReKrzQgWztB5pw==
X-CSE-MsgGUID: Tln6DZwYRbWDwSWzEEwHlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60858976"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60858976"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 11:28:28 -0700
X-CSE-ConnectionGUID: XetSAgxyQXue0ceWAnfDfA==
X-CSE-MsgGUID: Wl4R6agrRO+WE3k7u1T3xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="213976224"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.108.174]) ([10.125.108.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 11:28:28 -0700
Message-ID: <710dcb52-7f4d-46fe-a8ef-7e91d52af82d@intel.com>
Date: Tue, 23 Sep 2025 11:28:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 00/20] Type2 device basic support
To: Alejandro Lucero Palau <alucerop@amd.com>,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <33f5b788-c478-4279-bf9b-a5fc1000bc23@intel.com>
 <c012498b-d9f9-439a-a926-ef5f10689bf7@amd.com>
 <aea329a3-9cb9-4552-88e7-2b354483ad53@intel.com>
 <0b36e5c2-2f15-4e83-bf4b-c4c15f55d3d2@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0b36e5c2-2f15-4e83-bf4b-c4c15f55d3d2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/23/25 3:35 AM, Alejandro Lucero Palau wrote:
> 
> On 9/19/25 22:42, Dave Jiang wrote:
>>
>> On 9/19/25 9:55 AM, Alejandro Lucero Palau wrote:
>>> Hi Dave,
>>>
>>>
>>>
>>> On 9/19/25 17:26, Dave Jiang wrote:
>>>> On 9/18/25 2:17 AM, alejandro.lucero-palau@amd.com wrote:
>>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>>
>>>>> First of all, the patchset should be applied on the described base
>>>>> commit then applying Terry's v11 about CXL error handling plus last four
>>>>> pathces from Dan's for-6.18/cxl-probe-order branch.
>>>>>
>>> <snip>
>>>
>>>>> base-commit: f11a5f89910a7ae970fbce4fdc02d86a8ba8570f
>>>>> prerequisite-patch-id: 44c914dd079e40d716f3f2d91653247eca731594
>>>>> prerequisite-patch-id: b13ca5c11c44a736563477d67b1dceadfe3ea19e
>>>>> prerequisite-patch-id: d0d82965bbea8a2b5ea2f763f19de4dfaa8479c3
>>>>> prerequisite-patch-id: dd0f24b3bdb938f2f123bc26b31cd5fe659e05eb
>>>>> prerequisite-patch-id: 2ea41ec399f2360a84e86e97a8f940a62561931a
>>>>> prerequisite-patch-id: 367b61b5a313db6324f9cf917d46df580f3bbd3b
>>>>> prerequisite-patch-id: 1805332a9f191bc3547927d96de5926356dac03c
>>>>> prerequisite-patch-id: 40657fd517f8e835a091c07e93d6abc08f85d395
>>>>> prerequisite-patch-id: 901eb0d91816499446964b2a9089db59656da08d
>>>>> prerequisite-patch-id: 79856c0199d6872fd2f76a5829dba7fa46f225d6
>>>>> prerequisite-patch-id: 6f3503e59a3d745e5ecff4aaed668e2d32da7e4b
>>>>> prerequisite-patch-id: e9dc88f1b91dce5dc3d46ff2b5bf184aba06439d
>>>>> prerequisite-patch-id: 196fe106100aad619d5be7266959bbeef29b7c8b
>>>>> prerequisite-patch-id: 7e719ed404f664ee8d9b98d56f58326f55ea2175
>>>>> prerequisite-patch-id: 560f95992e13a08279034d5f77aacc9e971332dd
>>>>> prerequisite-patch-id: 8656445ee654056695ff2894e28c8f1014df919e
>>>>> prerequisite-patch-id: 001d831149eb8f9ae17b394e4bcd06d844dd39d9
>>>>> prerequisite-patch-id: 421368aa5eac2af63ef2dc427af2ec11ad45c925
>>>>> prerequisite-patch-id: 18fd00d4743711d835ad546cfbb558d9f97dcdfc
>>>>> prerequisite-patch-id: d89bf9e6d3ea5d332ec2c8e441f1fe6d84e726d3
>>>>> prerequisite-patch-id: 3a6953d11b803abeb437558f3893a3b6a08acdbb
>>>>> prerequisite-patch-id: 0dd42a82e73765950bd069d421d555ded8bfeb25
>>>>> prerequisite-patch-id: da6e0df31ad0d5a945e0a0d29204ba75f0c97344
>>>>> prerequisite-patch-id: ed7d9c768af2ac4e6ce87df2efd0ec359856c6e5
>>>>> prerequisite-patch-id: ed7f4dce80b4f80ccafb57efcd6189a6e14c9208
>>>>> prerequisite-patch-id: ccadb682c5edc3babaef5fe7ecb76ee5daa27ea4
>>>> Alejandro,
>>>> I'm having trouble creating a branch. The hashes for prereq don't seem to exist. Can you please post a public branch somewhere? Thanks!
>>>
>>> Did you read the first paragraph of the cover letter?
>> I reset to f11a5f89910a7ae970fbce4fdc02d86a8ba8570f
>> I was able to apply Terry's v11
>> And after that I think I'm suppose to apply these 4 right?
>> ab70c6227ee6 dax/cxl: Defer Soft Reserved registration
>> 88aec5ea7a24 cxl/mem: Introduce a memdev creation ->probe() operation
>> e23f37a4a834 cxl/port: Arrange for always synchronous endpoint attach
>> 595f243eeac3 cxl/mem: Arrange for always-synchronous memdev attach
>>
>> It failed on cherry picking the first one: 595f243eeac3
>>
> 
> Hi Dave,
> 
> 
> My mistake. I did not remember I had to slightly modify Dan's patches.
> 
> 
> I will send v19 including those patches and working on the minor issues from reviews.

Pushing your code to a public branch on somewhere like github would be great. Thanks!

> 
> 
> Thanks
> 


