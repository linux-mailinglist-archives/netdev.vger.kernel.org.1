Return-Path: <netdev+bounces-24594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59020770C00
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 00:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897931C2174B
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 22:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E761C253AE;
	Fri,  4 Aug 2023 22:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8C61DA31;
	Fri,  4 Aug 2023 22:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6FCAC433CC;
	Fri,  4 Aug 2023 22:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691188822;
	bh=viJvzKCYhnnEJkDUh8kUaB3lgnY2RkYgHxBnD66dVQw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gvTQ1gidWx/zrSUmzLXp+S6P74yQKoqqIqviT8MKDgH4q0cGj4pgM9dZFCgt1UmV/
	 bE3PZAQ51kjOg6dDwyLZzXaHG8576CpFxTQv9msl1vNf4ymBZjApvZZuA8jTCjyafz
	 l0cAFPzzuQROYMBQMQ4bRBuoae3ZD3nMcPoGFv0tMIWKs72NJCcErD9ENncfH0a3tE
	 vNfne0brfnpWTdO90UIikcXCVSG8qK6nF0k7r7HzsnFVvzuAQQVTn98m2yNzFmXUJX
	 ehbLmquBbLKdXcEIIvkjV3T6/AuEy/rMGXtL0kAaxXNF7Qu3OhFIshMF0k2HAjpAz9
	 H3G1j5OApzX7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF9BBC64458;
	Fri,  4 Aug 2023 22:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] mptcp: fix the incorrect judgment for msk->cb_flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169118882271.4114.18105742009856428701.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 22:40:22 +0000
References: <20230803072438.1847500-1-xiangyang3@huawei.com>
In-Reply-To: <20230803072438.1847500-1-xiangyang3@huawei.com>
To: Xiang Yang <xiangyang3@huawei.com>
Cc: matthieu.baerts@tessares.net, martineau@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, mptcp@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 3 Aug 2023 07:24:38 +0000 you wrote:
> Coccicheck reports the error below:
> net/mptcp/protocol.c:3330:15-28: ERROR: test of a variable/field address
> 
> Since the address of msk->cb_flags is used in __test_and_clear_bit, the
> address should not be NULL. The judgment for if (unlikely(msk->cb_flags))
> will always be true, we should check the real value of msk->cb_flags here.
> 
> [...]

Here is the summary with links:
  - [-next] mptcp: fix the incorrect judgment for msk->cb_flags
    https://git.kernel.org/netdev/net/c/17ebf8a4c38b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



