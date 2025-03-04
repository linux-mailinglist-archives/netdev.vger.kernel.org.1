Return-Path: <netdev+bounces-171638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A33FA4DEF1
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE793A6856
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 13:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E770B204597;
	Tue,  4 Mar 2025 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/69QXM5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBFF2046A7
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093909; cv=none; b=QE0DPBE11IOM20WkbYI+Wx2FixYeEj2a6lnSb7pWUxlLA9/gVErenvNXy1f9bhZG60ljjZ5Vzmn6IfqKG6xMPwnSHUt9oEPgS/0ghOm+voR9NWZEt9hCgBipLiEzcS/c5d3PcSf5FCOscgqZkNsUO5uw//6un+icIPiJQ9Lw5jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093909; c=relaxed/simple;
	bh=Xh5iiVezbe3pvsGK2lbuxPTlq2T8TRg3qVDRZq0aaSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLdYtzMrjijkF7dBCH/ZWYhMOlavwfk7UhjVTwqVbNqWZKnBTBYRhdeFwffHU3BMWQcoZt4S+PvjgrQxjYXYo0GG39aHkqk/oEaT0E6ix57PDAFZrY0aDkcT6QMXDkEXpT2G5RWuaj+IDXK2JoNeitUr082Fhqr5yFvEebM2ogM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I/69QXM5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741093908; x=1772629908;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xh5iiVezbe3pvsGK2lbuxPTlq2T8TRg3qVDRZq0aaSw=;
  b=I/69QXM5hHWL2OkI+UJziLmC7zYqsRHFhNHUBX4RwImdpy9k42gU0V+i
   3xj8lIJiS09418+tjq98KISLysLbp3PgyMukVzkesHOUd2rQZX7WvZ+nU
   n4QYMqo/8sWIvAVr0oUiW4ynQcRjktXENcf3SuepEOXAf73G6miycvcIf
   iYFYX0My50uYxocVqlF3cPgwGKpcuHJhxNqiaORwwUqKUwcuXSxNZUYeV
   742mSYiO22yDkNEzd3Y+75PT3VoGu8MK8GD0jm1Z+A3l8iuWUWr8zULNc
   3AjSeSLlK/2C+3qcK//qcVwJIBc/79HA4YTZ+Bj9S+GK1wfRg+jg6ptbS
   w==;
X-CSE-ConnectionGUID: 1bOLLzpATAmY65uYWKj55g==
X-CSE-MsgGUID: lXYYW45nRd25OMZbae5hVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59422788"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="59422788"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 05:11:48 -0800
X-CSE-ConnectionGUID: Hp5g01T4RD2aay6dqcLwxw==
X-CSE-MsgGUID: Ahb3pMS+SbSmMLnzntTlQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118379435"
Received: from mszapar-mobl1.ger.corp.intel.com (HELO [10.245.99.188]) ([10.245.99.188])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 05:11:45 -0800
Message-ID: <e384e61a-4ccd-4ae7-8ddd-66259769f6dd@linux.intel.com>
Date: Tue, 4 Mar 2025 14:11:42 +0100
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
 Simon Horman <horms@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20250304110833.95997-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250304110833.95997-4-martyna.szapar-mudlaw@linux.intel.com>
 <9f6b830f-d2ee-4fde-a131-a956a6e84df7@molgen.mpg.de>
 <00a160e5-c9b2-4b91-9823-dee37fdc5d25@linux.intel.com>
 <832cc2a5-0c15-42d1-924b-a14674db6391@molgen.mpg.de>
Content-Language: en-US
From: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>
In-Reply-To: <832cc2a5-0c15-42d1-924b-a14674db6391@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/4/2025 12:51 PM, Paul Menzel wrote:
> Dear Martyna,
> 
> 
> Thank you for your quick reply.
> 
> Am 04.03.25 um 12:45 schrieb Szapar-Mudlaw, Martyna:
> 
>> On 3/4/2025 12:15 PM, Paul Menzel wrote:
> 
>>> Am 04.03.25 um 12:08 schrieb Martyna Szapar-Mudlaw:
>>>> From: Jan Glaza <jan.glaza@intel.com>
>>>>
>>>> The count field in virtchnl_proto_hdrs and virtchnl_filter_action_set
>>>> should never be negative while still being valid. Changing it from
>>>> int to u32 ensures proper handling of values in virtchnl messages in
>>>> driverrs and prevents unintended behavior.
>>>> In its current signed form, a negative count does not trigger
>>>> an error in ice driver but instead results in it being treated as 0.
>>>> This can lead to unexpected outcomes when processing messages.
>>>> By using u32, any invalid values will correctly trigger -EINVAL,
>>>> making error detection more robust.
>>>>
>>>> Fixes: 1f7ea1cd6a374 ("ice: Enable FDIR Configure for AVF")
>>>> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>>>> Reviewed-by: Simon Horman <horms@kernel.org>
>>>> Signed-off-by: Jan Glaza <jan.glaza@intel.com>
>>>> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar- 
>>>> mudlaw@linux.intel.com>
>>>> ---
>>>>   include/linux/avf/virtchnl.h | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/ 
>>>> virtchnl.h
>>>> index 4811b9a14604..cf0afa60e4a7 100644
>>>> --- a/include/linux/avf/virtchnl.h
>>>> +++ b/include/linux/avf/virtchnl.h
>>>> @@ -1343,7 +1343,7 @@ struct virtchnl_proto_hdrs {
>>>>        * 2 - from the second inner layer
>>>>        * ....
>>>>        **/
>>>> -    int count; /* the proto layers must < 
>>>> VIRTCHNL_MAX_NUM_PROTO_HDRS */
>>>> +    u32 count; /* the proto layers must < 
>>>> VIRTCHNL_MAX_NUM_PROTO_HDRS */
>>>
>>> Why limit the length, and not use unsigned int?
>>
>> u32 range is completely sufficient for number of proto hdrs (as said: 
>> "the proto layers must < VIRTCHNL_MAX_NUM_PROTO_HDRS") and I believe 
>> it is recommended to use fixed sized variables where possible
> 
> Do you have a pointer to the recommendation? I heard the opposite, that 
> fixed length is only useful for register writes. Otherwise, you should 
> use the “generic” types [1].

Thanks for sharing the source and your perspective, you are right, as a 
general rule, using generic types is preferred - I actually learned 
something new from this.
That said, I still believe there are exceptions, and in this case, using 
u32 is the right choice. When dealing with protocols or data formats 
using a fixed-width type makes sense.
Additionally, throughout this file, we consistently use u32/u16 for 
similar cases, so also here we're keeping it aligned with the existing 
codebase.
Thank you for your review and appreciate the discussion on best practices.

Regards,
Martyna

> 
>>>>       union {
>>>>           struct virtchnl_proto_hdr
>>>>               proto_hdr[VIRTCHNL_MAX_NUM_PROTO_HDRS];
>>>> @@ -1395,7 +1395,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(36, 
>>>> virtchnl_filter_action);
>>>>   struct virtchnl_filter_action_set {
>>>>       /* action number must be less then VIRTCHNL_MAX_NUM_ACTIONS */
>>>> -    int count;
>>>> +    u32 count;
>>>>       struct virtchnl_filter_action actions[VIRTCHNL_MAX_NUM_ACTIONS];
>>>>   };
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: https://notabs.org/coding/smallIntsBigPenalty.htm
> 


