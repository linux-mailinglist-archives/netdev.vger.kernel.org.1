Return-Path: <netdev+bounces-223485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE25B594FD
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E651BC7A13
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646852D6E7E;
	Tue, 16 Sep 2025 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwM8jv5b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346782C158F;
	Tue, 16 Sep 2025 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021612; cv=none; b=j/DZEwBGqvkDTkpKdvzWViu5gYBmcPeGyDnpwKPS+cOPQrUeXuHqwhQYwZR3TB/2VMoyuGyApzOOmNZu2XGzipOH+fJjGNOzVwI0zZySzFkDZxo+PIASwMEH6z+aKUPiq23ZkoRA0mS/IZj/LGOZbKtE40XTLe2gNOkXBaMHriU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021612; c=relaxed/simple;
	bh=14sOQQinc11cHCKnIiI6Ab/MANDaVgA92SJ8bByuOrA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GPrV5j2caYUn7rB44rGKla0S29Yxbnh/INgdV2tSHP7KKkhVcXg5ic2OrVE1mxa8T9lRBfj+MdTjd9fAcGy2XaNZ0ERoGtOwiomvRYzw80A6+ZZNMFjPQBYDWKTW5zWE0Gz2s7WRcKn5hV7dPEKIvvEl0haLaJlvmJTYyaxPP7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwM8jv5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2E0C4CEEB;
	Tue, 16 Sep 2025 11:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758021612;
	bh=14sOQQinc11cHCKnIiI6Ab/MANDaVgA92SJ8bByuOrA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GwM8jv5bXdsHfLGp25eYIs+KXZkrnrk1BTxTI8uOnCDcLnnOfpO7jCDV8/zfKyVYw
	 R3XtBe05hWce2cnVkQsWvnmAS6GM/kKDsOzCofqrfT18T0y2niThi4CnnpYHDDO88d
	 nKBfo9i2rs1o6ZeMPVkdOYV7Yc4y1BZHEendlGMtaF4ft9LzwJr+XO6VMgnGhInk9w
	 cYGz8RF2NITu2t9He49tjMR/MEWemu0HRVIwouU54Z5YviVndwjmPqAdu4k4dPSsjo
	 MV8FMOL0+kY0vKZLLpvC2AXRvXS9C9JG/eOr5N9aJmw309/U4K7I1wXe7n3l3QnSex
	 +Qo1j+I6FVvfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F4F39D0C1A;
	Tue, 16 Sep 2025 11:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v12 0/5] Add Ethernet MAC support for SpacemiT K1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175802161326.713595.16381910315366172301.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 11:20:13 +0000
References: <20250914-net-k1-emac-v12-0-65b31b398f44@iscas.ac.cn>
In-Reply-To: <20250914-net-k1-emac-v12-0-65b31b398f44@iscas.ac.cn>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlan@gentoo.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 p.zabel@pengutronix.de, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, uwu@dram.page,
 vadim.fedorenko@linux.dev, junhui.liu@pigmoral.tech, horms@kernel.org,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 conor.dooley@microchip.com, troy.mitchell@linux.spacemit.com,
 hendrik.hamerlinck@hammernet.be, andrew@lunn.ch

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 14 Sep 2025 12:23:11 +0800 you wrote:
> SpacemiT K1 has two gigabit Ethernet MACs with RGMII and RMII support.
> Add devicetree bindings, driver, and DTS for it.
> 
> Tested primarily on BananaPi BPI-F3. Basic TX/RX functionality also
> tested on Milk-V Jupiter.
> 
> I would like to note that even though some bit field names superficially
> resemble that of DesignWare MAC, all other differences point to it in
> fact being a custom design.
> 
> [...]

Here is the summary with links:
  - [net-next,v12,1/5] dt-bindings: net: Add support for SpacemiT K1
    https://git.kernel.org/netdev/net-next/c/62a12a221769
  - [net-next,v12,2/5] net: spacemit: Add K1 Ethernet MAC
    https://git.kernel.org/netdev/net-next/c/bfec6d7f2001
  - [net-next,v12,3/5] riscv: dts: spacemit: Add Ethernet support for K1
    https://git.kernel.org/netdev/net-next/c/60775f28cfb7
  - [net-next,v12,4/5] riscv: dts: spacemit: Add Ethernet support for BPI-F3
    https://git.kernel.org/netdev/net-next/c/3c247a6366d5
  - [net-next,v12,5/5] riscv: dts: spacemit: Add Ethernet support for Jupiter
    https://git.kernel.org/netdev/net-next/c/e32dc7a936b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



