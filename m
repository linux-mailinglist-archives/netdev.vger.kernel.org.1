Return-Path: <netdev+bounces-22095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3A87660B8
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 02:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8A31C215A4
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 00:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11757F2;
	Fri, 28 Jul 2023 00:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816D8800
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 00:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02D7BC433CD;
	Fri, 28 Jul 2023 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690503621;
	bh=JWpibV1AQXBMpPFvCewoBsCPhbnapxlbGt4HsLNitJo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cjsALfXyWA/6raCCl2px6oP9dHVI0H2lgfOOk0OgMkuMP5SgQggtxyRMFs+YHPDfp
	 eEZR/KZdnLWiGaq56v2krh/Zj42BbLex/0ual0lDgI3DpqUrp8wSTgM5qWVrHT3yOG
	 /eCUgIboNAuzcV8lTNA2NHthDvx5w0CaPWwEKI764J69oc7VJdZDSkCtt0h7XyvGZH
	 A2Rq5fIuC/cER0EdPG5kV2jg2g8//gBIjNdYHL7hv7CkKbfMeT/diR+6gUwQ6c6qNs
	 OddxVh7qRQnAilLi3WA++CpbLsNBOezNc1461qpd3FwrwftjG25y4ulzPBuRGm/Lfm
	 yo0cOqsMs/1Fg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3C40C41672;
	Fri, 28 Jul 2023 00:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bridge: Remove unused declaration
 br_multicast_set_hash_max()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169050362092.24970.6426041238367256548.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 00:20:20 +0000
References: <20230726143141.11704-1-yuehaibing@huawei.com>
In-Reply-To: <20230726143141.11704-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com,
 bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 22:31:41 +0800 you wrote:
> Since commit 19e3a9c90c53 ("net: bridge: convert multicast to generic rhashtable")
> this is not used, so can remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/bridge/br_private.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] bridge: Remove unused declaration br_multicast_set_hash_max()
    https://git.kernel.org/netdev/net-next/c/4d66f235c790

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



