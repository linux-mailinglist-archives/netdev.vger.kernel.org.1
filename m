Return-Path: <netdev+bounces-224103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC06B80B72
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2916D3A498F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C432F3C3E;
	Wed, 17 Sep 2025 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLk0O9x/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B732D3756
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124037; cv=none; b=Kms+AuUcvp6uJ2VOSRvd6MkKI4uVrzElTwm7iDW7hPAp1LMICkgAY6ir+JVbPyUoSQ2KOcSNCgeDpvFByJQ98RzTUYZyIdvT76ouJeTCRu8ZeZ3Fft1QECEYkyORTUZu0YTcPO5XTBvlPG2XI+gBsztkwFSOMoYeiZ0XsS5mz7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124037; c=relaxed/simple;
	bh=k5Vp5BooCMriqyBFVs7F7rsoUNAEWvdW/GK/c31rO0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQXVF3xOC6InjDpwFn1gCcsf2/fMcBWITb84s8Ul5JeErCqSSQOX4XSra6RU8uSzCOWIx5nNiKfwzIuLSw5TwkN+zX/ZYt5Sm5Z9nFaYZkxk79mpfR9BQHywBVhaChCxMdCISbkTQLjJobuZ95rGnEmFnMshOqHRgZDb762iG7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLk0O9x/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108CFC4CEE7;
	Wed, 17 Sep 2025 15:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758124035;
	bh=k5Vp5BooCMriqyBFVs7F7rsoUNAEWvdW/GK/c31rO0M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pLk0O9x/R6MTHgisNeCLbdQrSzn4Ltq6c06HKlWsvCPQuaeF8VsnpV95OsopUPlrC
	 RtycGiWAsQtku9jlSdSyDUz1YeVrdDQ3pa1eTlgYnwLJa2JRvfTNNGYm68W+S/+zXQ
	 858mixpL9vA/kT8TlnBlr8TKeiamLtZxsIHsBzuaqOLfRicxKcNzP4XZf5V/+6EfBq
	 GIOjepwLqriUVgjA+ltFuxcb61MeMrNZKy9uyzC+u8AMeXdVw8abe+R0QSzY6EHslc
	 DZXkH3WB+Y8by5C6LY59lHynRbOfNNLWSOVp3iwAEHS84kns6BPssPumJZKaeeEALR
	 07Da2u7+mP5dg==
Message-ID: <2e85dd1b-7b2e-473c-92c6-e93600224ef9@kernel.org>
Date: Wed, 17 Sep 2025 09:47:14 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/10] udp: add udp_drops_inc() helper
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-9-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250916160951.541279-9-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 10:09 AM, Eric Dumazet wrote:
> Generic sk_drops_inc() reads sk->sk_drop_counters.
> We know the precise location for UDP sockets.
> 
> Move sk_drop_counters out of sock_read_rxtx
> so that sock_write_rxtx starts at a cache line boundary.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/sock.h |  2 +-
>  include/net/udp.h  |  5 +++++
>  net/core/sock.c    |  1 -
>  net/ipv4/udp.c     | 12 ++++++------
>  net/ipv6/udp.c     |  6 +++---
>  5 files changed, 15 insertions(+), 11 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



