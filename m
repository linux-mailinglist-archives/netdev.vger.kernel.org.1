Return-Path: <netdev+bounces-61441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C883823AEF
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 04:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E6B287F9A
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 03:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA01F5394;
	Thu,  4 Jan 2024 03:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMlIkeqf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850185226;
	Thu,  4 Jan 2024 03:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0790CC433CC;
	Thu,  4 Jan 2024 03:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704337227;
	bh=Xz7Lo2G6S9Q9d+YnRqtsp3GSYzUccrpjzZzkNsKMJQU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BMlIkeqfTyLY5qNT9JrXH05lA472oJprI7ddpZ2Gmar+AOilyM72K2xNiY0ohcxQV
	 bY+J+g7qLc5TCrRcj2JSIfZh7Fa8241M/VAjQnmk+dqv/0meNauCAYdPjlgQSDGXu9
	 qqEBU2nY+LGo+C0a5qewmNzGXiZ7t3ctltEyGS8bLdr1dNegNVGH/Rj9Vg/IMBCc4j
	 jKVt8posv5TnX2vEDxOm3mixbam4mOD5/hSfItKpCfqwskc5wdonPniAT24+eeJXYe
	 SSwko2JJMQBEMPBOxllWnOgXcTztxShOwmnzKArF5WOZ7w6l1SMP//taSM68LRKlYp
	 +OsvE12J9tgjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF9D9DCB6FF;
	Thu,  4 Jan 2024 03:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: kcm: fix direct access to bv_len
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170433722691.32402.14744164078319972525.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 03:00:26 +0000
References: <20240102205959.794513-1-almasrymina@google.com>
In-Reply-To: <20240102205959.794513-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jan 2024 12:59:58 -0800 you wrote:
> Minor fix for kcm: code wanting to access the fields inside an skb
> frag should use the skb_frag_*() helpers, instead of accessing the
> fields directly.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: kcm: fix direct access to bv_len
    https://git.kernel.org/netdev/net-next/c/b15a4cfe100b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



