Return-Path: <netdev+bounces-23975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E200776E665
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6511C2145F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F2915AFA;
	Thu,  3 Aug 2023 11:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB9A8F7C
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D040EC433CA;
	Thu,  3 Aug 2023 11:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691061020;
	bh=ZM6srAz7iS9kwiZHQUQLWj1QVWOLIa8qIiy8vt/q1xc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rizXe8+Ucmv6dvWsNhwGwrTwv6pyqZx0xlYk7LMJG9RZ7L+A816JRYVbmxBJjx2O3
	 cIYQsJuN5kqo5NPYCB/8KbB9Os6LnVUZTA8f0/MmVMrRsaYP1z2FmZBs2hli6zLL1m
	 2kylR3ckXEr8JwZULYzQL/geaVMGHbECdEj94G4DlW9nlJM6vC8YDpsMVratB9/bw/
	 IYCMk4RWlI1JuaVieZg2DI/8qLHUTv0mPuawPEh1jqyDRp1alZaNUbHQRH7/hsTdQA
	 JjBLTTP20iFwjzUS3QmpGpoqWoBvy1/4MIwink+OPmvu8Ijho0/Z+bJVVK5IkIE3DW
	 MzBnl5TLSELoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF0DBC3274D;
	Thu,  3 Aug 2023 11:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tipc: Remove unused function declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169106102071.8585.16493259766116573750.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 11:10:20 +0000
References: <20230802034659.39840-1-yuehaibing@huawei.com>
In-Reply-To: <20230802034659.39840-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 lucien.xin@gmail.com, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 2 Aug 2023 11:46:59 +0800 you wrote:
> Commit d50ccc2d3909 ("tipc: add 128-bit node identifier") declared but never
> implemented tipc_node_id2hash().
> Also commit 5c216e1d28c8 ("tipc: Allow run-time alteration of default link settings")
> never implemented tipc_media_set_priority() and tipc_media_set_window(),
> commit cad2929dc432 ("tipc: update a binding service via broadcast") only declared
> tipc_named_bcast().
> 
> [...]

Here is the summary with links:
  - [net-next] tipc: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/c956910d5af1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



