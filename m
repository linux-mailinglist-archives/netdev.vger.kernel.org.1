Return-Path: <netdev+bounces-209938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6F1B115EB
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 03:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500AF545F9B
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 01:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE98194124;
	Fri, 25 Jul 2025 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9V27TIW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A294B10FD;
	Fri, 25 Jul 2025 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753407612; cv=none; b=Bp6htYQVVq1/4PZxHBziwli6otPlbb0N5H1ewWNFj6HVTJzNZjGvWSBHQGQN/D40SnraPRG4jE6JMNfRI6Kr2ugh9h3JnLpLvV/F9Gop0jYXE1jG2LufT+YILbqORnvocamtXs/rikfNMrbFlFxuXB6u7v9g7OpchDToj/+NNpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753407612; c=relaxed/simple;
	bh=f5HZZIcJyY3r2sAv5U8oKwJfCVI8PDB6W3bJrZlCNI0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jB4nbkVEcFzWpjTEXQVEqhDIsz1dvNDPnXA+tXjdjpJxu7JaD1Y4uh2KXHPbBuc2guRM/zP15ivfXsvek7DpJMsqRGwDRJGe+gEBXGxR1a8ETy+liFsuO4z8ip1atZuyQ8ulv+/7fZ2njaP+kOShnzXSfhRLZofu+JEUDgyaJVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9V27TIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F0AC4CEED;
	Fri, 25 Jul 2025 01:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753407612;
	bh=f5HZZIcJyY3r2sAv5U8oKwJfCVI8PDB6W3bJrZlCNI0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u9V27TIW1Z9wi96FWGQ7U51ijYLS/zke5R3tDo14yf/thcGJxhyRq2H/YOvU2G0um
	 bcM7ELIQInNBXjOIQNAI5fUylQXE9knn3Kls6QHvk085zF6UykuGJo0LMKkQjM3l5M
	 Z16ZqVKbLVn1JktoRynrhnp7d6OqlolOZaEshwf+dkF1HT3Yu+uHEGWKVAC967+wFG
	 CPyFuiibzK6i9MxZFg4bybMCzXt38P16Ts2+Nsfktndm9YfEmBNkn6wxAGZ2D9ddXX
	 86pXM8oFx0lW4qa8O696iMOKKwAKJ4QZMWh6NplfRlCKTE4FV8eOfEuFMCtE8bdGmi
	 I+XiXw7ZFFEVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B8F383BF4E;
	Fri, 25 Jul 2025 01:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth-next 2025-07-23
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175340763001.2600170.388804154259482388.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 01:40:30 +0000
References: <20250723190233.166823-1-luiz.dentz@gmail.com>
In-Reply-To: <20250723190233.166823-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Jul 2025 15:02:32 -0400 you wrote:
> The following changes since commit 56613001dfc9b2e35e2d6ba857cbc2eb0bac4272:
> 
>   Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux (2025-07-22 18:37:23 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2025-07-23
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth-next 2025-07-23
    https://git.kernel.org/netdev/net-next/c/d2002ccb47dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



