Return-Path: <netdev+bounces-37287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5156C7B486F
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 17:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 486EFB20A5D
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 15:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F3F18AEE;
	Sun,  1 Oct 2023 15:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B349D17985
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 15:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 210F3C433C9;
	Sun,  1 Oct 2023 15:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696174824;
	bh=purhxorVw7LwlaXYjSNQv6wHSRtD7IgbRpkibSkp2LM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r8zFtYR74fjSzQzVfGNyCrjPUyBeJ3cYRGFSgh5P9Kl9k1c+9BfhJZI3mSFlOhyEl
	 M5LVOQQLQp27o7Jzwo64BplQmtVDIpUAYlUsx1zD4vW2q1DrDH5Aa0n9rX3BmCddPt
	 tb9EIaczh+p7Dp62CztJIBQM5UxbgIF6O+4XzNegMcnVM1IFm6B4hyG3srBSSluguX
	 4X/EA5/8qUqE+6yvQ/UTfBIjeapqNv3LRHF6I4lGi2vLQGFbIdk06DFIJ3ha+vwNKS
	 W5apkGY8cd4y2A7tpoc2yJUIZywmK4JrQFL3pcKhXNb7ZyV6OhgMZH6Y+675GcY8nv
	 sHO9FgcVSM9XQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0547BC64457;
	Sun,  1 Oct 2023 15:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/3] net: use DEV_STATS_xxx() helpers in
 virtio_net and l2tp_eth
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169617482401.6513.935207423305903169.git-patchwork-notify@kernel.org>
Date: Sun, 01 Oct 2023 15:40:24 +0000
References: <20230921085218.954120-1-edumazet@google.com>
In-Reply-To: <20230921085218.954120-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 simon.horman@corigine.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Sep 2023 08:52:15 +0000 you wrote:
> Inspired by another (minor) KCSAN syzbot report.
> Both virtio_net and l2tp_eth can use DEV_STATS_xxx() helpers.
> 
> v2: removed unused @priv variable (Simon, kernel build bot)
> 
> Eric Dumazet (3):
>   net: add DEV_STATS_READ() helper
>   virtio_net: avoid data-races on dev->stats fields
>   net: l2tp_eth: use generic dev->stats fields
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/3] net: add DEV_STATS_READ() helper
    https://git.kernel.org/netdev/net-next/c/0b068c714ca9
  - [v2,net-next,2/3] virtio_net: avoid data-races on dev->stats fields
    https://git.kernel.org/netdev/net-next/c/d12a26b74fb7
  - [v2,net-next,3/3] net: l2tp_eth: use generic dev->stats fields
    https://git.kernel.org/netdev/net-next/c/a56d9390bd60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



