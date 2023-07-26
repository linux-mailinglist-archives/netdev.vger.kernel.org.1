Return-Path: <netdev+bounces-21141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 532C0762918
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 05:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836821C21084
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 03:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0416B15D0;
	Wed, 26 Jul 2023 03:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD96C1108
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F5E5C433C9;
	Wed, 26 Jul 2023 03:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690341020;
	bh=hMCPvZFKLanrr69pIj6onTahy0FPfqQtFdYlgvZi8yY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YimEVX3V/lBXfT96mJNBU5jx32jZYm5v4zTE705PjphtYXL2qupJSdfsRy2BevZ3u
	 3duXn+r4F2YEpcfAsD8TT29XmLB/N7Dfzcpp+YHtsEBHftnD3bs1eNMd721M/kbYi8
	 AtT/P50rsFFJgNCNiQ4NHh2UMp6pTRpGKFbBzBA2+twecVWj7sXcmJI54SDVp/z3xA
	 P8YmG+ZH8PJfYpD+38kc4IyMHRuLeUYJ8U7A0XLCmad1oA85W7Z3L28DD40ITTcahc
	 XScC9P1kymg2ix0UziIX9xLFBwsFLjeGI0rTtIlctyuquJoDOcXzMmnaivcjrQjpmy
	 b+RUFwz1fnP7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B4A7C73FE2;
	Wed, 26 Jul 2023 03:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] macvlan: add forgotten nla_policy for
 IFLA_MACVLAN_BC_CUTOFF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169034102003.18310.5663605946528991892.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jul 2023 03:10:20 +0000
References: <20230723080205.3715164-1-linma@zju.edu.cn>
In-Reply-To: <20230723080205.3715164-1-linma@zju.edu.cn>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 23 Jul 2023 16:02:05 +0800 you wrote:
> The previous commit 954d1fa1ac93 ("macvlan: Add netlink attribute for
> broadcast cutoff") added one additional attribute named
> IFLA_MACVLAN_BC_CUTOFF to allow broadcast cutfoff.
> 
> However, it forgot to describe the nla_policy at macvlan_policy
> (drivers/net/macvlan.c). Hence, this suppose NLA_S32 (4 bytes) integer
> can be faked as empty (0 bytes) by a malicious user, which could leads
> to OOB in heap just like CVE-2023-3773.
> 
> [...]

Here is the summary with links:
  - [v1] macvlan: add forgotten nla_policy for IFLA_MACVLAN_BC_CUTOFF
    https://git.kernel.org/netdev/net/c/55cef78c244d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



