Return-Path: <netdev+bounces-122071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA1F95FCCC
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BCD1F24D75
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1D419DF46;
	Mon, 26 Aug 2024 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBBBi/Z9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29455199392
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711430; cv=none; b=foagi0cMan2nBa+brrfuCeMPFt4t+zj+4bt7g7HImJp2jyBWBqgmFrOE/RqJx6xqd5nPCrTjbILUE3mmVrUZ5jE2SQ+bnRcQ47IieFoNDJjGGBcnubr5Frnq74QhGIHaf9tckeFOGPIAWi/F3qz+s3MU89sytaa4I8mmFS7JlFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711430; c=relaxed/simple;
	bh=sXTYQaR4PhsE+RmLxrmoNnU9JT2ZvcuuWrh7RG+Ij8Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oMGpufUujhFUDSLed72ZmolIGFQAx5qX3Du8gDTxEl4qxCy9eYdOghBVTgQU4Cls1KiZEXUXD4kihHvGy+DmPcc46SmdMcWAVTn7MPTiCw8RVqKfABWWJtuLkTwleE3mbwPuOjj3bTHBo0KLZUGyLxDQzmuS7tvBCSUC/Ro3hb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBBBi/Z9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33B8C8B7D9;
	Mon, 26 Aug 2024 22:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724711429;
	bh=sXTYQaR4PhsE+RmLxrmoNnU9JT2ZvcuuWrh7RG+Ij8Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EBBBi/Z9euRCPTHIsw9rTuZprGqzO3h0Jddh8EZIo8LlIMdqixfrW/I4MKNWOJ6P0
	 o/Pr8g6b00+6eBo3sfGjVUjYnlC0CQ6FJohW2ZGjXFSRM2kqZhaAVMqV6S3Fkx4gBV
	 3Tpc03vACTbJLU87qwEBYs5vpcpacKKxU8dJhyJbFql1v73E0KCsmHSda6BGMCZfdZ
	 e30YKS8q+kveTl1115KplUnuAhgAbLYlSVTazIRLhQsELuBUWx6C/GWVSLSmO458G5
	 RCJO/8asxrPkPBSAH0yCVTHlcU9ZXxi9c5IEL3b45Q0VpT2OtbbBCX7I5yHZmzbeYP
	 0kpjbFIPZiFZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2EB3806651;
	Mon, 26 Aug 2024 22:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: avoid indirect calls for SOL_IP socket options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172471142948.144512.543299330759320070.git-patchwork-notify@kernel.org>
Date: Mon, 26 Aug 2024 22:30:29 +0000
References: <20240823140019.3727643-1-edumazet@google.com>
In-Reply-To: <20240823140019.3727643-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Aug 2024 14:00:19 +0000 you wrote:
> ipv6_setsockopt() can directly call ip_setsockopt()
> instead of going through udp_prot.setsockopt()
> 
> ipv6_getsockopt() can directly call ip_getsockopt()
> instead of going through udp_prot.getsockopt()
> 
> These indirections predate git history, not sure why they
> were there.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: avoid indirect calls for SOL_IP socket options
    https://git.kernel.org/netdev/net-next/c/89683b45f15c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



