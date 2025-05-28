Return-Path: <netdev+bounces-193883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE79AC62A6
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 09:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6341BA37C4
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 07:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB87229B0B;
	Wed, 28 May 2025 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRwTugnT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DBD13B5A9;
	Wed, 28 May 2025 07:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748416204; cv=none; b=Bdj5g0lXzKbjN1hD065WiCjtNYzP+QAI5DI+CV11K+n98crnzUjmL+/Td793cteKQXoDZb2e5eKJimkO+pZlePzHXjESTqzRVOno6IRsWRZA2x8rV5YfV6OxJIuTtl99FhhXgXzfAVbD6KITffi0tYKvCAM3p5KG/CiEdjdMprs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748416204; c=relaxed/simple;
	bh=b17czl604puTsFyxm927VcXZIwq3UoC5jpyPmjjyHG4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h3u/o9sCMNB5KSPA2vbQSXOMZO6znO9n9KuQDyTQcU/HFg1LbzvEzmAdflRu0COZhIN2Sg4MAroN/u/APGLJMa4IRn2pCc7QdV2ok8aryjL32sFDA2E9TLAsM+a5tkl85YvOvwJdLtVfk/ThfIBRzxgDklONmxRAd84Y5B1PJFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRwTugnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E86C4CEE7;
	Wed, 28 May 2025 07:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748416203;
	bh=b17czl604puTsFyxm927VcXZIwq3UoC5jpyPmjjyHG4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BRwTugnTHsKaqnkXFcHY7ys00DX1qO7uA7QlPp4aSae0qiu7s0p1FaDKZH/Rx95nc
	 K7MUoEHAJp9zUibOYGfZWYRW/9VD7JubB9GlpRkH+gRdL0Q6Vnx/J4i7hYtHDqVCtw
	 9hkJE2XKOkyW56WtjR0d/fOWsFTo2gLcSlkzRPkiAJGFKJYOO1a9YARkfCPuits0Hd
	 gVaxrD2+zM30xc/2fzmBYmHn5M1k47M/cA5sgczHekIDPc4s4RuZ+YyurXdsVtsmwh
	 sfcy2W/bhhf2YO8hRCEjgYydH9MVgC5B8ozqRjfMhGLPmiiT2kURce5JtU3ec/N+16
	 tz6qP45x2xSww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB04B39F1DE4;
	Wed, 28 May 2025 07:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] calipso: Don't call calipso functions for AF_INET sk.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174841623776.1935682.16829373096139455739.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 07:10:37 +0000
References: <20250522221858.91240-1-kuniyu@amazon.com>
In-Reply-To: <20250522221858.91240-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: paul@paul-moore.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, huw@codeweavers.com,
 kuni1840@gmail.com, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, syzkaller@googlegroups.com,
 john.cs.hey@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 22 May 2025 15:18:56 -0700 you wrote:
> syzkaller reported a null-ptr-deref in txopt_get(). [0]
> 
> The offset 0x70 was of struct ipv6_txoptions in struct ipv6_pinfo,
> so struct ipv6_pinfo was NULL there.
> 
> However, this never happens for IPv6 sockets as inet_sk(sk)->pinet6
> is always set in inet6_create(), meaning the socket was not IPv6 one.
> 
> [...]

Here is the summary with links:
  - [v1,net] calipso: Don't call calipso functions for AF_INET sk.
    https://git.kernel.org/netdev/net/c/6e9f2df1c550

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



