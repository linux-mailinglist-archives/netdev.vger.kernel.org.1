Return-Path: <netdev+bounces-133403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B81C6995D00
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 03:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9DA51C21E17
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D66B7DA88;
	Wed,  9 Oct 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+STguNT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7564F35894;
	Wed,  9 Oct 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728437431; cv=none; b=O/Z1TRLzWSKdbXAHTynM1ufVyZ/wUJpX/rLkcc88bMTZmo0IV3Yk1Iz3oRSiEXagdsCLjYzeNuLnWxOtTcsdsoEshiHfZCvBK2+0edtmopyHuIrxjqx3ZgRRpogusQ0KoPHBVcDTm3EPmiChwBRGfTmiGG2i6nd/whGtA1vzFU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728437431; c=relaxed/simple;
	bh=ELeUXHnxTfESquvIYIJAk+Lmnxd8MqxPod7WKlmXj98=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VFgeukiL6kzcw35BQyrWt/Rzg3kdN25G5zFPsQ+/BeWYDzltbBQdCUyle9AvXqTI7GjPP3NUZrKzkqP1ajK1u5UNBL0Fh5rrGBtHdRWxjivMdyENs3vAjeI2Yx93IJNeOTSzI7/2guwCXY7vls24bSzidA7cj/O7FcwoQ4Fgljk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+STguNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0564AC4CEC7;
	Wed,  9 Oct 2024 01:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728437431;
	bh=ELeUXHnxTfESquvIYIJAk+Lmnxd8MqxPod7WKlmXj98=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X+STguNTU+lVKkb3Ve8PNFmrNMqFqg7Hxmz468Rx784HArCcdwhNYeHUAfcvdzQBB
	 4TGMcDiOjm43t8pE4/aKi9UA+9E6HVTSfjr/jxp+iBuA7n0csSoy9UcubB/xJGkfjJ
	 yT4rRsTYc1h5x7mRVtcw4UB39paKfIKxXsBMjalxHEb5ZjEJoNy/UVX2+4FQxrraXo
	 /C9Y56mmVBGPFKyyB26wAar5vwC7FXy2uQUZ23n1vpArAiP0S6VZEYZvGAudJO0Kwc
	 AHOvfPLZ16+H+WmQ/6rXWhsWU+jVvQSrRnwtGWSpxF6bgsKpBj0cSu/XX7T2yumOMt
	 glw0EPNY/6qow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7199D3A8D14D;
	Wed,  9 Oct 2024 01:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6] net: phy: microchip_t1: SQI support for LAN887x
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172843743505.746583.5316004080368012444.git-patchwork-notify@kernel.org>
Date: Wed, 09 Oct 2024 01:30:35 +0000
References: <20241007063943.3233-1-tarun.alle@microchip.com>
In-Reply-To: <20241007063943.3233-1-tarun.alle@microchip.com>
To: Tarun Alle <tarun.alle@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 7 Oct 2024 12:09:43 +0530 you wrote:
> From: Tarun Alle <Tarun.Alle@microchip.com>
> 
> Add support for measuring Signal Quality Index for LAN887x T1 PHY.
> Signal Quality Index (SQI) is measure of Link Channel Quality from
> 0 to 7, with 7 as the best. By default, a link loss event shall
> indicate an SQI of 0.
> 
> [...]

Here is the summary with links:
  - [net-next,v6] net: phy: microchip_t1: SQI support for LAN887x
    https://git.kernel.org/netdev/net-next/c/36efaca9cb28

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



