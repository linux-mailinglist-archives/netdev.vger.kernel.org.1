Return-Path: <netdev+bounces-45645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA5E7DEC24
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 06:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BCE5B2105C
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 05:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA4E1FB2;
	Thu,  2 Nov 2023 05:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AG7RImVW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FAA1FA7
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 05:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C7EDC433C8;
	Thu,  2 Nov 2023 05:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698901824;
	bh=bzR2RaLaT2nMVmnA0N6mBNlgAptSXtYyvUKXDGond14=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AG7RImVWVbX0Zd1qznsTXUhD1iimL2L7z7j0Txu0PulPFUeuaoViAfKdj+jVfgKSf
	 PNQ2a6Du8paURJUAcpTSiIfWmjw/4W9Rxp08bxWJjmgmrF3Pvwnu9EtTfIRjlUY1a+
	 +mPrpXlInUmmeHz/DYS5V40sCcteSA0IrSSbLREzm6SMay3UEAVRjNm3tYMotTWCsj
	 2Gvw96Q987lkBEsJEqv1Y+FYcO6JDcszmEz5g0RsWkrFC3MWI+Al8a4Qf9dK3+9+BD
	 TJGg6b/6GId9G5681RneUqo26Hfj+g+L6onvJmXUhIRzUUwOGlnhLC3Zg0v/R13nIF
	 M6jFZ8VX1GNUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 725EEE00092;
	Thu,  2 Nov 2023 05:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/2] Add missing MODULE_DESCRIPTIONS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169890182446.20479.14661638602610307439.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 05:10:24 +0000
References: <20231028184458.99448-1-andrew@lunn.ch>
In-Reply-To: <20231028184458.99448-1-andrew@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, rmk+kernel@armlinux.org.uk,
 f.fainelli@gmail.com, richardcochran@gmail.com, joel@jms.id.au,
 andrew@codeconstruct.com.au

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 28 Oct 2023 20:44:56 +0200 you wrote:
> Fixup PHY and MDIO drivers which are missing MODULE_DESCRIPTION.
> 
> Andrew Lunn (2):
>   net: phy: fill in missing MODULE_DESCRIPTION()s
>   net: mdio: fill in missing MODULE_DESCRIPTION()s
> 
>  drivers/net/mdio/acpi_mdio.c    | 1 +
>  drivers/net/mdio/fwnode_mdio.c  | 1 +
>  drivers/net/mdio/mdio-aspeed.c  | 1 +
>  drivers/net/mdio/mdio-bitbang.c | 1 +
>  drivers/net/mdio/of_mdio.c      | 1 +
>  drivers/net/phy/bcm-phy-ptp.c   | 1 +
>  drivers/net/phy/bcm87xx.c       | 1 +
>  drivers/net/phy/phylink.c       | 1 +
>  drivers/net/phy/sfp.c           | 1 +
>  9 files changed, 9 insertions(+)

Here is the summary with links:
  - [v1,net-next,1/2] net: phy: fill in missing MODULE_DESCRIPTION()s
    https://git.kernel.org/netdev/net/c/dd9d75fcf0f4
  - [v1,net-next,2/2] net: mdio: fill in missing MODULE_DESCRIPTION()s
    https://git.kernel.org/netdev/net/c/031fba65fc20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



