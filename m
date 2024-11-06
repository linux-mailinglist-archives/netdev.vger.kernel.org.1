Return-Path: <netdev+bounces-142187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926BA9BDB6E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABCD284848
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDEE18CBFD;
	Wed,  6 Nov 2024 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oP6DoqRV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B1C189B9D
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857827; cv=none; b=q1xANpPXHeJtgW/55vmhC+Awu4nnLt7FI9MSHntST2mxal3gPTx2pP02DypB8KNo6PnxGgMext0vpwDiQWuYAPgPKdVYBgp0hQknc6Y8cmTB6pYFLjkMxxwXxysj02yP4dacXXsYGDXO26riArq7DvLvjKnON10QwuUQvZO4mg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857827; c=relaxed/simple;
	bh=wreK4udCjmutUlfkrqpsAEZxhMwrFt7ZiWwR0X7sgeU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OQTx64FcpRsWLOt7jQykX+JeIwwnaVuu4XsVnT8HTHJZ0IZPLXEJuoL+UQWViz+rPENJ7eJ49svewWn7jaugjTUND34tYu1xJ618ZTq1wfODe1OuEIfxYC7v2YGOt+R+OdAPQxN73BT3g2S19rvedxIP0oK/FIbdxasV5CLlRWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oP6DoqRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF10C4CED4;
	Wed,  6 Nov 2024 01:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730857827;
	bh=wreK4udCjmutUlfkrqpsAEZxhMwrFt7ZiWwR0X7sgeU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oP6DoqRVJdkbMz7mJm1MLmqkx7xv07Ryu5o62co/GPsLdNQdxnOKTZ68fpxoQqX15
	 l/Tf1eCmyn0UMHEwbELcBqPojiS+rVOdF52z5nHv7x3rKzH4Flp8UEa/w6/AvplvQG
	 7Neg5+KQocNewB9Ou8x2MTxRojN5yukqg+8UTr36MKvCzK7HGXlADWHfepaZZrxoMq
	 XOewcLbp3dtWmi8tBVjWiHJp4Cy2BWnwfiitLj0rD1Ye5LP9KrywWt3gqS8oMpA2MJ
	 vlt2OrsAgdDymBWeYB9uTflELld8xpc0FQ2raZwV1UCSRokWheU/l1q9oMG7MkoHur
	 DDtBwdKziLRiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712E73809A80;
	Wed,  6 Nov 2024 01:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: remove leftover locks after reverted change
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173085783600.762099.2702724711208623186.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 01:50:36 +0000
References: <680f2606-ac7d-4ced-8694-e5033855da9b@gmail.com>
In-Reply-To: <680f2606-ac7d-4ced-8694-e5033855da9b@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 4 Nov 2024 23:16:20 +0100 you wrote:
> After e31a9fedc7d8 ("Revert "r8169: disable ASPM during NAPI poll"")
> these locks aren't needed any longer.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 29 ++---------------------
>  1 file changed, 2 insertions(+), 27 deletions(-)

Here is the summary with links:
  - [net-next] r8169: remove leftover locks after reverted change
    https://git.kernel.org/netdev/net-next/c/83cb4b470c66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



