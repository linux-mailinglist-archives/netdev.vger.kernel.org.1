Return-Path: <netdev+bounces-172680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCC7A55AF8
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579813B3DE8
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A3227E1D4;
	Thu,  6 Mar 2025 23:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="US4CwlH3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7194627E1D3
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 23:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304403; cv=none; b=s5hTY38oXnqymEMmr67uD6PmAhHTh8RSJ6vmSoo+aN0/z5meEZH2JlGBcpDfGa08e+X7QSbO462a64fTJM+cs7Nw77kSly0C6Wt6N2Cza4Fewb+xyf7F9rwIApF+5lNlo6NQ0sexgAMFVigvFufVjCLkd+V2q4U9Wp1D4LpmXC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304403; c=relaxed/simple;
	bh=Sp4qgK9vTpwQ47CUglbGJ7gM58c29DREKq6fVjbDp9U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tSspr3BgoMFpxn474FJZjFWTMUriV7vviS1XihXCw+x/QdsvkABMCOcdu8bso6Eflzr0gURRhtOoVLeqRV+HWUFYZwYn4E8PMnFYcYERd1zDL+kb7jYIq/y755gg8OfZDug5E0xUBYG2Q0h4KIG9mVGxW/nRLEDCm/yop/koTx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=US4CwlH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D488AC4CEE9;
	Thu,  6 Mar 2025 23:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741304402;
	bh=Sp4qgK9vTpwQ47CUglbGJ7gM58c29DREKq6fVjbDp9U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=US4CwlH3cJTwD+bSUmVa9EyVH6r8+ejvdvY3s5f1IojkXYAXl+I3pAO+tgqOGJfVD
	 7piY+ORJxP1v1duM5UYprwDCi8KyEWHjQVPYRDoZEL46+fl0RmFDRhrTwDTWxb4c/0
	 rXEvkSNlI5OZ0nXJUy2t6D7ZAyB/JWoSLVVyo/HuhGy1cjsXRFPUBak+jGgOw6KJM+
	 Vyu1ytBwvd4j9QkOOqKJ/yz/E/76A4QKZHu+1Nevw8ptmSiecAprzdtlftxvMi7qXF
	 92y/v1aOj16bCf3R9agAA+YzSbzLdI5tTaeA3eiYjmymjWMF9Gs32TLLVqWVjQq+PC
	 dozISOo0jelWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DF4380CFF6;
	Thu,  6 Mar 2025 23:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] tcp: even faster connect() under stress
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174130443598.1819102.96067326148629564.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 23:40:35 +0000
References: <20250305034550.879255-1-edumazet@google.com>
In-Reply-To: <20250305034550.879255-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, kuniyu@amazon.com, kernelxing@tencent.com,
 horms@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Mar 2025 03:45:48 +0000 you wrote:
> This is a followup on the prior series, "tcp: scale connect() under pressure"
> 
> Now spinlocks are no longer in the picture, we see a very high cost
> of the inet6_ehashfn() function.
> 
> In this series (of 2), I change how lport contributes to inet6_ehashfn()
> to ensure better cache locality and call inet6_ehashfn()
> only once per connect() system call.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] inet: change lport contribution to inet_ehashfn() and inet6_ehashfn()
    https://git.kernel.org/netdev/net-next/c/9544d60a2605
  - [net-next,2/2] inet: call inet6_ehashfn() once from inet6_hash_connect()
    https://git.kernel.org/netdev/net-next/c/d4438ce68bf1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



