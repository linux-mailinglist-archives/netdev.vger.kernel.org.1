Return-Path: <netdev+bounces-35572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91AA7A9C17
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4422825CC
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D479CA73;
	Thu, 21 Sep 2023 19:03:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A0017737
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDEDC433C9;
	Thu, 21 Sep 2023 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695323000;
	bh=c3bN5RdUOwaiT612FMG/5YYA8X4vBPUc59XmKynGO+M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zl/4qx0DGNVCwGXVAHJoPY6HbS23cODZzxLBo+X32tyMSXNkfdpf8c1YOwBn3IgV0
	 NeybeYrXft4xz6NIFrjvwJ+RLNRfVQ4FQEOyj945iamsRMz0fhZ8A2SQouYAplbC6X
	 A1tAmHN+DcP/pB49rdbUEafU0bbvM+a/gsc0R0zKAGp6Xgg3sEIzs4HTrlfsrmlsG4
	 6DGCWJ6L/299Cs7ismEOJU4EI/PTHNvsa1nfl8w+Sb7RKKQr7LzUb2SRisR09ZVC+E
	 AkyxMasy4pIvRnZVQNVNfS8qm2tX9tRzz+CmScZTM74lmj9QkYUscODvAN/E4B6yrV
	 azwDH+ll8ixSQ==
Message-ID: <e303dccf-7809-833a-58c7-e347d7c17610@kernel.org>
Date: Thu, 21 Sep 2023 13:03:19 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 2/8] inet: implement lockless IP_MTU_DISCOVER
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230921133021.1995349-1-edumazet@google.com>
 <20230921133021.1995349-3-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230921133021.1995349-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/23 7:30 AM, Eric Dumazet wrote:
> inet->pmtudisc can be read locklessly.
> 
> Implement proper lockless reads and writes to inet->pmtudisc
> 
> ip_sock_set_mtu_discover() can now be called from arbitrary
> contexts.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/ip.h                | 13 ++++++++-----
>  net/ipv4/ip_output.c            |  7 ++++---
>  net/ipv4/ip_sockglue.c          | 17 ++++++-----------
>  net/ipv4/ping.c                 |  2 +-
>  net/ipv4/raw.c                  |  2 +-
>  net/ipv4/udp.c                  |  2 +-
>  net/netfilter/ipvs/ip_vs_sync.c |  2 +-
>  7 files changed, 22 insertions(+), 23 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



