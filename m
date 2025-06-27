Return-Path: <netdev+bounces-201718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C8BAEAC13
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 03:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2611C40993
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 01:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2817E156C79;
	Fri, 27 Jun 2025 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlLzGzWi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F314D15689A;
	Fri, 27 Jun 2025 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750986000; cv=none; b=JtoZIOV9Y4nm/orTwTrWFF2xX1J3B5lBgrptRPT0+SsOtfXHo9a4UKHId4gyHN5QiCHHOGOoP+E9cbNemR/lddBfpD4Lw7uV9biiNO/OnBgwlsuaLxeh9xyosO7TNwGsIVpzUV1fUABRSQ/giPdqQZvrTJOA4m5s7owmEQpxPXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750986000; c=relaxed/simple;
	bh=VkWF1gdQoTZWOGfhakMa99lt5mYOIofcHp91h9azi3s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YkYMvC/XOILR3J2jW+RzJoR74+GHwZGAiLb30E8vRbTJK2ivGablRwdPYCH6J4rge5LmPV4scnoebN2adUNLo1iG8xDGRRKvJYVbUCRAOJ5dHLyLVBIyfE0a7rB2J1tv3ISJvpJQZQXRjzN2bzchVVILjxX6XF5m/OsMxPTEzUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlLzGzWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADC9C4CEEB;
	Fri, 27 Jun 2025 00:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750985998;
	bh=VkWF1gdQoTZWOGfhakMa99lt5mYOIofcHp91h9azi3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rlLzGzWiKp2Qe5vnXYID5PL3G0ZwHe96L4b5VwQbuVopWdLxZMFJEyWgcJ0tbMp+d
	 ydwNgeKh3B6azaWAK3bXexI1fmTyJCOjq0s+ZVKwVznU8ilxOO16ovZF3sODCDwadr
	 iP0fpW0wXjz1Fn3BOtUuOn+qfYMCErSr+7yri+Crynum/gG27Mk+OSc2TjFunHWxW5
	 dsR8RqPSTIQhc0Gq/AVr/KsxFtTXlErnTKFcuDP+w2B3meMyI+w34xHBhrk+2H7q7B
	 /43mFJgJi4FUWhi2l3BF1dr1ujbVTL+TMIsiEt9YoUBGYNZH5xt5fuDcNfanabN0tn
	 DN9jNHQB//ZeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE0C3A40FCB;
	Fri, 27 Jun 2025 01:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Remove unused function
 first_net_device_rcu()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175098602474.1388943.17116977813012792000.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 01:00:24 +0000
References: <20250625102155.483570-1-yuehaibing@huawei.com>
In-Reply-To: <20250625102155.483570-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Jun 2025 18:21:55 +0800 you wrote:
> This is unused since commit f04565ddf52e ("dev: use name hash for
> dev_seq_ops")
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/linux/netdevice.h | 7 -------
>  1 file changed, 7 deletions(-)

Here is the summary with links:
  - [net-next] net: Remove unused function first_net_device_rcu()
    https://git.kernel.org/netdev/net-next/c/040ae95a984f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



