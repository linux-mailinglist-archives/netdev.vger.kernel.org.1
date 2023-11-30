Return-Path: <netdev+bounces-52650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 496F97FF937
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 19:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0E61C20A5D
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 18:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B444E59172;
	Thu, 30 Nov 2023 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="up3s8Uig"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7B5916B
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 18:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5348CC433C9;
	Thu, 30 Nov 2023 18:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701368426;
	bh=5oQfWfo9n3puYXukpKuGX9ycyMOGM53aoPGF8dw/Pl8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=up3s8Uigb2LJHwWF9M+SJSUo94S4ph7aPC5KxslXsbg4kzy1sFLIF7DyIHpGlg5pa
	 k1U5OswpB1VHvFz4Sju4+AGA4EeGdXjg/i3Q3QEUxyGTurjdAw9gqY4NMLRuWp+lBn
	 3txKH3rkJGzW1lvdSKbgD33FNiEHr0EtSWMbjv3UtBuAs6GGclHbd7iicmHD6Uqyj8
	 k5eq1MWBiGbVg/iwicZigV7Qukp35Sh62YaQ/WgHlW89RPmhrNfqLyFw86nBIvX0tW
	 +tcwkQgwzhIFEPtNng+WLc4swe6HGXZ9YeFdaAL2XMteiQioycG/0PedZudIvryNaJ
	 N9aIg18PkS9ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39176DFAA82;
	Thu, 30 Nov 2023 18:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: page_pool: fix general protection fault in
 page_pool_unlist
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170136842622.17358.1745471454100165762.git-patchwork-notify@kernel.org>
Date: Thu, 30 Nov 2023 18:20:26 +0000
References: <20231130092259.3797753-1-edumazet@google.com>
In-Reply-To: <20231130092259.3797753-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Nov 2023 09:22:59 +0000 you wrote:
> syzbot was able to trigger a crash [1] in page_pool_unlist()
> 
> page_pool_list() only inserts a page pool into a netdev page pool list
> if a netdev was set in params.
> 
> Even if the kzalloc() call in page_pool_create happens to initialize
> pool->user.list, I chose to be more explicit in page_pool_list()
> adding one INIT_HLIST_NODE().
> 
> [...]

Here is the summary with links:
  - [net-next] net: page_pool: fix general protection fault in page_pool_unlist
    https://git.kernel.org/netdev/net-next/c/f9893fdac319

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



