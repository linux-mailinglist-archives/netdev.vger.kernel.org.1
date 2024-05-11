Return-Path: <netdev+bounces-95664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726628C2F23
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 04:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1021C21084
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 02:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C647F208A0;
	Sat, 11 May 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoYO0Ugh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F711843
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715395831; cv=none; b=G9RFhnkTMRd7CPamLYL+p2j3lY0zJTt+sbjd7HpDM8At2lEi+BDM+Pb2UlFi3QCVExRZoTzNDkFSct6S7wtp3Jk7PkQTcZz+c2f4jz5FH94VUUTqD/uvCUwcrm9QIF58639Noeuq1rir+jKJgu+uHFkjbnBvf2k40YTMW0QDDyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715395831; c=relaxed/simple;
	bh=62yoUXR20R0IDQEN+hAZRlz3nEnjjd5ZtnUwVKtE29s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yd3j6gZVZMpAUOlelBTR0Jssb7tBVif2MJ24CGdt5Ul2Ps2Buk2KZ9SQyWk8gZ6fHuZp5GsJOlxcZ68dirt6y9UwAbm6prP5YYRaYINYJOvA58qdB5BJBWw00eevmkeCYcb3o0/Y874S0Coxdfp62ulbvSS9ogQRi6aNrm/00P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoYO0Ugh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B392BC32781;
	Sat, 11 May 2024 02:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715395830;
	bh=62yoUXR20R0IDQEN+hAZRlz3nEnjjd5ZtnUwVKtE29s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SoYO0Ugh1hJarVBRSFT6vQrnZLnqq0wzpl8tFSSpG01Rth8UqCGfTXTJ1XLFJx7RM
	 I+IWzWdrGb0JsQ96OCYjYc+L1i7++aDLACp0OLDGDIpwU3O2r5vv6W3c7xxsFESx7N
	 bY3TZIMaupzw8E/tqYw2a5Z6FBYI1Lr7AOIBxP7QD3mFvcQXM2uP1mbQByq81f2ajQ
	 8r4QpcwrDF6qn/aFCjMOrcEiFWf/eaThDfgFUSTkI5MmzRQmAje+nl/de2SbTlQUBv
	 aKmz/wnhjrUi5FMfDu0ewV6W/u0Mk9O5UMnEURsjiZn0TsLCQphU98I0ZNCG8LNobY
	 m2s9aVrVTxImg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9EB9EC32759;
	Sat, 11 May 2024 02:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] mlx5 misc fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171539583064.8208.2562281778785794679.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 02:50:30 +0000
References: <20240509112951.590184-1-tariqt@nvidia.com>
In-Reply-To: <20240509112951.590184-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 9 May 2024 14:29:46 +0300 you wrote:
> Hi,
> 
> This patchset provides bug fixes to mlx5 driver.
> 
> Patch 1 by Shay fixes the error flow in mlx5e_suspend().
> Patch 2 by Shay aligns the peer devlink set logic with the register devlink flow.
> Patch 3 by Maher solves a deadlock in lag enable/disable.
> Patches 4 and 5 by Akiva address issues in command interface corner cases.
> 
> [...]

Here is the summary with links:
  - [net,1/5] net/mlx5e: Fix netif state handling
    https://git.kernel.org/netdev/net/c/3d5918477f94
  - [net,2/5] net/mlx5: Fix peer devlink set for SF representor devlink port
    https://git.kernel.org/netdev/net/c/3c453e8cc672
  - [net,3/5] net/mlx5: Reload only IB representors upon lag disable/enable
    https://git.kernel.org/netdev/net/c/0f06228d4a2d
  - [net,4/5] net/mlx5: Add a timeout to acquire the command queue semaphore
    https://git.kernel.org/netdev/net/c/485d65e13571
  - [net,5/5] net/mlx5: Discard command completions in internal error
    https://git.kernel.org/netdev/net/c/db9b31aa9bc5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



