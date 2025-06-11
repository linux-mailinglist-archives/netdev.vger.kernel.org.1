Return-Path: <netdev+bounces-196730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B847AD61A3
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 23:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B2C17388A
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 21:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803242472A3;
	Wed, 11 Jun 2025 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCuAT7k5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B66D247298
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678004; cv=none; b=ChfhX3/unLVo6IY+Ht+9a/7zLu3kFHcH8idEQ++ZEoJCZk1FpKkqaBSk/Q4ioF4fyklnQt0gcZwNYQIeA65hE4IfC+4dCjGfYSoq2rnJsnHKwwwyNu2DC9fFnSrAnufryDevuIrGSeJgM2MF+6w6V2ja7f0VlAmjU20TZuXOpDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678004; c=relaxed/simple;
	bh=l7Q2pzYVlTn24zSDQ+fF5ZKOzmCXSRDA9SFSQ8CeWY4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A6G3j+T5myLsv5q1sLjrLlQLE7RtNmDIzwIHbKufUai6vs3MqXlYUYzTaxmPrc86PscTNOVYpAnSuPdJ2eyRaxtPmd1obeRcxfmf2c8cwy0y/KDNFb7WensomJgwRc2d0oX3sQUeVSvM9unUdKLYHfJNb1Tsw7SOlmRefGQS2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCuAT7k5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA22C4CEF1;
	Wed, 11 Jun 2025 21:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749678004;
	bh=l7Q2pzYVlTn24zSDQ+fF5ZKOzmCXSRDA9SFSQ8CeWY4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZCuAT7k5HJngVqKR/c7hi86VRF+YwNK8Vjabd9tiIc8APv+DROAs9ttDnUMqvASqx
	 nahwP1ND/3f2a15v1WlE99VY0oSHdpRFzbCPcNAqLt80IhQPL+iH5oUtm9DePfxnXk
	 a7b2pbmYd7rF0ybir7Rau/wR3H78bxNpFDLOgr8lx5yXRLmEAYhLjfE7AbMVyIae1W
	 yFxBvAYRkUA1g2DtkilhPgrHlvPf1K+7mGpURNGTEbXNI7htsJpJ8j3PQB1HWkHQ+6
	 gnDQn++i935VbQhUDK0OrcoTT3+L+bvX8NwG95SQ71CBxBq1Bm1lPnJipVXXhJctiw
	 mr07wNhguND9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E7E380DBE9;
	Wed, 11 Jun 2025 21:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates
 2025-06-10 (i40e, iavf, ice, e1000)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174967803425.3496159.10923726360736126981.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 21:40:34 +0000
References: <20250610171348.1476574-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250610171348.1476574-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 10 Jun 2025 10:13:40 -0700 you wrote:
> For i40e:
> Robert Malz improves reset handling for situations where multiple reset
> requests could cause some to be missed.
> 
> For iavf:
> Ahmed adds detection, and handling, of reset that could occur early in
> the initialization process to stop long wait/hangs.
> 
> [...]

Here is the summary with links:
  - [net,1/5] i40e: return false from i40e_reset_vf if reset is in progress
    https://git.kernel.org/netdev/net/c/a2c90d63b712
  - [net,2/5] i40e: retry VFLR handling if there is ongoing VF reset
    https://git.kernel.org/netdev/net/c/fb4e9239e029
  - [net,3/5] iavf: fix reset_task for early reset event
    https://git.kernel.org/netdev/net/c/0c6f4631436e
  - [net,4/5] ice/ptp: fix crosstimestamp reporting
    https://git.kernel.org/netdev/net/c/a5a441ae283d
  - [net,5/5] e1000: Move cancel_work_sync to avoid deadlock
    https://git.kernel.org/netdev/net/c/b4a8085ceefb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



