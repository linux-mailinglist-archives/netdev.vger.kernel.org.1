Return-Path: <netdev+bounces-247237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E09A6CF6166
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 01:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AFBF301D619
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 00:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7571A2389;
	Tue,  6 Jan 2026 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uf9mFFOD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289FF19E99F
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767659613; cv=none; b=jl2+XntQm8v5JsBp/P9I1STUG/5r1C13IJnaNgu25OowynxqgiAH9tFXeka9tUEo/TgykBg/mE5wF4LHLy/xkmLguq3htVe+H8no3uumAfSQPn8uIxAldbeOmpTE35C6I+A12pC0Fr+Jc8Jw97uPdoIAI8OYQaN+5E4JXvgKvtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767659613; c=relaxed/simple;
	bh=86u6d4ffqh5mz4x5u28N4CcnVkLoZi8OKtkZ7S3hKoU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ukOR8Nzp6NV3f7FGKRsqe8vxKRIKtBo5RqAiW7YA5Q5vz3O57fS7osJRXBsxdImd+wY0lKkaD3So7QwzIPeHksM/s5aYSMudMvnKmhlmYuZeNPOpEWjPT/Ubt2CPNSmFrLZ6b6rqAnBp9PyK3H53bdBIQftiWeIIO35c/o/DSMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uf9mFFOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3FCC116D0;
	Tue,  6 Jan 2026 00:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767659613;
	bh=86u6d4ffqh5mz4x5u28N4CcnVkLoZi8OKtkZ7S3hKoU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uf9mFFODTEvExL6O2ddS6fsbgbcbeSOfuaJ8MwIhv8XMOyzVGPG7zbKZSw5/BiBXE
	 eT3O6kEWqpSoukVBGCUAa7vutcMX9moJn14ddc+CPAkyZ6VCZ86d4FwZQKRQXuFbya
	 L/vaMMi/ASoYH9N8oGb8wXQnBrUsk/WTSJOgU2owV2Ev6s+N4vooe8FUxkYfK3egLZ
	 e7Jn1LSep7uuy8dHaLzAmWU7sFbdxwBD9BjHPgu67GgP9Z/indVMHZV+P8l83diKP/
	 28xOT7PkEJk7F5d2aDvZ9szqkqntOmzi+DEchsl7gxuUq9wSDKsXjBYcEJ/vEKpF1q
	 Ie8Z+lzy1FITg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B8C5380A966;
	Tue,  6 Jan 2026 00:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net/sched: Fix memory leak on mirred loop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176765941104.1341185.9703975063435681136.git-patchwork-notify@kernel.org>
Date: Tue, 06 Jan 2026 00:30:11 +0000
References: <20260101135608.253079-1-jhs@mojatatu.com>
In-Reply-To: <20260101135608.253079-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 victor@mojatatu.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Jan 2026 08:56:06 -0500 you wrote:
> Changes from v1:
> Initialize at_ingress earlier before the if statement.
> 
> Jamal Hadi Salim (1):
>   net/sched: act_mirred: Fix leak when redirecting to self on egress
> 
> Victor Nogueira (1):
>   selftests/tc-testing: Add test case redirecting to self on egress
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net/sched: act_mirred: Fix leak when redirecting to self on egress
    https://git.kernel.org/netdev/net/c/9892353726ad
  - [net,v2,2/2] selftests/tc-testing: Add test case redirecting to self on egress
    https://git.kernel.org/netdev/net/c/4bcd49a03b94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



