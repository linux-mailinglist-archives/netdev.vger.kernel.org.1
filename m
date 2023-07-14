Return-Path: <netdev+bounces-17858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8FB7534C0
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 10:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE2D1C2159C
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 08:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A1879F0;
	Fri, 14 Jul 2023 08:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4779E1
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 08:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C159C433CB;
	Fri, 14 Jul 2023 08:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689322221;
	bh=Jx2+15zQhjpNk6e3HbcwaX9VEt65C3lrUYRs2gzXBMI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q2FTq4WjgudshYJ4MfGx3OtginjBf0WZaoim3wGcsQGZmm33bCv2e/5AXzl5lSwW4
	 3vvL+4Aw3Qv4wIPLJjBFbh/YPc3KqeA/Z4gybUeM15ty3SJAoHEbcInaQNv2wbFjqs
	 GSv0uiqBHFgdGMI2x0e2SSDHaeI/o+HIs1SElXXqoycGCKkbAIcp6/0IoCD9VdX3FA
	 kllJvrwUOJAVr6493tNaxucnqBpIVjEpkCJ98LcEsAfuXedPmLp0P6qCcl27OB7tAI
	 wp09pqSYZbtmIksCw35J1lk5YH6qJ9dqR0fYaDZAyLZK+r2YD1ouASuGKIMa57ZPDZ
	 2RY4lEnjonZIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 438FCE49BBF;
	Fri, 14 Jul 2023 08:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bna: Remove error checking for debugfs_create_dir()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168932222127.28600.2169782274077317127.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jul 2023 08:10:21 +0000
References: <20230713095118.4807-1-machel@vivo.com>
In-Reply-To: <20230713095118.4807-1-machel@vivo.com>
To: =?utf-8?b?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqCA8bWFjaGVsQHZpdm8uY29tPg==?=@codeaurora.org
Cc: rmody@marvell.com, skalluru@marvell.com, GR-Linux-NIC-Dev@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com, rdunlap@infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jul 2023 17:51:06 +0800 you wrote:
> It is expected that most callers should _ignore_ the errors return by
> debugfs_create_dir() in bnad_debugfs_init().
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 5 -----
>  1 file changed, 5 deletions(-)

Here is the summary with links:
  - [net,v2] bna: Remove error checking for debugfs_create_dir()
    https://git.kernel.org/netdev/net/c/4ad23d2368cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



