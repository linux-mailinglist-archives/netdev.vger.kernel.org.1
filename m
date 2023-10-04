Return-Path: <netdev+bounces-38125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D937B9843
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 50B2E281C41
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 22:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACFF2628A;
	Wed,  4 Oct 2023 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Viub2YgP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF10F10780
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 22:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 613A6C433C9;
	Wed,  4 Oct 2023 22:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696459225;
	bh=1/vNADmIrrdv8Ojld+/naMK6QXUgQVh29g62L7sRtcw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Viub2YgPCMsMejgCj7QL8CPNlTfmo94JXHdTNvxIzow6R21P4+2X47uy1+12RxGDe
	 nsXM/yBv5xU0NHvdb0T/X8466jA6Y8q6nGQdPCk5OFRREY4QzcACohuowGLYLy1rif
	 scJG7AkJdv4Iul69MhzMU7AE9EIooCdGZgvYxq67Aue3TCvYTaDpGb/skVP0i1jDm+
	 dMAKshQU+23nu5xCYgunta5BCri2UbAIVQGMOQgR89uNOek2nv/FScMko0Li89Ptcd
	 d+dCkdklrs5P6G6JBLzoRIV8PQ03VKFfYLvFv7FKK/mKa4bv5KiAjrM2L5VFRu/e43
	 RipUSjesB18Cg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47BC0C595D0;
	Wed,  4 Oct 2023 22:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 1/2] tcp: fix quick-ack counting to count actual ACKs
 of new data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169645922528.13304.15866636062707945532.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 22:40:25 +0000
References: <20231001151239.1866845-1-ncardwell.sw@gmail.com>
In-Reply-To: <20231001151239.1866845-1-ncardwell.sw@gmail.com>
To: Neal Cardwell <ncardwell.sw@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 netdev@vger.kernel.org, ncardwell@google.com, ycheng@google.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  1 Oct 2023 11:12:38 -0400 you wrote:
> From: Neal Cardwell <ncardwell@google.com>
> 
> This commit fixes quick-ack counting so that it only considers that a
> quick-ack has been provided if we are sending an ACK that newly
> acknowledges data.
> 
> The code was erroneously using the number of data segments in outgoing
> skbs when deciding how many quick-ack credits to remove. This logic
> does not make sense, and could cause poor performance in
> request-response workloads, like RPC traffic, where requests or
> responses can be multi-segment skbs.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] tcp: fix quick-ack counting to count actual ACKs of new data
    https://git.kernel.org/netdev/net/c/059217c18be6
  - [v2,net,2/2] tcp: fix delayed ACKs for MSS boundary condition
    https://git.kernel.org/netdev/net/c/4720852ed9af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



