Return-Path: <netdev+bounces-30052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC2E785BE9
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 17:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D17F1C20CE0
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 15:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E08AC2E4;
	Wed, 23 Aug 2023 15:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEA4AD42;
	Wed, 23 Aug 2023 15:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CC0EC433CA;
	Wed, 23 Aug 2023 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692804022;
	bh=B5eeEK5W55Em3qU8pGy5VFF9KO5gEdhoOLajNTGqkFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R9lXXKWaNz9N+vTMv5UX/mrFglo+6HkVOTBr1BCfB2iXPuwcQaiSHU2F4BthQu4cr
	 uepdwIE1PNnfV/K2UG7NGahvbB1/hpZOMb0B1z4KjVbT7IZLiZ7loRaLeD3AuYS1Vs
	 jf9F/kiv1qNMXYmQJY3jKUE5mP81YuaFHaO1gfABlfpbHPsd28U1T5tOFHbMuyd+pA
	 4zQROIli88pk4XOH7UOsIjsiiXlwwLzCrqOUt1BmP+Zk9FYKaUbKVOvaf8O6gU0Sts
	 GIY/3WTUj7bdwQnIfQI336OGtYL/KOiIKxRrjWQC09E8ETWnzEDtuvKqDfdUvtYpvn
	 Xyn9gbqJaTi0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4303CC395C5;
	Wed, 23 Aug 2023 15:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 0/3] ss: mptcp: print new info counters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169280402226.32621.2151909857968360089.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 15:20:22 +0000
References: <20230823-mptcp-issue-415-ss-mptcp-info-6-5-v1-0-fcaf00a03511@tessares.net>
In-Reply-To: <20230823-mptcp-issue-415-ss-mptcp-info-6-5-v1-0-fcaf00a03511@tessares.net>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 pabeni@redhat.com, aclaudi@redhat.com

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed, 23 Aug 2023 09:24:05 +0200 you wrote:
> Some MPTCP counters from mptcp_info structure have been added in the
> kernel but not in ss.
> 
> Before adding the new counters in patch 3/3, patch 1/3 makes sure all
> unsigned counters are displayed as unsigned. Patch 2/3 displays all seq
> related counters as decimal instead of hexadecimal.
> 
> [...]

Here is the summary with links:
  - [iproute2,1/3] ss: mptcp: display info counters as unsigned
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=0c3f1582d5b3
  - [iproute2,2/3] ss: mptcp: display seq related counters as decimal
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=cfa70237d62a
  - [iproute2,3/3] ss: mptcp: print missing info counters
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=505c65aa44c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



