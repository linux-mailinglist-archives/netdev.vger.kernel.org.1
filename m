Return-Path: <netdev+bounces-53742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0342F80451B
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 03:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A2DFB20326
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED66F20F8;
	Tue,  5 Dec 2023 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H57n9yXc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2B4CA58
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 02:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CB3FC433C8;
	Tue,  5 Dec 2023 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701744025;
	bh=Eq4A/LWka7uXN0IlYb+DI3bGBTJZiMJO4BXJOr8/xsk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H57n9yXcXz8gpZ1odXXFD56+T/z4NJwU4FdN961xWaAh83rJkobUXvE3bplJQUlNq
	 xKsCWjvsYXjRbmL4FetF6R9mMk+jElZAO4aMC+Kx4ZolmJ5wD7FyLKBtZl61mYhesU
	 OABZrrDQ3Wzi56xGxivlzsaRYq6xzJ+Sud6cox5QqX1g+5NkLm4jrchfXkCeZ4acKM
	 yCu337UhKokUxi9pYHXlQBonbvcR2HTkgqkk+SEqerhVddc0gn0jLyTIG0LkHuGz6n
	 mY0ODrgAY/oUvzORFQHovav1urRvX9PvEAruOD5SP0HXtyIb8oHwekbCYh0rkFDo4s
	 jG4oaqkMYaJ0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AD28DD4EEF;
	Tue,  5 Dec 2023 02:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v3] octeontx2-pf: consider both Rx and Tx packet stats for
 adaptive interrupt coalescing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170174402523.31470.12401024322897178687.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 02:40:25 +0000
References: <20231201053330.3903694-1-sumang@marvell.com>
In-Reply-To: <20231201053330.3903694-1-sumang@marvell.com>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 naveenm@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 1 Dec 2023 11:03:30 +0530 you wrote:
> From: Naveen Mamindlapalli <naveenm@marvell.com>
> 
> The current adaptive interrupt coalescing code updates only rx
> packet stats for dim algorithm. This patch also updates tx packet
> stats which will be useful when there is only tx traffic.
> Also moved configuring hardware adaptive interrupt setting to
> driver dim callback.
> 
> [...]

Here is the summary with links:
  - [net,v3] octeontx2-pf: consider both Rx and Tx packet stats for adaptive interrupt coalescing
    https://git.kernel.org/netdev/net/c/adbf100fc470

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



