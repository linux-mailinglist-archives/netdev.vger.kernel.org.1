Return-Path: <netdev+bounces-239803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 65385C6C7C7
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F8EE3688BD
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6007C248176;
	Wed, 19 Nov 2025 02:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9yiygjf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B751C861D
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 02:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520980; cv=none; b=scXtbm9xtSTt8UXPnNb7sUFCkoBYFUnsUsjIk/y9A+HGA+k9QeBsecl6xr+xGgQ5/wYcqKbwvb+/9jNRd0BpBkDaqJoxHJkhAnLKhKazKsq3IKhOloqwm2PWqXWFdcOBmcItlJzizPXN8fTih6RM1Wk7yszmLp7qRPfigNPEcPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520980; c=relaxed/simple;
	bh=DNM/wBmiDqQ3tUfCCl/2ovQ2pC0ym7qBaRfxzQUCVBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ae2ZFAdE16rVW3Qh44rc9+7HBdIRxwK7szsSLuA6Hrnl9ddCNa+wEBXdelnZLEOHB+c8nW8rToaj0P5b1dYzc4XPc9u2mcSIeVz07oJvbXkAQ4fW67GhX/GTghiYue326p9UzQHi/MaYwI/MC3K8vXBJM74KzqIbJRVYJVV4LW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9yiygjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460CAC19422;
	Wed, 19 Nov 2025 02:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763520979;
	bh=DNM/wBmiDqQ3tUfCCl/2ovQ2pC0ym7qBaRfxzQUCVBw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S9yiygjfyf8/U5+yQImR3QSsnUWR6WBhp9GaWTbDnj5L92g2UN5xclthQ2sbiHdhH
	 3tVvpcv04MdAQ0UaTRoo2Ko2+5PAitUS5uGUl2Lgw1oPCEir+cjrym7P8ZpXaB+bs2
	 e0pLjqz6sBWl3hwRSC9ejQzQhF2qnADbEnRX7GN0fx2YLqoVO1hCx/S5kjL92k9fUT
	 m4RaAKE5e/bqkji4UAfTPMRaX0aWY9OKu5t0N1uhvB2p+tcTf9DZxET4kT4UwhPivB
	 xoJ2Q+5Y6jliQOt8bh7QcTtcI42kV2HRMZkb0WAariDvQ4JS2IXmZ+QlFZE11HDUf0
	 E8dTYSuo5gRNg==
Message-ID: <48aee06e-32b5-4347-838c-bf98c0e9b431@kernel.org>
Date: Tue, 18 Nov 2025 19:56:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 net-next v2] ipv6: clear RA flags when adding a static
 route
Content-Language: en-US
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, Garri Djavadyan <g.djavadyan@gmail.com>
References: <20251115095939.6967-1-fmancera@suse.de>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20251115095939.6967-1-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/25 2:59 AM, Fernando Fernandez Mancera wrote:
> When an IPv6 Router Advertisement (RA) is received for a prefix, the
> kernel creates the corresponding on-link route with flags RTF_ADDRCONF
> and RTF_PREFIX_RT configured and RTF_EXPIRES if lifetime is set.
> 
> If later a user configures a static IPv6 address on the same prefix the
> kernel clears the RTF_EXPIRES flag but it doesn't clear the RTF_ADDRCONF
> and RTF_PREFIX_RT. When the next RA for that prefix is received, the
> kernel sees the route as RA-learned and wrongly configures back the
> lifetime. This is problematic because if the route expires, the static
> address won't have the corresponding on-link route.
> 
> This fix clears the RTF_ADDRCONF and RTF_PREFIX_RT flags preventing that
> the lifetime is configured when the next RA arrives. If the static
> address is deleted, the route becomes RA-learned again.
> 
> Fixes: 14ef37b6d00e ("ipv6: fix route lookup in addrconf_prefix_rcv()")
> Reported-by: Garri Djavadyan <g.djavadyan@gmail.com>
> Closes: https://lore.kernel.org/netdev/ba807d39aca5b4dcf395cc11dca61a130a52cfd3.camel@gmail.com/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> v2: rebase in top of net-next.git instead of net.git
> ---
>  net/ipv6/ip6_fib.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index 02c16909f618..2111af022d94 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -1138,6 +1138,10 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
>  					fib6_set_expires(iter, rt->expires);
>  					fib6_add_gc_list(iter);
>  				}
> +				if (!(rt->fib6_flags & (RTF_ADDRCONF | RTF_PREFIX_RT))) {
> +					iter->fib6_flags &= ~RTF_ADDRCONF;
> +					iter->fib6_flags &= ~RTF_PREFIX_RT;
> +				}
>  
>  				if (rt->fib6_pmtu)
>  					fib6_metric_set(iter, RTAX_MTU,

Converting an RA route to a static route should be a very rare use case.
I can't find a reason why this is wrong, so:

Reviewed-by: David Ahern <dsahern@kernel.org>


