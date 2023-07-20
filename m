Return-Path: <netdev+bounces-19332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B71E75A4F3
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 06:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBD61C212B6
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 04:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F283D60;
	Thu, 20 Jul 2023 04:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B911317EA;
	Thu, 20 Jul 2023 04:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 285EFC433C8;
	Thu, 20 Jul 2023 04:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689825622;
	bh=WW61fEJn5ley9K1VeZE4qAk6gC7/D9WN6n2QMTISo2g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KTGTYZoyh9kkafvx22Qw427otTcIOaectoEDbiZ2/mYm0sPOlXxJG5vANVMpoqr8s
	 Z/UjtLwfkJskzJy6gy1OWJzgRZmdp4PT+hVkkuRAja1HAxiuc1Tm0BNNYKU3WVzHOo
	 aNf4MalOznHSDao2pNIYBCUuXHOseG5YvbFPiHH7ADowczq3U1UyzmLdTdNSWTV45G
	 ZKybTABsCKsYcSLjE5M25ra3D+tLZHmCKXT+8GJdHvZpxyb1/blb7ZS4/5uNNJwj5Z
	 JkAOmG62hmAwhQDGhLw0qUIa7CKB94kJR8/eIn7dlvK/spCDJMj2ZL8HRTO77IfvKE
	 4ncWc1uPV2LIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 025C2E22AE2;
	Thu, 20 Jul 2023 04:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] net: stmmac: improve driver statistics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168982562200.4243.13225573648147427598.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jul 2023 04:00:22 +0000
References: <20230717160630.1892-1-jszhang@kernel.org>
In-Reply-To: <20230717160630.1892-1-jszhang@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com, wens@csie.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jul 2023 00:06:28 +0800 you wrote:
> improve the stmmac driver statistics:
> 
> 1. don't clear network driver statistics in .ndo_close() and
> .ndo_open() cycle
> 2. avoid some network driver statistics overflow on 32 bit platforms
> 3. use per-queue statistics where necessary to remove frequent
> cacheline ping pongs.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] net: stmmac: don't clear network statistics in .ndo_open()
    https://git.kernel.org/netdev/net-next/c/2eb85b750512
  - [net-next,v5,2/2] net: stmmac: use per-queue 64 bit statistics where necessary
    https://git.kernel.org/netdev/net-next/c/133466c3bbe1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



