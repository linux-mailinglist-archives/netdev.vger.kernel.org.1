Return-Path: <netdev+bounces-249185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4F4D155A1
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59E07301AE10
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CE730F54A;
	Mon, 12 Jan 2026 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+AHMIMy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BD013D51E;
	Mon, 12 Jan 2026 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251664; cv=none; b=CI/7zsCyaPMJexjPb7lEIydaeNozoB6H+fpA4myC+v6UHxCfFebXwIuNbXvIWnb2mPnimozFwLZnycLa8TuBz+thaAm7NH28rZHg9t96Ww4WX81lT2NbmR55f16ourIapFvvHFilcNDnn+s2M2LcX5PwRAV6/B+2FmmUv54A1R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251664; c=relaxed/simple;
	bh=T+IbXCejgGPTwazYt8b8/MgJnTovhi18mU8GBYKL28Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f7IGbD9aBa3eTnDHrqkmwvcDD9fVcp5VPJZ2tQSw3sQeWT7pV72iOmu5/6DvIOoABo2ywbVab821QMscBI29xxXczMWsuFK/9ZhYrdVnITzX0A+VPlMGDXqyCW/XKfrwbABZudAdtDiUEMfvqcktTgIUjalt5HDKRsq2I06LzxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+AHMIMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92712C116D0;
	Mon, 12 Jan 2026 21:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768251663;
	bh=T+IbXCejgGPTwazYt8b8/MgJnTovhi18mU8GBYKL28Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M+AHMIMyhZscO8ufIpDuBwGklKaZG/QYW5xSWyZ2t7NLb5EQUmDUgjYzEniS/xljJ
	 4heZ6bzvD8yRV4CpJyJZg8n9IwGt0VPIlEJL+PzlaxG04oQbY97f7fr1+HVmsHpPdA
	 rAbnuMevXhCLB7R4zvPuwU7VB8GqWsW/06Q4q4oTWn7E36U0wztAEn2q3USVVU+wj8
	 LZUsTE3wXJhpYGeNrZGFkzMTg6H1IITBz8gKllHDeF2QnsKVvVkDavYirpNX3ABEXC
	 S+oBoZrdPbIcw/+cM4Cerbvris5YclUKvpcYnprQqYbsdEkmPKq84P3i/BBzavSwIC
	 vONZXVha/UGIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B6350380CFD5;
	Mon, 12 Jan 2026 20:57:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net-next v1] net: ethernet: ave: Remove unnecessary
 'out of memory' message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176825145730.1092878.10545402450455276257.git-patchwork-notify@kernel.org>
Date: Mon, 12 Jan 2026 20:57:37 +0000
References: <20260109103915.2764380-1-hayashi.kunihiko@socionext.com>
In-Reply-To: <20260109103915.2764380-1-hayashi.kunihiko@socionext.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  9 Jan 2026 19:39:15 +0900 you wrote:
> Follow the warning from checkpatch.pl and remove 'out of memory' message.
> 
>     WARNING: Possible unnecessary 'out of memory' message
>     #590: FILE: drivers/net/ethernet/socionext/sni_ave.c:590:
>     +               if (!skb) {
>     +                       netdev_err(ndev, "can't allocate skb for Rx\n");
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next,v1] net: ethernet: ave: Remove unnecessary 'out of memory' message
    https://git.kernel.org/netdev/net-next/c/11ed2195887d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



