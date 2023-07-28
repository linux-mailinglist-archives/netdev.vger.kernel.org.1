Return-Path: <netdev+bounces-22230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 070687669EB
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40A3281FBA
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5663B111BE;
	Fri, 28 Jul 2023 10:10:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26A111C87
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D84FC433CA;
	Fri, 28 Jul 2023 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690539024;
	bh=41mSCjdZJfPKi0PrO7L2R4Z8gSTlWLUxxk3kpxsWyeY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u5TNG5HfUQNaFE8HEVgsUMYF5IpjIqrYTTcDCu9wtR+G88okhJrL4VtLpAHbVPiK0
	 foFKl20Gzk08nDwBxWlwk5njvXtjqkjHUGimNm25Yt8/n2S8AxAE9cUQDUERyyaytb
	 bQSt/ac9NnvNP0tV66k2PL/ccYjNHqATCpaunEKCk6M+OwBbcTUKUiSCdZfHpm361J
	 IdicK3D2TLxhg9yKzDsgOUiNk9kjWU/wck+WWHfvcvdZS9bqQafA3+3hRPelHjv9yL
	 4Ca4qxYaqkMk8fZY3U6Aya0J3Ojzw98RLDrPQ6IUN9VRTXq13xUnDNVtjrC2ZYb7vb
	 5hQkGqGFEdkeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3442AC39562;
	Fri, 28 Jul 2023 10:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv4 net-next] IPv6: add extack info for IPv6 address add/delete
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169053902421.13986.9225955378460946821.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 10:10:24 +0000
References: <20230726023905.555509-1-liuhangbin@gmail.com>
In-Reply-To: <20230726023905.555509-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, idosch@idosch.org,
 bgalvani@redhat.com, idosch@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 26 Jul 2023 10:39:05 +0800 you wrote:
> Add extack info for IPv6 address add/delete, which would be useful for
> users to understand the problem without having to read kernel code.
> 
> Suggested-by: Beniamino Galvani <bgalvani@redhat.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [PATCHv4,net-next] IPv6: add extack info for IPv6 address add/delete
    https://git.kernel.org/netdev/net-next/c/7f6c40391a04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



