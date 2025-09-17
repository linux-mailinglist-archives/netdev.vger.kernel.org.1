Return-Path: <netdev+bounces-224087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DED76B8098C
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F961C2728D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD228333AB7;
	Wed, 17 Sep 2025 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l66zIifN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EB2333AA7
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123193; cv=none; b=AL7LeD0UBASlwhd375ojnYzuBlPEGZsseTOSwhbZFncifgNAU4nN0GJIlxDCWROhlgvIPmE4QkvnWraq9MJp+NRgO0lLD19yDwA7YdS76kq1U6rLTYu4FJJP3w+2BztMnoaedrakquxEDfFfulucVxg6zsopB/5GMbBfbyFZz9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123193; c=relaxed/simple;
	bh=0eHJKUg9Z9QwSL1QKlQ9WcBEPmU6m6jNIupR+6jrlUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nsygrbwc/W41pHXKgj8q8boozpFtoP8iFwSKtIa/RBo/EF5hY0x3poyIp6tqPfTllV+r4QKfDm0XllgeY5k4b7zOyTd9432IhTPvM2Ubh1d1bHuaRrfWS151OcSvygfsR+axXkZhS/J7mjaty28ejvU8F3ITv1V1tas8D7w0Kio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l66zIifN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10CCC4CEE7;
	Wed, 17 Sep 2025 15:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758123193;
	bh=0eHJKUg9Z9QwSL1QKlQ9WcBEPmU6m6jNIupR+6jrlUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l66zIifNxSnT1U3KP2jCIL3a3bJYVA2V3YYg6zQWV3x1/AJyW6gayVi+eWS89KQdH
	 hTACyPeQaLl5Q0jJIwDjA2pz0FFzubv9rj20UtKMbfDT+BtG/xSxwl75tgWdBthMBi
	 fI06lnwtTajLCpYLUtWatONu+8SrpistTTFzIenZXdjbLG/p9yQqZOGk85dX9q05Nf
	 WrF8v0g7IJVfCh9u40Ym9fRuRn+wSOZLH78k/WaZGxhSZ42eDtqb80yRNVszI59zPn
	 mXk3/h6OuhyfDk+MhuBTUjFQnr4IcLiuvtJDl6qshUCU1ho5PRB0agp/iwiCEf2/or
	 beKHwli25fvyw==
Message-ID: <a694fead-4e27-4eb2-b1c5-6a283b6a30f8@kernel.org>
Date: Wed, 17 Sep 2025 09:33:12 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/10] ipv6: make ipv6_pinfo.daddr_cache a
 boolean
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-3-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250916160951.541279-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 10:09 AM, Eric Dumazet wrote:
> ipv6_pinfo.daddr_cache is either NULL or &sk->sk_v6_daddr
> 
> We do not need 8 bytes, a boolean is enough.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/ipv6.h             | 2 +-
>  include/net/ip6_route.h          | 4 ++--
>  net/ipv6/af_inet6.c              | 2 +-
>  net/ipv6/inet6_connection_sock.c | 2 +-
>  net/ipv6/ip6_output.c            | 3 ++-
>  net/ipv6/route.c                 | 3 +--
>  net/ipv6/tcp_ipv6.c              | 4 ++--
>  7 files changed, 10 insertions(+), 10 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



