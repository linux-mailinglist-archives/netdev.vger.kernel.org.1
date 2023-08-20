Return-Path: <netdev+bounces-29154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F71781D79
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 12:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F631C208BA
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 10:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0CB53B1;
	Sun, 20 Aug 2023 10:49:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C423D4
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 10:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34C6AC433C9;
	Sun, 20 Aug 2023 10:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692528566;
	bh=Ty0QsN4+gA2/QZ/57Spnq95DCQRwiWTnZ3Im6c9P+6s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZqyI2rpRABqa0fCgLjl2HjluyjizHLtX8sIQhiv48nUEWxJWMCNd8x/+9dwn+9nkm
	 MUmHZnjTsJhsg+wj6r82GT654NLqx2LgwWL3IKuDLS7grNI3YkaNQxhqojs2xi0ZsQ
	 Ou0QeH7jhmSbeLpOe73MWvAcC1d3d6IY3zeLDVdjBuG8rLwa7MD05F5GaLAFsWagAi
	 Em1JdHtQ6lTkCvuv57NnK9FMBeTOZkBSu5pLI5zQCPUHVQvUY72zd9Kap/V4ueYuqr
	 RSwFewZ91LQzWkhO0zdBcXrGNyuMSR+y4zwwFc7vFoMgslPkOsj/H3CEK2/+1OJazO
	 J1atQYdqcOFaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21DE8E93B34;
	Sun, 20 Aug 2023 10:49:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] ipv4: fix data-races around inet->inet_id
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169252856613.3170.7649745027254680443.git-patchwork-notify@kernel.org>
Date: Sun, 20 Aug 2023 10:49:26 +0000
References: <20230819031707.312225-1-edumazet@google.com>
In-Reply-To: <20230819031707.312225-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 19 Aug 2023 03:17:07 +0000 you wrote:
> UDP sendmsg() is lockless, so ip_select_ident_segs()
> can very well be run from multiple cpus [1]
> 
> Convert inet->inet_id to an atomic_t, but implement
> a dedicated path for TCP, avoiding cost of a locked
> instruction (atomic_add_return())
> 
> [...]

Here is the summary with links:
  - [v2,net] ipv4: fix data-races around inet->inet_id
    https://git.kernel.org/netdev/net/c/f866fbc842de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



