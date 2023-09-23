Return-Path: <netdev+bounces-35943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 875767AC100
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 13:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 2A10A1F22799
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 11:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA17C15E86;
	Sat, 23 Sep 2023 11:10:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8682567
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 11:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97646C433C7;
	Sat, 23 Sep 2023 11:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695467420;
	bh=G6v81uejH6j4JToJZhqDGFZIfPfAL+yoQGjuursMf0Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GIuVdFZ74fZyPEpIv/BCSFe8zoDgQ1QuRcEYkDYW+LBW4tTpU9o7zmqFGsu3qbw1R
	 6bcOMDI2yaPxGGq/faWSNqXDEbRwERxDs/4dhTN9B5QyKSyr5b5JhEaTEohTdhvhSO
	 h4KXgV37NSU7WC8lZwtMYLivCMlhaZc5OMbbXgElg1NOMpZp+iUlp+5WE9kM/Cx1/r
	 rPus1VfRDqYQ0fhsSRZK7vINy1N0pc7wGomWCSailXdPSZNpIz5CtJj79t4c9QhTXK
	 nFDklo4bGb+5xLOh1fHsEwVAgj+/rcUsHehp87Uz5jwyWsKcR0hu2KqUSQPoCLDkOq
	 0IJ2TTwFWN4Ng==
Message-ID: <14d4fc18-4cb5-abc5-8957-0d72cebda025@kernel.org>
Date: Sat, 23 Sep 2023 13:09:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 1/4] tcp_metrics: add missing barriers on delete
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230922220356.3739090-1-edumazet@google.com>
 <20230922220356.3739090-2-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230922220356.3739090-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/23 4:03 PM, Eric Dumazet wrote:
> When removing an item from RCU protected list, we must prevent
> store-tearing, using rcu_assign_pointer() or WRITE_ONCE().
> 
> Fixes: 04f721c671656 ("tcp_metrics: Rewrite tcp_metrics_flush_all")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp_metrics.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



