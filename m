Return-Path: <netdev+bounces-22414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEE47675F2
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 21:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386F41C21549
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 19:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419A317727;
	Fri, 28 Jul 2023 19:00:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B090B14AA0
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 19:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30A53C433C9;
	Fri, 28 Jul 2023 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690570823;
	bh=5VSj7XhsC5YpbbM6QaMsAL2ddm6L07CE3QCvSJHOi+4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uVlTkDBEloAGDf9rugAKOizE9iFeB5urGz5+gmNLa8WqikaQQ8qzwxmm3qk57Tjv1
	 K8oulY5FFjbf6Bw0dvFlZXJ9vvpENDiVouRY471ikg81OHFddQ/RNcmU1jVvbajgcH
	 nUs1Da4pBljol2e0JUl+xvnIHo0wke9t8tturbAc7qVzQohp4flrfi7zqnGlVQK8C0
	 pqdgRvvn3rAmVEWdk1UGlLzI4mvgivr4niWEdAZ0vbxUSyQUMbjsjd8luTDkTReNxM
	 MepuCj34GQoT2ZOLQ7sXXIZkhUgr3NT1sMq6NpK3liMwPmqHHDF6pxIG79X2Q58zfG
	 zxan1YRKG8M9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15E5FC4166F;
	Fri, 28 Jul 2023 19:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: store netdevs in an xarray
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169057082308.523.12097779537419544794.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 19:00:23 +0000
References: <20230726185530.2247698-1-kuba@kernel.org>
In-Reply-To: <20230726185530.2247698-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, sd@queasysnail.net, leon@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 11:55:28 -0700 you wrote:
> One of more annoying developer experience gaps we have in netlink
> is iterating over netdevs. It's painful. Add an xarray to make
> it trivial.
> 
> v2:
>  - fix the potential mishandling of wrapping (Leon)
> v1: https://lore.kernel.org/all/20230722014237.4078962-1-kuba@kernel.org/
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: store netdevs in an xarray
    https://git.kernel.org/netdev/net-next/c/759ab1edb56c
  - [net-next,v2,2/2] net: convert some netlink netdev iterators to depend on the xarray
    https://git.kernel.org/netdev/net-next/c/84e00d9bd4e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



