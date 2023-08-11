Return-Path: <netdev+bounces-26685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B074777895F
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20962820E8
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EE85679;
	Fri, 11 Aug 2023 09:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E8853B1
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86C16C433C9;
	Fri, 11 Aug 2023 09:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691744424;
	bh=qLF7YlZrtiwbNwFp51qWg89Le3oLDBKUtjdyQOi9qXQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m/s7XLhO43bruPdqhby3sHMscz0+GSDU3xevXRxqEG/OmP8BE9As+N9IcjsWsBAZM
	 pkD1ObJLy3h8ZExeEkQVuaXFCF8OPKvOUUx2wYpf4XIYK6C7PQ3wFgHShS/UtxMuJM
	 YHr7VMUAGOfeodGJYT331jnZ7+VS44NRIrRjSG2EkxOnrsTekokgH4KGmCpFAQXSiR
	 Vwl5PoXdJCbNXeVLt6/r4dmQ/KONcE3jXfTDWTT731jrzD5j0/8433jKz7OcoZHI5x
	 +7PNZMR1eRORb2NmUlthrTiC7+Ci+t+UjpPdKPVggHn0zgJANvIlLXtUHecPhq3wcC
	 mNQypC4xsdVXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70031C3274B;
	Fri, 11 Aug 2023 09:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net/xgene: fix Wvoid-pointer-to-enum-cast
 warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169174442445.10902.2590537294686225131.git-patchwork-notify@kernel.org>
Date: Fri, 11 Aug 2023 09:00:24 +0000
References: <20230810103923.151226-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230810103923.151226-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
 quan@os.amperecomputing.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andi.shyti@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 10 Aug 2023 12:39:22 +0200 you wrote:
> 'enet_id' is an enum, thus cast of pointer on 64-bit compile test with
> W=1 causes:
> 
>   xgene_enet_main.c:2044:20: error: cast to smaller integer type 'enum xgene_enet_id' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net/xgene: fix Wvoid-pointer-to-enum-cast warning
    https://git.kernel.org/netdev/net-next/c/c5b0c34fae1e
  - [net-next,2/2] net/marvell: fix Wvoid-pointer-to-enum-cast warning
    https://git.kernel.org/netdev/net-next/c/e5cd429e7928

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



