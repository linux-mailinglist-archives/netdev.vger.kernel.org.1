Return-Path: <netdev+bounces-103760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B8B909590
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 04:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CBA1C211BA
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 02:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2586FD0;
	Sat, 15 Jun 2024 02:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjxXPYvb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9C05256
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417434; cv=none; b=e0M2s4HXjXXl2qV1m1E4Dp1CzBwcIXvzeYr/xcP1hulTL1ynq9v+B2n+nHnsSL3Cm+GEkrwCXypBRmgjyHq/npWel/OZHmdrxG2vdJhSZTlghvEVRrrpm4cvrevK0AlKu+Kg8+TjPaD6Q2hOsfpyYwLoPjVuCVdvdb5XXT95IxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417434; c=relaxed/simple;
	bh=IvbnHvcH6jDLbIQVWFyhCHVas2OHYK98GSflnp7q618=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XVGToM4vnWFP+PJnIshODcQXAVo8vYIzlst2636GY3b2hwq3E3vUceRyRFhxxmyncVYeOR9V834lznyigGvGWtEqwm8I2dX8idVuT/lhGn4NXnlBVdFAlp2iDtPcj9Z4tqOCFUnyqyEswcDUMvQESgCTOg+K2bb2EOFSHp63Ndo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjxXPYvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 723A7C4AF1C;
	Sat, 15 Jun 2024 02:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718417434;
	bh=IvbnHvcH6jDLbIQVWFyhCHVas2OHYK98GSflnp7q618=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NjxXPYvbp+O0WvAFmgwx3nTMGIKw7e3TZVytzcMpZkL3ggtmW1E3IPQP7gj+J0RPT
	 wsTz1F5zYl8KlIfQFWQ+5znyUfeliG4UUGQp9x/Vt1y46lUYKHuK8wRZfX1H41+3WS
	 Wl6/sG07w7WtBgUC9GidR0RidlRJHZ6OhDuOJLpny/l7Jt0N3F2mOeOyvYG+4PhUZP
	 8eh8TqDxnQsiwXS1x+v4FTNJsIEuxihQVrw7OZwhDXJBcnTCdtVjvg9pafqOB3/6Uv
	 rs9bMjmYDw4puZuFYFhM7yzMLOI7Gy2ztwaO+MNFfqlLDHuadcLtayXTbEdLW+Zjxr
	 MJJQNxFlECusg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B6C6C4332D;
	Sat, 15 Jun 2024 02:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] mlx5 misc patches 2023-06-13
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171841743437.11975.8247844885675204066.git-patchwork-notify@kernel.org>
Date: Sat, 15 Jun 2024 02:10:34 +0000
References: <20240613210036.1125203-1-tariqt@nvidia.com>
In-Reply-To: <20240613210036.1125203-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Jun 2024 00:00:30 +0300 you wrote:
> Hi,
> 
> This patchset contains small code cleanups and enhancements from the
> team to the mlx5 core and Eth drivers.
> 
> Series generated against:
> commit 3ec8d7572a69 ("CDC-NCM: add support for Apple's private interface")
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] net/mlx5: Correct TASR typo into TSAR
    https://git.kernel.org/netdev/net-next/c/e575d3a6dd22
  - [net-next,2/6] net/mlx5: CT: Separate CT and CT-NAT tuple entries
    https://git.kernel.org/netdev/net-next/c/49d37d05f216
  - [net-next,3/6] net/mlx5: Replace strcpy with strscpy
    https://git.kernel.org/netdev/net-next/c/f070d422bab9
  - [net-next,4/6] net/mlx5e: Fix outdated comment in features check
    https://git.kernel.org/netdev/net-next/c/a9dbb4ac58c0
  - [net-next,5/6] net/mlx5e: Use tcp_v[46]_check checksum helpers
    https://git.kernel.org/netdev/net-next/c/fac15a72b8e5
  - [net-next,6/6] net/mlx5e: Support SWP-mode offload L4 csum calculation
    https://git.kernel.org/netdev/net-next/c/296eaab82506

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



