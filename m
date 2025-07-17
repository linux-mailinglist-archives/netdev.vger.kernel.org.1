Return-Path: <netdev+bounces-207914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF13DB0900A
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB3F5875D0
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2A82F85D8;
	Thu, 17 Jul 2025 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIEGViI6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1CD1DE2A7;
	Thu, 17 Jul 2025 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764405; cv=none; b=ozVc3OfmeLeX9s5pPTylOy1tesE5bjgCM4cugkdihuBnTxWsMslqZ3nZ6l0zSbbDpiNJxY+18ZkBvSg9wF6BlhJ1N5t9XQJ6XZwl/Yy9iDakzskNp6MgYq3bMZ8gZ9SIYijZaJibwVG4MRYbvvylkRFbtLIG00w/1ggfRjpoX8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764405; c=relaxed/simple;
	bh=A72Ar2iFSdO41Z9dEPccuxr9jaIKh2dcvIDWI5CCQ14=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JVHXYqCHvK/ZvNUVSiTSox0xWW5t77o+I3ZDkp6XK24F1F4x19xMpb4cGnl5c9QNLEgXR/8DmOvYoqFz6UJq1Eewrs2l5hmn34hOGkvXGAtj47X55xvi/MZYPgBaM/rNKE3HhI1aZl2zm680VkfkoQD1QLJU/CAa2arCAlRYKno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIEGViI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BD3C4CEED;
	Thu, 17 Jul 2025 15:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752764404;
	bh=A72Ar2iFSdO41Z9dEPccuxr9jaIKh2dcvIDWI5CCQ14=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qIEGViI63Lp4Ikmci9EwRgNgTnxBqNDYZMc/ZrWhF5K0YimKHMWvsSvxlBAmi6b3V
	 6Gc4LTbNDebl0jcWPMVJ6hCX6Nne3eNoyfM5Q9z9MEBsPk/0AeqVy4oJaWa1i+kpiN
	 UPxhfY0g5pPX6z10w0aigibU72gmGbkzvMyayheGOl1GUzOkNP6MTQIzcFhSaoZTc2
	 459A4a8mPrYZ53tvcXyTE3hcKAqPpqt1wNgqUA2xCl8LKn8M7FfdNUIPpdyjQIwtr5
	 1iWB/C/t1tiZmE9/PvnpmO3D2079u/PRYUu6SzcX4P111soXijgNmwDBwPS6OL4U8W
	 21BE8/D2NMB0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E24383BF47;
	Thu, 17 Jul 2025 15:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/5] rxrpc: Miscellaneous fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175276442426.1962379.12517391969214295109.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 15:00:24 +0000
References: <20250717074350.3767366-1-dhowells@redhat.com>
In-Reply-To: <20250717074350.3767366-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Jul 2025 08:43:40 +0100 you wrote:
> Here are some fixes for rxrpc:
> 
>  (1) Fix the calling of IP routing code with IRQs disabled.
> 
>  (2) Fix a recvmsg/recvmsg race when the first completes a call.
> 
>  (3) Fix a race between notification, recvmsg and sendmsg releasing a call.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/5] rxrpc: Fix irq-disabled in local_bh_enable()
    https://git.kernel.org/netdev/net/c/e4d2878369d5
  - [net,v2,2/5] rxrpc: Fix recv-recv race of completed call
    https://git.kernel.org/netdev/net/c/962fb1f651c2
  - [net,v2,3/5] rxrpc: Fix notification vs call-release vs recvmsg
    https://git.kernel.org/netdev/net/c/2fd895842d49
  - [net,v2,4/5] rxrpc: Fix transmission of an abort in response to an abort
    https://git.kernel.org/netdev/net/c/e9c0b96ec0a3
  - [net,v2,5/5] rxrpc: Fix to use conn aborts for conn-wide failures
    https://git.kernel.org/netdev/net/c/f0295678ad30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



