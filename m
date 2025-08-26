Return-Path: <netdev+bounces-216732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7E2B35023
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A193517708F
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0659420468E;
	Tue, 26 Aug 2025 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d07/xWFn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1962202C46;
	Tue, 26 Aug 2025 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167601; cv=none; b=PnHHGwHAlfTDcJWHakJ2AmJ0+cZrqGGtkAR0NrkqCLdJRs+1KP1tjit9pjksyOswrpybNyXxvNtGID/x0CJPaK/fiNEfTgqBTAWWWPcTJkUTYQ8pWBcYHx7tjlUQwgo4rG8ur18Ga2BG4NKGTTzmybl0A6x3gGmNu2K+j8eVeSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167601; c=relaxed/simple;
	bh=nFdoYMsetpkExOywGteVf61pntlJzVPFbCbV+aonY+s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UV/iP10sVbAKhplkSvc19oE+0ajlZMsUkQAB/hc6k2pwJYfExAkOZfy3MHKB8+z/wYWhnfOXnff6fIUQwEQHhqLfz8RWhZLihq+Ce24DxIu91JniDKep//hVZCG4n91/jXbg6tOqgJbaOWduf9AjSf1n7yRPYMpwjLW2WNXiIrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d07/xWFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED93C4CEF4;
	Tue, 26 Aug 2025 00:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756167601;
	bh=nFdoYMsetpkExOywGteVf61pntlJzVPFbCbV+aonY+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d07/xWFn3ctZBfg0wwxOM970KLYVvN6GvhJC94yC5+ky/qGHGs9oAp7wS7SaQ0eKi
	 iz/ehGXuJSYOz1qG4NEB0LajdVe14784BoFFOFyst8z1y6ZFdCTyXdGeE0C8j+H5MB
	 z61MoR2kahO4vBmxj+s1OJe++gCkgzRf70QZHMjRxH8IuM9tryFGCJpLKoA4Uvub1W
	 lO4pUHlWULPOHUm2tfEKcvBJ7t9PheghxCQOQFb3beP2nS7xXqLGlPt4Ss+u2hrxuF
	 AmZjvGdLsMAVGrrGNxueY9pBwSYkGGhDHCW4HJT3o20Wr8y0QIVqPuWhaJbQ8VE3O2
	 E2Z+fXwB3ZDiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB4383BF70;
	Tue, 26 Aug 2025 00:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net Patch] Octeontx2-af: Fix NIX X2P calibration failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175616760924.3604027.10938088742034137991.git-patchwork-notify@kernel.org>
Date: Tue, 26 Aug 2025 00:20:09 +0000
References: <20250822105805.2236528-1-hkelam@marvell.com>
In-Reply-To: <20250822105805.2236528-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 Aug 2025 16:28:05 +0530 you wrote:
> Before configuring the NIX block, the AF driver initiates the
> "NIX block X2P bus calibration" and verifies that NIX interfaces
> such as CGX and LBK are active and functioning correctly.
> 
> On few silicon variants(CNF10KA and CNF10KB), X2P calibration failures
> have been observed on some CGX blocks that are not mapped to the NIX block.
> 
> [...]

Here is the summary with links:
  - [net] Octeontx2-af: Fix NIX X2P calibration failures
    https://git.kernel.org/netdev/net/c/d280233fc866

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



