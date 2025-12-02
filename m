Return-Path: <netdev+bounces-243247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAC5C9C389
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 17:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 749763483B4
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 16:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD9E279792;
	Tue,  2 Dec 2025 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TabK4NPH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E3212B0A;
	Tue,  2 Dec 2025 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764693306; cv=none; b=K+iBAWQ56EwVYKWmWEhrkbdfcupT6m/j+KtqOotN350HWZzpvyKRaExRoyc7WkCpRR2mNhE8S+oidA54IJC1mUZDEHszam493yR/OKWiIEM3mubE2PVTcG0/Zvb/JQN7uevtnv1bvf6XaOxdBJ5tBLc29yjuebMsbCBruNexRu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764693306; c=relaxed/simple;
	bh=Ypxqaow/7O9dLqCku+Yyx8xIqARbQZ7VDch13rAvga4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VslQL/AFIzUkbfBPz5sG4c2VAasPTRJHFrZJwqiip/qKKZJHYzbSGsJApc7JV7HzpsHhB4mPG1Ty7I1LcO/h3FDFSpLdHOZlkHO/EcbzgEuQ5qV45vn/1v3nDFEdoM0Ajr2jQ3B5N99Bn0L7q7vigG5zErOByha91elV3wMhZ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TabK4NPH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764693304; x=1796229304;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ypxqaow/7O9dLqCku+Yyx8xIqARbQZ7VDch13rAvga4=;
  b=TabK4NPH/4a4qQD62djsHtvqF+3eYrhXjEkq9NxvpHsd8Ztem9CNLg/i
   KOVr6/5Nsz6J8P0Vu3WejQYkZ3uZh/CKjnZ9zBTisSIJs0eqAJEsH13VO
   I3YSCXWpTG6IwX0GgT+BvT3NElz6HvAcRIwR/VK06tA3VSTg0eHqvYGt6
   joc6MXdQc7zmltWYJAonoEtR20G1FVqoDdYhS8VKZ3q3sSRoqQvTW8IiT
   dUuxdTaqERCIxZTBCug7K/X4auEsbAmhZp8Q57PNZ/Q60w4wZOnb5RCt0
   kZjbZWpkvuAfXKbCoG4LatXrh30W+xrRdbovpsy5iDmnC2FDecMD29Z8j
   g==;
X-CSE-ConnectionGUID: MnZo5hAyRIufVUwJVlPJoA==
X-CSE-MsgGUID: 2xnwoo0vQZKj63x/jprpig==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66554703"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="66554703"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 08:35:03 -0800
X-CSE-ConnectionGUID: bzT+uEasSyiNHHp9sUF+gw==
X-CSE-MsgGUID: D3oSsEHRSTCQQwDwqMgodQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="231749151"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.111.202]) ([10.125.111.202])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 08:35:03 -0800
Message-ID: <1be144f4-4ebd-420b-9a09-104c3cb1a8d6@intel.com>
Date: Tue, 2 Dec 2025 09:35:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 15/23] sfc: get endpoint decoder
To: PJ Waskiewicz <ppwaskie@kernel.org>,
 Alejandro Lucero Palau <alucerop@amd.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Martin Habets <habetsm.xilinx@gmail.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
 <20251119192236.2527305-16-alejandro.lucero-palau@amd.com>
 <4aab1857efeaf2888b1c85cbac1fc5c8fc5c8cbc.camel@kernel.org>
 <34f7771f-7d6d-4bfd-9212-889433d80b4c@amd.com>
 <7f1e56067bdc46195a9e36f914aa103dc76d4f7f.camel@kernel.org>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <7f1e56067bdc46195a9e36f914aa103dc76d4f7f.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/25 11:35 AM, PJ Waskiewicz wrote:
> Hi Alejandro,
> 
> On Wed, 2025-11-26 at 09:09 +0000, Alejandro Lucero Palau wrote:
>>
>> On 11/26/25 01:27, PJ Waskiewicz wrote:
>>> Hi Alejandro,
>>>
>>> On Wed, 2025-11-19 at 19:22 +0000, alejandro.lucero-palau@amd.com
>>> wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>

<snip>

> 
> What I'm trying to do is get the regionX object to instantiate on my
> CXL.mem memory block, so that I can remove the region, ultimately
> tearing down the decoders, and allowing me to hotplug the device.  The
> patches here seem to still assume a Type3-ish device where there's DPA
> needing to get mapped into HPA, which our devices are already allocated
> in the decoders due to the EFI_RESERVED_TYPE enumeration.  But the
> patches aren't seeing that firmware already set them up, since the
> decoders haven't been committed yet.

Can you please clarify on what you mean by "the decoders haven't been committed yet"? If the region is setup, then isn't the expectation that the decoders are committed on device? 



