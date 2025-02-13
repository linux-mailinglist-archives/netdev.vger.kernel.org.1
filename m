Return-Path: <netdev+bounces-166020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1A1A33F30
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3591620D9
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD76227E93;
	Thu, 13 Feb 2025 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QDR0b1j0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CDA227E90
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 12:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449969; cv=none; b=EXTjTFeP+C788BlmcC9yGRw3qTQfAQWm9ZFasjATAxKRKwks18moC0MB33N51MEnJMwJp515eTFkFhhhFqz97P67ndxrFHBzeAlvkPOupZmOZKwqM5RFhCRsY2Aeu9e7lAmu3FYxaNstiGz07BPJ9Wt6WUXpDhHn9K5O1WYSpbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449969; c=relaxed/simple;
	bh=RcflCDrVyBPjEwqhw+sYDxD23XYRao4CSRuywRl9PrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCF/G6ye7NGHqsMX87wLjYFEv7QfQ3FMhY5kIk6zpZ/bbnajk403pSYbiyXjj5OB3DeVIb5+rsAJVHiWCNWXxtl763KBqtr9boeckeYT+tKt+8bT+6XI3wvUwgXgW+99OO/ydt++do+u8oACF9JME2O+u+voqaaxAsDW8NyB5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QDR0b1j0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739449967; x=1770985967;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RcflCDrVyBPjEwqhw+sYDxD23XYRao4CSRuywRl9PrA=;
  b=QDR0b1j0sNcz/WMHPiICsv1sdi6l3omWiYrHyI9+sh6IYfCxdTpQhCkk
   EbahgUNVE6JpTdWgkPXVZL1/pNafjBvQKxUAZH820FWyGEQdGqGo0QFH6
   HFekLSgQ9fd2DMrjazf8QqAhF8XGLvWyc3PRan2qhvj1sAiYrMCdtGhBv
   zUecqRfRO2BB+oaJokkAL5vJKS5JF53oVyQNv1laztkoXeCi6GOtFC0NT
   HNXYHR7sewv+6Yay34IGHM1PmLfJBrq5geUINkaxHCdfBn1mUaYI25aj/
   Yl8dDB5xeAshcpdSK5v4Es21L3j7ZqVwFnIu8Gx1RaQByym6l1JzX/7qi
   g==;
X-CSE-ConnectionGUID: yRf8HZnzSaC6J12OcrmriQ==
X-CSE-MsgGUID: G1eQ+ZQyR16uF9OAS3DwoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40020057"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40020057"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 04:32:46 -0800
X-CSE-ConnectionGUID: mpO1Da2XTIez3KJCr4zVMw==
X-CSE-MsgGUID: mTEzOXx5TQeeZz0W6XJwdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117760734"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.246.21.71]) ([10.246.21.71])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 04:32:45 -0800
Message-ID: <72975a9c-0daf-4100-b31a-cee0f52e2514@linux.intel.com>
Date: Thu, 13 Feb 2025 13:32:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 1/2] ice: Fix deinitializing VF in error path
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 michal.swiatkowski@linux.intel.com,
 Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
 Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
References: <20250211174322.603652-1-marcin.szycik@linux.intel.com>
 <20250213105525.GJ1615191@kernel.org>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20250213105525.GJ1615191@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13.02.2025 11:55, Simon Horman wrote:
> On Tue, Feb 11, 2025 at 06:43:21PM +0100, Marcin Szycik wrote:
>> If ice_ena_vfs() fails after calling ice_create_vf_entries(), it frees
>> all VFs without removing them from snapshot PF-VF mailbox list, leading
>> to list corruption.
>>
>> Reproducer:
>>   devlink dev eswitch set $PF1_PCI mode switchdev
>>   ip l s $PF1 up
>>   ip l s $PF1 promisc on
>>   sleep 1
>>   echo 1 > /sys/class/net/$PF1/device/sriov_numvfs
> 
> Should the line above be "echo 0" to remove the VFs before creating VFs
> below (I'm looking at sriov_numvfs_store())?

Both "echo 1" commands fail (I'm fixing it in patch 2/2), that's why there's
no "echo 0" in between. Also, in this minimal example I'm assuming no VFs
were initially present.

Thanks for reviewing!
Marcin

>>   sleep 1
>>   echo 1 > /sys/class/net/$PF1/device/sriov_numvfs
>>
>> Trace (minimized):
>>   list_add corruption. next->prev should be prev (ffff8882e241c6f0), but was 0000000000000000. (next=ffff888455da1330).
>>   kernel BUG at lib/list_debug.c:29!
>>   RIP: 0010:__list_add_valid_or_report+0xa6/0x100
>>    ice_mbx_init_vf_info+0xa7/0x180 [ice]
>>    ice_initialize_vf_entry+0x1fa/0x250 [ice]
>>    ice_sriov_configure+0x8d7/0x1520 [ice]
>>    ? __percpu_ref_switch_mode+0x1b1/0x5d0
>>    ? __pfx_ice_sriov_configure+0x10/0x10 [ice]
>>
>> Sometimes a KASAN report can be seen instead with a similar stack trace:
>>   BUG: KASAN: use-after-free in __list_add_valid_or_report+0xf1/0x100
>>
>> VFs are added to this list in ice_mbx_init_vf_info(), but only removed
>> in ice_free_vfs(). Move the removing to ice_free_vf_entries(), which is
>> also being called in other places where VFs are being removed (including
>> ice_free_vfs() itself).
>>
>> Fixes: 8cd8a6b17d27 ("ice: move VF overflow message count into struct ice_mbx_vf_info")
>> Reported-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
>> Closes: https://lore.kernel.org/intel-wired-lan/PH0PR11MB50138B635F2E5CEB7075325D961F2@PH0PR11MB5013.namprd11.prod.outlook.com
>> Reviewed-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> 
> The comment above notwithstanding, I agree that this addresses the
> bug you have described.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 


