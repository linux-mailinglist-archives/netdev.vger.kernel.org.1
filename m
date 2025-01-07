Return-Path: <netdev+bounces-155809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 900B3A03E0A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324291881190
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4F11DE2A0;
	Tue,  7 Jan 2025 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r540sbn0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C855A1DAC88
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736250011; cv=none; b=ftRTFkMGf1ucP5Zo5ycHJJJuy3/GrI2aJ8UYx8QtX3vOqknrJRivL4lB5/n+CAQrA3JuOPy0W9wWAXwtnbXkXHUJfD5PqoTqOom4FiXhI82RJ3wshZLU9Q752uvdZZJqykwaIIiRaA0/8+FA4kcp03ez5IgHzyqByfPk4H/mjxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736250011; c=relaxed/simple;
	bh=VZsqylYrFcdy7rVu50r2zA8B698Fb8nwUwjNptFXD4c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IKs4sJ2h+uwFwCk3ZDPIpKl112yJ0Q84yh13KTPk7/cuQQDPuWEUim5ldz4gu4qTxixv+0znUCxFC+Y6w1wHnYxuFn/yzMEMavFrw2kre3kQRbpgvBY7aeXpY9C1VK8FvOMXNedZ7BIuvM5C1Wc2nkUTZ5splawxv9VMQpKSusA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r540sbn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36963C4CED6;
	Tue,  7 Jan 2025 11:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736250011;
	bh=VZsqylYrFcdy7rVu50r2zA8B698Fb8nwUwjNptFXD4c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r540sbn0QfP0pxOq6ybHGoGDckuiCe/53bQM4ECL3et2rQ8iCtkrwK9vrsqA2blfJ
	 5bG0euoOLVi7KZ4JKvtiGEwGHCnM5fjXWA+Ke1I2J1mCIsYX+6g4YPb4tf6OAS89y7
	 tLwB8r2RY1RbUVG4K57YQwWEA8zbIMHhCn2dTUYt6Jb+3HYk24Qgb3JKmJEDMLJbDG
	 NlQXqMlLnHpaswjhl1kJ0cIiiXvdWM8DGf6zElne3sGGxcvmmatBNDk6iE4/cIBTtm
	 Ceq//Cwk1mKA0F5dyPS8gwZEcPQUUJLsCxgEM6kLsoILehI41faURyLIbKNI36U4Jr
	 hKgYyo9tXwQBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFDD380A97E;
	Tue,  7 Jan 2025 11:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net: airoha: Add Qdisc offload support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173625003251.4120801.586359106755098449.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jan 2025 11:40:32 +0000
References: <20250103-airoha-en7581-qdisc-offload-v1-0-608a23fa65d5@kernel.org>
In-Reply-To: <20250103-airoha-en7581-qdisc-offload-v1-0-608a23fa65d5@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, upstream@airoha.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 03 Jan 2025 13:17:01 +0100 you wrote:
> Introduce support for ETS and HTB Qdisc offload available on the Airoha
> EN7581 ethernet controller.
> 
> ---
> Lorenzo Bianconi (4):
>       net: airoha: Enable Tx drop capability for each Tx DMA ring
>       net: airoha: Introduce ndo_select_queue callback
>       net: airoha: Add sched ETS offload support
>       net: airoha: Add sched HTB offload support
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: airoha: Enable Tx drop capability for each Tx DMA ring
    https://git.kernel.org/netdev/net-next/c/5f7955903804
  - [net-next,2/4] net: airoha: Introduce ndo_select_queue callback
    https://git.kernel.org/netdev/net-next/c/2b288b81560b
  - [net-next,3/4] net: airoha: Add sched ETS offload support
    https://git.kernel.org/netdev/net-next/c/20bf7d07c956
  - [net-next,4/4] net: airoha: Add sched HTB offload support
    https://git.kernel.org/netdev/net-next/c/ef1ca9271313

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



