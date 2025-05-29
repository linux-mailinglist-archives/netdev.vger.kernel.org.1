Return-Path: <netdev+bounces-194175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B835BAC7ABF
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 11:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF0FD7A84A4
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 09:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E6921CA0D;
	Thu, 29 May 2025 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpuc0glj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAEE21B9F0;
	Thu, 29 May 2025 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748509804; cv=none; b=Ug6O5Cw/PAZTcZiJZ/KWAbJOHgBioBMf/UphDUXIkANl5QM+DFcgxfZLHPkFLKObUXfkqSjcFgsX2KPZ2uwZB9efNcg/FYZApEEe1Fwal/Mg9b4ilmM2JdZOMXDtN4GKZag3x9VYLLs9++8gWgbmOwgpQ8y7dOYUrrjjZMcQats=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748509804; c=relaxed/simple;
	bh=Yb2uSf81m/g9NlDY7wmvxatJgdvhAEkJ2SZriq2WmG8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b247ZVg+uxg7diJuzszyAZ1i7ecgpJkcgr2ZuMUBCLimSmXipuNED+FTEnjn4FZq4VVheWRaamec3C+cnfPCIjS1CIaWKXnL8GQVI5Niwww5fPuyHhCe24Q+JdC8JInHoQuepgxCmRBOYZvpRLmKPmoi3RmQkoaG8aQsQ2zdSPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpuc0glj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F9AC4CEEF;
	Thu, 29 May 2025 09:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748509804;
	bh=Yb2uSf81m/g9NlDY7wmvxatJgdvhAEkJ2SZriq2WmG8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cpuc0gljbw7Wel8lndc9mBJ6wKLR2x1eW0jJMO9g8nZ6QrREy5jr9bWDS2rnNd3Kt
	 3828I2yiiEBHzYBGtEjCUyeVP8fzrFgNXi16tghzh2vxXuK/bMWwX5Idrh+rtK5Z1n
	 5nlbEHz3Hj7+Shfs/mHCQefQK+L1buCyoz30c3Rk0n8B5sgpUV819bID9G8gY3B8T7
	 bQQ34g5U9bfVDRUeYFlM3VC9HmFyYP9TSVof/Ij53VfJzkAci/d5G92IV0Igodh+b3
	 Od5wZ/LIOitZJInY3nhFQK/WajIY83+/LsVv7rPR9HpBZeCetNdNa6dZGnnsTrHQdV
	 MysXznv41IAfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F2939F1DEE;
	Thu, 29 May 2025 09:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: stmmac: platform: guarantee uniqueness of
 bus_id
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174850983774.3198213.12132601744057177877.git-patchwork-notify@kernel.org>
Date: Thu, 29 May 2025 09:10:37 +0000
References: <20250527-stmmac-mdio-bus_id-v2-1-a5ca78454e3c@cherry.de>
In-Reply-To: <20250527-stmmac-mdio-bus_id-v2-1-a5ca78454e3c@cherry.de>
To: Quentin Schulz <foss+kernel@0leil.net>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, jakob.unterwurzacher@cherry.de,
 heiko@sntech.de, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 quentin.schulz@cherry.de

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 27 May 2025 13:56:23 +0200 you wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> bus_id is currently derived from the ethernetX alias. If one is missing
> for the device, 0 is used. If ethernet0 points to another stmmac device
> or if there are 2+ stmmac devices without an ethernet alias, then bus_id
> will be 0 for all of those.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: stmmac: platform: guarantee uniqueness of bus_id
    https://git.kernel.org/netdev/net/c/eb7fd7aa35bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



