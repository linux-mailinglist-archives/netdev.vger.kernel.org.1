Return-Path: <netdev+bounces-30477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A889A78785E
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 21:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F97281562
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 19:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4058415AD6;
	Thu, 24 Aug 2023 19:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D2111CAF
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 19:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AABFC433C7;
	Thu, 24 Aug 2023 19:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692904226;
	bh=rwPVKvMFwPTglukeawxDljxe8sv9U6Q7h79nRwOMo1M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q/zO44aJJmsdI7Jxknl3sMa+xBwG+QF2a6diNd8mBC1gohcA4VZlb4FPwWlO+7QoL
	 /elPWXPoRebKddrua8YE2wbFvG4dH6lnP2EBdLaxLkoPNUoFxQw8hlYG2kR1KTxQAC
	 xaouAWJz1xv3JrwRKQpJqo+ejzg9ixFyrwo3p6+9npc6s4W9xsadIA3FP0kuqCHCsh
	 uXfc9BliJhB7uVYQwhis3a23WPbldBlPhPW9KJRAkTHZ877D2MBTGcfGbE5lbRuUxH
	 djR5bIx9buCkSvpnteeRPMfTzEISXUqNgf/GbdGD79KfvQ5pLv/6jkKVO9K/a8ZCh5
	 MxUlx7i7miqmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 197DEC395C5;
	Thu, 24 Aug 2023 19:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL v1] Please pull mlx5 MACsec RoCEv2 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169290422609.11645.14718872759290823619.git-patchwork-notify@kernel.org>
Date: Thu, 24 Aug 2023 19:10:26 +0000
References: <20230821073833.59042-1-leon@kernel.org>
In-Reply-To: <20230821073833.59042-1-leon@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@nvidia.com, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 linux-rdma@vger.kernel.org, maorg@nvidia.com, markzhang@nvidia.com,
 netdev@vger.kernel.org, pabeni@redhat.com, phaddad@nvidia.com,
 raeds@nvidia.com, saeedm@nvidia.com, horms@kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Aug 2023 10:38:25 +0300 you wrote:
> Changelog:
> v1:
>  * Removed NULL check in first macsec patch as it is not needed.
>  * Added more information about potential merge conflict.
> v0: https://lore.kernel.org/netdev/20230813064703.574082-1-leon@kernel.org/
> ----------------------------------------------------------------
> 
> [...]

Here is the summary with links:
  - [GIT,PULL,v1] Please pull mlx5 MACsec RoCEv2 support
    https://git.kernel.org/netdev/net-next/c/3c5066c6b0a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



