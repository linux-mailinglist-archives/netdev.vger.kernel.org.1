Return-Path: <netdev+bounces-15500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA9F748195
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 12:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBC6280F03
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 10:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CF94C91;
	Wed,  5 Jul 2023 10:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39DD20F4;
	Wed,  5 Jul 2023 10:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7181EC433CA;
	Wed,  5 Jul 2023 10:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688551223;
	bh=rfKwXHw/MObGrKQHHxQ3kXk+3dEtPedetkvV200qdBA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i7DLBNU9u74goYVpIpur4MOnr3DPPgafPqv3zyjUTrOLo7DxhosmRCu1pbSZ7PvSL
	 3Kdc6u+SuLg6v45+2FkhX37ZL0sRcMtxEuJWFVDrncyYySTIR07gr6wC67EaNlKaPp
	 voua6jvdKjCC7vLHuyP6p45Re2YdZQ4O53jfYTzham6f1Rh+4VbPMWs3Iw5RjBBPEh
	 nKmUBWhxKP9nCiUK/ksgfvIBWlN/+b6RMRa44F4cOhMsS7vJP8R7WoA/zg150hmlGN
	 70LtwZSQShBCSkwxtgHIS/a+54rAzVyfoB4OGO9DGIcpdWyqM2AMYi83blCE0P1OKL
	 OqLKfBnuiz05A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E528C0C40E;
	Wed,  5 Jul 2023 10:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/9] mptcp: fixes for v6.5
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168855122331.15504.15239551564077359539.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jul 2023 10:00:23 +0000
References: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-0-d7e67c274ca5@tessares.net>
In-Reply-To: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-0-d7e67c274ca5@tessares.net>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 fw@strlen.de, kishen.maloor@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org, cpaasch@apple.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 04 Jul 2023 22:44:32 +0200 you wrote:
> Here is a first batch of fixes for v6.5 and older.
> 
> The fixes are not linked to each others.
> 
> Patch 1 ensures subflows are unhashed before cleaning the backlog to
> avoid races. This fixes another recent fix from v6.4.
> 
> [...]

Here is the summary with links:
  - [net,1/9] mptcp: ensure subflow is unhashed before cleaning the backlog
    https://git.kernel.org/netdev/net/c/3fffa15bfef4
  - [net,2/9] mptcp: do not rely on implicit state check in mptcp_listen()
    https://git.kernel.org/netdev/net/c/0226436acf24
  - [net,3/9] selftests: mptcp: connect: fail if nft supposed to work
    https://git.kernel.org/netdev/net/c/221e4550454a
  - [net,4/9] selftests: mptcp: sockopt: use 'iptables-legacy' if available
    https://git.kernel.org/netdev/net/c/a5a5990c099d
  - [net,5/9] selftests: mptcp: sockopt: return error if wrong mark
    https://git.kernel.org/netdev/net/c/9ac4c28eb70c
  - [net,6/9] selftests: mptcp: userspace_pm: use correct server port
    https://git.kernel.org/netdev/net/c/d8566d0e0392
  - [net,7/9] selftests: mptcp: userspace_pm: report errors with 'remove' tests
    https://git.kernel.org/netdev/net/c/966c6c3adfb1
  - [net,8/9] selftests: mptcp: depend on SYN_COOKIES
    https://git.kernel.org/netdev/net/c/6c8880fcaa5c
  - [net,9/9] selftests: mptcp: pm_nl_ctl: fix 32-bit support
    https://git.kernel.org/netdev/net/c/61d965805026

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



