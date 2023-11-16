Return-Path: <netdev+bounces-48274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39EB7EDE77
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 11:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33C71C2084C
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 10:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593232CCD9;
	Thu, 16 Nov 2023 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3Ckb7P9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6482CCB2
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 10:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2A54C433C7;
	Thu, 16 Nov 2023 10:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700130572;
	bh=sYxm+o9mysruVaMMu8BHgciGInB8OETPhkga4z0YhmU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q3Ckb7P9p719w4kQjKkUo4DZe1Y2NpHUoZ1RlYEnbUQaeZfTxjQ9t08lvQx9pl1TL
	 AOyCXkck4YobQmQNYC/k2yYHufodJfnFwBrjmsT8SnbfLpKEwvVMFNacsrTJohacuL
	 G8etXrVVjJSVVlVoKCVBTXjtjVBud8rmspKqEdKYCUa2CbQgT+QI7AULDsx8OTj482
	 RIGr26aXVfDI8UHeGdiJ7dwJenywcvDS2UFE7ux8X/xoU/8y62rxOiNJ3tbK21MjbG
	 AS2rG+gE42gpiFBAAjMYguQFu/2g756LgB5qKrodo1E+b+InOcq26P/Ih+mt8ySQtc
	 9+z1OhMLXELxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2ACFC4166E;
	Thu, 16 Nov 2023 10:29:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/6] netfilter: nft_set_rbtree: Remove unused variable
 nft_net
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170013057266.29188.8784130938113311187.git-patchwork-notify@kernel.org>
Date: Thu, 16 Nov 2023 10:29:32 +0000
References: <20231115184514.8965-2-pablo@netfilter.org>
In-Reply-To: <20231115184514.8965-2-pablo@netfilter.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, fw@strlen.de

Hello:

This series was applied to netdev/net.git (main)
by Pablo Neira Ayuso <pablo@netfilter.org>:

On Wed, 15 Nov 2023 19:45:09 +0100 you wrote:
> From: Yang Li <yang.lee@linux.alibaba.com>
> 
> The code that uses nft_net has been removed, and the nft_pernet function
> is merely obtaining a reference to shared data through the net pointer.
> The content of the net pointer is not modified or changed, so both of
> them should be removed.
> 
> [...]

Here is the summary with links:
  - [net,1/6] netfilter: nft_set_rbtree: Remove unused variable nft_net
    https://git.kernel.org/netdev/net/c/67059b61597c
  - [net,2/6] netfilter: nf_conntrack_bridge: initialize err to 0
    https://git.kernel.org/netdev/net/c/a44af08e3d4d
  - [net,3/6] netfilter: nf_tables: fix pointer math issue in nft_byteorder_eval()
    https://git.kernel.org/netdev/net/c/c301f0981fdd
  - [net,4/6] netfilter: nf_tables: bogus ENOENT when destroying element which does not exist
    https://git.kernel.org/netdev/net/c/a7d5a955bfa8
  - [net,5/6] netfilter: ipset: fix race condition between swap/destroy and kernel side add/del/test
    https://git.kernel.org/netdev/net/c/28628fa952fe
  - [net,6/6] netfilter: nf_tables: split async and sync catchall in two functions
    https://git.kernel.org/netdev/net/c/8837ba3e58ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



