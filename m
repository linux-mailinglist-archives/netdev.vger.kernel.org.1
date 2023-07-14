Return-Path: <netdev+bounces-17765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA419753015
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 05:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1434E1C214C1
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 03:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF01F440C;
	Fri, 14 Jul 2023 03:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872B91C28;
	Fri, 14 Jul 2023 03:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E040C433CA;
	Fri, 14 Jul 2023 03:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689306023;
	bh=qIaxLF9EaBI3XUjzGEZTW/UB155qI1yMDTOXYf+dj30=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S8+8KSrERAWbtokp3Sw2bbPmU0UNUZu0kYSFYYb/hQz20xwOgB60oxCfWqZJakp9o
	 kYh874Oi4U19SrroNRTDg7YXm1nsqKApnr6KdvsQdK+pvpM78WD4TRRQ4lv9Vzpsa6
	 b9yFQXj3iSS4dW8YxiOHFi+H4ZaXXi43NvLxqAYbSEYwudpvZ/70YKbakkKRbeheTT
	 Bo6wBq0LseWDefVvvXXnfBpFhJZ3pB7ScQ/quWiRCWNqd50I+dNdr9CaBggzvPNoy4
	 UyjL3xH6HjZoSPAkppw/SQLFye1KkSKyIK1grVjm1gXLYTegHBTqyWQ8FsV3oiusjX
	 6GJOABC56eZgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3490DE4D002;
	Fri, 14 Jul 2023 03:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] selftests: mptcp: join: pass args in new env
 vars
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168930602321.1851.14129799139703386002.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jul 2023 03:40:23 +0000
References: <20230712-upstream-net-next-20230712-selftests-mptcp-use-local-env-v1-0-f1c8b62fbf95@tessares.net>
In-Reply-To: <20230712-upstream-net-next-20230712-selftests-mptcp-use-local-env-v1-0-f1c8b62fbf95@tessares.net>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 geliang.tang@suse.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Jul 2023 18:03:15 +0200 you wrote:
> In this series, Geliang did some refactoring in the mptcp_join.sh file.
> 
> Patch 1 reduces the scope of some global env vars, only used by some
> tests: easier to deal with.
> 
> Patch 2 uses a dedicated env var for fastclose case instead of re-using
> addr_nr_ns2 with embedded info, clearer.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] selftests: mptcp: set all env vars as local ones
    https://git.kernel.org/netdev/net-next/c/662aa22d7dcd
  - [net-next,2/4] selftests: mptcp: add fastclose env var
    https://git.kernel.org/netdev/net-next/c/080b7f5733fd
  - [net-next,3/4] selftests: mptcp: add fullmesh env var
    https://git.kernel.org/netdev/net-next/c/4aadde088a58
  - [net-next,4/4] selftests: mptcp: add speed env var
    https://git.kernel.org/netdev/net-next/c/e571fb09c893

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



