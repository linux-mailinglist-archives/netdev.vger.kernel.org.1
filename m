Return-Path: <netdev+bounces-110750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E9C92E266
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 10:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CE6286EC2
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 08:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A10152189;
	Thu, 11 Jul 2024 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKe0I392"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38811155A34;
	Thu, 11 Jul 2024 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686674; cv=none; b=FWlA8EfDBw32/UnbkcBy8w5b5uxamO7IHk6l5yA/S9ctjtvpyn2ixa2/bxl7y0MU+OqFZ7dvL0g2eA+IBJX0+OfnT3JvGZuViYQxc4FhPswCIBUUY7vUDZxhuekdOgXK8X6o7IdziMDOhtTaR9k2NZ0h8e+WLHSsb9rax/smbvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686674; c=relaxed/simple;
	bh=aC3Xr9tS22ND23vxAONRN3pa/zO5+j1Y/oCN8be4Ids=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=phSEfK3tk+vrwtA/ujSIzxf7dzh427drR6p7OzuT3Q2fptvV8yRRsHRleIKkLo9TyZou2k4aK6heuinnij50vmewONzl1MD0321yUEZQ/UZvon8arPpVGwwGZhFdbq2UBjg4rQcDU1PXsgp7ZrmNPB+wW6RYvVFsPqYuvUBCIjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKe0I392; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5D0FC4AF0A;
	Thu, 11 Jul 2024 08:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720686673;
	bh=aC3Xr9tS22ND23vxAONRN3pa/zO5+j1Y/oCN8be4Ids=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KKe0I3923FdDqHvWUh6oX1FOOD0dAUqy3ws6sX7bdqT35X6RXXENDNezfvhpMpy1f
	 l3wQILHmbnyV+LlHM/enz2pMHEiuPFzgKF/Lz0ai3Y7hFXbjeELAdIzf00WVueKWWX
	 bQyxoAObhQDriQ/U+8dAQ695ia3III3rJZwJ/3bBEmc4jlJUcgT0mjt9CkdemnqKWw
	 Nen4ezEB1djRqweqe/S/tLmZ6zj8NnjsezDXXgvK245mjiCoSBCF/EZdjGOx3gw5a/
	 hrP2rkD/32xnFY4XRHDVDdOGpTKyJB+5vrAqeZ1pGKUX/jwhDn1z4RaxnK8Eq60elK
	 fN4xRQX0lqubQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9200BC433E9;
	Thu, 11 Jul 2024 08:31:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: ethernet: mtk-star-emac: set mac_managed_pm when
 probing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172068667359.28697.10752199531087262735.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 08:31:13 +0000
References: <20240708065210.4178980-1-jianhui.lee@canonical.com>
In-Reply-To: <20240708065210.4178980-1-jianhui.lee@canonical.com>
To: Jian Hui Lee <jianhui.lee@canonical.com>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 lorenzo@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, f.fainelli@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  8 Jul 2024 14:52:09 +0800 you wrote:
> The below commit introduced a warning message when phy state is not in
> the states: PHY_HALTED, PHY_READY, and PHY_UP.
> commit 744d23c71af3 ("net: phy: Warn about incorrect mdio_bus_phy_resume() state")
> 
> mtk-star-emac doesn't need mdiobus suspend/resume. To fix the warning
> message during resume, indicate the phy resume/suspend is managed by the
> mac when probing.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: ethernet: mtk-star-emac: set mac_managed_pm when probing
    https://git.kernel.org/netdev/net/c/8c6790b5c25d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



