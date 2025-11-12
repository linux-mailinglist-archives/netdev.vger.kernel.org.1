Return-Path: <netdev+bounces-237997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E83C5288A
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 14:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 618794FCE64
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 13:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE4233032C;
	Wed, 12 Nov 2025 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JE3wl8vs"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C268132B985;
	Wed, 12 Nov 2025 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954730; cv=none; b=EGfJHSF3nbTIx6/01N/WD91Sl0xDyAk2fAbACPzVg9LPbJ5SI5NwZ8v8pbIFJA0tqnnhkCoZC5OPw3vOapWlmAlQS9L3RAN58R5yDMStxm7L5+d7P7keuxmUSTT2C25tNmFskV8kbvLoA9Ph+MVCiyvhbVSb2ChDYv/YPseipxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954730; c=relaxed/simple;
	bh=926g/bR+ndK1WO8tADmH+kTD2crpUYkExc5CQuLvhr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcmrXZ+Q3uir7G6P61/7H6iZgfkzdxBj/Dppt+u7ZFfZn4dpYNrz9KcbyEDX66ehXX9WbcC+pykU6kfPuxwd+MZ12HzXUOxBBEcPnGZ1LgTjlO3u1LB1oWgAEmlQnPKIdav7fgo/BPf5SuEO4Kmv3CrdIrV70rWH4tZS+sN61oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JE3wl8vs; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7d10e9ac-98b1-4a75-a61a-85a59c8efd86@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762954726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ruMFOcG7D0W9A+6GtEDStFryFcPeoA+waQGsMml5l8=;
	b=JE3wl8vsDZVY8ASV11GDLOFMqgjh8ig4RKSnUQiHu+xnLz4nehI0RnAKax25y+Gn9oN2Ky
	VF0EH5w3gO3f7ap7upwg950W+ZpEk9Z+zwQyDJtpI08Umr2gauXrig6ZFuGXr3xN9y6cmx
	9LvPYojRhtTLF68ftzpMha2VUokAqSo=
Date: Wed, 12 Nov 2025 13:38:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v1 2/7] ptp: ocp: Make ptp_ocp_unregister_ext()
 NULL-aware
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20251111165232.1198222-1-andriy.shevchenko@linux.intel.com>
 <20251111165232.1198222-3-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251111165232.1198222-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/11/2025 16:52, Andy Shevchenko wrote:
> It's a common practice to make resource release functions be NULL-aware.
> Make ptp_ocp_unregister_ext() NULL-aware.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/ptp/ptp_ocp.c | 24 ++++++++++--------------
>   1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 95889f85ffb2..28243fb1d78f 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -2225,6 +2225,9 @@ ptp_ocp_ts_enable(void *priv, u32 req, bool enable)
>   static void
>   ptp_ocp_unregister_ext(struct ptp_ocp_ext_src *ext)
>   {
> +	if (!ext)
> +		return;
> +
>   	ext->info->enable(ext, ~0, false);
>   	pci_free_irq(ext->bp->pdev, ext->irq_vec, ext);
>   	kfree(ext);
> @@ -4558,21 +4561,14 @@ ptp_ocp_detach(struct ptp_ocp *bp)
>   	ptp_ocp_detach_sysfs(bp);
>   	ptp_ocp_attr_group_del(bp);
>   	timer_delete_sync(&bp->watchdog);
> -	if (bp->ts0)
> -		ptp_ocp_unregister_ext(bp->ts0);
> -	if (bp->ts1)
> -		ptp_ocp_unregister_ext(bp->ts1);
> -	if (bp->ts2)
> -		ptp_ocp_unregister_ext(bp->ts2);
> -	if (bp->ts3)
> -		ptp_ocp_unregister_ext(bp->ts3);
> -	if (bp->ts4)
> -		ptp_ocp_unregister_ext(bp->ts4);
> -	if (bp->pps)
> -		ptp_ocp_unregister_ext(bp->pps);
> +	ptp_ocp_unregister_ext(bp->ts0);
> +	ptp_ocp_unregister_ext(bp->ts1);
> +	ptp_ocp_unregister_ext(bp->ts2);
> +	ptp_ocp_unregister_ext(bp->ts3);
> +	ptp_ocp_unregister_ext(bp->ts4);
> +	ptp_ocp_unregister_ext(bp->pps);
>   	for (i = 0; i < 4; i++)
> -		if (bp->signal_out[i])
> -			ptp_ocp_unregister_ext(bp->signal_out[i]);
> +		ptp_ocp_unregister_ext(bp->signal_out[i]);
>   	for (i = 0; i < __PORT_COUNT; i++)
>   		if (bp->port[i].line != -1)
>   			serial8250_unregister_port(bp->port[i].line);
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

