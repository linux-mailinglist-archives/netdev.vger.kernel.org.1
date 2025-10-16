Return-Path: <netdev+bounces-230249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B037BE5C45
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 01:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFF419A7DA5
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 23:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D602E7199;
	Thu, 16 Oct 2025 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0MLGu9z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751CD2E62AC
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760656228; cv=none; b=TorUX9yECfr9CQY+RAr3v6SqRzoMx0byKfHDpqOYYaFjmE042nKO6eUjV+w/iUyfNNtQwtH8APpP+ZM04SfzpoPWI6YAdMzcQo1hpwKv722BAWwwqmJEpPKo0UnttrLx0kxjauQjrVyrPXOTRuJu0rrCuCzbdXrdwbGYypDK15E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760656228; c=relaxed/simple;
	bh=7AUlS/E/OmspYWOQMifKYx2KW7NrQ6lvqhU6h0IwChE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pnJZJ1HEcoG1ZKSLl4uhJKooKiEA6NpdY/E/fAakO8/ks7Ca3pPJnf8v3MiIxILPaWD/1epP/+sT/LBnHjznJfc+uSDv5LZcdFDNaZe4R9B/PlDWaoOFqXtG4nocFc/6KoNwnWhodpcX0PpiAl5FWSTmfFOqYNAxwE2ZB4jFPXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0MLGu9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B2AC4CEF1;
	Thu, 16 Oct 2025 23:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760656228;
	bh=7AUlS/E/OmspYWOQMifKYx2KW7NrQ6lvqhU6h0IwChE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q0MLGu9zZFT+dmRt7e4efsxOyKWlLoPYupOEksSgrt8aMxyfl/jbIxtivbj8TNn5O
	 v6x4BaqC3tPY6C1Io5g9D18XlWWvOvEOekiiTXVYAJxxYUTkRNEBk//Qs99X5kuAf+
	 D3Fpzw/uA6A25M9e7UeaEWYxD/lBUmsy67+E0DdeE9lRHi31676/i1ZotqS4/XAS6n
	 HJUrDW/cKNyiWBK36zT7IliROMXrft9r6ehusOKJqlgR1UBYKxyYYDmkuf27N7Bajc
	 Ex8ez8sOUoMP5Gup9dUJt8ItnPWNV7iUk8SXO5UTbgiWJrV1WraKEANo08DVe4VhDU
	 UDy5tacS3p/xA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F553810902;
	Thu, 16 Oct 2025 23:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: stmmac: more cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176065621200.1940287.10394518101609096808.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 23:10:12 +0000
References: <aO_HIwT_YvxkDS8D@shell.armlinux.org.uk>
In-Reply-To: <aO_HIwT_YvxkDS8D@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Oct 2025 17:09:07 +0100 you wrote:
> The subject for the cover message is wearing thin as I've used it a
> number of times, but the scope for cleaning up the driver continues,
> and continue it will do, because this is just a small fraction of the
> queue.
> 
> 1. make a better job of one of my previous commits, moving the holding
>    of the lock into stmmac_mdio.c
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net: stmmac: dwc-qos-eth: move MDIO bus locking into stmmac_mdio
    https://git.kernel.org/netdev/net-next/c/12a7b7bc1427
  - [net-next,2/5] net: stmmac: place .mac_finish() method more appropriately
    https://git.kernel.org/netdev/net-next/c/0bc832a54d27
  - [net-next,3/5] net: stmmac: avoid PHY speed change when configuring MTU
    https://git.kernel.org/netdev/net-next/c/e82c64be9b45
  - [net-next,4/5] net: stmmac: rearrange tc_init()
    https://git.kernel.org/netdev/net-next/c/07d91ec99a8a
  - [net-next,5/5] net: stmmac: rename stmmac_phy_setup() to include phylink
    https://git.kernel.org/netdev/net-next/c/4a4094ba7ad2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



