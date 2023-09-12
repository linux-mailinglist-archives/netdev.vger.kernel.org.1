Return-Path: <netdev+bounces-33331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D1C79D6C2
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2356E1C20C07
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0CF1C14;
	Tue, 12 Sep 2023 16:50:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446357F0
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0970C433CA;
	Tue, 12 Sep 2023 16:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694537425;
	bh=ijtyR3u0rQ4mCuDAN600HMX4Nqi7itcM/R8HVDKSWrI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uOcKwcl+QqmQkTx8/aVSiv2kRimCeZY8jjWaUtgAZ68Dql6tAacaPLGws//vdfO4Q
	 4FQ69QdDsuaODOvrFTezPQgYg9ln86xhjlS4oRfPKv+7fRYT6Gu6X7q27GZIHJZwbt
	 2FqQRKdlrb3Y39Qnp4UU9k4z2YhBB98JL9TtPXB0jU+SjgD4tCFqZGQiJBUEyArXOQ
	 dAkC+u3T53glIXd76HRjZYyB3LwSB0Hh2GmhzzAy8ustWftERw+HAQx5xi/vQHYx0X
	 aQTiV9HZCG3xGjTqztNl9i2ZUOg4c8HLKCTqQXSCdIwQKXsaR5Fp/zTm3dF13Fhv2R
	 pnVsSclCDTjyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9486BE1C280;
	Tue, 12 Sep 2023 16:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: fix ip6_sock_set_addr_preferences() typo
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169453742560.6355.5468481279280127612.git-patchwork-notify@kernel.org>
Date: Tue, 12 Sep 2023 16:50:25 +0000
References: <20230911154213.713941-1-edumazet@google.com>
In-Reply-To: <20230911154213.713941-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, hch@lst.de,
 chuck.lever@oracle.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 11 Sep 2023 15:42:13 +0000 you wrote:
> ip6_sock_set_addr_preferences() second argument should be an integer.
> 
> SUNRPC attempts to set IPV6_PREFER_SRC_PUBLIC were
> translated to IPV6_PREFER_SRC_TMP
> 
> Fixes: 18d5ad623275 ("ipv6: add ip6_sock_set_addr_preferences")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> 
> [...]

Here is the summary with links:
  - [net] ipv6: fix ip6_sock_set_addr_preferences() typo
    https://git.kernel.org/netdev/net/c/8cdd9f1aaedf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



