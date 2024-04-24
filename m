Return-Path: <netdev+bounces-90746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A0F8AFE4C
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 04:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567E41F23639
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 02:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8363168B8;
	Wed, 24 Apr 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r96HXd74"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A128B14A84
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925228; cv=none; b=C3Pw2ojv0x201SYpvSVGlsN0kUTrTEbNmrb2EuO+gnvMnuMWooEM0t9Wbw4RKE2Yg7k5gDe8YUPQaBo1OzPoYLDsQ/XLpQOA+Xb+/KlmrsP9jWWdiaaQKQW0pY07vEbgEDPcZTu09GETyEv6lV5ymYJEcenc93ovTbpbUBkRdhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925228; c=relaxed/simple;
	bh=Im2ilEupdD1suFBdcey0iwbyTeVU3M4UETsm6WzB+/4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y7e8mJRGdaFF2D5CrX2CUyPAEYOu+v+jkmx5BCql9nRb3MMrSlGURR40rg8b8fqi7ISDTnxxQR0Kz8awcseVt74PSxltQUGIF0FNp12AsruoenR6pAxx9m0Fmw01RMeE8S1o1vEVQyNPobnd5uRhDbgfiR3KFm16mQHht9lDEGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r96HXd74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E017C4AF0D;
	Wed, 24 Apr 2024 02:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713925228;
	bh=Im2ilEupdD1suFBdcey0iwbyTeVU3M4UETsm6WzB+/4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r96HXd74YfCc35xhQhvgJW5FXLWYoHhV7gpy398f1HYAjpWYfqlSZ/vjKep0ZDwBG
	 yRBYhIHRW/1ayH90Ed1Y2UALQmXYZjBDyCNSISElYAT1fxsvIVy/IRVRhn2+iv+2Qd
	 +0niO8R9sW65tNrp+ABdqbzhUUZLwOYxmyu/ytaNTZ4lWZmGAJWxCtIytbkBjxQT2J
	 nOP+Ir+xxnhM3YkDtoZ66HKfcRxlzxpL7jQd9Fs4X4AnTnZq8MZfLWwhNPRw7GAX8P
	 0wInNuEarOQMbAEoXVFNn+TIP1KiAJKZqsbE5l1z0ThF3nAcWqYnJG98jnc8pkdT6R
	 1jUue6T4sO/IA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63887C4339F;
	Wed, 24 Apr 2024 02:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] neighbour: fix neigh_master_filtered()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171392522840.21916.13195848930129128540.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 02:20:28 +0000
References: <20240421185753.1808077-1-edumazet@google.com>
In-Reply-To: <20240421185753.1808077-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 21 Apr 2024 18:57:53 +0000 you wrote:
> If we no longer hold RTNL, we must use netdev_master_upper_dev_get_rcu()
> instead of netdev_master_upper_dev_get().
> 
> Fixes: ba0f78069423 ("neighbour: no longer hold RTNL in neigh_dump_info()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/neighbour.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] neighbour: fix neigh_master_filtered()
    https://git.kernel.org/netdev/net-next/c/1c04b46cbddd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



