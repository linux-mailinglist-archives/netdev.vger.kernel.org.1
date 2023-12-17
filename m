Return-Path: <netdev+bounces-58311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E05E815CF4
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 02:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C351C2154F
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 01:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF257F4;
	Sun, 17 Dec 2023 01:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8kisFly"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D0FEA9
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 01:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BE04C433CB;
	Sun, 17 Dec 2023 01:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702775512;
	bh=6AFA0mOFQ0nQxn91DIjKTeg2SOL+PFSGZdy2NqdILEo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k8kisFlyYY4VmHCgG0Fm0mRr6TmlhWyLmEsqmV80+ruWP5EVg/kSMnWpnVlcRHTAZ
	 X0Nr2nUQeRNCFtSiuqH7ynx5n2pNMkRqfIzuMBaSLwOdhyNx8dCcnz0og2d144vlYF
	 KPHGS6ES3lgIKwG0deBZh2ljnDhPLT096nrqy0antayNe0KY5Eiog/V8s8PsX9LDki
	 fV0sC115N3sIEjYfFFnl0yfkhh/jIUASciqhRNPuIstfaUshYl8CyT7PzsopSOWO6V
	 wPelEtAXqtZFmkGGs1C1JBJn/Fcsv80FajrvmQeAlzCYa8Ce4/MZD5gy7xEtvHkTpT
	 JQINKsOgwYgaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81DCBC4314C;
	Sun, 17 Dec 2023 01:11:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phylink: reimplement population of
 pl->supported for in-band
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170277551252.21831.11174233431443095768.git-patchwork-notify@kernel.org>
Date: Sun, 17 Dec 2023 01:11:52 +0000
References: <20231213155142.380779-1-vladimir.oltean@nxp.com>
In-Reply-To: <20231213155142.380779-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Dec 2023 17:51:42 +0200 you wrote:
> phylink_parse_mode() populates all possible supported link modes for a
> given phy_interface_t, for the case where a phylib phy may be absent and
> we can't retrieve the supported link modes from that.
> 
> Russell points out that since the introduction of the generic validation
> helpers phylink_get_capabilities() and phylink_caps_to_linkmodes(), we
> can rewrite this procedure to populate the pl->supported mask, so that
> instead of spelling out the link modes, we derive an intermediary
> mac_capabilities bit field, and we convert that to the equivalent link
> modes.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phylink: reimplement population of pl->supported for in-band
    https://git.kernel.org/netdev/net-next/c/37a8997fc5a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



