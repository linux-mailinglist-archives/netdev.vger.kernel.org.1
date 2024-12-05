Return-Path: <netdev+bounces-149231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 410E29E4CD9
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 04:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC351881711
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 03:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2BF2770C;
	Thu,  5 Dec 2024 03:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hs4LsXjL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF55522F
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 03:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733370620; cv=none; b=Ws++3KXrZrcLirHObRl6bveYEhSCsqd1LiUHFUswuZzDKe86JvacAjdXaUXqypsp9mJ9PzIzghpeGCawEl8+mu6t3jGRA6uGF/gMmrTmCPMKKq8ODZHEA91EhX+jEK6/uCQZWF+rNbsFpGXnS9T2JteQT1YYL/M/hzE4Bw3kKoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733370620; c=relaxed/simple;
	bh=o7t/uGH8TiEAxh0yI5h3F3cyumKZ/tnPYuKDuQ8Rl/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JboleXS8k4fNcTccgeeQTQeiWVIOTy/ORunwmKHlKmNQBXK/Ggdii8b6bQpKVRbIb1e29ype3W980PDERzkhuaMJgAQAXh3KejiMbejkf/Pdu952C7MGkhExK2duTuiDefXppfy1UFyZbob0n29VEfKPXvSeEEyic29CMuNubSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hs4LsXjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68806C4CED6;
	Thu,  5 Dec 2024 03:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733370620;
	bh=o7t/uGH8TiEAxh0yI5h3F3cyumKZ/tnPYuKDuQ8Rl/g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hs4LsXjLHsOztYGacMhg6QskVSCp1YdbSGaXtXtYX7rDERMJEQdaib35g1fYhSWhj
	 Chfr4mkRVVESWJsIidSyLETWFat+4XS6Pcb3xEnykLDgUTBqr6omV61VsTasnlJSlM
	 PHrwT9L/HR+qzoMrptihkfocfoSw8kh17IrYxofj960y7tN+49+jXMB0cmCkTmVPyI
	 erroeM/dwpxnHT48V2rvSgJ9Suu9AhNA5Ard3Nmwqv7d0nh4MGsGhp7RNgiiSj+Q7r
	 U1dXn+U4krLE82XNHMMcxbLxvmvF6eYyrDMdkvOe+G5TYT33H54cFC9+VdkGMgRr9r
	 UFLWs2EWKgLNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34171380A94C;
	Thu,  5 Dec 2024 03:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6] mlx5 misc fixes 2024-12-03
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173337063500.1436302.12940640807031847951.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 03:50:35 +0000
References: <20241203204920.232744-1-tariqt@nvidia.com>
In-Reply-To: <20241203204920.232744-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 3 Dec 2024 22:49:14 +0200 you wrote:
> Hi,
> 
> This patchset provides misc bug fixes from the team to the mlx5 core and
> Eth drivers.
> 
> Series generated against:
> commit af8edaeddbc5 ("net: hsr: must allocate more bytes for RedBox support")
> 
> [...]

Here is the summary with links:
  - [net,1/6] net/mlx5: HWS: Fix memory leak in mlx5hws_definer_calc_layout
    https://git.kernel.org/netdev/net/c/530b69a26952
  - [net,2/6] net/mlx5: HWS: Properly set bwc queue locks lock classes
    https://git.kernel.org/netdev/net/c/10e0f0c018d5
  - [net,3/6] net/mlx5: E-Switch, Fix switching to switchdev mode with IB device disabled
    https://git.kernel.org/netdev/net/c/5f9b2bf019b7
  - [net,4/6] net/mlx5: E-Switch, Fix switching to switchdev mode in MPV
    https://git.kernel.org/netdev/net/c/d04c81a3e3ce
  - [net,5/6] net/mlx5e: SD, Use correct mdev to build channel param
    https://git.kernel.org/netdev/net/c/31f114c3d158
  - [net,6/6] net/mlx5e: Remove workaround to avoid syndrome for internal port
    https://git.kernel.org/netdev/net/c/5085f861b414

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



