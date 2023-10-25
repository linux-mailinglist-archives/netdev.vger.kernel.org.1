Return-Path: <netdev+bounces-44127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1501E7D6718
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 11:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465881C20DA2
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 09:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E1E224FB;
	Wed, 25 Oct 2023 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeHouFxs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D724219FF
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 09:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE601C433C8;
	Wed, 25 Oct 2023 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698226823;
	bh=obLZ+ov0IDqSzA8P6SKqhzYX3GlFGhhfWdc5m4TasUI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XeHouFxs7/tc/dnttJDfuLetS3FoZITsAvxuv183v+Mq2wwpYyiAxe7EJ6fICw2p9
	 rnb6BnZeVV85w36CZmHjzRDu4hgMbexWaHmq8nP4tplAcilxX5w8d/TKt90h1mP32d
	 zHSaxK90Obz/O0d+KvNyCSQubh8NXcvSdLG2pInlkCxgI24RAWqPSSxVXyAMwkGA6B
	 O8z0YNRxq9FekI7c4aZFQ0pUylSbsAjxcY1o6Q4ToVVPoTS0RAmM54DmC4bvmyrNsC
	 lKmKnXMb2te84cgFF9K7VwlpBZ+EiQZ6mBknV1C9Lgd7P7ls39twP05Be1c2T7FlAx
	 sBqS6zR3vR/lQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C8D6E11F55;
	Wed, 25 Oct 2023 09:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ipv4: fix typo in comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169822682363.18837.12374680836954385910.git-patchwork-notify@kernel.org>
Date: Wed, 25 Oct 2023 09:40:23 +0000
References: <20231025061434.2039-1-wangdeming@inspur.com>
In-Reply-To: <20231025061434.2039-1-wangdeming@inspur.com>
To: Deming Wang <wangdeming@inspur.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 25 Oct 2023 02:14:34 -0400 you wrote:
> The word "advertize" should be replaced by "advertise".
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  net/ipv4/esp4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - net: ipv4: fix typo in comments
    https://git.kernel.org/netdev/net/c/197f9fba9663

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



