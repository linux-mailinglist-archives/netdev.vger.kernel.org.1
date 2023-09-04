Return-Path: <netdev+bounces-31884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 873FC79114B
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 08:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF811C204F6
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 06:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54287A34;
	Mon,  4 Sep 2023 06:21:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E52E7FE
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 06:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74D5CC433C9;
	Mon,  4 Sep 2023 06:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693808465;
	bh=etpYbzwAHVtTNrUBJcrpCLc8JFwKatKo6Nm7fue8s3I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WYgYnwu+h98hBfvs16o3qXpRovdGzhSGk1you7qoYBT8J7oqpiqs27ps37WnWHRGW
	 Mg4y6J/1tKHHBF9ZjWrH8zOlO6RqY9BF4cXOFDSI/ZtOZjWpHFCtBfnSvGoUWZJPkd
	 b8nZ+BLw87GG8S2zExI2Gd0aIpRiOO/so07n1cYibrWISWjDiwZr6L/ah7b1z2tkAs
	 FfGLQ1LXWR7xxBPtoVgh9c7R1bQ312UGt2jWASMioTuSEjnr54TtokaIMKq7zMUiqV
	 lY0xjdZeN6T1oKRl7ACQzj5hOmFn2yPJvyIVvuakYaHIBXrjorUNy4+Kyk/uVbaYoG
	 Co/k3KNllbO5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51656C04E25;
	Mon,  4 Sep 2023 06:21:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: ipv6/addrconf: avoid integer underflow in
 ipv6_create_tempaddr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169380846531.7662.5513574099634997948.git-patchwork-notify@kernel.org>
Date: Mon, 04 Sep 2023 06:21:05 +0000
References: <20230901044219.10062-1-alexhenrie24@gmail.com>
In-Reply-To: <20230901044219.10062-1-alexhenrie24@gmail.com>
To: Alex Henrie <alexhenrie24@gmail.com>
Cc: netdev@vger.kernel.org, jbohac@suse.cz, benoit.boissinot@ens-lyon.org,
 davem@davemloft.net, hideaki.yoshifuji@miraclelinux.com, dsahern@kernel.org,
 pabeni@redhat.com, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 31 Aug 2023 22:41:27 -0600 you wrote:
> The existing code incorrectly casted a negative value (the result of a
> subtraction) to an unsigned value without checking. For example, if
> /proc/sys/net/ipv6/conf/*/temp_prefered_lft was set to 1, the preferred
> lifetime would jump to 4 billion seconds. On my machine and network the
> shortest lifetime that avoided underflow was 3 seconds.
> 
> Fixes: 76506a986dc3 ("IPv6: fix DESYNC_FACTOR")
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v3] net: ipv6/addrconf: avoid integer underflow in ipv6_create_tempaddr
    https://git.kernel.org/netdev/net/c/f31867d0d9d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



