Return-Path: <netdev+bounces-15982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C891174AC8A
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 10:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ABA62816AB
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 08:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469188BFF;
	Fri,  7 Jul 2023 08:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04BA538A
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 08:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B0E3C433CA;
	Fri,  7 Jul 2023 08:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688717422;
	bh=aohNnOH0wvs9TSAr0wvY7il4dGP5lxM3YQ3nxa4VZHU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CfPkHreF+wDoTOjvr9MeEFEnnKukicbTbSU4fAi8w3sufLdxsXi9CgrJ7p1VQSKrx
	 oyus0qcrXPl+HKEIo7ZxjMG4b6LAz8Zx0wmQ91hCoBIdU2/kHyRTCepVw7T6dtN/7x
	 0QZSbhiKRGDD5ohifyXuZHlCSaYpLXRyct4fF7H7G3Mq5gN6R7LnRbHv8yVJySLvrx
	 GzJfWw1YEmuch8yyem/T9MfafYe02Splv3BXkK0UCd980+erBQQT00i4vg0OhTAkk1
	 tfAojHF3EThAGRoIMmTFEDLh3AgQd1PPJXiH9aMaB4MhGocXRx0oPylC2P/Lbs2t9N
	 vgSaloznttwhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 109BFC73FEB;
	Fri,  7 Jul 2023 08:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] octeontx2-af: Promisc enable/disable through mbox
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168871742206.16578.3681415561880198567.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jul 2023 08:10:22 +0000
References: <20230706042705.3235990-1-rkannoth@marvell.com>
In-Reply-To: <20230706042705.3235990-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michal.kubiak@intel.com, sgoutham@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, sbhatta@marvell.com,
 gakula@marvell.com, schalla@marvell.com, hkelam@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 6 Jul 2023 09:57:05 +0530 you wrote:
> In legacy silicon, promiscuous mode is only modified
> through CGX mbox messages. In CN10KB silicon, it is modified
> from CGX mbox and NIX. This breaks legacy application
> behaviour. Fix this by removing call from NIX.
> 
> Fixes: d6c9784baf59 ("octeontx2-af: Invoke exact match functions if supported")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net,v1] octeontx2-af: Promisc enable/disable through mbox
    https://git.kernel.org/netdev/net/c/af42088bdaf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



