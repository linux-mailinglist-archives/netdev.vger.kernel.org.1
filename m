Return-Path: <netdev+bounces-12397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B1A737501
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 21:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 234F22813C1
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 19:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9165017FE4;
	Tue, 20 Jun 2023 19:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412D0171AA
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 19:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBA83C433C8;
	Tue, 20 Jun 2023 19:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687288819;
	bh=gQQVz6y9GXtfawuuXQWfZrUW1kvaqS4fnl2EBDOLsf4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TTfp8ihBTW4VUcIpuWqGT2KGMjeO622VhOaGNTiwJB8McQcR+EhUHIJuL1t7loGDw
	 2GQGk/0U1vXt++1lhkKAHQkLZoaERpwOLSTziIBe3W6reGHAIx5xWgNudal9ISjFOj
	 KutN7ERVI+AH3GTXig/9NLlsFVQLYKdVnVAV1wqie213PKFW5Ey+KxhKu8Wxyn6vH9
	 YXTR0XCAvXgJwPCyt8zEtvzhcRvGJgr9iDXReTqQBTbSakE36VV/1gTAcZHRN/7xZG
	 VQiayqQ/I6y/BQ1XNiRLJj7uepdsW0p4nedrS3MzFVEMTStrLYRDoByROpE7qVHQiF
	 VcWGHlVUInUNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B274EC43157;
	Tue, 20 Jun 2023 19:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: fec: allow to build without PAGE_POOL_STATS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168728881972.9715.3661763087644511870.git-patchwork-notify@kernel.org>
Date: Tue, 20 Jun 2023 19:20:19 +0000
References: <20230616191832.2944130-1-l.stach@pengutronix.de>
In-Reply-To: <20230616191832.2944130-1-l.stach@pengutronix.de>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, wei.fang@nxp.com, shenwei.wang@nxp.com,
 xiaoning.wang@nxp.com, linux-imx@nxp.com, andrew@lunn.ch,
 netdev@vger.kernel.org, kernel@pengutronix.de, patchwork-lst@pengutronix.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Jun 2023 21:18:32 +0200 you wrote:
> Commit 6970ef27ff7f ("net: fec: add xdp and page pool statistics") selected
> CONFIG_PAGE_POOL_STATS from the FEC driver symbol, making it impossible
> to build without the page pool statistics when this driver is enabled. The
> help text of those statistics mentions increased overhead. Allow the user
> to choose between usefulness of the statistics and the added overhead.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - net: fec: allow to build without PAGE_POOL_STATS
    https://git.kernel.org/netdev/net-next/c/857922b16bb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



