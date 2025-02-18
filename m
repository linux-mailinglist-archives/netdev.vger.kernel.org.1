Return-Path: <netdev+bounces-167152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2694A39048
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6311716DC
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E7E1487F6;
	Tue, 18 Feb 2025 01:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWb/VpUJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE40537F8;
	Tue, 18 Feb 2025 01:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739841621; cv=none; b=T2qAX/ZmZtxywDwe5WJn5DiKzSwoTco+1SoiRoBwxPUOAu1oRZBZ4P4d3CoDGYzaqalZ8Hjegj3C5y8EsauKfWstcsDgZjxWwYpkOOnEk4PlrRZi8brzOfklZnveog8hIKcukCI/9hWhRv96sdyD+8fVvKpNguDTeY8kUr8oN9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739841621; c=relaxed/simple;
	bh=faw9/dQRG1yyXfFilLPDy5GQnixQoVs1FkcKsxZbL3I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HcaSL0GJ20zyDLQbsVfD5IzRKWLbzxxbPpa0g+02+Uu4F2kc7njw89m/hIE7qOexpnQ55o5KQYb9/SYA3vF8VC+2z1lSJTTiHunXfQT/I94PBs5ZkOhHstzAJkLo/e0PGMqkj2q+T2nJjZMPrnhz+aRvFAH6Nx5p+76X1CSTDng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWb/VpUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB5BC4CEE4;
	Tue, 18 Feb 2025 01:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739841621;
	bh=faw9/dQRG1yyXfFilLPDy5GQnixQoVs1FkcKsxZbL3I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GWb/VpUJETmWTep+sh2o8ryfOUwowkwBrGdoeEsg0e2gtFAu8AcMQh28ysFEMSdo+
	 Kh7zf5TBkTTMbWuPlg3RmpVpNWqKaE4kQki6Rsbl9HIJ2ECyEEd89hcBC7NnnfY9QC
	 DreNL/HGJtOCDTlkSA+PBJvEqVq/dAI2eZPJPB5XkT/Y7oY4N8w+8z3W6Ft36oQHa2
	 UClcSlqRYz1aj9CftIDghxKFZlwGz0I2bAD7NfSR6BjMq3TBBM0LGI78GjknI07Lbj
	 FMrLLvoyQu+ORbyhaIATZgXMSAKv0QEeXCdxuN4miJ7Zq5mmwwFdsHU536JHA2k1xv
	 7+AUU91JCjsPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE82380AAD5;
	Tue, 18 Feb 2025 01:20:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/3] net: phy: dp83822: Add support for
 changing the transmit amplitude voltage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173984165125.3591662.98390841427840675.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 01:20:51 +0000
References: <20250214-dp83822-tx-swing-v5-0-02ca72620599@liebherr.com>
In-Reply-To: <20250214-dp83822-tx-swing-v5-0-02ca72620599@liebherr.com>
To: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, afd@ti.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, f.fainelli@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dimitri.fedrau@liebherr.com, dima.fedrau@gmail.com,
 conor.dooley@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Feb 2025 15:14:08 +0100 you wrote:
> Add support for changing the transmit amplitude voltage in 100BASE-TX mode.
> Add support for configuration via DT.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
> Changes in v5:
> - Remove default from binding
> - Fix description in binding by defining what 100% gain means
> - Switch to reverse christmas tree in phy_get_internal_delay
> - Add kernel doc for phy_get_tx_amplitude_gain
> - EXPORT_SYMBOL_GPL for phy_get_tx_amplitude_gain
> - Link to v4: https://lore.kernel.org/r/20250211-dp83822-tx-swing-v4-0-1e8ebd71ad54@liebherr.com
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/3] dt-bindings: net: ethernet-phy: add property tx-amplitude-100base-tx-percent
    https://git.kernel.org/netdev/net-next/c/7fff5d958648
  - [net-next,v5,2/3] net: phy: Add helper for getting tx amplitude gain
    https://git.kernel.org/netdev/net-next/c/961ee5aeea04
  - [net-next,v5,3/3] net: phy: dp83822: Add support for changing the transmit amplitude voltage
    https://git.kernel.org/netdev/net-next/c/4f3735e82d8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



