Return-Path: <netdev+bounces-214816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A678B2B5DD
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 03:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8CBC6207B8
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 01:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E337213B280;
	Tue, 19 Aug 2025 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plD62Ex9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8692110
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566419; cv=none; b=i2s0CD+uUAEwhQ6GI2s6u7Pm0DSW1UqY7bqxyfbiazQZOWjtmFmQ7v128yykhF9ZG5Ed5zDZbzlYgNJ1+4p4mqwfGXR3I+cYcIqm4+Mv7F4KAyykVqVlaeNRuG+kCH5aUVprPelr0QhCFA/UUqLU+bmrLgJBw2LnYpgKVlz+DtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566419; c=relaxed/simple;
	bh=imG/COrLI0xVx1ALeCqp04JnSJqQTYTunHsThHcZ3I8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ccl+sU3BNbUMQ5t4yn/lte73ww9BfAjxJHM/aulYJ5mqdQORVmvS+Xx4UnnNL83iHjJSHZL3hsLF99PKPxzJTQMW/Kv/kzhxnS6KXVhUnsAj7Edi1/duwpA6uzSCQhtmNSQHYtR8SeUwL2oA9OtcywYcg6A+U78kA7JWeHLtowo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plD62Ex9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB40C4CEEB;
	Tue, 19 Aug 2025 01:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755566418;
	bh=imG/COrLI0xVx1ALeCqp04JnSJqQTYTunHsThHcZ3I8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=plD62Ex9l6pV1NHPyPjLMLTkTsUI805/2pd2ujdpQp4+tLCoC83T4ZIPS13/Xnegk
	 RP2s97IkcwdtF55vfrUWWZVVjCDTMi9055n6J7sBDCW8E/jm+AvkTz0vvEbzTzMSCU
	 4Rj6yG1Sess3UqqyWY+q5m0tIZui06wbssfumY0409GHonL8rmFmqV710yebrI6QjW
	 LQ17VAXvqmcc+A2RmJiYO0PeAMxYQLqsA/q4++V9qzCMizU5ZOm3M6IOu+Ht+5vEya
	 eL6pWI8nPRJ6QNyseD6MK5hFwE90/+kQav0CTT5DBke7iWfVGpyDNzqtSZxoOyPjAh
	 ZFgzYRROMNE+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DAC383BF4E;
	Tue, 19 Aug 2025 01:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7] net: stmmac: EEE and WoL cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175556642825.2971230.1225757977150449764.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 01:20:28 +0000
References: <aJ8avIp8DBAckgMc@shell.armlinux.org.uk>
In-Reply-To: <aJ8avIp8DBAckgMc@shell.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Aug 2025 12:32:12 +0100 you wrote:
> Hi,
> 
> This series contains a series of cleanup patches for the EEE and WoL
> code in stmmac, prompted by issues raised during the last three weeks.
> 
> Andrew's r-b's added from the RFC posting.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] net: stmmac: remove unnecessary checks in ethtool eee ops
    https://git.kernel.org/netdev/net-next/c/6d598e856d10
  - [net-next,2/7] net: stmmac: remove write-only mac->pmt
    https://git.kernel.org/netdev/net-next/c/49b97bc52aff
  - [net-next,3/7] net: stmmac: remove redundant WoL option validation
    https://git.kernel.org/netdev/net-next/c/b181306e5e68
  - [net-next,4/7] net: stmmac: remove unnecessary "stmmac: wakeup enable" print
    https://git.kernel.org/netdev/net-next/c/f17bd297bb83
  - [net-next,5/7] net: stmmac: use core wake IRQ support
    https://git.kernel.org/netdev/net-next/c/d09413dd2577
  - [net-next,6/7] net: stmmac: add helpers to indicate WoL enable status
    https://git.kernel.org/netdev/net-next/c/6a9a6ce96229
  - [net-next,7/7] net: stmmac: explain the phylink_speed_down() call in stmmac_release()
    https://git.kernel.org/netdev/net-next/c/5e5b39aa6f82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



