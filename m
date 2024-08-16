Return-Path: <netdev+bounces-119261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E2A955001
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003EF28435B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D220E1BD4E4;
	Fri, 16 Aug 2024 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+RJWxvz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A225F4AEE5;
	Fri, 16 Aug 2024 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829432; cv=none; b=KRw2s/LwsvOgWA37OBqkASQ0m7izxDHnS0+y6r9wvKGhwgXbvVfKrtmjl7MhUucIi1QRcrKR+CUjZ1VbOgcTyEtmmFTdR5rYy7bVT10zbMtt6QnsWTZ25MZkKbw2RXQQvqBe+93GcQuYKjfUQ1S5hvBfQ5w1gBbwznnHnHLLvZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829432; c=relaxed/simple;
	bh=JaXZdxvF0nAJddX1aXf3wtQLWu28jEQt1m9rfw8bTrw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m3F+nFLde9Au9/j2e8MQAgIBt1DHlAgyhf8KKYTvWz4nYYzuPgiCrKs+tZHWpK0ZozU4ey6CFapzyPvfpWCWTo7cImcld7BYv47pJ78hlV9xiI7j18SKzToO97A8xmvgFrfsh4Arlhr27OqkYJ67wxcQWcMWazHyhI364n5XngU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+RJWxvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322DBC4AF0C;
	Fri, 16 Aug 2024 17:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723829432;
	bh=JaXZdxvF0nAJddX1aXf3wtQLWu28jEQt1m9rfw8bTrw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q+RJWxvzYNIUt0B78tCDYLG+JfLVDTuMaT60Nchze714XISTy6z5djviY6HAhHhYT
	 us/xc/TCoqm8CxIbu8RljRGFKKspOsI4Dm4QUkYYkSsQABM13EyWnBnl/oX7I7DGya
	 c1WSsZmwfpY+emvoM/4CWsZbJhv5/L2y0WRMAkCRZiRKqVVNFbCTshPzVSAF9Bkmet
	 pZHjHNFDq23cf60yJCRn7+6IjEWwh0+Y9UNyje8nAmYFspXfdGAT0xz8Pfkwxwci5y
	 hXPPgBryNlzadAu9y1SHx8AS5frkOMgSYpdr002o9mDeXqzqtAJ3el0M2ru78lYgoW
	 wGnEL6zBDahpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE6B238231F8;
	Fri, 16 Aug 2024 17:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/6]  net: dsa: microchip: ksz8795: add Wake on
 LAN support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172382943150.3583497.14805648315334646638.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 17:30:31 +0000
References: <20240813142750.772781-1-vtpieter@gmail.com>
In-Reply-To: <20240813142750.772781-1-vtpieter@gmail.com>
To: Pieter <vtpieter@gmail.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marex@denx.de,
 Woojung.Huh@microchip.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 pieter.van.trappen@cern.ch

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Aug 2024 16:27:34 +0200 you wrote:
> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> 
> Add WoL support for KSZ8795 family of switches. This code was tested
> with a KSZ8794 chip.
> 
> Strongly based on existing KSZ9477 code which has now been moved to
> ksz_common instead of duplicating, as proposed during the review of
> the v1 version of this patch.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/6] dt-bindings: net: dsa: microchip: add microchip,pme-active-high flag
    https://git.kernel.org/netdev/net-next/c/6a66873d820b
  - [net-next,v6,2/6] net: dsa: microchip: move KSZ9477 WoL functions to ksz_common
    https://git.kernel.org/netdev/net-next/c/f3ac6198a719
  - [net-next,v6,3/6] net: dsa: microchip: generalize KSZ9477 WoL functions at ksz_common
    https://git.kernel.org/netdev/net-next/c/fd250fed1f88
  - [net-next,v6,4/6] net: dsa: microchip: add WoL support for KSZ87xx family
    https://git.kernel.org/netdev/net-next/c/90b06ac06529
  - [net-next,v6,5/6] net: dsa: microchip: fix KSZ87xx family structure wrt the datasheet
    https://git.kernel.org/netdev/net-next/c/0d3edc90c4a0
  - [net-next,v6,6/6] net: dsa: microchip: fix tag_ksz egress mask for KSZ8795 family
    https://git.kernel.org/netdev/net-next/c/6f2b72c04d58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



