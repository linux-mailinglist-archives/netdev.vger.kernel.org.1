Return-Path: <netdev+bounces-99216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 695E18D4245
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE8B7B2240A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 00:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C0420EB;
	Thu, 30 May 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WK+dY9CN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1274136B
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717028432; cv=none; b=q48MXXMz5mG0LgcQPU5SNTtQ9MNXcXyviiuBw0tWmDjucEe/phezihTfE0/r1EQQj9WtVqyp+Hh8iv0ibtzo3zcotTCkkeGyyspRBhDqoETB68AtuLgmzzeMh9bYtUV9mY+4y2BeYDUpCQOiya0/fLBD/mSNSEKHsaEVuUe55Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717028432; c=relaxed/simple;
	bh=kKvK1M8t9zhNQYupiA0IxFah7pe9dHwW+pJwTgChvZM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eBnUednatbpdetmYoSeHgxVIWruIqSBtlzmkN352N4aN51NayZAlDOfm/jgshyEDz4WVK5nkfN2YwyRnG82aUB2Xq9jcHNrrIlncnky3946cmlCBb+lUzqb+r+wxAfRSN7XJEvpLummV0LnplpyTQ/vFaUq7S4Vrr6J1N//267k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WK+dY9CN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CBC7C32781;
	Thu, 30 May 2024 00:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717028431;
	bh=kKvK1M8t9zhNQYupiA0IxFah7pe9dHwW+pJwTgChvZM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WK+dY9CNARmdRjf/YLdPYz7T5iDcQlhpd+idGCIj5WiS1JqBi3wVov1Q5STobS1lW
	 RF1I2g0zPK8CqwMrPN70fyFwJuvGQwdX14gxpCOvhMEJ5PrGWSYxccmVEwOI4OIbrk
	 XvESye8BQ9lxqfHjanaZNOLf21sj8LZk5arYDz3wtsjM/9Y4upavk7yBEHMXuvKtrs
	 7RKoEr4A5zE2cYNekEP/EtSVCod0xA65pcsF3xVZqZLXCwhDAcDP2blP5JsOBowaA5
	 HwnNxGNKnEbaLsF1SqX62l8Mg6GYbZddWmq/IZb/ukMXe3de7Fej8r75oz6XVb2UK3
	 zL7ttglqQBQBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A825D40190;
	Thu, 30 May 2024 00:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: lan9303: imply SMSC_PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171702843143.13917.15004407102158999412.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 00:20:31 +0000
References: <20240528073147.3604083-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20240528073147.3604083-1-alexander.sverdlin@siemens.com>
To: A. Sverdlin <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 09:31:13 +0200 you wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Both LAN9303 and LAN9354 have internal PHYs on both external ports.
> Therefore a configuration without SMSC PHY support is non-practical at
> least and leads to:
> 
> LAN9303_MDIO 8000f00.mdio:00: Found LAN9303 rev. 1
> mdio_bus 8000f00.mdio:00: deferred probe pending: (reason unknown)
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: lan9303: imply SMSC_PHY
    https://git.kernel.org/netdev/net-next/c/126913479e88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



