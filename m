Return-Path: <netdev+bounces-233533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F29C1528E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B71B464059
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDD3336EF9;
	Tue, 28 Oct 2025 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjKECZ2+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383902877FE;
	Tue, 28 Oct 2025 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661236; cv=none; b=oBdlPfugFhcoro09Dx4GCXKX2tpYmxQIbA2sWDbB3emzdyCVBD9luDy6neLI6Dm53H+sXNsI4v/usKYYt72jaBTiHUkXf1weeczCMleQuNF2tSHIOrNFuC4SBfCS08uhHyxG5285GQpwtsn70wV7YiEAhdNzHVUaicrpiW5RXhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661236; c=relaxed/simple;
	bh=QwRLL5j9thMLgs8+QAEz/w2vJUj8mHUdca6Hu3kM2Uk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mnmZUZz7OP10bSXu04ZuXaZmeM9cc81i1/sxvSVBIgne0eBFG9N4NpqgdFbhC4vOpeVkR4V/Ctiex/Z5o6+fsvYqK1dwEHzL3hCM1JGf87F/LeoyQSWK2rNUMMtT4Man7dxUtDhFiYbTeLci8ddMfzsM8r2zE6M26x/whw45FJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjKECZ2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC445C4CEE7;
	Tue, 28 Oct 2025 14:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761661235;
	bh=QwRLL5j9thMLgs8+QAEz/w2vJUj8mHUdca6Hu3kM2Uk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RjKECZ2+Ujtg9uz6vMIFpfGU1yq701BpLgwVitjDZToVOw+z4uWhQvZlZ3isW9KiG
	 9uaGfZ4QajI5E7jj94vjw+pkPvF3Ddt6F0qDJJLIt8vaOA9vxmnrlGZvwhcCN4Y5U3
	 cuwuYMyVdHRd77q+GUV/fBuWkBtT6T9KyMt8MxiN/w0XM06ljlWnYxyDbNGC0CQ1aq
	 15dktkxmNG5AuaehrbJjp1Jp5z2yXO7r8z4YjSfe+2trXM5Pt4flThmd+Ze33nr46Z
	 ipuEbMtO7uCmEo2OC3N4Xs7aNcy4DciqLbMx4uly8+EaKkrH9kDJuVTztM+JDChAOL
	 Ek/d0eQOSgb8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCBB39EFA55;
	Tue, 28 Oct 2025 14:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/5] net: macb: EyeQ5 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176166121351.2249512.7238254409117352079.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 14:20:13 +0000
References: <20251023-macb-eyeq5-v3-0-af509422c204@bootlin.com>
In-Reply-To: <20251023-macb-eyeq5-v3-0-af509422c204@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun_=3Ctheo=2Elebrun=40bootlin=2Ecom=3E?=@codeaurora.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, benoit.monin@bootlin.com,
 gregory.clement@bootlin.com, maxime.chevallier@bootlin.com,
 tawfik.bayouk@mobileye.com, thomas.petazzoni@bootlin.com,
 vladimir.kondratiev@mobileye.com, andrew@lunn.ch, conor.dooley@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 23 Oct 2025 18:22:50 +0200 you wrote:
> This series' goal is adding support to the MACB driver for EyeQ5 GEM.
> The specifics for this compatible are:
> 
>  - HW cannot add dummy bytes at the start of IP packets for alignment
>    purposes. The behavior can be detected using DCFG6 so it isn't
>    attached to compatible data.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] dt-bindings: net: cdns,macb: add Mobileye EyeQ5 ethernet interface
    https://git.kernel.org/netdev/net-next/c/c51aa14be9c4
  - [net-next,v3,2/5] net: macb: match skb_reserve(skb, NET_IP_ALIGN) with HW alignment
    https://git.kernel.org/netdev/net-next/c/ae7a9585ea69
  - [net-next,v3,3/5] net: macb: add no LSO capability (MACB_CAPS_NO_LSO)
    https://git.kernel.org/netdev/net-next/c/7a3d209145d1
  - [net-next,v3,4/5] net: macb: rename bp->sgmii_phy field to bp->phy
    https://git.kernel.org/netdev/net-next/c/3f7e51cd5fbf
  - [net-next,v3,5/5] net: macb: Add "mobileye,eyeq5-gem" compatible
    https://git.kernel.org/netdev/net-next/c/48cf0be9b9a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



