Return-Path: <netdev+bounces-243692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF23ACA5FEA
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 04:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3AD6300E763
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 03:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371BA2727E3;
	Fri,  5 Dec 2025 03:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMVysHs1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7A726CE2C
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 03:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764904997; cv=none; b=RS1bo9qHClBfHOc4msuKy9ZjEC+tCSMDErjHHviafbjWFLAB/3D6rzVNpAtWqhckkoZfg1ROmcWoJ8lNI2t9en7JNQBBYQko8x983AnijlnYnEKz6UTSQcp37+/XkYRewHuxDP2nnnm5zFTD6mELqOtOsqmrlqnAfQDTfrz3avU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764904997; c=relaxed/simple;
	bh=zDf+Jis4mfUaSsgB9MR+gX9omLkOdCM7LuR38a/LiLU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QYfN5AaQCZDhAU+uoWYe6cJrORx0gIURUTJ7YjRo2WsYWZKVMB7LIUaDMgw5N8lyc1qGQqM2+1jnJcq/FSO2SFhVto1mLQ41qca5CWjPZCNDwvdLBa1x4GevaGtHDh0VUwT/d3Ympbq2rVjlpw1tb69AicLe01qkyG2rv5y2rGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMVysHs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F117C4CEFB;
	Fri,  5 Dec 2025 03:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764904996;
	bh=zDf+Jis4mfUaSsgB9MR+gX9omLkOdCM7LuR38a/LiLU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LMVysHs1XVqK0wIwvGeQOpR64fsCKiiHGXAVjZfnK205+xf4x7PUEbI76EWU2IIzM
	 FlY8PbpKaIfryF3pfonaD2dUaASyGSLbQkAPrvA5kuw3KxadN5rAah421/5eJNw0tN
	 WDlR4jxufi5WVZlB46hmc56zM8ajUWtFsgZ6XL04wWGzNP5/t8rei4SHxGfInI1joJ
	 eHJgEc3N3Ew1PT2B4RTEpU6Uj414JrnOLgrFhKk+8vzUWokcbuOldFnRV2dyfzkNQD
	 VLrFn5jxZI0Thypmi/CM6HtHI4mfyI1A53SYCX8kGFoKrBo4NJuWIW/79fbpqXjvGn
	 V4plubGEWF6yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5C293AA9A89;
	Fri,  5 Dec 2025 03:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mlxsw: Three (m)router fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176490481454.1084773.14919281827246452239.git-patchwork-notify@kernel.org>
Date: Fri, 05 Dec 2025 03:20:14 +0000
References: <cover.1764695650.git.petrm@nvidia.com>
In-Reply-To: <cover.1764695650.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 idosch@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 2 Dec 2025 18:44:10 +0100 you wrote:
> This patchset contains two fixes in mlxsw Spectrum router code, and one for
> the Spectrum multicast router code. Please see the individual patches for
> more details.
> 
> Ido Schimmel (3):
>   mlxsw: spectrum_router: Fix possible neighbour reference count leak
>   mlxsw: spectrum_router: Fix neighbour use-after-free
>   mlxsw: spectrum_mr: Fix use-after-free when updating multicast route
>     stats
> 
> [...]

Here is the summary with links:
  - [net,1/3] mlxsw: spectrum_router: Fix possible neighbour reference count leak
    https://git.kernel.org/netdev/net/c/b6b638bda240
  - [net,2/3] mlxsw: spectrum_router: Fix neighbour use-after-free
    https://git.kernel.org/netdev/net/c/8b0e69763ef9
  - [net,3/3] mlxsw: spectrum_mr: Fix use-after-free when updating multicast route stats
    https://git.kernel.org/netdev/net/c/8ac1dacec458

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



