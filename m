Return-Path: <netdev+bounces-212282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9099EB1EED6
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 21:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9B6A054F9
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 19:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0704286439;
	Fri,  8 Aug 2025 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzvfd6TW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A3285CA9;
	Fri,  8 Aug 2025 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754681393; cv=none; b=Mdm+7Nf/azgKKd97XzrlMlo3f0Q4V5m0g5YCyYrfgBCpBf75uVt9uYL72z6Mo7KvcsdLvQF25ozp1mnd2cZz2mBPyj6Vu0mPiLtnPiCk8rKyggyj+iKMEapia94ENe47h+lqqB9qEGlT7LFQpATIaF7XzPCnkzDEbpfxkGVThPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754681393; c=relaxed/simple;
	bh=CiCDLFP0XbUo4Ghv+kqOOeZMQP6GmlGXuHQJyu0BoUo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ny0d7medXK1Vz3ApLAdRrjM/lYut1onvRjPlp5YJNb61tut0XZAK3XYNX6xgNtZO2WcazDW9WpdGBWmqYlDZ++1ANmKCzWrvSEgfBCrreNYFW8J91lHfoO7C0wspouXbb3J7zWr7MDSEHtQpvZOvApryZYhFePzQMlW6O92Rw8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzvfd6TW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08ADAC4CEED;
	Fri,  8 Aug 2025 19:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754681393;
	bh=CiCDLFP0XbUo4Ghv+kqOOeZMQP6GmlGXuHQJyu0BoUo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nzvfd6TWNGPVP/CzLfSavkL3tBvZNDjEauHvQZ0OzZfJTOyu8A/1pnCgl2zVWM9qm
	 r4IIzyO0xVVPSwZ0IAQ4qych+wPww+GXMJiaF3HQrFOzSXQ1IM/Nm23FAYMdVy+zF4
	 GL2Y+VYdZQifx5znCXVpI35dGbz1V7jXrp+wv2kyjVJUri5Er6VXvGvArC+wLc8PW3
	 MlygcpXM4L4EeWuQHwKRPmq8nCruwpPQ87/9WIZD+RmXvbETIUQndq0y+Qx4nj+Nr9
	 Pz4dkXFb4ZTq+Zu2F3DSyht+LlXl2chrWjuRoneuZnWdUNohWkV5zyo8w7rCNKGW7q
	 QaWfimKB2hBRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7104E383BF5A;
	Fri,  8 Aug 2025 19:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Fix emac link speed
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175468140625.242168.262371954250110213.git-patchwork-notify@kernel.org>
Date: Fri, 08 Aug 2025 19:30:06 +0000
References: <20250805173812.2183161-1-danishanwar@ti.com>
In-Reply-To: <20250805173812.2183161-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, m-malladi@ti.com, h-mittal1@ti.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, srk@ti.com, vigneshr@ti.com, rogerq@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 5 Aug 2025 23:08:12 +0530 you wrote:
> When link settings are changed emac->speed is populated by
> emac_adjust_link(). The link speed and other settings are then written into
> the DRAM. However if both ports are brought down after this and brought up
> again or if the operating mode is changed and a firmware reload is needed,
> the DRAM is cleared by icssg_config(). As a result the link settings are
> lost.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ti: icssg-prueth: Fix emac link speed handling
    https://git.kernel.org/netdev/net/c/06feac15406f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



