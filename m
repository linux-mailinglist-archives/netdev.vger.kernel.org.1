Return-Path: <netdev+bounces-42105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E997CD1E5
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 03:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4F9281AF3
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 01:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B79D1FD3;
	Wed, 18 Oct 2023 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wmamv1ij"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDFB1FC9
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 01:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFA4FC433CA;
	Wed, 18 Oct 2023 01:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697593226;
	bh=tRHDyxpD6weyFMiCG4ndDFZfPeRyep8kFCcFnW5Zu4c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wmamv1ijWQwT94HxbNILmFRdc4YPhShuCdVf5dokgcr+ewV1IgdN1PmgsDqDL2y1j
	 YPFmKQaaeVGOEN5TLh4D8ouHDXuwpG6aozGf86N5X9wOzcl53C6v9CrtIkyj6fMpFI
	 DkGb0BYiy/B/RaBhG5KJE2fFffpNkeb8el9Xwb35vgpU1Mk6QdF592rcPuJUEfuDxH
	 Ift4K5iKHpuIaHm+NO66ILWUg7LsqsQyqNHeXebuQ0KYIAcU3T4vsi4DUyaB3KHk3I
	 M1hJa83ZNT3B+sOV+6fdI2twMOggUYNS2KmrBRrD6K4LLgCByhxFP/suHFYF3LOA4R
	 c7hshnlL8nWpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB021C04E24;
	Wed, 18 Oct 2023 01:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next V3 01/15] net/mlx5: Parallelize vhca event handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169759322682.7564.2475141741118387188.git-patchwork-notify@kernel.org>
Date: Wed, 18 Oct 2023 01:40:26 +0000
References: <20231014171908.290428-2-saeed@kernel.org>
In-Reply-To: <20231014171908.290428-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, weizhang@nvidia.com, moshe@nvidia.com, shayd@nvidia.com,
 jacob.e.keller@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Sat, 14 Oct 2023 10:18:54 -0700 you wrote:
> From: Wei Zhang <weizhang@nvidia.com>
> 
> At present, mlx5 driver have a general purpose
> event handler which not only handles vhca event
> but also many other events. This incurs a huge
> bottleneck because the event handler is
> implemented by single threaded workqueue and all
> events are forced to be handled in serial manner
> even though application tries to create multiple
> SFs simultaneously.
> 
> [...]

Here is the summary with links:
  - [net-next,V3,01/15] net/mlx5: Parallelize vhca event handling
    https://git.kernel.org/netdev/net-next/c/3f7f31fff251
  - [net-next,V3,02/15] net/mlx5: Redesign SF active work to remove table_lock
    https://git.kernel.org/netdev/net-next/c/15fa898aebe5
  - [net-next,V3,03/15] net/mlx5: Avoid false positive lockdep warning by adding lock_class_key
    https://git.kernel.org/netdev/net-next/c/89d351c2241a
  - [net-next,V3,04/15] net/mlx5: Refactor LAG peer device lookout bus logic to mlx5 devcom
    https://git.kernel.org/netdev/net-next/c/e534552c92a4
  - [net-next,V3,05/15] net/mlx5: Replace global mlx5_intf_lock with HCA devcom component lock
    https://git.kernel.org/netdev/net-next/c/b430c1b4f63b
  - [net-next,V3,06/15] net/mlx5: Remove unused declaration
    https://git.kernel.org/netdev/net-next/c/0d2d6bc7e74f
  - [net-next,V3,07/15] net/mlx5: fix config name in Kconfig parameter documentation
    https://git.kernel.org/netdev/net-next/c/58cd34772a30
  - [net-next,V3,08/15] net/mlx5: Use PTR_ERR_OR_ZERO() to simplify code
    https://git.kernel.org/netdev/net-next/c/68e81110fbcf
  - [net-next,V3,09/15] net/mlx5e: Use PTR_ERR_OR_ZERO() to simplify code
    https://git.kernel.org/netdev/net-next/c/5a37b2882418
  - [net-next,V3,10/15] net/mlx5e: Refactor rx_res_init() and rx_res_free() APIs
    https://git.kernel.org/netdev/net-next/c/d90ea84375b8
  - [net-next,V3,11/15] net/mlx5e: Refactor mlx5e_rss_set_rxfh() and mlx5e_rss_get_rxfh()
    https://git.kernel.org/netdev/net-next/c/cae8e6dea279
  - [net-next,V3,12/15] net/mlx5e: Refactor mlx5e_rss_init() and mlx5e_rss_free() API's
    https://git.kernel.org/netdev/net-next/c/0d806cf9c007
  - [net-next,V3,13/15] net/mlx5e: Preparations for supporting larger number of channels
    https://git.kernel.org/netdev/net-next/c/74a8dadac17e
  - [net-next,V3,14/15] net/mlx5e: Increase max supported channels number to 256
    https://git.kernel.org/netdev/net-next/c/6dd6eaf43e8d
  - [net-next,V3,15/15] net/mlx5e: Allow IPsec soft/hard limits in bytes
    https://git.kernel.org/netdev/net-next/c/627aa13921c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



