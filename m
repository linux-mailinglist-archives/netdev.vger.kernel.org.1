Return-Path: <netdev+bounces-34026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FF57A1ADB
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 11:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5A41C20C50
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 09:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B99DDCB;
	Fri, 15 Sep 2023 09:40:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FD8DDDA
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 09:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51841C43391;
	Fri, 15 Sep 2023 09:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694770829;
	bh=XXZXlu4jkSsFPBa7nCHCNpcv/hoVdsXUtmnPt8pFGKI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nGF/bVpGXs9tyr8j72SHZc9ENF+qPFoNAXs5UvZhc4hdQl+7QfErv65y5l4iFiARe
	 56Roqqfr31QkVpl4ZnUU+4ORoamPjvzxGLcmEKUaXObC17vKW8S+zT/946CeuBrNpQ
	 dwlo2Z+fK49dsfYDM7dMr65NKi3y4go7WdB94+mCI8hDTJPBVVh5dYw20xE95nVy/c
	 7GBypUsV8vMRjDYb6X+Vze4rYb9f7LsurRI6LsxQGsqevXZe3qkic9n4OFQ8RYVHU/
	 mGGDy+ejMX5grH+zCRtIsQe79f4ini5XBjL4zAeYgPZDwEt60Au0qk08E5qMyoah8G
	 /lylLgCfAmBcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C51AE22AF3;
	Fri, 15 Sep 2023 09:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2-pf: Enable PTP PPS output support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169477082924.23365.9688061553614275175.git-patchwork-notify@kernel.org>
Date: Fri, 15 Sep 2023 09:40:29 +0000
References: <20230912175116.581412-1-saikrishnag@marvell.com>
In-Reply-To: <20230912175116.581412-1-saikrishnag@marvell.com>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, richardcochran@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 12 Sep 2023 23:21:16 +0530 you wrote:
> From: Hariprasad Kelam <hkelam@marvell.com>
> 
> PTP block supports generating PPS output signal on GPIO pin. This patch
> adds the support in the PTP PHC driver using standard periodic output
> interface.
> 
> User can enable/disable/configure PPS by writing to the below sysfs entry
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-pf: Enable PTP PPS output support
    https://git.kernel.org/netdev/net-next/c/35293cb392e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



