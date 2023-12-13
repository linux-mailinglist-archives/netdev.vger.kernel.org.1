Return-Path: <netdev+bounces-56657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A717080FC06
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 01:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628BC282393
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F33910F0;
	Wed, 13 Dec 2023 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oicnRBSE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8269910EA;
	Wed, 13 Dec 2023 00:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 256BCC43395;
	Wed, 13 Dec 2023 00:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702426229;
	bh=VXosqkC/e3GEGFUuiG+gcRBbUiW7ZCrLw2sUasKp4+I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oicnRBSEmUG3ZpI42PyXQAtLa6H7MTNb2FnNttW3Oo+i7JxTulntzLvQF3YxPIl8O
	 1P6q3MjBRXcKMjx0PFm6YKCnnvdznvaTF/cuALk6s1Uf8HwEgVkB5Wciydb1XojQcC
	 Chk41fY9PcquLLZszFpAZIhyFRcSoEUDKb+w06fWMm/B6toQ+eqeTHicNiXMVzhWHL
	 dYhe2ET4YqmVKhlErTpWw3/EwWEm0nWWwZL8i9rzN9ElMpuTmfcxH7T1LD83oYEYU+
	 U9E2skaETZ6Qbw/uYxxSGQqAKBwDPRu1R/qhKnYduLlC6L5plNgxzt1Ah3GeEB2AJw
	 nEPbcF85jdajQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11808DFC907;
	Wed, 13 Dec 2023 00:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: mdio-gpio: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170242622906.31821.7118921876028610861.git-patchwork-notify@kernel.org>
Date: Wed, 13 Dec 2023 00:10:29 +0000
References: <20231211-strncpy-drivers-net-mdio-mdio-gpio-c-v3-1-76dea53a1a52@google.com>
In-Reply-To: <20231211-strncpy-drivers-net-mdio-mdio-gpio-c-v3-1-76dea53a1a52@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Dec 2023 19:10:00 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect new_bus->id to be NUL-terminated but not NUL-padded based on
> its prior assignment through snprintf:
> |       snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id);
> 
> [...]

Here is the summary with links:
  - [v3] net: mdio-gpio: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/79ac11393328

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



