Return-Path: <netdev+bounces-146498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2509D3C60
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 14:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EB37B2CED6
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 13:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223C41AAE31;
	Wed, 20 Nov 2024 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g5Q+/BUq"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A161991AA
	for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107935; cv=none; b=rPxaE78q0jLt3TjjfYV6FM2Y7OX3o0eftS+Xv6FKTitq3R1g6EwGnnFzeipA2kN0bVXWvOWQl3Pv0VgPRvaQUKvSaO/BVGMBqCMUJY52/x3Gp9sde4i4lhdXKcSwo3JECYF5Kw2p9V8HKZTBHYnHnNhLdyoXgdXAXYdhzYIs4bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107935; c=relaxed/simple;
	bh=KBffu/dejV66mtn99IVVjRLvR+lCkIRbYLQn9mLvpmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMea9kdn3TSG1YrP3lkiJWekGaWBv/EuPpOHPBUmldoXvtVNlL+GcI72ocAkzxVDASIlStYujvWlf+aG2iSbQ/3RBSFHS0eG2BQVbtWv1yvXZofy1vCFTdkVaoNRfOwNbsnAIBdaXTqqRIUqmQkf1mYZvPZKUPmQXcqYly1dKT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g5Q+/BUq; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6056ea19-acf9-4ba9-bb27-d18598d22a2e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732107924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CId5N/ufcuAL77pVCfhtuI+j2MsmhTA8i0CzPZcEl9o=;
	b=g5Q+/BUqi3osUCk+yWj4lJwQkfEt8Kuu+TNBM/VOVKmxATfYCQV/z6jRKJ5ir5YAbs08Qm
	P3IHaCYVnRmHqOpqLcoJ5qYI/q+Xhdn1vz1s+ob+dWUOOMMLeBIKRZAygXGMp0lyFnF5ks
	q4Wbmj/tFC9SuSBY43WknoLrqO28rMc=
Date: Wed, 20 Nov 2024 05:05:19 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ptp: ocp: Fix the wrong format specifier
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, jonathan.lemon@gmail.com
Cc: richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241120062605.35739-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241120062605.35739-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19/11/2024 22:26, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Use '%u' instead of '%d' for unsigned int.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>

This is net-next material, but the merge window has started and
therefore net-next is closed, please repost in 2 weeks.

> ---
>   drivers/ptp/ptp_ocp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 5feecaadde8e..52e46fee8e5e 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -1455,7 +1455,7 @@ ptp_ocp_verify(struct ptp_clock_info *ptp_info, unsigned pin,
>   		 * channels 1..4 are the frequency generators.
>   		 */
>   		if (chan)
> -			snprintf(buf, sizeof(buf), "OUT: GEN%d", chan);
> +			snprintf(buf, sizeof(buf), "OUT: GEN%u", chan);
>   		else
>   			snprintf(buf, sizeof(buf), "OUT: PHC");
>   		break;


