Return-Path: <netdev+bounces-236930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3BFC42484
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 03:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA9D188D753
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 02:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29890272816;
	Sat,  8 Nov 2025 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFiFAVn2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045761FECD4
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762568442; cv=none; b=F94idReMbODS/8n9H3Egkr0mXGje/iLPs7Kkk5MYuNxrf9nMutEDeXLYGG7weRtCjfha3InqwsTRaH8oa1NZqBfhwgkhvhmYdFpBI+lYV+9VmZiQu/a3hhj7v+oZKApEo8ASvjBvmcdhQI54trKkdZITdwW2pufRHrB/n3QcHEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762568442; c=relaxed/simple;
	bh=2EWQylWi6y/SRWvRHIdj75snDRhjl9Pnbx8QbMn69S4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Iq+6ma5z6edbl6P8fdoSXlNpHOC+GVY0g6AXllhzpln9gUX62EJKJiiog8Rot2d4BHp78/w9kKTTkry/6dX5c8ExS5R6+jqGp8LiUEqQ3CsJXErAFeifpDi8DV9ncgbzWQaFWBHu8C0MQp0lp1mL0oCRrV7YHN4kI5WJpAnKP3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFiFAVn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A41C113D0;
	Sat,  8 Nov 2025 02:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762568441;
	bh=2EWQylWi6y/SRWvRHIdj75snDRhjl9Pnbx8QbMn69S4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qFiFAVn23VO4hqgaZSgMgTlwOKaPqbk6UkuFwck9ce471H4iGBedqgfsJVaz13PV6
	 QxMEo1UtqulAcvr0otJc5iCl1Z9jJ2nRyoUqZgO6kB2SKX4aNsCd7LzDQcybBq9mFv
	 3Uc/rDNwC4w4QBH0L2tfZuXr+JfAd+m2lpBlnM1mlw9Ybqy1PlKqafatlpqRQkJ+Yw
	 5NIYXxgNKStzhq+VNsJsXh5IG7ImKkonsdykB3E9blPIr4fgu4HUoT2PKV486Z5dYq
	 HlkQ7TXU860MyVA4O1+r9s8gl52IKqRY/fetvbQYiwRrfcn7Rs/nSTaY/cNV+MAuoZ
	 MGvixVmlrbjNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DD03A40FCA;
	Sat,  8 Nov 2025 02:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/6] tcp: Clean up SYN+ACK RTO code and apply
 max
 RTO.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176256841400.1224950.9201486523791396252.git-patchwork-notify@kernel.org>
Date: Sat, 08 Nov 2025 02:20:14 +0000
References: <20251106003357.273403-1-kuniyu@google.com>
In-Reply-To: <20251106003357.273403-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ycheng@google.com,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Nov 2025 00:32:39 +0000 you wrote:
> Patch 1 - 4 are misc cleanup.
> 
> Patch 5 applies max RTO to non-TFO SYN+ACK.
> 
> Patch 6 adds a test for max RTO of SYN+ACK.
> 
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/6] tcp: Call tcp_syn_ack_timeout() directly.
    https://git.kernel.org/netdev/net-next/c/be88c549e9d7
  - [v1,net-next,2/6] tcp: Remove timeout arg from reqsk_queue_hash_req().
    https://git.kernel.org/netdev/net-next/c/3ce5dd8161ec
  - [v1,net-next,3/6] tcp: Remove redundant init for req->num_timeout.
    https://git.kernel.org/netdev/net-next/c/6fbf648d5cc4
  - [v1,net-next,4/6] tcp: Remove timeout arg from reqsk_timeout().
    https://git.kernel.org/netdev/net-next/c/207ce0f6bc13
  - [v1,net-next,5/6] tcp: Apply max RTO to non-TFO SYN+ACK.
    https://git.kernel.org/netdev/net-next/c/1e9d3005e02c
  - [v1,net-next,6/6] selftest: packetdrill: Add max RTO test for SYN+ACK.
    https://git.kernel.org/netdev/net-next/c/ffc56c90819e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



