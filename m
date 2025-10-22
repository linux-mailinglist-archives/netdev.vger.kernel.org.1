Return-Path: <netdev+bounces-231496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3D4BF9A53
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 03:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5F719C5FFE
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C1E21578D;
	Wed, 22 Oct 2025 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gITWc2Oe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C403F9D2
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761097836; cv=none; b=Ejpm5QEipXFUudARVmjwILREFjb/HcdOkSpblgNb8BtwpuEkbBTgcwO8yWn/09B1z7dvSzyas6LOXZ4JocVLVy8N8qixOdU7+3Crb3oybTLKuCEJZyz6HMC0VLAC6I+zCU+u2xUKKayKbGoiC84APX1gC3b0aBrA6ix4d+5XF5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761097836; c=relaxed/simple;
	bh=/eTy4JtMv/vr6iqZocb7lPKZoXLwzYl/RYQlWEEt4bQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jYGvUKIeRdfeb9g8jS/Ai3a42okCtqfIOyKP8mf/FbK8i87IIcF/ADQgvmv1jNNfOsupj/r5fQ+gAI5q+eIXHcnr7rqO5VdUg1rBoInHeM4T8qcMaF8J2TukMzz8vgaFJAks84xl8C/X/3MWo5tzrjETSW6Isdbf1BaSNYsPJBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gITWc2Oe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECABCC4CEF1;
	Wed, 22 Oct 2025 01:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761097836;
	bh=/eTy4JtMv/vr6iqZocb7lPKZoXLwzYl/RYQlWEEt4bQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gITWc2OepTEpTH4QeVoo+w086E3kiGzcJG00wK8LBjY2B4lJptF5+B+uD+kE84QQx
	 HpzOaME48fucUHFOuR2cS+JxAAd7rCvc7exS4onFB62gaqgLJ0wMy5wCs6cGyPCvVm
	 9bG3cA7mMyI3FJhPoQgao/V80EL8ceQNGMiq6SSHb3fnbG+JNOC96kD8WRJMdzgX0+
	 X3RHum0oDVWqfHVPPUarE97kpYjSjdw+CJsP1nxEYsd1g9TJqOE4ZrkHARCV4DVogY
	 qVmJ3WJQVLAq/JPWwUi1J8vNKzokw+1aaXpmWYd/fLnXzngKJpWsH5T0ElbSrI+EFt
	 8Dj6Y0ZPc821A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DE03A55FAA;
	Wed, 22 Oct 2025 01:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: stmmac: mdio: use phy_find_first to
 simplify
 stmmac_mdio_register
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176109781700.1305042.6815334207593742023.git-patchwork-notify@kernel.org>
Date: Wed, 22 Oct 2025 01:50:17 +0000
References: <20ca4962-9588-40b8-b021-fb349a92e9e5@gmail.com>
In-Reply-To: <20ca4962-9588-40b8-b021-fb349a92e9e5@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, netdev@vger.kernel.org, linux@armlinux.org.uk,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 18 Oct 2025 20:48:07 +0200 you wrote:
> Simplify the code by using phy_find_first().
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - remove variable addr and use phydev->mdio.addr
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: stmmac: mdio: use phy_find_first to simplify stmmac_mdio_register
    https://git.kernel.org/netdev/net-next/c/4a107a0e8361

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



