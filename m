Return-Path: <netdev+bounces-109579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D76928F9C
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 02:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F7A5B247C7
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 00:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C62C256D;
	Sat,  6 Jul 2024 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTp+PwrW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11421A3D;
	Sat,  6 Jul 2024 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720224032; cv=none; b=fWI38JLBH8t3xTMmM5mgJ2kdBTTFT2Ye6mjZKZ+yJdttTsCd9sTQnD/n+F0UH1DRXvyK9MZbIG3emK3vljyRC9xq67uMq7npdNoOty7yqEj178wJbl1L1F4xZGkpWEf55jJmw/xk+JIfk1pMlGqnlmbkJ7Y6pIb/HdvJOjOh6dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720224032; c=relaxed/simple;
	bh=WhMcksiqGoZDH0KM2bnh5KtXmtQWYKWu4lTqKhd6JHY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CHorjHnlU7T2cHAU+42DHYlQKxK1yh3EHO1++eGyMtR8ak4spqeoU5TriHxSCHMPkHVPwV51Ha2qhpVX/Ghpa75Kh3PIlbnmYpiv5MGMUH/gampE9Xelb8fZxsdJFQnH30wazN7bT+33Nk2SFqtrA03jlWODt7JhcGj/vaIYhpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTp+PwrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 799C4C4AF0A;
	Sat,  6 Jul 2024 00:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720224031;
	bh=WhMcksiqGoZDH0KM2bnh5KtXmtQWYKWu4lTqKhd6JHY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iTp+PwrWdcFQ7z87SyPZ0O05b6n2/niJM5tt1ubEKT1f1iMrfb1hfcKk6bY8Akexu
	 fqWaqNH15R3nAWgx+r19RyacXf8bBk2aEFKKCAmbakSsHsKkRIlLfTDpR+Qz/Qb2XC
	 cs3QDye+1ZLKSqX+Sjh2wYgCIRkg4V42M3ds82KInjn1A1sPpHJW3e30Uxld8Qktrx
	 /driQAndvMa52c+00dB3sANciDkoBkqyD35VaeKGOlKgzKAElkF9KgAKqsC30055lV
	 Z90rcW287YEbTQLe4iCzGz3kusZWkNz2PJJdS2g16OpMTlCZuJltwDe+NkqInkKE+o
	 QwAfzYK/GpAUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 630C0C43446;
	Sat,  6 Jul 2024 00:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: mediatek: Allow gaps in MAC
 allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172022403140.7894.3886257470983936157.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jul 2024 00:00:31 +0000
References: <379ae584cea112db60f4ada79c7e5ba4f3364a64.1719862038.git.daniel@makrotopia.org>
In-Reply-To: <379ae584cea112db60f4ada79c7e5ba4f3364a64.1719862038.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 lorenzo@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, eladwf@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 1 Jul 2024 20:28:14 +0100 you wrote:
> Some devices with MediaTek SoCs don't use the first but only the second
> MAC in the chip. Especially with MT7981 which got a built-in 1GE PHY
> connected to the second MAC this is quite common.
> Make sure to reset and enable PSE also in those cases by skipping gaps
> using 'continue' instead of aborting the loop using 'break'.
> 
> Fixes: dee4dd10c79a ("net: ethernet: mtk_eth_soc: ppe: add support for multiple PPEs")
> Suggested-by: Elad Yifee <eladwf@gmail.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: mediatek: Allow gaps in MAC allocation
    https://git.kernel.org/netdev/net-next/c/3b2aef99221d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



