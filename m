Return-Path: <netdev+bounces-19329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D471975A4E2
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 05:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8D1281C00
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 03:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64BB10F5;
	Thu, 20 Jul 2023 03:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0F4A31
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 03:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A28EC433C9;
	Thu, 20 Jul 2023 03:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689825020;
	bh=2jgCgWh1deu9jf3CbJxs+XKpugIkwpfkYRmFyAF0vJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X8J7ZI2usMkyYUBTGA8xGs2WzGXh/eB9zDS2XGHAZWdxEJGcr29kgjZO/+JsExN6z
	 dEYkNqZJMLXmerUKpn9vt6Z7wVZHyGI8RR9DDHbJ4pkyvFahSRkUtbGKSteOsekJep
	 lX7BOTes2QacstZplh54v6UUzYy8YdsyBpt4B9gjNtbLwX4HgcSJwrQ/ABlsNu7dBJ
	 31epCmG3gM8uCxYxx2bTfdKfq3hLm8QKDE8TkSk9U2yyvPJIHKIKDIz48XkAul77Bv
	 u9ss59KX+RQfL3+Rc3PTL0x+MgmcXRcfyhHAemwRDGSRU32LiZ+vQG7uYo5svrQTSg
	 +Tv0hINBiIEtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6118CC6445A;
	Thu, 20 Jul 2023 03:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] xfrm: delete not-needed clear to zero of encap_oa
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168982502039.32453.1486432439604353693.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jul 2023 03:50:20 +0000
References: <20230719100228.373055-2-steffen.klassert@secunet.com>
In-Reply-To: <20230719100228.373055-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Wed, 19 Jul 2023 12:02:28 +0200 you wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> After commit 2f4796518315 ("af_key: Fix heap information leak"), there is
> no need to clear encap_oa again as it is already initialized to zero.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> 
> [...]

Here is the summary with links:
  - xfrm: delete not-needed clear to zero of encap_oa
    https://git.kernel.org/netdev/net-next/c/a94fd40a18ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



