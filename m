Return-Path: <netdev+bounces-84236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAED1896214
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 03:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078DB1C23608
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 01:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF9B175AB;
	Wed,  3 Apr 2024 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Snz2XKYe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B6314F7F
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108435; cv=none; b=RZLt85l3SGdDXaMPyrYDAWMwrRfJTy+F+oA0hrvo97HXgA268zfzLMP4JIn+nziWzib2q9wolut6WPU071E9ZKG/Lkg59S/qvEAhWq2z2R25QIl4DkjZzJ7eZMhtPKMYsLRJcnbxDsE+7qNVBARePegq6iJypoYZ7cXpjuLTZ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108435; c=relaxed/simple;
	bh=Z6HRn/oQCeShVx7kQYlxo75+zP1XCe5qFz4Q59vudUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UT8esV+rxQife0nPzi/zbQ/+DJOs1tGTUOD3IXmqFOcL86craZzrmjUTok8q6x9YyZegPJA/pgIctOYZRknH412yg5g6JYbd8vsCoUQ1/+poaLugNM4kp2PRe7bzO0rLlV4oEnGL3/GYvjqCWwoNX8hrgqGsbWCm8HeorbGcASI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Snz2XKYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2ACEC43390;
	Wed,  3 Apr 2024 01:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712108434;
	bh=Z6HRn/oQCeShVx7kQYlxo75+zP1XCe5qFz4Q59vudUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Snz2XKYezmw16rBzeQivI8frv9SZLdj3Ox6fXmW7faW2IzgX3q2swL+RfjDiA7XdY
	 SSJvH6/SVRpa0lWiznS70SyQwLU/MdOQZfuFOIWwvOrlF1q0PH06nG8dHScbmJpLoe
	 wBPlWxOqq6cJNRiqx2DbPhiKcww4VYhcqdmSjzFEVwcTvNqGeWWL7l9BlM5VwBJIwH
	 LRS5+fuPlUzE56gY0lrZ8HHVAZRgishCz+revY3pKpEvtsXMfTRa6tj4MfFH4GzBAl
	 BqR6sWluAQ05Ltfh771M6JvOABVTKXMHi6llwopNNxLwZWxUGjvIaesA7SKxDghClJ
	 3fZs4Gf0YpJHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2E57D9A155;
	Wed,  3 Apr 2024 01:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp/dccp: complete lockless accesses to
 sk->sk_max_ack_backlog
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171210843479.14193.3217620378257440808.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 01:40:34 +0000
References: <20240331090521.71965-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240331090521.71965-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, kernelxing@tencent.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 31 Mar 2024 17:05:21 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Since commit 099ecf59f05b ("net: annotate lockless accesses to
> sk->sk_max_ack_backlog") decided to handle the sk_max_ack_backlog
> locklessly, there is one more function mostly called in TCP/DCCP
> cases. So this patch completes it:)
> 
> [...]

Here is the summary with links:
  - [net-next] tcp/dccp: complete lockless accesses to sk->sk_max_ack_backlog
    https://git.kernel.org/netdev/net-next/c/9a79c65f00e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



