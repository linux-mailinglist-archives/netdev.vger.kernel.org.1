Return-Path: <netdev+bounces-202572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CD2AEE4C2
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FD818855D8
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6AD28DEEE;
	Mon, 30 Jun 2025 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5zHiF3Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522F928FAA5;
	Mon, 30 Jun 2025 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301269; cv=none; b=PfylfTQkJXBmk4LcxzqG4OpcG0gzBe9WtamJRlkPnz7tOnYJ8KVDXzBsWmqhNmnWAI4JltVeSuqePofgtjWWTSD/6b9g5yZyXEo1m3CEH9EUz9MpRr5YHJX1Ybe6m11nBHfUN9jviMLY4asiTqJqcf56FwIffKpzvYXGCC8ONI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301269; c=relaxed/simple;
	bh=Ufwo18IowwwYmo6uzicPJMJYs6/UzCvrzdowvbrymq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AD2+5tOA9APDEHDKmy0ArtqkqhWsW/erUmbqWua9kvU5Z9dNJPmLuuArqb+QkWY1CnlVY7ipR11uTYSV6LRO7xKIWzdjBwN8mHjW/yztHR7wmtx1agnyl/74j2gGe0f6a115b+uXwc57CCW8hA8V8pPHaHkK6ZAEF85cDAiJCjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5zHiF3Q; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751301268; x=1782837268;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ufwo18IowwwYmo6uzicPJMJYs6/UzCvrzdowvbrymq8=;
  b=k5zHiF3QPGmTm0L4CiYOSWGiaEGTYPqWifO0q3TLOK5Y0xycLg1ribU7
   ltlpwYsQFwFNgXA1/4WZOOeWkUqVoL3aOjJbc0MsL7a0zZVgUI8sCbvra
   4iwoiA9imb44a01P6ymH96VTRm6lFVskJ1CRW3JqtA1aP5aLbcCryUA/2
   u1DcBhH0EW5ovHDsEqnPzqcvqO1CL1C87NGMcqQwSCD9O2FR0dRNzuCEb
   D78DUU/YlCnBRpJ4mAxlHsV1GIwdvxBeA0r9N+02bOhI/PNBE6rQZdc2x
   vNd6FHfmkGsR9lAX8jhXhPgM6iBNY8EuMXpxiCgKvJ4eVPhnUGgDSFAvb
   g==;
X-CSE-ConnectionGUID: 4iU1OSGtQhWfJNFPkv58vA==
X-CSE-MsgGUID: rBQncCUlS4iLbyushi7YXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="64135975"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="64135975"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 09:34:26 -0700
X-CSE-ConnectionGUID: qWX9GIwqTkycYyHg0VW2/w==
X-CSE-MsgGUID: 2ww2rYhHQgiC5V3eMoLBVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="190673538"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.125.109.132]) ([10.125.109.132])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 09:34:25 -0700
Message-ID: <5caa70f4-27d6-4635-93e4-61aaa9216b4e@intel.com>
Date: Mon, 30 Jun 2025 09:34:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 16/22] cxl/region: Factor out interleave ways setup
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, Alejandro Lucero <alucerop@amd.com>,
 Zhi Wang <zhiw@nvidia.com>, Ben Cheatham <benjamin.cheatham@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-17-alejandro.lucero-palau@amd.com>
 <20250627101345.00002524@huawei.com>
 <0a73070b-b7b0-4697-9fb6-b43a4e6834b6@intel.com>
 <20250630172052.000011bd@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250630172052.000011bd@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/30/25 9:20 AM, Jonathan Cameron wrote:
> On Fri, 27 Jun 2025 16:05:20 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> On 6/27/25 2:13 AM, Jonathan Cameron wrote:
>>> On Tue, 24 Jun 2025 15:13:49 +0100
>>> <alejandro.lucero-palau@amd.com> wrote:
>>>   
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Region creation based on Type3 devices is triggered from user space
>>>> allowing memory combination through interleaving.
>>>>
>>>> In preparation for kernel driven region creation, that is Type2 drivers
>>>> triggering region creation backed with its advertised CXL memory, factor
>>>> out a common helper from the user-sysfs region setup for interleave ways.
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>  
>>> As a heads up, this code changes a fair bit in Dan's ACQUIRE() series
>>> that may well land before this.  Dave can ask for whatever resolution he
>>> wants when we get to that stage!
>>>
>>>   
>> We probably want to rebase on top of that. Dan has an immutable branch in cxl.git for the ACQUIRE() patch. Or are you talking about the outstanding CXL changes?
>>
> The CXL specific ones from that series.

Hopefully we can get those resolved with the next rev when Dan's back from vacation. 
> 
> J
>>
> 


