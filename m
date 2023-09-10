Return-Path: <netdev+bounces-32742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E89799F52
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 20:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9E728119A
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 18:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA187E2;
	Sun, 10 Sep 2023 18:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCAA882A
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 18:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31250C433C8;
	Sun, 10 Sep 2023 18:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694370622;
	bh=mZ54+PLc9IhlxDCovXeQUxgZe/yoX7FCotx5+2XnyxI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hGjYraTNgwz9pL5z1mc0tIopgmeUev+KZjP5U+GpiZtmlzqFJB2+3EIDF4uC7GkYy
	 +8Xwh47ggzWpGGP8nvCEuJ+0WwFJCb3N3+xP29hO+68Ncdja8nm1zUywZaJw5ZWkrW
	 2yeM9qVOZTD90D4w8WtFW+fjZi/tvAKlirIDXd9+42tXBqysV1cK3Jh5ABla+GYyIi
	 B+sqGbeKsJpC0fmu76xy9YsHCEpwoprB9u/0GlxM26Rcie0d6mjXIJYrd8KdQTakvl
	 K6BLEo/R9qyL9da+1yUfXcxoD7mcnzLXKMGOw7kwZjWMWa/8EvsDQCBAHnSvenwzGk
	 bxk430cmkMT4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17947E505B7;
	Sun, 10 Sep 2023 18:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] octeontx2-pf: Fix page pool cache index corruption.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169437062209.3953.12683727128957272697.git-patchwork-notify@kernel.org>
Date: Sun, 10 Sep 2023 18:30:22 +0000
References: <20230908025309.45096-1-rkannoth@marvell.com>
In-Reply-To: <20230908025309.45096-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
 alexander.duyck@gmail.com, ilias.apalodimas@linaro.org,
 linyunsheng@huawei.com, bigeasy@linutronix.de

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 8 Sep 2023 08:23:09 +0530 you wrote:
> The access to page pool `cache' array and the `count' variable
> is not locked. Page pool cache access is fine as long as there
> is only one consumer per pool.
> 
> octeontx2 driver fills in rx buffers from page pool in NAPI context.
> If system is stressed and could not allocate buffers, refiiling work
> will be delegated to a delayed workqueue. This means that there are
> two cosumers to the page pool cache.
> 
> [...]

Here is the summary with links:
  - [net,v3] octeontx2-pf: Fix page pool cache index corruption.
    https://git.kernel.org/netdev/net/c/88e69af061f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



