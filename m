Return-Path: <netdev+bounces-224907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B256B8B623
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 23:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 424B17A71F3
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 21:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2C12D063D;
	Fri, 19 Sep 2025 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="flsx/aK4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766A22773C6;
	Fri, 19 Sep 2025 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758318132; cv=none; b=j0mOyWRxTi9q16yXHC9VYskg/EUe8vlUmKrmm80iQj1bK/Gch2Dt/M+30GvacgtfsOQ9YTIvy2KmSRymPD+lnHWlbWw74Q9oT8wQrACX1c1XrVE72r1w3rCbtik0ESyuMOy31Bbm8StPQJdZjyaZWYRwn99y2TeCeMf9zQfNr1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758318132; c=relaxed/simple;
	bh=b6jaFRhcyrVBQkuNL7YifEGCswU9MAcVDsBn1whxhzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZQc2Z+SWhan3yRb5YnLo0CMI0btASRDC78+bMeIaWZS1KRAw/bJ/bK7nhuM1T4fyhdapLySNrf/5y1/5ihyBy7BndI8fC9ijMriIHttNN0ifUhVSLVp7Pv4K2lE4d7y+fh8bpRM49GjlXWBotZX5sWZKyGCdf68IpMVkxw05uL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=flsx/aK4; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758318130; x=1789854130;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=b6jaFRhcyrVBQkuNL7YifEGCswU9MAcVDsBn1whxhzs=;
  b=flsx/aK4rUYveatYYorMfdj4PJz+TbqAclavzkOtVHG6G2I1Q37oVC5K
   LyVX3K3X939gvSiqa+6AEoPiM03LK9Dd94Dc3dMdNuIZ2YdCG79KuyjgY
   JpWo0RmInsQNCTZ2TAUcl9Mab5vNT338cAwTEqET2FYgiZU67rhbgAYIP
   xth9scApUeR35eKwCgzhCitaEt8CqZnLefMsbqqObTdobrgxqqFO6xHVI
   yNqZPerZXVxPZx6nBJIV4Uz/OLt3fiAIed5EaNwVGj2mLAaVi+9eY5UC7
   C4MfKGpNXWI5bvxIbHaAuIiOK4BVvB53A9PjGf9cZBSexzeGWzxj1ofdD
   A==;
X-CSE-ConnectionGUID: KQPoG0rSQMSFeHd0abjbiQ==
X-CSE-MsgGUID: WpdYrSySQZOCrX1cg+UZ3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60731396"
X-IronPort-AV: E=Sophos;i="6.18,279,1751266800"; 
   d="scan'208";a="60731396"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 14:42:09 -0700
X-CSE-ConnectionGUID: nEwLKXfmTXKf7GH0x8W/0A==
X-CSE-MsgGUID: ufH7+BOvR1KbEPHYdSojsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,279,1751266800"; 
   d="scan'208";a="213083364"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.58]) ([10.125.108.58])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 14:42:09 -0700
Message-ID: <aea329a3-9cb9-4552-88e7-2b354483ad53@intel.com>
Date: Fri, 19 Sep 2025 14:42:08 -0700
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
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <c012498b-d9f9-439a-a926-ef5f10689bf7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/19/25 9:55 AM, Alejandro Lucero Palau wrote:
> Hi Dave,
> 
> 
> 
> On 9/19/25 17:26, Dave Jiang wrote:
>>
>> On 9/18/25 2:17 AM, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> First of all, the patchset should be applied on the described base
>>> commit then applying Terry's v11 about CXL error handling plus last four
>>> pathces from Dan's for-6.18/cxl-probe-order branch.
>>>
> 
> <snip>
> 
>>>
>>> base-commit: f11a5f89910a7ae970fbce4fdc02d86a8ba8570f
>>> prerequisite-patch-id: 44c914dd079e40d716f3f2d91653247eca731594
>>> prerequisite-patch-id: b13ca5c11c44a736563477d67b1dceadfe3ea19e
>>> prerequisite-patch-id: d0d82965bbea8a2b5ea2f763f19de4dfaa8479c3
>>> prerequisite-patch-id: dd0f24b3bdb938f2f123bc26b31cd5fe659e05eb
>>> prerequisite-patch-id: 2ea41ec399f2360a84e86e97a8f940a62561931a
>>> prerequisite-patch-id: 367b61b5a313db6324f9cf917d46df580f3bbd3b
>>> prerequisite-patch-id: 1805332a9f191bc3547927d96de5926356dac03c
>>> prerequisite-patch-id: 40657fd517f8e835a091c07e93d6abc08f85d395
>>> prerequisite-patch-id: 901eb0d91816499446964b2a9089db59656da08d
>>> prerequisite-patch-id: 79856c0199d6872fd2f76a5829dba7fa46f225d6
>>> prerequisite-patch-id: 6f3503e59a3d745e5ecff4aaed668e2d32da7e4b
>>> prerequisite-patch-id: e9dc88f1b91dce5dc3d46ff2b5bf184aba06439d
>>> prerequisite-patch-id: 196fe106100aad619d5be7266959bbeef29b7c8b
>>> prerequisite-patch-id: 7e719ed404f664ee8d9b98d56f58326f55ea2175
>>> prerequisite-patch-id: 560f95992e13a08279034d5f77aacc9e971332dd
>>> prerequisite-patch-id: 8656445ee654056695ff2894e28c8f1014df919e
>>> prerequisite-patch-id: 001d831149eb8f9ae17b394e4bcd06d844dd39d9
>>> prerequisite-patch-id: 421368aa5eac2af63ef2dc427af2ec11ad45c925
>>> prerequisite-patch-id: 18fd00d4743711d835ad546cfbb558d9f97dcdfc
>>> prerequisite-patch-id: d89bf9e6d3ea5d332ec2c8e441f1fe6d84e726d3
>>> prerequisite-patch-id: 3a6953d11b803abeb437558f3893a3b6a08acdbb
>>> prerequisite-patch-id: 0dd42a82e73765950bd069d421d555ded8bfeb25
>>> prerequisite-patch-id: da6e0df31ad0d5a945e0a0d29204ba75f0c97344
>>> prerequisite-patch-id: ed7d9c768af2ac4e6ce87df2efd0ec359856c6e5
>>> prerequisite-patch-id: ed7f4dce80b4f80ccafb57efcd6189a6e14c9208
>>> prerequisite-patch-id: ccadb682c5edc3babaef5fe7ecb76ee5daa27ea4
>> Alejandro,
>> I'm having trouble creating a branch. The hashes for prereq don't seem to exist. Can you please post a public branch somewhere? Thanks!
> 
> 
> Did you read the first paragraph of the cover letter?

I reset to f11a5f89910a7ae970fbce4fdc02d86a8ba8570f
I was able to apply Terry's v11
And after that I think I'm suppose to apply these 4 right?
ab70c6227ee6 dax/cxl: Defer Soft Reserved registration
88aec5ea7a24 cxl/mem: Introduce a memdev creation ->probe() operation
e23f37a4a834 cxl/port: Arrange for always synchronous endpoint attach
595f243eeac3 cxl/mem: Arrange for always-synchronous memdev attach

It failed on cherry picking the first one: 595f243eeac3


