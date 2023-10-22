Return-Path: <netdev+bounces-43278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E167D22A9
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 12:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D5F1C2091C
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 10:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5181C30;
	Sun, 22 Oct 2023 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWrH9dae"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D12817C1
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 10:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D51BFC433CA;
	Sun, 22 Oct 2023 10:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697971223;
	bh=uwhNf8Xsz9iBhpFZMXMiQZZAT5BjZv0iz7G3cmV13T0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TWrH9dae2769fwo7H9U5cjDK6+wKIRLw82c8g4195paCZ+J2rUx4BDbOMi9VtC4Jt
	 m/YtEU6RvBCvGWpG0ohA8XvOC49dp9QsF24Rp3DLrCGKcNQbnkeT+3n4NPyFohhJJk
	 ainixz6Y+QVsaTW3ud6bjGo/24/VOZdAqcB/a+9ZdmkfWD4N8OCKuG+orjeWIrINnd
	 YNcP4frKHf/ldjINQim5WycSDxzWq/YUOe1fGQVfk1mu15iHPAkT8f93O1xtjHlRHk
	 qj3cPss49MWAe+Oj4+xp4QzNgPnWZgzVka0jYHMLkaC6izktSug5+V0mviq2bC06j+
	 mRKQ0emHsmnzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7FC7C04DD9;
	Sun, 22 Oct 2023 10:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: chelsio: cxgb4: add an error code check in
 t4_load_phy_fw
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169797122375.373.14524048379646362591.git-patchwork-notify@kernel.org>
Date: Sun, 22 Oct 2023 10:40:23 +0000
References: <20231020092758.211170-1-suhui@nfschina.com>
In-Reply-To: <20231020092758.211170-1-suhui@nfschina.com>
To: Su Hui <suhui@nfschina.com>
Cc: rajur@chelsio.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 20 Oct 2023 17:27:59 +0800 you wrote:
> t4_set_params_timeout() can return -EINVAL if failed, add check
> for this.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - net: chelsio: cxgb4: add an error code check in t4_load_phy_fw
    https://git.kernel.org/netdev/net/c/9f771493da93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



