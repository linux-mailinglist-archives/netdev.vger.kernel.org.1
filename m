Return-Path: <netdev+bounces-33882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C907A08EC
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6361C20D71
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6330A18E05;
	Thu, 14 Sep 2023 15:03:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC4828E08
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2FBC433C9;
	Thu, 14 Sep 2023 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694703825;
	bh=WCPZHwZt2o/yN/NOj21L9Wh/ZK07F6R74pgaSVTD+D8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bxHjr+HJ70fZe7nfnhoZEyP3yLlsHbUdqpZcutQLdZDPZPIsQ3vSzHWgAsfOT/VCl
	 Cpf7mEgggenTkxXOOxU2WaqqDsN5+iEcBbiEqU2EuFIT9I8zgDT3SARX0EaP5gf6Gq
	 kMqysrKVNGRT0V+70IGM6/5+G//WBVYJ60X1LfcZW9c30lyebHDIMN57A7pbf3LZJ/
	 oFUEqIBAaIOvTFySP9+ZrC2fdJscT32h8cXKx33XZZhYiV3HgfbaYHF9nnGnraPvsR
	 c460W7hF+6Q6H0Or1Pd+SLbEcXiGRLrNLYvxThpaD6kfrSPoDBavalHPbv4cXUFOCG
	 rzSoJSNLaLZEw==
Message-ID: <5e624b57-923c-0592-2d97-cc3d08839c26@kernel.org>
Date: Thu, 14 Sep 2023 09:03:44 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 07/14] ipv6: lockless IPV6_MULTICAST_ALL
 implementation
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230912160212.3467976-1-edumazet@google.com>
 <20230912160212.3467976-8-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230912160212.3467976-8-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/23 10:02 AM, Eric Dumazet wrote:
> Move np->mc_all to an atomic flags to fix data-races.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/ipv6.h     |  1 -
>  include/net/inet_sock.h  |  1 +
>  net/ipv6/af_inet6.c      |  2 +-
>  net/ipv6/ipv6_sockglue.c | 14 ++++++--------
>  net/ipv6/mcast.c         |  2 +-
>  5 files changed, 9 insertions(+), 11 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



