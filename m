Return-Path: <netdev+bounces-186609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A84A9FDEE
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 01:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BD73AF6D6
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 23:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630942139C4;
	Mon, 28 Apr 2025 23:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGJP4i/u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363FF70831;
	Mon, 28 Apr 2025 23:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745884201; cv=none; b=VQJdzn8fY5drjYclcayvJZACahRIdeWMKqyrta0IxX51u/prNDgJQyKroekNFjUtda2pKalVOu5FbI2iCVOvLj2wDLaMfKosxzQAK4U+/rWNg8wtM4mYaLQTUFJLL3bg+XDMrB3y0+eIa35I62z+YXsIdY0qCzDQIUpr9q2YZt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745884201; c=relaxed/simple;
	bh=vsCYRJOu2+7O/vaGXslstlkjSpMCXUDLAHK65Ew0rG0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xpmro3vUSm6tUYe5s2e9Bv6M75be7CG9elwNLbbjZ4pnZG1fjJ4+aI7fn9MM2cdRLTqvS+HlXizfJ81U8oFV7ftcSf9xfYFHOdrkvpPgj/maAoxIURUL95BiHV8c4JpzgTOFxm5ilWp9IqkSN3zVsAcmeszeNVmhRIcLkkFke3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGJP4i/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A6AC4CEE4;
	Mon, 28 Apr 2025 23:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745884200;
	bh=vsCYRJOu2+7O/vaGXslstlkjSpMCXUDLAHK65Ew0rG0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aGJP4i/u7wVlXy+99f3czCJoOsn4bi4HjuC4uYD0eZ7DUNidJen8244Hc5WgthPof
	 xDwv5RreNyi0aZOIMyRC0qnk154UIAX0cN4yZyR+N+53PRCBLF/xwrkAaBRRr1vZVU
	 iCSP7q8GciiXf1yZIym1xY6MU1eLTJrfZgBJMQ8YbqEg6CFYVrI3WAoY888ZQWJm4E
	 NTcCeUS2nIA84m0TuKhDRddrr3YXCJkzd+Eic63sX4vhsCHEPjgzPqKgBtzefarWMo
	 ERTHZYuurxiVhCgkHMwUYhls6WP/8qcPEUACvh1fDucevmJcB4Qx8V8D5NyhzPwJAi
	 Is1By8WOGx3jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEC83822D4A;
	Mon, 28 Apr 2025 23:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/8] Phase out hybrid PCI devres API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174588423950.1081621.6688170836136857875.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 23:50:39 +0000
References: <20250425085740.65304-2-phasta@kernel.org>
In-Reply-To: <20250425085740.65304-2-phasta@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, bbhushan2@marvell.com,
 taras.chornyi@plvision.eu, venza@brownhat.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, deller@gmx.de, horms@kernel.org,
 jacob.e.keller@intel.com, mingo@kernel.org, tglx@linutronix.de,
 viro@zeniv.linux.org.uk, shannon.nelson@amd.com, sd@queasysnail.net,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Apr 2025 10:57:33 +0200 you wrote:
> Changes in v2:
>   - Rename error path. (Jakub)
>   - Apply some RBs
> 
> Fixes a number of minor issues with the usage of the PCI API in net.
> Notbaly, it replaces calls to the sometimes-managed
> pci_request_regions() to the always-managed pcim_request_all_regions(),
> enabling us to remove that hybrid functionality from PCI.
> Philipp Stanner (8):
>   net: prestera: Use pure PCI devres API
>   net: octeontx2: Use pure PCI devres API
>   net: tulip: Use pure PCI devres API
>   net: ethernet: natsemi: Use pure PCI devres API
>   net: ethernet: sis900: Use pure PCI devres API
>   net: mdio: thunder: Use pure PCI devres API
>   net: thunder_bgx: Use pure PCI devres API
>   net: thunder_bgx: Don't disable PCI device manually
> 
> [...]

Here is the summary with links:
  - [v2,1/8] net: prestera: Use pure PCI devres API
    https://git.kernel.org/netdev/net-next/c/66ada7471155
  - [v2,2/8] net: octeontx2: Use pure PCI devres API
    https://git.kernel.org/netdev/net-next/c/48217b834529
  - [v2,3/8] net: tulip: Use pure PCI devres API
    https://git.kernel.org/netdev/net-next/c/adc36d0914f6
  - [v2,4/8] net: ethernet: natsemi: Use pure PCI devres API
    https://git.kernel.org/netdev/net-next/c/2a5a74947a2b
  - [v2,5/8] net: ethernet: sis900: Use pure PCI devres API
    https://git.kernel.org/netdev/net-next/c/6e5f7a5b5e0c
  - [v2,6/8] net: mdio: thunder: Use pure PCI devres API
    https://git.kernel.org/netdev/net-next/c/fad4d94d9ae5
  - [v2,7/8] net: thunder_bgx: Use pure PCI devres API
    https://git.kernel.org/netdev/net-next/c/06133ddc3590
  - [v2,8/8] net: thunder_bgx: Don't disable PCI device manually
    https://git.kernel.org/netdev/net-next/c/1549bd06e340

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



