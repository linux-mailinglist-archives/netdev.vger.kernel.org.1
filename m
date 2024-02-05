Return-Path: <netdev+bounces-69023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FDD8492FA
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 05:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE20282C0F
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 04:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107518821;
	Mon,  5 Feb 2024 04:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvYo/BRK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E110DAD32
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 04:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707108135; cv=none; b=hFFR6TVHHnn5DJBIH2y0SAc88NnrQywtzeSLfaDw+QYBmzWlMCmxZ2GDsFZ/BFvS8EQxkIb/yhWrOZJZ4LQF8s6RCc5tT6QNfpSYC0VLaxMHQb89017K+Pbz3e2yg+H0nKU9mzFJpT00Uvq/R5CHpNbBPoFYbetDgRqd9O7HwXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707108135; c=relaxed/simple;
	bh=fjuw97UNxe8893EC07Bsbk8rXlEW3BZYaEn9eQ32e/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2WpY946Ku2zOBw01FSuS/YrSPDg7vgzezLoXV3IU209D/uP3SsOo6WtXkQf+z1MHWk5m8llBA/MhJHbUI3zFrYQGr4Yzd1Rai/42I3YdqOGpOcjOsYIISWBTn0Um33nAds1SJHcq985BnsLncpQtupJHm0bf3E/0ipMoSz5dcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvYo/BRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12CBC433F1;
	Mon,  5 Feb 2024 04:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707108134;
	bh=fjuw97UNxe8893EC07Bsbk8rXlEW3BZYaEn9eQ32e/M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gvYo/BRKsgSbfBvKz58Oj7StqPOM4SDkAfm2FFtstRDXr0kYAjquQ2SQ0+y2kCcwY
	 3jiuorJnqSAT1J2M/YLEANTjkB7WuTzwJTuEiILFhEn7Zliw9CdrvXWP7YVkM3ZyuF
	 5FGKHvS6bUNKZiKEEObP/cfxgrEgL/y33+Zcafrj7xHEwLK28CXMjn0Iokz/7Sj0uY
	 o/pVsrCOHat8QdcAAXLa5gC9PQJI2BX2I1QB7R0f8WNMDTgEt0hvDo+3LEG+4hCCzu
	 iCvWzI+MLZGwM2pABhDp+ms9NKstEc/Kadp6euu8/X7KeOhHo24ukYTfjDJeFb375r
	 1VeCLvBVCiyDw==
Message-ID: <51bb9972-70e5-4f65-9ab2-35e17d6c1467@kernel.org>
Date: Sun, 4 Feb 2024 21:42:12 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/5] net/ipv6: set expires in
 rt6_add_dflt_router().
Content-Language: en-US
To: thinker.li@gmail.com, netdev@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, kernel-team@meta.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, liuhangbin@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20240202082200.227031-1-thinker.li@gmail.com>
 <20240202082200.227031-2-thinker.li@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240202082200.227031-2-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/24 1:21 AM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Pass the duration of a lifetime (in seconds) to the function
> rt6_add_dflt_router() so that it can properly set the expiration time.
> 
> The function ndisc_router_discovery() is the only one that calls
> rt6_add_dflt_router(), and it will later set the expiration time for the
> route created by rt6_add_dflt_router(). However, there is a gap of time
> between calling rt6_add_dflt_router() and setting the expiration time in
> ndisc_router_discovery(). During this period, there is a possibility that a
> new route may be removed from the routing table. By setting the correct
> expiration time in rt6_add_dflt_router(), we can prevent this from
> happening. The reason for setting RTF_EXPIRES in rt6_add_dflt_router() is
> to start the Garbage Collection (GC) timer, as it only activates when a
> route with RTF_EXPIRES is added to a table.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  include/net/ip6_route.h | 3 ++-
>  net/ipv6/ndisc.c        | 3 ++-
>  net/ipv6/route.c        | 4 +++-
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 


Suggested-by: David Ahern <dsahern@kernel.org>
Reviewed-by: David Ahern <dsahern@kernel.org>


