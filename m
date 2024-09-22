Return-Path: <netdev+bounces-129202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4AD97E2F1
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 21:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6731B21000
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 19:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD5C2CCAA;
	Sun, 22 Sep 2024 19:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fizMX9st"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEFD6AA7;
	Sun, 22 Sep 2024 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727031627; cv=none; b=g6qGvSYDaG5HbDL+Pe1psEKgtSmQeKdnG20duyAWs+SoEgQmnE4SEmDtVfLTVZf7OOMEzclwfHr2KOPN8j3aT4mxK+27n6FpBBdAk7y9ptY/2nJskbR75HbYkmmalqRBYAlwOL+lI9bZAYUcl3BMlve8mqoLHGVkM6cXRGK4mUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727031627; c=relaxed/simple;
	bh=qbjUX2exvh1Fjhx27QOtodw5p57GnEZdWqSE5L8X3ig=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nyzn4Q3U4qb1fW4ub1SeiwLVm9ZmkRbCp8suXTi3+k0TUl8NF5ssmbkWN4nvx8A0knuilLN4jYzBkrBsu88jky972TirNyiFSqh/B9riqZ4ngtCW8PQeuRub93ikFHsg9dn6C5EUwq5VfdSJoukPf4tpymUY+oiMODRCZ3vqC/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fizMX9st; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EB8C4CEC3;
	Sun, 22 Sep 2024 19:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727031626;
	bh=qbjUX2exvh1Fjhx27QOtodw5p57GnEZdWqSE5L8X3ig=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fizMX9stz9DWI4OkVhZXDLvrsNS2NVFyNAJDuDJ6BebCpjv9nHf70hq5TqFTj1pZD
	 al7a4PYfI/mmmWuZHRluYUOQ4+VsjDA7ajDZV4G0bmW7JVj/l7XIBFFk+Lo+EqgaiV
	 +Jp0qIYlriQJ0swVO2uSrV4nceF4EyjMNLvF5hzY5x/gn0t4LqhF05NJ0iJF3W5pdY
	 x1163YznP/FnkNrGY3E9orqM+cds4b++fv/BF5qgkCfm6ltqqN99N/yvckGWoTUwOR
	 4q0YviryawAds3Hsrdx5p+gMFrraQpiTcPTaLbCgqkTFMatwarJonCGwhsapktNYZp
	 +qm9030+FyBxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C733806655;
	Sun, 22 Sep 2024 19:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ipv6: select DST_CACHE from IPV6_RPL_LWTUNNEL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172703162901.2820125.2053441078890055489.git-patchwork-notify@kernel.org>
Date: Sun, 22 Sep 2024 19:00:29 +0000
References: <20240916-ipv6_rpl_lwtunnel-dst_cache-v2-1-e36be2c3a437@linutronix.de>
In-Reply-To: <20240916-ipv6_rpl_lwtunnel-dst_cache-v2-1-e36be2c3a437@linutronix.de>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Cthomas=2Eweissschuh=40linutronix=2Ede=3E?=@codeaurora.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alex.aring@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 16 Sep 2024 20:57:13 +0200 you wrote:
> The rpl sr tunnel code contains calls to dst_cache_*() which are
> only present when the dst cache is built.
> Select DST_CACHE to build the dst cache, similar to other kconfig
> options in the same file.
> Compiling the rpl sr tunnel without DST_CACHE will lead to linker
> errors.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ipv6: select DST_CACHE from IPV6_RPL_LWTUNNEL
    https://git.kernel.org/netdev/net/c/93c21077bb9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



