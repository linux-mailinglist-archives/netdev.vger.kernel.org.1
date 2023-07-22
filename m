Return-Path: <netdev+bounces-20089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9616075D8E4
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 04:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71CB1C21802
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 02:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1CC79D4;
	Sat, 22 Jul 2023 02:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78F76AA5
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 02:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BA91C433C7;
	Sat, 22 Jul 2023 02:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689991821;
	bh=LZMXAF3sjY0rOtOE+mG9qozWkjoC4MEsPJb4ux6Pn5M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D0+9xPAC3kMEMaUpnnHK/79jVdGVCezCLvQQYELPIHxbhrXJCsU4HzJm4siRe9VOa
	 GROZDrn4J7UCFAtDTkW98coIwj446LMuCM3Zmvv9sqNq1s4a5GdjKCQquAcWSlTESh
	 MxTAYDV6abxFQHWPLMcrbvQpiIkhrQjaUPQK7Oe5blXbH6a0FVYCLREvvlLwJXRb0a
	 UKrtbOyslK+d5NCJMa4PrY6jURGbQI7eAqcd0CeOy9uPotospVbwCCb4T6jknrGqnh
	 O5q9jRX/5x+Q9JBUQB7iJFLS6pyJli+reenWKf8sUdn1xOIdCWtKv1/gX3hBPfsCyY
	 WaafN+ypOiADg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DA33C595D0;
	Sat, 22 Jul 2023 02:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: net: fix sort order
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168999182123.11383.18422705757059724914.git-patchwork-notify@kernel.org>
Date: Sat, 22 Jul 2023 02:10:21 +0000
References: <20230720151107.679668-1-mkl@pengutronix.de>
In-Reply-To: <20230720151107.679668-1-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 kernel@pengutronix.de, florian.fainelli@broadcom.com,
 justin.chen@broadcom.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Jul 2023 17:11:07 +0200 you wrote:
> Linus seems to like the MAINTAINERS file sorted, see
> c192ac735768 ("MAINTAINERS 2: Electric Boogaloo").
> 
> Since this is currently not the case, restore the sort order.
> 
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Justin Chen <justin.chen@broadcom.com>
> Fixes: 3abf3d15ffff ("MAINTAINERS: ASP 2.0 Ethernet driver maintainers")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: net: fix sort order
    https://git.kernel.org/netdev/net-next/c/070e8bd31b28

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



