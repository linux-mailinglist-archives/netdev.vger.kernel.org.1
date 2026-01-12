Return-Path: <netdev+bounces-248930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49135D11860
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 10:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 438D7300B690
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 09:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DF91C84CB;
	Mon, 12 Jan 2026 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Revb+Q8F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0222628D
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210581; cv=none; b=o7p7bP0r67u/hHs9q8ERp05fCZ4TaOhK1OejQsoreyKol+MV6Q2h6pQabnsUsjpsIHHMK3mSB6W9TVOuTRq7amsR38ZYIRthrZVNlVZHtfDPgjk7amaurgMvh0QJU0PYatw0mHLqAX+jrWQQ5yUlZWfftl5Ro0412GXWHDDgJxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210581; c=relaxed/simple;
	bh=TsiS/CSpnyt0RXJzA4DD1dTIpkRrzTXuDtHXTG3OcMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhJRy8GTGI28ht/Zyeo65uWb+C65IoyQK2lMa5K2lHYZHG735l5O53d7TqzS12lsKXVqgIXTrMBTmwCPfW54K7MxARm29C3E4uLq8G3Acqn2vrlTKbz0jOmvQ5PX4o/jKKxCTOCjf5wyxo/jCSnqQO9qDrOF93ozX79TbF0/Irs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Revb+Q8F; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768210579; x=1799746579;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TsiS/CSpnyt0RXJzA4DD1dTIpkRrzTXuDtHXTG3OcMc=;
  b=Revb+Q8FP4n2EmG34zhgyrDYU+aa/oUUqEo1IDN9pgBR84W+91Pg7SII
   qTzXcGdSxAFhGUlNq2Kmjcussmv2Wz41J2wcdw2gonvK6bfpp4bSxCa8K
   71rMHqOjXXZSlGWOR1T7Y4sNbR28gW30eY3VkFJ6zi6wI94rfj5ciupEN
   S8HaCOVjIkewjuB8U/nbyPi3UX7EjR578RwoG73GzFdl9KG1ocyWjl3Nm
   tNyiD8PmDhxqjELDpsMPYoTTZEkLRY2CtoEC8gvKzMgm0d+roOiTV2F+i
   wzN1vJAmhEJOOIGzuY4GY6A5toVJK7hd1EpKeVpH0pE2F8XWtWLYxR2xj
   A==;
X-CSE-ConnectionGUID: UgFK2FBrSjKmsw+AU4O74g==
X-CSE-MsgGUID: HkyeEIliRFWyDo+2q+/cdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69216796"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69216796"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 01:36:19 -0800
X-CSE-ConnectionGUID: /L0Bh2RqRtSXJ6k0tqXgeg==
X-CSE-MsgGUID: Lc9R4vtjRD6XCe43eVkMwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="203259953"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.246.20.185]) ([10.246.20.185])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 01:36:18 -0800
Message-ID: <1e162d79-20a2-4de3-8862-aa4fbe842132@linux.intel.com>
Date: Mon, 12 Jan 2026 10:36:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ice: fix setting RSS VSI hash for E830
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20260109085339.49839-1-marcin.szycik@linux.intel.com>
 <ddd25fe0-a6a8-4ba9-8cb1-3f91ca562928@linux.dev>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <ddd25fe0-a6a8-4ba9-8cb1-3f91ca562928@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 09.01.2026 17:44, Vadim Fedorenko wrote:
> On 09/01/2026 08:53, Marcin Szycik wrote:
>> ice_set_rss_hfunc() performs a VSI update, in which it sets hashing
>> function, leaving other VSI options unchanged. However, ::q_opt_flags is
>> mistakenly set to the value of another field, instead of its original
>> value, probably due to a typo. What happens next is hardware-dependent:
>>
>> On E810, only the first bit is meaningful (see
>> ICE_AQ_VSI_Q_OPT_PE_FLTR_EN) and can potentially end up in a different
>> state than before VSI update.
>>
>> On E830, some of the remaining bits are not reserved. Setting them
>> to some unrelated values can cause the firmware to reject the update
>> because of invalid settings, or worse - succeed.
>>
>> Reproducer:
>>    sudo ethtool -X $PF1 equal 8
>>
>> Output in dmesg:
>>    Failed to configure RSS hash for VSI 6, error -5
>>
>> Fixes: 352e9bf23813 ("ice: enable symmetric-xor RSS for Toeplitz hash function")
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index cf8ba5a85384..08268f1a03da 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -8038,7 +8038,7 @@ int ice_set_rss_hfunc(struct ice_vsi *vsi, u8 hfunc)
>>       ctx->info.q_opt_rss |=
>>           FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_HASH_M, hfunc);
>>       ctx->info.q_opt_tc = vsi->info.q_opt_tc;
>> -    ctx->info.q_opt_flags = vsi->info.q_opt_rss;
>> +    ctx->info.q_opt_flags = vsi->info.q_opt_flags;
> 
> The very same typo pattern is in ice_vc_handle_rss_cfg() in
> ice/virt/rss.c
> 
> I believe both places have to be fixed.

Hmm... where exactly? ice_vc_rss_hash_update() (called from ice_vc_handle_rss_cfg()) looks correct.

Thanks for reviewing,
Marcin

> 
>>         err = ice_update_vsi(hw, vsi->idx, ctx, NULL);
>>       if (err) {
> 


