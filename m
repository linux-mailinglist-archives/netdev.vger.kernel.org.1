Return-Path: <netdev+bounces-96162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCE18C4897
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 23:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C560FB235B8
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 21:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45794823CB;
	Mon, 13 May 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGo2Sybp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF8181741;
	Mon, 13 May 2024 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715634031; cv=none; b=c2fG4pyWKJrcv44GcLZcLZE9ewoUWOePLN4kKnHLCe5o3JaOhyRwRaJ5ioOsEdNNIG/W08APgzxJgJetLmSHVuhxuUYg3TX9V5RmMxib/qifhrojogn0pVhTo1OTDwJgkp++L4AfX3Izx7iA5JVYCvXOXgJDLOLHQk3uJ7cf4+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715634031; c=relaxed/simple;
	bh=hIkA1gPj2/D1aunRqsi8+wfqPz4MiORLkR+FQhueo/I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GlpfZvknvCnblBJY2KiIIGgygcZqcFDQXBZyI2n/RbjzJlu0is/YshEJsOdlYfrEdHiX4qDN81RIhJk1kWVuJL9uteJ9Lns8B5dRMdU4DGP+joEKzLtMfS8p+pKMi29L36MkWcioP5F8P6L2VJ0+InnxQnEPP5Z9+6ijUu6Jnbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGo2Sybp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD78DC32786;
	Mon, 13 May 2024 21:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715634030;
	bh=hIkA1gPj2/D1aunRqsi8+wfqPz4MiORLkR+FQhueo/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YGo2SybpZMyGq3ZswKa1a78fgrFlkjfUPPVSHAMNGI9c2rlMTs/QSHFLv80eX3rcb
	 vX1tVlJD3PYiu7BrX17gWRt+8nQZafQw68s9Fc/K9LNMTX8Aktofsb85jUdP/UKZvl
	 E3Ww66odq3fBov3G5gbpMtn4xvEeZI4ps7AgDtfudwP23vZPQacdf7nzFyovtNoG7X
	 X9Waggx+aAwuRiKFqjndsQVg6Dm1ZIg6hs7SmEC8lJdJ2RbPFZXvmwPMpF8L4nmsvf
	 gfSQnxQjfZEu+SdNrT7cHQq1BA7GE4HpYoqk5m4FpPWWJf8wEECikKZeOwiuPZR4Hq
	 RUBuh2wF3eMOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E9EEC43443;
	Mon, 13 May 2024 21:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: air_en8811h: reset netdev rules when
 LED is set manually
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171563403064.25832.6280293947152507143.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 21:00:30 +0000
References: <5ed8ea615890a91fa4df59a7ae8311bbdf63cdcf.1715248281.git.daniel@makrotopia.org>
In-Reply-To: <5ed8ea615890a91fa4df59a7ae8311bbdf63cdcf.1715248281.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ericwouds@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 9 May 2024 11:00:42 +0100 you wrote:
> Setting LED_OFF via brightness_set should deactivate hw control, so make
> sure netdev trigger rules also get cleared in that case.
> This fixes unwanted restoration of the default netdev trigger rules and
> matches the behaviour when using the 'netdev' trigger without any
> hardware offloading.
> 
> Fixes: 71e79430117d ("net: phy: air_en8811h: Add the Airoha EN8811H PHY driver")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: air_en8811h: reset netdev rules when LED is set manually
    https://git.kernel.org/netdev/net-next/c/87bfdbbb1992

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



