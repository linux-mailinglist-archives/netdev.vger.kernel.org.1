Return-Path: <netdev+bounces-178476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB70A771BD
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 02:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3053AC3C2
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 00:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46841917F4;
	Tue,  1 Apr 2025 00:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuR12LFz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08D1190472
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 00:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743466221; cv=none; b=Jf8djVidI/zmT/eoyHAAdjvyMdqjOAUo4R1lg1EIkFHFv/c9T5zrqI8zmwiwiY3lzB/tWqtCS17jVIrAv/iEnh99bOuBbpO0jOdD45vOuXIMgE2oUPn9NrJBsB8k0OIX0kziTUYXH4niZadDxahJnX/r6vd4lro87K+SaNZ6nws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743466221; c=relaxed/simple;
	bh=SjhPl+Pmp85NCIZaTgfj8/3Nhp5c8Y7ck68owE00c/s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lBz5txJFun16h5al5H+JdfHIj5+a177po4kHYk90aG0uBLGYWmd6LmAon6g88tKhpHXzEfj7ocZdih3wkRfGxYSoWL83kp0ylO3kWoX2RWTmXzrNEKyx6yae6+qC2bFrsErr9mQckhdNwdbQ7UkP83ITRoVO3fNY2EJqyf1Sq+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuR12LFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45ECEC4CEE3;
	Tue,  1 Apr 2025 00:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743466221;
	bh=SjhPl+Pmp85NCIZaTgfj8/3Nhp5c8Y7ck68owE00c/s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VuR12LFzME8o2hsLIf7X8MQMkg+c4YlIsYR5nv+ibqfDXrJK8l3vEQfHtCtnU/aqw
	 3YMyyR4udd+V1MElaOoGLAKZa+WRh9FCPFVWooad7s5t7nQ18dL/5izgYgeCYc6yRI
	 ADhAzzmUEpq4gf5wi0ej4QwUL/di9ElvC6uoIGfpqIJKTcuLQNxv7AaXzlJZBpYG8t
	 JGJ9DcROKuT5kvy1eRZ7gImptf+61kAIrcMM01owp/M+XrN27BCXGPbL/g8yaZKg4E
	 emUSUUv3aCq2JFytR3hZjODZr0YV2llrVV+I7wSFtNK7qS+7wo1Kg7ET4VnuELeoHb
	 S0HfAoTdGCJFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C56380AA7A;
	Tue,  1 Apr 2025 00:10:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "tcp: avoid atomic operations on
 sk->sk_rmem_alloc"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174346625775.178192.8168747588535755973.git-patchwork-notify@kernel.org>
Date: Tue, 01 Apr 2025 00:10:57 +0000
References: <20250331075946.31960-1-edumazet@google.com>
In-Reply-To: <20250331075946.31960-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, horms@kernel.org, netdev@vger.kernel.org,
 willemb@google.com, kuniyu@amazon.com, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Mar 2025 07:59:46 +0000 you wrote:
> This reverts commit 0de2a5c4b824da2205658ebebb99a55c43cdf60f.
> 
> I forgot that a TCP socket could receive messages in its error queue.
> 
> sock_queue_err_skb() can be called without socket lock being held,
> and changes sk->sk_rmem_alloc.
> 
> [...]

Here is the summary with links:
  - [net] Revert "tcp: avoid atomic operations on sk->sk_rmem_alloc"
    https://git.kernel.org/netdev/net/c/f278b6d5bb46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



