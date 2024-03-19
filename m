Return-Path: <netdev+bounces-80548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E913E87FBD4
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 11:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 685CFB21F51
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 10:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC18822EE5;
	Tue, 19 Mar 2024 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXsuXzk0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D8F1E498
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710844247; cv=none; b=F79QH2/LGbB4bEYHZ5wVpNeTDFAu35ImO/mU4qsR2B7Vbb0VhDHZGgrInGuqWGq4vcRJEX0DM7FfZduSBwnooeo4S1g9q1oUioFvJCGQJdYludUdOIcj2vYtNcmkiPeeUvR135NRAIjgBT2pO92HUOEnd6bwTCoj0mHFt9Vop2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710844247; c=relaxed/simple;
	bh=2aMOppWXHr/rOduFsvsPxVeWiPCrBjpKgMNJd+4ftoI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c4X4U+BKQnhzzAYeadNRi92fjHGogNTpj/MuLM3razW+Ow4sJSCN4/Ia3YTA/MvOOnu6WaTv+/jZpeGuOD6x64iJsv3vdmMcTThQXIbUW5Ygtw4ZFtQ8Zg5YZ47UJhrZE5Cb3jyH7MMI0JKaKWIy1L/8fcW2iBHq4+KKNoyuy40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXsuXzk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C484C43394;
	Tue, 19 Mar 2024 10:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710844247;
	bh=2aMOppWXHr/rOduFsvsPxVeWiPCrBjpKgMNJd+4ftoI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WXsuXzk0RKQqDv5QMayt4X69+9e0maWIOchvAhO64fEGz7RgVTLHGf4EGsHRRXAKH
	 cIof6+9S8QHuvggt3YRRJOXWSVHCJPkAvdA30MUhxP7yzcOwtpHRGprP3iJhTQhOi4
	 LwzJf0hLynNPCK8Q/UarTod2D2Cq4nb+7Vuoh2P2z/IWTh3EygWTfSfWyefr0dnH4e
	 giJ2FIsNZcmWOOGnrjSuWP0QNnvp3Q7UCD4LNpn9qj9vGfja6L01/vvrLgwX7nSh4f
	 GHp/TkqIce5uVK+kRKcJFHLTKuP+g2A4tdnWyzgIKrT0d5mKZi1n1psQGokYR2BCur
	 ZwBcMnAnbELmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F589D84BA6;
	Tue, 19 Mar 2024 10:30:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: move dev->state into net_device_read_txrx group
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171084424719.5485.10120010385829581228.git-patchwork-notify@kernel.org>
Date: Tue, 19 Mar 2024 10:30:47 +0000
References: <20240314200845.3050179-1-edumazet@google.com>
In-Reply-To: <20240314200845.3050179-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, lixiaoyan@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 14 Mar 2024 20:08:45 +0000 you wrote:
> dev->state can be read in rx and tx fast paths.
> 
> netif_running() which needs dev->state is called from
> - enqueue_to_backlog() [RX path]
> - __dev_direct_xmit()  [TX path]
> 
> Fixes: 43a71cd66b9c ("net-device: reorganize net_device fast path variables")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Coco Li <lixiaoyan@google.com>
> 
> [...]

Here is the summary with links:
  - [net] net: move dev->state into net_device_read_txrx group
    https://git.kernel.org/netdev/net/c/f6e0a4984c2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



