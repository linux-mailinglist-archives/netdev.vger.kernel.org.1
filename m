Return-Path: <netdev+bounces-238467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 520F9C596A8
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 19:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C68DC506CEA
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37E21E285A;
	Thu, 13 Nov 2025 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KtNR02rl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539181FC0EA
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763054567; cv=none; b=Fm+adcvWQnma00cd8p7LAGRl5WcZdcBtAHIs01mykNPrZdQc63fdTW8OwE2zuwEbDz0o4eRVqV6odZLRSa5EkPN4PulOfmpbolem4gy9i2X6garj65zPJ3Q7wycngJv8ieQvclu7F5DzmrcQicnsacRjUaYbNfZFHH3EYWDGWjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763054567; c=relaxed/simple;
	bh=MdYfZqAAfI9UhZo7IuK3PHUM5hvs8ciQVUC6Vr0MK90=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ujz9LuU8DNbQNNJAjKa1LJH1qnvpa/Do1U9qujBRXj7pp1rBXuyUtyNauc5YtCYYUAHvA6e2hsY79NFJ+DPG+2nC523YrM3w8cU9djhm4fbo4UaDNavByyhyyXGMkrGlAjq9e/OvHOutw7oxcZYXKw72kQyvb1pkftR3AlHw3Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KtNR02rl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763054566; x=1794590566;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=MdYfZqAAfI9UhZo7IuK3PHUM5hvs8ciQVUC6Vr0MK90=;
  b=KtNR02rlxSz9aiXkguDe+1huxw861JjxO39013qFvq0G+AdkELlfASCb
   MB6yq4m6S7ysEupPwHVJIbIqd+657JrP5p9IVRvXpLuZoE211EIhT64eC
   /JX36QYp7v6pqDmxQzaJyeCZx34jGh5LXqrhMlby57eiY6SHuTgsNfP+0
   VSxyWDLNQR7Ffl5PvYcNsvb45YiCM4aemcNLCsZlbjkeTG0SKUrJS71Q4
   z6HNQ44LGcJkbT5XYBS1Ek+Mxu5gNf0McBZ3+J0SEGTH3RfCdoIA3LIgv
   YSO6SedSe7soFLUS0Znm61aR2cHqdk4rDpncFOMrUz2YwhX+qiRMCs22+
   Q==;
X-CSE-ConnectionGUID: kzet9P4LS5GXd5M4jBBRgA==
X-CSE-MsgGUID: mIMkw8igQLeupbTP/Orfdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="90621016"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="90621016"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 09:22:46 -0800
X-CSE-ConnectionGUID: KGfI05O1Qk6pC7jk7wmDHA==
X-CSE-MsgGUID: bOpJib/jReq0+a1qsf5Clw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="212957758"
Received: from vverma7-desk1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.125.108.134])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 09:22:45 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next] igc: Restore default Qbv schedule when
 changing channels
In-Reply-To: <87bjl6l3j5.fsf@jax.kurt.home>
References: <20251107-igc_mqprio_channels-v1-1-42415562d0f8@linutronix.de>
 <87ldkblyhd.fsf@intel.com> <87bjl6l3j5.fsf@jax.kurt.home>
Date: Thu, 13 Nov 2025 09:22:44 -0800
Message-ID: <871pm126fv.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kurt Kanzenbach <kurt@linutronix.de> writes:

> On Wed Nov 12 2025, Vinicius Costa Gomes wrote:
>> Hi,
>>
>> Kurt Kanzenbach <kurt@linutronix.de> writes:
>>
>>> The MQPRIO (and ETF) offload utilizes the TSN Tx mode. This mode is always
>>> coupled to Qbv. Therefore, the driver sets a default Qbv schedule of all gates
>>> opened and a cycle time of 1s. This schedule is set during probe.
>>>
>>> However, the following sequence of events lead to Tx issues:
>>>
>>>  - Boot a dual core system
>>>    probe():
>>>      igc_tsn_clear_schedule():
>>>        -> Default Schedule is set
>>>        Note: At this point the driver has allocated two Tx/Rx queues, because
>>>        there are only two CPU(s).
>>>
>>>  - ethtool -L enp3s0 combined 4
>>>    igc_ethtool_set_channels():
>>>      igc_reinit_queues()
>>>        -> Default schedule is gone, per Tx ring start and end time are zero
>>>
>>>   - tc qdisc replace dev enp3s0 handle 100 parent root mqprio \
>>>       num_tc 4 map 3 3 2 2 0 1 1 1 3 3 3 3 3 3 3 3 \
>>>       queues 1@0 1@1 1@2 1@3 hw 1
>>>     igc_tsn_offload_apply():
>>>       igc_tsn_enable_offload():
>>>         -> Writes zeros to IGC_STQT(i) and IGC_ENDQT(i) -> Boom
>>>
>>> Therefore, restore the default Qbv schedule after changing the amount of
>>> channels.
>>>
>>
>> Couple of questions:
>>  - Would it make sense to mark this patch as a fix?
>
> This only happens if a user uses ETF or MQPRIO and a dual/single core
> system. So I didn't see the need to mark it as a fix.
>

I still think this is fix material. People can always run stuff in VMs,
and it makes it easier to have single/dual core systems.

>>
>>  - What would happen if the user added a Qbv schedule (not the default
>>    one) and then changed the number of queues? My concern is that 'tc
>>    qdisc' would show the custom user schedule and the hardware would be
>>    "running" the default schedule, this inconsistency is not ideal. In
>>    any case, it would be a separate patch.
>
> Excellent point. Honestly I'm not sure what to expect when changing the
> number of queues after a user Qbv schedule is added. For MQPRIO we added
> a restriction [1] especially for that case. I'm leaning towards the same
> solution here. What do you think?

Sounds great. Avoiding getting into inconsistent states is better than
trying to fix it later.

>
> Thanks,
> Kurt
>
> [1] - https://elixir.bootlin.com/linux/v6.18-rc5/source/drivers/net/ethernet/intel/igc/igc_ethtool.c#L1564


Cheers,
-- 
Vinicius

