Return-Path: <netdev+bounces-190288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D23AB6036
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 02:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9262846718C
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 00:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7833C135A53;
	Wed, 14 May 2025 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUJRDRYx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5425F20DF4
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 00:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747182597; cv=none; b=bKcYDxSW/+/X3iWbEZk3Mr+d5Q4QlY+S2q1hweeeyp14MOrtbu0GnYbUK82lGKXyh1WYS1Fzo9LWbR0t2ZSGRbwD/ehuGH+c4i+c2Obo1NQbM74Kh41K3ATkZXLm204rl/MEgd8s2yuPgCES2paRzuTwZA3YQRzpaQFaY03nx/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747182597; c=relaxed/simple;
	bh=h4ZdnFQ0+A+nYWZaSTZg75RrYcINzaKDi3dggp0CmBk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KgW0jpsEIbU0Zt3p7iRy4gN9fLGMl4uv0HbyyvwYT+8BcJEvyBEkJ0naNuGhtq5xfpR6tQEFUYlb1h7bW9mrfZHwbAfwX3PJTg+8ECdWwar144PGIwEsUYUCwxKM49yuh2lNkUyum3o6gGsdZ6uZOb7F9RXC5qXziQDd5lnWFGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUJRDRYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DDDC4CEE4;
	Wed, 14 May 2025 00:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747182596;
	bh=h4ZdnFQ0+A+nYWZaSTZg75RrYcINzaKDi3dggp0CmBk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fUJRDRYxLcf85fdKCOWaDuPFk1fgn/7bbjkDz2LnsXE4veQ7v5jRAFBPjqGqE7GOD
	 BLtt2wybNKKAZo/S2q9p6g9T2/KQ8WLzL51k+cnR9L9mgMVGpe5+BMnwZ+pjnCuSpM
	 4KMYTwwe0FmZPcdo/VUM4MVmiQgC24X6Xy0ALU4rv7o8QEYjMXnZF5w9141uqEu+ZB
	 QFM1LGYBWJVOn24+VPv2I5+792pIBLLPWgyaB94AsrN9BsJOObji7B5DpEQ8PXTAQl
	 EEvP/90lLGdc1TN4KJGe1jcJAbKU6u8TtRoDal2z+fVZgWwrsW4S6ooUBEDcoMcWtm
	 c2qFuFtKydJwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E15380DBE8;
	Wed, 14 May 2025 00:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: remove stub for
 mdiobus_register_board_info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174718263399.1832687.16964931481363607622.git-patchwork-notify@kernel.org>
Date: Wed, 14 May 2025 00:30:33 +0000
References: <410a2222-c4e8-45b0-9091-d49674caeb00@gmail.com>
In-Reply-To: <410a2222-c4e8-45b0-9091-d49674caeb00@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 May 2025 22:20:59 +0200 you wrote:
> The functionality of mdiobus_register_board_info() typically isn't
> optional for the caller. Therefore remove the stub.
> 
> Note: Currently we have only one caller of mdiobus_register_board_info(),
> in a DSA/PHYLINK context. Therefore CONFIG_MDIO_DEVICE is selected anyway.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: remove stub for mdiobus_register_board_info
    https://git.kernel.org/netdev/net-next/c/dc75c3ced10c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



