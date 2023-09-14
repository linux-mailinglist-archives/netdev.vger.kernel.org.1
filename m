Return-Path: <netdev+bounces-33891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F917A0910
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F8B0B20CD2
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA3E21112;
	Thu, 14 Sep 2023 15:11:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E35039C
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B9BC433C7;
	Thu, 14 Sep 2023 15:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694704272;
	bh=MK4/tz1thjYBFkmde73Spea+XOH0RrrHJJxgANJ6zWw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GAbCMN6x1JvaLjs183/lCyKr+XOpm1H9A2db1H4PemR/qxcYYT5srxOo6CDcpLMNh
	 AOyYwg0CdGJsR/CECMbVp5wI740KUUR0JX7z96J4KxxmfUXe3WZMGKsiCcACcjXwQX
	 ZFLJ5RENJN7Ua1nPHaKwbuwpGB+j6P7fRncuqjkVsyV+yPXX3ZqW4G9cYzgpUbKvca
	 kJaGCsAm3J9+6ZPyObwoaDsB9zpXmlXd3sM71okBHtTpeUg6vk+cGRxRBZ8j7Frw5M
	 wAviW3OlHjrr6xqg9c6jKNpXRsXBgLeZFYgpvRj0yYwcPmAqDWbd6z7qx5AZiKIWD0
	 497leh41pC2Wg==
Message-ID: <823f7b14-864f-6d60-99f7-e22c64e16488@kernel.org>
Date: Thu, 14 Sep 2023 09:11:11 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 14/14] ipv6: lockless IPV6_FLOWINFO_SEND
 implementation
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230912160212.3467976-1-edumazet@google.com>
 <20230912160212.3467976-15-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230912160212.3467976-15-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/23 10:02 AM, Eric Dumazet wrote:
> np->sndflow reads are racy.
> 
> Use one bit ftom atomic inet->inet_flags instead,
> IPV6_FLOWINFO_SEND setsockopt() can be lockless.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/ipv6.h     |  3 +--
>  include/net/inet_sock.h  |  1 +
>  net/dccp/ipv6.c          |  2 +-
>  net/ipv4/ping.c          |  3 +--
>  net/ipv6/af_inet6.c      |  2 +-
>  net/ipv6/datagram.c      |  7 ++++---
>  net/ipv6/ipv6_sockglue.c | 13 ++++++-------
>  net/ipv6/ping.c          |  2 +-
>  net/ipv6/raw.c           |  2 +-
>  net/ipv6/tcp_ipv6.c      |  2 +-
>  net/ipv6/udp.c           |  2 +-
>  net/l2tp/l2tp_ip6.c      |  4 ++--
>  net/sctp/ipv6.c          |  3 ++-
>  13 files changed, 23 insertions(+), 23 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



