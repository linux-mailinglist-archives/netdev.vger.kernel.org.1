Return-Path: <netdev+bounces-304990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w8+rJ5yWS2o5WAEAu9opvQ
	(envelope-from <netdev+bounces-304990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:50:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DCD710167
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:50:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Q6iR7Mfr;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304990-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304990-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAE6F30449E6
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 11:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A4941F7FD;
	Mon,  6 Jul 2026 11:43:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B96A41F7CA
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 11:43:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338187; cv=none; b=DyT0z93qFEvcWqKX05Q4uGNzWZ15fXG40KNweEYuBBiaWIlAOcW4+NVE2xXZnMHhoMbZ1kJGdSOJmU+9zP5dN09GN7vcHbFrFSNGpBLhzAqnqaGGGnlGyGfKmOLNb/v+ucHrBNTJ8JiEb0z3rBMMCPi9nGuJMFmAQP0BRPOrvjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338187; c=relaxed/simple;
	bh=a06xVfWa6SYvsmjjp2HOBGrgbWN4UUlrbTQI3T0FOv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYSZpwNj5zRydFgqhMz/8SKY4EKtPwDi95vgqBKzVT4tdPeL1+WryjfCNLEkMn0Rjkd2pFXMr+yAI8qAi1mvU424Cg7W6NZpQWpMdVUoqwM7aPOcDz0+JnKAUG0l7mhp7glzNaYInZREHiNT/1mjZ/xOV6oQKl2UbXBQ0lDlN6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q6iR7Mfr; arc=none smtp.client-ip=91.218.175.170
Message-ID: <65c049ee-4209-4c35-aff4-c4c42f92bb33@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783338183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxlHQiawq1DpmHOF5r6CC4nEYAVd/3tojFp0FBDS7Zs=;
	b=Q6iR7Mfr0Ek5CwrYEqLK86PKUnmjE8LIhC/ZZLwNSOs+apqq0smVAN2J0kHEAD0u7ECEzl
	MgOpqzkQC5mrQsj0utdXT9Z+LGnFyOUyXkWkHMmaTy0tOgFbaWuLZQBXKzNzxbYKN/eyoC
	FZxbZoqyibu35AnddpuE0+lzbjF0B+0=
Date: Mon, 6 Jul 2026 12:43:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ptp: netc: explicitly clear TMR_OFF during
 initialization
To: wei.fang@oss.nxp.com, richardcochran@gmail.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Frank.Li@nxp.com
Cc: netdev@vger.kernel.org, imx@lists.linux.dev, wei.fang@nxp.com
References: <20260706081232.3661826-1-wei.fang@oss.nxp.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260706081232.3661826-1-wei.fang@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304990-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:wei.fang@oss.nxp.com,m:richardcochran@gmail.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Frank.Li@nxp.com,m:netdev@vger.kernel.org,m:imx@lists.linux.dev,m:wei.fang@nxp.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[oss.nxp.com,gmail.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19DCD710167

On 06/07/2026 09:12, wei.fang@oss.nxp.com wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
> 
> The NETC timer does not support function level reset, so TMR_OFF_L/H
> registers are not cleared by pcie_flr(). If TMR_OFF was set to a
> non-zero value in a previous binding, it will persist across driver
> rebind and cause inaccurate PTP time.
> 
> There is also a hardware issue: after a warm reset or soft reset,
> TMR_OFF_L/H registers appear to be cleared to zero, but the timer clock
> domain internally retains the stale value. When the timer is re-enabled,
> TMR_CUR_TIME continues to track the old offset until TMR_OFF is written
> explicitly. This can cause incorrect PTP timestamps and even PTP clock
> synchronization failures.
> 
> Per the recommendation from the IP team, explicitly write 0 to TMR_OFF
> in netc_timer_init() to flush the internally cached value and ensure
> TMR_CUR_TIME follows the freshly initialized counter.
> 
> Fixes: 87a201d59963 ("ptp: netc: add NETC V4 Timer PTP driver support")
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>   drivers/ptp/ptp_netc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> index 94e952ee6990..5e381c354d74 100644
> --- a/drivers/ptp/ptp_netc.c
> +++ b/drivers/ptp/ptp_netc.c
> @@ -779,6 +779,7 @@ static void netc_timer_init(struct netc_timer *priv)
>   	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
>   	netc_timer_wr(priv, NETC_TMR_ECTRL, NETC_TMR_DEFAULT_ETTF_THR);
>   
> +	netc_timer_offset_write(priv, 0);
>   	ktime_get_real_ts64(&now);
>   	ns = timespec64_to_ns(&now);
>   	netc_timer_cnt_write(priv, ns);

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

