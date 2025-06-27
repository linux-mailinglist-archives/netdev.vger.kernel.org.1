Return-Path: <netdev+bounces-202080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70395AEC2DD
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 01:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A4E4A44E0
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 23:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150732571A1;
	Fri, 27 Jun 2025 23:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ni1PGoBI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26720218E8B;
	Fri, 27 Jun 2025 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751065524; cv=none; b=OcsUsXKPfur62NA4R0jQ1RGJwL+FeZ7P+ATYAYEyCIAxRaBH0vfye+FUa5vXqy1YvDkAw4PDQJBUvFhPIvce/cdsnANfl0SjWCLxkUOYTEXejzhCKrIlChfWkbKO+CGx4wuZF9uta8fjHx1zOl6tbNmBLGOg0NLwhYNycvbFDTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751065524; c=relaxed/simple;
	bh=wRIRhJCsEL9zZxdLGTeYwDDxinrcqeldfAZjHjYSMQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nadlGeC0d3TWbeIdolBYlND49HMhEEIFFc11kXLDPTorQkhSazILhShUVV3i0yjx1Dz1gzmXLLpL++naFhS2OcHje502H1/f+5qE42kZ4NiPL3mn16mVXq2oiE6Fqee+bxrbxZcyBG8HJ40i9JQHbeiuQ5YouOz6KEvvPPDaLzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ni1PGoBI; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751065522; x=1782601522;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wRIRhJCsEL9zZxdLGTeYwDDxinrcqeldfAZjHjYSMQ4=;
  b=ni1PGoBIDm9oiibsK67QKUmJaYiDtNyt+RzP7VFh1+c4y6s+gGn+72Rr
   Fp4ysLJJFCP7BnT6TTBdBXAb1Co9QbStifKzrHSf/Z2u5UmtDClLWpWhi
   i5vnW3SqoNHItgZ51P1W/vSDkxi+zgc63QHb5Q/LtUeyN3kSbA3nyK2gX
   olrb6TVKgliWGSZwKZr+XTAA88sGvZ+w3COD820Olkoxi9hhJulBiJf7A
   1/ydKOo3oCxzYCJySG1hjdzZn6qtDZXajEpPS/fDz7EYKv7WdiCzvQD/8
   cJa/tF/ZffS4WZcX5nGp0ak0pJgibvqYrtt4nmiflie8JB7rBcPzILIW3
   w==;
X-CSE-ConnectionGUID: jmFdrc/SQaSxm47+SIBw9Q==
X-CSE-MsgGUID: B8CYdSySRdOjj2IgQUDEVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53510978"
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="53510978"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 16:05:22 -0700
X-CSE-ConnectionGUID: +1Cg3FN5Rta2ntTQCbNeEw==
X-CSE-MsgGUID: apmWlYiRR7Sd9h1YHSNMFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="153104767"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.77]) ([10.125.109.77])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 16:05:21 -0700
Message-ID: <0a73070b-b7b0-4697-9fb6-b43a4e6834b6@intel.com>
Date: Fri, 27 Jun 2025 16:05:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 16/22] cxl/region: Factor out interleave ways setup
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-17-alejandro.lucero-palau@amd.com>
 <20250627101345.00002524@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250627101345.00002524@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/27/25 2:13 AM, Jonathan Cameron wrote:
> On Tue, 24 Jun 2025 15:13:49 +0100
> <alejandro.lucero-palau@amd.com> wrote:
> 
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation based on Type3 devices is triggered from user space
>> allowing memory combination through interleaving.
>>
>> In preparation for kernel driven region creation, that is Type2 drivers
>> triggering region creation backed with its advertised CXL memory, factor
>> out a common helper from the user-sysfs region setup for interleave ways.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> As a heads up, this code changes a fair bit in Dan's ACQUIRE() series
> that may well land before this.  Dave can ask for whatever resolution he
> wants when we get to that stage!
> 
> 
We probably want to rebase on top of that. Dan has an immutable branch in cxl.git for the ACQUIRE() patch. Or are you talking about the outstanding CXL changes?


