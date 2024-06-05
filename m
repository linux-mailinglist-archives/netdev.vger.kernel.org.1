Return-Path: <netdev+bounces-101012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 905C88FD067
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 16:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79AAAB3237D
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC6F1990B0;
	Wed,  5 Jun 2024 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/OmKoe0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44C9194A43;
	Wed,  5 Jun 2024 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593032; cv=none; b=lnukRqO9bn+AVW9SgL+Gd+asrRuqAsfj6k/GBGUISi3d2btgXLba91BXXTnsu3Ih9LWk3UWtGWEOcJPgoEQlaJwEs9/WOoeywFxMBgQFo7LpZkDso0lHOQjM/CG0LICaFFNVYnewDCsUwEq20zO9WF6zLbzPY8imm46E0JJGJls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593032; c=relaxed/simple;
	bh=u3bAQnWwZ28p/kNsVqk2e4u6Iq8eIG5zznvzDkYoUog=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RYgaCMoEhKQZ6oMw8qX4Y8xj4d8kdgBLrcBZhy1b1LvYbOrmAOdDB7LF1mvLci12mvzRK9qdEUushXEiXj6gbDlQ15x25wMJqlIwpbiBBTNu+7R7rSbXwGZ9x9YfmhnQRs5Nuyyw5hrmA7+CaJCjul9nZpRway7Z8Qs8sZNhIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/OmKoe0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 844D4C32782;
	Wed,  5 Jun 2024 13:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717593031;
	bh=u3bAQnWwZ28p/kNsVqk2e4u6Iq8eIG5zznvzDkYoUog=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k/OmKoe09Hnm9ndfZnuOCZUr5Of+DpVHDTCZ2aB1AuRqQycgkANEzX5Mhejcjt6or
	 eF/GEgPsSTorLYM5jtvxNLaNoSgld5P0WGOgqBNOAjhFWjVgK9xP6BSckBSBTOY2Ny
	 v7y3yyhCyfuDxo6tvjYtyjCpXSOmiclyiivveMrkLJJ0lvXq2A58doanTU1ntfaSpR
	 qsNk6Q2BIm6uP88sHhJJvXuzkgm4yY/WI+ysX0VdgB/UI6wV1LDWGP9GkznMdaxZXF
	 v/FevXfVS3lkD4MAX3jLb28EhlZXt4vy4DcK6fITG2ozKSIgL9rCglsxaEfCJJKGUa
	 oMBv3cVpEaW7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D3E0D3E99A;
	Wed,  5 Jun 2024 13:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net v3] net: ethernet: mtk_eth_soc: handle dma buffer size soc
 specific
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171759303143.15829.1231118828058253183.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 13:10:31 +0000
References: <20240603192505.217881-1-linux@fw-web.de>
In-Reply-To: <20240603192505.217881-1-linux@fw-web.de>
To: Frank Wunderlich <linux@fw-web.de>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 lorenzo@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, frank-w@public-files.de,
 john@phrozen.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 bc-bocun.chen@mediatek.com, daniel@makrotopia.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  3 Jun 2024 21:25:05 +0200 you wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> The mainline MTK ethernet driver suffers long time from rarly but
> annoying tx queue timeouts. We think that this is caused by fixed
> dma sizes hardcoded for all SoCs.
> 
> We suspect this problem arises from a low level of free TX DMADs,
> the TX Ring alomost full.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ethernet: mtk_eth_soc: handle dma buffer size soc specific
    https://git.kernel.org/netdev/net/c/c57e55819443

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



