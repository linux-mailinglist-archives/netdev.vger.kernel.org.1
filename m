Return-Path: <netdev+bounces-23580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F6876C90C
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 11:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BCD281CF7
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7995686;
	Wed,  2 Aug 2023 09:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8F35685
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 09:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5431C433C9;
	Wed,  2 Aug 2023 09:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690967421;
	bh=hbDe5VNi38FyeWM4a+GIOVZBfB/pl/EA2dNFf0kspKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LILAmfCcKmjnLEa6a7zoHJV4NNoC/3R5pI140X8qm1Aa341LJkF6ADGfO3G+ZKdm0
	 zUtlAtZyTPARpDVmmNY2jDYML1XmI6jdLJydm4e1H/6noyeNVO2D6utXCo8pmk0asD
	 3vCq7OgVFgdP+aa/DyYySpGGAEt059sPtr/Xf8cmbEaMHa6h+60yGyDU3oW5pt+2bC
	 89gCN6siVRjt5vo3RfpWbFDnzWAuEam7eFiriArdZDLtWk93d6qi1ttyFuTGgBF9TY
	 JmtzeEcyoNWBgTvitnD5Q9fpTLcaRen6z735GkYMHoag5yeTSC23XpXueUpqhe5Jvp
	 FX4TsoZWIgeEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82491C6445B;
	Wed,  2 Aug 2023 09:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: ethernet: dwmac: oxnas glue removal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169096742152.32235.5074570655625825451.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 09:10:21 +0000
References: <20230731-topic-oxnas-upstream-remove-v3-0-a1bddb085629@linaro.org>
In-Reply-To: <20230731-topic-oxnas-upstream-remove-v3-0-a1bddb085629@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
 devicetree@vger.kernel.org, linus.walleij@linaro.org, arnd@arndb.de,
 daniel@makrotopia.org, andy@kernel.org, conor.dooley@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 31 Jul 2023 16:41:09 +0200 you wrote:
> With [1] removing MPCore SMP support, this makes the OX820 barely usable,
> associated with a clear lack of maintainance, development and migration to
> dt-schema it's clear that Linux support for OX810 and OX820 should be removed.
> 
> In addition, the OX810 hasn't been booted for years and isn't even present
> in an ARM config file.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: stmmac: dwmac-oxnas: remove obsolete dwmac glue driver
    https://git.kernel.org/netdev/net-next/c/a67fa91130ca
  - [net-next,v3,2/2] dt-bindings: net: oxnas-dwmac: remove obsolete bindings
    https://git.kernel.org/netdev/net-next/c/6d7d66ac9ce1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



