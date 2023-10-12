Return-Path: <netdev+bounces-40251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 233767C6662
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 09:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FB71C20BAC
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 07:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6978DDF6A;
	Thu, 12 Oct 2023 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yc9b/hKm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4744A101C0
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 07:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2991C433C9;
	Thu, 12 Oct 2023 07:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697095824;
	bh=JcDNeIe0yZllHx/V1e8yfZ/5Ffb9PqcUTTJMYxF40Ho=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yc9b/hKmXZHdxsbI25nCcb0s/ymoLuvGmTY6P8j0Uge46GGjSq3w0ju1cuEmieypy
	 dziRkjlrnkwMKF/0BwGZcin6MELW18cXIxeC/Cf1xaVdjT5Fm8my4XE7jaDv19yqfs
	 G/kIuMALN6A8r66SUW6UKDSA6SoTQuoqZENwfqMMTSpqKDjuPacBYZFvBIuKkfkxEx
	 YvshVKMYPVXZsmgS1m7vZtEVL5472m5PoAeAXvvigOb5zsNJpVvAAbxkU75WPYq6US
	 EUjfRD6ySTwAnifXVGvlkRvVYzYQ9tx+MjnnHhLb1iypg741qEh7JB0LegGIPT3FW4
	 3JDIkkDEPLVUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92EDFE11F70;
	Thu, 12 Oct 2023 07:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] af_packet: Fix fortified memcpy() without flex array.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169709582458.1593.10221782315144344818.git-patchwork-notify@kernel.org>
Date: Thu, 12 Oct 2023 07:30:24 +0000
References: <20231009153151.75688-1-kuniyu@amazon.com>
In-Reply-To: <20231009153151.75688-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, keescook@chromium.org,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 slyich@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 9 Oct 2023 08:31:52 -0700 you wrote:
> Sergei Trofimovich reported a regression [0] caused by commit a0ade8404c3b
> ("af_packet: Fix warning of fortified memcpy() in packet_getname().").
> 
> It introduced a flex array sll_addr_flex in struct sockaddr_ll as a
> union-ed member with sll_addr to work around the fortified memcpy() check.
> 
> However, a userspace program uses a struct that has struct sockaddr_ll in
> the middle, where a flex array is illegal to exist.
> 
> [...]

Here is the summary with links:
  - [v1,net] af_packet: Fix fortified memcpy() without flex array.
    https://git.kernel.org/netdev/net/c/e2bca4870fda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



