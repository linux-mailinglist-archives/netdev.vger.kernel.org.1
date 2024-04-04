Return-Path: <netdev+bounces-84684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33299897DBD
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 04:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE8728842D
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 02:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4C829CF1;
	Thu,  4 Apr 2024 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPESMufZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AABB225AF
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712197831; cv=none; b=glu09j/cPRQmwjJ534zO1NkK+2Ekp2G6Jny+TJu+Jer9pJoe/+MvCzTJpQo3VDvS/nadeMF+jGjyju3wEmEV9z5Tjp0KQOzCq4WVzaRvZpSRyAsxj8BEYjeZQrc2Z+MGWawopeb1eR4nF/CpS2bBwFLW+HjzkimptKUlzn6AaKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712197831; c=relaxed/simple;
	bh=8XU1P2kBhaYjJVrGyPeBz3T79JiJ428bXbeGCwtW1RA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KkBBeki+j0R6w0hYHzYtxENsO3n0EBvd/IlzNAwREuOlkttJTKvsQTL21F4+snTA5Nv+8vtvxUBbTaZL+Kq5tSQ1bsYPG2CQ77M1aQKAo/BzJ/l51bGvQuX5gRIAni6K76nr9yLnwSaXLCZb5m/I/wmzTKEMA13qMinIaKmQYkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPESMufZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9249C433C7;
	Thu,  4 Apr 2024 02:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712197831;
	bh=8XU1P2kBhaYjJVrGyPeBz3T79JiJ428bXbeGCwtW1RA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hPESMufZ9Y8q8O5IHpauLuRFWQXunQ+IXlf0aH1xDCgZ2j754Rc9Nvv7V/Q/b+1SX
	 ug1KIz2xWPdJlOBtK8Rf5x7ejvivHor9C9vCVGAk/WJTEQkUaMuhEPlCv2DKTLinar
	 QAFvQQCTzl6w4d5k6BfpmZabh/cD/aQVixfKWcd8eT/9jbjuu72OfFWJTbvi2BdSjH
	 grQRGPUp/LVJrj2GmGcSWplAG9Z/K82BdlDjZ+PkA89ovXKYU3DCQ0F/daFb1nf4Ra
	 +YsHxzFriD+N01M3M6SAfeCiyhm/hxQLp3g+25D0oohJD1zEeIIz3VOKzq1V8dbayV
	 y8ojYbEFU8uxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF788D2D0E1;
	Thu,  4 Apr 2024 02:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/2] af_unix: Remove old GC leftovers.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171219783091.25056.4589044183528305137.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 02:30:30 +0000
References: <20240401173125.92184-1-kuniyu@amazon.com>
In-Reply-To: <20240401173125.92184-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 1 Apr 2024 10:31:23 -0700 you wrote:
> This is a follow-up series for commit 4090fa373f0e ("af_unix: Replace
> garbage collection algorithm.") which introduced the new GC for AF_UNIX.
> 
> Now we no longer need two ugly tricks for the old GC, let's remove them.
> 
> 
> Kuniyuki Iwashima (2):
>   af_unix: Remove scm_fp_dup() in unix_attach_fds().
>   af_unix: Remove lock dance in unix_peek_fds().
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/2] af_unix: Remove scm_fp_dup() in unix_attach_fds().
    https://git.kernel.org/netdev/net-next/c/7c349ed09031
  - [v1,net-next,2/2] af_unix: Remove lock dance in unix_peek_fds().
    https://git.kernel.org/netdev/net-next/c/118f457da9ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



