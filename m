Return-Path: <netdev+bounces-128022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5469777AA
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 06:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D0F4B2358E
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 04:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E30F364BC;
	Fri, 13 Sep 2024 04:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfVW4Uyn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E902F34
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 04:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726200032; cv=none; b=JsTVovJc56jMmE+IMWhrQ75r6HCwMpttfOggzo2HOZiQz2u8gq/+RxHL5DCLV1xbxZcGrBzYl7O1aCpnwgV5MZHEXiR3TALXUeGXztbmb1aPBrn6qiMWSwFCz9ydEaU8EIlVyABm9gMzOx2oSz0dQpTYV5CCf8L7uU2mJWi6H3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726200032; c=relaxed/simple;
	bh=I8Tcqtw7Q3qS9hVZAL/AQU885Tr4qb2BYhohwwc/1Rc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pk3TMcXn9yyfTGnzDvGezR2QAlB3pvhBaJ5QE0RRyUTl1W5gEeMwAglu8m6FPcuJeB9uk6vsDJj1I1jUSSKOiZugj4UyLTs4arNNyIaPc/tnO7ESByUR2XNlAbvnS3ZmNlUbB+vtC5nwaH5DBUi9cu1v5kmjEL8CHrBxI1nFQtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfVW4Uyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2A3C4CEC0;
	Fri, 13 Sep 2024 04:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726200030;
	bh=I8Tcqtw7Q3qS9hVZAL/AQU885Tr4qb2BYhohwwc/1Rc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SfVW4UyngJbXjGLpkd3wk5zSMoSpqwZuI7JVL9c5RfVWJmRM66Os3Ow8GyEvCadmg
	 8FVw86Lb8ZOmQbXVy18Dxk1OitGZBnXT1GzM4hMu80CkYQGJjvBE6x2KC/YYZf8MpV
	 SQQONC212+9i4zKYcq0rEyOlgkvxW3ZwYNlext/OUz+iICTNYS/VeGbMoO0A6O6aT4
	 DCWunVOA2d7WXEA4vdiL8I/JS2IsRzZZNKwoGGSECqHFSeeVVru7iqOXRTUs11+LdQ
	 J3mkEXmr8ccBISoQAW5ihmwIrwGhiLLfCEp9BrnWoHJmMEcP91jEkv7/aSp6aA3qEG
	 J3O6AaFeTKW7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DA23806644;
	Fri, 13 Sep 2024 04:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next 01/15] net/mlx5: HWS,
 updated API functions comments to kernel doc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172620003176.1809438.12430472460959173503.git-patchwork-notify@kernel.org>
Date: Fri, 13 Sep 2024 04:00:31 +0000
References: <20240911201757.1505453-2-saeed@kernel.org>
In-Reply-To: <20240911201757.1505453-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, gal@nvidia.com, leonro@nvidia.com, kliteyn@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Sep 2024 13:17:43 -0700 you wrote:
> From: Yevgeny Kliteynik <kliteyn@nvidia.com>
> 
> Changed all the functions comments to adhere with kernel-doc formatting.
> 
> Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] net/mlx5: HWS, updated API functions comments to kernel doc
    https://git.kernel.org/netdev/net-next/c/e2e9ddf8775b
  - [net-next,02/15] net/mlx5: HWS, fixed error flow return values of some functions
    https://git.kernel.org/netdev/net-next/c/3f4c38df5b0f
  - [net-next,03/15] net/mlx5: fs, move steering common function to fs_cmd.h
    https://git.kernel.org/netdev/net-next/c/48eb74e878e0
  - [net-next,04/15] net/mlx5: fs, make get_root_namespace API function
    https://git.kernel.org/netdev/net-next/c/da2f660b3ba1
  - [net-next,05/15] net/mlx5: fs, move hardware fte deletion function reset
    https://git.kernel.org/netdev/net-next/c/940390d97690
  - [net-next,06/15] net/mlx5: fs, remove unused member
    https://git.kernel.org/netdev/net-next/c/8ad0e9608c2c
  - [net-next,07/15] net/mlx5: fs, separate action and destination into distinct struct
    https://git.kernel.org/netdev/net-next/c/ef7b79b924e5
  - [net-next,08/15] net/mlx5: fs, add support for no append at software level
    https://git.kernel.org/netdev/net-next/c/1217e6989c99
  - [net-next,09/15] net/mlx5: Add device cap for supporting hot reset in sync reset flow
    https://git.kernel.org/netdev/net-next/c/9947204cdad9
  - [net-next,10/15] net/mlx5: Add support for sync reset using hot reset
    https://git.kernel.org/netdev/net-next/c/57502f62678c
  - [net-next,11/15] net/mlx5: Skip HotPlug check on sync reset using hot reset
    https://git.kernel.org/netdev/net-next/c/48bb52b0bc66
  - [net-next,12/15] net/mlx5: Allow users to configure affinity for SFs
    https://git.kernel.org/netdev/net-next/c/9c754d097073
  - [net-next,13/15] net/mlx5: Add NOT_READY command return status
    https://git.kernel.org/netdev/net-next/c/5bd877093fd0
  - [net-next,14/15] net/mlx5e: SHAMPO, Add no-split ethtool counters for header/data split
    https://git.kernel.org/netdev/net-next/c/909fc8d107b7
  - [net-next,15/15] net/mlx5e: Match cleanup order in mlx5e_free_rq in reverse of mlx5e_alloc_rq
    https://git.kernel.org/netdev/net-next/c/cc1812918930

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



