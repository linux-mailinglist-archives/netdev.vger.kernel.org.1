Return-Path: <netdev+bounces-141364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E85C59BA95C
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CA9EB20DD2
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2536A18BC37;
	Sun,  3 Nov 2024 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjP++LQx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1552189BA0;
	Sun,  3 Nov 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730674229; cv=none; b=SEc6ubW+DDAvM0DNcOnDDHXktaRrSIXXwew2eSM3ZqqbAAZ2GfiR4glmiRgaVD01/Jcrs9OMK0hLwr8AS9VkowPfL3hPXKCoO2lObgox3u0wO7gUY/HQkH6L1eUUmjnIVZZX20ErfzR8IQK95pLubAuxnENQrtftaq4Q2XsIZmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730674229; c=relaxed/simple;
	bh=azUdsJeLA1jzLVm2gM8E42xvwq0Ytk/yQai/Spgu5ok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hr2qjIFvntln86//0w8ARkzuaGN3So3fp1n3AOPNH19YODKn/66Ioc3zGSleraFREX3V4MNMCaRrFpNu/soeL9V1sLTVik8I0x06XTV4ULhcpAucpiSOYt1fT0DdzBtp9r0n0AcB+mn4NN6ktNYHR0jPG2F3wTcJOctVH0C0U7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjP++LQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAE5C4CED3;
	Sun,  3 Nov 2024 22:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730674228;
	bh=azUdsJeLA1jzLVm2gM8E42xvwq0Ytk/yQai/Spgu5ok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pjP++LQxtji39IW8pm5wWw5ICcN+bQ7p/gvmis48EA1Eflbb3njFx1CiSb8k9C8h2
	 GBHrxmKz2VbvE32UvjliGzmvWHw85YMpmkBWbZz8jXN9h9M/deIwe+f6vSLuMC47p0
	 P+SJSNKPHyXWlT7q4TuS9qDAEia2iWD6fKTqLEi9xhKAI+27aZVXZMyI6n5WKtJA5A
	 Es1k50QXteSQIyHuGg1yuPX2xSrj0Wxslu9ih720kjSNuK/KvL3O/eb0EDV0uC+Ixv
	 Gd59k9evH8avp98bvTotW1O9KwaLx+LmE9TqYi269gyoUjseOP4H1fFezWYiAMALpa
	 vD0T5Yyie+1Hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0E438363C3;
	Sun,  3 Nov 2024 22:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/12] ibm: emac: cleanup modules to use devm 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173067423633.3271988.11469025588601425929.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 22:50:36 +0000
References: <20241030203727.6039-1-rosenp@gmail.com>
In-Reply-To: <20241030203727.6039-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leitao@debian.org,
 u.kleine-koenig@baylibre.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Oct 2024 13:37:15 -0700 you wrote:
> simplifies probe and removes remove functions. These drivers are small.
> 
> Rosen Penev (12):
>   net: ibm: emac: tah: use devm for kzalloc
>   net: ibm: emac: tah: use devm for mutex_init
>   net: ibm: emac: tah: devm_platform_get_resources
>   net: ibm: emac: rgmii: use devm for kzalloc
>   net: ibm: emac: rgmii: use devm for mutex_init
>   net: ibm: emac: rgmii: devm_platform_get_resource
>   net: ibm: emac: zmii: use devm for kzalloc
>   net: ibm: emac: zmii: use devm for mutex_init
>   net: ibm: emac: zmii: devm_platform_get_resource
>   net: ibm: emac: mal: use devm for kzalloc
>   net: ibm: emac: mal: use devm for request_irq
>   net: ibm: emac: mal: move irq maps down
> 
> [...]

Here is the summary with links:
  - [net-next,01/12] net: ibm: emac: tah: use devm for kzalloc
    https://git.kernel.org/netdev/net-next/c/96111f1ec6bf
  - [net-next,02/12] net: ibm: emac: tah: use devm for mutex_init
    https://git.kernel.org/netdev/net-next/c/18082a84a7f0
  - [net-next,03/12] net: ibm: emac: tah: devm_platform_get_resources
    https://git.kernel.org/netdev/net-next/c/9f3ea8d70d6c
  - [net-next,04/12] net: ibm: emac: rgmii: use devm for kzalloc
    https://git.kernel.org/netdev/net-next/c/070239c07ac1
  - [net-next,05/12] net: ibm: emac: rgmii: use devm for mutex_init
    https://git.kernel.org/netdev/net-next/c/01902fe2bdd7
  - [net-next,06/12] net: ibm: emac: rgmii: devm_platform_get_resource
    https://git.kernel.org/netdev/net-next/c/9fb40aeeb521
  - [net-next,07/12] net: ibm: emac: zmii: use devm for kzalloc
    https://git.kernel.org/netdev/net-next/c/e2da0216e55e
  - [net-next,08/12] net: ibm: emac: zmii: use devm for mutex_init
    https://git.kernel.org/netdev/net-next/c/3fb5272de034
  - [net-next,09/12] net: ibm: emac: zmii: devm_platform_get_resource
    https://git.kernel.org/netdev/net-next/c/c2744ab3ce28
  - [net-next,10/12] net: ibm: emac: mal: use devm for kzalloc
    https://git.kernel.org/netdev/net-next/c/3f55d1655549
  - [net-next,11/12] net: ibm: emac: mal: use devm for request_irq
    https://git.kernel.org/netdev/net-next/c/14f59154ff0b
  - [net-next,12/12] net: ibm: emac: mal: move irq maps down
    https://git.kernel.org/netdev/net-next/c/c4f5d0454cab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



