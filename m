Return-Path: <netdev+bounces-218040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D0FB3AEC2
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 02:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E443BE252
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4962D97A1;
	Fri, 29 Aug 2025 00:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9Fz911d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D0A260592
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756425617; cv=none; b=gXN0MT6eCAB0EyIESSkh+G4MblyN1Fb0BAwgM8SGY80c66+HyBvqjdDKgew1v6G9M6/P7YdLnEgyYX8bkhkajk4zDUBPEGYPhCGCZxdAMQdpao26EH2nEEcaaNJ/EdJF+22t1nwz2byIWT9r8lHe3ZKDWPeeTL8gZNnbm0SnQRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756425617; c=relaxed/simple;
	bh=XHuj/eFq3JvZKdFMnx6z2EM258B7b2c8RFcbChBfhaE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hHMe42mExdSZAyVQWmuYYHACiK2i43wzSoHVnxIiP6rY57Hb0GDgdVZOJf+0GFDwo5dk0GICvcdSZRqUjtD0u3mmrYHSbsw5EHsQ4fxVnH6iWo+SYbWNRjNVYPqv2ehq7xnlwT9RzlHntfQkXPdY9IyE+LapBUvlvpsDaVX93cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9Fz911d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041F4C4CEEB;
	Fri, 29 Aug 2025 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756425616;
	bh=XHuj/eFq3JvZKdFMnx6z2EM258B7b2c8RFcbChBfhaE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c9Fz911dMFkeBEClmnNO3pEJkP0L8NFES3iaVgARcOTrSwhdX2qbhxFRNpxT+2KPP
	 bnP/UWwgO+tgh5lU9mbRdDDNy33gfaLFnItyT9TOZgHkNjIAOAw2t3k8FshOYVCbYp
	 w7JqMGhnMZ8ZIru6obFoVqSjBpf2ZUn6YEKOFp2wsuj5+OKxb5fDrky75Mm4sTZR7O
	 vlKWX74VVz61xtbflvp98GoUTcXoih6v9+4ikLgnlx+VAJoJNnFp3TwHkX2jkpeY2i
	 uuNpgupoxRFbvMdot7sIOvj8FTKXh2l4oYJodFUt3oNnZK+klMak+GRLn+cuZazoR2
	 2VSuAAUWjvFOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BF8383BF75;
	Fri, 29 Aug 2025 00:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: minor cleanups to
 stmmac_bus_clks_config()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175642562274.1653564.10878658368837488044.git-patchwork-notify@kernel.org>
Date: Fri, 29 Aug 2025 00:00:22 +0000
References: <E1urBvf-000000002ii-37Ce@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1urBvf-000000002ii-37Ce@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Aug 2025 09:54:51 +0100 you wrote:
> stmmac_bus_clks_config() doesn't need to repeatedly on dereference
> priv->plat as this remains the same throughout this function. Not only
> does this detract from the function's readability, but it could cause
> the value to be reloaded each time. Use a local variable.
> 
> Also, the final return can simply return zero, and we can dispense
> with the initialiser for 'ret'.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: minor cleanups to stmmac_bus_clks_config()
    https://git.kernel.org/netdev/net-next/c/2584ed250a37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



