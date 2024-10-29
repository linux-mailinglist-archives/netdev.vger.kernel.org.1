Return-Path: <netdev+bounces-140193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A759B580C
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413151F24137
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832A420FA8B;
	Tue, 29 Oct 2024 23:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvL8mTbE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F71620FA87
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 23:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245828; cv=none; b=NVA0CGmvpMETRYU15eiXmmZDMDfrmoU3g/5tA70fJIAO1neDud6EzHlMLsJuH+YKRLWqoTC0Jj80D7sR46YM6KjwnpiWBUqXjzIFWVpF4RJWmaVuKSUwgPc57E3kMmG4FWCr3+f+qHL6oxKNmheV6gANfX8EVUFZu+ZAVWHULFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245828; c=relaxed/simple;
	bh=MinWQehcDOC/MsPDK3RXLUVrx5pDMaH/eu7svFDNiU4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dVzno+g6jrnjD60KQw7tUMaq8nwtzwk8kUvOesmZBx96VqakiFiYA8uq3HgQ0Q8t2pd2jIKKTstfqJLl4VQGoHrPlY8knspZMbM2ZO7RqQ4eO4+8NPUAFDwAxauX64nBylHr8NQu/mUyrtZ9YQ28pGSKfPD+gB/w0v1f7C3LpjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvL8mTbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBF3C4CEE3;
	Tue, 29 Oct 2024 23:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730245826;
	bh=MinWQehcDOC/MsPDK3RXLUVrx5pDMaH/eu7svFDNiU4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MvL8mTbEf10Q3BX2k6VFzUd0tBe0vJiGCyUZ4e33y4YeHVngW0wUCHE16NvjwkFd3
	 lwk6lwzGK//JuZ1RjziPl7TOt8SNPanDevfjFXBaIoZCgusSOtGCbH/FjHL1Ne3kb0
	 axMUluWkYRXXJ9svCwuebhwxwXburlI6/TEvQQi9StV8KrpfYDP0g9SwuveGvSl4ET
	 f25OfnK9mZCnd/UHKINhHD1nRg2Av2YdnejgbzV/0EV+ZeOwp2Wp4xvSsxEYzu9MBG
	 xcUUKQ48du33xkIbmuPOROximUgAy5M63ZUfaHMswyxtpQqWLPh3a8IixO23mtnWQL
	 qADtGryhSFhdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD45380AC00;
	Tue, 29 Oct 2024 23:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] socket: Print pf->create() when it does not clear
 sock->sk on failure.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173024583374.858719.8851339668616193735.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 23:50:33 +0000
References: <20241024201458.49412-1-kuniyu@amazon.com>
In-Reply-To: <20241024201458.49412-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ignat@cloudflare.com, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Oct 2024 13:14:58 -0700 you wrote:
> I suggested to put DEBUG_NET_WARN_ON_ONCE() in __sock_create() to
> catch possible use-after-free.
> 
> But the warning itself was not useful because our interest is in
> the callee than the caller.
> 
> Let's define DEBUG_NET_WARN_ONCE() and print the name of pf->create()
> and the socket identifier.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] socket: Print pf->create() when it does not clear sock->sk on failure.
    https://git.kernel.org/netdev/net-next/c/4bbd360a5084

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



