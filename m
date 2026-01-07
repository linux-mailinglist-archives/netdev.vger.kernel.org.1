Return-Path: <netdev+bounces-247541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9395ECFB8F5
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B4BE3044870
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E96284B58;
	Wed,  7 Jan 2026 01:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXVEYb0F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B324A284898
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 01:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767748419; cv=none; b=hMe98nDs9C9GW6xQsXysgH6mMjgostAgwjVKjh9XaFMl1KHNJWW4Fg5vfop9nlOVsLoALRnTe3jjYSHKhNMHeukJslMR4ypRXg5xson0vmGYGtXTvFYErwLoGSwFejT70ygLs26piWcarqdJSpKX4JWAX9I6bcetVONcrbxz/T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767748419; c=relaxed/simple;
	bh=LSzIB7ZvHtwbKLPR0CyVa0RD/fmT9XyawYFuu4l+x2s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EcbqfcTZ5N9VJYzcjn0uQque2meNz6pTzYdZH0t2UURH0b5F9gRBx6h5Mghh0osuvAVfsDnHmyMqLtF1fj2gGcrq6PtdO4wQM1CjQJ0v9xrOePfhmLZTTOE4FAHY9azWhy3RCtwFIpk+pI1W1NU3ATgdAuP+f1rOX92kyY8RzmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXVEYb0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0BAC19423;
	Wed,  7 Jan 2026 01:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767748419;
	bh=LSzIB7ZvHtwbKLPR0CyVa0RD/fmT9XyawYFuu4l+x2s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sXVEYb0FWM4yiX9H8pkjr5yACRcxuuHJ5r2Y1O/+IeVBtsrTzPaTPtRlwhsmM+n1b
	 JgCcsv0gDqrn92BjwnGcHmGoQ4CiXRES01yJIF72P308s3L2LZIa53sTzNEuDS1S07
	 ZjDipzBUHmQn+d6mCx1ErVizEB+B5OLp9imDhgZOsmdeQ2MPDYnz/PuOXBwvW7TBM1
	 4z4W7yK2VY9MyH0497cadAEpOECnLgbE0DhqC+HPIId5xkco3fH+LApXrZf2bpJuXD
	 oQ2bsXDSKPNFNTY7XM+8kG7KQcNsysACJp5PtbxVsTvNQQd4m3YfmTUVUhQZ+CwXiI
	 3p/4nDyHtue8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2904380CEF5;
	Wed,  7 Jan 2026 01:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: npu: Dump fw version during probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176774821677.2186142.2029655991938895121.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 01:10:16 +0000
References: <20260105-airoha-npu-dump-fw-v1-1-36d8326975f8@kernel.org>
In-Reply-To: <20260105-airoha-npu-dump-fw-v1-1-36d8326975f8@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 05 Jan 2026 09:49:16 +0100 you wrote:
> Dump firmware version running on the npu during module probe.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_npu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: npu: Dump fw version during probe
    https://git.kernel.org/netdev/net-next/c/e4bc5dd53bf5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



