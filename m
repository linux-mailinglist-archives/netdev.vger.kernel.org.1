Return-Path: <netdev+bounces-117362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1B494DADE
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF20D2825AC
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550F913D600;
	Sat, 10 Aug 2024 05:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoYVoJWi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3139B13C9A1
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 05:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723267240; cv=none; b=LR7LF+VCNrYTG+RZ14PYwRNnzhQ0O7hJ3pHzJmWMp3W+e5f3+2evergJQCU9giy2wl76EpGUnNk/EOAGAgxoyUQzEVUijKmM8dRC9Dar9yx3cnV/PFyENsOhT03omKnG412a/ZMIzZZHBQ/vNBu8Mi/917oL0D77x5bTY2/MKuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723267240; c=relaxed/simple;
	bh=puwIa4nVkRVKi2u9ARmaPfkTA7St0Z6ZQ1vCDz3UN84=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HijntSS8pmhxQQnWVY8777pqVTO7S+tnemD1ziDdUXY2Urioq4x8GmnTuQ16wPwazUdc+0Wbt1vu1bHmNWLTSXOw9POHubzJ0c92j8Yv1RImidvMV7BCmTHmiYI8LspSno8vxe+OS8TeWMk6Mg4QaBl2M6lfB8qLgi2kspgOnsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoYVoJWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C506AC32781;
	Sat, 10 Aug 2024 05:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723267239;
	bh=puwIa4nVkRVKi2u9ARmaPfkTA7St0Z6ZQ1vCDz3UN84=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZoYVoJWispnllPNWF1DECUfSmksnq6+wfvBhukKlLxO9I0GJOiUy8yDLWOxCpDSgM
	 kuIC+sa79VG1RbitZ/MLjL60s+SGDMg3FpC+7/YWw7f9VyYNq+0k+JqjEIoYt76efY
	 LjgL7yD5rq2YZoRXiORO+M81NP4Pk2AqjtMhz4wwmj8WYgvHUdUY+bXKkQlDl1vo3T
	 8GZyX50fR82aPwvqLg1p7cyjHcEbD9gXEb7qVtMmkmpXYJfJQtKMND5PW8mwI4JOol
	 c17kkjgAGhHfMEg6Qr88eyRrR0mNScDTGdTTMoC3ziEyZjPUofnnCLJNRW6hBsO4xG
	 NIPLUbWtTfcaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEBB382333F;
	Sat, 10 Aug 2024 05:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 00/11] mlx5 misc patches 2024-08-08
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172326723848.4145426.6103022727049548125.git-patchwork-notify@kernel.org>
Date: Sat, 10 Aug 2024 05:20:38 +0000
References: <20240808055927.2059700-1-tariqt@nvidia.com>
In-Reply-To: <20240808055927.2059700-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 8 Aug 2024 08:59:16 +0300 you wrote:
> Hi,
> 
> This patchset contains multiple enhancements from the team to the mlx5
> core and Eth drivers.
> 
> Patch #1 by Chris bumps a defined value to permit more devices doing TC
> offloads.
> 
> [...]

Here is the summary with links:
  - [net-next,V2,01/11] net/mlx5: E-Switch, Increase max int port number for offload
    https://git.kernel.org/netdev/net-next/c/6e20d538fb1d
  - [net-next,V2,02/11] net/mlx5e: Enable remove flow for hard packet limit
    https://git.kernel.org/netdev/net-next/c/88c46f6103e2
  - [net-next,V2,03/11] net/mlx5e: TC, Offload rewrite and mirror on tunnel over ovs internal port
    https://git.kernel.org/netdev/net-next/c/16bb8c613379
  - [net-next,V2,04/11] net/mlx5e: TC, Offload rewrite and mirror to both internal and external dests
    https://git.kernel.org/netdev/net-next/c/b11bde56246e
  - [net-next,V2,05/11] net/mlx5e: Be consistent with bitmap handling of link modes
    https://git.kernel.org/netdev/net-next/c/4384bcff035e
  - [net-next,V2,06/11] net/mlx5e: Use extack in set ringparams callback
    https://git.kernel.org/netdev/net-next/c/ab666b5287e8
  - [net-next,V2,07/11] net/mlx5e: Use extack in get coalesce callback
    https://git.kernel.org/netdev/net-next/c/29a943d71d23
  - [net-next,V2,08/11] net/mlx5e: Use extack in set coalesce callback
    https://git.kernel.org/netdev/net-next/c/9c4298b466b1
  - [net-next,V2,09/11] net/mlx5e: Use extack in get module eeprom by page callback
    https://git.kernel.org/netdev/net-next/c/b5100b72da68
  - [net-next,V2,10/11] net/mlx5e: CT: 'update' rules instead of 'replace'
    https://git.kernel.org/netdev/net-next/c/486aeb2db55b
  - [net-next,V2,11/11] net/mlx5e: CT: Update connection tracking steering entries
    https://git.kernel.org/netdev/net-next/c/6b5662b75960

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



