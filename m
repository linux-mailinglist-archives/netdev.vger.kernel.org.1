Return-Path: <netdev+bounces-26684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E37877895A
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6991C21280
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE77453B9;
	Fri, 11 Aug 2023 09:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E252113
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 981E5C433D9;
	Fri, 11 Aug 2023 09:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691744424;
	bh=6HkZ14rxNckm2IMLL9JlA53nYCTTpxgs/GkWA7jwLbc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gYBIDRqjX/zEdrhRuCq/M1JirKTFx7+iVmxL+B76yj6XGNUMvyg3NDkHs+AmShc9L
	 hfGLZKmGkhE2LdYnTo//8IRcaUWxssIXViDeuDm/G+vlResKkpYKyvSJvDeTWOMtXx
	 gd/Gl+4vIkblNC3DlOG1eCHLdOl8U3LfV0VK9ESd70gPC4seKpyEZezIrVcvmjT13S
	 j4cgFdyO1YlMlQ4hwMyMgA9Ls/KZaGrzFDd4/5TcgmHfZfKyh/j9NsVfMf3+p7mcAQ
	 QhH05HmCLP9ToC82mIu05eV8optO4f0Muqwm3w0KYOgUQwmgOqoNmt8rCgkdRgO4nE
	 8tT0Ss6Xs8Ihg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B82EE21ECE;
	Fri, 11 Aug 2023 09:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mana: Add gdma stats to ethtool output for
 mana
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169174442450.10902.7270114450407172453.git-patchwork-notify@kernel.org>
Date: Fri, 11 Aug 2023 09:00:24 +0000
References: <1691640922-11362-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1691640922-11362-1-git-send-email-shradhagupta@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sharmaajay@microsoft.com,
 leon@kernel.org, tglx@linutronix.de, bigeasy@linutronix.de,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, mikelley@microsoft.com,
 shradhagupta@microsoft.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  9 Aug 2023 21:15:22 -0700 you wrote:
> Extended performance counter stats in 'ethtool -S <interface>'
> for MANA VF to include GDMA tx LSO packets and bytes count.
> 
> Tested-on: Ubuntu22
> Testcases:
> 1. LISA testcase:
> PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-Synthetic
> 2. LISA testcase:
> PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-SRIOV
> 3. Validated the GDMA stat packets and byte counters
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mana: Add gdma stats to ethtool output for mana
    https://git.kernel.org/netdev/net-next/c/ac3899c62296

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



