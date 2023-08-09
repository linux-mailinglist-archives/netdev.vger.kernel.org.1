Return-Path: <netdev+bounces-26039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBAD7769C6
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294AD1C21365
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE841DA2C;
	Wed,  9 Aug 2023 20:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD4D2453F
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 20:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95867C433CB;
	Wed,  9 Aug 2023 20:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691612422;
	bh=cd4gdOBnv+hTBKao2aZUkEYdG8/wUv7TUAypJSmZs1M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OwUekVn+FfU3C5uD2fv5G7Kff7DByY+kbu7oQi2sqAxn/hu8XX9OB58CowHc2Atnw
	 pipZN/vhFvKvROW7nAs2MEM9pt3mKerlDBx5mPfkrPcnDDZstL2K4psNinRlvLOBuN
	 gzWYORPscc19J38fldA+Mq7F+CcL22/5PLvM8UI1Ixl9L0gaan86XYcE77JyCqxwuk
	 2NQckr9ZGZajhBIxrTivBzpMmCc7/9dFE/jS7pPWqATxgLZPV4ORBwAgpKd/u3Mv2P
	 wx3eUE47P2OeIVKqiFvWXqiYxOOF2KEs5czgmt7zmCzI3cy90w65dwUOVQ7ODjET6d
	 toPybHKhwr6PQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DDAEE3308E;
	Wed,  9 Aug 2023 20:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl-gen: add missing empty line between
 policies
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169161242251.16318.5028490302810614272.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 20:20:22 +0000
References: <20230808200907.1290647-1-kuba@kernel.org>
In-Reply-To: <20230808200907.1290647-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, vadim.fedorenko@linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Aug 2023 13:09:07 -0700 you wrote:
> We're missing empty line between policies.
> DPLL will need this.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: vadim.fedorenko@linux.dev
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl-gen: add missing empty line between policies
    https://git.kernel.org/netdev/net-next/c/cd3112ebbaf4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



