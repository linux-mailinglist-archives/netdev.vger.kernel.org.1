Return-Path: <netdev+bounces-190130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDD0AB5434
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 14:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89B74626D9
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C482728D8D0;
	Tue, 13 May 2025 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4YsjN4N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABBB238C34;
	Tue, 13 May 2025 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747137598; cv=none; b=tJV1AoPnkYWjOx9XVh4b8d3NfQsrskpzVUj1WB6ohyDrNMXIm4uAaEE1tz5mL0pR1bhtTitwJ/L/9bLT63QZgPiXWu83RorSYpYuedcv5kR/wl86NhjgLzOSIu22QoH5EM5dnviaWWrPfunHLyYk6ALCKsVf+76UE5T4J4s43kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747137598; c=relaxed/simple;
	bh=7nLZ6+YQ0LEZVQ+Ha5u7twgq3seC/yQzyyA3Aw7H+8Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F/eLeXV1pdCmSgJL4NMVLctShWgvdNepE0wfrvHoxpYY2RBQi9cD5/bCWMa/wREDkQo01+C1LQJumHkrM22wHa/bMVlGA6NqwtQTZDZfZrYtYymfgwQVYkAzhkEduc+xxWdifMu12zLeB60gNhf9JpspEzdOlRDQ6BboXSiidvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4YsjN4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1D1C4CEE4;
	Tue, 13 May 2025 11:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747137598;
	bh=7nLZ6+YQ0LEZVQ+Ha5u7twgq3seC/yQzyyA3Aw7H+8Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q4YsjN4NOsrjD21ig93pRIXgXIlScg/u+shJuBOhY+vQuh+vsxUBUGS5QvFT7X/Jk
	 +zfmybqLvuRKntNxcX1tZKgdBp1N2N6nvkjsCwoTY28tAI5pOmvXJwCWvUaz54QpVv
	 WovEzZr/j3TjPJ6Ub98BQJv+N79FDFFD4xFfeMOLFr7aUl8t9zdSEnMayTapMYfnek
	 bS6RAhNJ4+C4pR09yqEhz/KLN0OnKplO3q/Hyr2Ed/r4Nb/1n6dz4NinYWPB2zf3n9
	 KmyGcCElo1OGz9Kv0lLTsOZfCfxw+f8qT08qxOYmB+rlIMe0pDcnVMC/5qZrd8M/tq
	 giFshi9KzKwWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE339D61FF;
	Tue, 13 May 2025 12:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/5] amd-xgbe: add support for AMD Renoir
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174713763601.1640156.13599661807797356779.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 12:00:36 +0000
References: <20250509155325.720499-1-Raju.Rangoju@amd.com>
In-Reply-To: <20250509155325.720499-1-Raju.Rangoju@amd.com>
To: Rangoju@codeaurora.org, Raju <Raju.Rangoju@amd.com>
Cc: horms@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shyam-sundar.S-k@amd.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 9 May 2025 21:23:20 +0530 you wrote:
> Add support for a new AMD Ethernet device called "Renoir". It has a new
> PCI ID, add this to the current list of supported devices in the
> amd-xgbe devices. Also, the BAR1 addresses cannot be used to access the
> PCS registers on Renoir platform, use the indirect addressing via SMN
> instead.
> 
> Changes since v2:
> - include linux/pci.h in xgbe-dev.c to ensure pci_err() is defined
> - line wrap to 80 columns wide
> - address Checkpatch warning "Improper SPDX comment style"
> - use the correct device name Renoir instead of Crater
> - follow reverse Xmass tree ordering
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] amd-xgbe: reorganize the code of XPCS access
    https://git.kernel.org/netdev/net-next/c/2d4407160f60
  - [net-next,v3,2/5] amd-xgbe: reorganize the xgbe_pci_probe() code path
    https://git.kernel.org/netdev/net-next/c/bbbd7303ea18
  - [net-next,v3,3/5] amd-xgbe: add support for new XPCS routines
    https://git.kernel.org/netdev/net-next/c/e49479f30ef9
  - [net-next,v3,4/5] amd-xgbe: Add XGBE_XPCS_ACCESS_V3 support to xgbe_pci_probe()
    https://git.kernel.org/netdev/net-next/c/ab95bc9aa795
  - [net-next,v3,5/5] amd-xgbe: add support for new pci device id 0x1641
    https://git.kernel.org/netdev/net-next/c/795f86ff0505

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



