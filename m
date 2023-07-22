Return-Path: <netdev+bounces-20090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7213F75D8E5
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 04:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C16F28258F
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 02:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82A28495;
	Sat, 22 Jul 2023 02:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59FE6AA2
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 02:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44F97C433CA;
	Sat, 22 Jul 2023 02:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689991821;
	bh=NsVDJrTzHCTfk8A4cWwuC63k40cnWCTHfx0WfweVvFY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qe5A99JmGjOgeRtdnYLRZIlOPtafedXlKlLoXe1JE0On3nmH2O0kUQTwZcLrVRXrq
	 SaD9TnTvUAeAy5jbPJbfQEGTZO0uPWDa4oqELApkM+fmwPR9RTJiN2fM3dh3R5oawZ
	 Miu4W/VcJgTCx7DmzTCyuIP4ZO0SVhFG+E+6osFIBlD1ektivMo0ce17sPH6in6pys
	 5SaixDc5sD8Qv9lSOjcr/ZP9VGW3fJB1IRA8MKnhrUUffLLEpV1NJZpU5WO4FglMBY
	 8XSYxjE9C/9hZTgRXhvesKZGYKllwZIGpV5n6E84tfJZGdP1RH9KtBuERcAcnHJ6fL
	 zyY93/X7X1Z8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32B54C595C0;
	Sat, 22 Jul 2023 02:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net: page_pool: remove page_pool_release_page()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168999182120.11383.7390715293643733630.git-patchwork-notify@kernel.org>
Date: Sat, 22 Jul 2023 02:10:21 +0000
References: <20230720010409.1967072-1-kuba@kernel.org>
In-Reply-To: <20230720010409.1967072-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Jul 2023 18:04:05 -0700 you wrote:
> page_pool_return_page() is a historic artefact from before
> recycling of pages attached to skbs was supported. Theoretical
> uses for it may be thought up but in practice all existing
> users can be converted to use skb_mark_for_recycle() instead.
> 
> This code was previously posted as part of the memory provider RFC.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] eth: tsnep: let page recycling happen with skbs
    https://git.kernel.org/netdev/net-next/c/b03f68ba26c8
  - [net-next,2/4] eth: stmmac: let page recycling happen with skbs
    https://git.kernel.org/netdev/net-next/c/98e2727c79d0
  - [net-next,3/4] net: page_pool: hide page_pool_release_page()
    https://git.kernel.org/netdev/net-next/c/535b9c61bdef
  - [net-next,4/4] net: page_pool: merge page_pool_release_page() with page_pool_return_page()
    https://git.kernel.org/netdev/net-next/c/07e0c7d3179d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



