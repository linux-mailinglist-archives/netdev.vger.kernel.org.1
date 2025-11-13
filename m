Return-Path: <netdev+bounces-238198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC2DC55C42
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 06:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7D53AD71D
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 05:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AB63016E4;
	Thu, 13 Nov 2025 05:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMuuCYoJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB02229D29E
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 05:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763010685; cv=none; b=Gc+u04p7gE+FUmgLCyayr/pY4XZKKx0Zq1nBGd5H9lQrU13McqFkvDzbA8PTuKYfALB7WeDPaMZiDOgMx61/MqaaC/NtwhGliQA595zdZ7K7SK7V2cwD7UBwBj2oKXukQYmn6zqs+34WnrgFa5pwu+Bw2lhbGmzHXaQeDRhO7v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763010685; c=relaxed/simple;
	bh=JZdmc1ZF8SVj2A8x9yB/iuU+Ecfj+1MNCEn5MGtRO8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNr3iDdPjsmZuCglgfoqNW4mFVGLV4YhHQPY7vsYLjoJEbS5y+3QAgX+URquOqdIeojQciVixuJ/POYUJygSHCb66tkKx8j1Ctu5o+yu+NdRr9k4Z/nAqFPQYiZ8wf2+AB0cbxX4GkxeCMszuGgJQdGcc92a796ZgESOBgnBKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMuuCYoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EFFC16AAE;
	Thu, 13 Nov 2025 05:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763010685;
	bh=JZdmc1ZF8SVj2A8x9yB/iuU+Ecfj+1MNCEn5MGtRO8g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rMuuCYoJp0W1xbHIKmbNfPgg34f/anpeaPJz5vYrB9UATOHeeY8FV8iDrNF/xputH
	 nvi7Ns7Z+D7JY3oHpkH+HMaULlzsSy4XFS/DNFoK6D6MJHC784UM6rywGC+cOAsceR
	 V849pXaRhH0loQaciu6imVAsotopXs6I0gzstyN4z1GZUK7//7ddicLOvMM2sxYr64
	 Qzi1O19PYBKPjguvba3qzL5+V6cShxfq4hcHeZoHTtryXnI6Ue4kQMsRG7+ZBMhQwL
	 oqwLZGLxUx6C/SL9A7F4UZBxYCY0SFOtgYlbHI+zJoOWfs5bqNilshY8xMgeq6cnKR
	 8a7uZ8g9V8n7g==
Message-ID: <fadbf374-0b3f-4c50-b3bd-26379664e9e4@kernel.org>
Date: Wed, 12 Nov 2025 22:11:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ipv6: clean up routes when manually removing
 address with a lifetime
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, idosch@nvidia.com
References: <20251113031700.3736285-1-kuba@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20251113031700.3736285-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/25 8:17 PM, Jakub Kicinski wrote:
> When an IPv6 address with a finite lifetime (configured with valid_lft
> and preferred_lft) is manually deleted, the kernel does not clean up the
> associated prefix route. This results in orphaned routes (marked "proto
> kernel") remaining in the routing table even after their corresponding
> address has been deleted.
> 
> This is particularly problematic on networks using combination of SLAAC
> and bridges.
> 
> 1. Machine comes up and performs RA on eth0.
> 2. User creates a bridge
>    - does an ip -6 addr flush dev eth0;
>    - adds the eth0 under the bridge.
> 3. SLAAC happens on br0.
> 
> Even tho the address has "moved" to br0 there will still be a route
> pointing to eth0, but eth0 is not usable for IP any more.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Bit of a risky change.. but there's no known reason to intentionally
> keep these routes.
> 
> v2:
>  - fix up the test case
> v1: https://lore.kernel.org/20251111221033.3049292-1-kuba@kernel.org
> 
> CC: idosch@nvidia.com
> CC: dsahern@kernel.org
> ---
>  net/ipv6/addrconf.c                      |  2 +-
>  tools/testing/selftests/net/rtnetlink.sh | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 40e9c336f6c5..b66217d1b2f8 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -1324,7 +1324,7 @@ static void ipv6_del_addr(struct inet6_ifaddr *ifp)
>  		__in6_ifa_put(ifp);
>  	}
>  
> -	if (ifp->flags & IFA_F_PERMANENT && !(ifp->flags & IFA_F_NOPREFIXROUTE))
> +	if (!(ifp->flags & IFA_F_NOPREFIXROUTE))
>  		action = check_cleanup_prefix_route(ifp, &expires);
>  

I was wandering the code earlier today. Could not find anything
obviously wrong with dropping that check, but putting into net-next for
a while will give some time for more testing by various groups.

Reviewed-by: David Ahern <dsahern@kernel.org>



