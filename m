Return-Path: <netdev+bounces-171609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4026CA4DCDC
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58247176468
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6FE1F193D;
	Tue,  4 Mar 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MrOL5429"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7483D561
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088759; cv=none; b=jkYUZVOpIRs0ibzlXlMngoCNMdxaIf6glJwgJc5RlIqfTmjChrpfa2LqvqHo9N22awTVIdxtswoLUE2mg7EhmRrdah04+0UNz+ESfwHAnMa/IgYLv/UTxZKZFx0G3UdfDS2ioTMdqgGMrYSSHWnew0fzuTjM/DOEA6gQtE3xyDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088759; c=relaxed/simple;
	bh=4soIBXAhLCkxO3sab6sFxXzD1R3x08j+wWGiid82z2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/UCv3JidPdc4/6v2NCYo6Q3QDRIuQpLG/OVQC6lg2Ux3hB4PZ0x+9FkGxqbpQHltkoum2Nu5YK4VAB1jWFoXYzfXMAafSCkBa4gZd7uqYyM4swdwYWKyngq7JZNCyHn3x9F9JyQblbH1N/BTivXgUK3kMFaUK5OFX0n1Kwz6WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MrOL5429; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741088759; x=1772624759;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4soIBXAhLCkxO3sab6sFxXzD1R3x08j+wWGiid82z2U=;
  b=MrOL5429SHySuNA0xzb7e1FLrUnZ/NXsGhLHzGf8wABrOh/a2MNqIx0X
   hQR8hZNlIjZquqF9Npay+5t7fNHdhiPXidTfXIsoqMynuMb0e7r1FEzzb
   l/Q+IbjuTNhRnz2Se4lQ1A274vQu7KwnbS7bD5cIecWZjjqtDj0orYoXP
   u22eKZhMMhJdsFA1+JQGjdUXh0OhOoi3lMNEO7QRT0pGH05ynkGyPSbE+
   S/7r+FZzfDwWG6APgcEI9CI5Bf7TLYd0oRzGXDTrVwewyR9z9MZvRkmVI
   JJb0EV/jUOpeSqp/PITwS4P7qQ64y0rD0125IBSB51838B5KojVdIKvta
   A==;
X-CSE-ConnectionGUID: w0uLXTvPR1+7SBSboJ89pQ==
X-CSE-MsgGUID: lv3YhJooSU2sGCH/yz4Izw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="59414277"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="59414277"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:45:58 -0800
X-CSE-ConnectionGUID: 1mi39+9bRoa3gjvfekyv4g==
X-CSE-MsgGUID: g39yr5FXSJSr6oNj+6TxMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="123472296"
Received: from mszapar-mobl1.ger.corp.intel.com (HELO [10.245.99.188]) ([10.245.99.188])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:45:56 -0800
Message-ID: <00a160e5-c9b2-4b91-9823-dee37fdc5d25@linux.intel.com>
Date: Tue, 4 Mar 2025 12:45:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [iwl-net v3 1/5] virtchnl: make proto and
 filter action count unsigned
To: Paul Menzel <pmenzel@molgen.mpg.de>, Jan Glaza <jan.glaza@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Simon Horman <horms@kernel.org>
References: <20250304110833.95997-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250304110833.95997-4-martyna.szapar-mudlaw@linux.intel.com>
 <9f6b830f-d2ee-4fde-a131-a956a6e84df7@molgen.mpg.de>
Content-Language: en-US
From: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>
In-Reply-To: <9f6b830f-d2ee-4fde-a131-a956a6e84df7@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/4/2025 12:15 PM, Paul Menzel wrote:
> Dear Jan, dear Martina,
> 
> 
> Thank you for the patch.
> 
> Am 04.03.25 um 12:08 schrieb Martyna Szapar-Mudlaw:
>> From: Jan Glaza <jan.glaza@intel.com>
>>
>> The count field in virtchnl_proto_hdrs and virtchnl_filter_action_set
>> should never be negative while still being valid. Changing it from
>> int to u32 ensures proper handling of values in virtchnl messages in
>> driverrs and prevents unintended behavior.
>> In its current signed form, a negative count does not trigger
>> an error in ice driver but instead results in it being treated as 0.
>> This can lead to unexpected outcomes when processing messages.
>> By using u32, any invalid values will correctly trigger -EINVAL,
>> making error detection more robust.
>>
>> Fixes: 1f7ea1cd6a374 ("ice: Enable FDIR Configure for AVF")
>> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>> Reviewed-by: Simon Horman <horms@kernel.org>
>> Signed-off-by: Jan Glaza <jan.glaza@intel.com>
>> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar- 
>> mudlaw@linux.intel.com>
>> ---
>>   include/linux/avf/virtchnl.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
>> index 4811b9a14604..cf0afa60e4a7 100644
>> --- a/include/linux/avf/virtchnl.h
>> +++ b/include/linux/avf/virtchnl.h
>> @@ -1343,7 +1343,7 @@ struct virtchnl_proto_hdrs {
>>        * 2 - from the second inner layer
>>        * ....
>>        **/
>> -    int count; /* the proto layers must < VIRTCHNL_MAX_NUM_PROTO_HDRS */
>> +    u32 count; /* the proto layers must < VIRTCHNL_MAX_NUM_PROTO_HDRS */
> 
> Why limit the length, and not use unsigned int?
> 

u32 range is completely sufficient for number of proto hdrs (as said: 
"the proto layers must < VIRTCHNL_MAX_NUM_PROTO_HDRS") and I believe it 
is recommended to use fixed sized variables where possible

>>       union {
>>           struct virtchnl_proto_hdr
>>               proto_hdr[VIRTCHNL_MAX_NUM_PROTO_HDRS];
>> @@ -1395,7 +1395,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(36, 
>> virtchnl_filter_action);
>>   struct virtchnl_filter_action_set {
>>       /* action number must be less then VIRTCHNL_MAX_NUM_ACTIONS */
>> -    int count;
>> +    u32 count;
>>       struct virtchnl_filter_action actions[VIRTCHNL_MAX_NUM_ACTIONS];
>>   };
> 
> 
> Kind regards,
> 
> Paul
> 


