Return-Path: <netdev+bounces-23667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C5A76D0F5
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CDC91C2129F
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D71D8494;
	Wed,  2 Aug 2023 15:04:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3143B8460
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58544C433C8;
	Wed,  2 Aug 2023 15:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690988688;
	bh=FYxDxLLm4G1AL23Y8wUCV3iqopuaTMFOeN78Za51Q0k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PuqyzbJie6pE8pjBPyt6DRkurG24M7RyyD2uHFZ1bjNMxXQ+WR0Rt8jVHSwtFf6Hf
	 F7U/JyJ/JuRKJGC1v80SW9sdtwQeYy6142wYmgdJRagAAktOr2h8CcfrVwB02kc3gx
	 4CsnPepWcRWmRAukq0OkpP5oBydleDz7cN09nxloIprjk09IOkmuhSaCb82iuTLr9O
	 Lzl8XSzU1hBwat3du7Rjh7mSbRKo4smrg1CPb1T3R5m43siTtQQb/MuMcKz2qQ+lmu
	 SSK+Kjurw9JVKrMfzDtg/szGMZV0WyEYzzAA67+KQBr1LXW6Vluj6EwLi5hpIRyeUe
	 0Z7UCIg07VzTg==
Message-ID: <78db52e1-8c52-fff6-0445-083558d8d9dd@kernel.org>
Date: Wed, 2 Aug 2023 09:04:47 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net 1/6] tcp_metrics: fix addr_same() helper
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20230802131500.1478140-1-edumazet@google.com>
 <20230802131500.1478140-2-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230802131500.1478140-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/23 7:14 AM, Eric Dumazet wrote:
> Because v4 and v6 families use separate inetpeer trees (respectively
> net->ipv4.peers and net->ipv6.peers), inetpeer_addr_cmp(a, b) assumes
> a & b share the same family.
> 
> tcp_metrics use a common hash table, where entries can have different
> families.
> 
> We must therefore make sure to not call inetpeer_addr_cmp()
> if the families do not match.
> 
> Fixes: d39d14ffa24c ("net: Add helper function to compare inetpeer addresses")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: David Ahern <dsahern@kernel.org>
> ---
>  net/ipv4/tcp_metrics.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


