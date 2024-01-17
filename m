Return-Path: <netdev+bounces-63945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD68F83040B
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 12:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E64B1F25154
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 11:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7C81C2AE;
	Wed, 17 Jan 2024 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCS+SiqT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF751CF81
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489225; cv=none; b=eHO2OeUIlcHzTZfOMzzs3/GpD83sudby/QYeJTbslNU0pSuzhyrodCkikOvH3hM7ycqzk6LTOQqXCoi4msn51spNVZAKwEDAKM45ri/16TTnUYM2CHbX7ukkZekGIpoj+9AQ47iYBh01N1uxEF5aHbO2p6ZnQJuIZR/sQ4mGXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489225; c=relaxed/simple;
	bh=DobWmIyEo7qmIygCSkf97oZBjOAAxABpWV3ITWN9EU8=;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jFU20mv7yL5O7xLdKUa/8uECdFpFFU5X/VhADlVsihnu82a1bQd3X/1MFUkFp4zBdqnFHygxV+iG2w0VSUNTqbCKsDg2EODvQQcaw8Gs41NuXL1v0C53A+qer2UUtVeHL5nCJl9UdBp/eLv0q8RHUQzCZXHPFAnRPcDTeT3Z5Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCS+SiqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81558C43390;
	Wed, 17 Jan 2024 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705489224;
	bh=DobWmIyEo7qmIygCSkf97oZBjOAAxABpWV3ITWN9EU8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LCS+SiqTWu9YoazGOh8d3HeXxIxHgGehep0Y4hVv4grkB7zD3QlGIi5QkStUgRnkX
	 rUAn5O8nrZtyDU+lad2Fux9ury8WKHczUnXdjpeZr30YHwvJXajywtvsCiN2sGhmCC
	 3saqo6wrJbQxVtjP6qdGSx3I4V6yODTFFWyH2cesXUmui8xWYW9c1kSPXujHgadEDV
	 OnsmmJOUz/qcTB4vfncUgU2Nxj9oqoP84ntDSzd3+lRSifhcmAiG1TIMQ7oseU7wRX
	 +b9Sby5K15YGqdysTqSdRs+3mDsfFpPFR2Xn0U6WcMufUhKy7ICZKeUh48QOvV9un5
	 NixLd5ipfO+dw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A022D8C96C;
	Wed, 17 Jan 2024 11:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: netdevsim: don't try to destroy PHC on VFs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170548922443.14327.12127551188532457562.git-patchwork-notify@kernel.org>
Date: Wed, 17 Jan 2024 11:00:24 +0000
References: <20240116191400.2098848-1-kuba@kernel.org>
In-Reply-To: <20240116191400.2098848-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, vladimir.oltean@nxp.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 16 Jan 2024 11:14:00 -0800 you wrote:
> PHC gets initialized in nsim_init_netdevsim(), which
> is only called if (nsim_dev_port_is_pf()).
> 
> Create a counterpart of nsim_init_netdevsim() and
> move the mock_phc_destroy() there.
> 
> This fixes a crash trying to destroy netdevsim with
> VFs instantiated, as caught by running the devlink.sh test:
> 
> [...]

Here is the summary with links:
  - [net] net: netdevsim: don't try to destroy PHC on VFs
    https://git.kernel.org/netdev/net/c/ea937f772083

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



