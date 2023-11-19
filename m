Return-Path: <netdev+bounces-49060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AADB7F08A3
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 20:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4101C2087E
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 19:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7286199D0;
	Sun, 19 Nov 2023 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzKnPI4i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5247199C0
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 19:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 775ECC433BD;
	Sun, 19 Nov 2023 19:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700423424;
	bh=kQ9I3DqnN8aZbJIWNRvsWiT2gYuL/9p6p/W0z0RkyzA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TzKnPI4iPGSRZMY1thpVx1MYEbQOJMnNKldTXUFQU7AL+3xeXR0zoDCKQ8r1ii822
	 u3Zspt1DetVZw1rSvtwzjWQsGT8yHbFUnSykgN1zmQ76lOTtOVZAefa+b0AYeZWG5i
	 O7usrgFoy6qguKs6+qh+bfVtyhcFc/LUvfYX05pAkkcU8rf+Gh+73PGUQpE5BDbGA0
	 AVXE2s6x6zZUwa7onsqUbEgLEmNsIUZpSfr8k3rzrUQVUYS+QToLvgzaebrkrQBTvs
	 ZacQFtIy07K69M6yycOvoQzmRF4NQTrpvHw/1uSM4t/UyVq5wfvyYJdQrhblwbaDXL
	 F5s4qvYpkiytg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64611C3274D;
	Sun, 19 Nov 2023 19:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: mtk_wed: rely on __dev_alloc_page in
 mtk_wed_tx_buffer_alloc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170042342440.11006.17100386577698964097.git-patchwork-notify@kernel.org>
Date: Sun, 19 Nov 2023 19:50:24 +0000
References: <a7c859060069205e383a4917205cb265f41083f5.1700239075.git.lorenzo@kernel.org>
In-Reply-To: <a7c859060069205e383a4917205cb265f41083f5.1700239075.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, john@phrozen.org,
 sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 lorenzo.bianconi@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 17 Nov 2023 17:39:22 +0100 you wrote:
> Simplify the code and use __dev_alloc_page() instead of __dev_alloc_pages()
> with order 0 in mtk_wed_tx_buffer_alloc routine
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_wed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: ethernet: mtk_wed: rely on __dev_alloc_page in mtk_wed_tx_buffer_alloc
    https://git.kernel.org/netdev/net-next/c/94c81c626689

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



