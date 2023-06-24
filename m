Return-Path: <netdev+bounces-13753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729E073CD41
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 00:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A434B1C20965
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 22:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5829EAFD;
	Sat, 24 Jun 2023 22:20:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304CFF515
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 22:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8053C433C0;
	Sat, 24 Jun 2023 22:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687645219;
	bh=B4PKhRzD0DzZiaGNnDlQ18u7TbvuZU0YvIUDUGR0lRE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CvITJziA0KWDAyRpAQczHu4RYlSzY9yRy5z2rs61TLj8v8fYls2thCXrXDFb0FN0U
	 In8CdZXG7madUAUF1OeejxRiT08mqJIRglIwEJwcUWvPitHjRuk9QiZim4JOu9mYNh
	 RkoxQJG/Xsea9jAdi2Jj/NX/B0SQ7cXKrzjfRpWlEEZB1olbu6kwLnhentaOMb9nV+
	 7amstTljNlLkE4WqZVPqr4l3aITeu0DaafA70l2ImsyDDoW/ce6PSlRtIibQh3GjAw
	 Y5hmYuXWecxGKxbNOE/mxnlzSBE+DAwad3LvMe1XbZnLkYbc6tuMuHsU3xZk9J8G9o
	 7I6QQQ8dcawtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DDA4C395F1;
	Sat, 24 Jun 2023 22:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sch_netem: fix issues in netem_change() vs
 get_dist_table()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168764521950.22804.8223942836730395376.git-patchwork-notify@kernel.org>
Date: Sat, 24 Jun 2023 22:20:19 +0000
References: <20230622181503.2327695-1-edumazet@google.com>
In-Reply-To: <20230622181503.2327695-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 stephen@networkplumber.org, jhs@mojatatu.com, simon.horman@corigine.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jun 2023 18:15:03 +0000 you wrote:
> In blamed commit, I missed that get_dist_table() was allocating
> memory using GFP_KERNEL, and acquiring qdisc lock to perform
> the swap of newly allocated table with current one.
> 
> In this patch, get_dist_table() is allocating memory and
> copy user data before we acquire the qdisc lock.
> 
> [...]

Here is the summary with links:
  - [net] sch_netem: fix issues in netem_change() vs get_dist_table()
    https://git.kernel.org/netdev/net/c/11b73313c124

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



