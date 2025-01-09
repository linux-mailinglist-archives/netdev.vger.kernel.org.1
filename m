Return-Path: <netdev+bounces-156720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB5EA07978
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916F4168EBD
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 14:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00C521C18D;
	Thu,  9 Jan 2025 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTx51jou"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9C021C187
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736433616; cv=none; b=rmOqBQbBuhwIogzS5XZx3r6LeT3ytRsMzmQ5KtQjJDtslioPq2uzv4OB5Cmuwds6GDBvhYhE5vip46IdIROjN1x2xW17DmOzYpKvYK9JPYgitN/RG54MSdARTKbveQZdJO1Vzia79FsPC8NLQCk/3z4OShIJm5m0zWHhw9SS/lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736433616; c=relaxed/simple;
	bh=iJEECy/eroWjA2ykxeON0jF3V4Rhzz776t8sG+e2C1g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pJGwn/GwJ1xgF6NWuOeud2L1K2B+T3bQ8Y+xaT7hYVBPzqH1ENyMW7Sx8S2TFmoCgiNHakOwJqStmxQSW+fsaGUD4MM/30UyiHolqtY8xqvINN2j7qE7BX7gaSmKqlLy6s2eqSggEFpXzin/fBHVWBqt8VtzeiNsRVL2yaJpWc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTx51jou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD87C4CED3;
	Thu,  9 Jan 2025 14:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736433615;
	bh=iJEECy/eroWjA2ykxeON0jF3V4Rhzz776t8sG+e2C1g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QTx51jouX1nfv+WVJGLliBdMv/rFyzX1aG0fqGFTPszlY6izlGA41ewBe1wCViuXE
	 np4+He/BUjZFEiueWqayw7loWPxUrrWflk2umqGCz54XxnD4lvOkhTMwTV5q7M/7wW
	 gBqbCmOeLNP4IE5dNUipnOWWRdOZvytdAyWGtf7Zv4MVHilmcjl54DFvD1wh58QmxC
	 xdXdWyPaufad+sASOId69cxxwlMrNGijBBUrdXT9RDvnDo+apt+9b8rUvVNmoKOcgy
	 M2/Rbm8qhMRvmH3h7VzHYgga2Lsb6XGvED64LY57oEPXgvTwGV9inX4NiqA1ov0X4P
	 XEvDCP6p8sCnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEC8380A963;
	Thu,  9 Jan 2025 14:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] net: make sure we retain NAPI ordering on
 netdev->napi_list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173643363677.1351255.17071454721045090941.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 14:40:36 +0000
References: <20250107160846.2223263-1-kuba@kernel.org>
In-Reply-To: <20250107160846.2223263-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 willemdebruijn.kernel@gmail.com, sdf@fomichev.me

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  7 Jan 2025 08:08:38 -0800 you wrote:
> I promised Eric to remove the rtnl protection of the NAPI list,
> when I sat down to implement it over the break I realized that
> the recently added NAPI ID retention will break the list ordering
> assumption we have in netlink dump. The ordering used to happen
> "naturally", because we'd always add NAPIs that the head of the
> list, and assign a new monotonically increasing ID.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] net: make sure we retain NAPI ordering on netdev->napi_list
    https://git.kernel.org/netdev/net-next/c/d6c7b03497ee
  - [net-next,v2,2/8] netdev: define NETDEV_INTERNAL
    https://git.kernel.org/netdev/net-next/c/0b7bdc7fab57
  - [net-next,v2,3/8] netdevsim: support NAPI config
    https://git.kernel.org/netdev/net-next/c/00adf88b186f
  - [net-next,v2,4/8] netdevsim: allocate rqs individually
    https://git.kernel.org/netdev/net-next/c/915c82f842f9
  - [net-next,v2,5/8] netdevsim: add queue alloc/free helpers
    https://git.kernel.org/netdev/net-next/c/a565dd04a120
  - [net-next,v2,6/8] netdevsim: add queue management API support
    https://git.kernel.org/netdev/net-next/c/5bc8e8dbef27
  - [net-next,v2,7/8] netdevsim: add debugfs-triggered queue reset
    https://git.kernel.org/netdev/net-next/c/6917d207b469
  - [net-next,v2,8/8] selftests: net: test listing NAPI vs queue resets
    https://git.kernel.org/netdev/net-next/c/eb721f117e7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



