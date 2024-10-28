Return-Path: <netdev+bounces-139634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C38F39B3AED
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F56D1F220D6
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 20:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B9C1DFE26;
	Mon, 28 Oct 2024 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THVdsqp6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1B41DFE03;
	Mon, 28 Oct 2024 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145637; cv=none; b=jY1jbOviR0bXEJHrtfWLfJ0AJhlPIivd1RIGyKBU7gEQwj3N6nZhO3wzzjByS9GuRLzmlN8Vka4MwVFtxlHejHJ4wwazV5OE78xsq4u0q3XpVEtDHldQTY6mAeTEJnaMPC7IKqtcF84QCXe3XyrMJmvCr4ybWlpLuIsjneCOwEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145637; c=relaxed/simple;
	bh=6qbXJFuxc6+C9ZVJT+j0122+xJJc6hI6TjaK719XrlM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BpAbICBFeNNySHb8M/FIJ7C7wXx8FLzCm0OUa/a/LEigV2Co7Y/xxgdlb3gNAVoPkmNXzHOlD3fFEbdcLqoQK+RonbQ5jOYdPVSnWRGnro5i/uUwoXabiF0dPohHuu8Yh0earhJzrtVFLP33b7sHkrz9/a3WggVonYuGZP/Tk2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THVdsqp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BCDC4CEE4;
	Mon, 28 Oct 2024 20:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730145636;
	bh=6qbXJFuxc6+C9ZVJT+j0122+xJJc6hI6TjaK719XrlM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=THVdsqp6GXSg7i4pil7kUeA9XVLRvm1UlWqHSy86VCGLtWPiXr2SeV7+USizh+1sx
	 JkoZ3J15GB3adVNEGcngHcu8HF8fJTSAIqfiDulxRenAgCLmH4oIH0hDZIzoOTRcCy
	 9myacgJnzPH/WM9WvFJ3VqTA4qb4Z+Ev0pG8qPZcOM2buoKkZcBAbodI6E8eGPV88v
	 /YI6e1NZeQ/d9jv6Sj7lacPSa9l88KvE8HOTO3eYa79UBePawDsvxP3xjhn59qZ7/g
	 bjoUiNp7U1zP1C7IltaRVTkn1WE24mxmBuZDhJCLe2RQVWPGmbmMOMYW1PyktVyaJy
	 CLKBupFwFxbxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A99380AC1C;
	Mon, 28 Oct 2024 20:00:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH rcu] configs/debug: make sure PROVE_RCU_LIST=y takes effect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173014564377.163218.1759428465962994314.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 20:00:43 +0000
References: <20241016011144.3058445-1-kuba@kernel.org>
In-Reply-To: <20241016011144.3058445-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: paulmck@kernel.org, netdev@vger.kernel.org, frederic@kernel.org,
 neeraj.upadhyay@kernel.org, joel@joelfernandes.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, kees@kernel.org, matttbe@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Oct 2024 18:11:44 -0700 you wrote:
> Commit 0aaa8977acbf ("configs: introduce debug.config for CI-like setup")
> added CONFIG_PROVE_RCU_LIST=y to the common CI config,
> but RCU_EXPERT is not set, and it's a dependency for
> CONFIG_PROVE_RCU_LIST=y. Make sure CIs take advantage
> of CONFIG_PROVE_RCU_LIST=y, recent fixes in networking
> indicate that it does catch bugs.
> 
> [...]

Here is the summary with links:
  - [rcu] configs/debug: make sure PROVE_RCU_LIST=y takes effect
    https://git.kernel.org/netdev/net-next/c/a3e4bf7f9675

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



