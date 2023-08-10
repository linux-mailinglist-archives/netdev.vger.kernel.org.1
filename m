Return-Path: <netdev+bounces-26515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B25D777FD8
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5F01C21246
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA64021514;
	Thu, 10 Aug 2023 18:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D39620FBF
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D2D0C433C7;
	Thu, 10 Aug 2023 18:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691690422;
	bh=uvSuZ13YW1WPt7fE/E72Bjy5V5Eusa9pHgu2Ss+Db6Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SMUaMeedci5RbmQkLkAqI9gj6YWYwct3+Nfnop2nS97dk9OWYD4RzltXGJGNTet17
	 x13ZJWm2vKWAxyTxYqemW6sgIN6Ee8orZh0FOTGQjjuMqeID2dYKbGh0y7cb+ChVVr
	 Fwo84lH/ROW+QdfyCiQrZZJyaLcFTaHzN916Ug8/V95WiVICFU0IE51i/i5VYLVEPq
	 QXfxp2NC45iNejuQI/G/a160aKmrlPGF9r715WIAACJdGLVHWIXBhktLgOsUtbsHkZ
	 UJ1I8SyOlDtUlwfisnnzKtElZVNt5Ox6/m9XqQ4hIUXbzrLY8RTr4hA1A0wYkuMMHX
	 O7otfIG6P47Aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 726EFC64459;
	Thu, 10 Aug 2023 18:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/5] netfilter: nf_tables: don't skip expired elements
 during walk
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169169042246.11500.14866835870797630076.git-patchwork-notify@kernel.org>
Date: Thu, 10 Aug 2023 18:00:22 +0000
References: <20230810070830.24064-2-pablo@netfilter.org>
In-Reply-To: <20230810070830.24064-2-pablo@netfilter.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Pablo Neira Ayuso <pablo@netfilter.org>:

On Thu, 10 Aug 2023 09:08:26 +0200 you wrote:
> From: Florian Westphal <fw@strlen.de>
> 
> There is an asymmetry between commit/abort and preparation phase if the
> following conditions are met:
> 
> 1. set is a verdict map ("1.2.3.4 : jump foo")
> 2. timeouts are enabled
> 
> [...]

Here is the summary with links:
  - [net,1/5] netfilter: nf_tables: don't skip expired elements during walk
    https://git.kernel.org/netdev/net/c/24138933b97b
  - [net,2/5] netfilter: nf_tables: GC transaction API to avoid race with control plane
    https://git.kernel.org/netdev/net/c/5f68718b34a5
  - [net,3/5] netfilter: nf_tables: adapt set backend to use GC transaction API
    https://git.kernel.org/netdev/net/c/f6c383b8c31a
  - [net,4/5] netfilter: nft_set_hash: mark set element as dead when deleting from packet path
    https://git.kernel.org/netdev/net/c/c92db3030492
  - [net,5/5] netfilter: nf_tables: remove busy mark and gc batch API
    https://git.kernel.org/netdev/net/c/a2dd0233cbc4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



