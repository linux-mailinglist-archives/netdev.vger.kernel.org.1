Return-Path: <netdev+bounces-48761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B3F7EF6E9
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 18:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E980E280CE6
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA17543174;
	Fri, 17 Nov 2023 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcIRyl00"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478F030655
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 17:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FF34C433CB;
	Fri, 17 Nov 2023 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700241623;
	bh=gzKLK25pchZx2+7U8UW7pwvd/X2fInSU3w+HR1kIkMY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AcIRyl00tgv3HcMdysqWKmWeFuAgSjJ1M03Q+ziAL9G5AUiqTt2f1UYZrP17rK9h9
	 58V8nuwPFYULblu/Xt88QKo8w2HVTR+9uBT0vRxri+sD2gEhEjfQ5+yLcj427zArO4
	 MnmnaW+uk0ZZ3FVF5VF5zpNlh/M9h1xZYKyVnzxpz5Ao4k0GuHM/07wo5fgzbqT7tY
	 PzYiS4ltF5NHG6xEOEJSF0pcpRjggyM8+R1nixJCmNuGfbA2HWMM21bLpUEQzsH174
	 Ff3AEfCxLatowFuIFoEuw9jH4BpYMD0EZhQyN2ytvqZc0u0IbBNeOxUMI+rva1VHoj
	 vW1rGmDemVzzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86B8DE00098;
	Fri, 17 Nov 2023 17:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] iproute2: prevent memory leak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170024162354.26596.18193202556756297538.git-patchwork-notify@kernel.org>
Date: Fri, 17 Nov 2023 17:20:23 +0000
References: <20231116031308.16519-1-heminhong@kylinos.cn>
In-Reply-To: <20231116031308.16519-1-heminhong@kylinos.cn>
To: heminhong <heminhong@kylinos.cn>
Cc: petrm@nvidia.com, netdev@vger.kernel.org, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu, 16 Nov 2023 11:13:08 +0800 you wrote:
> When the return value of rtnl_talk() is not less than 0,
> 'answer' will be allocated. The 'answer' should be free
> after using, otherwise it will cause memory leak.
> 
> Signed-off-by: heminhong <heminhong@kylinos.cn>
> ---
>  ip/link_gre.c    | 3 ++-
>  ip/link_gre6.c   | 3 ++-
>  ip/link_ip6tnl.c | 3 ++-
>  ip/link_iptnl.c  | 3 ++-
>  ip/link_vti.c    | 3 ++-
>  ip/link_vti6.c   | 3 ++-
>  6 files changed, 12 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [v4] iproute2: prevent memory leak
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=2c3ebb2ae08a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



