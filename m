Return-Path: <netdev+bounces-249191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCA7D155E0
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACC9C301A1EB
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5207C3624BD;
	Mon, 12 Jan 2026 21:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRVmcVi9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30410340DA1
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251672; cv=none; b=tbr6ha8GCcnfujtcxgZ4ExIFPve8MTr1ro6PEAY1Dl8DnRmKNF8yUQtdrWjwvCnzhmDmQZHx2qKBEgoihYwBPL1NwWUAt9pDQP8tTwJe4TANOMQsiysmHv1y2FzHXGbsn7RvdyLF4Lt01DChUCm/2bbKU54o/jbsRYTmlLw0YkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251672; c=relaxed/simple;
	bh=ap0CiB86Ug52R1MPqqqwJDhGOQ48WecQ7CUvlpAV99I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y9cyTuikTZ+mpfrGioHFqcTTo6WCfFiNKt9j3tCiBA9n+NnjiZtwZTOrAxMgWXISYt61um0QwOUYDr3Vxp2gNMXCSDELE1kh7FPKhXho2r48JLddSkzPUIglZu+NiVIhYAYoNx3SXIEyAuipH+ubT7gF1AfH5ViOhvosd/UYhvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRVmcVi9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD468C116D0;
	Mon, 12 Jan 2026 21:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768251671;
	bh=ap0CiB86Ug52R1MPqqqwJDhGOQ48WecQ7CUvlpAV99I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IRVmcVi9Cnz+7PbZZwYAbZCWLlN/XC9sXYTFDXLhZ8MOKFsGMg4CuB0B+4is6OPnb
	 C3duRMo5O37ReOBNtmcggGxHq4dxNQd25IptEMCTH2WKDwXe5w0XzckL8ZgJgxRUei
	 zOuuie4c7NJWKH7lpxdH0bvEvLSSrudV/78L77zaj/6s5AHQ5YmFcfiV9QzWIdVSJ5
	 136muumzASuA1F7otitq/I4SxZj0t1Qh46V4F9wrLhGqwnxV0mrcw+/aceeMNGrbrF
	 OGGhjFoYamcqJ+NuQkJhoqCvRofFiVXncn3vJj6x4/xbNrZplZMFHx/+WjL+K6/HMl
	 36P5whZHrSR2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2EC6380CFD5;
	Mon, 12 Jan 2026 20:57:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] selftests: net: py: capitalize defer queue
 and
 improve import
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176825146578.1092878.3845005632760122191.git-patchwork-notify@kernel.org>
Date: Mon, 12 Jan 2026 20:57:45 +0000
References: <20260108225257.2684238-1-kuba@kernel.org>
In-Reply-To: <20260108225257.2684238-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, petrm@nvidia.com,
 leitao@debian.org, jdamato@fastly.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Jan 2026 14:52:56 -0800 you wrote:
> Import utils and refer to the global defer queue that way instead
> of importing the queue. This will make it possible to assign value
> to the global variable. While at it capitalize the name, to comply
> with the Python coding style.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] selftests: net: py: capitalize defer queue and improve import
    https://git.kernel.org/netdev/net-next/c/799a4912eea7
  - [net-next,2/2] selftests: net: py: ensure defer() is only used within a test case
    https://git.kernel.org/netdev/net-next/c/7a1ff3545ade

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



