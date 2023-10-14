Return-Path: <netdev+bounces-40910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B12B27C91B3
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424A3282DCC
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C88628;
	Sat, 14 Oct 2023 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIrakdRE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A11B7E
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 00:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAB43C433C9;
	Sat, 14 Oct 2023 00:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697242224;
	bh=YQ1O9PYmm8sxHyNuoIlrdyVOinwFtmn8ZaOM9uEyT9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pIrakdREaMHdBdCmvtlgQ+x3HMmObnug6sS9TzVPl01Kp8zAPup/UjHtsTHfnUHWS
	 v9/B74Qegjp6pDzTT1emoUu2B1BRHPtZcB5bZWsYzgHa7fiFkupwswwUzLB91VtJd4
	 /yLWTeOgHJhJlPvAgqydrTf5aVfefwj6f7vDzUcJtzRBNDb4sOs7wyuxbqZUT8o/As
	 uI0dPki2rB+0Ce03HjDZJb6PeI/iKzY7+yVdVLXK6c8DHk1W4dgRjJff1bhYUv4BTB
	 S6zWs9gJJIR3CT/ANRlc9bJ1Kv2vTlT4hGK6z/69y8X5pKuWnN0ulL0RBaGu2qdCG+
	 1tJDUy7s74t1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8DD44C73FEA;
	Sat, 14 Oct 2023 00:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2-af: Enable hardware timestamping for VFs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724222457.16074.4480556425524593039.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 00:10:24 +0000
References: <20231011121551.1205211-1-saikrishnag@marvell.com>
In-Reply-To: <20231011121551.1205211-1-saikrishnag@marvell.com>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, richardcochran@gmail.com,
 lcherian@marvell.com, jerinj@marvell.com, hkelam@marvell.com,
 sbhatta@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Oct 2023 17:45:51 +0530 you wrote:
> From: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> Currently for VFs, mailbox returns ENODEV error when hardware timestamping
> enable is requested. This patch fixes this issue. Modified this patch to
> return EPERM error for the PF/VFs which are not attached to CGX/RPM.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: Enable hardware timestamping for VFs
    https://git.kernel.org/netdev/net-next/c/5ee0a3bd1509

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



