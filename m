Return-Path: <netdev+bounces-29964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8E9785630
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 12:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE851C20A12
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 10:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C616ABA28;
	Wed, 23 Aug 2023 10:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D779457
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEBE0C433D9;
	Wed, 23 Aug 2023 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692787822;
	bh=0QwIye9kBwY5Vr5DgQSC0Kgzt2/KlgF0x1Nw3tfzebY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YbR1lHIbggN6yDJWUpewYifUQRkdmDVWG+Q6BP8QzIeiQjVzPYZhEeqX5oS9fTaJW
	 IRgX7GhwZADYDjgD+D+inhSiIcmKXKKnpVV+G057WsdOVrgKrOUi18ZcKvIiLWTsOq
	 SorW7Dmn0o+RFp0nD3qheuanzLlsPO+0JcQEPZO3YxLOMUK5fLKUcIzwB/oBcaS/Ln
	 SLv3hF7kN5elq+XvjurbWEAJKxEwsxjB2b+kVw4fD3qnF6g8CzzANdaVdJcs6mycsK
	 Xidd+bC9ZFaV4I5thGcEdgJdqYSFcrgI9YgibnHi0lJ+NwBSE2aMyJaMY0WX7hBvSv
	 gIS2j7QxBJYuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B76D2C595CE;
	Wed, 23 Aug 2023 10:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bnxt: use the NAPI skb allocation cache
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169278782274.755.16011214260896057322.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 10:50:22 +0000
References: <20230822215142.1012310-1-kuba@kernel.org>
In-Reply-To: <20230822215142.1012310-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, michael.chan@broadcom.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 22 Aug 2023 14:51:42 -0700 you wrote:
> All callers of build_skb() (*) in bnxt are in NAPI context.
> The budget checking is somewhat convoluted because in the shared
> completion queue cases Rx packets are discarded by netpoll
> by forcing an error (E). But that happens before skb allocation.
> Only a call chain starting at __bnxt_poll_work() can lead to
> an skb allocation and it checks budget (b).
> 
> [...]

Here is the summary with links:
  - [net-next] bnxt: use the NAPI skb allocation cache
    https://git.kernel.org/netdev/net-next/c/e3b3a87967ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



