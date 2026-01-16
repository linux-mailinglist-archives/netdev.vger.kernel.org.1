Return-Path: <netdev+bounces-250652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0E9D3882A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 22:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EB0C3033BA5
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 21:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8BA2E54BB;
	Fri, 16 Jan 2026 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="E57lSS+u"
X-Original-To: netdev@vger.kernel.org
Received: from mx13lb.world4you.com (mx13lb.world4you.com [81.19.149.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E864D2EDD57
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768597913; cv=none; b=ZVuT/z/W6D9cl7m1J+S5L/8VhZK3vbuDXtGRyKCQdRy4WLN6XVJZ0je67nM1cPNZkIoQLLlVe/0LcFOwe9XuXsjfvMDyjiPixozdINWhH3JtOMfjL+fBPIWILK98X4JaPjE+0hvoydiZstTH5BZ8IDh1utRXOFR/F69D0z/Uyf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768597913; c=relaxed/simple;
	bh=SqpG767PvAtkO+NgiKh9fJn8Bu+uwI3P4e5M3Qj2Yjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKcTkWVSJ6BRfea+KDgfTA3Vi0NcEhxAD8sS381+O1yczuGV8sPx7pBVy8T1rGEYJqxW8cdt1QTKAdvjIBYwE/WsTnUVdsKrpT2GC31bJ9yqVNhOfYM3QR7wvuD7vJZEkHyKxSKASP3n0cWiyfo7RIG6TukzwjHSLhcxszb3K5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=E57lSS+u; arc=none smtp.client-ip=81.19.149.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/Of2aHDnBQYvimcONCrRSPr6lc/3qw1kcepp5pGhxuQ=; b=E57lSS+uCc/5Z2GOQfxhY5ZtHE
	L/qkPh+jfTweI3CGh0h4lfgYn0yVbz65lphe8kPm2UsObMSyWYbrN3ZOt2x+DqKVAIKUi92GScCnH
	e6WF9JfRwGV5CjOS3OrTg2XtZdxAQJgyo/60gthIX5FNjRtfEe6sw69RRIIWg44OARVA=;
Received: from [188.23.33.245] (helo=[10.0.0.160])
	by mx13lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vgqYC-000000000jR-3Qst;
	Fri, 16 Jan 2026 21:36:09 +0100
Message-ID: <88efe7ae-7ffd-4088-a81c-b3761bd1ac20@engleder-embedded.com>
Date: Fri, 16 Jan 2026 21:36:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: extend ndo_get_tstamp for other
 timestamp types
To: Kevin Yang <yyd@google.com>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Joshua Washington <joshwash@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Willem de Bruijn <willemb@google.com>
References: <20260115222300.1116386-1-yyd@google.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20260115222300.1116386-1-yyd@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 15.01.26 23:22, Kevin Yang wrote:
> Network device hardware timestamps (hwtstamps) and the system's
> clock (ktime) often originate from different clock domains.
> This makes it hard to directly calculate the duration between
> a hardware-timestamped event and a system-time event by simple
> subtraction.
> 
> This patch extends ndo_get_tstamp to allow a netdev to provide
> a hwtstamp into the system's CLOCK_REALTIME domain. This allows a
> driver to either perform a conversion by estimating or, if the
> clocks are kept synchronized, return the original timestamp directly.
> Other clock domains, e.g. CLOCK_MONOTONIC_RAW can also be added when
> a use surfaces.
> 
> This is useful for features that need to measure the delay between
> a packet's hardware arrival/departure and a later software event.
> For example, the TCP stack can use this to measure precise
> packet receive delays, which is a requirement for the upcoming
> TCP Swift [1] congestion control algorithm.
> 
> [1] Kumar, Gautam, et al. "Swift: Delay is simple and effective
> for congestion control in the datacenter." Proceedings of the
> Annual conference of the ACM Special Interest Group on Data
> Communication on the applications, technologies, architectures,
> and protocols for computer communication. 2020.
> 
> Signed-off-by: Kevin Yang <yyd@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
>   drivers/net/ethernet/engleder/tsnep_main.c |  8 +++++---
>   drivers/net/ethernet/intel/igc/igc_main.c  |  8 +++++---
>   include/linux/netdevice.h                  | 21 ++++++++++++++-------
>   3 files changed, 24 insertions(+), 13 deletions(-)
>


...

>   
> +enum netdev_tstamp_type {
> +	NETDEV_TSTAMP_RAW = 0,
> +	NETDEV_TSTAMP_CYCLE,
> +	NETDEV_TSTAMP_REALTIME,
> +};

Would it make sense to document the types? By your change of the
ndo_get_tstamp() documentation below, the info that cycles is
about a free running cycle counter is lost.

IMO the name RAW for the timestamp of the adjustable physical clock is
not a good fit, because NETDEV_TSTAMP_CYCLE is more raw (not adjustable)
than NETDEV_TSTAMP_RAW (adjustable). Maybe NETDEV_TSTAMP_PHC instead of
NETDEV_TSTAMP_RAW?

If I understand your second patch correctly, then NETDEV_TSTAMP_REALTIME
can provide a timestamp with low accuracy, which can even jump backwards
(a later received package can get an earlier timestamp due to the simple
synchronisation in gve_hwts_realtime_update). Should the expected
quality of the timestamps be documented here?

> +
>   /*
>    * This structure defines the management hooks for network devices.
>    * The following hooks can be defined; unless noted otherwise, they are
> @@ -1406,11 +1412,10 @@ struct netdev_net_notifier {
>    *     Get the forwarding path to reach the real device from the HW destination address
>    * ktime_t (*ndo_get_tstamp)(struct net_device *dev,
>    *			     const struct skb_shared_hwtstamps *hwtstamps,
> - *			     bool cycles);
> - *	Get hardware timestamp based on normal/adjustable time or free running
> - *	cycle counter. This function is required if physical clock supports a
> - *	free running cycle counter.
> - *
> + *			     enum netdev_tstamp_type type);
> + *	Get hardware timestamp based on the type requested, or return 0 if the
> + *	requested type is not supported. This function is required if physical
> + *	clock supports a free running cycle counter.

...

Gerhard

