Return-Path: <netdev+bounces-126141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3008D96FEFC
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 03:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE511F235D8
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1A1E571;
	Sat,  7 Sep 2024 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1VLqy9a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35848DDC5;
	Sat,  7 Sep 2024 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725672633; cv=none; b=Xc1ct5Qw9YleUSsy6K8pBQWixlSgEE4KbUJRcYAJ1Z9CWrvV4XRcXZQ5kJIudplrutIgLVBiqUrGax+XSPe37/SdWfpVrJTd1xA44OhOb4M09wgkaIPgD/ubjAhns2nFmq9BBnbuajiBXhg/HFFeZLmYzaIzq4hXg6MzpbN9j3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725672633; c=relaxed/simple;
	bh=5Jm73vgTEfnwIFsP+es+dH0SeFuU1K0dlq+7nGBgiVY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uNFggMn4i0pCuMofS+PmCrjlb9dRCFpOKbW5eyK18Tk3RME2g4Qg8P7gR23YKapSWvpj88XfF5vFRxwQY0cDGw9FpmnYYLencM324Z0weZlyklWn32q/oNidxeqzDumKA6i6CqMFqrnmwNmuToDmOd7PGdjrBGDhWj8DJrXPPHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1VLqy9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9948C4CEC4;
	Sat,  7 Sep 2024 01:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725672632;
	bh=5Jm73vgTEfnwIFsP+es+dH0SeFuU1K0dlq+7nGBgiVY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y1VLqy9aLyeyU3Rmn+kypiWegdDoEhzdbrWdxKTIYUGiIO7n1ikxsKcWnE/olm3Gq
	 UasssgR0qYSwuCQjA9gsjmtmTQw5Nr5AZoVaJGPEj12Tg7jFMywYNJhE1PsrtkahLy
	 7p3WDFZygHMh5G0TJNQoX6KFs0Njme4BCCRJG6lDozPJTvlYBf0LCNQBlJW6Z+KAEk
	 gOazp1zXH8r1AQO3fFtN6JN9dhSc+DBOfsc+88y9R8lgqz++ph4jpFaM16d7bayu9R
	 2p41ltfpIfHgPyWF0bam/p6M4qkGR/npNE8nFSeadpq5y/QmnoQiHeciyjM1rxJXd9
	 GhRkQcjMjSXRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADDE3805D82;
	Sat,  7 Sep 2024 01:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] Use functionality of irq_get_trigger_type()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172567263374.2576623.4916481959837531063.git-patchwork-notify@kernel.org>
Date: Sat, 07 Sep 2024 01:30:33 +0000
References: <20240904151018.71967-1-vassilisamir@gmail.com>
In-Reply-To: <20240904151018.71967-1-vassilisamir@gmail.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, nico@fluxnic.net,
 leitao@debian.org, u.kleine-koenig@pengutronix.de, thorsten.blum@toblux.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Sep 2024 17:10:15 +0200 you wrote:
> Changes in v2:
> 	- Split the patches into subsystems.
> 
> v1: https://lore.kernel.org/netdev/20240902225534.130383-1-vassilisamir@gmail.com/
> 
> Vasileios Amoiridis (3):
>   net: dsa: realtek: rtl8365mb: Make use of irq_get_trigger_type()
>   net: dsa: realtek: rtl8366rb: Make use of irq_get_trigger_type()
>   net: smc91x: Make use of irq_get_trigger_type()
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: dsa: realtek: rtl8365mb: Make use of irq_get_trigger_type()
    https://git.kernel.org/netdev/net-next/c/517c29247557
  - [net-next,v2,2/3] net: dsa: realtek: rtl8366rb: Make use of irq_get_trigger_type()
    https://git.kernel.org/netdev/net-next/c/36a5faec5658
  - [net-next,v2,3/3] net: smc91x: Make use of irq_get_trigger_type()
    https://git.kernel.org/netdev/net-next/c/f4bbf496f5fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



