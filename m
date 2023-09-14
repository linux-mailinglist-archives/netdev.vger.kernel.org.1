Return-Path: <netdev+bounces-33884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D897A08F2
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0661F2406C
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AEA15E96;
	Thu, 14 Sep 2023 15:04:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3855F28E08
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445F8C433C7;
	Thu, 14 Sep 2023 15:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694703881;
	bh=rMTmQXBe8WoFPN8jET/DCOPZ8JW2S8xRGLFvqZ2obas=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kfc53uohRlT2I07ItOE6GSrlB/bEWstkLaFcGp7MlqPnerKWlAyg5NuPLrcl3b8qt
	 NIhymep8vsWZXSwicLu9C4x482eyZTndIOvz/nH9dt9KH0MaiuQzB9Qj8BVPSfbbcp
	 0JMWVDlyBefk2mJo3t1d++MsUoivKjMmkH8irKHwA7c7R4ItWKqQ+rODeEbEnFR/hm
	 ZsHoWUtsy2VLPjVhEx/Z3/Di9i8r1U3Wf4PyBg04+UQdBSq29b2jA0gKBX8rWNIu20
	 JF8473h3aQGbcBRSIpvo1rJ/GRIIcVPeInPzKpaQ3DQrFKU9cxAsC1fRxvleenU79s
	 SchOp6CijxZ6g==
Message-ID: <87d30047-dd29-d9bb-2f77-20ea52d69ff2@kernel.org>
Date: Thu, 14 Sep 2023 09:04:40 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 08/14] ipv6: lockless IPV6_AUTOFLOWLABEL
 implementation
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230912160212.3467976-1-edumazet@google.com>
 <20230912160212.3467976-9-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230912160212.3467976-9-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/23 10:02 AM, Eric Dumazet wrote:
> Move np->autoflowlabel and np->autoflowlabel_set in inet->inet_flags,
> to fix data-races.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/ipv6.h     |  2 --
>  include/net/inet_sock.h  |  2 ++
>  include/net/ipv6.h       |  2 +-
>  net/ipv6/ip6_output.c    | 12 +++++-------
>  net/ipv6/ipv6_sockglue.c | 11 +++++------
>  5 files changed, 13 insertions(+), 16 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



