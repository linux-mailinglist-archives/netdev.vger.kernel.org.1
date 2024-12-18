Return-Path: <netdev+bounces-152935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609779F6634
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 13:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D1F16C1FD
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36A91A3029;
	Wed, 18 Dec 2024 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0ej6xMr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A95A19F42D;
	Wed, 18 Dec 2024 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734526212; cv=none; b=Ph4FLCvBKYQ5IHW4XVajrEAbIcmYeVYi15RNWZy1cFp/RGAHm03KVK1dq8Dk7LwvQnaL2+/aiYgbscaA6GZvkG+MkszMDiXi6MhSCgGCwZBVBzg7g8xhOnV4WGKdlDpEKoqf5TxyClB6TjTF7d2Lc5Ix7y9LoVPRMg5vvzECjyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734526212; c=relaxed/simple;
	bh=GPYYtTW4OXSQZXcpref/M/pt2I134vglgN4Zuj0N4ak=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZFfV6Q4Ifd94a3WQi8dcyvOIPRILYTFbjeSyWZPwnMCIC3QazE8bfwAF4BtBGZfzykG8KJ+YlmYjq5OTFhd3X+pNq3KRxsESSrvSAxA3R6eI4JDK7/DbnAMYY3uqkyDoKqaaF+xxroUR69L9XNlRnmWRMEun8Tv3Isd3XbV1y+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0ej6xMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABC6C4CECE;
	Wed, 18 Dec 2024 12:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734526212;
	bh=GPYYtTW4OXSQZXcpref/M/pt2I134vglgN4Zuj0N4ak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z0ej6xMrJcyYqFGt0rR9B5bqSueO5kjNtVTg9gx8Gbf42C1YkhFok014v7CJFZcmW
	 /UKbPF8p+bhpnK4MXyyQLeQS5mXMyexGXC/TTL+lyCO6/UpMYeysUiMNNZUammgO6U
	 2WcUfctYj8eddhJahoXwjXM51Za26/nWrkvzcNKq43I4C73qdrS7gdJCG/7q5QOEKl
	 mVIurkqQfgEcKxUHqpWeXPjbDddyV/cNtKuJwh68RBu1zzKlT65leNeRwl5fmcJkvo
	 ikYhNLQ5CPnYO8T5iVGf11p4DKswQ3cjGHoLYu8G8DRipMjdkb2KfRYEffXA+aPaXe
	 xS0/DimxWJ9rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE07C3805DB1;
	Wed, 18 Dec 2024 12:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: qca8k: Fix inconsistent use of jiffies
 vs milliseconds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173452622952.1602968.13907831625691013754.git-patchwork-notify@kernel.org>
Date: Wed, 18 Dec 2024 12:50:29 +0000
References: <20241215-qca8k-jiffies-v1-1-5a4d313c76ea@lunn.ch>
In-Reply-To: <20241215-qca8k-jiffies-v1-1-5a4d313c76ea@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ansuelsmth@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 15 Dec 2024 17:43:55 +0000 you wrote:
> wait_for_complete_timeout() expects a timeout in jiffies. With the
> driver, some call sites converted QCA8K_ETHERNET_TIMEOUT to jiffies,
> others did not. Make the code consistent by changes the #define to
> include a call to msecs_to_jiffies, and remove all other calls to
> msecs_to_jiffies.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: qca8k: Fix inconsistent use of jiffies vs milliseconds
    https://git.kernel.org/netdev/net-next/c/5a49edec44f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



