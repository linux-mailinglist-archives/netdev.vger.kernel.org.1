Return-Path: <netdev+bounces-33912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6707A099F
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9552282213
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B853D1CF9E;
	Thu, 14 Sep 2023 15:40:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5C1CF97
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82CA5C433C8;
	Thu, 14 Sep 2023 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694706028;
	bh=5YlYThHz6kgaqNTLekMN0xx5bNrfNkh1z47efDbzHxU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ppEhEDVqEA7rO5RNK5j77cEpotSvib41/81y2Y0BODMefDJtYWdFeXLcSfmZxbLY1
	 UbyeefML5WO/6rmxWypTzpmR6ivUC+zKCWsZzzVg6D7DciWrVMo7XrQB3NmOfCxMjJ
	 K8bYrbmxogc7UQsB8rH/mh7YH2NXe/Aye8sVtzFfifuMyaMz2Uj3yrZ5Klmnp58Cew
	 N+C7jhKukqwWVL09Y5ttKe2CSW9JVnwvUNwYBlZdHptQsg9NPQ0TIAYFuIboo6zvoY
	 utruOyoUM3X08/RilnvxB4/wI/EVKGompPs7OeLeXBERpw1SrzdnMHP2JStzwhbvNU
	 u8XxPeryf7EYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64F6CE22AF6;
	Thu, 14 Sep 2023 15:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: mcast: Remove redundant comparison in
  igmp6_mcf_get_next()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169470602840.30402.16427118028030872259.git-patchwork-notify@kernel.org>
Date: Thu, 14 Sep 2023 15:40:28 +0000
References: <20230912084100.1502379-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20230912084100.1502379-1-Ilia.Gavrilov@infotecs.ru>
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 12 Sep 2023 08:42:49 +0000 you wrote:
> The 'state->im' value will always be non-zero after
> the 'while' statement, so the check can be removed.
> 
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: mcast: Remove redundant comparison in igmp6_mcf_get_next()
    https://git.kernel.org/netdev/net-next/c/59bb1d698028

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



