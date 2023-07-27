Return-Path: <netdev+bounces-21700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9CA764516
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 06:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B191281FD4
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 04:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E17D1FA0;
	Thu, 27 Jul 2023 04:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CEC1FA5
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 04:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0FA1C433CD;
	Thu, 27 Jul 2023 04:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690433419;
	bh=oAlhpdqllpUNhhfbt/X1AhwYd7wBST0uOT3weX9MniI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gx7VVZnKdw2ilCi1HKaXlthvQk991ZJmhMwD2KqbOmUTRwDWwfYSiaxaBXPP6/iK3
	 k0LgKQZBErVAH4ihFp2UQYSj8w4Mm3pHtfN3OiAzx9bXIhKCNUmR1e3Qsrd+YPnn37
	 uYn4foaqqryd08xi9c9r3fBPt44qskW8mB8slQMoqze0JHqAVUEKjo19ouvdDAtLic
	 zqpJlvlgwoQ6d2rvRNgrVrvdXM7+TKsG1pWm2XyaMxmIirAwmF1ZTlqhH/kf4rfn8l
	 LtEfNYw889QV/QNWLCWV4Kh9QJeCI4yUfoM4usoGGn1XYma/vnSCQpoVbQMqJlhStj
	 nh2Ht7p5UcUsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9ED28C691F0;
	Thu, 27 Jul 2023 04:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bcmasp: BCMASP should depend on ARCH_BRCMSTB
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169043341964.19452.12546568587180628010.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jul 2023 04:50:19 +0000
References: <1e8b998aa8dcc6e38323e295ee2430b48245cc79.1690299794.git.geert+renesas@glider.be>
In-Reply-To: <1e8b998aa8dcc6e38323e295ee2430b48245cc79.1690299794.git.geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, florian.fainelli@broadcom.com, justin.chen@broadcom.com,
 simon.horman@corigine.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jul 2023 17:46:37 +0200 you wrote:
> The Broadcom ASP 2.0 Ethernet controller is only present on Broadcom STB
> SoCs.  Hence add a dependency on ARCH_BRCMSTB, to prevent asking the
> user about this driver when configuring a kernel without Broadcom
> ARM-based set-top box chipset support.
> 
> Fixes: 490cb412007de593 ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> [...]

Here is the summary with links:
  - [net] bcmasp: BCMASP should depend on ARCH_BRCMSTB
    https://git.kernel.org/netdev/net-next/c/73365fe44aa5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



