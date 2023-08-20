Return-Path: <netdev+bounces-29155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FC3781D7A
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 12:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C445A1C20444
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 10:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09045668;
	Sun, 20 Aug 2023 10:49:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E59539F
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 10:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0CB3C433CB;
	Sun, 20 Aug 2023 10:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692528567;
	bh=A+omY1vrghxxLUAgUoo/PFgjdr9rHEVJytQ9bqYrS9s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WIOooW0/dQGSLVG2xZnI65MpxGzWPrbziymOVp/SNKEOhMhpBD5jWWFeXbUxa4OPB
	 zBel8OCtwtEt6kFEAz1QHGhg+yw/eIHwnFf8LmjcK9NaawSoIOTBuTPXjYBoGFS2DE
	 0jUI/sinJocykzaCAs89zrgc2WbzdAgWtNR9wIxtj5+bSp0Rmu0pRxyKXvfviYVl4+
	 K9mAyFdW/lmbB/ph26d32PX08eDs/pt4NCfYqtt4BFO2087fw59DupR1Q1mfa7GEoa
	 1R9gi76jk+9LTno/9wi/c4qjLCVVUqAPv3KD4S3PVSBjC0k+OHNH+BqPeySq8+Yvyd
	 20ATWt8r4CPOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE2DCC395C5;
	Sun, 20 Aug 2023 10:49:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: realtek: add phylink_get_caps
 implementation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169252856777.3170.269285332063521836.git-patchwork-notify@kernel.org>
Date: Sun, 20 Aug 2023 10:49:27 +0000
References: <E1qXJrG-005Oey-10@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qXJrG-005Oey-10@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linus.walleij@linaro.org,
 alsi@bang-olufsen.dk, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 19 Aug 2023 12:11:06 +0100 you wrote:
> The user ports use RSGMII, but we don't have that, and DT doesn't
> specify a phy interface mode, so phylib defaults to GMII. These support
> 1G, 100M and 10M with flow control. It is unknown whether asymetric
> pause is supported at all speeds.
> 
> The CPU port uses MII/GMII/RGMII/REVMII by hardware pin strapping,
> and support speeds specific to each, with full duplex only supported
> in some modes. Flow control may be supported again by hardware pin
> strapping, and theoretically is readable through a register but no
> information is given in the datasheet for that.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: realtek: add phylink_get_caps implementation
    https://git.kernel.org/netdev/net-next/c/b22eef6864ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



