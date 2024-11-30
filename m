Return-Path: <netdev+bounces-147936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A8C9DF36A
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 22:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9541C162EA3
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 21:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A190E1B21BB;
	Sat, 30 Nov 2024 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLaKjJ3d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D73E1B0F0B
	for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733003420; cv=none; b=ryav0NYM8GBA6tSsM2GgcrDCGxRQYpU8jBOCQh5HVGerCnjQtoV2Lf0TmqfEDMGoee7coN7uOo0roijg9WXZ8vZLLF3gWNugCPtC8rQhLcHzOg6zMFrdZjJnBz5r38fqkNfF7wB6ooNVGPEDhmEpRoNiRu+rdJaUVrRS9q93DVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733003420; c=relaxed/simple;
	bh=iGE06+myJd5gti4uvAGMuPlHU+jBxyoiOb1hfNB5OpI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GJWJjTE22QIj0fQRh2V23fTDs68WuMkB7+3QG+f4VDENqnyTMitQsbqGl8LwpIKVDYQG5mmfoFYinJtZJGVLEi6/On+eS71vYztPO7KxG8Rge8ygU94gk6uihHU4O8FA4vbtGXpZ7HY+5f7MTKWA0VTQTd74cktZeQmBFlqUg8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLaKjJ3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE22EC4CECC;
	Sat, 30 Nov 2024 21:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733003418;
	bh=iGE06+myJd5gti4uvAGMuPlHU+jBxyoiOb1hfNB5OpI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SLaKjJ3das04/KfzxvoU2rJ7lehSrkEh9R1JciSr6Cgt0S+sXg4ROO8q536jxEpE7
	 A4Svwzzm6NVD6pcHMhPKrv+KyqxyGABXP9KQMNxn87Er+87Gfc08CfhJ+SHiXaqsBP
	 IpPNDEWFKE/re+Z7xAs3cdr2Uyij49P6QDoQHVmQvYnCbbiMiePUZjRPGfeA9jbK4Q
	 y71s0J7ioi4wx0S4tZo/iTS021N8sFoueiVZEpUJ12OWl0+nwbN66hj/soMJkXCVp5
	 Mt1abA42nsCoYtsUK/7e9vcQ/V3FjG1CX0O4uBcsMhQOIXHzWciFm8wp0WSrc39QnQ
	 t37keVmUz64Ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEFB380A944;
	Sat, 30 Nov 2024 21:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: populate XPS related fields of timewait sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173300343225.2487269.2261559398487646656.git-patchwork-notify@kernel.org>
Date: Sat, 30 Nov 2024 21:50:32 +0000
References: <20241125093039.3095790-1-edumazet@google.com>
In-Reply-To: <20241125093039.3095790-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+8b0959fc16551d55896b@syzkaller.appspotmail.com, kuniyu@amazon.com,
 brianvv@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Nov 2024 09:30:39 +0000 you wrote:
> syzbot reported that netdev_core_pick_tx() was reading an unitialized
> field [1].
> 
> This is indeed hapening for timewait sockets after recent commits.
> 
> We can copy the original established socket sk_tx_queue_mapping
> and sk_rx_queue_mapping fields, instead of adding more checks
> in fast paths.
> 
> [...]

Here is the summary with links:
  - [net] tcp: populate XPS related fields of timewait sockets
    https://git.kernel.org/netdev/net/c/0a4cc4accf00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



