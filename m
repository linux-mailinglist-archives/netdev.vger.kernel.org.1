Return-Path: <netdev+bounces-116675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544F394B580
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D2C1F22CFF
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 03:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4707A27453;
	Thu,  8 Aug 2024 03:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQne4MSX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFB013A88D;
	Thu,  8 Aug 2024 03:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723087841; cv=none; b=GeOZ+vGj2Q04cy/O/AdV7hUgTCGEyfgIkPAMeyJtTPCsdT+I/ftx8EkS9PYH5cfD2jL2ecHila12Lvn+qKkHrgal02fvAdM18fwPkcLxE18Ooq7bDeApsJYKfKaECgi4ecRqe4SyXFNh7JAtv68arBZzfHismjeOaryCeen2w6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723087841; c=relaxed/simple;
	bh=QwNjRd0RNPYX2D5qSQgcbPkf5TvpBc9IVCky9OnElQ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ht9imR+uf8T95SSrX+luYqf+EdONsWmv0SB+nuRYBzpOVOBiig4cOwL20zxDfi6oAoGCWe70LNli9Vuo6EreQqK23f1IpZxhx5Y4xZIri8tRdRaxSB79BWXYk1yvokocbi+Yq8qvb6TjAq18pdI+vdvBEVTMWuouQhnQDze4x7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQne4MSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E81EC32781;
	Thu,  8 Aug 2024 03:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723087840;
	bh=QwNjRd0RNPYX2D5qSQgcbPkf5TvpBc9IVCky9OnElQ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rQne4MSXKQQO+XB+HzRGED3bBJ0ItsU8j9D6d1FrZfRt3xSfCUTBLyRQ5V1zkTGhh
	 r3MLtdCpm9XxJie16Ujj6cUV4TCcU6VT5WlSnLmwFajbL1pKJVVwhf9rzTjoZcASnX
	 DsU2/lRGBIJIkwYkSNVpP/UMntN/amyCbo7jStB0hHhjbHhAzbmKX5yf12+2AIp284
	 Rds1v9FmaENZpKgTHBPutoCvgO4CsAFoKWpxZ2CBXQ4YCLvtVDn+yJVmSCiHi8607d
	 hnzJmXWHJC8uR/M+5O00VI8O5oELTlvROUfhl787ONDfsRc4um5WrSJ3H3bOO7hq82
	 UO/Kz8BTWaxzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC4F3822D3B;
	Thu,  8 Aug 2024 03:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bonding: Pass string literal as format argument
 of alloc_ordered_workqueue()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172308783928.2759733.6354737913910268027.git-patchwork-notify@kernel.org>
Date: Thu, 08 Aug 2024 03:30:39 +0000
References: <20240806-bonding-fmt-v1-1-e75027e45775@kernel.org>
In-Reply-To: <20240806-bonding-fmt-v1-1-e75027e45775@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jv@jvosburgh.net, andy@greyhouse.net, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 netdev@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 06 Aug 2024 10:56:52 +0100 you wrote:
> Recently I noticed that both gcc-14 and clang-18 report that passing
> a non-string literal as the format argument of alloc_ordered_workqueue
> is potentially insecure.
> 
> F.e. clang-18 says:
> 
> .../bond_main.c:6384:37: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
>  6384 |         bond->wq = alloc_ordered_workqueue(bond_dev->name, WQ_MEM_RECLAIM);
>       |                                            ^~~~~~~~~~~~~~
> .../workqueue.h:524:18: note: expanded from macro 'alloc_ordered_workqueue'
>   524 |         alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, ##args)
>       |                         ^~~
> .../bond_main.c:6384:37: note: treat the string as an argument to avoid this
>  6384 |         bond->wq = alloc_ordered_workqueue(bond_dev->name, WQ_MEM_RECLAIM);
>       |                                            ^
>       |                                            "%s",
> ..../workqueue.h:524:18: note: expanded from macro 'alloc_ordered_workqueue'
>   524 |         alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, ##args)
>       |                         ^
> 
> [...]

Here is the summary with links:
  - [net-next] bonding: Pass string literal as format argument of alloc_ordered_workqueue()
    https://git.kernel.org/netdev/net-next/c/93b828cc8e2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



