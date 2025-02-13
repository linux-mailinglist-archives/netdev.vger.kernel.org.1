Return-Path: <netdev+bounces-165810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7CDA336B1
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 05:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F3D188C9A9
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B6E2066D1;
	Thu, 13 Feb 2025 04:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXK+AcgH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25810207670
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 04:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419813; cv=none; b=dBPI5I9YNSd0VQi6NEE3f7OxcFJhVUWKh87Ex+iKDPZK0n61XLALpKH9OjHgIrSN6Z4vUrOd2Yz/ngizx35B10+5053E9Z53QWbwhpN5EYgKEegKwSLWBFDAACZCqqf62drQt/m9yMOvsBrMmV2D76k8voYc0p883eGP/NgfX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419813; c=relaxed/simple;
	bh=LIrqkGuTX3sYA4yBsXtfyIW8dQhWiFELckp1JVT151c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H4lHSPdpemo9gE2nXfdftQ+mQwotuWL69kD8S/2HULs6tXJT3kykdYK0YLr9SYAgAgab5hLSxZqJ2R+Yu5AQELFySnE8brSW+NGSyPmSXtF7E68tYekpnU4dNceg3lXQwyxBxfLr9Nc6Bnk3wFYEwPuTsyyM3AhL9S/2vsOjo14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXK+AcgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98270C4CED1;
	Thu, 13 Feb 2025 04:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739419812;
	bh=LIrqkGuTX3sYA4yBsXtfyIW8dQhWiFELckp1JVT151c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EXK+AcgHmCxyA5l+XQkuFJUqLZ0zy+SMKJYXuWULgV6wr2wYPwSzVp7PadkMsOxbM
	 lkvAhG9djKCy9MYrK3jZnUOTtD86WMWzpUcTpCCi/ELL+Jdxq6XP0uHOzEQkoBAikn
	 4OQNwkXwDQpmDtP+6X9kpMF2/vPUM+8UjRZRpzsoQAzUOIAX26P8eawT53v5xNNPE6
	 Px4RR6vXGE2t1u4ruJb0QS9kOkQsOuBS2I2oC9w+79jSx1uOuzBrCkxGRtnHNoE/mh
	 AahkaffoXPqHCKH5lVXCQV9twpknSU/Gw+7WAeiwc9jPCDx8YRs3Hd5T0DwxB5LN6M
	 o6JCSaKLRfKSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAED4380CEDC;
	Thu, 13 Feb 2025 04:10:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: avoid unconditionally touching sk_tsflags on RX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173941984155.756055.1106706415523373627.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 04:10:41 +0000
References: <dbd18c8a1171549f8249ac5a8b30b1b5ec88a425.1739294057.git.pabeni@redhat.com>
In-Reply-To: <dbd18c8a1171549f8249ac5a8b30b1b5ec88a425.1739294057.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuniyu@amazon.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Feb 2025 18:17:31 +0100 you wrote:
> After commit 5d4cc87414c5 ("net: reorganize "struct sock" fields"),
> the sk_tsflags field shares the same cacheline with sk_forward_alloc.
> 
> The UDP protocol does not acquire the sock lock in the RX path;
> forward allocations are protected via the receive queue spinlock;
> additionally udp_recvmsg() calls sock_recv_cmsgs() unconditionally
> touching sk_tsflags on each packet reception.
> 
> [...]

Here is the summary with links:
  - [net-next] net: avoid unconditionally touching sk_tsflags on RX
    https://git.kernel.org/netdev/net-next/c/f0e70409b7eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



