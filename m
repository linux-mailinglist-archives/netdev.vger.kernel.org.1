Return-Path: <netdev+bounces-31120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EC578B8E4
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 22:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99AAA1C2098B
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 20:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B231428E;
	Mon, 28 Aug 2023 20:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0457114017
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 20:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 960B4C433CA;
	Mon, 28 Aug 2023 20:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693252823;
	bh=IMG05OvEIF9muWiy9du9grPxzhqpkKFAD7+Z0qInqSo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DoUli7b45HIEc7jJT4yW3tTvabhBmmTYoJgOeGmaDokE3p/SehR/Z+yI7jLm4TsdU
	 ptrYp2LHMInfWW74HSuGrVRZRgaaKGjtip9sVh8Knwo6M5qaizafiGjQv3UduwsG3k
	 OemlK9KzdyjvZzBxYvTMaDORS9Y3rvJlQzR4nFIosb/HqrAjDoXcudRwIcvKuSf7qs
	 gEJaEJP7wbHj5yqZ7kd6rpESIPiTfF65LqAhVgRv9e9Od5jv6FaFaP7JKBVXc3BC3V
	 +mGDOwMuNX1DCTwlPmmMU5gyekaILS/XG4OOuA3YfYqCO88U5ZX5Ri5kZBekBKYFQa
	 ygAnz1QihOdBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E77BE33081;
	Mon, 28 Aug 2023 20:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: mtk_wed: minor change in
 wed_{tx,rx}info_show
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169325282351.23387.1731086781524620861.git-patchwork-notify@kernel.org>
Date: Mon, 28 Aug 2023 20:00:23 +0000
References: <71e046c72a978745f0435af265dda610aa9bfbcf.1693157578.git.lorenzo@kernel.org>
In-Reply-To: <71e046c72a978745f0435af265dda610aa9bfbcf.1693157578.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, john@phrozen.org,
 sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 lorenzo.bianconi@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 27 Aug 2023 19:33:47 +0200 you wrote:
> No functional changes, just cosmetic ones.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_wed_debugfs.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [net-next] net: ethernet: mtk_wed: minor change in wed_{tx,rx}info_show
    https://git.kernel.org/netdev/net-next/c/6c9cfb853063

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



