Return-Path: <netdev+bounces-247239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B05CF616C
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 01:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96E15300FBEF
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 00:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E9F1E7C34;
	Tue,  6 Jan 2026 00:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXCHUxMH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8E81E5724
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 00:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767659616; cv=none; b=IOBD6sjGm7fdTh9g4I74UKZOln7oUeLEwAQ/VpofYO/Lxnom0KC1hm+MZNHqz/p0HLr1i1tqtF6Br8FaiAua7cIPPp93jAs02vhXPOdbfj+NTjsIW+RESF2Qk2yR3OgfgLAFWTnYTcF0FzCzp/9796c6Wzz4YDmEvxC23qK7704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767659616; c=relaxed/simple;
	bh=43Yo18+TKFmz9SxuJ+aN5IMhsbRVzkzo4rD++TRu42I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zw/W1DSZjqv6MaBhwtqOVV7Ck1eDN1IAjPi7N744KgNRaoeuga/FYqtC0Ba0/OC0aa6lV5eOLhDVbbGioDuDOot3IoOMz5Of0shE/Z+INnOwWpscswnreDaXTMmVbR5y8qAWgX3O2PY8KHTXhJvfPmI7BVzmB+Eyk92tnY95i4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXCHUxMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AB8C16AAE;
	Tue,  6 Jan 2026 00:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767659615;
	bh=43Yo18+TKFmz9SxuJ+aN5IMhsbRVzkzo4rD++TRu42I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LXCHUxMHXJGIDkva0ui+kC946OB1yUnd2EYeznCoO3bspcWv3nuDg/hTIFZHrZn7R
	 VpzdmtkXBhRBjeOMn2kDQ0LEMLxFocF+m1Qwu/e+WkGrGZI++n+ix3RmDBF1kMSSMV
	 MamGL1i04o21VzV6PRq+3BO3R4Dm001gjdDZ3fQyQFfM/wrgmRAul6IQbVHKdGFmrg
	 3qR8vsnpz6cNQu1jnM6iReCHg9ze4uxo/hUWSdyFVGM0LtA4GsDuBd9saNCNq8gECR
	 3j1r0YHsyIkbknXs0ERzrpQ9HQAa5EHrrqcERQohoARoTDhbLqfn5eG8003SXFeQ+n
	 9+CBRa0vyO+fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3C3C5380A966;
	Tue,  6 Jan 2026 00:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Fix npu rx DMA definitions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176765941378.1341185.10653064219768375586.git-patchwork-notify@kernel.org>
Date: Tue, 06 Jan 2026 00:30:13 +0000
References: 
 <20260102-airoha-npu-dma-rx-def-fixes-v1-1-205fc6bf7d94@kernel.org>
In-Reply-To: 
 <20260102-airoha-npu-dma-rx-def-fixes-v1-1-205fc6bf7d94@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 02 Jan 2026 12:29:38 +0100 you wrote:
> Fix typos in npu rx DMA descriptor definitions.
> 
> Fixes: b3ef7bdec66fb ("net: airoha: Add airoha_offload.h header")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/linux/soc/airoha/airoha_offload.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Fix npu rx DMA definitions
    https://git.kernel.org/netdev/net/c/a7fc8c641cab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



