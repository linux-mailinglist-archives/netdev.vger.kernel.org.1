Return-Path: <netdev+bounces-31121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA3078B8E5
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 22:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C48A1C2097C
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 20:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC891429B;
	Mon, 28 Aug 2023 20:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0443412B85
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 20:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AFDBC433C9;
	Mon, 28 Aug 2023 20:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693252823;
	bh=CqjuW402PpZpAgu8f4tnY0zy5XFrdQZNiOGeZSTJ/G8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aRivSw86zN2yIlP/PCx6fLIYE6m6zkU++dpIzZ88LM7yK6cNhLCNM9hLAKdDVXk9H
	 CTC6mu3F0Vfw0vh80jKWnmlGJawP18llgvTmB7s0HJg0fGli4R9fgPXo+u1cDhOeLT
	 WYR/2mmDan2KU7nL7BGJV2kY157P++rD599jUSkN214LAUz5kJ9GcDP9XTjK2/VOQg
	 RfYPex2Q7o0hI7HpXdZXYoiqo2jlJ3euhhGfMA+L5vFIT3vkNFtxc3wIR1ofMZZ84g
	 6g2CnwqUMqGuQcWX9o+AYd0DvI9ikC5X2mtssW/luHcgo0bCYKao4ZTtEV6EUfW5cO
	 rHC1bZtBQfKCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73DC7C3959E;
	Mon, 28 Aug 2023 20:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: mtk_wed: add some more info in
 wed_txinfo_show handler
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169325282347.23387.3931100973377919249.git-patchwork-notify@kernel.org>
Date: Mon, 28 Aug 2023 20:00:23 +0000
References: <3390292655d568180b73d2a25576f61aa63310e5.1693157377.git.lorenzo@kernel.org>
In-Reply-To: <3390292655d568180b73d2a25576f61aa63310e5.1693157377.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, john@phrozen.org,
 sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 lorenzo.bianconi@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 27 Aug 2023 19:31:41 +0200 you wrote:
> Add some new info in Wireless Ethernet Dispatcher wed_txinfo_show
> debugfs handler useful during debugging.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_wed_debugfs.c | 11 ++++++++++-
>  drivers/net/ethernet/mediatek/mtk_wed_regs.h    |  2 ++
>  2 files changed, 12 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: ethernet: mtk_wed: add some more info in wed_txinfo_show handler
    https://git.kernel.org/netdev/net-next/c/042bf24ac987

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



