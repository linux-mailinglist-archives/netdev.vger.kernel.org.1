Return-Path: <netdev+bounces-245374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C076ECCC720
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 16:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB26F30157C0
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9173570BF;
	Thu, 18 Dec 2025 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfxtlufk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469702798E8
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766071401; cv=none; b=GXmwlfFa+62Okw9YUjoohS2NQbkueYQspj5UoG/F6n0Z2A0NF+neQ1nYZT1iN6CXHEV9TMSSa/4Y/mjtj3AbGz+2mQz1ShMgy4D/SCOezclAf3J79+HHQI26Gt8gA+7pWJPLhNQDVvZnLjhvFf5rEiFh3FktV7IKdXTxeIPmnCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766071401; c=relaxed/simple;
	bh=ezCQh6K+FITn3hPbhyuoCzdHbf/06A1UQKyIJy0QHOA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RXPVT1N0dUCknjsCERQLRCwxwRSljV/A+pb6A+Ermrd/uBjFa4oRjgkKcWX8pJ2dp9MtKZxE63zsgbAwn0nVzTwaorhf5G5PwSHssSFcUupJpr9VyiEKfrbUYjn4RPQpJ8kp5kIUNcZIySfmamDMm43tuKKpttJhMrGkgqnxcN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfxtlufk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AD1C4CEFB;
	Thu, 18 Dec 2025 15:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766071400;
	bh=ezCQh6K+FITn3hPbhyuoCzdHbf/06A1UQKyIJy0QHOA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bfxtlufkvX9kyLJBUgKOH0GuJi80SWxBuKK+ZLf66s7f5EmOcsc90tcIxL4HytBr8
	 z5H+LeYJjXyrbBMeWuPPBg9ArF5E8PxYzFK+IlX2Ph6G4XBcoLoD85e0Db4VX60D88
	 YpSGKHxLP27G+VqVCrzWPF8EXhb8Rx/dNtS9X5FjolVPeEYW3h5tQxEpPRhSp8DLjF
	 Go4y7swFuqyPTd3LI50iIdc6evjkPSNveVew/vKwSzvRMIt1Km8xwZwwOatwIIGsH3
	 YN1KTw+3wC3D+XHFA+5ottP7YQr9BJVDYkP79905aXccLhg914H7Vb4PfDb7HsTLBz
	 l2X/zotsO+UHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B99F380A966;
	Thu, 18 Dec 2025 15:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] sctp: Fix two issues in sctp_clone_sock().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176607121001.3006526.7412778117771328500.git-patchwork-notify@kernel.org>
Date: Thu, 18 Dec 2025 15:20:10 +0000
References: <20251210081206.1141086-1-kuniyu@google.com>
In-Reply-To: <20251210081206.1141086-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 10 Dec 2025 08:11:11 +0000 you wrote:
> syzbot reported two issues in sctp_clone_sock().
> 
> This series fixes the issues.
> 
> 
> Changes:
>   v2:
>     Patch 2: Clear inet_opt instead of pktoptions and rxpmtu
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] sctp: Fetch inet6_sk() after setting ->pinet6 in sctp_clone_sock().
    https://git.kernel.org/netdev/net/c/b98f06f9a5d3
  - [v2,net,2/2] sctp: Clear inet_opt in sctp_v6_copy_ip_options().
    https://git.kernel.org/netdev/net/c/d7ff61e6f3ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



