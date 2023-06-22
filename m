Return-Path: <netdev+bounces-12926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00551739720
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF52928181C
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 06:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB5F525C;
	Thu, 22 Jun 2023 06:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9715245;
	Thu, 22 Jun 2023 06:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A435C433D9;
	Thu, 22 Jun 2023 06:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687413623;
	bh=SHn5tQe2jYazXUxFSxkxExMVYFmrrKKLAx5OU8zGQzM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pfBrxp6ZfSXM72a0vzcYyHLQx+uG67RMooZzUU8lg0FoPUBWlQDDNpeZRIQ+VCKEu
	 4Z/xjCooiNDoxumBumOr2a+JndmoPSRy4bfvxZ5yn+jSNqfAwH+4Wf3vS9q40faLS6
	 6LplXgqJU3bCeofuPfathMC3+wEC6yAah3SPiIQG0lHVwDECnY5CDOTlQTmhWbgEIH
	 IFpUT27swQuAmTxj4dmZE8603AOWFDSi8ILbTL7777keEMigTIApYVQfaRX37/Tg+n
	 ZcZuX1CVc/ljFhsUMAdJ2yjKhKrP7igN6rDtYTLv/WK+fQkZQ/jYbZ0UJlAT8psbmB
	 H8KLmgWb4DVxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32D09E2A034;
	Thu, 22 Jun 2023 06:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] mptcp: expose more info and small
 improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168741362320.8755.12586500995813300263.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jun 2023 06:00:23 +0000
References: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
In-Reply-To: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, geliang.tang@suse.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jun 2023 18:30:13 +0200 you wrote:
> Patch 1-3/9 track and expose some aggregated data counters at the MPTCP
> level: the number of retransmissions and the bytes that have been
> transferred. The first patch prepares the work by moving where snd_una
> is updated for fallback sockets while the last patch adds some tests to
> cover the new code.
> 
> Patch 4-6/9 introduce a new getsockopt for SOL_MPTCP: MPTCP_FULL_INFO.
> This new socket option allows to combine info from MPTCP_INFO,
> MPTCP_TCPINFO and MPTCP_SUBFLOW_ADDRS socket options into one. It can be
> needed to have all info in one because the path-manager can close and
> re-create subflows between getsockopt() and fooling the accounting. The
> first patch introduces a unique subflow ID to easily detect when
> subflows are being re-created with the same 5-tuple while the last patch
> adds some tests to cover the new code.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] mptcp: move snd_una update earlier for fallback socket
    https://git.kernel.org/netdev/net-next/c/c026d33b8f50
  - [net-next,2/9] mptcp: track some aggregate data counters
    https://git.kernel.org/netdev/net-next/c/38967f424b5b
  - [net-next,3/9] selftests: mptcp: explicitly tests aggregate counters
    https://git.kernel.org/netdev/net-next/c/5dcff89e1455
  - [net-next,4/9] mptcp: add subflow unique id
    https://git.kernel.org/netdev/net-next/c/6f06b4d4d1cc
  - [net-next,5/9] mptcp: introduce MPTCP_FULL_INFO getsockopt
    https://git.kernel.org/netdev/net-next/c/492432074e4f
  - [net-next,6/9] selftests: mptcp: add MPTCP_FULL_INFO testcase
    https://git.kernel.org/netdev/net-next/c/aa723d5b3541
  - [net-next,7/9] selftests: mptcp: join: skip check if MIB counter not supported (part 2)
    https://git.kernel.org/netdev/net-next/c/00079f18c24f
  - [net-next,8/9] mptcp: consolidate transition to TCP_CLOSE in mptcp_do_fastclose()
    https://git.kernel.org/netdev/net-next/c/bbd49d114d57
  - [net-next,9/9] mptcp: pass addr to mptcp_pm_alloc_anno_list
    https://git.kernel.org/netdev/net-next/c/528cb5f2a1e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



