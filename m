Return-Path: <netdev+bounces-33886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471CD7A08FD
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0476B282044
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20771CA99;
	Thu, 14 Sep 2023 15:06:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A2D1CAA4
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5A8C433C7;
	Thu, 14 Sep 2023 15:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694703984;
	bh=puQpVaLNmKac1XdoYn/Zlrchdu1QAu66oJfUOZokg0U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BagqCSsCu20WQR9pS3UuHavs4ebaVKhD05ifCl2fn9VSf1l19mSjB9ewkeIzV1qQc
	 jLzYq6enhagJ2CP2WZho4ko9vT/8BYoxndsv8TAVmiCSbdK1HZbzYa4F914IoaNIlc
	 2/NxEyjS08y6YzA65kOxGWfU1Ot0hwMKmKI0bqC3OKYFkwBCIv0H8oQ+JD3H8Xna2b
	 +2AGE2CLM4c3Vo05zdVPfT0szRixwu7a0zyTVjM8pqoy1AT3Q0GpHWK4FcHMw0y0hV
	 rS/jlrsi+6wQzqML3XnYUdh9UuMC6gu4M7t7ICS5nsnvkArYBfeqsBp4YF1Le8QcTF
	 YBouh7YvrWNgQ==
Message-ID: <3bfa3059-4ca7-c4f0-a9b4-92049286103f@kernel.org>
Date: Thu, 14 Sep 2023 09:06:23 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 10/14] ipv6: lockless IPV6_RECVERR implemetation
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230912160212.3467976-1-edumazet@google.com>
 <20230912160212.3467976-11-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230912160212.3467976-11-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/23 10:02 AM, Eric Dumazet wrote:
> np->recverr is moved to inet->inet_flags to fix data-races.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/ipv6.h     |  3 +--
>  include/net/inet_sock.h  |  1 +
>  include/net/ipv6.h       |  4 +---
>  net/dccp/ipv6.c          |  2 +-
>  net/ipv4/ping.c          |  2 +-
>  net/ipv6/datagram.c      |  6 ++----
>  net/ipv6/ipv6_sockglue.c | 17 ++++++++---------
>  net/ipv6/raw.c           | 10 +++++-----
>  net/ipv6/tcp_ipv6.c      |  2 +-
>  net/ipv6/udp.c           |  6 +++---
>  net/sctp/ipv6.c          |  4 +---
>  11 files changed, 25 insertions(+), 32 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



