Return-Path: <netdev+bounces-57718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBDC813FAA
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18831F22D49
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771757E4;
	Fri, 15 Dec 2023 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHVieKQu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E3EBB
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 02:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 059D7C433CD;
	Fri, 15 Dec 2023 02:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702606826;
	bh=j6KrmINRaWMhhldHh504fxTCEc6kovd3RJSEXFF2n7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OHVieKQuCJnOJ52OMcP/bPLLYjgKXy2SbtlppZCzDvUXT3P8kTqwRDcuPSaq3ktdK
	 OCY6XOEY5oGftvDzyKpEXKHzbN8FQMsUdhSb2T7kbM1B1eAnWADSujvVZlQM9e0qba
	 HFDa8i9MsoSa+/Lu3RlKBECh8PwhxrlCNnkBVECeeot95ovAstSlCrsEA9bVkicUgj
	 z8qIB9ED0ILi3QUnMOGPULAVTPLZByMnC/go7i2JcnSyjPuhKl+Um7yhs9OZA39f4X
	 PO8Nc7Xd3gVorapcFTAovzTyYYyHRns1V6WF0xpjJW9L410/ccIg+EEDZhxCkYLR3w
	 Res6+NXKFuyUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4ED4DD4F00;
	Fri, 15 Dec 2023 02:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: skbuff: fix spelling errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170260682593.8212.12408473597715000719.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 02:20:25 +0000
References: <20231213043511.10357-1-rdunlap@infradead.org>
In-Reply-To: <20231213043511.10357-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Dec 2023 20:35:11 -0800 you wrote:
> Correct spelling as reported by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> 
> [...]

Here is the summary with links:
  - net: skbuff: fix spelling errors
    https://git.kernel.org/netdev/net-next/c/bf873a800ac3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



