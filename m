Return-Path: <netdev+bounces-145165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F989CD5E2
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 04:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 116E6B23599
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C631741CB;
	Fri, 15 Nov 2024 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9NOXVfI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3C8173357;
	Fri, 15 Nov 2024 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731641427; cv=none; b=gDY0W15DyMrHzy66YGBBKxPBAYujx5dOgobEEGRJ5H3RV25fS7FxGn1V0ms68VlOhbHfcKNtmEKcfFCA58nD/m8/CYBwWlXJJUsehCx2BkoMAdNk/Zr1o5yhobRlxGhQB3CIgOcMBP09CkIG/vIhL2J8KnHjRoDEUYe3v8GjFQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731641427; c=relaxed/simple;
	bh=JV/05U3NhZxJjiMzxnBuMp3VCFi+787aOaBvpWeQEh0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PGJG2leYQYZs7rOnOYFiGJoCXvkAVaI8KsGVC+f2MRI8JDXVHhgmKoREhUb8epSPZ1E7//SIH90U4CBs9XroAFLz00iPJ636gI2NfOb2EFR+xt01LbTmx5g2W+nFTmGjOnHTH0YPOppv4yJVdJWdYG3kwnxBL6Wdvs3jh165ouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9NOXVfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE150C4CECF;
	Fri, 15 Nov 2024 03:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731641426;
	bh=JV/05U3NhZxJjiMzxnBuMp3VCFi+787aOaBvpWeQEh0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E9NOXVfIzPAlP+Nr8dhoMVk03F3w3huF0Pb55FCFkVS96J6pTAPCmbMNO+GQgkJkW
	 KDB0KuAkTVEqGOzsS3zvOsK59H7WGMfz4YXS+U0scvpL9wykefAFxPnqda1c19zq2G
	 FzKfFbNQ6z1gAUdzM/rkTSCY+bvqR5CLQ+njiFNGyvUIaN01Y7p4rMPT7lWRzfY9tJ
	 E2Go0Qt/4M2lcWJ5/vagHShT9FUh6wEZJ80s6IoPvno1IY6+nJxyQ8PhXm/2cdCEHc
	 QkM9gmSsSiOdfdrw++dmP1L9Dfgp4iHXzkrvuhB5/X4J/C9yUdvcdm3lxvillyV7fe
	 i+mwoTboM/HTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD283809A80;
	Fri, 15 Nov 2024 03:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] include: mdio: Remove mdio45_ethtool_gset()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173164143724.2139249.14310287581673930566.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 03:30:37 +0000
References: <20241112105430.438491-1-alistair@alistair23.me>
In-Reply-To: <20241112105430.438491-1-alistair@alistair23.me>
To: Alistair Francis <alistair@alistair23.me>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux@armlinux.org.uk, hkallweit1@gmail.com, andrew@lunn.ch,
 alistair23@gmail.com, alistair.francis@wdc.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Nov 2024 20:54:29 +1000 you wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> mdio45_ethtool_gset() is never called, so let's remove it.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  include/linux/mdio.h | 16 ----------------
>  1 file changed, 16 deletions(-)

Here is the summary with links:
  - [1/2] include: mdio: Remove mdio45_ethtool_gset()
    https://git.kernel.org/netdev/net-next/c/e7cb7cf43afb
  - [2/2] mdio: Remove mdio45_ethtool_gset_npage()
    https://git.kernel.org/netdev/net-next/c/575092a7f0ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



