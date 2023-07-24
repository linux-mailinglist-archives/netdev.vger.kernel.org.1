Return-Path: <netdev+bounces-20287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B91D575EF49
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2411C20962
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8E57465;
	Mon, 24 Jul 2023 09:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818076FC9
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2551C433CA;
	Mon, 24 Jul 2023 09:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690191621;
	bh=sp7SOFmN98zaab209/qdxyPHhiomDUaHbOyBHlM/sOo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=klyqvkOEsjxWQz86du8ademrg/CZPL614nicW12d/UNCNrZYHw0t2RQskCXkjVDNm
	 DpIUdnAC2SM///O2Rvr8QNYfcdqJTmLB3nEoR39mnbJu9WpRM3U+N66Oim0qqQYNoE
	 oPrXS0R/esLrJMg1g19UysaV1sPxhiaEd0L6wwBbGHfKCmkNEhxtLjFVp+xD1QbPTp
	 H663kvxNPYrtNrZht1ZJ2M+JE/bszPKvbbFj8OpW42OuxpOhYZ6S03QKqq2XAEvsmR
	 6+uku2UtxnFzmY1xT1yAP75ZdsQ6NNKVQpljrxI+YX2DN5Gxqwb5p9MUfFCfsvIdso
	 dHOtWv3Z25O/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7F2CC595D0;
	Mon, 24 Jul 2023 09:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] ethernet: atheros: fix return value check in
 atl1c_tso_csum()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169019162181.19399.6985665934296895199.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jul 2023 09:40:21 +0000
References: <20230720144208.39170-1-ruc_gongyuanjun@163.com>
In-Reply-To: <20230720144208.39170-1-ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc: chris.snook@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Jul 2023 22:42:08 +0800 you wrote:
> in atl1c_tso_csum, it should check the return value of pskb_trim(),
> and return an error code if an unexpected value is returned
> by pskb_trim().
> 
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>  drivers/net/ethernet/atheros/atl1c/atl1c_main.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [1/1] ethernet: atheros: fix return value check in atl1c_tso_csum()
    https://git.kernel.org/netdev/net/c/8d01da0a1db2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



