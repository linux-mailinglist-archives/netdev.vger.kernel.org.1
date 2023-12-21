Return-Path: <netdev+bounces-59477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FCB81AFAC
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 08:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72431F2925F
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 07:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32C813AF4;
	Thu, 21 Dec 2023 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spO9djQJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E6B156C3
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 07:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 602BBC433C9;
	Thu, 21 Dec 2023 07:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703144423;
	bh=QzryzI+/hs+oYKS0k19iIk/Vs4q5TaiJCyz5iqaxglc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=spO9djQJ16Z+fJBegPE8vGZl0G/yj6wTscSg6xqCESyihsWjJkVrc/SOR1BuY1LuH
	 ZDHxSTpmxwj6aYG0yhbGJmtNa3f24DQnDVmH6IhFspHD37dYIzH74WZZRYo4a4h/jl
	 v4OLjA7E9A2QE7mY+y5oUTUpeG7eEKHgZRzhaSbTgDNq1AceLV/dlCmouuFKnsq//Z
	 OH0+G/6GdwSgWaWuLzJek/gaFF3W6moM3xEJlqJiofDT6XOxddPfmzr6OMipYtA7PD
	 Q4NspfPzF2jzByXLQcw23DKM5ujueni5aBMjumKRl883XcaoQn0L2ZQEfht+bY73xC
	 Mm9lfbj35x4mA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42A98DD4EE4;
	Thu, 21 Dec 2023 07:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: mtk_wed: fix possible NULL pointer
 dereference in mtk_wed_wo_queue_tx_clean()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170314442326.7814.12333428527193140447.git-patchwork-notify@kernel.org>
Date: Thu, 21 Dec 2023 07:40:23 +0000
References: <3c1262464d215faa8acebfc08869798c81c96f4a.1702827359.git.lorenzo@kernel.org>
In-Reply-To: <3c1262464d215faa8acebfc08869798c81c96f4a.1702827359.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
 john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 17 Dec 2023 16:37:40 +0100 you wrote:
> In order to avoid a NULL pointer dereference, check entry->buf pointer before running
> skb_free_frag in mtk_wed_wo_queue_tx_clean routine.
> 
> Fixes: 799684448e3e ("net: ethernet: mtk_wed: introduce wed wo support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_wed_wo.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [net] net: ethernet: mtk_wed: fix possible NULL pointer dereference in mtk_wed_wo_queue_tx_clean()
    https://git.kernel.org/netdev/net/c/7cb8cd4daacf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



