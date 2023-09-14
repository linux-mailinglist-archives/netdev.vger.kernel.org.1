Return-Path: <netdev+bounces-33888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FAC7A0900
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF63F2820F9
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B05B1CF83;
	Thu, 14 Sep 2023 15:08:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4100939C
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3C3C433C7;
	Thu, 14 Sep 2023 15:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694704115;
	bh=eJXzBDklBK2PzrkJi76s1vRd2WacLfJJSHFeXauH6fs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hZ6N/gG2IkMSbJP+UrBlQclafimQ/UXt69rz31URDVNs3gfXr/cJHwfCEy6GuILSm
	 WpyduI4cu7GoqdBtunEEUCAHPDir0qHNacAvLg/bK5oaEQXWcgTnZ3/e1mAS/0Egng
	 FOynM52tXnjKZvzGjP7Z+g29pY2kFnsuPxXaPj3drqXCcrgTVg9Ks7e8HvU4bq0YZO
	 nKu84Jy0ct21+HxOwGZTmh5a2oZRlMQX1wK6vJdxjGZPu5y71ociiulTbrfwsIYO3g
	 duWN6i8qnSzPoilRk7RR1IPZspVQLpct7QEvKgjd9iMpmhF6aZ+vKn+FgpqBEnamyV
	 snvk6rENI8zcA==
Message-ID: <95b7ac0d-4971-591b-f294-65a152320712@kernel.org>
Date: Thu, 14 Sep 2023 09:08:34 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 12/14] ipv6: lockless IPV6_ROUTER_ALERT_ISOLATE
 implementation
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230912160212.3467976-1-edumazet@google.com>
 <20230912160212.3467976-13-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230912160212.3467976-13-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/23 10:02 AM, Eric Dumazet wrote:
> Reads from np->rtalert_isolate are racy.
> 
> Move this flag to inet->inet_flags to fix data-races.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/ipv6.h     |  3 +--
>  include/net/inet_sock.h  |  1 +
>  net/ipv6/ip6_output.c    |  3 +--
>  net/ipv6/ipv6_sockglue.c | 13 ++++++-------
>  4 files changed, 9 insertions(+), 11 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



