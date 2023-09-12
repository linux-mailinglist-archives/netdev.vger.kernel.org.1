Return-Path: <netdev+bounces-33131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8108E79CCB9
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5942811F7
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF2D168C5;
	Tue, 12 Sep 2023 10:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE8213AF4
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02E14C433CA;
	Tue, 12 Sep 2023 10:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694512825;
	bh=DGowEOYUWbmWAlu4sfavxnuNY8MphrKdfJFFwomgHbc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G8p/fsq3Ie8NLsY5qc2I0IpfNSluzjQTGLKJEPRg1fuxmEdlEGvx1kfcWdDu//g0A
	 uiMj7oPaQ9+5b1qzb9AoAC5Jp6y3iR/I1VfGj9v5c2ZOUDC752QRuh1miZ1a5mq5yz
	 uBZKLGLgyOHdYEQTm0yY7Up09sk6BS+Pzoe2avynMy+mvefD1uO4zdSa6nxwXycmV0
	 06WeGuCh0zRGCJx6oEyteNBhTQo2rb8WilmGBPHTWcBChsuWxpza2NkXwnKLJK6bw7
	 NvIjDDl37yBTx6auDo9vkeSG9MVFXfOD0DRL/qnYWpXPsPI65WsjWOlbk6m85lzzrj
	 CKkpbBoLUgPew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7F0DE1C282;
	Tue, 12 Sep 2023 10:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] wwan: core: Use the bitmap API to allocate bitmaps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169451282488.7239.12895349010079709401.git-patchwork-notify@kernel.org>
Date: Tue, 12 Sep 2023 10:00:24 +0000
References: <20230911131618.4159437-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230911131618.4159437-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: haozhe.chang@mediatek.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 11 Sep 2023 16:16:18 +0300 you wrote:
> Use bitmap_zalloc() and bitmap_free() instead of hand-writing them.
> It is less verbose and it improves the type checking and semantic.
> 
> While at it, add missing header inclusion (should be bitops.h,
> but with the above change it becomes bitmap.h).
> 
> Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
> Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> [...]

Here is the summary with links:
  - [v2,1/1] wwan: core: Use the bitmap API to allocate bitmaps
    https://git.kernel.org/netdev/net-next/c/cd8bae858154

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



