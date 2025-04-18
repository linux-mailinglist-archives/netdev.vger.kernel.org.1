Return-Path: <netdev+bounces-184037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F217A92FC4
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2046460F27
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830BC26771F;
	Fri, 18 Apr 2025 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDLXCb10"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89E267714
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942202; cv=none; b=KEdmfJtLUXukVEJOum6bahKSbq2qpMMxL6W2X4/y7Uic+SNh2krrvf5g1rswp5HERGBaaDy8BPBwJZQd5k/b8p3S/NCLA/IpUHBtyWPP7H/t+GZ/dLlN/QZ1VvUt41SK20d5+ZpQMxXz3AmyyieaqRYv2hV93tzSXrtM+25B1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942202; c=relaxed/simple;
	bh=GrNXNsg8thhryFhRIZCHfkYBELHVyUHwQRQ/n00IPGk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XwoCXoBPq2OK6iYgmyBPwT0oIl9A+e4AdVlkVmWjpoKpjOoYIoUTqG6G1LUYgxIgzoGddW+GnzcM6O1ht4BYR5V1DVshFm5DQzDjiUeDVDesky8/HzlTpn09yxQpf/1EqA6SaW806B6ZRsnjRrwtJRRioFyVqpriAINhPsT5jQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDLXCb10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48ABC4CEEA;
	Fri, 18 Apr 2025 02:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744942201;
	bh=GrNXNsg8thhryFhRIZCHfkYBELHVyUHwQRQ/n00IPGk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rDLXCb100h//SVUpdcl4UQ585zMo4am7V5N+BpZ74niCtsqXgpOIRdxVwKJ6I7vq0
	 ID1qTakmi412HtyqO4khIdD2v+RDbYJd1HHLHNM4e2P8eTrpyQxtjRmmFQobgclXua
	 Vd3xzZGOURAN2wwZ74EfPc1YfDvROY1EG+VehMMrH/vgKBI0bQnbYVOAbcwujaUn5x
	 XMFw0JNwHZojNHzr1sBN8FGQgnvhH3+mX7GkM1cKUBSEVNAPxqSrcs1KvoZ8gX8qEW
	 pU2WLW0d3ZDSLWX2XPhQkerStPNLe27skPsbEjFzuCwa3KI931dhX3ykfcqsWbhTlz
	 Oc4vnJcWlKMJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3483A380AAEB;
	Fri, 18 Apr 2025 02:10:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: mediatek: stop initialising
 plat->mac_interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174494223974.79616.7693576407987445072.git-patchwork-notify@kernel.org>
Date: Fri, 18 Apr 2025 02:10:39 +0000
References: <E1u4zyh-000xVE-PG@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1u4zyh-000xVE-PG@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, matthias.bgg@gmail.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Apr 2025 11:26:47 +0100 you wrote:
> Mediatek doesn't make use of mac_interface, and none of the in-tree
> DT files use the mac-mode property. Therefore, mac_interface already
> follows phy_interface. Remove this unnecessary assignment.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] net: stmmac: mediatek: stop initialising plat->mac_interface
    https://git.kernel.org/netdev/net-next/c/01be295b485a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



