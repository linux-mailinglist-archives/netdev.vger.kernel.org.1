Return-Path: <netdev+bounces-52008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9307F7FCE0E
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 05:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8E51C21064
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6356FA6;
	Wed, 29 Nov 2023 04:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/TunPZp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF686FA5
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 04:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 149B1C433C9;
	Wed, 29 Nov 2023 04:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701233424;
	bh=zdGX5wEfjDirv8VVCe5Xz/q6fTQSFV2zAnrQNCT5WV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y/TunPZp13e4ZPRuX0UlALlA70llvMtJV9MOi+jlvu87DUv3NvPesnznP/8v0LoOS
	 QlH00m2MuVwr8f/6X+XidyWzT7Objjr9pVF/r2+Cq9p8LJov81VuhcGqrDnnZQwnYF
	 YT2BEqqi4g2Gmew7zNwnU7gD8Vx7YmduukMQNz/r/aMYG7UYRtFe1QVWTkaHayUaxz
	 x0xaJnGm/bQPQoE8FQwM8nTR4ZAkmR9UCu/jPjNuYm4ZtR2gZpE8aLHA7W+Gzi7MvB
	 tJgQTAY4xY5yyGdNDSp6Ns+aPbVQCT4R2EcJtJJqKxs1uliNAgOhE7m4Yt5abVYAiP
	 RPV+zJiReGeIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EEDECDFAA89;
	Wed, 29 Nov 2023 04:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] iproute2: prevent memory leak on error return
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170123342397.22449.3200085287282268932.git-patchwork-notify@kernel.org>
Date: Wed, 29 Nov 2023 04:50:23 +0000
References: <20231114081307.36926-1-heminhong@kylinos.cn>
In-Reply-To: <20231114081307.36926-1-heminhong@kylinos.cn>
To: heminhong <heminhong@kylinos.cn>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 14 Nov 2023 16:13:07 +0800 you wrote:
> When rtnl_statsdump_req_filter() or rtnl_dump_filter() failed to process,
> just return will cause memory leak.
> 
> Signed-off-by: heminhong <heminhong@kylinos.cn>
> ---
>  ip/iplink.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - iproute2: prevent memory leak on error return
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=389657c3ec43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



