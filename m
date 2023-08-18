Return-Path: <netdev+bounces-28983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BD6781561
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 00:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4EFC1C20D0C
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 22:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAF61C2B3;
	Fri, 18 Aug 2023 22:20:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286C21BF1F
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 22:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9E55C433CB;
	Fri, 18 Aug 2023 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692397227;
	bh=0siwSpzPAecerRDCRzE041XpLAcbPWf3qT5C89Iq5Os=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FQ0gnryK+NBlLZjHIioObpULhKTiIrEUG0fvJM/ua1qq+lIefYqsFI2rrboghWr5w
	 K88yGLSf/GYtpU6/7eUOPaOAveXdfFdPDx5krBrc3qja0dIZ3rbXCZBOQrmwWRoSJl
	 2Wjl3+g8oaqYO0yhUXbRj1Nl5w/13Rih/VV/tCyAv/zXaUQhpR2B2ndePstKgetqqp
	 +hYJtwyBprmlDnxLPrg6vfrJwTHzsNFkCHMavUxCNJ4l65RyQilM1RCae2oVsaWs7d
	 rM0h/M4DhSK/nZW3rpxlO5JWDo9Hy14Xz+uKV05qzLTn5yA3XPailxx/SERjE7/p3P
	 U1bxU1YPjwXEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D847E26D32;
	Fri, 18 Aug 2023 22:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fec: use napi_consume_skb() in
 fec_enet_tx_queue()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169239722757.24641.1884586305107929173.git-patchwork-notify@kernel.org>
Date: Fri, 18 Aug 2023 22:20:27 +0000
References: <20230816090242.463822-1-wei.fang@nxp.com>
In-Reply-To: <20230816090242.463822-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alexander.duyck@gmail.com, xiaoning.wang@nxp.com,
 shenwei.wang@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Aug 2023 17:02:42 +0800 you wrote:
> Now that the "budget" is passed into fec_enet_tx_queue(), one
> optimization we can do is to use napi_consume_skb() to instead
> of dev_kfree_skb_any().
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Suggested-by: Alexander H Duyck <alexander.duyck@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: fec: use napi_consume_skb() in fec_enet_tx_queue()
    https://git.kernel.org/netdev/net-next/c/91a10efc89dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



