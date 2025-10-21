Return-Path: <netdev+bounces-231385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9867BBF84F0
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 21:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B9B94EE8B9
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 19:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EEE25BEF2;
	Tue, 21 Oct 2025 19:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QAr1UBUT"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E8F350A00;
	Tue, 21 Oct 2025 19:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761076073; cv=none; b=uJy6G9mGHSbeZPiuKzB/N0Byqm8GtrYs2pQgscjy9ZwIKmRovyEh6sxIkqJrnQlCxFdVVH2KwdTJZ8Q1eqYYPVV96tsUkW6aDkigHcz+iF4mg8YWyRW3yyfdjORPkfo94VYpNTsy+cRd8PeFehn2tV1ZK3j0SzRCBh56WepSG48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761076073; c=relaxed/simple;
	bh=99XOQ8/c1bSey+JyTeJXM1222mQtTxFiwkbfFTqMK2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=josDSFVtjteloEGdIz+PIJBWu1y0sSBW/v2XLvlPkkp5KcwToOLwAxsiNd4wgXNnWbjk5ZsF6Z5Pxl4UNSCu11NevqB8y865bOj8HndwKupQun+spVvrH0XYdNXLFxsZBriPFG8y/QyHBNm0wcXKs/UG6TrMhEj3RNjxwUfqpB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QAr1UBUT; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <951141f8-f26b-4d0e-bf54-5c7f4e0b99af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761076066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eD409e6hY+qRd6MhDEDpdC+HWvW0mADRZZeGBzPBkr0=;
	b=QAr1UBUTj+UKkxgh0C2c9YUBV+RQz1HEYGs1x5JNXxVw+2+O9PLK6BxsFYX7L8U2HGs+rU
	8f2E2RgI7rwvVz4kt8cbUJxoNvkFJHSPHtzOuGHRejAFMoeYoneOQH1uMUb2awkvAOpP/t
	kTR81ogxPV+L51RlvQKJUFs2oOxy7dA=
Date: Tue, 21 Oct 2025 20:47:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ptp: ocp: Fix typo using index 1 instead of i in SMA
 initialization loop
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251021182456.9729-1-jiashengjiangcool@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251021182456.9729-1-jiashengjiangcool@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 21/10/2025 19:24, Jiasheng Jiang wrote:
> In ptp_ocp_sma_fb_init(), the code mistakenly used bp->sma[1]
> instead of bp->sma[i] inside a for-loop, which caused only SMA[1]
> to have its DIRECTION_CAN_CHANGE capability cleared. This led to
> inconsistent capability flags across SMA pins.
> 
> Fixes: 09eeb3aecc6c ("ptp_ocp: implement DPLL ops")
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
>   drivers/ptp/ptp_ocp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 794ec6e71990..a5c363252986 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -2548,7 +2548,7 @@ ptp_ocp_sma_fb_init(struct ptp_ocp *bp)
>   		for (i = 0; i < OCP_SMA_NUM; i++) {
>   			bp->sma[i].fixed_fcn = true;
>   			bp->sma[i].fixed_dir = true;
> -			bp->sma[1].dpll_prop.capabilities &=
> +			bp->sma[i].dpll_prop.capabilities &=
>   				~DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE;
>   		}
>   		return;

Thanks!

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

