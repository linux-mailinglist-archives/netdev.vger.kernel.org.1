Return-Path: <netdev+bounces-124297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F66968D9A
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 20:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09F61F243DC
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28CD1A3027;
	Mon,  2 Sep 2024 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7xS3seo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB083B1AC
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302317; cv=none; b=U4kiO1phl2TCISdV+uK7/30svdKv82z6j2E19IkmLBVIQkpL5tw9r6drKHbmfsanVfO/xT5UgnR4FjdC7WggIdcKbmwQvVz601RCTa+gGhhqpmlno9Y7OakWZoUt+g4kyT365LSMeN4cFixhd4j3kuKOXiUVm8CIpTnr+pAik1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302317; c=relaxed/simple;
	bh=myBCe2TaV76YLmxEp9JbMx+BofKjJHsB0M5gCM643PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9vlkB7qvDclE2x5VDTy7MtEYFc+4UQ9/QpqrfchV4dXr6pfX5Imsnhe7tiXCI96jmhmSByJM6Sd3pBbzUcxPcgwScPMW+PExhjVmk6YsXW6y1RcxU7gBzS4MkwM28RqMRoMsxKHQBvqmKz/ZLlejpdR9wQfGWMJWi7Og0zo4X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7xS3seo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BA8C4CEC2;
	Mon,  2 Sep 2024 18:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725302317;
	bh=myBCe2TaV76YLmxEp9JbMx+BofKjJHsB0M5gCM643PI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F7xS3seoBBKiByceFlQMCZccGGPVGJXiy+DgjShqslwDmEnZYFXxO322c5SbDsJK7
	 fiEV+fu3dCcI1idKKAQcAGc2k5nz/maX4jtfER2Lv4YLKO/8vAvBQ4/4wl8ON6vesV
	 QH31SNRZD9Aa15+n0f241CIaa4mpCO4bGw09fYeG6OL7WQ8ZhH34J+JYa9+YxezJnz
	 /7ppd2erYA7vD+58E4CKVcarI+6HUFe/t3q1MOXOQ50Jtju8tO2K6XE1uRZOPMXNeh
	 X/KVHcUqQ42pXtvYP6waUaxThoEneMite6m1BEgTmj0aO29CudPA9Qh4hgOhtbHLJI
	 s3EFotIYwozkw==
Date: Mon, 2 Sep 2024 19:38:33 +0100
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
Message-ID: <20240902183833.GK23170@kernel.org>
References: <20240902130937.457115-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902130937.457115-1-vadfed@meta.com>

On Mon, Sep 02, 2024 at 06:09:35AM -0700, Vadim Fedorenko wrote:
> SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
> timestamps and packets sent via socket. Unfortunately, there is no way
> to reliably predict socket timestamp ID value in case of error returned
> by sendmsg. For UDP sockets it's impossible because of lockless
> nature of UDP transmit, several threads may send packets in parallel. In
> case of RAW sockets MSG_MORE option makes things complicated. More
> details are in the conversation [1].
> This patch adds new control message type to give user-space
> software an opportunity to control the mapping between packets and
> values by providing ID with each sendmsg. This works fine for UDP
> sockets only, and explicit check is added to control message parser.
> 
> [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

...

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c

...

> @@ -1543,10 +1546,15 @@ static int __ip6_append_data(struct sock *sk,
>  			flags &= ~MSG_SPLICE_PAGES;
>  	}
>  
> -	hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
> -		     READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
> -	if (hold_tskey)
> -		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
> +	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
> +	    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
> +		if (cork->flags & IPCORK_TS_OPT_ID) {
> +			tskey = cork->ts_opt_id;
> +		} else {
> +			tskey = atomic_inc_return(&sk->sk_tskey) - 1;
> +			hold_tskey = true;

Hi Vadim,

I think that hold_tskey also needs to be assigned a value in
the cases where wither of the if conditions above are false.

Flagged by Smatch.

> +		}
> +	}
>  
>  	/*
>  	 * Let's try using as much space as possible.

-- 
pw-bot: cr

