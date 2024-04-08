Return-Path: <netdev+bounces-85761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A166489BFC5
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429381F2326E
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A27A7D3F8;
	Mon,  8 Apr 2024 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJm6G0i9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E9F7CF29;
	Mon,  8 Apr 2024 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581228; cv=none; b=F89Lc2NpreSxZ4wtN3yUud3as+O4l3Q1XqzNhohzQ6nGiOj776q7uGsM44i4mvzNLlFAdxFYa6gziHqtIl8E+AFDIMZL0kZMzGGRZ4da2/ud0CX01Jx94Jn7N4MI7/f9vvvdAh1z1q995t7bArpMTvm8BdN7N/miRlp3UGwhAvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581228; c=relaxed/simple;
	bh=SKmIkCuasOmtGJF2nICPyAm5mULG4Q7bUsyMXCdFlb0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MugC8HKfPzEGJO7LtBHFJrgKS6rUM+rOKtAZ17Xhkh/9ulFNfpnl+VsXr7C9GhXwdcE85fbrvzQ/mFcjxAwZfdNH459L4G8ZsVGlFeqG5k5tCWMtT26NZ3MuPEKC/4vCBCCtKK9+BTsLX0NaFF3+kJiELYUauDL1kQQpW4INDbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJm6G0i9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D530C433A6;
	Mon,  8 Apr 2024 13:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712581228;
	bh=SKmIkCuasOmtGJF2nICPyAm5mULG4Q7bUsyMXCdFlb0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NJm6G0i9sZk5lxrRxqDJK4K1dka3lgf31PO44tIglEge4ShH1f2Pw6bJgonptaPp6
	 HHs55XoTlmYZq9i2qfz/FmPFbVX2NZIDXYxESG5BgFl5bAfi6X3Oo+6AMCNtVsRoEH
	 ZIDCIBz9koOqsG8iukVdZNEniRhbp0s74ro/bMpJS48w/7E2zDgdGccJ0c4c6cN9Wk
	 o4FRgQ5kIS9T+KFqtKdDo1fHJf926pDbW/T/ds14ZSiqjqrGeu2lRJGXWEbWXhHrIv
	 JoqHVZoJzEyFpsDH71LFz6ICt7j8Rk0EY11xac0108N9TtYHVRP7u9TleduP6vjHaS
	 SpRjnoDo2Yjxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 024DBC54BD6;
	Mon,  8 Apr 2024 13:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] mptcp: add reset reason options in some places
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171258122800.2224.8882516894860681833.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 13:00:28 +0000
References: <20240406014848.71739-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240406014848.71739-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
 kernelxing@tencent.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat,  6 Apr 2024 09:48:48 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The reason codes are handled in two ways nowadays (quoting Mat Martineau):
> 1. Sending in the MPTCP option on RST packets when there is no subflow
> context available (these use subflow_add_reset_reason() and directly call
> a TCP-level send_reset function)
> 2. The "normal" way via subflow->reset_reason. This will propagate to both
> the outgoing reset packet and to a local path manager process via netlink
> in mptcp_event_sub_closed()
> 
> [...]

Here is the summary with links:
  - [net-next,v2] mptcp: add reset reason options in some places
    https://git.kernel.org/netdev/net-next/c/382c60019ee7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



