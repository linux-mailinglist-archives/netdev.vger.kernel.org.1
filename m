Return-Path: <netdev+bounces-189415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA11BAB206D
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 02:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D5C47B1F2E
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 00:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014C933F6;
	Sat, 10 May 2025 00:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5pPXF+t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FB12594;
	Sat, 10 May 2025 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746835790; cv=none; b=MLrMp6ygc/ZlqUNsrxXwFzWsd6zcbvroL5rfJLUJSbfZa0vde8OeMBDjjztXABjKqnSfs2qtKAJDP5+xNu0daIF86Y9DHtENERymfhq+yBXW6YFxMp8nmXxXyq9YzZ5OEBY9eOKvjBE5yVOYfZIK+E4//JU/Y13vAOfGthhsVw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746835790; c=relaxed/simple;
	bh=kXNBeRU7VCxMX/j1nGw2XIM7gL8Cgd788Rgg4Hct5KM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lzmNVVX9ZWu20F3WnK5ptXhZWCLAZkk3vDT0r3T6ImlCExOXtczXOIrZV1q+e39PSd/cSWs/+zcHeCGsfp9dpAAPn/qNQRHhyXkGwUrtl4zUAHDmcprQ9Tg7m9fg/KhDwDEOy+w7kN8iVpzPDTMSSCo0x3QZqo9ZYeOtyjicRNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5pPXF+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFFAC4CEE4;
	Sat, 10 May 2025 00:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746835790;
	bh=kXNBeRU7VCxMX/j1nGw2XIM7gL8Cgd788Rgg4Hct5KM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L5pPXF+taDiU6O4URLhb8fgD25ohfQCeegirga08uxKsx5/EUh67lK1rsw/Y0Yv14
	 h+4AVMuqx8Yt49vJfXdbnwXMW4UzdvvxJfaKtgIPUEM+ylil/GD1+22vAkEfjd/FBM
	 G3jvCdx/mwDIGr8rEUtmUNLDJ7J9tt7MRbt38XPymtOIPJoACfCcV6BLvUylwtw6MY
	 BnNrObb71Lgc9u9FZRHDZc22IOuWYUH8HCYZmLML0pKXq3PYLnE9qwycmlsjBD5AZr
	 m1jEkWPrWbSHT8iblrjPn/pd7X+N8Z+7VPEbHjZBRq+nvGcI4x5z+Ya/3Z7ZGVTVmH
	 PDgoUNjim+o/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC7E381091A;
	Sat, 10 May 2025 00:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mvpp2: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174683582851.3848477.5233720660248982558.git-patchwork-notify@kernel.org>
Date: Sat, 10 May 2025 00:10:28 +0000
References: <20250508144630.1979215-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250508144630.1979215-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, kory.maincent@bootlin.com,
 marcin.s.wojtas@gmail.com, linux@armlinux.org.uk, claudiu.manoil@nxp.com,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, richardcochran@gmail.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 May 2025 17:46:30 +0300 you wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6. It is
> time to convert the mvpp2 driver to the new API, so that the
> ndo_eth_ioctl() path can be removed completely.
> 
> Note that on the !port->hwtstamp condition, the old code used to fall
> through in mvpp2_ioctl(), and return either -ENOTSUPP if !port->phylink,
> or -EOPNOTSUPP, in phylink_mii_ioctl(). Keep the test for port->hwtstamp
> in the newly introduced net_device_ops, but consolidate the error code
> to just -EOPNOTSUPP. The other one is documented as NFS-specific, it's
> best to avoid it anyway.
> 
> [...]

Here is the summary with links:
  - [net-next] net: mvpp2: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/3c9ff6eb2de5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



