Return-Path: <netdev+bounces-184936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F17AA97C02
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 03:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 913497A8052
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BF52580C7;
	Wed, 23 Apr 2025 01:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kX28TB0l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2753679D0;
	Wed, 23 Apr 2025 01:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745370596; cv=none; b=rQmXTVhR9Ph/ybjQee9EoeTEL0KSu1XtIPlZXmKloopBUA1XdQy2GzIzH+lCvPBQyAPczot83fHgBKO9FEpMLAXeaF6SRvrQaIGVqIKUsS2IVHRmG0sNcSRrvnd7Zj5P0K/62Js2OJx2lo4dcvapq/llBLr9asnIX/4mBBDBx1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745370596; c=relaxed/simple;
	bh=CsSwBwOvvSambLDsZV2UPnqCRF6/mYCB3XiishBDRmE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q8ES3mpF+mHbJFIs8jaSZ76kWt3vrA/eVPvf74e0HAbJ76HT9wuszutp4HfPF3MX5f2U8Zzj/drfTQNURz50NHPhWKK/HQVnS3LfmcYqebn3k9FiQZ3jyohfEZdJxj8nefaUMUtkZWi6Xkgz9UD5+5IBMFoG++y7kSg+mhaqPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kX28TB0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9B9C4CEEC;
	Wed, 23 Apr 2025 01:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745370595;
	bh=CsSwBwOvvSambLDsZV2UPnqCRF6/mYCB3XiishBDRmE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kX28TB0lLhtY4NeiFlQrRVQsMN1dRWyC0+Qc104QdHp76YiulL7D72rrxC0Paq1Cv
	 W/iOsicC0+e9u0/EO/hsQCMPtrDKSn15z4+D/D8NXbDkNy5l8DdQ0CxZbrBgIk7113
	 9lQPVsobmJqnwY6/Dp/gkN5smA4E+HY2k6JjZEvNWHDW4XKYfZWuCANUVeRacm+6KE
	 ak2Mt4i+HZVPeDoLzNdXHC4ERveiupZvAgbeuSYzOMtMGWweyRqDZzp38vyy4i9JnI
	 wg+1uV4JHeKUEE1ppIPyNewMdytJvBDpgYONBNlJIkN2DddoLgn2p8Bkw8Iknfzqg7
	 F4jleiEuVl+nA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C8D380CEF4;
	Wed, 23 Apr 2025 01:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] net: phy: dp83822: Add support for
 changing the MAC series termination
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174537063400.2104608.5858549846283654983.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 01:10:34 +0000
References: <20250416-dp83822-mac-impedance-v3-0-028ac426cddb@liebherr.com>
In-Reply-To: <20250416-dp83822-mac-impedance-v3-0-028ac426cddb@liebherr.com>
To: Dimitri Fedrau <Dimitri.Fedrau@liebherr.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 f.fainelli@gmail.com, andrew+netdev@lunn.ch, afd@ti.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dimitri.fedrau@liebherr.com,
 dima.fedrau@gmail.com, rmk+kernel@armlinux.org.uk

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Apr 2025 19:14:46 +0200 you wrote:
> The dp83822 provides the possibility to set the resistance value of the
> the MAC series termination. Modifying the resistance to an appropriate
> value can reduce signal reflections and therefore improve signal quality.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
> Changes in v3:
> - Add maximum to mac-termination-ohms in ethernet-phy.yaml
> - Add allowed values for mac-termination-ohms in ti,dp83822.yaml
> - Added mac-termination-ohms in sample in ti,dp83822.yaml
> - Link to v2: https://lore.kernel.org/r/20250408-dp83822-mac-impedance-v2-0-fefeba4a9804@liebherr.com
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] dt-bindings: net: ethernet-phy: add property mac-termination-ohms
    https://git.kernel.org/netdev/net-next/c/4cb6316d33d8
  - [net-next,v3,2/4] dt-bindings: net: dp83822: add constraints for mac-termination-ohms
    https://git.kernel.org/netdev/net-next/c/1de1390ee014
  - [net-next,v3,3/4] net: phy: Add helper for getting MAC termination resistance
    https://git.kernel.org/netdev/net-next/c/145436ae0119
  - [net-next,v3,4/4] net: phy: dp83822: Add support for changing the MAC termination
    https://git.kernel.org/netdev/net-next/c/6c3c3c230a13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



