Return-Path: <netdev+bounces-240082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC17EC7033A
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2836238233E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B138D35C1A6;
	Wed, 19 Nov 2025 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEBEeLg1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8233A35BDC5
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763570447; cv=none; b=S+Y9Ta5CjrJUVXF1jeAXSgkI5hNyPzDyGNNliUbW2F3FXAngH4abnXqTfNyBNigjMKCrDlcXoP0r/k3VYZn/f7ffetlsQH/optERPI+/s4F3pIQ0bgFXqHr3k9AFUkQe5QC5Z7RZcpt9suPikwNWxolCG108Zb17KySbZGDIl40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763570447; c=relaxed/simple;
	bh=iUjwqaammSlItw6iy0AGcOa7+3IBT44TGBC6u0+zcoQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mv/SNsQoI+FWfPhbBTdAxgALXm65ZlAHa8c3cHgDgd0YxNvMEUwkGity6Y+4Vj1tEcPXMgtKqSeBORqFj/aSejdYBqjJEABBN0QFpwNN77yqLhS6dEnXmERlqyvzV1LYspfzc3T3Ga6afegHK7n/tfF9hMvwmJE/IbayUFHaIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEBEeLg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECA6C113D0;
	Wed, 19 Nov 2025 16:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763570447;
	bh=iUjwqaammSlItw6iy0AGcOa7+3IBT44TGBC6u0+zcoQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BEBEeLg1vESjR0s8FUiMwIazpXhPwRquWGltWffJgUMmUC+O44PiandHyICVyMY4B
	 vzRRi9opZ1ZEnFRqVqoT3iJiFATo2lBrPg8uu0xHOscWBA2DJidUHZC4VPFql8Sr5F
	 YpXD8uHa3YVt6rbJuGILc4YUWbAmlBVNh07dK1nOEIL/CphqNtCVgQtcSHf/TF7V5k
	 hjGVMLVu0fKb8nwBQNl0HqJ2pzxWz/elx0V+hc3g/0ycqvNcUC+8y0fUNkq1JBtebi
	 IVVyerddZaXKA4OyOG09CP+3xTrs6qoybhIuDDDxwfUmoVeNe4eqonV1BndsNneo+b
	 nLGDXSlNNm36Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB06239D0C22;
	Wed, 19 Nov 2025 16:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: stmmac: sanitise stmmac_is_jumbo_frm()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176357041250.873046.17131882776763838281.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 16:40:12 +0000
References: <aRxDqJSWxOdOaRt4@shell.armlinux.org.uk>
In-Reply-To: <aRxDqJSWxOdOaRt4@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Nov 2025 10:00:08 +0000 you wrote:
> stmmac_is_jumbo_frm() takes skb->len, which is unsigned int, but the
> parameter is passed as an "int" and then tested using signed
> comparisons. This can cause bugs. Change the parameter to be unsigned.
> 
> Also arrange for it to return a bool.
> 
>  drivers/net/ethernet/stmicro/stmmac/chain_mode.c  | 9 ++++-----
>  drivers/net/ethernet/stmicro/stmmac/hwif.h        | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/ring_mode.c   | 9 ++-------
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
>  4 files changed, 10 insertions(+), 16 deletions(-)

Here is the summary with links:
  - [net-next,1/2] net: stmmac: stmmac_is_jumbo_frm() len should be unsigned
    https://git.kernel.org/netdev/net-next/c/b5adada61e02
  - [net-next,2/2] net: stmmac: stmmac_is_jumbo_frm() returns boolean
    https://git.kernel.org/netdev/net-next/c/bf351bbec57f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



