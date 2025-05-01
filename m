Return-Path: <netdev+bounces-187269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DE0AA6008
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 16:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D3B3B8969
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 14:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EC31F869F;
	Thu,  1 May 2025 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEdDpZPW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33FB1F76C2
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746109801; cv=none; b=MTbvC8ekrrMf3eIztEPi9Z3MobBN15wIVGFb6ThD2i7rb6XbRfDQz5MYQx/lMOOvMzpOcxc/KD66qKoRnmEuBqVX/UaOrVXDEerxjXxzgYfkfkshaDWonXSJqCK3pi065OQaFeMI6XBz8PVqIeuaVxAfhI3cnsUqFYj4UAA+Gfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746109801; c=relaxed/simple;
	bh=uztGknmGOzWCPOlAWz5AUi9BH4R3pmG1zLs7k6JUo2I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UH2y6l0BoFJpNjW8VzZRGtKrLEfWHI6RO16IgKAulqCliyPyzSK58/qkDqab4wVQxSSjXU+qFmX4JR6Uj9GaqTX9pTmDuiB1dL2sIK+DZXZ6g8qfOv5Y/fNbaMfdXo1OQp2q/ZRw9fc+A5vznpPmchFAMzdKmms2ADDoTUA5f6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEdDpZPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36572C4CEE3;
	Thu,  1 May 2025 14:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746109801;
	bh=uztGknmGOzWCPOlAWz5AUi9BH4R3pmG1zLs7k6JUo2I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BEdDpZPWtaa2ubF17Y7E9SbBRfrMxDAC7vLsa9l4PK2BjUA/QjyoMj+CrUhtLyaLn
	 Dj1qiuUVW0yCPjOdq5htc73/ahGCVFWcdLKgB865b2N5MmUJa3nBu7/9EQczANdZ3U
	 ERFcmZE/MQVHuSYVG5rgfwZMDLWUf0QFh9ggamVdk8DRhA0MJtdY3V0T4fNDk1Vghe
	 zrWMXD2zCLUP/pW4NVUDVx6PurjQ5lX6n2j2obp02MOcO/vDPIHpkoGYk0VFj5bvqc
	 lgB1JnBLNkvyVXRmwYVZZ72whALrmMIW95o+2H3Z1UKDffgF/Z/5bbkUTLTLXE9r3n
	 MQJ1L2rBhgZiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DA83822D59;
	Thu,  1 May 2025 14:30:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2025-04-29 (idpf, igc)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174610983999.2996110.4451199725814266425.git-patchwork-notify@kernel.org>
Date: Thu, 01 May 2025 14:30:39 +0000
References: <20250429221034.3909139-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250429221034.3909139-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 29 Apr 2025 15:10:30 -0700 you wrote:
> For idpf:
> Michal fixes error path handling to remove memory leak.
> 
> Larysa prevents reset from being called during shutdown.
> 
> For igc:
> Jake adjusts locking order to resolve sleeping in atomic context.
> 
> [...]

Here is the summary with links:
  - [net,1/3] idpf: fix potential memory leak on kcalloc() failure
    https://git.kernel.org/netdev/net/c/8a558cbda51b
  - [net,2/3] idpf: protect shutdown from reset
    https://git.kernel.org/netdev/net/c/ed375b182140
  - [net,3/3] igc: fix lock order in igc_ptp_reset
    https://git.kernel.org/netdev/net/c/c7d6cb96d5c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



