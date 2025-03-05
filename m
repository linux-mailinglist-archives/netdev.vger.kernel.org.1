Return-Path: <netdev+bounces-171892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFE9A4F36A
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 02:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1EFB16F74C
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 01:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70875156669;
	Wed,  5 Mar 2025 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5YMm3PR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4833B15575B;
	Wed,  5 Mar 2025 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137608; cv=none; b=Uwz+FdZ7pGtfzA9G76KJWFKwPegxvIfpZV5QKQ7FszuHHFLOz+BnYa9issuKBTOmMYoiCM0wMcyNibmT4hgRSSYf02QZl9REsQqRQgwEYXjIowYgFVOeG4PxqzN+6hKJ19wPuAMLL1RyZebulAAZp8PRDbXfnVGxJffC7sSdB5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137608; c=relaxed/simple;
	bh=qtYyU2GWkAbceijxko2dV24PO0Lb+bnlMbAzop+2lh4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZONqB7kLQnQA5Z6KOgYEZjlwMlP/vjy5bqBeZS1hykCQcqDPWPpbcwjku0i6vZl4W+DziVhytejCmGBJlHt8cN82OgNjo7kuD3sAi33tJgNKUwwo++BiJaVmfyW6Bcgq9sNWzS7uau0Mv5EmrdZP/yS4FEZl+bjOnjifLi98X2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5YMm3PR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2657C4CEEA;
	Wed,  5 Mar 2025 01:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741137607;
	bh=qtYyU2GWkAbceijxko2dV24PO0Lb+bnlMbAzop+2lh4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l5YMm3PRyJdJDEAGMe4nXh1wKrRQxCYv1TuNbR//WHU6Az2aCUkoYNxPy4sMecSAQ
	 5ib0evTNetqxQwNyEYkQKHcMQhIXfibsFp0DbAyVTjfl4oeMiyOao9FfD4DU79DTMd
	 d821zkJf0h6eS4xoi03u0PEX1eRqvpOJ6KmsWfUu5K2jrPQTCQt1sXfnrviTHe065G
	 s+lPVFwcBwGgCl2ujWsysLa/ETGrxduIu6wyAdm9gymjN/eTcsFfVoAgw8xfrfQWkR
	 g62kIpk7s+BnUiHaTr+PCGnO81+fz1V2fCWYSYANEaQ0hoVSKC+eEQQnlNYk57zrrF
	 zZSvzQJcGAfvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE82380CFEB;
	Wed,  5 Mar 2025 01:20:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: phy: nxp-c45-tja11xx: add support for
 TJA1121
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174113764050.356990.3050200111085365446.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 01:20:40 +0000
References: <20250228154320.2979000-1-andrei.botila@oss.nxp.com>
In-Reply-To: <20250228154320.2979000-1-andrei.botila@oss.nxp.com>
To: Andrei Botila <andrei.botila@oss.nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, s32@nxp.com,
 clizzi@redhat.com, aruizrui@redhat.com, eballetb@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Feb 2025 17:43:18 +0200 you wrote:
> This patch series adds .match_phy_device for the existing TJAs
> to differentiate between TJA1103/TJA1104 and TJA1120/TJA1121.
> TJA1103 and TJA1104 share the same PHY_ID but TJA1104 has MACsec
> capabilities while TJA1103 doesn't.
> Also add support for TJA1121 which is based on TJA1120 hardware
> with additional MACsec IP.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: phy: nxp-c45-tja11xx: add match_phy_device to TJA1103/TJA1104
    https://git.kernel.org/netdev/net-next/c/a06a868a0cd9
  - [net-next,v2,2/2] net: phy: nxp-c45-tja11xx: add support for TJA1121
    https://git.kernel.org/netdev/net-next/c/7215e9375694

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



