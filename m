Return-Path: <netdev+bounces-109588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2677C928FCD
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 02:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BA52847C6
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 00:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E998F47;
	Sat,  6 Jul 2024 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bChjxcYB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DDE79F4;
	Sat,  6 Jul 2024 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720227032; cv=none; b=Mr3g/uf4VVF0TtJrB2j8tq+qKo53JkG09qh5wXxHgUpRUu6YnEPCK4lneW7IcVzlYObtqOAc7AAfsk0xakz9GPoT0hUhlInxtRk4X6xmjo+FhBXdZX8D9mw7j4n4rd+HzEHHdknSGPVOvQgQLZtfOpcWMCQ3wfpLtAPOQ+GAX5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720227032; c=relaxed/simple;
	bh=qZUYt9aCrtldBy4xJcQnybZR0D/11ePWcBIs/S9zoq4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OH9lHJ1poKGdGN6duxT+bVQOPQSqKzLbdBwI/s1rr7qS4NUUL2A4X2ppdkMQvXS1eTy6TBhh2s3uTZOHZAOuJzIDCNOJ1yKwFK4mnK1OAzjkQb7+gqafjWQHIuV/N6KA1TtKcFfJMRqhduzbjxvugP3cvGSlkuKmXpBcIbBuf18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bChjxcYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8DD8C116B1;
	Sat,  6 Jul 2024 00:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720227031;
	bh=qZUYt9aCrtldBy4xJcQnybZR0D/11ePWcBIs/S9zoq4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bChjxcYBXUcPHYz06ycy3d1LQZn8aauBp9d1ElSFa7FB1mPQKpnIzq+kyQNfV/iau
	 k3IGfjAsfejpxbK912m6LNif2H3Hi41qPgj1+aMh2wWB/OMPMvX9BxhT5v5g2l/4vg
	 TYY8q76b1AjJpMuhQJws5yd34CS816/m3xVEAHPjcgD1hLs3AgYTp1aNYBEeId+Jte
	 I3mLeFsSAl75WoiSw21zRvqZBGuXvRpz6/s7bD17xjUHibXcQ9Wh3pa70dgvVBvpWm
	 AQ1uMRjMToL/f4l35Gj1u0U0BRNo4JhfB21ibNg+zFY6ylvvdr874E091zCXdLI0u7
	 vRRNGCjwL+syA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 990A6C43612;
	Sat,  6 Jul 2024 00:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: ethernet: mtk_ppe: Change PPE entries number to 16K
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172022703162.32390.6364958633398952266.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jul 2024 00:50:31 +0000
References: <TY3P286MB261103F937DE4EEB0F88437D98DE2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TY3P286MB261103F937DE4EEB0F88437D98DE2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 lorenzo@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, eladwf@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Jul 2024 01:26:26 +0800 you wrote:
> MT7981,7986 and 7988 all supports 32768 PPE entries, and MT7621/MT7620
> supports 16384 PPE entries, but only set to 8192 entries in driver. So
> incrase max entries to 16384 instead.
> 
> Signed-off-by: Elad Yifee <eladwf@gmail.com>
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> 
> [...]

Here is the summary with links:
  - [v3] net: ethernet: mtk_ppe: Change PPE entries number to 16K
    https://git.kernel.org/netdev/net-next/c/ca18300e00d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



