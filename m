Return-Path: <netdev+bounces-213893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73125B2743C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2A05C78A9
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2DC13957E;
	Fri, 15 Aug 2025 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttth/RDT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D8C131E49;
	Fri, 15 Aug 2025 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755218997; cv=none; b=tpogaOwi5JGoH73MsdV8Nnp+xC7YbnUZ9VbYr1o+LienfuCZH2LUl7hdrYEHPi7jHidozs42/wqhbNfUEz82z0kj8GNr9mI0pTdW2hNLqG7qHCb/5qpJtVTX9GnLs8HL59Aoax5SNC3I61VxE1itjlzXOzNbOfQ9btC5KJtyW6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755218997; c=relaxed/simple;
	bh=eBjfGJFAIB9PNSuG226jlmZoI98zEZdasUPmN3XCETk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gqn9DTcPv1B3oarRZMO+HmQKES9M1kEOPzkfSw3KLxPPVumQ8fG8k7rDT8gSUIexTk1M+jysY7POB+nvAzD1KQK7hCung04eQDv2yaToS99eBLwlHJPoFJyXny9a7rp3A43iJNId8RNPIW0hKyq0SS9O0D90RQEfJXOV3ssfueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttth/RDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1F1C4CEED;
	Fri, 15 Aug 2025 00:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755218997;
	bh=eBjfGJFAIB9PNSuG226jlmZoI98zEZdasUPmN3XCETk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ttth/RDTtdSmxz2nATU/O9UwTv9OrskOMAnAvixmPgts/tgloNF0ZJjkPfwX+9M/6
	 DcopTv5J4Pn9CnOWr1qKO6YMgbDoBK20V4A+C5mcTJYfrKn+3IrPBfHyRG0ClnHA+t
	 WbcHNpjlFJZmC9eviHGZmW/G7N20ZSI/2p4xMwnLmkmQi0GRyuOHvVe/ixoQhpXXii
	 gMbz7/Qh++9s1kTHTNt2HnPD7gBo90HJb4m6VqVciJcoG8MvHXLYiCYRojQGpafzWI
	 G6UUS0va9Tct7vP7srXgW2iyQ9xrjAROa+WZE3VwdgXfvaZchXUtPGMMrKg07BfOER
	 Ur6/Ww7CIaQtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A518E39D0C3E;
	Fri, 15 Aug 2025 00:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V2] net: xilinx: axienet: Fix RX skb ring management
 in
 DMAengine mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175521900824.500228.10283078380078516780.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 00:50:08 +0000
References: <20250813135559.1555652-1-suraj.gupta2@amd.com>
In-Reply-To: <20250813135559.1555652-1-suraj.gupta2@amd.com>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 sean.anderson@linux.dev, radhey.shyam.pandey@amd.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, harini.katakam@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Aug 2025 19:25:59 +0530 you wrote:
> Submit multiple descriptors in axienet_rx_cb() to fill Rx skb ring. This
> ensures the ring "catches up" on previously missed allocations.
> 
> Increment Rx skb ring head pointer after BD is successfully allocated.
> Previously, head pointer was incremented before verifying if descriptor is
> successfully allocated and has valid entries, which could lead to ring
> state inconsistency if descriptor setup failed.
> 
> [...]

Here is the summary with links:
  - [net,V2] net: xilinx: axienet: Fix RX skb ring management in DMAengine mode
    https://git.kernel.org/netdev/net/c/fd980bf6e9cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



