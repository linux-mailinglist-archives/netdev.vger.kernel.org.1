Return-Path: <netdev+bounces-241753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0103C87F09
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBCB3B45A0
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9638330F546;
	Wed, 26 Nov 2025 03:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8GqSsEy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0DC30DD1B;
	Wed, 26 Nov 2025 03:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127267; cv=none; b=rKQMsOWasK+5qbeQgbWIyhlIaDh0nWTWyzpekX+i1NP4qad8Buygh42Kfsi8PMZydMH2b2oGEIDvRX5YnVdBkNdExKO7525eCSLM/nYdFwLQtPMi9rAG3nkGCqsz+JZzbpdkzLhMUg0ZGKxIrrVXdhKCiAIE1QVzi/mBEft6G4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127267; c=relaxed/simple;
	bh=NUm/3mkkmk23EkVmqhUGOtMMlCXJBJdmv15M4dDY32k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cbNN0MxqJorgu+f9xASHAGVyjm8rvyruLdtiYwvX3DkHwJPCYCV+8QEIl4W8n7Re8Un12X2SC72LOdpUKoV4Z81hknx5XcF3l3I12Ik31/70C+BkxxZLWFNdQlJOhnUag2sl3JAm+KFrqMj67WVgHKHBCahB4NyQWvRMTjA0v94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8GqSsEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A14C113D0;
	Wed, 26 Nov 2025 03:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764127267;
	bh=NUm/3mkkmk23EkVmqhUGOtMMlCXJBJdmv15M4dDY32k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b8GqSsEy+DQdGkNVp5IyyxHspwoMuJVmZICuojYSxDp/qza6Fg07wMNP452v9zt3j
	 hwJTXnaWnhdrI757RfynyFwXzV5g6a9K5JBzEeFIuYxmZypooDcbD6MkC+QVxIzAPN
	 cmSOet/zSCsjM55/8+/9aOO9A/EzOjzgNsLb+yp2Y4oP0b6AV6mbl7JW6I8gLqrXQQ
	 SGs0eV9GsQ30sR0+UvggVUNOl70P3slvpVkSAuAfEHFguJ3itm4hTm+OBFnR+9W8ou
	 Afq7liq3zJ4kiS5Fx2f/SyDxoVd4Y5zDbCC+ImY2sUN18mFks8Habizo5PSn7kX5hb
	 TSRBnX67cQEmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BDE380AAE9;
	Wed, 26 Nov 2025 03:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] vsock/test: Extend transport change
 null-ptr-deref test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176412722900.1502845.12794410692488163252.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 03:20:29 +0000
References: 
 <20251123-vsock_test-linger-lockdep-warn-v1-1-4b1edf9d8cdc@rbox.co>
In-Reply-To: 
 <20251123-vsock_test-linger-lockdep-warn-v1-1-4b1edf9d8cdc@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: sgarzare@redhat.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 23 Nov 2025 22:43:59 +0100 you wrote:
> syzkaller reported a lockdep lock order inversion warning[1] due to
> commit 687aa0c5581b ("vsock: Fix transport_* TOCTOU"). This was fixed in
> commit f7c877e75352 ("vsock: fix lock inversion in
> vsock_assign_transport()").
> 
> Redo syzkaller's repro by piggybacking on a somewhat related test
> implemented in commit 3a764d93385c ("vsock/test: Add test for null ptr
> deref when transport changes").
> 
> [...]

Here is the summary with links:
  - [net-next] vsock/test: Extend transport change null-ptr-deref test
    https://git.kernel.org/netdev/net-next/c/b796632fc83c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



