Return-Path: <netdev+bounces-92683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFC98B8412
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 03:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0481F230A9
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8604363C7;
	Wed,  1 May 2024 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6JP1Wja"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56744522A
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714528230; cv=none; b=NC97mkx2n+3rJuo19q1G7Am53R9oNcI/GRuu/P4G/OEcU7uYfNHUVsc7FIMpN+hFt6LZfUWcQlts4YvHGR/YA4nceFJKPhfa4Zcn/2ZTBDQhQpgsK+eNFoV74w4gaxFxMcJZrJ6cE6mHOOm5z71SNX/OuExehaF8qVXRVgf9/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714528230; c=relaxed/simple;
	bh=M+Qx5FN9HOLbZ/WKW7GJi5c/Qs0pnNYq52TwwTeosZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ss7BKU6M++6KR+4/COZg33lJmt2/5waxWnds3ZrP0rAeH8waMioNCqpzjVXLJMwGgJT+1ILLzc4d7HxnzxJ4wCnuUlImuHTiOkm1+N0xhZtZSSZf2vvMF6EWsqw3a/lD2kaPiZoTPKmkpx1iTQvg1XrAnGQSMHOCMGaijkxJfmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6JP1Wja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C854EC4AF48;
	Wed,  1 May 2024 01:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714528229;
	bh=M+Qx5FN9HOLbZ/WKW7GJi5c/Qs0pnNYq52TwwTeosZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i6JP1Wja26HkUr+l5ot+pXPywk2fKvSmpAUDO09anyd1ljNFn9YKdvvm8FPjZOaGG
	 62ap8/ncb9Fsg0IZMakc2ukwgQ3SwRAjGH3QFm7e+hA5xaYqGCRUu+Dg1vLkWKfOBo
	 UgvIxzhC30YNTvtCSG5tCBHUE7VWF7Lr/rUSPjvtUrVCuMyLGFccw6ILkqieUL2ogd
	 6MbUMGAP2c2A+toge/aK1ME3YgVJI3ILTgxgQH9XXygYN48ucyMEouubY7IZMt3m8i
	 TM7RxEaqTok3DVZJr1pdU8a1aqJL6WgsSoX+DvFgdukIlmwo0WCT2hDSyio3PaFoDT
	 6R2B1jhJjXyvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCC74C433E9;
	Wed,  1 May 2024 01:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] inet: introduce dst_rtable() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171452822977.22205.12940447951912192234.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 01:50:29 +0000
References: <20240429133009.1227754-1-edumazet@google.com>
In-Reply-To: <20240429133009.1227754-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Apr 2024 13:30:09 +0000 you wrote:
> I added dst_rt6_info() in commit
> e8dfd42c17fa ("ipv6: introduce dst_rt6_info() helper")
> 
> This patch does a similar change for IPv4.
> 
> Instead of (struct rtable *)dst casts, we can use :
> 
> [...]

Here is the summary with links:
  - [net-next] inet: introduce dst_rtable() helper
    https://git.kernel.org/netdev/net-next/c/05d6d492097c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



