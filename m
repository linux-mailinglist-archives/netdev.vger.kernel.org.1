Return-Path: <netdev+bounces-29173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44728781F2C
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 20:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CB2280FAE
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 18:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A621C6AA4;
	Sun, 20 Aug 2023 18:13:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F16E63D6
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 18:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC2E8C433CA;
	Sun, 20 Aug 2023 18:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692555209;
	bh=qlUFJFMGKJEyRNhMsZWpsnU76hWFMDPbhjPCg6ohHzI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xffz+Ioy3Tprjd7jpX81Y8FaJqLL9cNZqH7nRQfKQtKMoUzNQjH96B9mz2ru6Lhtg
	 CxVydaFNyTr41f97Htr4pq8Uf+9+UgjO5uGeYY07biFvZfaRtzfbFUR9IqOz4wfgOL
	 JxIxtkrldI1kPQDnd6gzCr30giUnqrxyOaDZRwa5oeDdxbMSAtEaNHIlNyjtcNmZMc
	 fkp0Z785NyGhLy6YyaKN8c1obaddTY1m1sfPBwQ0SeI1SAzoWW9tdVLz0AQKyHlups
	 Bh4AXAESBk2dzSNzpgmQtGx0+T48jnwMl+buRTYRQq3tXybtglxnuJZRL/iJwmQcuz
	 v+Oat0Oj/46Dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6ABFC395C5;
	Sun, 20 Aug 2023 18:13:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: release reference to inet6_dev pointer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169255520981.4244.4865009702396255151.git-patchwork-notify@kernel.org>
Date: Sun, 20 Aug 2023 18:13:29 +0000
References: <20230818182249.3348910-1-prohr@google.com>
In-Reply-To: <20230818182249.3348910-1-prohr@google.com>
To: Patrick Rohr <prohr@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, maze@google.com,
 lorenzo@google.com, dsahern@kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 18 Aug 2023 11:22:49 -0700 you wrote:
> addrconf_prefix_rcv returned early without releasing the inet6_dev
> pointer when the PIO lifetime is less than accept_ra_min_lft.
> 
> Fixes: 5027d54a9c30 ("net: change accept_ra_min_rtr_lft to affect all RA lifetimes")
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Simon Horman <horms@kernel.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Maciej Żenczykowski <maze@google.com>
> Signed-off-by: Patrick Rohr <prohr@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: release reference to inet6_dev pointer
    https://git.kernel.org/netdev/net-next/c/5cb249686e67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



