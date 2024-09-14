Return-Path: <netdev+bounces-128298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AD1978D71
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 07:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC881C22177
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 05:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594ED17BA7;
	Sat, 14 Sep 2024 05:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAGW3RRL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D94437;
	Sat, 14 Sep 2024 05:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726290032; cv=none; b=fhX7xcIu2cyVYJYfYbnNKWW6L+92sTVFV4IYJqCx7DRaikh7Z+2lcVKyjvRKdklzB9ZSnH2biiILFzaYIaPumgbz7qOcZS8KD81sHGyDXPuDK4SlVpqGdWgXqH1Y5yyus9/hged0alRdDhkn1gcSFW/rh8hPY7nWGFzroMSJWVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726290032; c=relaxed/simple;
	bh=TU6+0ZV2vIa+B6CuwSGtaZg1fH3e9avaFbiyTxXIxCg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sB9TUmBjWuwaIi8quuD3xQXbAToq2WFm0k1xfuoahJR4qaB9J8i6sS08J7lH2qHWY9yv/XJT0W57K0MgIJzQEioedDkXlOhNsmJqln8U1uOHydZe/GarTLqks2dGDemYmdXSHzNHt5uLmqhPV+9vy+BMS6zjTp3y6bv27c6KNqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAGW3RRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EA1C4CEC0;
	Sat, 14 Sep 2024 05:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726290031;
	bh=TU6+0ZV2vIa+B6CuwSGtaZg1fH3e9avaFbiyTxXIxCg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uAGW3RRL7XOg/9EunDa6Jylph3B+XdvGGoAv8DNTziA6HwjKKSdd3ENZCu4F3vp1z
	 DgD3ovh8M9XnojXwUTbW652RwtVoWy18lckP6RWAFV3PrpGZMhQeZJE4QDylWRVr20
	 dT2GCqzsB2Nv+YZJto8f4byuEcUeszTY/lk0hsAv51+58lS+9G3xa1PmGOqe7O/bES
	 stdIbzy7Aa3PQvASippMkxfWm1Ja5Q5YF0cTcwiLJhHoq2dKpNQjAOPb4e28b7wUKn
	 sWuGYQDCBg8t4c/dJ4CPVQcq0Hv5jGkDj7safHddz7/D3MM7E9bKWR20Fzm+D1IF7I
	 IKrh10uLOEnYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D1C3806655;
	Sat, 14 Sep 2024 05:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv5 net-next 0/9] net: ibm: emac: modernize a bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172629003301.2464053.6462513032875139594.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 05:00:33 +0000
References: <20240912024903.6201-1-rosenp@gmail.com>
In-Reply-To: <20240912024903.6201-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, jacob.e.keller@intel.com, horms@kernel.org,
 sd@queasysnail.net, chunkeey@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Sep 2024 19:48:54 -0700 you wrote:
> v2: removed the waiting code in favor of EPROBE_DEFER.
> v3: reverse xmas order fix, unnecessary assignment fix, wrong usage of
> EPROBE_DEFER fix.
> v4: fixed line length warnings and unused goto.
> v5: Add back accidentally left out commit
> 
> Rosen Penev (9):
>   net: ibm: emac: use devm for alloc_etherdev
>   net: ibm: emac: manage emac_irq with devm
>   net: ibm: emac: use devm for of_iomap
>   net: ibm: emac: remove mii_bus with devm
>   net: ibm: emac: use devm for register_netdev
>   net: ibm: emac: use netdev's phydev directly
>   net: ibm: emac: replace of_get_property
>   net: ibm: emac: remove all waiting code
>   net: ibm: emac: get rid of wol_irq
> 
> [...]

Here is the summary with links:
  - [PATCHv5,net-next,1/9] net: ibm: emac: use devm for alloc_etherdev
    https://git.kernel.org/netdev/net-next/c/b9758c434284
  - [PATCHv5,net-next,2/9] net: ibm: emac: manage emac_irq with devm
    https://git.kernel.org/netdev/net-next/c/dcc34ef7c834
  - [PATCHv5,net-next,3/9] net: ibm: emac: use devm for of_iomap
    https://git.kernel.org/netdev/net-next/c/969b002d7b65
  - [PATCHv5,net-next,4/9] net: ibm: emac: remove mii_bus with devm
    https://git.kernel.org/netdev/net-next/c/93a6d4e03629
  - [PATCHv5,net-next,5/9] net: ibm: emac: use devm for register_netdev
    https://git.kernel.org/netdev/net-next/c/a4dd8535a527
  - [PATCHv5,net-next,6/9] net: ibm: emac: use netdev's phydev directly
    https://git.kernel.org/netdev/net-next/c/baab9de385a8
  - [PATCHv5,net-next,7/9] net: ibm: emac: replace of_get_property
    https://git.kernel.org/netdev/net-next/c/cc0c92ff662d
  - [PATCHv5,net-next,8/9] net: ibm: emac: remove all waiting code
    https://git.kernel.org/netdev/net-next/c/c092d0be38f4
  - [PATCHv5,net-next,9/9] net: ibm: emac: get rid of wol_irq
    https://git.kernel.org/netdev/net-next/c/39b9b78065cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



