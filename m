Return-Path: <netdev+bounces-185469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA18A9A902
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA39465FC3
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E7322688C;
	Thu, 24 Apr 2025 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWyt1lig"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFAD2253E0;
	Thu, 24 Apr 2025 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745488200; cv=none; b=iVxBRYF2VNB2edS0OQtUk0DFo2AtKV4U+RPUqcEkPYkkMpY+wDknbuRKsRicY+4wxpYRFhnh9UWOkYEDMrSwzZ38f9+vAcKXSpyrteNV/y3+hYm1j/yhno5kUouF2IBUlKy3ofYN9jz7oyqRplgiDDvaxeBaZ2hHVAmQZqK7/9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745488200; c=relaxed/simple;
	bh=R9awTCWfYQT+3DVyXdq4O6KOWy8I5nbxfqM4T+xhyhA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qLPKznIIuK/5ipPWQRKx/eAZNIsnJf7IIe5FdmsKs6pwMH8/CdmyDcBQbVmgIiq3ATHyAYUusuHtyBNaidrggnsNFCy96hcfjNeCpHgMz/ZZKqkvWOb7cK8+22LdtCQHmldiEXnV/4292xV8igMPOTOu2vL0eJFSlLa84C547Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWyt1lig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30E5C4CEE3;
	Thu, 24 Apr 2025 09:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745488200;
	bh=R9awTCWfYQT+3DVyXdq4O6KOWy8I5nbxfqM4T+xhyhA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aWyt1ligkmlcN0AWt9ApWj8S0OFpt14U/4naqfbtM8ddYUlXyhu2Y9gCUfPYN8vd7
	 smtbenO/7fSiKxPhHFrJ7TznhEeSUBiHgnHVkd2k+1Iizf+ur0ZlasnHOd1VMsn/36
	 6aZe1GDwB7ao1R09QY69V6siwgWi12Z4Dy8XWwPuyvsUp/Uib6VVfUv0uzQUGNfKei
	 xsq5I9xciDXMG/DS1njjPvRBmfqkbgJ7BMg2TgCCy1zH8apaOVnfvzB+fOh4JJ0Q1G
	 J6hMmKoVtz5obhdnKUfdRDGZT3dY3vbEu9kna/U0AReSmafQaCEniHVgagyOgOa2a+
	 SbrBZ8aTn+ytQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D10380CFD9;
	Thu, 24 Apr 2025 09:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: dp83822: Fix OF_MDIO config check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174548823899.3286532.214953382110102023.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 09:50:38 +0000
References: <20250423044724.1284492-1-johannes.schneider@leica-geosystems.com>
In-Reply-To: <20250423044724.1284492-1-johannes.schneider@leica-geosystems.com>
To: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Cc: dmurphy@ti.com, andrew@lunn.ch, davem@davemloft.net, f.fainelli@gmail.com,
 hkallweit1@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk, michael@walle.cc, netdev@vger.kernel.org,
 bsp-development.geo@leica-geosystems.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 23 Apr 2025 06:47:24 +0200 you wrote:
> When CONFIG_OF_MDIO is set to be a module the code block is not
> compiled. Use the IS_ENABLED macro that checks for both built in as
> well as module.
> 
> Fixes: 5dc39fd5ef35 ("net: phy: DP83822: Add ability to advertise Fiber connection")
> Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: dp83822: Fix OF_MDIO config check
    https://git.kernel.org/netdev/net/c/607b310ada5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



