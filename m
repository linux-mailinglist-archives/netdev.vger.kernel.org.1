Return-Path: <netdev+bounces-99246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB128D433B
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 04:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B631F2314D
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCAF17BA4;
	Thu, 30 May 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/LzTUNd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A1FC2E9;
	Thu, 30 May 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717034432; cv=none; b=E1DQ3UODLPQfY8faPkNRqghbDpSP9tRW2Cg10THDIGxHPxt0+O+uOXeNzsKJeW0s4makFgdaLwSZmR0iZdTPYRL2M77Zs3FKdeypwzmA7ohJI+Ng1SF4Dwijtne/rxpfFFOvocVSOZZgi5JFFGHep7swJvWuT6dcb4tq1kYRz8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717034432; c=relaxed/simple;
	bh=JxtROD1xNSjCJsqXFY/a55Z5Z4Z7MK5y6MUH2nMzrgs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RejezNETDAc0rLHyKNWMZuOmegbq4tKrEJ0DPyXaSPqoSMO/4z/1nrm5bYd7yNH+dqJZhWKk2gSsUTgK05jiL0H905zgd5Ij7SZaFxCZ8hthCmLhbWZY2qcEZtgQktV2qj6UC6ftjdAidoy+H+JZXS5pod0ICblKgxfWJLbOzlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/LzTUNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4563BC2BD10;
	Thu, 30 May 2024 02:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717034432;
	bh=JxtROD1xNSjCJsqXFY/a55Z5Z4Z7MK5y6MUH2nMzrgs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l/LzTUNdBX95zl+aEwEy2Ripz5P0gqSephirqr96LDv6jQ88RBi6vhwzgjgt6LZY/
	 TlAHvAmdwHyuU3SgcKG/LpX3OgLy73YYUedi7gGe30Tu7XK2NF2SmkMUQNePuUq+8k
	 XSjCygnFZ0BG7lx5BSe7Z0G6RtnBfmN1dSm+Pv8RTgaYriow0fBB1jZKW1EoR+D8Zi
	 zuXEFzRBBsQDe818kiyLTmO2lR/NybXomleRXoRl0JHwYHHEhgM68/dYJrlHSgo84E
	 blHEQ/bCxiz24mxe65L8MqzpNZOihTAF24djFjf6KCM784zmmxd+7zT4uVIleSbLqr
	 sC2t4vGDRa11Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2EADBD84BCD;
	Thu, 30 May 2024 02:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: microchip: fix RGMII error in KSZ DSA driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171703443218.3291.4892024519339960900.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 02:00:32 +0000
References: <1716932066-3342-1-git-send-email-Tristram.Ha@microchip.com>
In-Reply-To: <1716932066-3342-1-git-send-email-Tristram.Ha@microchip.com>
To:  <Tristram.Ha@microchip.com>
Cc: woojung.huh@microchip.com, andrew@lunn.ch, vivien.didelot@gmail.com,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tristram.ha@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 14:34:26 -0700 you wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The driver should return RMII interface when XMII is running in RMII mode.
> 
> Fixes: 0ab7f6bf1675 ("net: dsa: microchip: ksz9477: use common xmii function")
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
> Acked-by: Jerry Ray <jerry.ray@microchip.com>
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: microchip: fix RGMII error in KSZ DSA driver
    https://git.kernel.org/netdev/net/c/278d65ccdadb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



