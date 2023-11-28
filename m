Return-Path: <netdev+bounces-51622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A58357FB67D
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FCAB2825EC
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 10:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F149C4C3A6;
	Tue, 28 Nov 2023 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIj3796d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D433A883E
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 10:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C361C433C9;
	Tue, 28 Nov 2023 10:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701165624;
	bh=NsbL4HYOozvRUMI4yuxv4Ey5+n2/HiIxbM5udGAy0G4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kIj3796dvOVWLt/qfCo2ZnjGWRISk9idwyOE9Ko9gnepEsxIFsE/AgqRKBQtoEwrX
	 aHm2oeBeM1P+xfLgIe6QMOVV7q2AsTK8mT31mcNKeeKJ4EqeeBw2hUD8s9MWFPB+z3
	 dT9AA51ajuiLWEUUpFlgDRHlWav/x6pzeHfo9S+vpRnCA6ERJkkB9aOno8S+2Fxj4c
	 uDWcp5WcU3u5RZae/jUIxCzRoRxvv22hIajrxJGRjxdLSCFK0cikJ6Vp3hCXhg1A2V
	 xg7HHo+YiOVMCxZOslrUdJ3mIO9y8Zu4hFywOlxfAgR0ETgoKjkSPf7J5LtWaOyWhB
	 2mkb3TJNXUVLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F196C39562;
	Tue, 28 Nov 2023 10:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: Fix possible buffer overflow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170116562425.31333.11843125198692560702.git-patchwork-notify@kernel.org>
Date: Tue, 28 Nov 2023 10:00:24 +0000
References: <20231124210802.109763-1-elena.salomatkina.cmc@gmail.com>
In-Reply-To: <20231124210802.109763-1-elena.salomatkina.cmc@gmail.com>
To: Elena Salomatkina <elena.salomatkina.cmc@gmail.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 25 Nov 2023 00:08:02 +0300 you wrote:
> A loop in rvu_mbox_handler_nix_bandprof_free() contains
> a break if (idx == MAX_BANDPROF_PER_PFFUNC),
> but if idx may reach MAX_BANDPROF_PER_PFFUNC
> buffer '(*req->prof_idx)[layer]' overflow happens before that check.
> 
> The patch moves the break to the
> beginning of the loop.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Fix possible buffer overflow
    https://git.kernel.org/netdev/net/c/ad31c629ca3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



