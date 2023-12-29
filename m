Return-Path: <netdev+bounces-60604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ED9820233
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 23:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3391C21002
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 22:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569D114A99;
	Fri, 29 Dec 2023 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2kf/AwE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFBC14AA0
	for <netdev@vger.kernel.org>; Fri, 29 Dec 2023 22:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D967C433C8;
	Fri, 29 Dec 2023 22:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703889626;
	bh=knQqQ1UetkD26roGSB0QsCwBMR310hU4Jct/yugr98A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G2kf/AwEWhtUp7y2hx/9LqM5DyeIYOplO7Ndvr1rRXjn8le4/M3ylGJUtEg10KpK5
	 Inyop64wNM4EN44MPsIxhB/Qzz/zduaHY7OXR+G66+j3Hn7soCqSlZA6gojsameKzx
	 KsAXgfj8MJJMKcr10YBizgrqlMrw27JmLfsDi0NGsWtlyJB/+evKjTZZst5NrkjjOi
	 ZDlWxFKoFv0iHvzEU34OS1FJtVBjdan34TrFwHArFNCge1D0QbylGePujpJGwEkeI2
	 1lAjh3i/O2OTa8hFa7fbdS1aviVgVJ8uDxH45pGbvCJvcVj1PNkaLKGmvJ8HNfO6Af
	 0C4WTowReMg0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B800E333D8;
	Fri, 29 Dec 2023 22:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next 01/15] net/mlx5e: Use the correct lag ports number when
 creating TISes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170388962643.7259.15079529345343624226.git-patchwork-notify@kernel.org>
Date: Fri, 29 Dec 2023 22:40:26 +0000
References: <20231221005721.186607-2-saeed@kernel.org>
In-Reply-To: <20231221005721.186607-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Wed, 20 Dec 2023 16:57:07 -0800 you wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> The cited commit moved the code of mlx5e_create_tises() and changed the
> loop to create TISes over MLX5_MAX_PORTS constant value, instead of
> getting the correct lag ports supported by the device, which can cause
> FW errors on devices with less than MLX5_MAX_PORTS ports.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] net/mlx5e: Use the correct lag ports number when creating TISes
    https://git.kernel.org/netdev/net-next/c/a7e7b40c4bc1
  - [net-next,02/15] net/mlx5: Fix query of sd_group field
    https://git.kernel.org/netdev/net-next/c/e04984a37398
  - [net-next,03/15] net/mlx5: SD, Introduce SD lib
    https://git.kernel.org/netdev/net-next/c/4a04a31f4932
  - [net-next,04/15] net/mlx5: SD, Implement basic query and instantiation
    https://git.kernel.org/netdev/net-next/c/63b9ce944c0e
  - [net-next,05/15] net/mlx5: SD, Implement devcom communication and primary election
    https://git.kernel.org/netdev/net-next/c/a45af9a96740
  - [net-next,06/15] net/mlx5: SD, Implement steering for primary and secondaries
    https://git.kernel.org/netdev/net-next/c/605fcce33b2d
  - [net-next,07/15] net/mlx5: SD, Add informative prints in kernel log
    https://git.kernel.org/netdev/net-next/c/c82d36032511
  - [net-next,08/15] net/mlx5e: Create single netdev per SD group
    https://git.kernel.org/netdev/net-next/c/e2578b4f983c
  - [net-next,09/15] net/mlx5e: Create EN core HW resources for all secondary devices
    https://git.kernel.org/netdev/net-next/c/c4fb94aa822d
  - [net-next,10/15] net/mlx5e: Let channels be SD-aware
    https://git.kernel.org/netdev/net-next/c/e4f9686bdee7
  - [net-next,11/15] net/mlx5e: Support cross-vhca RSS
    https://git.kernel.org/netdev/net-next/c/c73a3ab8fa6e
  - [net-next,12/15] net/mlx5e: Support per-mdev queue counter
    https://git.kernel.org/netdev/net-next/c/d72baceb9253
  - [net-next,13/15] net/mlx5e: Block TLS device offload on combined SD netdev
    https://git.kernel.org/netdev/net-next/c/83a59ce0057b
  - [net-next,14/15] net/mlx5: Enable SD feature
    https://git.kernel.org/netdev/net-next/c/c88c49ac9c18
  - [net-next,15/15] net/mlx5: Implement management PF Ethernet profile
    https://git.kernel.org/netdev/net-next/c/22c4640698a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



