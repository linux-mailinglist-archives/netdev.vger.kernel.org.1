Return-Path: <netdev+bounces-39416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD857BF11C
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 04:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A329281C49
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 02:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442E38F64;
	Tue, 10 Oct 2023 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIv4pLhW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3896C1870;
	Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97F6EC43391;
	Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696906225;
	bh=RWfYfisSlrkC3q8bAo6ZXhtYCjJgOwu0iOjtsmTdS/s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rIv4pLhWWKx7g+2URb+EL2iSSJCXxA+wWgL0JIVVGuX2OMWT/zXUvKqhzzFqy5P90
	 CXGb5VmS/iN++hCFmYG0tPzjn36z6Dn8HPGg/YkW0XX+cx1ngiwIJu8eQwJOu4LAsh
	 PzmQfRMHhkd5woxjUD1NiI9O3S8KOUt7uyreukqWa/RIMheIoizXEhMdukR08q3528
	 hquIOzCk8EXcU5HKtAEtYyrgzrmxYXdRDS+FM03Op1HXT38JbVN3vwZYPf7Clo+t0/
	 Fc9xe5i9b43iickzw83boVQJkfjqKwJosOfIozzRQwIuVnkr1pnrqRrq1pWyEI10Nb
	 N6T3msFnMcsIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B27AE11F48;
	Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bcm63xx_enet: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169690622543.548.4787561962344231209.git-patchwork-notify@kernel.org>
Date: Tue, 10 Oct 2023 02:50:25 +0000
References: <20231005-strncpy-drivers-net-ethernet-broadcom-bcm63xx_enet-c-v1-1-6823b3c3c443@google.com>
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-broadcom-bcm63xx_enet-c-v1-1-6823b3c3c443@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Oct 2023 20:51:40 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> A suitable replacement is strscpy() [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> [...]

Here is the summary with links:
  - bcm63xx_enet: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/0aba524728f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



