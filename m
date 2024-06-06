Return-Path: <netdev+bounces-101250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB91F8FDD77
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 05:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670D71F24183
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 03:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1AD19D89B;
	Thu,  6 Jun 2024 03:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1PAnXfJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7631319D889
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 03:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717644637; cv=none; b=Qg7pChtUEg2Y3mGWF8+GMLBi47mmsKlgfgqgYASzdHKE44IPj/nRTC7kjt1AdPcpRn+c8BzK7vmuL8proHaQPI13lQcreibwVmNjmgyb6Ck2nTLxUvZWH/35o4WlJ0Pzw+fdmygjqb52FHLsTfv4EPSmf0SEmsutYhBlSwW9g+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717644637; c=relaxed/simple;
	bh=6V2RqtJZti5cDRokTQIqSU6LdcbUfi9LOQoz0ZL29vo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DFSaUzE3dBL1Ix0Q+RSQbU43YNiv2flaklo2yH5m8PIfM+8BRPLVJ6aEJXn/qXIrggniatubA7X3iAPr+cwKdH9IhzanwoD2P3O6BL+om3Z9q5o/PlcxJvpE47XH0AaI8G3QZh4qp4bkFeatq5bfYu25yL/2v+tphnT3yzKlNPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1PAnXfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3DADC4AF08;
	Thu,  6 Jun 2024 03:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717644637;
	bh=6V2RqtJZti5cDRokTQIqSU6LdcbUfi9LOQoz0ZL29vo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H1PAnXfJBNamlZo8abkbPeHY+5LO5rq0RajCDy4XZa9HwIGY2VIzGEE5bcQtAHhuF
	 koD8JbWIFS4t8xdXwWdh6d/uy0RirF74/4niSwIfrP5wzpAV5qn8Q2gmRaCBWndPWy
	 svR+uJU0aUKaavVVxN0Ye2UWi+rnK4ieC6fmNThSbFHjMF1M4avVOTVI7Oz6NA1YNq
	 yu4ubg55jA1PApsXLHDDluXD5NSugtkrM03u0OFb0yXzU8uY1ZydFEiAQdE1dnRyDx
	 Gh846bLSbpIaU2O4HZFJ/o8J7Qe5tqvG6ww336hPyDHAuIKDnt6GSeqa+Yq8uZhQvL
	 PtPL1nu1mZjiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2ECDD3E997;
	Thu,  6 Jun 2024 03:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 00/14] net/mlx5e: SHAMPO, Enable HW GRO once more
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171764463685.22288.17396409353476710830.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 03:30:36 +0000
References: <20240603212219.1037656-1-tariqt@nvidia.com>
In-Reply-To: <20240603212219.1037656-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 4 Jun 2024 00:22:05 +0300 you wrote:
> This series enables hardware GRO for ConnectX-7 and newer NICs.
> SHAMPO stands for Split Header And Merge Payload Offload.
> 
> The first part of the series contains important fixes and improvements.
> 
> The second part reworks the HW GRO counters.
> 
> [...]

Here is the summary with links:
  - [net-next,V2,01/14] net/mlx5e: SHAMPO, Use net_prefetch API
    https://git.kernel.org/netdev/net-next/c/4e92d247418c
  - [net-next,V2,02/14] net/mlx5e: SHAMPO, Fix incorrect page release
    https://git.kernel.org/netdev/net-next/c/70bd03b89f20
  - [net-next,V2,03/14] net/mlx5e: SHAMPO, Fix invalid WQ linked list unlink
    https://git.kernel.org/netdev/net-next/c/fba8334721e2
  - [net-next,V2,04/14] net/mlx5e: SHAMPO, Fix FCS config when HW GRO on
    https://git.kernel.org/netdev/net-next/c/a64bbd8c286f
  - [net-next,V2,05/14] net/mlx5e: SHAMPO, Disable gso_size for non GRO packets
    https://git.kernel.org/netdev/net-next/c/083dbb54c480
  - [net-next,V2,06/14] net/mlx5e: SHAMPO, Simplify header page release in teardown
    https://git.kernel.org/netdev/net-next/c/e839ac9a89cb
  - [net-next,V2,07/14] net/mlx5e: SHAMPO, Specialize mlx5e_fill_skb_data()
    https://git.kernel.org/netdev/net-next/c/d34d7d1973c4
  - [net-next,V2,08/14] net/mlx5e: SHAMPO, Skipping on duplicate flush of the same SHAMPO SKB
    https://git.kernel.org/netdev/net-next/c/f5a699e00f04
  - [net-next,V2,09/14] net/mlx5e: SHAMPO, Make GRO counters more precise
    https://git.kernel.org/netdev/net-next/c/8f9eb8bb5c5a
  - [net-next,V2,10/14] net/mlx5e: SHAMPO, Drop rx_gro_match_packets counter
    https://git.kernel.org/netdev/net-next/c/16f448d47a86
  - [net-next,V2,11/14] net/mlx5e: SHAMPO, Add header-only ethtool counters for header data split
    https://git.kernel.org/netdev/net-next/c/e95c5b9e8912
  - [net-next,V2,12/14] net/mlx5e: SHAMPO, Use KSMs instead of KLMs
    https://git.kernel.org/netdev/net-next/c/758191c9ea7b
  - [net-next,V2,13/14] net/mlx5e: SHAMPO, Re-enable HW-GRO
    https://git.kernel.org/netdev/net-next/c/99be56171fa9
  - [net-next,V2,14/14] net/mlx5e: SHAMPO, Coalesce skb fragments to page size
    https://git.kernel.org/netdev/net-next/c/14ae2fd12be8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



