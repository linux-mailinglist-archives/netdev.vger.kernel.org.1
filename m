Return-Path: <netdev+bounces-47081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBDA7E7BAE
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 12:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F207BB20AFD
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B69514295;
	Fri, 10 Nov 2023 11:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZnCSgE89"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C4410A09
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 11:06:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C336F2B799;
	Fri, 10 Nov 2023 03:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699614364; x=1731150364;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jSjaIeYVLujogtgrUxKvwBz6mq9OFmFnD9WaBUQ1vwE=;
  b=ZnCSgE89Sc+IflHBpkzoHpbnJZnHR7WHNsUFESslJ8Zeb9ujeB7Hn/1S
   2IXnWa1VmQjHjM8BpFyO4vZ8MGXqqQDnKEwmhDpXmNLuhaMBp95Inhx2R
   U8Meo5ipTa2CCG3YMJ+ByJxNWwvsRH0JNMOzodDfKaba4lGNSvQugdV1O
   lEkhiSMetPMreh4+V9QtLzVQlsgvIhmVU+4fk5vGqzr2/YDpEOYMzU4dp
   787WhKBUO4jLvxneFcDyGGjG4qF596HjEvnC6XGK8lM5dWUap8+S2ybaT
   8uiFNM/xXuqa/bgnYkH4nG1W3yH6UcLe2CQzVWeaJXH22OKxt3P2nr0B5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="421263017"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="421263017"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 03:06:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="880940762"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="880940762"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.215.255.120]) ([10.215.255.120])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 03:06:00 -0800
Message-ID: <7df1364d-c327-4053-8219-f267c2e8aeea@linux.intel.com>
Date: Fri, 10 Nov 2023 19:06:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 0/7] qbv cycle time extension/truncation
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231108155144.xadpltcdw2rhdpkv@skbuf>
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20231108155144.xadpltcdw2rhdpkv@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/11/2023 11:51 pm, Vladimir Oltean wrote:
> Hi Faizal,
> 
> On Tue, Nov 07, 2023 at 06:20:16AM -0500, Faizal Rahim wrote:
>> According to IEEE Std. 802.1Q-2018 section Q.5 CycleTimeExtension,
>> the Cycle Time Extension variable allows this extension of the last old
>> cycle to be done in a defined way. If the last complete old cycle would
>> normally end less than OperCycleTimeExtension nanoseconds before the new
>> base time, then the last complete cycle before AdminBaseTime is reached
>> is extended so that it ends at AdminBaseTime.
>>
>> Changes in v2:
>>
>> - Added 's64 cycle_time_correction' in 'sched_gate_list struct'.
>> - Removed sched_changed created in v1 since the new cycle_time_correction
>>    field can also serve to indicate the need for a schedule change.
>> - Added 'bool correction_active' in 'struct sched_entry' to represent
>>    the correction state from the entry's perspective and return corrected
>>    interval value when active.
>> - Fix cycle time correction logics for the next entry in advance_sched()
>> - Fix and implement proper cycle time correction logics for current
>>    entry in taprio_start_sched()
>>
>> v1 at:
>> https://lore.kernel.org/lkml/20230530082541.495-1-muhammad.husaini.zulkifli@intel.com/
> 
> I like what came of this patch series. Thanks for following up and
> taking over. I have some comments on individual patches.
> 

Hi Vladimir,

Thanks a bunch for your review and your patience with some of my basic 
mistakes.
Appreciate the time and effort you put into it.
I'll take a bit to double-check the code and retest some stuff.

Will loop back with you soon.

Cheers.

