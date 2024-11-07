Return-Path: <netdev+bounces-142603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31F89BFC36
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B934B22D5A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C3A78C6D;
	Thu,  7 Nov 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOePNEfH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656396EB4C;
	Thu,  7 Nov 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944828; cv=none; b=QXWTZtVkBbW/V7EE/CRbzyqjrLjdjo4JDRWUzon91BLNc1TBtQ7SUbD/R2lso8TT2Q4kxQtja8oTx+Z58VNkNGRjckz8AZKR4luHM9cjnqlI0DeL2bRdh7x9Safgqpxg4RzVE8gzF1tZnmeD9Ei/OjUQiWR2XvS6d12qJo0AYFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944828; c=relaxed/simple;
	bh=1BUDSPoeb+/qQeqYnnF7CsVsbkJqooWgE1ax/Juomq8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=screGP62hKRQOJW6oIisVHlArITv6PD3id9RjDoZPPkLt6TD7B2ejodUQTnWjnrfYS+nY84706/TldVJpJ6t/cMSgXU63j8T90ge2APuMn5CC5doynXD3FQ0vLd9vVY3mf6eJHsJGU57rqYTuhOtNoC/BbfXFZdx2uQ4N/QnjHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOePNEfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF8FC4CECC;
	Thu,  7 Nov 2024 02:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730944827;
	bh=1BUDSPoeb+/qQeqYnnF7CsVsbkJqooWgE1ax/Juomq8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JOePNEfHKy27IoxmW8tn3U3WcpHvwyoJN2uP8RkH0ekIX1IOBVA6UvqHpDZrlcjFK
	 /Qr12rqZx3c9/HKA2i0nByh1VO88ZwjR2hxTnHjfTq2WSZDgr2EW8yYwyxU7gPe7ST
	 AIdoSzmAhDVoxgGIV6rqdPnpROmU0Nbz+Pja+VGBT0tgpeeomcUdDOUxasJuItWg+Z
	 mphtLiACVPQ4GwGNucKCTuI82MXYqkyCcWQncQwg6Tg+muouHf7sBLZqxdOo7LwN8y
	 qlFSzwmvpwJmx2wmESRG3BFCglSogmnSbnhoilWP+puEdm/UdNCM2TwDX6rC5gOmu0
	 wKwaliaZw2Kfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C3A3809A80;
	Thu,  7 Nov 2024 02:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net: ucc_geth: devm cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173094483699.1489169.1489956594032005327.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 02:00:36 +0000
References: <20241104210127.307420-1-rosenp@gmail.com>
In-Reply-To: <20241104210127.307420-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 maxime.chevallier@bootlin.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 Nov 2024 13:01:23 -0800 you wrote:
> Also added a small fix for NVMEM mac addresses.
> 
> This was tested as working on a Watchguard T10 device.
> 
> Rosen Penev (4):
>   net: ucc_geth: use devm for kmemdup
>   net: ucc_geth: use devm for alloc_etherdev
>   net: ucc_geth: use devm for register_netdev
>   net: ucc_geth: fix usage with NVMEM MAC address
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: ucc_geth: use devm for kmemdup
    https://git.kernel.org/netdev/net-next/c/2246f5b2e982
  - [net-next,2/4] net: ucc_geth: use devm for alloc_etherdev
    https://git.kernel.org/netdev/net-next/c/edf0e374e446
  - [net-next,3/4] net: ucc_geth: use devm for register_netdev
    https://git.kernel.org/netdev/net-next/c/85d05befbbfc
  - [net-next,4/4] net: ucc_geth: fix usage with NVMEM MAC address
    https://git.kernel.org/netdev/net-next/c/257589764032

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



