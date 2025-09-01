Return-Path: <netdev+bounces-218939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93810B3F0E6
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 00:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E2D3BEEE8
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DD42820D7;
	Mon,  1 Sep 2025 22:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WnjL1/It"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384EE32F75D
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756764800; cv=none; b=dDyBbcWs1dy7MohM/GPkK+H0ZkU/b4Snz9uVBRQb/k0Il/DtsmPXAyFFMwE8yd2kDdn4SFcYw/+2ynWIqXiCqq4QQA1EQ4BHSE5UnnDYjJzc2/t2c85oWdRYck8sdDf1I1c937UZnSq6Nxkia8Q0cwstF41z4dwAoh9tiE48Uow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756764800; c=relaxed/simple;
	bh=2hJIeGvPrPBdRhm9e18Vazro8L3JBlo6cfYnIHqp1QA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0UvFIWpYxYFFdz/cVbsFnu7zmtzUzdksXcnmlKPbpEhGh1Gk7ZvL/TcN0lEJSRXJBK+3kAu+7fOKOYfjffBA9eOufINq+ZqgSBeIsH9cgPueOSg8rVPxeaI1jrMbaz/xJ8+LEiib8yvGJheQlXvc4mRMluxt6qzB5ivlzhqHyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WnjL1/It; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e13abc99-fb35-4bc4-b110-9ddfa8cdb442@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756764795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAn/M/2ucy/8Lh/WFBw3kIMvkZg2yrA5U3RNBpGf4FE=;
	b=WnjL1/ItZhqaTB0PEP7mrbcPFRjcmo8EezPjX3VC2Al1+490dkK6EQvoxQ+wI2vE757tT4
	7UM94bu4scxY7QSY67gKOvY+/6aYw3CU4bdfYGrC14n+ROCg5zjRWcLcZx6fKXyPcDPT6s
	fDeIJOfphiHa4PHwGjTjxgVFgRGLtkg=
Date: Mon, 1 Sep 2025 23:13:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: intel: fm10k: Fix parameter idx set but not used
To: Brahmajit Das <listout@listout.xyz>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org
References: <20250901213100.3799820-1-listout@listout.xyz>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250901213100.3799820-1-listout@listout.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 01/09/2025 22:31, Brahmajit Das wrote:
> Variable idx is set in the loop, but is never used resulting in dead
> code. Building with GCC 16, which enables
> -Werror=unused-but-set-parameter= by default results in build error.
> This patch removes the dead code and fixes the build error.
> 
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
>   drivers/net/ethernet/intel/fm10k/fm10k_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_common.c b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
> index f51a63fca513..2fcbbd5accc2 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_common.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
> @@ -457,7 +457,7 @@ void fm10k_unbind_hw_stats_q(struct fm10k_hw_stats_q *q, u32 idx, u32 count)
>   {
>   	u32 i;
>   
> -	for (i = 0; i < count; i++, idx++, q++) {
> +	for (i = 0; i < count; i++, q++) {
>   		q->rx_stats_idx = 0;
>   		q->tx_stats_idx = 0;
>   	}

All callers to this function provide constant 0 as idx param. The better
solution would be to remove the parameter completely.

