Return-Path: <netdev+bounces-170346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB13A48485
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21CB63A87FA
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D63526FDBE;
	Thu, 27 Feb 2025 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f1xRBVY9"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110CB26FDAE
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672395; cv=none; b=q4KhLMg8kPbSBMsgUf5jQDC8O7wMKXk8OKl8qCYYvSF9AgCzELd04QQ3v2qiC4L8guPq7O7UoVOtp0JT1yY75q/4tG6+QD/XPB1nZEb8rDWRkAlZvFKqWyCL1jfNw5cqWmcLff+8M7xp5K59npI9nYffTJElbViRQlDsl/PICYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672395; c=relaxed/simple;
	bh=o96Sirk3ffuovk8cGsC+wDWcIqGhIk+HB9ekzloHdZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=raIvAxiunJrLJJehc/hlzla/LTNiyZWu9XlCTmqJksQGr43WHEWNuRaszmdBNLInFEvl5xsJCEGgJYEaGQtK/xB8DQnOQLnglWOK9+V8Qajgr3f0W1SexOvhKTou4XyJfq2KKTJyhDOM3VUBv8Pllry3d5mC546c33gyscjmhWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f1xRBVY9; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <542018d4-ded1-40c6-9a97-d3789877b771@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740672380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlwRt4wQ2xFVKA1gnOfel5WpP6ziq3DqOeLOcmYMfaQ=;
	b=f1xRBVY9kC5vW0Jmevz6TSCi6ihdzUm1YZh8shcQgPXA/5MQK77athpLb9tTS6JlCKbbo/
	g/ZkYclMC3BONheB7zHH/CKYLOMheX2zqrMHh6J5w6F0OfVaDOi3qXwMqpPvLKYfvZMr9p
	wtA9SMC8mz2efcjqOcd9uJqxRCQdR30=
Date: Thu, 27 Feb 2025 16:06:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: ti: icss-iep: Reject perout generation request
To: Meghana Malladi <m-malladi@ti.com>, vigneshr@ti.com,
 javier.carrasco.cruz@gmail.com, jacob.e.keller@intel.com,
 diogo.ivo@siemens.com, horms@kernel.org, richardcochran@gmail.com,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
References: <20250227092441.1848419-1-m-malladi@ti.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250227092441.1848419-1-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 27/02/2025 09:24, Meghana Malladi wrote:
> IEP driver supports both perout and pps signal generation
> but perout feature is faulty with half-cooked support
> due to some missing configuration. Remove perout
> support from the driver and reject perout requests with
> "not supported" error code.
> 
> Fixes: c1e0230eeaab2 ("net: ti: icss-iep: Add IEP driver")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
> 
> This patch is a bug fix to disable/remove a faulty feature, which will be
> enabled separately as a feature addition to net-next, as suggested by
> Jakub Kicinski and Jacob Keller:
> https://lore.kernel.org/all/20250220172410.025b96d6@kernel.org/
> 
>   drivers/net/ethernet/ti/icssg/icss_iep.c | 21 +--------------------
>   1 file changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
> index 768578c0d958..d59c1744840a 100644
> --- a/drivers/net/ethernet/ti/icssg/icss_iep.c
> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
> @@ -474,26 +474,7 @@ static int icss_iep_perout_enable_hw(struct icss_iep *iep,
>   static int icss_iep_perout_enable(struct icss_iep *iep,
>   				  struct ptp_perout_request *req, int on)
>   {
> -	int ret = 0;
> -
> -	mutex_lock(&iep->ptp_clk_mutex);
> -
> -	if (iep->pps_enabled) {
> -		ret = -EBUSY;
> -		goto exit;
> -	}
> -
> -	if (iep->perout_enabled == !!on)
> -		goto exit;
> -
> -	ret = icss_iep_perout_enable_hw(iep, req, on);
> -	if (!ret)
> -		iep->perout_enabled = !!on;
> -
> -exit:
> -	mutex_unlock(&iep->ptp_clk_mutex);
> -
> -	return ret;
> +	return -EOPNOTSUPP;
>   }
>   
>   static void icss_iep_cap_cmp_work(struct work_struct *work)
> 
> base-commit: 29b036be1b0bfcfc958380d5931325997fddf08a

LGTM. It maybe cleaner to remove PTP_CLK_REQ_PEROUT in
icss_iep_ptp_enable as well, but if the idea is to bring the feature
back, then it should be good enough.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

