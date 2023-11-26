Return-Path: <netdev+bounces-51113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D487F9282
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 12:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179971C209B9
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 11:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DBCCA56;
	Sun, 26 Nov 2023 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2ClE7HW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6A8EC2
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 11:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3BECC433C9;
	Sun, 26 Nov 2023 11:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700998824;
	bh=34F4lqCISsRjHHVGpx+jJmrlhfrox2D5fMfaaHbhegc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R2ClE7HWx+mH4Lra9xUNcn/leXCR9TOFOxSImaA/rCd3RcOubQMW39dYyAQFw2U7I
	 Xza5WmiuYwGJWKWdaqUhEe+GaOxeWzSH4vCEfglVkarWJ2OXYESgpwLaZpOkglEuaM
	 opQtEfZucFZZCsMdX80MFxZy1NrDMjSiv4s6XRFqzYM/khTAb+4XBgbtHN0aYgutyq
	 oGnw682prRorr+KFq4TxQOKGcn4wLzm450upN7HKz5Uq5HwZfvl8iHSsz26VhHdNic
	 sY3ossyVkA/GobRqlYBFhFuO7FY+ffsz2RJZO9b1T7UKN2O4iYLQWPc5HN4/b5p5ep
	 V/tHrwNmyyRQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA800E00086;
	Sun, 26 Nov 2023 11:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 1/2] net: dsa: mv88e6xxx: fix marvell 6350 switch probing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170099882389.5867.3933796779624265445.git-patchwork-notify@kernel.org>
Date: Sun, 26 Nov 2023 11:40:23 +0000
References: <20231124041529.3450079-1-gerg@kernel.org>
In-Reply-To: <20231124041529.3450079-1-gerg@kernel.org>
To: Greg Ungerer <gerg@kernel.org>
Cc: rmk+kernel@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 24 Nov 2023 14:15:28 +1000 you wrote:
> As of commit de5c9bf40c45 ("net: phylink: require supported_interfaces to
> be filled") Marvell 88e6350 switches fail to be probed:
> 
>     ...
>     mv88e6085 d0072004.mdio-mii:11: switch 0x3710 detected: Marvell 88E6350, revision 2
>     mv88e6085 d0072004.mdio-mii:11: phylink: error: empty supported_interfaces
>     error creating PHYLINK: -22
>     mv88e6085: probe of d0072004.mdio-mii:11 failed with error -22
>     ...
> 
> [...]

Here is the summary with links:
  - [PATCHv2,1/2] net: dsa: mv88e6xxx: fix marvell 6350 switch probing
    https://git.kernel.org/netdev/net/c/b3f1a164c7f7
  - [PATCHv2,2/2] net: dsa: mv88e6xxx: fix marvell 6350 probe crash
    https://git.kernel.org/netdev/net/c/a524eabcd72d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



