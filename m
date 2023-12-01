Return-Path: <netdev+bounces-52896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7287980096B
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 12:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2D91F20F8B
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 11:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FE621105;
	Fri,  1 Dec 2023 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kxpc7PsU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51606210F4;
	Fri,  1 Dec 2023 11:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1EAFC433CA;
	Fri,  1 Dec 2023 11:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701429024;
	bh=PXhKkK67oIWsxhXAaOKvIKniepSLh2qo4iOSwGzwesE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kxpc7PsUJa5HPsw4gS7M8GUgZ3b8hXyyO41W+pk34t1RgSKpN/KalTnWGsjTVKJFT
	 1W4K5RgdVumLRy1lL/1Xq2HT5nCer2zPHCFLuQRq5B3JipqIbuv438nILyVkGMsO7p
	 VxDxHfI2SxdVCf9VUyEjOVYUMtWWDoL0q+NTb23kCt62/2IwKG01YOYAPwIlejb9l9
	 G3/NzneQ8brhuRoqDNFg2hgtlMwge3zXEPi6XJeKtw/F39XndBWI6D08dgZU7S/AP5
	 uWHGdQ4YknrRJuyFuvgK1LX0S4J7Ik4xbUxW/WnQAVfchHtXKyBvHw6YDeL1Qwdptn
	 wtK8jXKoQEzNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE107C4166E;
	Fri,  1 Dec 2023 11:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: exclude 9p from networking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170142902377.13641.3703303468178395976.git-patchwork-notify@kernel.org>
Date: Fri, 01 Dec 2023 11:10:23 +0000
References: <20231128145916.2475659-1-kuba@kernel.org>
In-Reply-To: <20231128145916.2475659-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, nogikh@google.com, ericvh@kernel.org, lucho@ionkov.net,
 asmadeus@codewreck.org, linux_oss@crudebyte.com, v9fs@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 28 Nov 2023 06:59:15 -0800 you wrote:
> We don't have much to say about 9p, even tho it lives under net/.
> Avoid CCing netdev.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: Eric Van Hensbergen <ericvh@kernel.org>
> CC: Latchesar Ionkov <lucho@ionkov.net>
> CC: Dominique Martinet <asmadeus@codewreck.org>
> CC: Christian Schoenebeck <linux_oss@crudebyte.com>
> CC: v9fs@lists.linux.dev
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: exclude 9p from networking
    https://git.kernel.org/netdev/net/c/cf50b5cae847

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



