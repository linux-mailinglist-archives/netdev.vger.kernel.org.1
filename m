Return-Path: <netdev+bounces-31883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C120A791149
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 08:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE821C204F9
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 06:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F9CA45;
	Mon,  4 Sep 2023 06:21:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B6DA34
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 06:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8004AC433C7;
	Mon,  4 Sep 2023 06:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693808465;
	bh=29N1e8HELfP3+P2Rsxxmt1XUP7m58cYlampgq/7u8gA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QzG1ZWJj+MYF8ADGr+84C5CsO7MOE/gFDncHkrxv+RlFaezBIJzrtdac7sXAc4k7z
	 uBw25Vrwb7xUMs8aX3lEOxAeXBAjVJ+TAyeblu942B6Kjh9q11/3VGPhnW7rqiuGH8
	 SU7p5hFKRRGv7FiVeicEU9augcxTsDUf1jYyw03Ue0OWrUkK7QhpXmVCb2hVPbdmjm
	 5F6cUq/IVyoVjpXxIByVMLihN0BCyfLW8Jk2x7kxiKWIKoxnRkA1fhiDExyPkpeOO+
	 OFUymD8QrwRtcRygJAZgeIZCZju0vdYiM6/IxzpuxGk7+8I1yh8CN21UuBwMhdu29z
	 3VOEf7kbvq/1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6414DC04E27;
	Mon,  4 Sep 2023 06:21:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/1] net: phy: micrel: Correct bit assignments for
 phy_device flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169380846539.7662.5346435566421171880.git-patchwork-notify@kernel.org>
Date: Mon, 04 Sep 2023 06:21:05 +0000
References: <20230901045323.3907976-1-o.rempel@pengutronix.de>
In-Reply-To: <20230901045323.3907976-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
 netdev@vger.kernel.org, lukma@denx.de

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  1 Sep 2023 06:53:23 +0200 you wrote:
> Previously, the defines for phy_device flags in the Micrel driver were
> ambiguous in their representation. They were intended to be bit masks
> but were mistakenly defined as bit positions. This led to the following
> issues:
> 
> - MICREL_KSZ8_P1_ERRATA, designated for KSZ88xx switches, overlapped
>   with MICREL_PHY_FXEN and MICREL_PHY_50MHZ_CLK.
> - Due to this overlap, the code path for MICREL_PHY_FXEN, tailored for
>   the KSZ8041 PHY, was not executed for KSZ88xx PHYs.
> - Similarly, the code associated with MICREL_PHY_50MHZ_CLK wasn't
>   triggered for KSZ88xx.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] net: phy: micrel: Correct bit assignments for phy_device flags
    https://git.kernel.org/netdev/net/c/719c5e37e99d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



