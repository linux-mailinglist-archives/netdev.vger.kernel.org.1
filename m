Return-Path: <netdev+bounces-121970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB9395F6EB
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5731F22C0A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 16:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D766C198A34;
	Mon, 26 Aug 2024 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0ED872j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE386198A2F;
	Mon, 26 Aug 2024 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690433; cv=none; b=ePNS+V5xh84BPN/yjkaov23YOLXjIQ76P5NT4ASie/AWvg36WiJUY/fNt1JtJtfjzoDXyBc8aciRR8d84dIkVK3DviNEnIDxl4GBW/jMjC6b/bLrpf4xDpNVcNc44JSFyKq+D7MKR4Zw6byGc3HpYJpXWCftf7bWAlgcHXU35vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690433; c=relaxed/simple;
	bh=k2m9iYAIvlkB7vXvKp4rjVwvEeXCjGF7PnGuU+rayxY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kqExHPClnqXDe1H/J9OtuscQV8yghnqe3SqxFxl+UQzFvb5SwOML8GaAw72gt0DIQf2BbEAPLCSYJ/JLRqP+TS/0Q01mciOgmwFP5jbiOpLq8PTJPcvO87m47SqPauLg/P05ftnmqndIdvg7q/ywTS0YEVv76ayOEtsO2uC4mMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0ED872j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B32C52FDD;
	Mon, 26 Aug 2024 16:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724690433;
	bh=k2m9iYAIvlkB7vXvKp4rjVwvEeXCjGF7PnGuU+rayxY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q0ED872jzRGghQp3s7dLm9vnqHhqlPR/lEMDCnkFZp7YMJeIX1fjFs64tMuH0ofhf
	 CrQMQeLTBeuhLZu6c5PhaMRr6dOYmftnIPUPQJUBBVT6OFWTfH+Pm3lIXr3wvHB3Da
	 i+U2RXDB1E71P5q/u3ExGJDrKzxcI76wPX+w5vpJZrlFjQfWIQJ6MBtwb1fDlw/sj9
	 o5m1nHuBXB7gHEJ9xjoHypur0fEigImY2pOqYIvH9FDhhCB4HgnFKOtpDWZRc9cZ8x
	 E88btR9U+VjFp8pggofJvSajHJa9Niz7HOCkB2XwN32EyRYXoBftA2v00awMFEkd+3
	 SOH7R/wCuAu7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C4D3822D6D;
	Mon, 26 Aug 2024 16:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] Add ALCD Support to Cable Testing Interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172469043299.64426.5670112366033990783.git-patchwork-notify@kernel.org>
Date: Mon, 26 Aug 2024 16:40:32 +0000
References: <20240822120703.1393130-1-o.rempel@pengutronix.de>
In-Reply-To: <20240822120703.1393130-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux@armlinux.org.uk

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Aug 2024 14:07:00 +0200 you wrote:
> Hi all,
> 
> This patch series introduces support for Active Link Cable Diagnostics
> (ALCD) in the ethtool cable testing interface and the DP83TD510 PHY
> driver.
> 
> Why ALCD?
> On a 10BaseT1L interface, TDR (Time Domain Reflectometry) is not
> possible if the link partner is active - TDR will fail in these cases
> because it requires interrupting the link. Since the link is active, we
> already know the cable is functioning, so instead of using TDR, we can
> use ALCD.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] ethtool: Extend cable testing interface with result source information
    https://git.kernel.org/netdev/net-next/c/abcd3026dd63
  - [net-next,v3,2/3] ethtool: Add support for specifying information source in cable test results
    https://git.kernel.org/netdev/net-next/c/4715d87e11ac
  - [net-next,v3,3/3] phy: dp83td510: Utilize ALCD for cable length measurement when link is active
    https://git.kernel.org/netdev/net-next/c/986a7fa4b454

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



