Return-Path: <netdev+bounces-118708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D23E95286B
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 05:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B48ABB222CC
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 03:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E9F43156;
	Thu, 15 Aug 2024 03:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCvVAOcf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358A042056;
	Thu, 15 Aug 2024 03:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723693836; cv=none; b=qGoL7CukvuTERBsqb4K+N4eg3bSXZEQaVDOKZnsoJ1xLB1F+dVST5W+kjOrnagedq58JPDK8LO7ctjd1waEkT9O19Qvpminc4NgNe+sZEQdDYq3XlfniIofrdJxzIg3ZHCACfqvW/i8SX4th3nvVwfZqxlFgjW6Et5x8K8Z+n1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723693836; c=relaxed/simple;
	bh=5qRwC82KpDXvBwqWDUCuIrJF+pNBzAZ2uhECqrpB95E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p5v0bI0bJhOBP3qFfBYkC6q0Ff8hcUWd4aNkHaK6U5j8mn8q8LhUbVZXjWU5USkL2QfGDNcRv1bfYq5lNNOcGvWYyx3+O3ohwSrZAGrS6BEtlbWz+aswGaEH7WZLHadQEifAokx5XFQw1CkM+d8/EjQxQHaCKz5a22v8jVPm22A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCvVAOcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26ABC4AF0A;
	Thu, 15 Aug 2024 03:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723693835;
	bh=5qRwC82KpDXvBwqWDUCuIrJF+pNBzAZ2uhECqrpB95E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mCvVAOcfSHk9eqRgLArhNINeZnbEIydLZTxZEY1Zd9W+olhqbit0g+OlU6MU4By5L
	 YCRh7aHE2TkaT51EilPUBaPPsYQQllox6U1fZbV7aQPD+xQvI4R2OCqjUJdPkbwrCZ
	 M/0xX+EjI5Uely8VCkIyc00sUZodPzVwwisCMU9nsQShw95R147UsLVJqZ5OYpejXQ
	 dqk+WMAb2K3ws6fb22TNI8V9tVGoEjn0sJcLK6nlxjFGBRx7MEc69ITRfN7yMkfIxs
	 4y77Sj/8BDF6vHM0su7bLsif2nm2gmnAeo/EPUBEf9lCreQO6Se0rSjljRKcTqi+Tr
	 k3AA8MPfZugNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C153810934;
	Thu, 15 Aug 2024 03:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2][next] UAPI: net/sched - cxgb4: Fix
 -Wflex-array-member-not-at-end warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172369383473.2458412.370604795772411458.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 03:50:34 +0000
References: <cover.1723586870.git.gustavoars@kernel.org>
In-Reply-To: <cover.1723586870.git.gustavoars@kernel.org>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 bharat@chelsio.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Aug 2024 16:13:58 -0600 you wrote:
> Small patch series aimed at fixing a -Wflex-array-member-not-at-end
> warning by creating a new tagged struct within a flexible structure.
> We then use this new struct type to fix a problematic middle-flex-array
> declaration in a composite struct.
> 
> Gustavo A. R. Silva (2):
>   UAPI: net/sched: Use __struct_group() in flex struct tc_u32_sel
>   cxgb4: Avoid -Wflex-array-member-not-at-end warning
> 
> [...]

Here is the summary with links:
  - [1/2,next] UAPI: net/sched: Use __struct_group() in flex struct tc_u32_sel
    https://git.kernel.org/netdev/net-next/c/216203bdc228
  - [2/2,next] cxgb4: Avoid -Wflex-array-member-not-at-end warning
    https://git.kernel.org/netdev/net-next/c/6c5cdabb3ec3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



