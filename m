Return-Path: <netdev+bounces-206938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32552B04D0E
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 02:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F1C57A4D18
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B12E1A08B8;
	Tue, 15 Jul 2025 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhzDMFyM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D561922C0;
	Tue, 15 Jul 2025 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752539997; cv=none; b=jNHc7YtKID+1H5PGXGPydrgoaLmKg+kiOLb7tWFgq/Ba3daGMgVsZn7zzxG61gprZhi3+Cps4Vqw432q4+p5XOn6N3sBNqOzpj3VD5WVlWVXbaSKdl4LM1s67dXZv/pP6nQD5afZ/cBIL3QnKcAgKf3X1xPoWFFr/8uy9jd4hVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752539997; c=relaxed/simple;
	bh=nnnDx+Bdzb2hLfPDR6Ot67iq2A547Q7/sYTemYUEt7A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RWhxRi+jLppsQekLEsNU7jj5plPlS0efGORWiFqXvCILHM6D4eAhDDFdzhY+56HnzbtI2/vUO+hdJId93o6DhvDxjC/vs0PlVy8So94hiIjSfX59Wq+oqdTApCeWFdirzuN8C0QnWHZaAxBAdjc4/P4SHZigY0nsJCYilm/rZS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhzDMFyM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D9EC4CEED;
	Tue, 15 Jul 2025 00:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752539996;
	bh=nnnDx+Bdzb2hLfPDR6Ot67iq2A547Q7/sYTemYUEt7A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mhzDMFyMxRJoHA2RzKFH3H2XeqCz2hhYpq0NQZK5HKFnbet49mxOEmSl200i4fqke
	 uXlH0hqJ5IyaC2XYwwEOTZVEYVfplgRFvsWkZYgjEtQeTOD7IZh6/rpqVaCMLuAp/S
	 yG4+VYlcwBC6H1gobZegXWwAHj/xE3FCfSqf2maWUPPZmGfezktxKBGMni6mXeDq9+
	 2qvBdtJDEbbw/i1E6/0yV+aQ9JCwnxdmt8jiRd6Ireyd39ALnfdVl7klu/F+8lOsF7
	 46BnGfTyhRxecJE0Jdp3qiSvvleY6F8YUlpwt8bZFGEAAwKRm6TzzkBqjED39iKbO5
	 PrXfLj44TEzFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE66383B276;
	Tue, 15 Jul 2025 00:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] netdevsim: implement peer queue flow control
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175254001752.4040142.18398064208547773786.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 00:40:17 +0000
References: <20250711-netdev_flow_control-v3-1-aa1d5a155762@debian.org>
In-Reply-To: <20250711-netdev_flow_control-v3-1-aa1d5a155762@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dw@davidwei.uk, kernel-team@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Jul 2025 10:06:59 -0700 you wrote:
> Add flow control mechanism between paired netdevsim devices to stop the
> TX queue during high traffic scenarios. When a receive queue becomes
> congested (approaching NSIM_RING_SIZE limit), the corresponding transmit
> queue on the peer device is stopped using netif_subqueue_try_stop().
> 
> Once the receive queue has sufficient capacity again, the peer's
> transmit queue is resumed with netif_tx_wake_queue().
> 
> [...]

Here is the summary with links:
  - [net-next,v3] netdevsim: implement peer queue flow control
    https://git.kernel.org/netdev/net-next/c/ff2ac4df58ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



