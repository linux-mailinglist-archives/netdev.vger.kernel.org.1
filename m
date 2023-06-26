Return-Path: <netdev+bounces-14057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C9B73EB80
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 22:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0C4280DD2
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 20:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B0114263;
	Mon, 26 Jun 2023 20:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CA2125AB
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 20:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 299BDC433C9;
	Mon, 26 Jun 2023 20:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687810223;
	bh=Qr2BoaHCmA8FAEwgeL4Ne/1sF3BIxNu04k17Wue2gbc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nfQZAIcxc021w4dPNIRTcLwtWVZW6iDse33xN5oAnOQBF9Bfisy0ZMod9YY0bm1qm
	 S2M6ExM8aizBT5fu3ipPU29XBE59NwcPx79qd40vlxzQXwUKOeBhgPwfNpBqIxvZwL
	 F695dl4LtO25iHX2wTEBbB3lsXDLJr1lDlFgsStrkbe5CstygwsuhFvDmPtcFfbO3N
	 OudMtG9RYbxjVRWN1g3Ql5Eb+7wAnhAwaclpT1kVjtlmbVlkPGV75JSVG2SM5yR6gI
	 WK7uPcF0BZsWgY07tBiLOi5CKwJUXPiVW4EJSXSO2PJxf6H98DqooY8BzX94H4iAFo
	 D4npw00+8ofhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B28EE537FE;
	Mon, 26 Jun 2023 20:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/8] ipvs: increase ip_vs_conn_tab_bits range for
 64BIT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168781022304.12712.2901963056439649933.git-patchwork-notify@kernel.org>
Date: Mon, 26 Jun 2023 20:10:23 +0000
References: <20230626064749.75525-2-pablo@netfilter.org>
In-Reply-To: <20230626064749.75525-2-pablo@netfilter.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Pablo Neira Ayuso <pablo@netfilter.org>:

On Mon, 26 Jun 2023 08:47:42 +0200 you wrote:
> From: Abhijeet Rastogi <abhijeet.1989@gmail.com>
> 
> Current range [8, 20] is set purely due to historical reasons
> because at the time, ~1M (2^20) was considered sufficient.
> With this change, 27 is the upper limit for 64-bit, 20 otherwise.
> 
> Previous change regarding this limit is here.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] ipvs: increase ip_vs_conn_tab_bits range for 64BIT
    https://git.kernel.org/netdev/net-next/c/04292c695f82
  - [net-next,2/8] ipvs: dynamically limit the connection hash table
    https://git.kernel.org/netdev/net-next/c/4f325e26277b
  - [net-next,3/8] netfilter: nft_payload: rebuild vlan header when needed
    https://git.kernel.org/netdev/net-next/c/de6843be3082
  - [net-next,4/8] netfilter: ipset: remove rcu_read_lock_bh pair from ip_set_test
    https://git.kernel.org/netdev/net-next/c/78aa23d0081b
  - [net-next,5/8] netfilter: nf_tables: permit update of set size
    https://git.kernel.org/netdev/net-next/c/96b2ef9b16cb
  - [net-next,6/8] netfilter: snat: evict closing tcp entries on reply tuple collision
    https://git.kernel.org/netdev/net-next/c/458972550287
  - [net-next,7/8] netfilter: nf_tables: Introduce NFT_MSG_GETSETELEM_RESET
    https://git.kernel.org/netdev/net-next/c/079cd633219d
  - [net-next,8/8] netfilter: nf_tables: limit allowed range via nla_policy
    https://git.kernel.org/netdev/net-next/c/a412dbf40ff3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



