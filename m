Return-Path: <netdev+bounces-65836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2246283BECE
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 11:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2582E1C24075
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 10:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6480B225A9;
	Thu, 25 Jan 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U78gzTlx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7FC21107;
	Thu, 25 Jan 2024 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178627; cv=none; b=MnIyZlPSMVbyDouJVMQei98lykI9DVwbbUqEr8Wl0B9poJWD+ASTByVDCQA8JgRECQP+KX8fJoIKjAWzC55k6gHi099utQwMd+WY0Uk05wnU6Ct0ZRpv2I+rPHUfB9IC8fiqhQW5vcNy1Tu3sXeqgJ3QSJKB5rHXtol96Huwnq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178627; c=relaxed/simple;
	bh=XO8vaeNEgihVisn6INHjnqkUkQ40ZirSC+GSeseScQY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lhHxb7cUTy9MMtLrg7Z+lJUKeMCPui4XmmsRKK5qcBKFpU0nUuWDee7Pj4w1YOWkkcMWU2a1WKYrQKBVMVOqaVg69+IKbwoeuq5VeO9qmYEkDr/wnGhiLcJy0i7LyXGbV6uauERVcrTq3ah8lnKNixO3DR1Fav1DGlqEKvPDdpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U78gzTlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D056C43390;
	Thu, 25 Jan 2024 10:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706178626;
	bh=XO8vaeNEgihVisn6INHjnqkUkQ40ZirSC+GSeseScQY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U78gzTlxKvVc4YhV2Tz21X2lLAbfD0u9XVq38pBFajNljJDvsyJeDgU7Ho5YPqYd7
	 w76Cf3leA3EpwAGa19XzwGW/bl4jFaY6/3UY7HIzIGmmt2CZ3z11S8NczGWaQXC/xK
	 4NUImvQS6HKtV9U91MQot0iGDAy6NzxrFjPLB1UseI24YWoDETcUJAHqkUgnFS5lNA
	 /Wl4Fajh3/kuZsGUhZbnoVCFN8dZ3cpBWAxyffGIaSjSDsDjYpnXqZ/7adg2gOwlCK
	 QwuBRVLq4T8ReERMZKWRGCAYEhK2f//ai2TFjvjrVwllbNb0ed4R5K47DCMPl2cG97
	 lCqlxYUJzfVkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 869E0D8C961;
	Thu, 25 Jan 2024 10:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fec: fix the unhandled context fault from smmu
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170617862654.17143.210781888782424416.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 10:30:26 +0000
References: <20240123165141.2008104-1-shenwei.wang@nxp.com>
In-Reply-To: <20240123165141.2008104-1-shenwei.wang@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: wei.fang@nxp.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, xiaoning.wang@nxp.com, linux-imx@nxp.com,
 rmk+kernel@arm.linux.org.uk, B38611@freescale.com, netdev@vger.kernel.org,
 imx@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 23 Jan 2024 10:51:41 -0600 you wrote:
> When repeatedly changing the interface link speed using the command below:
> 
> ethtool -s eth0 speed 100 duplex full
> ethtool -s eth0 speed 1000 duplex full
> 
> The following errors may sometimes be reported by the ARM SMMU driver:
> 
> [...]

Here is the summary with links:
  - [net] net: fec: fix the unhandled context fault from smmu
    https://git.kernel.org/netdev/net/c/5e3448077350

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



