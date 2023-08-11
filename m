Return-Path: <netdev+bounces-26611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E6777858F
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 04:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40319281AC9
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 02:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BA8A46;
	Fri, 11 Aug 2023 02:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F7AA40
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55483C433C8;
	Fri, 11 Aug 2023 02:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691721622;
	bh=YndZcHJCV/o6mRr0NKkn4QmiusTlRpbegp99anOFoBE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AQyvlO30I0XiZ267clyidO57KQbHYuTbwf6St9AIG7KnE5ceUoo8+9h1qPpOHMVeR
	 6ho6EQSJy47bzqUMMTh+5cfVG5mcwhuMbbVnrsZ0GoiqksqtxUvTkbDLlB2skUmusD
	 9fTbjpWJxPIEEgZ6RjPACGaRt2Iq3iXtxtYKd3fAkrnsSnvTn5eMjzpjXYXfDynC8y
	 gKLsCCEtF2gXn3o4dO6N6znXQgLZE4VCqNmNntvsRWuuZgw1qUz7W9smSE8scX9tyH
	 CEj0t7mcTFo7N7sLucMiuEMD87doi+qKrUjIO3WXWx4z9m/B2Gu2Gxjv9ruIyK8Kz8
	 kPDVeKftwiruw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36742C39562;
	Fri, 11 Aug 2023 02:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] tun: avoid high-order page allocation for packet header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169172162221.18522.12671280608585780104.git-patchwork-notify@kernel.org>
Date: Fri, 11 Aug 2023 02:40:22 +0000
References: <20230809164753.2247594-1-trdgn@amazon.com>
In-Reply-To: <20230809164753.2247594-1-trdgn@amazon.com>
To: Tahsin Erdogan <trdgn@amazon.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 herbert@gondor.apana.org.au, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 9 Aug 2023 09:47:52 -0700 you wrote:
> When gso.hdr_len is zero and a packet is transmitted via write() or
> writev(), all payload is treated as header which requires a contiguous
> memory allocation. This allocation request is harder to satisfy, and may
> even fail if there is enough fragmentation.
> 
> Note that sendmsg() code path limits the linear copy length, so this change
> makes write()/writev() and sendmsg() paths more consistent.
> 
> [...]

Here is the summary with links:
  - [v4] tun: avoid high-order page allocation for packet header
    https://git.kernel.org/netdev/net-next/c/6231e47b6fad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



