Return-Path: <netdev+bounces-184061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1818AA9301F
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6117F8E0F0C
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE95F23E340;
	Fri, 18 Apr 2025 02:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsMo7VHy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A3F219ED;
	Fri, 18 Apr 2025 02:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744944622; cv=none; b=pPi0iC+kNtwSs3gqXZ7cSlDpTBfKcEebKQQbArmoOvFgnjN9AZno7d+BDh7Tq3+icwmleW7Yc0vbfqnq8y9OXecPKUPN4hwZKEwTiOe4+mrkoa4QKnZP3GKv6QXObt883amnNgbsZTz6ajgstPCOvErnllOVhirpzvgikTRUDeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744944622; c=relaxed/simple;
	bh=jGrq8tE+7YaPDd/xmPS8CKHr6eL02Q7LBXtFoqx9d1U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DrSe+rJQs4dsmwWExbJODikG0rLP+grWwoPO42MR5aqgyWshQZ0GRbDbuBijZk9kAwOuVsRE8y6cE+u2MkMOLVOAC5It59d+e+LoNhBStXy7NVrTy+BSACyuVUcDRtDoyABcLEXfNrtpAhYgenXpzpjmIPnax/KaZJy65s4EGGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsMo7VHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C47AC4CEE4;
	Fri, 18 Apr 2025 02:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744944622;
	bh=jGrq8tE+7YaPDd/xmPS8CKHr6eL02Q7LBXtFoqx9d1U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fsMo7VHygmGy/jQuNAxeTIH45lseIn2JeBjB4QMNT1GDl9g7aJq+jg2+vkyNIy4bF
	 36U7lQius+JyUfGnb/CTXbr06/HlF0+FAhdfsaSJnXY+In1hXWEecjy/jzhqPRtVB1
	 xsBl5ofbMAZ10MHk2e6qnZzeImRyi1TjWOEca3YIA2qsSqAhFhqVrw/G39Pe0M4Um3
	 NCJI5D5FhYfX9sd+7Zp6CQ4yFxhn7n21LNQhf+sCbi1l7iV1efKE2jkd8geIQ5js1z
	 tio4O0ELJfMMdZRyEmapl6y8Cmb2/IZC+Yf1pfDCe+iJXgjuI1ieUvtrC9OxVKxceG
	 UeCAgmLfgFglA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D90380AAEB;
	Fri, 18 Apr 2025 02:51:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] trace: tcp: Add const qualifier to skb parameter
 in tcp_probe event
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174494466027.88264.11686966435646986323.git-patchwork-notify@kernel.org>
Date: Fri, 18 Apr 2025 02:51:00 +0000
References: <20250416-tcp_probe-v1-1-1edc3c5a1cb8@debian.org>
In-Reply-To: <20250416-tcp_probe-v1-1-1edc3c5a1cb8@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@amazon.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Apr 2025 10:06:12 -0700 you wrote:
> Change the tcp_probe tracepoint to accept a const struct sk_buff
> parameter instead of a non-const one. This improves type safety and
> better reflects that the skb is not modified within the tracepoint
> implementation.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> [...]

Here is the summary with links:
  - [net-next] trace: tcp: Add const qualifier to skb parameter in tcp_probe event
    https://git.kernel.org/netdev/net-next/c/1df4a945444f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



