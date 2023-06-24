Return-Path: <netdev+bounces-13763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E540A73CD4F
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 00:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2640C281149
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 22:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2216179D1;
	Sat, 24 Jun 2023 22:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8886DA939;
	Sat, 24 Jun 2023 22:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD23FC433CA;
	Sat, 24 Jun 2023 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687646424;
	bh=K86mZI8N6UbjhVQdXUNDiUpIwUPbWBlJmA42eX8wF18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F7usb2f7+HNAVTZ7aibl+NyDCAVTGa8OKWcPCzKHFV2gkv4u0vXCqDgwSGZTkBMW+
	 5ZKvuh2J0ItL0Sn//21yORZRsJ4+YupoNni/rsrvSDUaaZ/FfTQVQSsDvQbSN4o0oM
	 WNFMxKBhk75YqmCz4YlUJo7JkADVDATrQnjzEs+ANY/gAbPBWEtCn/T3GtlPw2ekQJ
	 nenl6/EHPUGsuz3nJ+MUOaTBSy5ioPedVAIlmtGJSZGB0QOuNKfRXszpbT7IuJ2Qux
	 ahnlvZFU1zOQ2fg6ynpfupIelDQweFSL3hkoo3YNd/LmpOiNIPBWxfjQh8KIP1z93E
	 9utXJSw9Wakng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D20EC395F1;
	Sat, 24 Jun 2023 22:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] selftests: mptcp: Refactoring and minor fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168764642457.414.3013119023826690334.git-patchwork-notify@kernel.org>
Date: Sat, 24 Jun 2023 22:40:24 +0000
References: <20230623-send-net-next-20230623-v1-0-a883213c8ba9@kernel.org>
In-Reply-To: <20230623-send-net-next-20230623-v1-0-a883213c8ba9@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: matthieu.baerts@tessares.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, geliang.tang@suse.com, shamrocklee@posteo.net

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Jun 2023 10:34:06 -0700 you wrote:
> Patch 1 moves code around for clarity and improved code reuse.
> 
> Patch 2 makes use of new MPTCP info that consolidates MPTCP-level and
> subflow-level information.
> 
> Patches 3-7 refactor code to favor limited-scope environment vars over
> optional parameters.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] selftests: mptcp: test userspace pm out of transfer
    https://git.kernel.org/netdev/net-next/c/4369c198e599
  - [net-next,2/8] selftests: mptcp: check subflow and addr infos
    https://git.kernel.org/netdev/net-next/c/d7ced753aa85
  - [net-next,3/8] selftests: mptcp: set FAILING_LINKS in run_tests
    https://git.kernel.org/netdev/net-next/c/be7e9786c915
  - [net-next,4/8] selftests: mptcp: drop test_linkfail parameter
    https://git.kernel.org/netdev/net-next/c/0c93af1f8907
  - [net-next,5/8] selftests: mptcp: drop addr_nr_ns1/2 parameters
    https://git.kernel.org/netdev/net-next/c/595ef566a2ef
  - [net-next,6/8] selftests: mptcp: drop sflags parameter
    https://git.kernel.org/netdev/net-next/c/1534f87ee0dc
  - [net-next,7/8] selftests: mptcp: add pm_nl_set_endpoint helper
    https://git.kernel.org/netdev/net-next/c/9e9d176df8e9
  - [net-next,8/8] selftests: mptcp: connect: fix comment typo
    https://git.kernel.org/netdev/net-next/c/e6b8a78ea266

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



