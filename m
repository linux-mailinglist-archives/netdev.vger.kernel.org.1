Return-Path: <netdev+bounces-182521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2602FA88FF5
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 01:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F143317D5BA
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21DF1F867F;
	Mon, 14 Apr 2025 23:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGgW25A5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F221F63F5;
	Mon, 14 Apr 2025 23:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744672201; cv=none; b=QFfPEN9xkZQfg12L1O0CR/gdxkmA9+P+TVvyM37yRW268fo1d4jYgB0Y+1tmW/zcWvC8Y3y86o98R1zm1vW3dmCono/3ujmqsWivwKbw/ZlzH/KlHOi89RSSvQ7bEzqJxopooN6OYPsQTEZTGeBQMIp/cPmOtE2bsYfxDe4KdgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744672201; c=relaxed/simple;
	bh=kROQQEO8+TMrf324dpy5mOF7Dx1PBVtIvpcK+Zvgr6k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W5N/Du+xFdMtDDpt88NbiHujs3uEmd+6m54s6xJv/3aLLki2RNpEFcG609nz6gixqkbd1FHNPsUUaY/dpWEC2+VMH7TPHgJdh13fTN4zevntMH5tpbd9W+k/g4UEBibmXc8hq8umUBkBQdaRESMruURl3Cih98jCGeouNKyGLk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGgW25A5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F20C4CEE9;
	Mon, 14 Apr 2025 23:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744672201;
	bh=kROQQEO8+TMrf324dpy5mOF7Dx1PBVtIvpcK+Zvgr6k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YGgW25A5QjKiqLBGOiVjcCLGCGCVU8TouC3ZDc/kEnH6l/JvRuu7b89W+brlQ36wX
	 tKU9p1auYdALhGA0HeHXDaCdTp9DYeM72EJWDNXJi73yYBLzAm4lv6S2IrPmg27vtq
	 FnUXH+o8SEaw4JQmHg3qPnzJ8YCesmqsyiEP1YrYsPdOU3VhVtkZlGi9mhfE+juMee
	 yiYxc52A57Y5kUSWG3IOAyEFHnk9iZdbxhKY9bUuSJmHXNXX8KriIZFehIaJRhcHSn
	 bxkN8H+QjYrklSGXur4Pcodd6LJpZaQ1j6j438hRRorm+6QSFHyl9ImMAOH1X+9d4c
	 dttKUc3uYoWRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C6C3822D1A;
	Mon, 14 Apr 2025 23:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] CPSW Bindings for 5000M Fixed-Link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174467223899.2068134.1491793248862918118.git-patchwork-notify@kernel.org>
Date: Mon, 14 Apr 2025 23:10:38 +0000
References: <20250411060917.633769-1-s-vadapalli@ti.com>
In-Reply-To: <20250411060917.633769-1-s-vadapalli@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, rogerq@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Apr 2025 11:39:15 +0530 you wrote:
> Hello,
> 
> This series adds 5000M as a valid speed for fixed-link mode of operation
> and also updates the CPSW bindings to evaluate fixed-link property. This
> series is in the context of the following device-tree overlay which
> enables USXGMII 5000M Fixed-link mode of operation with CPSW on TI's
> J784S4 SoC:
> https://github.com/torvalds/linux/blob/v6.15-rc1/arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] dt-bindings: net: ethernet-controller: add 5000M speed to fixed-link
    https://git.kernel.org/netdev/net-next/c/f9c1120d9b5e
  - [net-next,2/2] dt-bindings: net: ti: k3-am654-cpsw-nuss: evaluate fixed-link property
    https://git.kernel.org/netdev/net-next/c/8b36a102c1a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



