Return-Path: <netdev+bounces-61990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B778257EF
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 17:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC022847C7
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 16:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C352E829;
	Fri,  5 Jan 2024 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKzJld71"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139A7569F
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 16:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6808CC433C7;
	Fri,  5 Jan 2024 16:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704471624;
	bh=J2kT4hySqcltz6dCgHF2wMwz4TZBOMouFcTXJtI1ehI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JKzJld71wwqKsb69pyH4l/OS4NzNl+CPKD+F0w+1Qco6HB/9JoY9N7L8pqvHt3/nX
	 xJh1/h3mTNopKhUhZKpWjDOFRyH8Oaz3WqHFc8Kx9MLTRpgIB1ePicFTGiMBWSwK6g
	 pRXN4vMBNNQu6325u/DP07bL9itfRe2ufx/K2kF0gnzfg4vZqZTQIE7ByxXTUdrCpd
	 gPp8CdeGJwFQ8Mt62FtLqnxJ9NXkobg4U5qGWVKGf6tsvRApmDSEGI0JWI6ObgDuLj
	 iWyavh4ug2JbqVW9pKAZ1cPXt5yVbSQGEYHjbkkTy+65tMT1KYG8bGCpgIdpPWIrDG
	 Sn0J1J2Mfvcgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C093C4167E;
	Fri,  5 Jan 2024 16:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: act_ct: fix skb leak and crash on ooo frags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170447162430.14252.14016343998496544271.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jan 2024 16:20:24 +0000
References: <20231228081457.936732-1-taoliu828@163.com>
In-Reply-To: <20231228081457.936732-1-taoliu828@163.com>
To: Tao Liu <taoliu828@163.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, vladbu@nvidia.com, paulb@nvidia.com,
 netdev@vger.kernel.org, simon.horman@corigine.com, xiyou.wangcong@gmail.com,
 pablo@netfilter.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Dec 2023 16:14:57 +0800 you wrote:
> act_ct adds skb->users before defragmentation. If frags arrive in order,
> the last frag's reference is reset in:
> 
>   inet_frag_reasm_prepare
>     skb_morph
> 
> which is not straightforward.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: act_ct: fix skb leak and crash on ooo frags
    https://git.kernel.org/netdev/net/c/3f14b377d01d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



