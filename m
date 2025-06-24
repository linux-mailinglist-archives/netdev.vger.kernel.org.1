Return-Path: <netdev+bounces-200537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C04AE5F56
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2353BA95B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 08:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A03625A354;
	Tue, 24 Jun 2025 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmUfvecG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75487258CE7
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753784; cv=none; b=KUR6yDdAJd2GGPnEt0vMXe0TKDjAjFaOqpAfbtSUnXmdyUfWwrxpF80yZ3F1mE4R3zJ71NMQ+CTP7hGv/Vl5KlQNT1OHsUarlNMLkRolqCcssVfTi4pI+zYY0iPIlRZpf16Cdxu4gPb87gHLvh/UEQO/vGkZMkLN/8V2CrSJgww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753784; c=relaxed/simple;
	bh=kg1ZbTX6+QBvNMo0yo+Uim5yoqskLKpcS7uX86rSodA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sPLMBBhXHqDkNjSm1d0yOrsYyBr2Nq2Aeul9I2XGw0xTzCMUV2rfG5e+SrQjUV+RTsjIOntaLxxajmM3e/G5oOwHXmqAYydysbl6JfA3bSGDXmG2NHiNy1tqSy2zp17qec7WDa3T0o9Fr9IVyalM0xX3Yu047UB0H1Zcj7w6dUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmUfvecG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2EEC4CEF3;
	Tue, 24 Jun 2025 08:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750753784;
	bh=kg1ZbTX6+QBvNMo0yo+Uim5yoqskLKpcS7uX86rSodA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SmUfvecGxiN7urufbEpMvt7fz6sOMBGIjlRsA7/IJm84DfmpLMShaZScrsoBwdFYP
	 hx9t87XSbm7IZ7Tbx2jLltfD7xbo38ARACwz9PpWk9dtXdvh+x09STip+vh2NT/l7V
	 UNAPoNJOHGD6U8qBfSBNevjwIFVUua/QnGxjdSr4THGHTnL9l2NrXrygZTIcbIfjcL
	 NMsq2oL+q6mQqSBUaK8IVf7izxhBSlyc8ldBCmBDZSaMtGZCPok//eX4yF+gKD31Ot
	 8GofFS7GSuSwCgDRYH2bQUyHjVHtvGgQ+P5aJgrOVshuixtyVyDxQHKvLli3RWnjh7
	 bZw9lkzndkz3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F9438111DD;
	Tue, 24 Jun 2025 08:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/4] af_unix: Fix two OOB issues.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175075381100.3450670.13737310661356171408.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jun 2025 08:30:11 +0000
References: <20250619041457.1132791-1-kuni1840@gmail.com>
In-Reply-To: <20250619041457.1132791-1-kuni1840@gmail.com>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, rao.shoaib@oracle.com,
 kuniyu@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 18 Jun 2025 21:13:54 -0700 you wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
> 
> Recently, two issues are reported regarding MSG_OOB.
> 
> Patch 1 fixes issues that happen when multiple consumed OOB
> skbs are placed consecutively in the recv queue.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/4] af_unix: Don't leave consecutive consumed OOB skbs.
    https://git.kernel.org/netdev/net/c/32ca245464e1
  - [v2,net,2/4] af_unix: Add test for consecutive consumed OOB.
    https://git.kernel.org/netdev/net/c/e1ca44e85f65
  - [v2,net,3/4] af_unix: Don't set -ECONNRESET for consumed OOB skb.
    https://git.kernel.org/netdev/net/c/2a5a4841846b
  - [v2,net,4/4] selftest: af_unix: Add tests for -ECONNRESET.
    https://git.kernel.org/netdev/net/c/632f55fa60c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



