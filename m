Return-Path: <netdev+bounces-193791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A025AC5EAB
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 03:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1AD49E3343
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 01:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E041F170826;
	Wed, 28 May 2025 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwsOZrth"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C3474BE1;
	Wed, 28 May 2025 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748395209; cv=none; b=YdGDt2sixV5vgubYRvv4g5wOfHPLK6bWSBV+E9qf/IyF8UKU0PlTqfQWS4hrOSilFkepipqKU+xhWTuhB3XGNEY+wRYvZy52obpF0q0UVvFGo7kMqFFBKgqs6Jr5YD9HQDRyzG6u46/7KmrIbnQs5NFOVnNLB2do/F9T5xtwfDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748395209; c=relaxed/simple;
	bh=m3QrveW3xV5EfuvOTv2NxE5UGUIv1X8HYHGlnoy2QMU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dwqf23WZHx5mLCDDb6WyTAXqX48rSVaYTNRGBk/VeLXuhGfH+dlivA3AxwK1Pf51veOGwMddkOfsg1PeVHZnAZFYY6vPsE3k/U7TjY441h+iR6bN4IUXOnBKdbrtREmi6aRY+Qe70M0JCCgOAOfJIQPrE0OAsiZT+b2SgrbyK+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwsOZrth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D02C4CEE9;
	Wed, 28 May 2025 01:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748395207;
	bh=m3QrveW3xV5EfuvOTv2NxE5UGUIv1X8HYHGlnoy2QMU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QwsOZrthoiRtdDSxr2+iS+ztsOZjpmXeZQIs2HLNItofnDBw59If+rNh8T1ORTBaH
	 njXmfi9yyOcQZJCKJbx7YGs7sY9ehLoOkuOrnLSYsInRkwwDJAnRDApbutBU0VC2Ii
	 LNOoKB6chb5g0qF1bj3Bqd0QEsZPDY6DgjDl16L9rWLrsOor+p9mjAxMtB9l9ilyh0
	 JB13zUXSI5KWAwfhUt+HkjcpRnP86ebVFdtfgcRhH9xmOinxIFrFBcnmD1RSfFtUBN
	 LqNbpKfqteHCGyo3SbrYVhE7W/HmlZNNXNbIdRlXiF91/aDgCMQxistoMfeFiNNeF5
	 wmko1C89JBhdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F25380AAE2;
	Wed, 28 May 2025 01:20:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH 0/3] net: dsa: mt7530: Add AN7583 support + PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174839524201.1849945.3988099260497875532.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 01:20:42 +0000
References: <20250522165313.6411-1-ansuelsmth@gmail.com>
In-Reply-To: <20250522165313.6411-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
 SkyLake.Huang@mediatek.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 arinc.unal@arinc9.com, Landen.Chao@mediatek.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 May 2025 18:53:08 +0200 you wrote:
> This small series add the required changes to make Airoha AN7583
> Switch and Internal PHY work due to strange default configuration.
> 
> Christian Marangi (3):
>   dt-bindings: net: dsa: mediatek,mt7530: Add airoha,an7583-switch
>   net: dsa: mt7530: Add AN7583 support
>   net: phy: mediatek: Add Airoha AN7583 PHY support
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] dt-bindings: net: dsa: mediatek,mt7530: Add airoha,an7583-switch
    https://git.kernel.org/netdev/net-next/c/fef184880923
  - [net-next,2/3] net: dsa: mt7530: Add AN7583 support
    https://git.kernel.org/netdev/net-next/c/d76556db10bf
  - [net-next,3/3] net: phy: mediatek: Add Airoha AN7583 PHY support
    https://git.kernel.org/netdev/net-next/c/8bc3c234dcb6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



