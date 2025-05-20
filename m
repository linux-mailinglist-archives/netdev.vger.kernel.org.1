Return-Path: <netdev+bounces-192019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED500ABE473
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 22:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB764C1FC9
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 20:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34148281360;
	Tue, 20 May 2025 20:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mE18FTjH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B0026E16F;
	Tue, 20 May 2025 20:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747771606; cv=none; b=GT2EBzxGJk7+UVMntXtj7AWkiJnNoukuivLuZvtLxeBZp8sJ+9v7HMigxUM7tPUtpuB6JDG9H2JmweVvoICNOtYMFup6bNpDYMU4DyG63sYsMXhWGqRngQZ0tfL5h8YP+vH2zfGOxY6LwvE57dlheNpfyTN294PdXgzwryqd++c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747771606; c=relaxed/simple;
	bh=Q0FOuhUVciG9N/OKF9hak+IoDdEV6ovR25LtLj84fFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHSZL5Lx0nxJ6sN5VG7E3H4KhrWckNQ/cyxoBWG8txXuG+tQKv4ZY0o0MkXo/m/k71Ju58MzioiaoDKzcR+9zObplKKVCbqd8k1wbrWONnaVM1nxt8Pu7lcj6ovbp2VYW0UL4cYdpvrZAFC9rP2w9+u8MgPnAdTOnvIqdmncE3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mE18FTjH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747771604; x=1779307604;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q0FOuhUVciG9N/OKF9hak+IoDdEV6ovR25LtLj84fFQ=;
  b=mE18FTjH195q2UG3MB8iAepgqGAbwqVZajkNDoTwX4ZF56juok4g/om0
   BWbyOj0Svr7AVeyI8ORuEOkvQ1mQY2S0esEoB1p1Xg8tZE6WMnYezQOab
   nylXJAd9b5HJJI2PoFDZRz7Ox8nz2TMXHY5XykyFTNMf3XwFkrFnFfkA/
   osP1FClXLsqA/IQbMLNsHPlelODr23Y+pyQ/TZM2bS5i00scXZmG8/asD
   YHOYAeJNk7HGRQUXmCc8ZdvF2+JxCl1sNVX1/UiowkhNRfzt66bDfua66
   UmE3ok9kYnUfqNfztQjPQiWUBXNw6nCvBFbN7KlwyCdo0bRbR+6dtR3dI
   A==;
X-CSE-ConnectionGUID: AUup539nQdSx50+ho0t/tw==
X-CSE-MsgGUID: //rB0Z6zQr63GivjUVvvYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="60363762"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="60363762"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 13:06:43 -0700
X-CSE-ConnectionGUID: Wu64k1LvRGmQCnJkCy/n7A==
X-CSE-MsgGUID: k6XTc0+4R4a3pJji0tFs+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="143793504"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.109.92]) ([10.125.109.92])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 13:06:42 -0700
Message-ID: <3dcce508-c94a-4614-acf6-123a3ca6eb6b@intel.com>
Date: Tue, 20 May 2025 13:06:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/22] cxl: Add type2 device basic support
To: Alejandro Lucero Palau <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-2-alejandro.lucero-palau@amd.com>
 <aCvsTqArfcKJQDBD@aschofie-mobl2.lan>
 <27f3bdd8-d3da-4dca-bcc4-5bdf7b3ebb35@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <27f3bdd8-d3da-4dca-bcc4-5bdf7b3ebb35@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/20/25 12:18 AM, Alejandro Lucero Palau wrote:
> Hi Allison,
> 
> On 5/20/25 03:43, Alison Schofield wrote:
>> On Wed, May 14, 2025 at 02:27:22PM +0100, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Differentiate CXL memory expanders (type 3) from CXL device accelerators
>>> (type 2) with a new function for initializing cxl_dev_state and a macro
>>> for helping accel drivers to embed cxl_dev_state inside a private
>>> struct.
>>>
>>> Move structs to include/cxl as the size of the accel driver private
>>> struct embedding cxl_dev_state needs to know the size of this struct.
>>>
>>> Use same new initialization with the type3 pci driver.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>
>> snip
> 
> 
> Thank you for all the review tags. Much appreciated.
> 
> 
> I'm afraid Dave merged the patchset some hours ago. Maybe he can still add your tags at some point since I think he is using a specific branch for this merge which will likely be merged to another one in the next days.
> 
> 
> Dave, can you reply here for knowing you have read it?

Hi Alejandro, sorry about the confusion. The branch I had you test was a test branch for my local testing before merging. The code has not been officially merged as it was not pushed to cxl/next branch upstream. It looks like there are some concerns we need to address from Alison and Dan. 
> 
> 


