Return-Path: <netdev+bounces-137283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9CD9A54A1
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011E31F21C41
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 14:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C82195FE3;
	Sun, 20 Oct 2024 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWKKrLQs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D58195B37;
	Sun, 20 Oct 2024 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729435837; cv=none; b=Qk5H9Ijm2tL11Lxrmy9WdiGrtjgT5aLqksBK6UiYeuWaXiOXZFU9/fstLl5+k3iPZL5srR5YZ20+zt6RjPIVyYJ56LdfP1CGf4+OAIZgIvckI7biKIjt8fu1S1jSdpWUmp0FQt7r47X5nDdtU7dKNiDHfDIzMYX0BZDe44m6s74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729435837; c=relaxed/simple;
	bh=9RU59F4px6cUHcJgMJoAb4VxkAq92i58smubeGEaDGU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h1SCPXSJ/XOm6UG7QvGRAgYXcWwN0oU8zvH9mIFUDinQZz5MECGV9EnbNExLY6m5QmoMHzPGT4Uzcjduen+3Rkhm+QNDSbD8GAWvkV+p8MAtVuJ/FPqUY7954VeiHPTeEg3+38hcLXBEuN4/77RI7cocuO38/XkY+iGmsEhQnHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWKKrLQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EC3C4CEC7;
	Sun, 20 Oct 2024 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729435837;
	bh=9RU59F4px6cUHcJgMJoAb4VxkAq92i58smubeGEaDGU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bWKKrLQscm4fB1iDDqzXGPF1Ry+zJkWwji7bv2se/rAcwgfEPYSu6cDfx/5cfuvlq
	 Ei3oGoFnQ/QIfbgf+VwKzLxOdgS/8LGhpqYoyynNJf3jBcfok4NJFUQWiJ9VhD+DF+
	 sR9+sbmBhHdYbzhlw7rnd19E/WKzOPm3atCZzt21TBdaktBrakpb/+CfC2uN0M8+Nj
	 1HhLUa5IK3y5kDps/a2aLhSRzBW38YyDzlLY0oNCVfaZcHAd13dx9m/1qZoCw/i6jq
	 f7qWxcufLhYDeaPSLQd3r/K354c8kQClSyPeds+/u5pbMym7YpCxWoVJAB5a1Kmiva
	 0iBnaXPHMLSpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFFB3805CC0;
	Sun, 20 Oct 2024 14:50:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: phy: dp83822: Fix reset pin definitions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172943584335.3593495.815352796490455138.git-patchwork-notify@kernel.org>
Date: Sun, 20 Oct 2024 14:50:43 +0000
References: <AS1P250MB0608A798661549BF83C4B43EA9462@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
In-Reply-To: <AS1P250MB0608A798661549BF83C4B43EA9462@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
To: Michel Alex <Alex.Michel@wiedemann-group.com>
Cc: maxime.chevallier@bootlin.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dmurphy@ti.com,
 Georg.Waibel@wiedemann-group.com, Andreas.Appelt@wiedemann-group.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Wed, 16 Oct 2024 12:11:15 +0000 you wrote:
> This change fixes a rare issue where the PHY fails to detect a link
> due to incorrect reset behavior.
> 
> The SW_RESET definition was incorrectly assigned to bit 14, which is the
> Digital Restart bit according to the datasheet. This commit corrects
> SW_RESET to bit 15 and assigns DIG_RESTART to bit 14 as per the
> datasheet specifications.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: dp83822: Fix reset pin definitions
    https://git.kernel.org/netdev/net/c/de96f6a30035

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



