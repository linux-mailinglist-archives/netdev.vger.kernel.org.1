Return-Path: <netdev+bounces-155646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ECEA0341A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 01:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88211633F3
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 00:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091D346434;
	Tue,  7 Jan 2025 00:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmGoR9vu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9D45009
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 00:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736210415; cv=none; b=ZbRkvSiAS8tHwhwXymdfTTa0WbkBMcdqjvL3LOAMrjaNhqJrjQgOg5rQsWQ1M5eUOzhmSbx3fNVCDAi3mFvlSTMU5LXc95KQYN0kpNBmCigSwswLSGUsOGW5Ld5eniiziKxj8jkSgQoYHJRSnNaBr44HEn2xl+Y1r4weWX6i5Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736210415; c=relaxed/simple;
	bh=gA77aVxWP4yB6mTAj9/XUFdKsilOeWCCebwMj3rx0Fk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AOETA6+lhtvKWpk/YgUoYWtOB4x6kd8Pcxn4KtDOlcJN1osupM9Jltn3c9xVRjMGpm630jwP4yP2cpHxJj5ABfG0Lr5zUeIqzx/XJFDrv3aLaNxDyBGR0t5YaZUxg8/0LkQNu8eOe4i3E6YoIsIcjVQ/rk9CHn8CPIvC5YkfjCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmGoR9vu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502A9C4CED2;
	Tue,  7 Jan 2025 00:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736210415;
	bh=gA77aVxWP4yB6mTAj9/XUFdKsilOeWCCebwMj3rx0Fk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gmGoR9vuoiw6sebJ+fwBnazOUfuvK8S0tuKXsD71kr1wWFy2Dp9ImCGbR4O7Ekwmi
	 vJDu/QuooT68RZpGDQijJK/PhuOaUBCvp0NY3uceqzI8znnLMtaVAGkaO3QIDuTacX
	 pGPUwfV/YGOxe14GwE39N4ZG6RRM9MtgGKiSgxqARlH0kBlVnzRTKcUROVZz960qR0
	 aOCtHqErjH372qkU0lhjMdNgAxSer0LAxDyugxCb0pLqYxeGuI670f/2mhLiu6ixDw
	 341VmaUBeam6E2o9BoGGU1So3AMHvqqMv9/aXHEv9Q1OU46RzpypKl4nPgOjDwcefO
	 onDzioS5VA/4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE127380A97E;
	Tue,  7 Jan 2025 00:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] net: pcs: add supported_interfaces bitmap for
 PCS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173621043648.3661002.8813298484787541928.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jan 2025 00:40:36 +0000
References: <Z3fG9oTY9F9fCYHv@shell.armlinux.org.uk>
In-Reply-To: <Z3fG9oTY9F9fCYHv@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, lynxis@fe80.eu,
 alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 angelogioacchino.delregno@collabora.com, daniel@makrotopia.org,
 davem@davemloft.net, edumazet@google.com, ioana.ciornei@nxp.com,
 kuba@kernel.org, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, matthias.bgg@gmail.com,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 3 Jan 2025 11:16:06 +0000 you wrote:
> Hi,
> 
> This series adds supported_interfaces for PCS, which gives MAC code a
> way to determine the interface modes that the PCS supports without
> having to implement functions such as xpcs_get_interfaces(), or
> workarounds such as in
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] net: phylink: add support for PCS supported_interfaces bitmap
    https://git.kernel.org/netdev/net-next/c/fbb9a9d263a6
  - [net-next,2/6] net: pcs: xpcs: fill in PCS supported_interfaces
    https://git.kernel.org/netdev/net-next/c/906909fabb81
  - [net-next,3/6] net: pcs: mtk-lynxi: fill in PCS supported_interfaces
    https://git.kernel.org/netdev/net-next/c/b87d4ee16bb4
  - [net-next,4/6] net: pcs: lynx: fill in PCS supported_interfaces
    https://git.kernel.org/netdev/net-next/c/b0f88c1b9a53
  - [net-next,5/6] net: stmmac: use PCS supported_interfaces
    https://git.kernel.org/netdev/net-next/c/d13cefbb108e
  - [net-next,6/6] net: pcs: xpcs: make xpcs_get_interfaces() static
    https://git.kernel.org/netdev/net-next/c/2410719cdd49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



