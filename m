Return-Path: <netdev+bounces-165160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA29A30BBD
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 13:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A325D1885E03
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 12:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08FE20B812;
	Tue, 11 Feb 2025 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFRmP1cf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E95208989
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739277004; cv=none; b=tODGRQdoiICT2d8+wIkJiCrGiTo/oXFq4e7Q3PE3WjR419usc/cugCk7EUphDq+7bxON1+x1VEQRQXIPyR7QiWrRpMF0TKYkcX4iA/kXZdQ37hwm9nfDWsataKQvsd/ar0Y3l6PAiFftfhV/cT/RdIeYU/QoBrvqW0CyHo+UOzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739277004; c=relaxed/simple;
	bh=wlw3hDTBe+tG29rUS6cS1u1djOBypfIeHI+1p6WPEZQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wuq81ZM/53AAxUr5+BBW5so5jiWyA78bElFC2+Dim5T4OPIwkSYTJYv1oeKa080xK9cJ0TmdDLRU0GkZ0G5aKZHbHf1hhtSH0hLm5Ho5SEFSWjq/S4FfyQBNiSLm8G/Rr1AHdTRCT4PQIqHhjLM731/sQtAdb9heOcdU39UG/qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFRmP1cf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17762C4CEDD;
	Tue, 11 Feb 2025 12:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739277004;
	bh=wlw3hDTBe+tG29rUS6cS1u1djOBypfIeHI+1p6WPEZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kFRmP1cf2ldC9STSQf55dMv1V/bYXqyY8sBIGvQ/igHkRcwUAUPs6jDozqfYfsjWX
	 IvyNAOwkFnBYq8rYCVCj92DX5SUO9UHpBI/rPfADkbwTa6Abh/cG1Z95N4PqaAhDjj
	 ZREYR4QsrLw5ukPgVNDMYPebXNC7R3mzNvncZAhikOHBElsZstfpw3MAnyTLx6tOPD
	 qBX4SsAcvvnnwJzRnFPZJ4f/NbknlMR/DLGrvOsjN0t1tQPCyk2PxJktv4sD7mmq/H
	 UjcVBmfmHbpSxxTy2FXdfKenR6pb9yt3Pcyy9PfUZJEfcQFbsWxaXPSo+NpqoapvhS
	 wX9lp7Kh1yOpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0D5380AA7A;
	Tue, 11 Feb 2025 12:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] tcp: allow to reduce max RTO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173927703276.4031056.4714016654809718532.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 12:30:32 +0000
References: <20250207152830.2527578-1-edumazet@google.com>
In-Reply-To: <20250207152830.2527578-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, ncardwell@google.com, kuniyu@amazon.com,
 kernelxing@tencent.com, horms@kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  7 Feb 2025 15:28:25 +0000 you wrote:
> This is a followup of a discussion started 6 months ago
> by Jason Xing.
> 
> Some applications want to lower the time between each
> retransmit attempts.
> 
> TCP_KEEPINTVL and TCP_KEEPCNT socket options don't
> work around the issue.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] tcp: remove tcp_reset_xmit_timer() @max_when argument
    https://git.kernel.org/netdev/net-next/c/0fed463777b8
  - [net-next,2/5] tcp: add a @pace_delay parameter to tcp_reset_xmit_timer()
    https://git.kernel.org/netdev/net-next/c/7baa030155e8
  - [net-next,3/5] tcp: use tcp_reset_xmit_timer()
    https://git.kernel.org/netdev/net-next/c/48b69b4c7e5d
  - [net-next,4/5] tcp: add the ability to control max RTO
    https://git.kernel.org/netdev/net-next/c/54a378f43425
  - [net-next,5/5] tcp: add tcp_rto_max_ms sysctl
    https://git.kernel.org/netdev/net-next/c/1280c26228bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



