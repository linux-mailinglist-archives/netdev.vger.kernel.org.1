Return-Path: <netdev+bounces-179013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95493A7A07D
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 11:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DF5C7A24B1
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 09:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2B42E3385;
	Thu,  3 Apr 2025 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMV4S2ef"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF79243364
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743673900; cv=none; b=bUxVTNY2OBAcljx5OLPt8VlwiLkJp/CZtBknvFbcE8EciupschiDvQMbUo+odB6HuIpXAb6dsNSe3eQ7v7YPj3BNOvPn6C16eujnEleAQl/BgQ0NbvEkU4IN9DeIkxcE98taPHjaNL/GwzMD73gfgQ/grW5zU7vk8woGn6rB3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743673900; c=relaxed/simple;
	bh=MtcQ7DZ5Rlv3F5xnlhEZiUe0iQ16fg6nrovE73Yt0LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPiRZdAPFZa2zzSMkBxDOmHJybrNTblxn3ZzEerSJC1GRpUdeR8LCS1Xj4S2OaeXb3CEcDhD97zH3IY1tGApQ/hDiuFN6UWz+p3ovWOT3xmdISDFzkSo4NC+Tbz5kCbF9MtDcU5r4gEbSHcd1moGQqIRLU0vQxhnmd5cTIwGym4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMV4S2ef; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743673899; x=1775209899;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MtcQ7DZ5Rlv3F5xnlhEZiUe0iQ16fg6nrovE73Yt0LI=;
  b=AMV4S2ef8xwWeUaqZV5+rzBdKN54j6dOfLax+dkheYj/6OwMirENXuf3
   wLSfAwQ1FGSqJ1hmxvfaYDChhDRBe8ISLOGJ2kgnGuFaqqgnTTBOfaE0v
   z61cTVK603obcIhfCI52dqeikP97iNwhn7bUzKB7RakzpDzxkAhcymew4
   kSZdI+fcGryuzCytu0b4CGdYGbbieAPTm4yTWH4qR/xL1+EigPSmf5DeP
   9UFdgFUYQd1oZvbDfijDXFRV/MweTp822pW1rBoIaZr72fxpMLuIJbkB1
   XUPZn9UgnsIkNaxLDQqun6U5JIVk8nJEFK6JcA6kZ/lff1Yo+B0yw1nzR
   g==;
X-CSE-ConnectionGUID: pO+VFcUPSduDtd3rrOuJgg==
X-CSE-MsgGUID: K8H2BlU8QFyQvc7dNhj+fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="55701496"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="55701496"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 02:51:38 -0700
X-CSE-ConnectionGUID: EIPOIixUSbOSW6P+fdJU4g==
X-CSE-MsgGUID: GIjPAyN5TX+hQT/KPhPjKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="126952994"
Received: from mszapar-mobl1.ger.corp.intel.com (HELO [10.246.0.161]) ([10.246.0.161])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 02:51:37 -0700
Message-ID: <125533c8-44fe-4a87-af16-d934800b82d2@linux.intel.com>
Date: Thu, 3 Apr 2025 11:51:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: improve error message for
 insufficient filter space
To: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>,
 Simon Horman <horms@kernel.org>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
References: <20250314081110.34694-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250319121743.GB280585@kernel.org>
 <PH0PR11MB5013F63C43277D7466F4F95896AC2@PH0PR11MB5013.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>
In-Reply-To: <PH0PR11MB5013F63C43277D7466F4F95896AC2@PH0PR11MB5013.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sujai,

I reverified the issue, and with the patch, I am now getting the correct 
error about insufficient space, when attempting to add to many rules. 
The error you’re encountering might be caused by a different issue.

Could you please test it again or send me offline the set of rules you 
are adding? It seems to be working fine on my side.

Regards,
Martyna

On 4/1/2025 11:49 AM, Buvaneswaran, Sujai wrote:
> Hi,
> 
> I tried to add tc rules to the HW beyond the maximum limit and still noticing the below error message instead of error message mentioned in the patch.
> 
> [root@dell-cnv-sut ~]# tc filter add dev ens5f0np0 ingress protocol ip prio 0 flower skip_sw dst_mac 00:f0:01:00:00:0E action mirred egress redirect dev ens5f0npf0vf0
> Error: ice: Unable to add filter due to error.
> We have an error talking to the kernel
> 
> [root@dell-cnv-sut ~]# tc filter show dev ens5f0np0 root | grep -c in_hw
> 16306
> 
> Please check it.
> 
> Thanks,
> Sujai B
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>> Simon Horman
>> Sent: Wednesday, March 19, 2025 5:48 PM
>> To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
>> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Michal
>> Swiatkowski <michal.swiatkowski@linux.intel.com>
>> Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: improve error message for
>> insufficient filter space
>>
>> On Fri, Mar 14, 2025 at 09:11:11AM +0100, Martyna Szapar-Mudlaw wrote:
>>> When adding a rule to switch through tc, if the operation fails due to
>>> not enough free recipes (-ENOSPC), provide a clearer error message:
>>> "Unable to add filter: insufficient space available."
>>>
>>> This improves user feedback by distinguishing space limitations from
>>> other generic failures.
>>>
>>> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>>> Signed-off-by: Martyna Szapar-Mudlaw
>>> <martyna.szapar-mudlaw@linux.intel.com>
>>
>> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> 


