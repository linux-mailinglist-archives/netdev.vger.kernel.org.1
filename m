Return-Path: <netdev+bounces-218873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCD9B3EE7E
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72ED1A802B2
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 19:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C96324B38;
	Mon,  1 Sep 2025 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrPCyeYX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE61F324B1D;
	Mon,  1 Sep 2025 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756755601; cv=none; b=JEJrIax5NgPbUDRFBqciMHGdBVLEskX/Hc8Dy3UkL6GcV4AxMHtdhcSjxCxnL4nmQWGLGOFFhvaxlfxnyHxw0Ajn+TE+16WvAL+52bZjyj72ft+cgacTVlyBd7RKoqmN217be4PJ7FJe2dsDVk9yF19YVxWFiHfgISXslYrui7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756755601; c=relaxed/simple;
	bh=isTLmJyKWm1rCPiKonv8yb3fcz+NecWR/zDJ56VbTyo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s+fOg9Lnfxzfkt88wh9oDZVAqVplhxFxyIwEPiJGm5ZqA1KvXuryP7aW16LT+664nZey6MtI0RyBBR0vdFEH4fIYXswk/LMvgUNmdnoU1wJJi0boJOLyhDsqplpRhfYoAzi1m0MR+B48VjNQUGHUGB88YPerl3r2+LpH1Ed4wPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrPCyeYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEABC4CEF0;
	Mon,  1 Sep 2025 19:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756755600;
	bh=isTLmJyKWm1rCPiKonv8yb3fcz+NecWR/zDJ56VbTyo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JrPCyeYXa99DqLSIS8q8bl2NnG9LoJrdGlf0K8PgWeaAEz1ilzavuRinUottntB9S
	 5qlQztrs+EiAyvhJUXr8POpIxxao+R0PW6rLsZQ4bLygqNnvZwPaoxdQIGcI/EcQGD
	 LUoldtVvsjQFlRXOk3gh5Fz0bd0Chqw0uxnwf0oB1xVmR+qQUjpi6jCPzUGOY1PlwP
	 VCt75ExxgxU27xVI6j78X5qR09wRz5pZ4j/IjyC6mKnHGTIK7NOEuKFNWRbBONSogX
	 R+q2/ZKRnsqtlyGpvh3T2Ghao3oa7VThKZj08upzP5DIOPJoMqI45inrWxuK/W0jhj
	 GCzz/Ojfn03CQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D9D383BF4E;
	Mon,  1 Sep 2025 19:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-08-29
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175675560625.3862603.1620076851732090865.git-patchwork-notify@kernel.org>
Date: Mon, 01 Sep 2025 19:40:06 +0000
References: <20250829191210.1982163-1-luiz.dentz@gmail.com>
In-Reply-To: <20250829191210.1982163-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Aug 2025 15:12:10 -0400 you wrote:
> The following changes since commit 5189446ba995556eaa3755a6e875bc06675b88bd:
> 
>   net: ipv4: fix regression in local-broadcast routes (2025-08-28 10:52:30 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-08-29
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-08-29
    https://git.kernel.org/netdev/net/c/0dffd938db37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



