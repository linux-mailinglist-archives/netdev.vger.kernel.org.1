Return-Path: <netdev+bounces-199221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BEDADF7B0
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AED17790C
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 20:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1D71D63C2;
	Wed, 18 Jun 2025 20:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K96cTTjd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D09121C17D
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750278595; cv=none; b=jYxnlBUTVdY7pMb8eRuo7+a0CqTZVVX49r7W70+Tf+KLs1Svz/140eOBaQwBT9tjbSd7buCmMSa9Ezvq16TmyLXYifpxwAH2QrNUF7TR3lMcxoxZav64bUHwsjHlFn2qUYZmgK/fIOZpCNeRW9ooYmzM5ylmgNCHQOjXwkiy+WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750278595; c=relaxed/simple;
	bh=GPiJq6EIs3EurNaCXhqyBPJfW4n3klyTEaZ1sxjArRU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KVSk39DLI03SwgFaYd+lmXsDGtvw9XRDtmWbwF/j8P5ALGZHCrjz8DQGGsjPmFaEvfwtPuJrkNNpQo8hFSyNS3RybASE3zZ2zqs3wjRfDocHocW9ElevrAtKsNM3qsJ5+iPzgsc9vdAzKg9n1P/NcTuaIH5otbSod1E22jl4JGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K96cTTjd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A5FC4CEE7;
	Wed, 18 Jun 2025 20:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750278594;
	bh=GPiJq6EIs3EurNaCXhqyBPJfW4n3klyTEaZ1sxjArRU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K96cTTjdMja7MIwbbg8lK165OSTxE4yj4D40w5QXxToC1BCypIwXe2MUuSPYMCOsO
	 NffdcKcnkDXfQMPbsZwNZ4/OcrDPXVGYjgNjJSzJywp2clsDkjqK8+2Mepu3YqKIP/
	 SWJ+9Onc3xc7jl+GgIONqpE1yjbJpqk2KZIcF/41g6FU+oqlM7u52TZQkCh73Est5q
	 U2HRARP/5meqwEz7+B8TA6QkoU30YQdWhWR69Fg/G6C4iEpYx29QBv1EJIR4QhirqJ
	 zYnotXaiBQYVTpnrqDcGgheGsQxyy+RcRZjvZdaI+8y8gzCh9BNC/GGueByIu6u7Uk
	 IplTVGcOyQx1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B433806649;
	Wed, 18 Jun 2025 20:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] eth: migrate some drivers to new RXFH
 callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175027862274.246778.380508616545971353.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 20:30:22 +0000
References: <20250617014555.434790-1-kuba@kernel.org>
In-Reply-To: <20250617014555.434790-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shayagr@amazon.com, akiyano@amazon.com, darinzon@amazon.com,
 skalluru@marvell.com, manishc@marvell.com, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, bbhushan2@marvell.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Jun 2025 18:45:50 -0700 you wrote:
> Migrate a batch of drivers to the recently added dedicated
> .get_rxfh_fields and .set_rxfh_fields ethtool callbacks.
> 
> Jakub Kicinski (5):
>   eth: bnx2x: migrate to new RXFH callbacks
>   eth: bnxt: migrate to new RXFH callbacks
>   eth: ena: migrate to new RXFH callbacks
>   eth: thunder: migrate to new RXFH callbacks
>   eth: otx2: migrate to new RXFH callbacks
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] eth: bnx2x: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/f1a6fcc454dd
  - [net-next,2/5] eth: bnxt: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/82113468a088
  - [net-next,3/5] eth: ena: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/e7860a6e1826
  - [net-next,4/5] eth: thunder: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/e8b87384391b
  - [net-next,5/5] eth: otx2: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/f99ff3c2a328

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



