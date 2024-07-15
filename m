Return-Path: <netdev+bounces-111411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB1B930D52
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 06:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F141F213D7
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 04:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD041836DF;
	Mon, 15 Jul 2024 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUoRr9gH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A4E1836D8;
	Mon, 15 Jul 2024 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721018433; cv=none; b=OYi/2/aJsqTIrNdWLZFcpgekIZryWBvI3osEmTDPF7j6x9EHgZnmEKC3lgoucJurnw+WBburHeHQBUE6zz7VOG6C07pABRkrk5ouAK2ywbMmZaxlhlMxHGI2lP0BPkNr/QPHD266iKwR7fLRPQnH2nIxFtP/eOJLOIABqec0QmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721018433; c=relaxed/simple;
	bh=/vzwV7HRYHzys+EVj+QnBgpvcTGEB5OGpRN370BoHOM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jo2gMwhne0SNpXu2WlzmtRqoiQXscVd9AzVcfn6H9kN4t9/xd/77yhgBmXvB52dRWtR7HL+6B8Qlt64hwqDlXE6sX3Xcmx8kZFh8WdoPxvDm6kq86bbzVDqTT7qwd6FN0KcLBJ6UqP+765O9aMoiBLPSbc18XjjFcK9aj/2fc6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUoRr9gH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEFD7C4AF0F;
	Mon, 15 Jul 2024 04:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721018432;
	bh=/vzwV7HRYHzys+EVj+QnBgpvcTGEB5OGpRN370BoHOM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iUoRr9gHdsUG87iRlVGiMS0N4NzXJ8d6SDmd+/UcptvUOhuiK+tp1guHXsgZtPHIm
	 BJpSvCrJ+b3bFvacmQtRg5cqOcwuducfGE1jbCTwb1Eaw/h0xHZ1KY8QtxFmg30FrW
	 0PnnO+VrFLSTsO+VQxpkNWbsC87dGCTZHmPljok2rGXCIiR919CISZTtlr2Ld+C9qB
	 8WQBIhult8yVnOgKoTqwLUDdwZwMZzq/MhlTcUWkBFdojlys0I9ycv9r7hh+0q57/z
	 rVXro1BSIhDfKhLxxVT8MiPXIljwCqEQEdWVKRJbwR6Q8MsRVaWe9a6thYkH4FxKmz
	 eGSsXh2unuREg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6A45C43614;
	Mon, 15 Jul 2024 04:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172101843287.2749.15465946602900508880.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 04:40:32 +0000
References: <20240712115325.54175-1-leitao@debian.org>
In-Reply-To: <20240712115325.54175-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, rbc@meta.com, horms@kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jul 2024 04:53:25 -0700 you wrote:
> After the commit bdacf3e34945 ("net: Use nested-BH locking for
> napi_alloc_cache.") was merged, the following warning began to appear:
> 
> 	 WARNING: CPU: 5 PID: 1 at net/core/skbuff.c:1451 napi_skb_cache_put+0x82/0x4b0
> 
> 	  __warn+0x12f/0x340
> 	  napi_skb_cache_put+0x82/0x4b0
> 	  napi_skb_cache_put+0x82/0x4b0
> 	  report_bug+0x165/0x370
> 	  handle_bug+0x3d/0x80
> 	  exc_invalid_op+0x1a/0x50
> 	  asm_exc_invalid_op+0x1a/0x20
> 	  __free_old_xmit+0x1c8/0x510
> 	  napi_skb_cache_put+0x82/0x4b0
> 	  __free_old_xmit+0x1c8/0x510
> 	  __free_old_xmit+0x1c8/0x510
> 	  __pfx___free_old_xmit+0x10/0x10
> 
> [...]

Here is the summary with links:
  - [net-next] virtio_net: Fix napi_skb_cache_put warning
    https://git.kernel.org/netdev/net-next/c/f8321fa75102

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



