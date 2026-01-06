Return-Path: <netdev+bounces-247235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70509CF6136
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 01:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D9D73036C4F
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 00:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779001E834B;
	Tue,  6 Jan 2026 00:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fig9GE94"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB301E7C18;
	Tue,  6 Jan 2026 00:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767659020; cv=none; b=HRo5uPvt3XOy0L6n9V332y9526fDw9NGKt84fMHzuHpMsy0TvJsgjqe5gMwN6+k67vpCS6PEwUpHrXKYyAC9+JHxDLSEpmcR/87GnTMze6jO6f5B74c6sWrDqr22cj7ZdLH+NcX7pWStnmso0I45TxhjN3JhP0gSIXosTv/DlHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767659020; c=relaxed/simple;
	bh=mo5R6mKrz2vthuRvZIdV31+9mqo3e6GoV8tjx0DpTFQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NNgqdXb8B6c+aw+fPvM6StEGHWQVo+WW+iWHhCNp1nZy+wn9w/iOoWVdyQACGoM5tII4zLaum86iZyXZQrMW6F1xWSodkjX6L9Z4+oNGlNnNK/hOGzOcjh6PqsKXwOYmMcov/OdYU8mfUwKjxLrOGFbP4Dh53xVLql33iAcUSeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fig9GE94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68F3C19424;
	Tue,  6 Jan 2026 00:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767659019;
	bh=mo5R6mKrz2vthuRvZIdV31+9mqo3e6GoV8tjx0DpTFQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fig9GE94J7e2SX1VlKMk+mLNb2lr7mY8m9YpX1oWPYtzDHUOuo3n+QLO5XjJWG9SJ
	 I+2DcuT6W5tN26ab/949WutRpK71uzdgVA5FLNdJt1FcPnPTjigLJMbZ8Abq9tj9Lt
	 BJCSLfD2U33s08vz88NQ4DhEBN6FI17+qbRECzn4ZpF3+pJAKpEeF3BsM+nvdr9vRt
	 GC3BZeTRvU9tybLGqUj0mNeBvgavwUdDanmVUEIJduC9/Gz59IcmL0ZSLO8FbrwYnk
	 +YP3N+jTBlJxY2cKg0yHzrQgI68CXgOfJhLsMujn2kBc9+NWaOBMwrK9Umi183A3mH
	 4NeowFODVcDAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B7BC380A966;
	Tue,  6 Jan 2026 00:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: mediatek: enable interrupts on AN7581
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176765881803.1339098.2859731628279711762.git-patchwork-notify@kernel.org>
Date: Tue, 06 Jan 2026 00:20:18 +0000
References: <20260102113222.3519900-1-olek2@wp.pl>
In-Reply-To: <20260102113222.3519900-1-olek2@wp.pl>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: daniel@makrotopia.org, dqfext@gmail.com, SkyLake.Huang@mediatek.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 benjamin.larsson@genexis.eu

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 Jan 2026 12:30:06 +0100 you wrote:
> Interrupts work just like on MT7988.
> 
> Suggested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  drivers/net/phy/mediatek/mtk-ge-soc.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [net-next] net: phy: mediatek: enable interrupts on AN7581
    https://git.kernel.org/netdev/net-next/c/2e229771543b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



