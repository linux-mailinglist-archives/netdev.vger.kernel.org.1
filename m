Return-Path: <netdev+bounces-84689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61243897DDA
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 04:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153D01F240FF
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 02:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAD91CD02;
	Thu,  4 Apr 2024 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZh6jmp5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889201CA9F
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712199043; cv=none; b=lQyDeDBRGZ5q3D5P7YwpUoyFQP8INZv6u74psVSLjCaCo4UGLCkMKMNll8a2Mt/CPRHnFTdKdqXpYsnby+kpCq6DHhaugBafBM9JVtu3e+S9D+pk5LsLM1o/SS1mUY4ToG3m2naS2DET+9H7H22/emMN+KUvEl9DF+M3Of3n3lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712199043; c=relaxed/simple;
	bh=bUD7GRQ3mDYCb8V4JE/SjZ8SVSWwPU7Ql35y4E9pKYw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EKrPNU1W8fZepqw1fn2NCc9ttLq11LM2d+WmYYnrLh6jZu9PqfT4HIJ02sSSlVCgZdU4Ps7Fi2mIAmMGVQcUcPNnMGeybIKUqmVl7ay+arH9vfiSIfLSF0eTNIeofePvPjbawuiN1mSCnWBxYWv+vlPZ0fBgEYePrul51YR7oj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZh6jmp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31B6FC433C7;
	Thu,  4 Apr 2024 02:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712199043;
	bh=bUD7GRQ3mDYCb8V4JE/SjZ8SVSWwPU7Ql35y4E9pKYw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cZh6jmp5FMU6PPNVwqKUAb6/6FmYPyaBVg81oU4ISpghd/ikvupnusjVoTyUmqeHC
	 vSIi+qcqM057lVthFPdHKFbAFIofOz4PrLSxPaCjoQ/5mCma7cBPWH8ZCboI0S3nDF
	 wERbd/OF5f3Dv0bYmGh0DpZ79IL1XNjlxalqzRYLBkDD2M06Jch3TnWf6xmU4vtJeP
	 kGNpU1O7t0tXmKYrYbLIftZNkMW8lkFualXumhyrNQJIjBZfjH55NSMuKCVEM3dAkC
	 wr8EdNNYeAqF5nyOvplvpJpnaVtc1bUj2itFzaBc9nbeLrc2mjExJqaFk4s6eD0jmz
	 Nuidzugo4ONCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23965D9A151;
	Thu,  4 Apr 2024 02:50:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] tools: ynl: ethtool.py: Make tool invokable from
 any CWD
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171219904314.5496.13812029659945386741.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 02:50:43 +0000
References: <20240402204000.115081-1-rrameshbabu@nvidia.com>
In-Reply-To: <20240402204000.115081-1-rrameshbabu@nvidia.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, gal@nvidia.com, tariqt@nvidia.com,
 saeedm@nvidia.com, edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, dtatulea@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Apr 2024 13:39:52 -0700 you wrote:
> ethtool.py depends on yml files in a specific location of the linux kernel
> tree. Using relative lookup for those files means that ethtool.py would
> need to be run under tools/net/ynl/. Lookup needed yml files without
> depending on the current working directory that ethtool.py is invoked from.
> 
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v1] tools: ynl: ethtool.py: Make tool invokable from any CWD
    https://git.kernel.org/netdev/net-next/c/ca3e10c4d83a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



