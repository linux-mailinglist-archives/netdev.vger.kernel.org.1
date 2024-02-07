Return-Path: <netdev+bounces-69880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 166D784CE73
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435F61C20E18
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92C55FEE1;
	Wed,  7 Feb 2024 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOovZnQ6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BC31E4BD
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321486; cv=none; b=aLSQrxeOTROLANcEQB7oSuUCFVRwJhZ+JAIh7TVNXHzvkvSddXWpRvHwSNAXtMxD5tRwYa0hUvUfoPwlLO7uwVDNFpzTk5bGt0rWb1O6/98VPT4eSPfaYX6Et1jXOEwUzXfk7WX9CqLcN2AuErwugN8uTqvz8G6lmUTpfzg2930=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321486; c=relaxed/simple;
	bh=KSj+MUjsXAF+ZjVYTSeHmVLoJlISCmyBnMTQZK1qIH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=symhZjkfC4OnLV1kchGu0mrjCKskKqvAA2JsSKbP8KSekkCWRjezrXWAtLD7WqNh3Tukn3BHx9iVMwRaFKa1zzwLoKZFN1/moNEM3Cm5oxlKXXqqW/TmvbgKRnrpeH7KzXnaplpCvIOCNmE91KHG6Ia72kPu6abKnhdzGPLEh9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOovZnQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3C7C433C7;
	Wed,  7 Feb 2024 15:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707321486;
	bh=KSj+MUjsXAF+ZjVYTSeHmVLoJlISCmyBnMTQZK1qIH8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eOovZnQ6hxtRoWO/1rja+JCNnDtO1rIvozxamL3doYcLWBF2K6V/ObNGBwe58A2Qg
	 1jrER5IgOxS/MO9kF3K8u44jlIHvxnKvT6h+D+y/U2EEbzKyNWXVDio7lw0c5LFQ/1
	 A4j2YufSxUGru2slLuSE5c4WT4j61Ad0j+JBd50LaZjyCWE7E3U8kl+5KWgW+Bg8dZ
	 vqcMz8+dkceS5YDDB2SYootK7Nv2JNECQ0sq/bDeUs80/kiff7iwg/YkDO+QpRmCch
	 StkK/GfQDoT/KuKbBKwk2LBF+uQ3WRvQZVX/P7bJxVbPEQItRNBkbjyHvNGyaHMo5t
	 HPbO3UI2q9t/w==
Message-ID: <d58cb247-b0ac-4cbd-9eb2-34cc5fc2670f@kernel.org>
Date: Wed, 7 Feb 2024 08:58:04 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/5] net/ipv6: Remove expired routes with a
 separated list of routes.
Content-Language: en-US
To: thinker.li@gmail.com, netdev@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, kernel-team@meta.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, liuhangbin@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20240205214033.937814-1-thinker.li@gmail.com>
 <20240205214033.937814-4-thinker.li@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240205214033.937814-4-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/24 2:40 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> FIB6 GC walks trees of fib6_tables to remove expired routes. Walking a tree
> can be expensive if the number of routes in a table is big, even if most of
> them are permanent. Checking routes in a separated list of routes having
> expiration will avoid this potential issue.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  include/net/ip6_fib.h | 47 ++++++++++++++++++++++++++++++++-
>  net/ipv6/addrconf.c   | 41 ++++++++++++++++++++++++-----
>  net/ipv6/ip6_fib.c    | 60 +++++++++++++++++++++++++++++++++++++++----
>  net/ipv6/ndisc.c      | 10 +++++++-
>  net/ipv6/route.c      | 13 ++++++++--
>  5 files changed, 155 insertions(+), 16 deletions(-)
> 

one nit below, but otherwise

Reviewed-by: David Ahern <dsahern@kernel.org>


> @@ -498,6 +510,39 @@ void fib6_gc_cleanup(void);
>  
>  int fib6_init(void);
>  
> +/* Add the route to the gc list if it is not already there
> + *
> + * The callers should hold f6i->fib6_table->tb6_lock and make sure the
> + * route is on a table.

The last comment is not correct given the fib6_node check below.

> + */
> +static inline void fib6_add_gc_list(struct fib6_info *f6i)
> +{
> +	/* If fib6_node is null, the f6i is not in (or removed from) the
> +	 * table.
> +	 *
> +	 * There is a gap between finding the f6i from the table and
> +	 * calling this function without the protection of the tb6_lock.
> +	 * This check makes sure the f6i is not added to the gc list when
> +	 * it is not on the table.
> +	 */
> +	if (!rcu_dereference_protected(f6i->fib6_node,
> +				       lockdep_is_held(&f6i->fib6_table->tb6_lock)))
> +		return;
> +
> +	if (hlist_unhashed(&f6i->gc_link))
> +		hlist_add_head(&f6i->gc_link, &f6i->fib6_table->tb6_gc_hlist);
> +}
> +


