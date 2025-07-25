Return-Path: <netdev+bounces-210221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE32B126C5
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27395408C2
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 22:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A0A248F52;
	Fri, 25 Jul 2025 22:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYpcDD6n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A873EAF9;
	Fri, 25 Jul 2025 22:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481845; cv=none; b=dxpviaL7YvZE8KWgjNRNUsBJvxO0782x+BYOQ1z8L6x6ADdVCI/SXHNIIT5bhGXxlCwNkNwNeLW7sgK5hUoNZPs7wREENRjLWD+Dg2+cauc0SdTrYHenKws6AnqBvC3pjOprbHtz5n8sJrff6V8cLVQvWSouVlHMwrTWB91MEsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481845; c=relaxed/simple;
	bh=z04vTW0gQGPvGaJMG8kNPz5saOFKvL63gvlNjB70bYY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=azRmGZUhEihhKFnx3rZA1dSOIZvrgMOfkexmmZ+Kco41mdFIxQaCY3AqKVxOqPG4s61BAPi0VHdj670J6jq41Owb5hA9BtOvruQN7qHR1RSFffrV+ufUYNeCRb6khn4TNmGeoqn16Q6eg5/59fLuzkIzvdt6QsE4aQ4AlPppNlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYpcDD6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777CFC4CEE7;
	Fri, 25 Jul 2025 22:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753481844;
	bh=z04vTW0gQGPvGaJMG8kNPz5saOFKvL63gvlNjB70bYY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qYpcDD6ncI95em36eR4MHWpzYbZ26xsvD8M/3rlMjf5BejvLN2oX/cX1+WUi26fl+
	 /jfkmDBi5tqiSyicsP/woDXY4BWN9vhVcfMmESt6sL1kE+46jvlEOSdN5u7FM0pDyS
	 C5vEzaXAD3JpwTg+CRYYx5Vl8evFuQca1fXPbiljFev/r9N1pUTa5503+DDH9KzvfN
	 vx1vUQjjYvhnNau5zki/ZP0sa/cTar1TvXzFYIZxDqMInu68kvzZbZyXZ4UgHMywrw
	 0rbTxlaF8zdMoLLn/Rm58cMyzHDWDBAneVx5jKDN+YaE67xo16mf4tH/KQqn/v9OPH
	 +b/7L5fHzcPww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E98383BF5B;
	Fri, 25 Jul 2025 22:17:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/7] net: dsa: b53: mmap: Add bcm63xx EPHY
 power
 control
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175348186199.3265195.5950781092157699342.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 22:17:41 +0000
References: <20250724035300.20497-1-kylehendrydev@gmail.com>
In-Reply-To: <20250724035300.20497-1-kylehendrydev@gmail.com>
To: Kyle Hendry <kylehendrydev@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux@armlinux.org.uk, noltari@gmail.com, jonas.gorski@gmail.com,
 f.fainelli@gmail.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Jul 2025 20:52:39 -0700 you wrote:
> The gpio controller on some bcm63xx SoCs has a register for
> controlling functionality of the internal fast ethernet phys.
> These patches allow the b53 driver to enable/disable phy
> power.
> 
> The register also contains reset bits which will be set by
> a reset driver in another patch series:
> https://lore.kernel.org/all/20250715234605.36216-1-kylehendrydev@gmail.com/
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/7] net: dsa: b53: Add phy_enable(), phy_disable() methods
    https://git.kernel.org/netdev/net-next/c/be7a79145d85
  - [net-next,v2,2/7] dt-bindings: net: dsa: b53: Document brcm,gpio-ctrl property
    https://git.kernel.org/netdev/net-next/c/cce3563875c7
  - [net-next,v2,3/7] net: dsa: b53: Define chip IDs for more bcm63xx SoCs
    https://git.kernel.org/netdev/net-next/c/fcf02a462fab
  - [net-next,v2,4/7] net: dsa: b53: mmap: Add syscon reference and register layout for bcm63268
    https://git.kernel.org/netdev/net-next/c/aed2aaa3c963
  - [net-next,v2,5/7] net: dsa: b53: mmap: Add register layout for bcm6318
    https://git.kernel.org/netdev/net-next/c/c251304ab021
  - [net-next,v2,6/7] net: dsa: b53: mmap: Add register layout for bcm6368
    https://git.kernel.org/netdev/net-next/c/e8e13073dff7
  - [net-next,v2,7/7] net: dsa: b53: mmap: Implement bcm63xx ephy power control
    https://git.kernel.org/netdev/net-next/c/5ac00023852d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



