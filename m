Return-Path: <netdev+bounces-198895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39432ADE3C7
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 08:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9623AB727
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 06:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3851891AB;
	Wed, 18 Jun 2025 06:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tf9LoSL/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFEC1EEA40
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 06:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750228534; cv=none; b=jf8wtcUFBaFm65Yn4oBg/MH+Quc+iPwhi8H9RkfDnRCyAeLGVwC8g4P9E8blR3WDM9B02M7BfXjb2OqxqR1dWfkq/MRoRKU4kgvXML19W7OW3imvU1z1L5+MFBljyuwsOeYH1XqNxnkh0HWBOUXi2fBjvkBxrBDYQ0NIcY42G3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750228534; c=relaxed/simple;
	bh=aU27uou+GwvbZ3l+3mHzxna6LubemKb6KHdTutkk27I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rUhre8geQTJ83qEDwmbfIznO5wvcRPeWPr2LPBlTC0sBfnAL9zCjI88i8KdARhTHXYG87fJcaQC2s347759LiLuL+amc7JX8Fsh7HtphQ3JyqYweNjsefzvgWIzm6MFMd5TKOae777tO7B88hvXZARsZ2C8VILcJ2f7Xb1/vxb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tf9LoSL/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750228533; x=1781764533;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aU27uou+GwvbZ3l+3mHzxna6LubemKb6KHdTutkk27I=;
  b=Tf9LoSL/umwp7H9ppG9b20Ig0NLfoblBC9IjKAK7/t9XXUq32kyb2Au0
   4JgqTkmJO4gfjKpsbWQVRYTOlpmniJjIhYrvGqONaWc4xEQvlianqqc/J
   V8wvYxDgMzSeOyKAFOhzXR/8sGFL7zi1thBbnDD6vcIz7ENFbMMlhuoLS
   BV0//pUSV7uv91LjLxf5EEaFrAOHcOB5V3jI7Lc+ivsBdYPikB/MtWobi
   TSMmEC+V519u27OZ2ThZlbXMLZBdtPMZe+a2glc/510fCOce8TfqcBlkl
   SyP6GdP4HlbpM+7IkfMsM+8Oi5oJBb+iaxke5fz7w3cWdVXtOqEqw9He/
   g==;
X-CSE-ConnectionGUID: C0WjY9kgQheisSzqpnbuXw==
X-CSE-MsgGUID: MloO7DBxS0CRhAgAZr9kQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="74964348"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="74964348"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 23:35:32 -0700
X-CSE-ConnectionGUID: E+BkApjYRxG+wFCM6wmLJQ==
X-CSE-MsgGUID: wYKmSwshRGqNe23ihUYBeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="172612510"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.50.4]) ([10.247.50.4])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 23:35:28 -0700
Message-ID: <3e458cbe-a251-4f25-b264-6d1d441604c7@linux.intel.com>
Date: Wed, 18 Jun 2025 14:35:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/7] igc: add private flag to reverse TX queue
 priority in TSN mode
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, faizal.abdul.rahim@intel.com,
 chwee.lin.choong@intel.com, horms@kernel.org, vitaly.lifshits@intel.com,
 dima.ruinskiy@intel.com, Mor Bar-Gabay <morx.bar.gabay@intel.com>,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, kuba@kernel.org
References: <20250611180314.2059166-1-anthony.l.nguyen@intel.com>
 <20250611180314.2059166-6-anthony.l.nguyen@intel.com>
 <26b0a6cd-9f2c-487a-bb7a-d648993b8725@redhat.com>
 <20250617121742.64no35fvb2bbnppf@skbuf>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20250617121742.64no35fvb2bbnppf@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Vladimir,

Thanks for your feedback.

On 17/6/2025 8:17 pm, Vladimir Oltean wrote:
> Hi Paolo,
> 
> On Tue, Jun 17, 2025 at 12:06:14PM +0200, Paolo Abeni wrote:
>> On 6/11/25 8:03 PM, Tony Nguyen wrote:
>>> To harmonize TX queue priority behavior between taprio and mqprio, and
>>> to fix these issues without breaking long-standing taprio use cases,
>>> this patch adds a new private flag, called reverse-tsn-txq-prio, to
>>> reverse the TX queue priority. It makes queue 3 the highest and queue 0
>>> the lowest, reusing the TX arbitration logic already used by mqprio.
>> Isn't the above quite the opposite of what Vladimir asked in
>> https://lore.kernel.org/all/20250214113815.37ttoor3isrt34dg@skbuf/ ?
>>
>> """
>> I would expect that for uniform behavior, you would force the users a
>> little bit to adopt the new TX scheduling mode in taprio, otherwise any
>> configuration with preemptible traffic classes would be rejected by the
>> driver.
>> """
>>
>> I don't see him commenting on later version, @Vladimir: does this fits you?
> 
> Indeed, sorry for disappearing from the patch review process.
> 
> I don't see the discrepancy between what Faizal implemented and what we
> discussed. Specifically on the bit you quoted - patch "igc: add
> preemptible queue support in taprio" refuses taprio schedules with
> preemptible TCs if the user hasn't explicitly opted into
> IGC_FLAG_TSN_REVERSE_TXQ_PRIO. If that private flag isn't set,
> everything works as currently documented, just the new features are
> gated.
> 
> The name of the private flag is debatable IMHO, because it's taprio
> specific and the name doesn't reflect that (mqprio uses the "reverse"
> priority assignment to TX queues by default, and this flag doesn't
> change that). Also, "reverse" compared to what? Both operating modes can
Compared to the default Tx queue priority in TSN mode, where Tx q0 has the 
highest priority and q3 the lowest. My thinking behind the naming was based 
on how the relevant register fields are configured.

Snippet of i226 documentation:
"While in TSN mode each transmit queue is assigned a priority level by the 
TxQ_Priority fields in the TxARB register"
"TxQ_Priority_0: The transmit queue that is assigned as priority 0 (highest 
priority). Default is queue 0"
"TxQ_Priority_3: The transmit queue that is assigned as priority 3 (lowest 
priority). Default is queue 3."

> equally be named "reverse". 
True —  mqprio already uses the reverse mapping by default even without 
this private flag, which could feel inconsistent.

> Maybe "taprio-standard-txq-priority" would
> have been clearer regarding what the flag really does.
I’m okay with that suggestion, though I’m not sure it makes things clearer. 
What’s considered “standard” may depend on context — for IGC users who 
haven’t worked with other NICs, the existing default priority mapping might 
feel like the standard. I’m definitely in favor of improving readability 
and maintenance, but I’m still unsure what name best reflects that balance.


