Return-Path: <netdev+bounces-177341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCBFA6FAA9
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466743BB98B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DFD2566FA;
	Tue, 25 Mar 2025 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdAlBKm7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123672566E8
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903996; cv=none; b=rHB99HxY+qZBo1/kNac+JAVgb0Qb7VM1vJmo2+7CLPxtUSRqbgqj5Ml2Cws06Fxm3NjzCr7F0gb1B0aEYJMhPVvVMTjG7dkLbhPcA/yAQuX1tufvFAZIJTCVyf9MkO8bsOaQ+1F8L6jw7d6GBi7UErnz2UqWaflq+R2B1eNm/fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903996; c=relaxed/simple;
	bh=RpX9XVOhX2mLGluYAa6LPhtEoLETO08/r/Q5PYeWPq0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AYEQDXCcvf1kgsAOI9VHqcn7BumRIjVj5zA57mvK9ZKQlu28A7sAp5VRBCeWWuOhf9zU9mk43mhnj4hE7CWgi8xl8YWjU8HioW7/nL2Yyw+KJOnI1rBEL/PRkTrJoYQ5hnbMIgCxyTQYpmo6WxTGtlaV1f5REbvOqntFTSP2zNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdAlBKm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8DAC4CEE4;
	Tue, 25 Mar 2025 11:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742903995;
	bh=RpX9XVOhX2mLGluYAa6LPhtEoLETO08/r/Q5PYeWPq0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RdAlBKm7k6FSFo8lqmwt9z1x3so3uR1WhJ+83zFBKee4Tn0I40XThpU2BeYEIkTxC
	 qZk44uR1ShykVNX5Yf2USLVeTmDsgfuDulh6VN2yPMKxqvmMmG0iE7fkulNyiedwcq
	 nrfF1SE7ShzEPQr+JnCXQUgcJvmBCPnvJaHqxXJEl8IftqoDphcEamEdEuxLEyFwIl
	 +x/75jMpoaLW6jB85gv35gcRB49BNy+e2+cplGOSABmG2YBr4lopTtgGuNxHLYLtFW
	 TPKBnqRlqc+7F/fTNJWJdOkwJVb3YD8aQ+/QGWZUodqWfaKQOMlN9TGXAhElQENERC
	 uf8V0QAfsYtlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB891380CFE7;
	Tue, 25 Mar 2025 12:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] net/mlx5: Expose additional devlink dev info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174290403176.534907.13973863538007744367.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 12:00:31 +0000
References: <20250320085947.103419-1-jiri@resnulli.us>
In-Reply-To: <20250320085947.103419-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, parav@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Mar 2025 09:59:43 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> This patchset aims to expose couple of already defined serial numbers
> for mlx5 driver.
> 
> On top of that, it introduces new field, "function.uid" and exposes
> that for mlx5 driver.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] ynl: devlink: add missing board-serial-number
    https://git.kernel.org/netdev/net-next/c/3e25c1a7c056
  - [net-next,v2,2/4] net/mlx5: Expose serial numbers in devlink info
    (no matching commit)
  - [net-next,v2,3/4] devlink: add function unique identifier to devlink dev info
    (no matching commit)
  - [net-next,v2,4/4] net/mlx5: Expose function UID in devlink info
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



