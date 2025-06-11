Return-Path: <netdev+bounces-196718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1795AD60C1
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 23:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2023E1E1256
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 21:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD882BE7BE;
	Wed, 11 Jun 2025 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txbxgyjn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B056288C1D
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676211; cv=none; b=L9QILN9KEyB7pmK6urjnA/EZIqagnklrAHyqt/7qwkkMHsHx8l6PEDl1VjcvMaIwlmCj5EHjl2xZMqqDdM8t6erQmJ2onyLgPY6jt4YdAJfMPGysEHCqSiYR2nGm2RI9qdt9qJeJ5Ii5g7IYTjRJbqGru19sjyYUsxsDqrDNTwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676211; c=relaxed/simple;
	bh=tQVepzhCtbTeLX9mqtZl2HvxMf4x+7n/PPF0Ln6jVK0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nwIXem1ub+J1sc/9gJytZn4scyA75IarLXygpDgt9TjU1kClqDhDzoqUHc1gBdnKdBnDwVIlxr7SMm0WeMzwDGnl4bPiLzVC5DtRjciZGBVa9INdlDaB8HnnUQxCWPfmP1eEE8SBTRfTY4BBoKCMpMQkDPaDmhTIlsKjkGEP9jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txbxgyjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97451C4CEEF;
	Wed, 11 Jun 2025 21:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749676209;
	bh=tQVepzhCtbTeLX9mqtZl2HvxMf4x+7n/PPF0Ln6jVK0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=txbxgyjnawTGwwil9c6/dqewL4XDdKKrUB/Z/DuQ+SpwlWYtcCUEC995qQD5TWzVq
	 aLbtkvuUro2Z08+DgniIjSpvLVOhqG9O9Xq/3ex9Snpp/SrkLuB+YFL5DffaBo1bPR
	 X03QfQjV4f3sjODhj47o7eApmNiPlsRYe3pXuChgWXE2X1/7kAMte/tC4UUk2bBbHC
	 Li8ZPTNi3lJRx0i4dbVbeJkqCwv4Y2CxyHcy43t5II0Q/vwt/3dowKbEqzNQm+URP1
	 fGLiIvLbByNmbx43ekDYd5Zauc/uGWqF9pQ5c72lMqwjsXJJ8LEPKhihqOG3dIur6N
	 7ezmGvRG4cMdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE38380DBE9;
	Wed, 11 Jun 2025 21:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net/mlx5: Expose serial numbers in devlink
 info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174967623949.3484955.17549462353872588347.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 21:10:39 +0000
References: <20250610025128.109232-1-jiri@resnulli.us>
In-Reply-To: <20250610025128.109232-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, parav@nvidia.com,
 kalesh-anakkur.purayil@broadcom.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Jun 2025 04:51:28 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Devlink info allows to expose serial number and board serial number
> Get the values from PCI VPD and expose it.
> 
> $ devlink dev info
> pci/0000:08:00.0:
>   driver mlx5_core
>   serial_number e4397f872caeed218000846daa7d2f49
>   board.serial_number MT2314XZ00YA
>   versions:
>       fixed:
>         fw.psid MT_0000000894
>       running:
>         fw.version 28.41.1000
>         fw 28.41.1000
>       stored:
>         fw.version 28.41.1000
>         fw 28.41.1000
> auxiliary/mlx5_core.eth.0:
>   driver mlx5_core.eth
> pci/0000:08:00.1:
>   driver mlx5_core
>   serial_number e4397f872caeed218000846daa7d2f49
>   board.serial_number MT2314XZ00YA
>   versions:
>       fixed:
>         fw.psid MT_0000000894
>       running:
>         fw.version 28.41.1000
>         fw 28.41.1000
>       stored:
>         fw.version 28.41.1000
>         fw 28.41.1000
> auxiliary/mlx5_core.eth.1:
>   driver mlx5_core.eth
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net/mlx5: Expose serial numbers in devlink info
    https://git.kernel.org/netdev/net-next/c/18667214b955

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



