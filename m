Return-Path: <netdev+bounces-39916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8701F7C4E37
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 11:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FB5282102
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 09:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E731A728;
	Wed, 11 Oct 2023 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsZeRKA5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B531A71F
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 09:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F33D8C433C8;
	Wed, 11 Oct 2023 09:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697015425;
	bh=JLYyKBJHxeifYby1tnPFjmaYZa4SYU0E3rUhNvB+YVY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YsZeRKA5VW2+uxJR5T1xh4dv25OFUPvWPmPQeChV7Oxy4qt0js/b5ZZgxhfRjOEvf
	 3ON6++0JOoZXgFdsYnMOzqg23qMLupi0r/txmhvTZxh53AovM72wlvC+lFJl66x4S5
	 d7/iLXB71yciWRFjzlohfOo8g4NRbNuur6X0b9b8lE+sk2Cm2BBuAi9FIe+pWAPwUh
	 Z7+4q30UwQPCk16KvsvRfCD/3vM/oztUsP+b2WyGAKFlir6LOYXYwSh+TbF8+bSTas
	 ViR0uZL0KulPhynZ9udXCaf+t2iDYzR0KE1y76JIFuuaxFG960PwZDlFG5CwAYHz5W
	 iApRGIvGZuYGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9680E21ED9;
	Wed, 11 Oct 2023 09:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: dsa: remove validate method
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169701542488.14579.12007814029438542061.git-patchwork-notify@kernel.org>
Date: Wed, 11 Oct 2023 09:10:24 +0000
References: <ZSPOV+GhEQkwhoz9@shell.armlinux.org.uk>
In-Reply-To: <ZSPOV+GhEQkwhoz9@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, f.fainelli@gmail.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, olteanv@gmail.com,
 linus.walleij@linaro.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 9 Oct 2023 10:56:39 +0100 you wrote:
> Hi,
> 
> These three patches remove DSA's phylink .validate method which becomes
> unnecessary once the last two drivers provide phylink capabilities,
> which this patch set adds. Both of these are best guesses.
> 
>  drivers/net/dsa/dsa_loop.c             |  9 +++++++++
>  drivers/net/dsa/vitesse-vsc73xx-core.c | 26 ++++++++++++++++++++++++++
>  net/dsa/port.c                         | 15 ---------------
>  3 files changed, 35 insertions(+), 15 deletions(-)

Here is the summary with links:
  - [net-next,1/3] net: dsa: vsc73xx: add phylink capabilities
    https://git.kernel.org/netdev/net-next/c/a026809c261b
  - [net-next,2/3] net: dsa: dsa_loop: add phylink capabilities
    https://git.kernel.org/netdev/net-next/c/db2c6d5fc4bd
  - [net-next,3/3] net: dsa: remove dsa_port_phylink_validate()
    https://git.kernel.org/netdev/net-next/c/63b9f7a19ff1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



