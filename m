Return-Path: <netdev+bounces-231035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D1CBF4227
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 02:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02E23A756C
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 00:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300B31D61B7;
	Tue, 21 Oct 2025 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYtLSjvR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A96D1D516C
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761006029; cv=none; b=jcHGxr/mHBPPNOmY96DPa7gA098bbH1FyflHz7lEI+EFGMA1aSRBP/q1yuqdNkPFQLiBAD7YPW2KIzz91BS5weiJnuxNXnOgLkTLKQTa34VMy7AhbDdUDbt1C+mGqKf3PGDhhYifN6WoJOvTDkgjXSlHmULCS4rbeIWVH3w+nPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761006029; c=relaxed/simple;
	bh=Oa7At8X5LE6w8IU0m/Q9FZ7Leu/pA13E/x0qrgCgKF4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GhJ01bLv9/eUk0sBg7T+iIQUfqBgl3e5/2c2bJZaemeainlNC7HB9VgPAd+tNJtBDqP23mk7HxSwP5DFTIwnTzV0M3euWW0FfTRF/hnTEy2Oh2PDI5BsLk2dGds55WXuhF6KYjqYJdquJ7vYOATI4DQQ/Dvx3AkCqJueJxVB+uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYtLSjvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D643AC4CEFB;
	Tue, 21 Oct 2025 00:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761006028;
	bh=Oa7At8X5LE6w8IU0m/Q9FZ7Leu/pA13E/x0qrgCgKF4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HYtLSjvRGnqnDfgIz4kFM7kXk/XW876cAgsRbSbKKscFabzpHmVpd1KvYzHyJDgiZ
	 8nGsWjxmSM2fKaRDjoxBvipNrhWycFoadVMmhE1xl6hBlxgiCvGLh7eNIGF1RAbD9Z
	 Ip/Q+dri8K77rY3So1AW7zQ9DmvMov0vZiIhl/wY2E7UJyJaiRXEcRh6FjpGkUyX7f
	 lKO6zwzNqkpZQmGiPhLSmhyoCOJuv/Qzke+6+G2NvTOdlpnrwZvXyXvtxBCd8xcPAU
	 F1N298DDcTMajkkxtPbkQZR9jCc5qT2pUAxaDRTKRthJ3IzRWqb9KWE9KNmRcLaK68
	 1men6IPA7bPww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD803A4102D;
	Tue, 21 Oct 2025 00:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: add a fast path in __netif_schedule()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176100601050.466834.13455934247208426317.git-patchwork-notify@kernel.org>
Date: Tue, 21 Oct 2025 00:20:10 +0000
References: <20251017145334.3016097-1-edumazet@google.com>
In-Reply-To: <20251017145334.3016097-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 kuniyu@google.com, willemb@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Oct 2025 14:53:34 +0000 you wrote:
> Cpus serving NIC interrupts and specifically TX completions are often
> trapped in also restarting a busy qdisc (because qdisc was stopped by BQL
> or the driver's own flow control).
> 
> When they call netdev_tx_completed_queue() or netif_tx_wake_queue(),
> they call __netif_schedule() so that the queue can be run
> later from net_tx_action() (involving NET_TX_SOFTIRQ)
> 
> [...]

Here is the summary with links:
  - [net-next] net: add a fast path in __netif_schedule()
    https://git.kernel.org/netdev/net-next/c/f8a55d5e71e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



