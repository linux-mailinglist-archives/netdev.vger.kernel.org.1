Return-Path: <netdev+bounces-20745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14375760E05
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 11:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA281C20C76
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2EC14281;
	Tue, 25 Jul 2023 09:10:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B62419F
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9C5DC433A9;
	Tue, 25 Jul 2023 09:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690276225;
	bh=+I3MrAkozYgkZ/ft0JFCrt2ovq1ZVfIjLtRLYDP33Co=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RpOeLjq0O8uuZNCUT4tikvPjADpnk+kFZFoJVVM/QcmqtAYeffGu3ONdhASc9sXYm
	 djR9jWSd1hMWApUKRc3D6nanYBiTd0HkVir3lLUP+9xuAQgrH55mHQD8vKLz5KSSsG
	 boDmbuZoALT+F0txVEPrGeaEDH/SImFOv7WTF67TE89j6QSvIWJ2IZjXD6FUlIEiJX
	 cD4+BNjXPtiRAJhWfx6qtDbjd49qY96ESkFqsj5GYsGXbiScbz3GHvySjzNx/zmAbO
	 h7v9KBWhCe6paxAtWVhOjlft3V16p7s9bSu/Fx8HsYUTfP23b+i3rLuNc1+4f5R4Ir
	 HkWfCQohpD2Ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCDC7C595D0;
	Tue, 25 Jul 2023 09:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: Apply redundant write work around on 4.xx
 too
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169027622483.7192.11650697551791902221.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jul 2023 09:10:24 +0000
References: <20230721-stmmac-tx-workaround-v1-1-9411cbd5ee07@axis.com>
In-Reply-To: <20230721-stmmac-tx-workaround-v1-1-9411cbd5ee07@axis.com>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 hkallweit1@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@axis.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 21 Jul 2023 15:39:20 +0200 you wrote:
> commit a3a57bf07de23fe1ff779e0fdf710aa581c3ff73 ("net: stmmac: work
> around sporadic tx issue on link-up") worked around a problem with TX
> sometimes not working after a link-up by avoiding a redundant write to
> MAC_CTRL_REG (aka GMAC_CONFIG), since the IP appeared to have problems
> with handling multiple writes to that register in some cases.
> 
> That commit however only added the work around to dwmac_lib.c (apart
> from the common code in stmmac_main.c), but my systems with version
> 4.21a of the IP exhibit the same problem, so add the work around to
> dwmac4_lib.c too.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: Apply redundant write work around on 4.xx too
    https://git.kernel.org/netdev/net/c/284779dbf4e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



