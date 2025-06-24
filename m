Return-Path: <netdev+bounces-200741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31482AE6B6D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 17:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA42D3BCFEB
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 15:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9940274B3E;
	Tue, 24 Jun 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RVqfRrpb"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245D03074AF
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750779320; cv=none; b=NT0acNwTnGqZay0woZ5vaG/K5/VlTL7DU+h9h/hEHhv6rtBTi1UumHyPEmevREEXt4OuZ3Nism6Np6Q4mUW0hbqjVQt9tjVvOC/5VON+g8dVjzKBVUsEpnYFiibrI03UyrttZy1jpg+mR5XvaFtYkYENNn7iEYY1KHbDAmJQ+u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750779320; c=relaxed/simple;
	bh=r3WUA3xgOjr5jzi9hYnapVBzM8cXszn92cqwpZYTPGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pj2lcgGJGrlljd5DFSZlrmimk/5VRjxh2eRrSh7Qd6CQXseG9sHdaOnJZ2Q6gX+d//bqPzT7aSLNBg1tYb7Xd03wSnxHuhyD5NeOdncRMTrV2g1ru3gbwufYQ1s62hv6rljs/McnWQjQ25LGPVlxHjwxjrzO9H4bt1y04awjWcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RVqfRrpb; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <766738cf-92e4-4be6-8f9f-838f07874f3e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750779314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPs77OInT+Yyay6Cjc+QE517PLfEmDNv2Y/kozuJhuc=;
	b=RVqfRrpbo/LM+jr185ugxRrBp8Db0yLqOzFAXDRJjNBKsUroO3UEQ8cLvHROYSO7qx430+
	O7QuYeQdyVlnqvixbalKk9N6lCl5T973rSRT/D5TedQqGjhOR0OxjLCT1lWPtwkbWUBtu6
	j2ybdN+YsE/hnNsXvgTWT8xlN2asfXM=
Date: Tue, 24 Jun 2025 16:35:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/5] eth: fbnic: fix stampinn typo in a comment
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, alexanderduyck@fb.com,
 mohsin.bashr@gmail.com
References: <20250624142834.3275164-1-kuba@kernel.org>
 <20250624142834.3275164-3-kuba@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250624142834.3275164-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 24/06/2025 15:28, Jakub Kicinski wrote:
> Fix a typo:
>   stampinn -> stamping
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   drivers/net/ethernet/meta/fbnic/fbnic_netdev.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> index a3dc85d3838b..805a31cd94b5 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> @@ -66,7 +66,7 @@ struct fbnic_net {
>   	struct fbnic_queue_stats rx_stats;
>   	u64 link_down_events;
>   
> -	/* Time stampinn filter config */
> +	/* Time stamping filter config */
>   	struct kernel_hwtstamp_config hwtstamp_config;
>   };
>   
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

