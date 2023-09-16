Return-Path: <netdev+bounces-34258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADFB7A2F3B
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 12:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E331C209FA
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 10:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF7112B89;
	Sat, 16 Sep 2023 10:20:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EC63220
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 10:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C9E9C433C9;
	Sat, 16 Sep 2023 10:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694859627;
	bh=tkPEYowSleh1P9oFQDhlZITsODAiyvzYGIZIQ+fKBy0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Udr8WT/EQpFc0qWkiKAAl6knmpdGeGX12E8JPVTmfKp7xC8agK9xN5XXZhQsMg79R
	 TmhQH2AkFSwl+jOrMRqktTwL3fsDwu+htjidjBkVRoRIqVIrP0SpxQaZjcAzjGfi0I
	 tMi89x4YmY9RL3fb/+JGfRsNGCD9DO3KmcBHmvMpT5yGM6bMt2EOkPDJ4CSKV5p3us
	 SWEn42bYJEHTpdGp456ptJI0Q+x1Dgbm1peKz9S9OJH+XgZe337pcp4IBVL0nSvpCt
	 EbGLxWEJPeEZ7/k2VDixBo1GH1L40YwPzFifNt0IPwmnpYF6aV7+QC63/WFNWKSfWG
	 KK/RJd72QbtFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E559E26882;
	Sat, 16 Sep 2023 10:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: ethernet: mtk_wed: do not assume offload
 callbacks are always set
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169485962718.21949.1017999086684232854.git-patchwork-notify@kernel.org>
Date: Sat, 16 Sep 2023 10:20:27 +0000
References: <ea9e1313e01f7925b9fc4040f3776070447f261d.1694630374.git.lorenzo@kernel.org>
In-Reply-To: <ea9e1313e01f7925b9fc4040f3776070447f261d.1694630374.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
 john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Sep 2023 20:42:47 +0200 you wrote:
> Check if wlan.offload_enable and wlan.offload_disable callbacks are set
> in mtk_wed_flow_add/mtk_wed_flow_remove since mt7996 will not rely
> on them.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes since v1:
> - move offload check inside hw_lock critical section
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: ethernet: mtk_wed: do not assume offload callbacks are always set
    https://git.kernel.org/netdev/net-next/c/01b38de18d06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



