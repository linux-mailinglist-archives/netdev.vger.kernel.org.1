Return-Path: <netdev+bounces-18806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA910758B31
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 04:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEDD1C20F1D
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 02:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FCC1FDF;
	Wed, 19 Jul 2023 02:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0961A20E7
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 02:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81DACC433CD;
	Wed, 19 Jul 2023 02:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689732622;
	bh=D4jJBa+TVMPHFik0QivCjqS1/RO4IGCwZnfbCVeuqUw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mMG74bwzxuDFq+lcUJ7w7lSLH27FHLf+X4KMXi7g87e5kobDrFEErjxtqY7NYQp9x
	 AkpBLMQ6koHQlTSDfMCdVXVoE8+tURZ3vm32aUpp6YXljGvBVNEzSN1GGtdOfT7+63
	 MfbNPj5+NcKdJCOx0rauUI8SHo4/JtbYYxxb8qbu3kXUshDDx7B39mEb/U9n6xN7ce
	 Xv179p2iS9o22m+cf4o36E8HgoTmcxlzkhl+PMlKgnQwxoM2N7rUAvhcKJBVfEK5MM
	 6flI5glvKyLt6arEDDR2EECSJFRO+wB6WBoOcb0Rv7BlqVQXEMtORbc/VjaV66/C2/
	 buM48U7VhRTgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57CFFE22AE7;
	Wed, 19 Jul 2023 02:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: get rid of sysctl_tcp_adv_win_scale
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168973262235.24960.6388490016229101876.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 02:10:22 +0000
References: <20230717152917.751987-1-edumazet@google.com>
In-Reply-To: <20230717152917.751987-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, soheil@google.com, ncardwell@google.com,
 ycheng@google.com, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jul 2023 15:29:17 +0000 you wrote:
> With modern NIC drivers shifting to full page allocations per
> received frame, we face the following issue:
> 
> TCP has one per-netns sysctl used to tweak how to translate
> a memory use into an expected payload (RWIN), in RX path.
> 
> tcp_win_from_space() implementation is limited to few cases.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: get rid of sysctl_tcp_adv_win_scale
    https://git.kernel.org/netdev/net-next/c/dfa2f0483360

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



