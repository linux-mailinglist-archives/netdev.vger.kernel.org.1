Return-Path: <netdev+bounces-124498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00040969B0E
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 13:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1771F24B6A
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 11:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C154E1A0BDF;
	Tue,  3 Sep 2024 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjbeojbN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D7B1B12EC;
	Tue,  3 Sep 2024 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725361232; cv=none; b=TD15GIWTGKO3wDqNOqb7XPI2gfIY5gOwBfln9sCBKT2LNP6a6QOj1ieMDBh41V4Nw7VkqW4SSNRgHsKDBFGcHgxGEINpl4ncGir7303oEB0PSM738kpjN6iGDItDdQ81/rl40aEnAMZCAT9cx+pB33qMjEiBbAdVgF+Cf9o0PrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725361232; c=relaxed/simple;
	bh=ylMqV+jJH9dxcuCIPmf7jFWF++944PIohyUMVAUrUr4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OSZddk3d6xR6VFhn0330rRhCLXNQEWGpF1+Y9tl1r2Ld6xWk3fqg7Xy8fDz+ATROeBESWvsWucNkdQh/m74ILOMTz8VIwqUZ0f5nqwsJ+BcNpy1R7ZnK5AULK5jcHiyEWTPCYYVb5AfQEocZBIRwSVviVSLNTWXICSZ8vaXwsXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjbeojbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1404CC4CEC9;
	Tue,  3 Sep 2024 11:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725361232;
	bh=ylMqV+jJH9dxcuCIPmf7jFWF++944PIohyUMVAUrUr4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IjbeojbNE5gbiQqgVSKXWrua+vTQU4QpXPN0ft2U2UOxsIDV1zfGRfEGqjhm+7uKA
	 cSzetxYkfncpnwUTqrhz694qhDDc7ac9rsN/HuF08CJYQKaaHUAPpXo9yN5G2XYtBg
	 GbixvswnB4F1pnDkMjxkz/5CG7uFpwVNsT3zHO0tmMA3mRikJDVvNZ2vjH28Hl2f6k
	 N0XndhQIQFvwY4uiH1th2XXM1aPbEEJ9wv10q7gyz96hHpZxz2UBEE0fs2og8EVSAn
	 siDq4zBURfBqJkJsVr85YIq1q7b5QhdlMMducpcUWIClQzm188W1Gei4vCK096vvMw
	 pEB7Ixjf6fcjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ED8D73805D82;
	Tue,  3 Sep 2024 11:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/8] net: Simplified with scoped function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172536123276.255858.14746783448329293832.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 11:00:32 +0000
References: <20240830031325.2406672-1-ruanjinjie@huawei.com>
In-Reply-To: <20240830031325.2406672-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: woojung.huh@microchip.com, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
 justin.chen@broadcom.com, sebastian.hesselbarth@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, wens@csie.org, jernej.skrabec@gmail.com,
 samuel@sholland.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
 krzk@kernel.org, jic23@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 30 Aug 2024 11:13:17 +0800 you wrote:
> Simplify with scoped for each OF child loop, as well as dev_err_probe().
> 
> Changes in v4:
> - Drop the fix patch and __free() patch.
> - Rebased on the fix patch has been stripped out.
> - Remove the extra parentheses.
> - Ensure Signed-off-by: should always be last.
> - Add Reviewed-by.
> - Update the cover letter commit message.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/8] net: stmmac: dwmac-sun8i: Use for_each_child_of_node_scoped()
    https://git.kernel.org/netdev/net-next/c/81b4eb62878a
  - [net-next,v4,2/8] net: dsa: realtek: Use for_each_child_of_node_scoped()
    https://git.kernel.org/netdev/net-next/c/51c884291a94
  - [net-next,v4,3/8] net: phy: Use for_each_available_child_of_node_scoped()
    https://git.kernel.org/netdev/net-next/c/1dce520abd46
  - [net-next,v4,4/8] net: mdio: mux-mmioreg: Simplified with scoped function
    https://git.kernel.org/netdev/net-next/c/b00f7f4f8e93
  - [net-next,v4,5/8] net: mdio: mux-mmioreg: Simplified with dev_err_probe()
    https://git.kernel.org/netdev/net-next/c/4078513fc86c
  - [net-next,v4,6/8] net: mv643xx_eth: Simplify with scoped for each OF child loop
    https://git.kernel.org/netdev/net-next/c/3a3eea209e6d
  - [net-next,v4,7/8] net: dsa: microchip: Use scoped function to simplfy code
    https://git.kernel.org/netdev/net-next/c/f834d572b7e9
  - [net-next,v4,8/8] net: bcmasp: Simplify with scoped for each OF child loop
    https://git.kernel.org/netdev/net-next/c/e8ac8974451e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



