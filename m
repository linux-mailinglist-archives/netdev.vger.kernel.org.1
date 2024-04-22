Return-Path: <netdev+bounces-90086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD598ACB8F
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 13:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285AD2850DD
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3348146591;
	Mon, 22 Apr 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHLB3EOY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA105145FF8;
	Mon, 22 Apr 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783628; cv=none; b=h2t+Lo3GcNqo1llX/0VzViGBlFE2g1PQo/2sTDuTMgB6Ac9btKp2/xder1MVDJ+RYN89eNfeDAWE3hOA19lBUSf4hK7h3fVypIOecVSzDNGpY0glEcfrLjCVJsubsaHhZiiW8FLHQ7GcbcF5TX6fXK3qU/qWYmWVHKcvE9L0Nes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783628; c=relaxed/simple;
	bh=o6+qeBDP8mdmsxsc3ZCzjmKCgHbtcy2bVyZBI60hcj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pCEyXH9Fc6+LojIN8Hu9BL02tEOVyrcQ4Cw9e4gwPkwZKOJ3S3EdsdP6pd9h33jNWex1FpyxrhF5m5jhSkV/ijXPeBRDdk3+VkHNd0D5I7BRGmQVMprqhzqvWgrCrZbGASoE0v9TgDWnI9JYNVPU0Z6R+PQYAH1zTdr4fUKTV6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHLB3EOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AA60C3277B;
	Mon, 22 Apr 2024 11:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713783628;
	bh=o6+qeBDP8mdmsxsc3ZCzjmKCgHbtcy2bVyZBI60hcj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cHLB3EOY4JnrWwi5SfiUaAWVqv/STdE69966QVwd47cvX7sz1njHVx9m0oSOo8Jzd
	 TpeZjK92yr39G7DC1hal/5HbL5RBuoOXU15CBr0EK+OXYLTL1L2/Ko4BzB1YbVixO9
	 /2SRkyWhnCs8u0pZ3lv5LWTzXSa3YhuhQr8IuMz7ldEgMUKpSrQL8z8CRhrH5UYQgY
	 okSo6J9WlwKdb1+JbdNC7DoyvPUcU4MfcPclZEXySwNETRoRlgyjOjxSFwsFWFvoxs
	 rjd0u7gGH41BA8ZDH43AIOs3IwBfARXEeQL3NhYcvK0M7SAZ7pq/EWmC1cV2V95vO/
	 Pa1V1r169qZ0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4947CC4339F;
	Mon, 22 Apr 2024 11:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bridge/br_netlink.c: no need to return void function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171378362829.5313.17055800887175868999.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 11:00:28 +0000
References: <20240419080200.3531134-1-liuhangbin@gmail.com>
In-Reply-To: <20240419080200.3531134-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, roopa@nvidia.com, razor@blackwall.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horatiu.vultur@microchip.com, henrik.bjoernlund@microchip.com,
 bridge@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 19 Apr 2024 16:02:00 +0800 you wrote:
> br_info_notify is a void function. There is no need to return.
> 
> Fixes: b6d0425b816e ("bridge: cfm: Netlink Notifications.")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  net/bridge/br_netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net] bridge/br_netlink.c: no need to return void function
    https://git.kernel.org/netdev/net/c/4fd1edcdf13c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



