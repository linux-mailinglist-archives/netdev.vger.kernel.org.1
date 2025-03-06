Return-Path: <netdev+bounces-172292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEE6A54138
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 04:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C074C3AD749
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 03:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AE1198A29;
	Thu,  6 Mar 2025 03:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iR2uE0+S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD926FC3
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 03:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741231798; cv=none; b=ki+UJXAeHMrb3u3XOaBcz4JEb7EOGH99kkgDiPZLDwSoWtFCjqqlUhYbyVG2loVF+t3eQC5ET2h/l5nrK/CU4WLEGdEDMLKD3LQ8BqyV+4s1EOX3df5cYGHo9wQQ0oB2e7p7o+YPm84niy9njHpOobkCPnN7ZThcDnV5qqLkUds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741231798; c=relaxed/simple;
	bh=DwjSgGJVgef0kI17Lci/NSOLJqNZW6lcGDA3JVs0eN4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P/TnBLmpY8H3oaVxvgkW3Xfv+P/D7ZN7GFXX7nygoVVD7w9xqTT2eb2RYVBmh7ygpQW2qvApcbizVv0VB+B3XF15El7AAXjUyMA7KOWp5kQsfFlggIRbQMVjAZBQIwNe+cr/APH3hhiVbU/hFKZMSHWcshXYFfgs22FumUSEx64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iR2uE0+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17194C4CED1;
	Thu,  6 Mar 2025 03:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741231798;
	bh=DwjSgGJVgef0kI17Lci/NSOLJqNZW6lcGDA3JVs0eN4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iR2uE0+SfSnt77476JZXnJN680qkQ/cgSHA59A3DTlSi8ygN62IKie4hn9Kc2xf2t
	 wzZnWPedXan6eQAbf1y0Wb3pOYpjwdIiAgm4/BL87RPJjVx9WLYDGZNpK4HbkQ/zoR
	 VIv2ROKc2PxUfpfdrPaDaDsYr651G1ldqAi9pOW1Pr/Dlk9swxR2Fmcmn1Oepdiror
	 e9We/yar6Xn69T1B8NlA0isfyRyeZRJXHmMebxtOAjcJQznpHygSPxYaExy8WvSU3h
	 GKS773jmuClkSi0Xan0k+aSy/LYPN1UC1IF+bQxrk/xUhA12UjJaQEzehHLSh+rs6z
	 Gal35QdNkTK7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C5A380CFF3;
	Thu,  6 Mar 2025 03:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: mt7530: Fix traffic flooding for MMIO
 devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174123183127.1114452.4008171486418029850.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 03:30:31 +0000
References: <20250304-mt7988-flooding-fix-v1-1-905523ae83e9@kernel.org>
In-Reply-To: <20250304-mt7988-flooding-fix-v1-1-905523ae83e9@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: chester.a.unal@arinc9.com, daniel@makrotopia.org, dqfext@gmail.com,
 sean.wang@mediatek.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 04 Mar 2025 09:50:23 +0100 you wrote:
> On MMIO devices (e.g. MT7988 or EN7581) unicast traffic received on lanX
> port is flooded on all other user ports if the DSA switch is configured
> without VLAN support since PORT_MATRIX in PCR regs contains all user
> ports. Similar to MDIO devices (e.g. MT7530 and MT7531) fix the issue
> defining default VLAN-ID 0 for MT7530 MMIO devices.
> 
> Fixes: 110c18bfed414 ("net: dsa: mt7530: introduce driver for MT7988 built-in switch")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: mt7530: Fix traffic flooding for MMIO devices
    https://git.kernel.org/netdev/net/c/ccc2f5a436fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



