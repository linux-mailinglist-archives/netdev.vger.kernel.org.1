Return-Path: <netdev+bounces-213139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8AFB23D9B
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 03:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B141AA816C
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 01:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BC319882B;
	Wed, 13 Aug 2025 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaQGoUoV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEAF2C0F87
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 01:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755047399; cv=none; b=gAESG8IjSWSD47f+PIEQaqx3ZOfyxCznVxsv+e+LQysIpightsLZSVz4pcxjFS7L1eKrf45v+dAGlT7eMxnWgIxg+IUOiQnHh/vxLFnQNqkgAiaiCJtSwZCo7jVt9KaSHXKVRDKpwkpxGfgA2f+WtZ2ygtjEtwoGRtkkkl9VRNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755047399; c=relaxed/simple;
	bh=z3Hly6wGwWLBc9E+tqRclXqYvOGN9kEqvEAWNamcDZ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HFgtdfrJFGDAKNtNoXOFO1bDTIpXz880ouamgs1WxTUC0alToXN8JKM3VhILRpVdWBQKOstJf+LSYrgoaDMCo5iaR0t4I9rclKACxMrbpdTJzFsEVwGH2PF/XkDaISnk08E/PQac+bDzbE8YbYAj5/g3+453FkOQV54YYVJuGMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaQGoUoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B92C4CEF0;
	Wed, 13 Aug 2025 01:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755047398;
	bh=z3Hly6wGwWLBc9E+tqRclXqYvOGN9kEqvEAWNamcDZ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BaQGoUoV10wNWfiWmQt6WDIZIwq7pB5rPqjIv29URPW6hBzN6uxCV76yr99r8QjEV
	 JIZiu7FeptUFvCswYDpUlDbvnB68eShYJgzJn6mkn51AnTV+hW32aXLK+3EKD7g+Cu
	 pNv+WL8Y+52A6m6tiQ1JkCi0rBimk/A5WmNfKx8Z0m/lhtRWtF7gJNpCLeTSlfyzWA
	 lAQYLBCysvYp4b2uxNvyC/XP9nAK+Wr2+bhd6CNkelKoRjv1uL6v9bIgc54CR3q/Pq
	 u4mYU4xJ2QM0lENmoacgzVZH6HnXqJqNBzlA7mklcJHcYqkkDriYx/4PiwDKI29aPm
	 evf6gRpiPo/0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADC239D0C2E;
	Wed, 13 Aug 2025 01:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/4] selftest: af_unix: Enable -Wall and
 -Wflex-array-member-not-at-end.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175504741075.2910902.4573020164380006687.git-patchwork-notify@kernel.org>
Date: Wed, 13 Aug 2025 01:10:10 +0000
References: <20250811215432.3379570-1-kuniyu@google.com>
In-Reply-To: <20250811215432.3379570-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Aug 2025 21:53:03 +0000 you wrote:
> This series fix 4 warnings caught by -Wall and
> -Wflex-array-member-not-at-end.
> 
> 
> Kuniyuki Iwashima (4):
>   selftest: af_unix: Add -Wall and -Wflex-array-member-not-at-end.
>   selftest: af_unix: Silence -Wflex-array-member-not-at-end warning for
>     scm_inq.c.
>   selftest: af_unix: Silence -Wflex-array-member-not-at-end warning for
>     scm_rights.c.
>   selftest: af_unix: Silence -Wall warning for scm_pid.c.
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/4] selftest: af_unix: Add -Wall and -Wflex-array-member-not-at-end to CFLAGS.
    https://git.kernel.org/netdev/net-next/c/1838731f1072
  - [v1,net-next,2/4] selftest: af_unix: Silence -Wflex-array-member-not-at-end warning for scm_inq.c.
    https://git.kernel.org/netdev/net-next/c/942224e6baca
  - [v1,net-next,3/4] selftest: af_unix: Silence -Wflex-array-member-not-at-end warning for scm_rights.c.
    https://git.kernel.org/netdev/net-next/c/9a58d8e68252
  - [v1,net-next,4/4] selftest: af_unix: Silence -Wall warning for scm_pid.c.
    https://git.kernel.org/netdev/net-next/c/fd9faac372cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



