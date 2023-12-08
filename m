Return-Path: <netdev+bounces-55278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E79580A173
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 11:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FA761F212E3
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729EC13FFB;
	Fri,  8 Dec 2023 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XX1rcNpx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578436FD1
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 10:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DADA6C433C9;
	Fri,  8 Dec 2023 10:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702032623;
	bh=LEtB9at6X+SClQxgbXPuelGVlTPDowCMmdLHvwtxK+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XX1rcNpxNeORNo0UsY/rt4dXHIeDAolDpXIHtM8v4YHILUr210ZTqlNXhdcvs6UQb
	 b0XmamUIC8Y/GRxt8OR6yU+MahN9IhcCaCHtDrqHCfE3JamL7lL0M/V4fvXw4P622l
	 1CDzJhJHCRQofsTcq2eG59D4kIWeqb4a0djuiaFvueES3l55pe6QClQQMM5SEYES2I
	 UEnLhE2WjE7nybhheCm9lmmAuf4D/hpOcj59Ebw7eIT8KoYvoI06eAe18zy/nz2iVs
	 O7xa7C5onZLYkgiRdjArRTNJv7jWo3Rxyoij2FuUyjN6kfArdxHJz+68CIVsTwsBEK
	 5lX0zDlyymsZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C46A8C04E32;
	Fri,  8 Dec 2023 10:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] neighbour: Don't let neigh_forced_gc() disable preemption
 for long
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170203262380.21119.9612861289100953455.git-patchwork-notify@kernel.org>
Date: Fri, 08 Dec 2023 10:50:23 +0000
References: <20231206033913.1290566-1-judyhsiao@chromium.org>
In-Reply-To: <20231206033913.1290566-1-judyhsiao@chromium.org>
To: Judy Hsiao <judyhsiao@chromium.org>
Cc: edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
 dianders@chromium.org, haleyb.dev@gmail.com, davem@davemloft.net,
 kuba@kernel.org, joel.granados@gmail.com, ja@ssi.bg, leon@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  6 Dec 2023 03:38:33 +0000 you wrote:
> We are seeing cases where neigh_cleanup_and_release() is called by
> neigh_forced_gc() many times in a row with preemption turned off.
> When running on a low powered CPU at a low CPU frequency, this has
> been measured to keep preemption off for ~10 ms. That's not great on a
> system with HZ=1000 which expects tasks to be able to schedule in
> with ~1ms latency.
> 
> [...]

Here is the summary with links:
  - [v2] neighbour: Don't let neigh_forced_gc() disable preemption for long
    https://git.kernel.org/netdev/net/c/e5dc5afff62f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



