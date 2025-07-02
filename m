Return-Path: <netdev+bounces-203546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31375AF656E
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DB33A80E4
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33091EFFB2;
	Wed,  2 Jul 2025 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtWCe20d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8961D2F42
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751495985; cv=none; b=E9qy2TujEF0dQr9XmNCigjfFvPNK8EPlZBRrcJYsvX+L5Nb6QioQU8MWjrUQ2NdF7ZFAwwg+zO3OaF6U/fCHkAo6NCmJL3FT7HpSFT0ipvUsxLin3j0ejdVjI9F3Ng1v7W2PEpFlw7WUygmr3651aCK/bJuupcYl3e9FWcSnZJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751495985; c=relaxed/simple;
	bh=vql7pSFq9cgz0JlxkD4W6ernapjh7TcBS2MmTyIMYM4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gtdnckEC4ON3U2TClFWbBtgBXJSxD1QlQpETnYOA95RE5d320iTexer7Q97H5Zy1L1+Sv5ff1c6YVlzEdIOAVqrUs13yW2oQEadcquQFclu/+NtcLawQeiEPsRHIF+R6oK9wMcyoKkOfR5kwX7MsGoB/xEBJhvQ8hn5WHLbAvF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtWCe20d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793B5C4CEF2;
	Wed,  2 Jul 2025 22:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751495985;
	bh=vql7pSFq9cgz0JlxkD4W6ernapjh7TcBS2MmTyIMYM4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EtWCe20des0A7ZbgPX/jQJ2fiwi5gC4WW3WgNI+u8mnmpZvYHp90DzXy68aXnbpZl
	 Z3c++jjXXFVrckwl5/ds3J9LA2ahmcmBwHa9YnCtMwR50VXl0OywI6r4jM8XWlhQJd
	 OJQfPUaArarBEhRGZx4BQO+eV9AbPabmTQG6Vz3Oywkip48mstP83PzFOa/zmdgBZF
	 o5XqYGbxLkJ88Qncu1ttVTD6QAtSduX/adhP1ZLKAiV5EFVrFydPLcygs5VqI+H1JM
	 RnlKB/6rrx70H+3JC2qH0vxgifymKu1byEwdFpL0+Dl/88JwGh0wyCR8IaQYcE9p48
	 TKQ/KEfqo9/SA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE4383B273;
	Wed,  2 Jul 2025 22:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] preserve MSG_ZEROCOPY with forwarding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175149601001.887832.3172745561402860388.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 22:40:10 +0000
References: <20250630194312.1571410-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250630194312.1571410-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, willemb@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Jun 2025 15:42:10 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Avoid false positive copying of zerocopy skb frags when entering the
> ingress path if the skb is not queued locally but forwarded.
> 
> Patch 1 for more details and feature.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: preserve MSG_ZEROCOPY with forwarding
    https://git.kernel.org/netdev/net-next/c/d2527ad3a9e1
  - [net-next,2/2] selftest: net: extend msg_zerocopy test with forwarding
    https://git.kernel.org/netdev/net-next/c/81d572a551f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



