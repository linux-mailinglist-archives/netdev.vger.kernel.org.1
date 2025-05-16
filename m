Return-Path: <netdev+bounces-190900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB92CAB935D
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 02:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FEA84E2BF6
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 00:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED361D6DB9;
	Fri, 16 May 2025 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxrT6v76"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F3F1D63FC
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747357194; cv=none; b=Mg82fUvfDbZUQsgmN4E45vtYw2EfeXV61C20hOJrcY1TfF1sF8BRcWd48bElkNboRTxWYbAYK1YQXt6QduFo6k3I9VNMKd0O6/brDuLd/RXup+ERGDL2manR1ElDJGi7LUo3qbOGvl2wX+txoR9hrgmp+4WNgqF+OupXIS65rPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747357194; c=relaxed/simple;
	bh=hzxQZHxfS8l5J224f0fu07P9xz+Rm3FnC8uEIseAXCA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WD8tWxXZqG4pzuR72bUHAi+HcpTalky+gab2wXsq7L64dKGTm8zm8f+D8A4mp8FDXR/Ka+8JDiEf+e4uR29PiB3PgcHy36oAiLDQYIcHOQxeM/t/J94WwpWSWvTDPSh+r9PpwZTTL7RSNaojvb0EZB9UjpNfpF4XUxRUi2ares4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxrT6v76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBEBC4CEF1;
	Fri, 16 May 2025 00:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747357194;
	bh=hzxQZHxfS8l5J224f0fu07P9xz+Rm3FnC8uEIseAXCA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dxrT6v763XBOGVZN9ev58sEoNQ2ThzQQe7rEkaRd4i4wJB52f6kwDHA29biL3gWhS
	 B4FGHI/6pHfHXeghQ5brlS5ko97FxlFcj9VdNg4UidGIoVBDoZJj8Kc1iCXiBG0XTn
	 /ewatylnTy4b+PJ8Vn6BuZElukTF80Sjx2YTnTbS7v1hvlGqCrUZmd31RUCFavkeQq
	 evetWwmTFVp6/F7do9k/S7kpeq0wLLSFhd9s6B4mLgPDilWfeC5DHss8x6VSwEEKVC
	 OVO/TAODDQIHWYlN1I8uzhUC6aC78p9ulJ9XvweW16N+GJYVcspqvYmd6aGuMwlMfT
	 Y2skCU1CBidXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FD63806659;
	Fri, 16 May 2025 01:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: lan743x: convert to ndo_hwtstamp_set()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174735723101.3295414.14333538206850685044.git-patchwork-notify@kernel.org>
Date: Fri, 16 May 2025 01:00:31 +0000
References: <20250514151931.1988047-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250514151931.1988047-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, bryan.whitehead@microchip.com,
 Raju.Lakkaraju@microchip.com, vishvambarpanth.s@microchip.com,
 UNGLinuxDriver@microchip.com, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vadim.fedorenko@linux.dev, richardcochran@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 May 2025 18:19:29 +0300 you wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6.
> 
> It is time to convert the lan743x driver to the new API, so that
> timestamping configuration can be removed from the ndo_eth_ioctl()
> path completely.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: lan743x: convert to ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/958a857a626c
  - [net-next,2/2] net: lan743x: implement ndo_hwtstamp_get()
    https://git.kernel.org/netdev/net-next/c/abb258eb78a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



