Return-Path: <netdev+bounces-74847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06769866EA1
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 10:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF46C1F25F4D
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 09:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09411612D8;
	Mon, 26 Feb 2024 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E/d9E7GQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2931F61C
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937741; cv=none; b=mRHSniiyQuZ0as1K8xr0y/EZ/gulo32JvR9cp+xhRDU1FdZliLCR4v6PqEPvDMKIa4urGVtZvZn0/ECUjqnNp5Z3v7/8yv+t+Q963/zVRNLSPX3YpqbJA3nh4zmAIyMtAGHc1ZDj5A//CF4+kkRpByCZjqa0qzsYOw+z2IDf+pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937741; c=relaxed/simple;
	bh=mQhdhs0eG99ugKitt0T802I/y8woUyUpvbpMhZE5pY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8yVRSHpDYhpalDlrHv0U0hp9qnlnnO2sc82ar0I04u6sVvlgVAHS3w7QnkKpsYjLaAR3HTeXnAqBU1GUCGHL6MKmPqZHPiIUveovWHXiLMaV+N5SCDGv/BOi9psb3UPAv2RqVh+bgBTnm1rgHY9JKWHeYOQ5RA04FV8h4hrv10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E/d9E7GQ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bda53361-d334-411b-8ac1-069d41025804@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708937736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=edBZCaExlvThpicmDyNTy0RLjhxVcCzS4RTR1xHtImI=;
	b=E/d9E7GQdda0ZeIBeDukSRZjzoUWkgNHD1Zu1wUTZZ0R2M9SXXGijixZaaksWoqy4Bl9/T
	bjjWkSpoUkjpjOvCQ+dNqF+G0N38bYjKNAYi+62sDsv05KsudDn8yo/mQimA6J5qj+DLD3
	g6ahp1cllfckg/gFytEGepano0MSeuE=
Date: Mon, 26 Feb 2024 16:55:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, vbabka@suse.cz,
 Xiongwei.Song@windriver.com
References: <20240224134943.829751-1-chengming.zhou@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240224134943.829751-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/24 21:49, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.

Update changelog to make it clearer:

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed as of v6.8-rc1, so it became a dead flag since the commit
16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
series[1] went on to mark it obsolete explicitly to avoid confusion
for users. Here we can just remove all its users, which has no any
functional change.

[1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Thanks!

> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  net/socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/socket.c b/net/socket.c
> index ed3df2f749bf..7e9c8fc9a5b4 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -343,7 +343,7 @@ static void init_inodecache(void)
>  					      0,
>  					      (SLAB_HWCACHE_ALIGN |
>  					       SLAB_RECLAIM_ACCOUNT |
> -					       SLAB_MEM_SPREAD | SLAB_ACCOUNT),
> +					       SLAB_ACCOUNT),
>  					      init_once);
>  	BUG_ON(sock_inode_cachep == NULL);
>  }

