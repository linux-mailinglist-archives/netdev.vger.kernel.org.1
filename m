Return-Path: <netdev+bounces-37989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3917B839A
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 17:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8D1412812FB
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 15:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C932819BA1;
	Wed,  4 Oct 2023 15:30:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B940118E39
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 15:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15200C433C8;
	Wed,  4 Oct 2023 15:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696433427;
	bh=Ysz4EVgzrtRcQC1+pBms7RnQ5vulyjwv3q38AbGYlB8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P+aUhVbY/cu0H1HGPZ7mOKvMRcXSeeWeAMtVFqzYo5pN3f49XTdPCFuaagPFMNr7z
	 EdScnbqlr9S5iMbrEtw2BJYFqFh9G1niVQwAQN5P7geMUfFAcHEXha8F8dahi0q3Rs
	 aaBEkjU3R3nMYv7hbU2vFp0ESBCXQbqjn9hkrHcP3oZfxBUIo2nIx1QBKH5bNJCOjH
	 Os5C3rg++x7NsXGjOftQZgpo85JoLPPekZeDRIzSyJ6L04qx5KA/T3PNlUcFybU10J
	 QiljwKu+nfntvjJvzwI/HUk2Js5/9Pv2vYU6FDefrnh45EloP7nN1zBZfND0lo+2D4
	 uDCCiQV8V37pw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC63AC595D0;
	Wed,  4 Oct 2023 15:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next V3 0/2] devlink: Add port function attributes
 for ipsec
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169643342696.21372.15580194782521448329.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 15:30:26 +0000
References: <20231002104349.971927-1-tariqt@nvidia.com>
In-Reply-To: <20231002104349.971927-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: stephen@networkplumber.org, dsahern@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jiri@nvidia.com, dchumak@nvidia.com,
 kuba@kernel.org, leonro@nvidia.com, saeedm@nvidia.com, netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Mon, 2 Oct 2023 13:43:47 +0300 you wrote:
> Hi,
> Please, see kernel series [1] for the overview of these changes.
> 
> [1] https://lore.kernel.org/netdev/20230825062836.103744-1-saeed@kernel.org/
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [iproute2-next,V3,1/2] devlink: Support setting port function ipsec_crypto cap
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=27fd1bfa1b5f
  - [iproute2-next,V3,2/2] devlink: Support setting port function ipsec_packet cap
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=994e80e9c9fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



