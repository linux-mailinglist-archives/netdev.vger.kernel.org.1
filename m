Return-Path: <netdev+bounces-61988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09818257C5
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 17:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E80F1F27DF8
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 16:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA362E846;
	Fri,  5 Jan 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZRY29Dt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BA32E828
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 16:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65DD3C43397;
	Fri,  5 Jan 2024 16:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704471027;
	bh=Q/0d/N+MsFMrZq6+p+/YhQS2joUDe6dGkAIT1HC6fVs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jZRY29DtDoRZU3R4eBBsRYNyFkLWMIpKVOlv7gzn+QYHQq82PynJkZFKic/6KP8iq
	 vXNFupXZR0v15Ouf/kP/I/tWekBDU+2qdnSpQqE+uYXuNvsFHSkqoVqnYSswJA/c1I
	 RqVjpB3ApyOdSH20/kDp21KyiE0QDsdob/6pcmuXbELzwZJWM+egBjl8BtRZ+h3AGb
	 IrCoDfsg2IRu9Liqn2TVMJh+ZTxoU30qp0dXXvInoxjES/mkmP5Wqrf4qpPrhu4eUd
	 9L/Wv+XnC7wbep0JEOvC5OTrX4YyD8UCPdSIWbrXhlShsc4bwRciO7OykDlQ1WlhJ4
	 nb4jeDFgHPbSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 443D8DCB6FE;
	Fri,  5 Jan 2024 16:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fill in MODULE_DESCRIPTION() for AF_PACKET
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170447102727.8824.12112538235167880265.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jan 2024 16:10:27 +0000
References: <20240104144119.1319055-1-kuba@kernel.org>
In-Reply-To: <20240104144119.1319055-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jan 2024 06:41:19 -0800 you wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add description to net/packet/af_packet.c
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: willemdebruijn.kernel@gmail.com
> 
> [...]

Here is the summary with links:
  - [net-next] net: fill in MODULE_DESCRIPTION() for AF_PACKET
    https://git.kernel.org/netdev/net-next/c/b8549d85983c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



