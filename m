Return-Path: <netdev+bounces-23606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9802176CB42
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 12:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A33A281376
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE695697;
	Wed,  2 Aug 2023 10:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C85681
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 10:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 800DFC433C9;
	Wed,  2 Aug 2023 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690973422;
	bh=JnLFcnfysVi81T7FL8HFhcW1i3Esh7h9N3JnfgtdG+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XOGwSz95zkGNiQWiwVW9TewpKdXMbnCKdRbaEU6dVaBfITTdJS6j2z0Qssytb4ZsT
	 sBXOMnz8V1GUGvRLDUSGRv638E5D52p/gwyRhaMvpYARUB74cAdZ0Tx6CmagK71y0v
	 7zO6aFHGoFStUdt2PTs+pwZ5nMv6jqITeacbHH1wFFBIE9YiwCYvJbHVqglOkhNHlu
	 NlOTGc7jK8BxN4oUoP6GszHf3qrkPmo57HCzfsGD3yx4+UXDGV9rK5TvAO7ZcEj6Kv
	 ts/jeJFU+SuW0JK7nq4MYJP11cVCHhlCYp05MBm547/uQdrnLKjtmQ5+32hxNvEVzO
	 sPM1pAfaCu4VQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64F63C6445B;
	Wed,  2 Aug 2023 10:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/net: report rcv_mss in tcp_mmap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169097342241.23292.15941047594841616101.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 10:50:22 +0000
References: <20230731180846.1560539-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20230731180846.1560539-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 31 Jul 2023 14:08:09 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> tcp_mmap tests TCP_ZEROCOPY_RECEIVE. If 0% of data is received using
> mmap, this may be due to mss. Report rcv_mss to identify this cause.
> 
> Output of a run failed due to too small mss:
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/net: report rcv_mss in tcp_mmap
    https://git.kernel.org/netdev/net-next/c/bd60438eeb1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



