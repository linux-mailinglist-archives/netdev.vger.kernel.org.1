Return-Path: <netdev+bounces-107575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4802F91B932
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0172B2134E
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 08:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2AB47F59;
	Fri, 28 Jun 2024 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uipkXCMK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118DB79F2;
	Fri, 28 Jun 2024 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719561629; cv=none; b=TM0iaTzsb5nenxLLCyuX6R50ofaGu63KXbku+doAFHKHvg4TpA45Re946gsc2tbU8aiE6YoZ+kSJ+PqaiGomH95lenFW7LAQplPMnTK3GdqZrmQtiBi47jgwbcStoy4B9dIDiO5xpVHwqDXryaV8QtCKAOMvivCc8BJKoX9We9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719561629; c=relaxed/simple;
	bh=XhNNQC6yWru73k0KmPtS/LA0y6wVM9NuF8Rpi2oA4e0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=czq4cUiVAZMo7qZi05sTiuz8tP/QwOvicHlOUHfU2zqQtlNZnoLWCSLfSZxFHZSIDiynfde4EXTRvQsCKpEGQIBleJv0b7RzJfvGM24bczNelpAZ5I8DiyDGFWW0Z/JBKkaypDN0XwNztMbt3BhtAkdayIPEalEqT5of8YCQCXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uipkXCMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9288DC32789;
	Fri, 28 Jun 2024 08:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719561628;
	bh=XhNNQC6yWru73k0KmPtS/LA0y6wVM9NuF8Rpi2oA4e0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uipkXCMKZN1khEQwc/Ztxz5SIcYSzJq+yWz5gOIYvA0R1f2WnFCfFuZJA5ZEdJWnN
	 2yHX+kZVbip0AEhtKBHPwRsqaZAf++OiJQTHOv3XVhfY4B1tVJwqUB9BYIy/O3IDdw
	 L7vSdXsTiUBPKZ/dzJRx5AcOPSPL4LqnEECVem5dp2xuJsx/f0nAkCbVUkBYtChhJA
	 /3vbxhrrXn+uT4G/kR1ouXISdzXx9ZXHqSLFsJhGBUq1l4v3k+DzTup1J7XxJ5OqCO
	 p+SP67g+XpTm0Re0TH4G4/w0veTV+7g0c/YWoPrjBE4/jDVAEMhSVklvIjVilPEHzP
	 p129y/7xmALeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C50DC43335;
	Fri, 28 Jun 2024 08:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next,PATCH v2] dt-bindings: net: realtek,rtl82xx: Document known
 PHY IDs as compatible strings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171956162850.13450.13594375026580373967.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jun 2024 08:00:28 +0000
References: <20240625184359.153423-1-marex@denx.de>
In-Reply-To: <20240625184359.153423-1-marex@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, conor+dt@kernel.org,
 davem@davemloft.net, edumazet@google.com, f.fainelli@gmail.com,
 hkallweit1@gmail.com, kuba@kernel.org, qiangqing.zhang@nxp.com,
 krzk+dt@kernel.org, pabeni@redhat.com, robh@kernel.org,
 devicetree@vger.kernel.org, kernel@dh-electronics.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 25 Jun 2024 20:42:28 +0200 you wrote:
> Extract known PHY IDs from Linux kernel realtek PHY driver
> and convert them into supported compatible string list for
> this DT binding document.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Joakim Zhang <qiangqing.zhang@nxp.com>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: kernel@dh-electronics.com
> Cc: netdev@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v2] dt-bindings: net: realtek,rtl82xx: Document known PHY IDs as compatible strings
    https://git.kernel.org/netdev/net-next/c/8fda53719a59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



