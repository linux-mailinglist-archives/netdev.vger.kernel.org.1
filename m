Return-Path: <netdev+bounces-56877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA964811136
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 13:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9688C281979
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 12:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C4C28E1D;
	Wed, 13 Dec 2023 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mce/beJh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396A31798F
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 12:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97E6DC433C9;
	Wed, 13 Dec 2023 12:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702471225;
	bh=LWZlRMBHe0H98SVKK8tqTAevoocsLbabA7oaIVKPvFQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mce/beJhXjvJ387GmREl9pBsNR4MzX26fjEjWQWz7L2r+ZHx4UeWtakVVhRYoU9s/
	 +nOiQb21mfMJktzHsrIm8nhQDw2XPQB/U7yk+2Mb8cdeTFukhptpsjlVPsUxJchw3a
	 jEoSV7Fg8kTYzCCsYq40y7/FzhzfCeFgu7dfwEKigU360DsQ5IzjCqEwLqIT4SqIHs
	 zRwEY1O6LPmOgWVNyNYO6iZUMbSMjGNHhc3P0Kce5l/NMVQDavKx6REbWvlMOvfMIo
	 d/5N+tZd7+jMGRV77s0bX7a4DQAonrXFMZb1rbX8eIwVx0uJLBjs59jR9yhhbGIowX
	 EvBzkdTaur1VQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 809ADC4314C;
	Wed, 13 Dec 2023 12:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] ionic: updates to PCI error handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170247122552.30596.16162818098614293135.git-patchwork-notify@kernel.org>
Date: Wed, 13 Dec 2023 12:40:25 +0000
References: <20231211185804.18668-1-shannon.nelson@amd.com>
In-Reply-To: <20231211185804.18668-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com,
 drivers@pensando.io

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 11 Dec 2023 10:57:56 -0800 you wrote:
> These are improvements to our PCI error handling, including FLR and
> AER events.
> 
> Shannon Nelson (8):
>   ionic: pass opcode to devcmd_wait
>   ionic: keep filters across FLR
>   ionic: bypass firmware cmds when stuck in reset
>   ionic: prevent pci disable of already disabled device
>   ionic: no fw read when PCI reset failed
>   ionic: use timer_shutdown_sync
>   ionic: lif debugfs refresh on reset
>   ionic: fill out pci error handlers
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] ionic: pass opcode to devcmd_wait
    https://git.kernel.org/netdev/net-next/c/24f110240c03
  - [net-next,2/8] ionic: keep filters across FLR
    https://git.kernel.org/netdev/net-next/c/45b84188a0a4
  - [net-next,3/8] ionic: bypass firmware cmds when stuck in reset
    https://git.kernel.org/netdev/net-next/c/ca5fdf9a7c5b
  - [net-next,4/8] ionic: prevent pci disable of already disabled device
    https://git.kernel.org/netdev/net-next/c/13943d6c8273
  - [net-next,5/8] ionic: no fw read when PCI reset failed
    https://git.kernel.org/netdev/net-next/c/219e183272b4
  - [net-next,6/8] ionic: use timer_shutdown_sync
    https://git.kernel.org/netdev/net-next/c/b0dbe358fbb4
  - [net-next,7/8] ionic: lif debugfs refresh on reset
    https://git.kernel.org/netdev/net-next/c/ce66172d3393
  - [net-next,8/8] ionic: fill out pci error handlers
    https://git.kernel.org/netdev/net-next/c/c3a910e1c47a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



