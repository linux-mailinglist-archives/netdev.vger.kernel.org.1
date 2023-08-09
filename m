Return-Path: <netdev+bounces-26036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A47257769BF
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B1A1C20F35
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300E019BA3;
	Wed,  9 Aug 2023 20:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A2124526
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 20:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D020C433C7;
	Wed,  9 Aug 2023 20:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691612422;
	bh=IgWIGYwbaRVg8Dh8flKqrLiWRhpgkgMSBj7YBNAiP2w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lpuV8K7/7jDQsintPKm4aHtHxPO3qhVwX83XopO+Pm1x59Qa1Bh14rI0Qs4IQ3LY/
	 tIdAqMBNo0gyoX+R25glS6agq1XbZfdJhcDMd3N1ZM4iM101++JDx++YCOaPVPfgIE
	 azY2jbV4nQMoUqQCRp5GEl1hepqgexyQ0/XDjl+7S+OWHAJct55ucdCuEPD1/mCHcB
	 B9P5VZXqz9FQgMS9gAUgWZmgAtGIWLZaIaeVVpLJUvio1qZHYG2C1YTy5kbjQjyaCY
	 kTKCnEvzNjUUNSSr54vBHsgMpvwdTQwUJXHqkmWuN+1h1AiVnik6/r1XKAtilnPo53
	 7x/Vn/Bi29ilg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7489BE33090;
	Wed,  9 Aug 2023 20:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169161242247.16318.3088407520751400257.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 20:20:22 +0000
References: <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 08 Aug 2023 12:12:16 +0100 you wrote:
> If we successfully parsed an interface mode with a legacy switch
> driver, populate that mode into phylink's supported interfaces rather
> than defaulting to the internal and gmii interfaces.
> 
> This hasn't caused an issue so far, because when the interface doesn't
> match a supported one, phylink_validate() doesn't clear the supported
> mask, but instead returns -EINVAL. phylink_parse_fixedlink() doesn't
> check this return value, and merely relies on the supported ethtool
> link modes mask being cleared. Therefore, the fixed link settings end
> up being allowed despite validation failing.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: mark parsed interface mode for legacy switch drivers
    https://git.kernel.org/netdev/net-next/c/145622771d22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



