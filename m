Return-Path: <netdev+bounces-238146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A21FC54A47
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 22:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 885E2341BA5
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 21:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4672E22BA;
	Wed, 12 Nov 2025 21:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PhDS0fOT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008772D6E76
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762983727; cv=none; b=imZFOA/JHww2MOxnMoSVCCgxH+/u8Fb1zqjEZLollhgS/uYyl6rvcV2kCfHZI793PxQPgG+Jt9NzXWSEcl3XyPA1sHcyS4nTGIheYX4VHtar5jrpoh72J04XzyO40kcOQOKSs0vQuWwgD6QfkXZoY/liGZKBxZBVPtV492VL49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762983727; c=relaxed/simple;
	bh=nuB61kww3NYzARmWzyj3/JWtL1K+5aUzT9fCLeONkXM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H1rvNbbh5maqZLQSo+gpHtJu3HSvcyC636c7rJxWJk6Qdpa28zMIeNCM3bFH1mqgumNgNStMAOXf8hqhDfhvDUotMuu5ZD0w+OgIKM2zdkTQiUgKluzGj+2Rbqi2wKUvGGa2K5xhJJs4E30KmwEhUd6OIDRyL4fMilcjssXavGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PhDS0fOT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762983726; x=1794519726;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=nuB61kww3NYzARmWzyj3/JWtL1K+5aUzT9fCLeONkXM=;
  b=PhDS0fOT4DHjTb0Y1lJyJrpZTJEMTRmC7Lbha4y71l96i38+rAg2+pCv
   cOkx2au1/G04BkmAX42ZtaKZ/rwg/wWm8PiR9jPgQaxpQ++SLSSamEB4D
   yykr/ikrGxgFfKlEtAhkJcxkeLFNEl2cRA9FG13Ok+I7QZgPn3r8chxsG
   zABN9D+1M09Kc6tytqPMVXf+QiPmfawKe5DjJxKD08bWrCjGG+ekrDDgZ
   63fDmQRp2NJTVqk4fZ+UAu8nQANbG7VO7782TlX+pD84E1WgCXCyz3+r1
   HUMnSp7dwvE3Y8oRhbG+gxsdYrwtf/18R8LlG3lBl4hoGeuT5LMPIph7h
   w==;
X-CSE-ConnectionGUID: GCfc7daaQW+mq0cxWxx6wQ==
X-CSE-MsgGUID: ZH7XyIGnQzCd5Mgs1HiqAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="68690802"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="68690802"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 13:42:06 -0800
X-CSE-ConnectionGUID: pDCoAjLJS8S/Rxb6WZ+AUA==
X-CSE-MsgGUID: 93od+bRgTFWGXIxSQcb8rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="189183119"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.140])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 13:42:05 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>
Subject: Re: [PATCH iwl-next] igc: Restore default Qbv schedule when
 changing channels
In-Reply-To: <20251107-igc_mqprio_channels-v1-1-42415562d0f8@linutronix.de>
References: <20251107-igc_mqprio_channels-v1-1-42415562d0f8@linutronix.de>
Date: Wed, 12 Nov 2025 13:42:06 -0800
Message-ID: <87ldkblyhd.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Kurt Kanzenbach <kurt@linutronix.de> writes:

> The MQPRIO (and ETF) offload utilizes the TSN Tx mode. This mode is always
> coupled to Qbv. Therefore, the driver sets a default Qbv schedule of all gates
> opened and a cycle time of 1s. This schedule is set during probe.
>
> However, the following sequence of events lead to Tx issues:
>
>  - Boot a dual core system
>    probe():
>      igc_tsn_clear_schedule():
>        -> Default Schedule is set
>        Note: At this point the driver has allocated two Tx/Rx queues, because
>        there are only two CPU(s).
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
>         -> Writes zeros to IGC_STQT(i) and IGC_ENDQT(i) -> Boom
>
> Therefore, restore the default Qbv schedule after changing the amount of
> channels.
>

Couple of questions:
 - Would it make sense to mark this patch as a fix?

 - What would happen if the user added a Qbv schedule (not the default
   one) and then changed the number of queues? My concern is that 'tc
   qdisc' would show the custom user schedule and the hardware would be
   "running" the default schedule, this inconsistency is not ideal. In
   any case, it would be a separate patch.


> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 728d7ca5338bf27c3ce50a2a497b238c38cfa338..e4200fcb2682ccd5b57abb0d2b8e4eb30df117df 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -7761,6 +7761,8 @@ int igc_reinit_queues(struct igc_adapter *adapter)
>  	if (netif_running(netdev))
>  		err = igc_open(netdev);
>  
> +	igc_tsn_clear_schedule(adapter);
> +
>  	return err;
>  }
>  
>
> ---
> base-commit: 6fc33710cd6c55397e606eeb544bdf56ee87aae5
> change-id: 20251107-igc_mqprio_channels-2329166e898b
>
> Best regards,
> -- 
> Kurt Kanzenbach <kurt@linutronix.de>
>


Cheers,
-- 
Vinicius

