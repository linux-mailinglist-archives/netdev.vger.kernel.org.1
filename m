Return-Path: <netdev+bounces-151887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 393869F174F
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 21:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C12D163023
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3545A190662;
	Fri, 13 Dec 2024 20:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKt4Sde2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113B318FDC6
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734121006; cv=none; b=uitsoti8DThrlL/9KoDlObJnHMshy0oG/WW/fbDr+D0x8bZBVBc4WWe5xbNqcUV2CcFlTeRDtSWDC1VBn9ycqClFyfe/LG501y/OFGSGYOC9nlWv2yft3cB8Q0Dx9jPnArG5/ZG+8FDvzZwvOwjGIqwE8FDCOeMtl4cN7+h01+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734121006; c=relaxed/simple;
	bh=LzIoTqz5y4/OkcuVqgs1wGgQDuGyPaDtZ0kcDQwVeoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HURzBHcEHqvb3M/t3slNXX9PDNje7BBHflz14l6dWIi5oXAtOHgJpq+Yo/l91GPGFNuq+Y1hCVc84hV78bIHoYxAtsa1i9hyN2rs152YY9tgt+B4bGx8yePO6gbor5hz3Is40itSL+o1gu68orWknBhapkC9KNhUlR3t0wRZnV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKt4Sde2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F176DC4CED0;
	Fri, 13 Dec 2024 20:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734121005;
	bh=LzIoTqz5y4/OkcuVqgs1wGgQDuGyPaDtZ0kcDQwVeoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bKt4Sde2wSbpczkFiqQkefxrA+WW64hg+9mOz+va721aTs7JqbV16+vaos3QZg5ka
	 1gFqaFkWR6fCRgssMLJMF4cFdR6ib+HiErGpMCF/G0PX8Gfh8SOyPla+CGAHnndtho
	 hc+3CqA6bJv4zYqadCLvp2mp5hnnj9NR2Ie5VGCB+u8DYYLPRuD/EJrDqCmALZf6DK
	 Rj4Li8GNDTV4u5YbVJNKi/LUHubMUOqWOc3yZO72fKsSfeA0RB1iU99bJUhTxLNhsB
	 cW90QHbwopC2M6R0LOSV7M/unpQsA6MoPvq8igGIZ4OFPo+esqNW+rvw22Js/9JIXL
	 sQynqtELbhV9w==
Date: Fri, 13 Dec 2024 20:16:41 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/4] inetpeer: remove create argument of
 inet_getpeer()
Message-ID: <20241213201641.GH561418@kernel.org>
References: <20241213130212.1783302-1-edumazet@google.com>
 <20241213130212.1783302-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213130212.1783302-3-edumazet@google.com>

On Fri, Dec 13, 2024 at 01:02:10PM +0000, Eric Dumazet wrote:
> All callers of inet_getpeer() want to create an inetpeer.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

...

> diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c

...

> @@ -189,10 +188,6 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
>  	if (p)
>  		return p;
>  
> -	/* If no writer did a change during our lookup, we can return early. */
> -	if (!create && !invalidated)
> -		return NULL;
> -

Hi Eric,

With this change invalidated is set but otherwise unused in this function,
so it can probably be removed.

Flagged by W=1 builds.

>  	/* retry an exact lookup, taking the lock before.
>  	 * At least, nodes should be hot in our cache.
>  	 */

