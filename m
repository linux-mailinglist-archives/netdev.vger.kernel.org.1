Return-Path: <netdev+bounces-244108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C790CAFD59
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 12:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8A823088B95
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 11:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26492FD7C8;
	Tue,  9 Dec 2025 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JipSi4NW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E242FD69F;
	Tue,  9 Dec 2025 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765281200; cv=none; b=bmrexLPBBsH8RD9SGr2XJpj5d+SD3CXOolvKrlOjPK3WFDfaHzyQ9MX2RSzHEDR6I2ST3hsy0OCi230baJz8EG8kSWwe0hsYHi5nRtNO5JkGKxsXDjVjZYGVq7ilL66/SOHurGddSM9+IZiJoMC4gPt0SKD9OyktjxIUYTPODEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765281200; c=relaxed/simple;
	bh=UcSBx9fOy134JKrS8UnzfBE1R9zVyw2cUWZKvaKTpYU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uUWtPQs+7/82kQPStfw7Nk9Z06GfwFI202+nzCHBvi597kl8PIhjpWRYsu/JbJ5KIMkapgGAhp9OZtWyX2D5JWrEXHCAOh/O1PgfxC8Dg2MCZs5XA9y7GNzUrinxCDU5F4aRBXPgfR593LHNMpr7l9RKwEwtzPsgiORycGX9d64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JipSi4NW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406D4C113D0;
	Tue,  9 Dec 2025 11:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765281200;
	bh=UcSBx9fOy134JKrS8UnzfBE1R9zVyw2cUWZKvaKTpYU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JipSi4NWZ4oPk+vkBl6Sktyw5nDZ4DX+0YaFDqNXbkzZGK50OT3HgiC8vDF3MaMnY
	 15MiFKN6PTJQFzUxm67bSjxH6unHOYgFHVkfLw3ijEsod6w4jOahXTB89JlVJvaH3R
	 3Bw5brmCC+/fQmLkxz2R0I1DT2SDOwcJMvP4K9NLda83k7dqGc0GgWhsUCSd4LG/6Z
	 MaHTAUabOyCQzlDXa2rcDCOY6PsOZYx2WXoiUFUilEPJBEYv1bI1J7RCr99XWCAR6r
	 Bjp02YGWSryw2yQSlCTSmHY4WBcdCf7tDTnJQkQc0RRvkrzyQEKdKlfm/6gOku+409
	 uHkiO7tTByrDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B59ED3808200;
	Tue,  9 Dec 2025 11:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] af_unix: annotate unix_gc_lock with
 __cacheline_aligned_in_smp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176528101552.3919807.12895158051021890888.git-patchwork-notify@kernel.org>
Date: Tue, 09 Dec 2025 11:50:15 +0000
References: <20251203100122.291550-1-mjguzik@gmail.com>
In-Reply-To: <20251203100122.291550-1-mjguzik@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: kuniyu@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 kuba@kernel.org, oliver.sang@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Dec 2025 11:01:22 +0100 you wrote:
> Otherwise the lock is susceptible to ever-changing false-sharing due to
> unrelated changes. This in particular popped up here where an unrelated
> change improved performance:
> https://lore.kernel.org/oe-lkp/202511281306.51105b46-lkp@intel.com/
> 
> Stabilize it with an explicit annotation which also has a side effect
> of furher improving scalability:
> > in our oiginal report, 284922f4c5 has a 6.1% performance improvement comparing
> > to parent 17d85f33a8.
> > we applied your patch directly upon 284922f4c5. as below, now by
> > "284922f4c5 + your patch"
> > we observe a 12.8% performance improvements (still comparing to 17d85f33a8).
> 
> [...]

Here is the summary with links:
  - af_unix: annotate unix_gc_lock with __cacheline_aligned_in_smp
    https://git.kernel.org/netdev/net/c/2183a5c8a04f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



