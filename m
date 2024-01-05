Return-Path: <netdev+bounces-61916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEED82532D
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 13:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F501C227DF
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 12:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F272CCB8;
	Fri,  5 Jan 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Puy2ML8h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2668A2CCB2
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 12:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5ADCC433C9;
	Fri,  5 Jan 2024 12:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704456027;
	bh=HABBMcf2qpEYNsmdi9LoyknRKlR0TJ1DyoY1ZcAavGY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Puy2ML8h3yb0mrAb50zwF9s06413aoblCqzdPm0ynEMy33o3JvJS79qanlSox3Eny
	 e539hlVU1MHFSOfjig4kp/m5wa0DeZuUxCAD7eqXId74gykSThWjwKFxqwcr60+j0q
	 zmEsx8xpnm5rW1lgHovMLm7PJfhU9cb3TD/eVDnaGxF/27CV8n452jQjnPz37HrYas
	 mGK19j0o9P2a/R/ls3fqFxuZoqUapzEssekfS3lqFmMGOYaaj1TJFlEpCthCtAT4Dp
	 gTIEI6oSZVvCfnfbWhH9EkltwgA4qLChPaqbV74O/iQUWULrpG280D2CTETjqf5yxp
	 H0Rz/c683H1Xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 834B3DCB6D8;
	Fri,  5 Jan 2024 12:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] ds->user_mii_bus cleanup (part 1)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170445602753.29854.15404184789063719245.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jan 2024 12:00:27 +0000
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
In-Reply-To: <20240104140037.374166-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, f.fainelli@gmail.com,
 luizluca@gmail.com, alsi@bang-olufsen.dk, linus.walleij@linaro.org,
 florian.fainelli@broadcom.com, hauke@hauke-m.de, ansuelsmth@gmail.com,
 arinc.unal@arinc9.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  4 Jan 2024 16:00:27 +0200 you wrote:
> There are some drivers which assign ds->user_mii_bus when they
> don't really need its specific functionality, aka non-OF based
> dsa_user_phy_connect(). There was some confusion regarding the
> fact that yes, this is why ds->user_mii_bus really exists, so
> I've started a cleanup series which aims to eliminate the usage
> of ds->user_mii_bus from drivers when there is nothing to gain
> from it.
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] net: dsa: lantiq_gswip: delete irrelevant use of ds->phys_mii_mask
    https://git.kernel.org/netdev/net-next/c/fc74b32b4032
  - [net-next,02/10] net: dsa: lantiq_gswip: use devres for internal MDIO bus, not ds->user_mii_bus
    https://git.kernel.org/netdev/net-next/c/cd4ba3ecced9
  - [net-next,03/10] net: dsa: lantiq_gswip: ignore MDIO buses disabled in OF
    https://git.kernel.org/netdev/net-next/c/7a898539391d
  - [net-next,04/10] net: dsa: qca8k: put MDIO bus OF node on qca8k_mdio_register() failure
    https://git.kernel.org/netdev/net-next/c/68e1010cda79
  - [net-next,05/10] net: dsa: qca8k: skip MDIO bus creation if its OF node has status = "disabled"
    https://git.kernel.org/netdev/net-next/c/e66bf63a7f67
  - [net-next,06/10] net: dsa: qca8k: assign ds->user_mii_bus only for the non-OF case
    https://git.kernel.org/netdev/net-next/c/525366b81f33
  - [net-next,07/10] net: dsa: qca8k: consolidate calls to a single devm_of_mdiobus_register()
    https://git.kernel.org/netdev/net-next/c/5c5d6b34b683
  - [net-next,08/10] net: dsa: qca8k: use "dev" consistently within qca8k_mdio_register()
    https://git.kernel.org/netdev/net-next/c/c4a1cefdf3bc
  - [net-next,09/10] net: dsa: bcm_sf2: stop assigning an OF node to the ds->user_mii_bus
    https://git.kernel.org/netdev/net-next/c/04a4bc9dddc7
  - [net-next,10/10] net: dsa: bcm_sf2: drop priv->master_mii_dn
    https://git.kernel.org/netdev/net-next/c/45f62ca5cc48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



