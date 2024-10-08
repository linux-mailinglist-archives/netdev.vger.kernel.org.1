Return-Path: <netdev+bounces-133122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8676599500E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54A3FB23B02
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6021DF726;
	Tue,  8 Oct 2024 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m81DBkuN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5919D1DF26B
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394229; cv=none; b=ZOlVNAfSCoUS6W9S1Hxt41E3yzooRHVtxIUegRSXk+uqRwNWntd4lvyMbmPX2tRRwlplmc8yAJCpos2wrWhgRVmTWb+daeoG2Ne2J6gaIwcxl5T9d4qOwlxpih1Pfu022TDkqHX+2kzAEPi4x+ExhcX8xHd7d+DtcRQ6hCPGvDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394229; c=relaxed/simple;
	bh=786uSdWkNmoYywABZQ4OHwULaDWHSASwqM2gVZuAUGo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O52LXFC4Z0yCVuGGbfKUzk92v4GClR13VQlTcsi97nzK+EL6MbS/7aTNuCGDMPI8c2lxdiZWOCsBSCe9+Y6aW6nMw2LquAM6PRZXFtsFwhjusMG/jt+cSFa0ZHuSPbefqPtS+gaGGBV34S53Mpski2jj7OOPYvS4s76MeCHiQ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m81DBkuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4E0C4CEC7;
	Tue,  8 Oct 2024 13:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728394229;
	bh=786uSdWkNmoYywABZQ4OHwULaDWHSASwqM2gVZuAUGo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m81DBkuNndRVOFgRGEVvX0pcGJAtIbh3gQWe0xz8rhAp59dZVKa7yG0p8PZhCE4Z7
	 6fVgh/HlXm9oypeaEko/sXME34jP+vd1V+I7Jx/L0UtBnN+yB1AzWXrbCTxB54g2sd
	 d4ubOKi7wYkCOsuRYb+1M2FOIfmZX6u5KiOCiLH8YbJWAgP4mMLZbzOw9Y5u5dKqM5
	 S8eGTJ0FBkOzZjdPAmPxP7e1/N6ic9r5Uz4XPr++hMAysca22tjNV/0NTGbdPhyoAP
	 A35+nroLAU+1Vwa4mK4gmGPB3Z2yvxK2f8oDvtzaOocMA2ctK7j5iyk9m1WYrnPu4b
	 j6zyMvsYLcmLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71C5B3810938;
	Tue,  8 Oct 2024 13:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/4] rtnetlink: Per-netns RTNL.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172839423326.544106.8422984141500816476.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 13:30:33 +0000
References: <20241004221031.77743-1-kuniyu@amazon.com>
In-Reply-To: <20241004221031.77743-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 4 Oct 2024 15:10:27 -0700 you wrote:
> rtnl_lock() is a "Big Kernel Lock" in the networking slow path and
> serialised all rtnetlink requests until 4.13.
> 
> Since RTNL_FLAG_DOIT_UNLOCKED and RTNL_FLAG_DUMP_UNLOCKED have been
> introduced in 4.14 and 6.9, respectively, rtnetlink message handlers
> are ready to be converted to RTNL-less/free.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/4] Revert "rtnetlink: add guard for RTNL"
    https://git.kernel.org/netdev/net-next/c/ec763c234d7f
  - [v3,net-next,2/4] rtnetlink: Add per-netns RTNL.
    https://git.kernel.org/netdev/net-next/c/76aed95319da
  - [v3,net-next,3/4] rtnetlink: Add assertion helpers for per-netns RTNL.
    https://git.kernel.org/netdev/net-next/c/844e5e7e656d
  - [v3,net-next,4/4] rtnetlink: Add ASSERT_RTNL_NET() placeholder for netdev notifier.
    https://git.kernel.org/netdev/net-next/c/03fa53485659

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



