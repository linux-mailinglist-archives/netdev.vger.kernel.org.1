Return-Path: <netdev+bounces-33875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 096F87A08B9
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55090B20D36
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4C4241ED;
	Thu, 14 Sep 2023 14:55:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A1B28E11
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 14:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E84C433C7;
	Thu, 14 Sep 2023 14:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694703354;
	bh=qquELLY/Nlz68lWG00v50QQtc9eCkSn+Wt0MCqYSjPY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZOmk40Bf3YMQrYcH2UQEu9CBMNCnCjQVc1y+ybn1NZLF4jRmG8lmLz3EFYRS4b9gX
	 9cv/Qp1HkPskyQ6E8s1XlxrGGvwkw5O7Fkjud2n170SJoOZr6yrm0SuNqJxJurG3B1
	 ReCui4i9DglKsVwSsTZtFwDNI0GEFNDCML9SPAQA9KI1Q9IfN2Aq28X5WRFEW6ZBU8
	 BPlIOmUkDG6HaKD/sEoQ9tUO1/fwM4vhEVKcqaV2pG/VLzXR1goGM0gsb1UM+8rhbW
	 HoZbbWIkML9EPC8I6LCUMIUQdueDOo7T8shZQu+SJ+6LapPzjrUFYVXwb+iDREkYaU
	 R1N3c8hNvVDcw==
Message-ID: <e3639580-5a84-bf03-970d-56163c3f68af@kernel.org>
Date: Thu, 14 Sep 2023 08:55:53 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 03/14] ipv6: lockless IPV6_MULTICAST_HOPS
 implementation
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230912160212.3467976-1-edumazet@google.com>
 <20230912160212.3467976-4-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230912160212.3467976-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/23 10:02 AM, Eric Dumazet wrote:
> This fixes data-races around np->mcast_hops,
> and make IPV6_MULTICAST_HOPS lockless.
> 
> Note that np->mcast_hops is never negative,
> thus can fit an u8 field instead of s16.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/ipv6.h            |  9 +--------
>  include/net/ipv6.h              |  2 +-
>  net/dccp/ipv6.c                 |  2 +-
>  net/ipv6/ipv6_sockglue.c        | 28 +++++++++++++++-------------
>  net/ipv6/tcp_ipv6.c             |  3 ++-
>  net/netfilter/ipvs/ip_vs_sync.c |  2 +-
>  6 files changed, 21 insertions(+), 25 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



