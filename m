Return-Path: <netdev+bounces-23040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC20476A76B
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 05:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB6C328185C
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 03:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EADF1C33;
	Tue,  1 Aug 2023 03:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A651398;
	Tue,  1 Aug 2023 03:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8C53C433CC;
	Tue,  1 Aug 2023 03:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690860023;
	bh=R8XNStQlp0EGvcCW2i6RmASh0PhlCiaHydE7HfXLJAM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xd07znuSPk7MFrc1XPZdYEZoztNRaA8V+w/ZC+G/02NXKBhcOtAFn6s/2IRnTxsah
	 elGSCoytQQW94+1jrAYGBicvotO0lsekIJYMwh7F1Pa1xcEhfi9hCEWNwDF4tOgojv
	 UOKBwPYjAP3fnsB2omtgSKxM+BDVOz4JxnzpLG7CZkmrA4xxeY3VhUdfq46bClW0DQ
	 C0d5EQLWuEoCdmHWpqx9CspAaaQ7kJHUzKSUy07iVV0s+CKXSDQ6KYfPNCB3e2kKIV
	 k+iDBa7/v12q+KsCpNMTWUZjEx9P4NUJtQ/DFFQQKnj6GmQSu/SPMJlPQK7GEjy1jm
	 B5sVHyxIhszEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94D86E96AD8;
	Tue,  1 Aug 2023 03:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] mptcp: cleanup and improvements in the
 selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169086002360.11962.11662635682041144649.git-patchwork-notify@kernel.org>
Date: Tue, 01 Aug 2023 03:20:23 +0000
References: <20230730-upstream-net-next-20230728-mptcp-selftests-misc-v1-0-7e9cc530a9cd@tessares.net>
In-Reply-To: <20230730-upstream-net-next-20230728-mptcp-selftests-misc-v1-0-7e9cc530a9cd@tessares.net>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 30 Jul 2023 10:05:14 +0200 you wrote:
> This small series of 4 patches adds some improvements in MPTCP
> selftests:
> 
> - Patch 1 reworks the detailed report of mptcp_join.sh selftest to
>   better display what went well or wrong per test.
> 
> - Patch 2 adds colours (if supported, forced and/or not disabled) in
>   mptcp_join.sh selftest output to help spotting issues.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] selftests: mptcp: join: rework detailed report
    https://git.kernel.org/netdev/net-next/c/03668c65d153
  - [net-next,2/4] selftests: mptcp: join: colored results
    https://git.kernel.org/netdev/net-next/c/9466df1a27d5
  - [net-next,3/4] selftests: mptcp: pm_nl_ctl: always look for errors
    https://git.kernel.org/netdev/net-next/c/1dc88d241f92
  - [net-next,4/4] selftests: mptcp: userspace_pm: unmute unexpected errors
    https://git.kernel.org/netdev/net-next/c/6a5c8c69a4c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



