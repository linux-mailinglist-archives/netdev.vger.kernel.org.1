Return-Path: <netdev+bounces-158062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB3EA10509
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 12:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41F93A6660
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 11:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2FD22963F;
	Tue, 14 Jan 2025 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6eFMFjt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4DE1ADC9B;
	Tue, 14 Jan 2025 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736853014; cv=none; b=EtxgSQ/8apVzPhz4b9T7MWnRmpQ/0X61XuYZfUmfITRIBSU5fUxhoIbO1oPRAgEsemElt9Ml5vqnXWs1t/CIBdMcC8DrXSq+6u1d6qlWZr3ph99L4momiTQl8bwwXtKpwrQGCbkEDGP12QYMdmVdupoUe9qdF324RLtT5zGhwpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736853014; c=relaxed/simple;
	bh=ljvHFsyZjZrin24tJ2bV14hRI8tsjGx2Pxwd7Eg49Hg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o0xaAA4YGDBJozU7p4qO8Hta/KZEqmPInBFJVm8Lh3KREuhTfGFlJKs4x3ImBANzx8vcRoToMMbRebyXjVukmz8PwUd6WNP2dBEVJyrPeMsLVOVvej0mD70LvZqe2vlrdR9seIXQaSCQ28qwXIFXUM915A5bRGxBArRc5EYNWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6eFMFjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F90C4CEDD;
	Tue, 14 Jan 2025 11:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736853013;
	bh=ljvHFsyZjZrin24tJ2bV14hRI8tsjGx2Pxwd7Eg49Hg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T6eFMFjt4YjdDLRnPqzp82l0EUPUUdUZ2kI/d6xrt/qJMmZO5I4fuVvpzFPY56ufd
	 YSf5uxe7ejTRVCyEY73VqYGReLte32FaZV9zu+sGiEQnyMvDuKS+emXWNzSGxAfY4P
	 kjjdx5qsrY/M/B+AuIpExjys0Thnls/SF7dnYaMnEqQq9PJXNyHBlwyVv4TWXJntrF
	 QH0IUw6SxLSnC6iRTTHsVZ4esqhngVr5dGMFKxKC7u16FHGUf34mhGyLluG0SRTViP
	 OEdv953d+914bruD3MLCn3ExG8+FyxHnCBpqrrlSwUgsWHtXnGNlrvmLGn4eUNfcUb
	 lQ2RXAkRFh3fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72E96380AA5F;
	Tue, 14 Jan 2025 11:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/7] Introduce unified and structured PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173685303625.4140712.8722921503248982401.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 11:10:36 +0000
References: <20250110060517.711683-1-o.rempel@pengutronix.de>
In-Reply-To: <20250110060517.711683-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, hkallweit1@gmail.com,
 corbet@lwn.net, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, horms@kernel.org, linux@armlinux.org.uk,
 maxime.chevallier@bootlin.com, linux-doc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 10 Jan 2025 07:05:10 +0100 you wrote:
> This patch set introduces a unified and well-structured interface for
> reporting PHY statistics. Instead of relying on arbitrary strings in PHY
> drivers, this interface provides a consistent and structured way to
> expose PHY statistics to userspace via ethtool.
> 
> The initial groundwork for this effort was laid by Jakub Kicinski, who
> contributed patches to plumb PHY statistics to drivers and added support
> for structured statistics in ethtool. Building on Jakub's work, I tested
> the implementation with several PHYs, addressed a few issues, and added
> support for statistics in two specific PHY drivers.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/7] ethtool: linkstate: migrate linkstate functions to support multi-PHY setups
    https://git.kernel.org/netdev/net-next/c/fe55b1d401c6
  - [net-next,v7,2/7] net: ethtool: plumb PHY stats to PHY drivers
    https://git.kernel.org/netdev/net-next/c/b7a2c1fe6b55
  - [net-next,v7,3/7] net: ethtool: add support for structured PHY statistics
    https://git.kernel.org/netdev/net-next/c/6167c0b6e8d7
  - [net-next,v7,4/7] Documentation: networking: update PHY error counter diagnostics in twisted pair guide
    https://git.kernel.org/netdev/net-next/c/7d66c74a171d
  - [net-next,v7,5/7] net: phy: introduce optional polling interface for PHY statistics
    https://git.kernel.org/netdev/net-next/c/f2bc1c265572
  - [net-next,v7,6/7] net: phy: dp83td510: add statistics support
    https://git.kernel.org/netdev/net-next/c/23bbd28729bd
  - [net-next,v7,7/7] net: phy: dp83tg720: add statistics support
    https://git.kernel.org/netdev/net-next/c/677d895af1cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



