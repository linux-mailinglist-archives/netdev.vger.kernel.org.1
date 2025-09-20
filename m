Return-Path: <netdev+bounces-224944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32211B8BAFE
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 02:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1CB1C05B22
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 00:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67221DEFF5;
	Sat, 20 Sep 2025 00:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lns9fbzz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923BB1E3DE8
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 00:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758327626; cv=none; b=Ru2u76tIy0S5NMNrWD6EC5PpkjHIZw1sA9OoiAEHFysiV3h0EFRtmXE6Ygkd+dVaiXT08vrWWdt06c7GbRDJ6ZVVTW1m8Rg1pBqwycuDX9J2VtQM+VHbHBO7LSw5iobw62UEpFfC/Ha3RSpJIWWmTWr1TjuTZ6BsU53076Wfswc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758327626; c=relaxed/simple;
	bh=zexwYQoxyOYMYcF163tm4TASujkkToWcnqXC6b0x3c4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uNEmqfEFGv7EBFSJ35bDh34K/gx5cejL+TGS6f2lFOXorTxlSNsgUi0cNG2QZMNqSH8IEi1UECnWH9BfEt3SZK1QjsuH2nA3RlVL22a5oNATMqavOqzCeJktekfE5Za3Mf2mxUaZAO8uxevgU17kV+maK/DyXZtw/UIJ+QAmivU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lns9fbzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1FBC4CEF5;
	Sat, 20 Sep 2025 00:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758327626;
	bh=zexwYQoxyOYMYcF163tm4TASujkkToWcnqXC6b0x3c4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lns9fbzzwn/+OC8jjUT0Om9rc1dILaJATaN5hC/uWr+EY1IthDDIH+S1VCz+WvrCQ
	 qkQxV8vm9J0MsuVeiDQJL2J0DvdKJgsomeXJ+p6WDT5ikjScxELxQcw4VUgykQItUr
	 efvOyhcUv5F4rRFRwr7QwuZ85Tp7USU25SiAQVtTDgVPxw4BE8nFeIJ4J3CPYm1ujK
	 /Eu18CaRTV2Y+KxiLsA4raoQJRI7xp69fmhAbWBagDhAnHys6FTHqfJmSeliahh/d/
	 af0rjX1ZhuYlEV7Z2RpT9LGDt4IGQPWBM8dQ0bCSBBf/lqBybVZxU43Y6wNt6gHUxY
	 TBlcgz4dq25+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE21F39D0C20;
	Sat, 20 Sep 2025 00:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: micrel: use %pe in print format
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175832762524.3747217.8829473345961283681.git-patchwork-notify@kernel.org>
Date: Sat, 20 Sep 2025 00:20:25 +0000
References: <20250918183119.2396019-1-kuba@kernel.org>
In-Reply-To: <20250918183119.2396019-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, richardcochran@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 11:31:19 -0700 you wrote:
> New cocci check complains:
> 
>   drivers/net/phy/micrel.c:4308:6-13: WARNING: Consider using %pe to print PTR_ERR()
>   drivers/net/phy/micrel.c:5742:6-13: WARNING: Consider using %pe to print PTR_ERR()
> 
> Link: https://lore.kernel.org/1758192227-701925-1-git-send-email-tariqt@nvidia.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: micrel: use %pe in print format
    https://git.kernel.org/netdev/net-next/c/c3bef01f0a56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



