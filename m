Return-Path: <netdev+bounces-95643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2DB8C2EC3
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 04:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A63EB22684
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 02:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2878812B8B;
	Sat, 11 May 2024 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLp92hLq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0375D12B82
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715392829; cv=none; b=qAVZcSpyP275W12ZtiKu7TStfOQug9fq+7t4hOp3pFvqeqYerd6zvRuJ8xo96A5g0HiDkQfhFDdDNFzUSlXpmi0GnZzaT+PvLRtvJZ97Bw0+zcpIeTmZW8CxC6EgE6AnKSPrXyT0Rvu916Q7rbwgk/NEav8cgV9TEK8eSQrB7uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715392829; c=relaxed/simple;
	bh=KGJp/6YUIo25PHSxv44i9pLIBOj9Rr5mX6JJbnaIj4A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RQEChlcoRUEW9Drkryb71nSF0gHeulTcmCTW71KJTW5p85MYBd8u9yMGGKI4G3C4JuOeBeN3XW1OWhVCJrgZkAb+qwYi3qKQAc/FlUPf4FAHaV1gdm+waO6IBQk32Isl63SV+/tw+TwsiYfNLVV7Pmy1oLnFzIEXYmkYFc8NuVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLp92hLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95474C32782;
	Sat, 11 May 2024 02:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715392828;
	bh=KGJp/6YUIo25PHSxv44i9pLIBOj9Rr5mX6JJbnaIj4A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KLp92hLq+S4r40AwoFqesYDBTUnlSJbI2JM/1zd8+OJ6uA2zQBK+WY2TpP6JUQrWd
	 7xH5c7vlAsdRZctWubW49B6EqWLaRMp2a9ViKE1JIsqUnDtQn0Tsg78gJPoEjFiNMv
	 Iq9ZSAe1g9t6ZtrD+5BaxZCrLSXvuXmpoMFhg1RbT10BXPGDY4Uy14zfERzAzvc0ij
	 RtwA3xS1oGOXj9yLDoXxxTa6ruT4Qh/bg6+ngAXb55l1eti7ff5+DamY+/2XQVnOSg
	 WomhgGW8pDCShrRPYhUd8NV0HTVc/bT6uZ6o28iFFRG+XUscgPFoWBr9Sy2VigfN2N
	 Vyy9ffAobLPsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8490AC54BA1;
	Sat, 11 May 2024 02:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ice: Fix package download algorithm
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171539282853.14416.17516373797723277172.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 02:00:28 +0000
References: <20240508171908.2760776-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240508171908.2760776-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, dan.nowlin@intel.com,
 horms@kernel.org, przemyslaw.kitszel@intel.com, paul.greenwalt@intel.com,
 pmenzel@molgen.mpg.de, himasekharx.reddy.pucha@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 May 2024 10:19:07 -0700 you wrote:
> From: Dan Nowlin <dan.nowlin@intel.com>
> 
> Previously, the driver assumed that all signature segments would contain
> one or more buffers to download. In the future, there will be signature
> segments that will contain no buffers to download.
> 
> Correct download flow to allow for signature segments that have zero
> download buffers and skip the download in this case.
> 
> [...]

Here is the summary with links:
  - [net] ice: Fix package download algorithm
    https://git.kernel.org/netdev/net/c/6d51d44ecddb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



