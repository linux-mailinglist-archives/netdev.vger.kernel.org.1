Return-Path: <netdev+bounces-234213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F86EC1DE9B
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B721881DF2
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5827BFC1D;
	Thu, 30 Oct 2025 00:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8kd55vj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3305E4C9D
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 00:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761784240; cv=none; b=FYcgRgzdfKSWIWeXO7pMqeVeVsl7tB8CNg8iS4aoLsOHdno9Qki/gxM4nN3pvZN4nRTtqd+f5JLqo8RA9CytdDsABpyOTvjl91jHrPrDDQf3lb5MlDFzJ3zWKts/rDpKQcBuLpcdnl2lyeqE19DdbNeEdX5C6HV9NbDKxrUNHWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761784240; c=relaxed/simple;
	bh=tQIruejwpKTnBaTSE8KgQ617sg7pjgA/bUfxzMS/3Mc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pLwdTqxkzDiQrqd6PsJq3q/NBaNtvJCRjHoE2NNC7a8JoSblifYD0RpOnjqX6KG8DMdJ/FhYdIdwvvMp7ZBDpYAs8hlNgQZu/TrnsPXPmN51NKCq+3euuW2Gko14gTPZ+t2RTbAHI0Bc3buaLg9QG40WcBHQIVX+2n4SYT3f7tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8kd55vj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B48C4CEF7;
	Thu, 30 Oct 2025 00:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761784239;
	bh=tQIruejwpKTnBaTSE8KgQ617sg7pjgA/bUfxzMS/3Mc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K8kd55vjC1NG01Kdeh4jGuJmG/xyIbES63tC9TUeBMt2tYQTLzYa6MU4RACwGJ5mH
	 7p6TaqzbMBhEG7JjyKuKkrYnU2kdwhKedaSUD644XDpbHMwMDX2yMndmJIiQr4BQBO
	 JgwtKIRdypeKmf3V//RP/Jr+HxdVtDiyGfuxyg9dtoXLDhklqjAlkJegHPzPFeeZmc
	 izDHIMn/QUtwD36ei0NengCxMAsJcO+T40YnfHTQ+JLIWVsBpxH9h43N9Vo16Wt7So
	 AKQO6crKRES5HRK+wvofPWa2+bzZ30Q36TU9EU5WJpC6++NAGOkwd6cYPNuvzcwNcX
	 WWlf6AFEBWosw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1953A55EC7;
	Thu, 30 Oct 2025 00:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/8] net: stmmac: hwif.c cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176178421675.3262354.14278133392680967130.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 00:30:16 +0000
References: <aQFZVSGJuv8-_DIo@shell.armlinux.org.uk>
In-Reply-To: <aQFZVSGJuv8-_DIo@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, richardcochran@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Oct 2025 00:01:25 +0000 you wrote:
> Hi,
> 
> This series cleans up hwif.c:
> 
> - move the reading of the version information out of stmmac_hwif_init()
>   into its own function, stmmac_get_version(), storing the result in a
>   new struct.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/8] net: stmmac: move version handling into own function
    https://git.kernel.org/netdev/net-next/c/fc18b6e98cce
  - [net-next,v3,2/8] net: stmmac: simplify stmmac_get_version()
    https://git.kernel.org/netdev/net-next/c/f49838f77cf6
  - [net-next,v3,3/8] net: stmmac: consolidate version reading and validation
    https://git.kernel.org/netdev/net-next/c/c36b97e4ca77
  - [net-next,v3,4/8] net: stmmac: move stmmac_get_*id() into stmmac_get_version()
    https://git.kernel.org/netdev/net-next/c/7b2e41fff76f
  - [net-next,v3,5/8] net: stmmac: use FIELD_GET() for version register
    https://git.kernel.org/netdev/net-next/c/b2fe9e29b5f6
  - [net-next,v3,6/8] net: stmmac: provide function to lookup hwif
    https://git.kernel.org/netdev/net-next/c/7b510ea8e58e
  - [net-next,v3,7/8] net: stmmac: use != rather than ^ for comparing dev_id
    https://git.kernel.org/netdev/net-next/c/f9326b139b4c
  - [net-next,v3,8/8] net: stmmac: reorganise stmmac_hwif_init()
    https://git.kernel.org/netdev/net-next/c/6436f408eb21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



