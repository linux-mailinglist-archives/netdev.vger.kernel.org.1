Return-Path: <netdev+bounces-247217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3A9CF5DD4
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 23:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EE9E302A12F
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 22:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909442EC086;
	Mon,  5 Jan 2026 22:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HFAcMs5T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3D11F4180
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767652786; cv=none; b=C/aPpwc0AtWHsRSxb7xcZ7RCpuci2YRIMj4SqqJnO6tJ1Aq7UryFrHSX0tjh/l9Ocebrgb20FLvN8XB1PKpLWj4QEVCI/nVltxAQTxx4W/bTD9RZsOD5tof4nEktfDg1w1H/L9ZUb/EZPXSTczmu80kKWJK3c44rcuBpwUUP5wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767652786; c=relaxed/simple;
	bh=Y/YyKuGAEyuZSeUBg9J3jnSkXBnkFLLiLAiSve8KMIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JbueNvIAxjqN84h1zKR53LL245TlDj/DMS4rZipbRaf+Y3ZoatPO7doOLycnM3OG4MwxgvZT5YV+GnM7OLti10lhtIk9sKDul5rvT8k0PgAFiPJuvb0UUElNrPELYxG11DpXLdQ4mog2DZteuZ/Q0Q+yUNGAqUK9YyD5u4JUM7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HFAcMs5T; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767652785; x=1799188785;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Y/YyKuGAEyuZSeUBg9J3jnSkXBnkFLLiLAiSve8KMIs=;
  b=HFAcMs5T1YPRCbqBpmNc3d6dOOiy/CccOSI6Y+gkBLJANcoTQVGW+qIp
   HiDWHH7fOZJ+Oibxe7sa8SZYkYgKK0WBlmQyAgkpkSbPDvMoGYi1c1vYl
   av6p0lWYUJjWWYc4Fy0En5cVgZKnKNPgBy2zC0/tkwr4wgrObFNnb9+pD
   3877LauejfUZ92bFXUK6A8uAegW7+kgwRZ4tNL4Ss5tqCvFZzhYmXlkXL
   A/qWeM4NAeol5qZVU/MRBhyEOlF5kT04AP2/rCojq+Rh8eOTMsJOZz2zO
   9Hslfx3ukh3vB2Bfl4K7j0W7n12L15GLhkeAw0Yy1Pao0ye75yttxYjvK
   g==;
X-CSE-ConnectionGUID: 5gMY9SdpSmyFk4ACBKwHtg==
X-CSE-MsgGUID: LoBR9nKXQI2tFSzccZqpUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="91678208"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="91678208"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 14:39:44 -0800
X-CSE-ConnectionGUID: wxKxTIrqTpWE/FidL4bAIQ==
X-CSE-MsgGUID: Dbt2w69nQiOrSG+8WJsP2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="207386714"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 14:39:44 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3] igc: Restore default Qbv
 schedule when changing channels
In-Reply-To: <20251120-igc_mqprio_channels-v3-1-ce7d6f00720d@linutronix.de>
References: <20251120-igc_mqprio_channels-v3-1-ce7d6f00720d@linutronix.de>
Date: Mon, 05 Jan 2026 14:39:43 -0800
Message-ID: <87y0mbwuog.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kurt Kanzenbach <kurt@linutronix.de> writes:

> The Multi-queue Priority (MQPRIO) and Earliest TxTime First (ETF) offloads
> utilize the Time Sensitive Networking (TSN) Tx mode. This mode is always
> coupled to IEEE 802.1Qbv time aware shaper (Qbv). Therefore, the driver
> sets a default Qbv schedule of all gates opened and a cycle time of
> 1s. This schedule is set during probe.
>
> However, the following sequence of events lead to Tx issues:
>
>  - Boot a dual core system
>    igc_probe():
>      igc_tsn_clear_schedule():
>        -> Default Schedule is set
>        Note: At this point the driver has allocated two Tx/Rx queues, because
>        there are only two CPUs.
>
>  - ethtool -L enp3s0 combined 4
>    igc_ethtool_set_channels():
>      igc_reinit_queues()
>        -> Default schedule is gone, per Tx ring start and end time are zero
>
>   - tc qdisc replace dev enp3s0 handle 100 parent root mqprio \
>       num_tc 4 map 3 3 2 2 0 1 1 1 3 3 3 3 3 3 3 3 \
>       queues 1@0 1@1 1@2 1@3 hw 1
>     igc_tsn_offload_apply():
>       igc_tsn_enable_offload():
>         -> Writes zeros to IGC_STQT(i) and IGC_ENDQT(i), causing Tx to stall/fail
>
> Therefore, restore the default Qbv schedule after changing the number of
> channels.
>
> Furthermore, add a restriction to not allow queue reconfiguration when
> TSN/Qbv is enabled, because it may lead to inconsistent states.
>
> Fixes: c814a2d2d48f ("igc: Use default cycle 'start' and 'end' values for queues")
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
> Changes in v3:
> - Adjust commit message and comments (Aleksandr)
> - Link to v2: https://lore.kernel.org/r/20251118-igc_mqprio_channels-v2-1-c32563dede2f@linutronix.de
>
> Changes in v2:
> - Explain abbreviations (Aleksandr)
> - Only clear schedule if no error happened (Aleksandr)
> - Add restriction to avoid inconsistent states (Vinicius)
> - Target net tree (Vinicius)
> - Link to v1: https://lore.kernel.org/r/20251107-igc_mqprio_channels-v1-1-42415562d0f8@linutronix.de
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>



Cheers,
-- 
Vinicius

