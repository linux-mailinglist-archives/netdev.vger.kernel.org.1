Return-Path: <netdev+bounces-33885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408997A08F6
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494C81C20E7D
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E202718C34;
	Thu, 14 Sep 2023 15:05:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3131F610
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B11C433C8;
	Thu, 14 Sep 2023 15:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694703918;
	bh=CM3nlDHrEUQ57SL8Vfoq97vEQ0wcZ4jtUk/MDoNLItk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i+QzWZehk571NnV2o98gj3UO525duoS6UR8r6hk4FQh2OJlqv5vtbgyDtHpV1VgIq
	 /TFD4TnT1FrluB9b817IrMoDiYVdroIx65KHjSkV8jufoi1hCK0OSENRgO1Yk6gU5h
	 0HNzgtgbuhr8vYI2ObeRf9tWpNYwQN4GoLX3bydR72vdqT37ZaMvIdP/MpXcmnZRys
	 JHdT8AxabqSr0gIA45pgDXF69rPMapqRdhfTt0kmtDqz+WoMARIZOgGib97exAYEyQ
	 8IPdCE59RBDA8aOnEUDJUE51lRzu50kwvZmckEqq5SVVq8o0xUwf1vXyCTk10L/ooi
	 r5clQ/VzpgyiA==
Message-ID: <c918df63-be93-10e4-f621-3af7d3e1a79f@kernel.org>
Date: Thu, 14 Sep 2023 09:05:17 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 09/14] ipv6: lockless IPV6_DONTFRAG
 implementation
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230912160212.3467976-1-edumazet@google.com>
 <20230912160212.3467976-10-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230912160212.3467976-10-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/23 10:02 AM, Eric Dumazet wrote:
> Move np->dontfrag flag to inet->inet_flags to fix data-races.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/ipv6.h     | 1 -
>  include/net/inet_sock.h  | 1 +
>  include/net/ipv6.h       | 6 +++---
>  include/net/xfrm.h       | 2 +-
>  net/ipv6/icmp.c          | 4 ++--
>  net/ipv6/ip6_output.c    | 2 +-
>  net/ipv6/ipv6_sockglue.c | 9 ++++-----
>  net/ipv6/ping.c          | 2 +-
>  net/ipv6/raw.c           | 2 +-
>  net/ipv6/udp.c           | 2 +-
>  net/l2tp/l2tp_ip6.c      | 2 +-
>  11 files changed, 16 insertions(+), 17 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



