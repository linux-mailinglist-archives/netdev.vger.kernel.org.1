Return-Path: <netdev+bounces-33890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF28C7A0907
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65DE41F23898
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6858B1BDC0;
	Thu, 14 Sep 2023 15:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3684339C
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7744EC433C7;
	Thu, 14 Sep 2023 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694704221;
	bh=JXliuxeCcf+hYzMjTQnEi1CA816lZz/LUehe4Lt64EE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CL2r3LhE/FU2YAvXdoBz8Rzt+Y34fQO0c6e9XWm5bzb5u+DEQ13JRoE87eB1ZltNg
	 Ubj5ShemrLy7DQQRA0PCjr7EA5pNG8fC4VYDtLvfp8wj/78hfp0jH4Txk5KKhIJk6P
	 iMhtP63qWZU/AQ/AbRDUUZB/QnfdsaUqTYlE7dqG9/ZmfAkGN6bM1ocRnx86IL1/Xe
	 SybRzahunJDFIRldVgjp46thZr1iQJcawThHv9cdrU2Q5u0qspMwVykebJocrb2Ne+
	 xOZ8Uj29xJtMFEZQSFK1CbZ5rXxgq57yTOlOW6Jw3nvTbAtIr1Ch4O/lee1iB2wQ+s
	 yqR559l6DZ7Sg==
Message-ID: <bd4dad72-2f4f-79a0-8660-fd5ea6f95c06@kernel.org>
Date: Thu, 14 Sep 2023 09:10:20 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 13/14] ipv6: lockless IPV6_MTU_DISCOVER
 implementation
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230912160212.3467976-1-edumazet@google.com>
 <20230912160212.3467976-14-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230912160212.3467976-14-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/23 10:02 AM, Eric Dumazet wrote:
> Most np->pmtudisc reads are racy.
> 
> Move this 3bit field on a full byte, add annotations
> and make IPV6_MTU_DISCOVER setsockopt() lockless.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/ipv6.h            |  5 ++---
>  include/net/ip6_route.h         | 14 +++++++++-----
>  net/ipv6/ip6_output.c           |  4 ++--
>  net/ipv6/ipv6_sockglue.c        | 17 ++++++++---------
>  net/ipv6/raw.c                  |  2 +-
>  net/ipv6/udp.c                  |  2 +-
>  net/netfilter/ipvs/ip_vs_sync.c |  2 +-
>  7 files changed, 24 insertions(+), 22 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



