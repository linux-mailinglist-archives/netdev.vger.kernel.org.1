Return-Path: <netdev+bounces-239817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB7CC6C9FC
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 04:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B202F4ECF4E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0884E27F736;
	Wed, 19 Nov 2025 03:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On9TGSFU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C8A1DE4CD
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 03:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523060; cv=none; b=oh2Tx25D49Re+wz67Ua0gRCApPv0kBwtQhBt5+ggmY4aq7LRKxrFT40Td2EL7roY3tdlo0ELsE0ux578O6MxZiF8cOwenhbgWlKvcWdXU4nfnIcHO1uuXoNRqUTGwzsRWmLg4jzEGROS7uo4QHtO/IIK5PCGkEcF3CXkshKDGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523060; c=relaxed/simple;
	bh=AXzxAVbgU4fgHVEF+woXPxiyX2Ucx3kJ05UOJejXjmA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bTtg2vAEYnXadkG5MEL25mx8+aZRW+lo8QNYxqGSMn638+xG3r83MRCFWOj6vcAVcOK+WYF+oAP73p+KpUojk1w8xkAeIFWKEjD07BKZyGWatgfr6fDlhBcffzz9oYOPwcYizyQHOXzjjQydmJkN6bfhFcji7POmpmhh5ZpRDXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On9TGSFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1A3C19425;
	Wed, 19 Nov 2025 03:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763523060;
	bh=AXzxAVbgU4fgHVEF+woXPxiyX2Ucx3kJ05UOJejXjmA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=On9TGSFUPsIQNDc8YgCJFBgIWA6yuXQsEmDRaQbOLoVgzNBHjYgv7PkzQKrAg7bA/
	 UKiWZgEy0/fgoVFJH1998J/EBEeHS0zycZuivkh49QZCQ6fsmh8l+wsAqpxRaMJBDq
	 g7lJJCfbyv5tu5kCUW/2lCJKXq7WYzEX3GAxg/bFHYqd0OdIz7HR7GJESm3J/3yxTn
	 bADkM0W7DfOgSlRw7rJWpbVvw6MbcU7x5ZRa7slSF4KFuGSqIZd12SHEpBvrEomtVw
	 k4GuLpK7885+3lnh60SaoKqfDK+92SyaLGQ1x3iCCKQhoqg8K/5IilBljf1snzZOkU
	 lkfPthLhiruVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D0F380A954;
	Wed, 19 Nov 2025 03:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/7] af_unix: GC cleanup and optimisation.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176352302499.209489.8147423042032307898.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 03:30:24 +0000
References: <20251115020935.2643121-1-kuniyu@google.com>
In-Reply-To: <20251115020935.2643121-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Nov 2025 02:08:31 +0000 you wrote:
> Currently, AF_UNIX GC is triggered from close() and sendmsg()
> based on the number of inflight AF_UNIX sockets.
> 
> This is because the old GC implementation had no idea of the
> shape of the graph formed by SCM_RIGHTS references.
> 
> The new GC knows whether cyclic references (could) exist.
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/7] af_unix: Count cyclic SCC.
    https://git.kernel.org/netdev/net-next/c/58b47c713711
  - [v1,net-next,2/7] af_unix: Simplify GC state.
    https://git.kernel.org/netdev/net-next/c/6b6f3c71fe56
  - [v1,net-next,3/7] af_unix: Don't trigger GC from close() if unnecessary.
    https://git.kernel.org/netdev/net-next/c/da8fc7a39be8
  - [v1,net-next,4/7] af_unix: Don't call wait_for_unix_gc() on every sendmsg().
    https://git.kernel.org/netdev/net-next/c/384900542dc8
  - [v1,net-next,5/7] af_unix: Refine wait_for_unix_gc().
    https://git.kernel.org/netdev/net-next/c/e29c7a4cec86
  - [v1,net-next,6/7] af_unix: Remove unix_tot_inflight.
    https://git.kernel.org/netdev/net-next/c/ab8b23150abc
  - [v1,net-next,7/7] af_unix: Consolidate unix_schedule_gc() and wait_for_unix_gc().
    https://git.kernel.org/netdev/net-next/c/24fa77dad25c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



