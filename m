Return-Path: <netdev+bounces-57193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 674ED81254D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB561F218E6
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4DF15BD;
	Thu, 14 Dec 2023 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOuwmTTG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F421378
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 892FAC433CA;
	Thu, 14 Dec 2023 02:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702521025;
	bh=qru7CWLLnDsIBqYu7xJkNzor0rLbcgClNZ60pzfcS4s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SOuwmTTGifLUSxpqZzKOqK/ltGDMYMagUxE1xTyOxpL1JtLkGRFdeZXfs2o+DGI8+
	 F6vOwTM+gwyyYqGYAj2/hdYDWTypLvfdOMT/c9bnmqGH3E0bg3M1YAMQuj/MAF8xpK
	 4Kz/72/UgTrfHHBkjWRpRlduo/w0JURgWYHMOinXdw4ksAcrZvD+csLv/nYz4wuxHW
	 jwzEbW5OgYTi/ZLD1nZ0/pRl+jf2vEQl3soGPKvEBBcvFXvUrjZ/XMvZ4loFRcecba
	 oOr+1Im7pR4teyBYkbTUR5OMFosQFWVYmJ9b7ajo9O2mKWQKPZUUflanZahD92PE4S
	 D7UGtDzOtIs8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76F2CDD4F06;
	Thu, 14 Dec 2023 02:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] docs: networking: timestamping: mention MSG_EOR flag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170252102548.28832.17903661591512870142.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 02:30:25 +0000
References: <20231212110608.3673677-1-edumazet@google.com>
In-Reply-To: <20231212110608.3673677-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Dec 2023 11:06:08 +0000 you wrote:
> TCP got MSG_EOR support in linux-4.7.
> 
> This is a canonical way of making sure no coalescing
> will be performed on the skb, even if it could not be
> immediately sent.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Martin KaFai Lau <kafai@fb.com
> Cc: Willem de Bruijn <willemb@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] docs: networking: timestamping: mention MSG_EOR flag
    https://git.kernel.org/netdev/net-next/c/173b6d1cdf58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



