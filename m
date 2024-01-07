Return-Path: <netdev+bounces-62234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3388264FB
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 17:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38443B20F13
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 16:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1383C13AC7;
	Sun,  7 Jan 2024 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pnkvn2gR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE76813AC2
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 16:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C691C433C8;
	Sun,  7 Jan 2024 16:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704643823;
	bh=a7N/ME3IfKvRa1T8hbgY1xBHCwKN9OHZsWbh8mc7uec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pnkvn2gRRV7JE/QNFLeLu+rhh07OnVyf8WoHPC57z1AvnOlemMa/egGpNgHhpkwwf
	 1FTgAxYX+xvHq8mRA2Ob9Zb5ROX4AaI/2kzLGwXdy2oV1upc67cHWpVruerkI1RCAk
	 UEpygYd17Uc7kjlfWlrwWPp3g8MluxEQBNG0sNCJw86JILrJCpiIAQf6+8r5zB9WqF
	 f1uc3v9tygvu1kNEM4Eajgjk/QUx47cZoMCnbJ59WKEHu3I8hwAdst+fdK246BDTJH
	 X3jZ8LOyV4bTmasnd2aIGz7Zownjh8BgG0D5H/6Yx+Jv6I9jvUbaEYucBSblud0ZUO
	 VIZk2jDHvAIxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43724C4167F;
	Sun,  7 Jan 2024 16:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6] net: ethernet: cortina: Drop TSO support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170464382327.3646.15433229900431891696.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jan 2024 16:10:23 +0000
References: <20240106-new-gemini-ethernet-regression-v6-1-889e98d3deb7@linaro.org>
In-Reply-To: <20240106-new-gemini-ethernet-regression-v6-1-889e98d3deb7@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: ulli.kroll@googlemail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com, canghousehold@aol.com,
 romain.gantois@bootlin.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 06 Jan 2024 01:12:22 +0100 you wrote:
> The recent change to allow large frames without hardware checksumming
> slotted in software checksumming in the driver if hardware could not
> do it.
> 
> This will however upset TSO (TCP Segment Offloading). Typical
> error dumps includes this:
> 
> [...]

Here is the summary with links:
  - [net,v6] net: ethernet: cortina: Drop TSO support
    https://git.kernel.org/netdev/net/c/ac631873c9e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



