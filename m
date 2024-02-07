Return-Path: <netdev+bounces-69692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD5684C2EE
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 04:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D87C1C219CC
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 03:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5B7FBE8;
	Wed,  7 Feb 2024 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOe46RBO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A66AF9D6
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707275431; cv=none; b=RkuOfqozCGO81of+N2QXu+zzib8Q6PdWTLQuM1Pi0Zf8TEMflY1ArKKQ4cjpGz8vXlhCBUjfvXT4gTvBKcPxK05gA/erQGtokGkNNkyhtbN5XzaEAZJhviTn5+H+apF+u1jz5Pev0PXvoQKKjvl1/u0//1/LAn1HWUXSkfgmduw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707275431; c=relaxed/simple;
	bh=6IvGPKLO+DcUfo5i0j7WjFBkB4i7Dx15xE1Wuyw0nl8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZbCOk2QvffS/MyPZIrX+tmXdt9Gsef3ya7ihDIrpGtoe0q0Xg6dPaD8LF9PVtVZiY3vudHCIv0KIYxxNMDoM3W/RluBDXoOiVpMK169plYh44NGyt30WPXoQ16sV6r37IYYZvemAf/rh3Sd6keXcbpfk3J2o7vE4GYSCfUjhElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOe46RBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F283C43390;
	Wed,  7 Feb 2024 03:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707275430;
	bh=6IvGPKLO+DcUfo5i0j7WjFBkB4i7Dx15xE1Wuyw0nl8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TOe46RBO/qcTfUe4W4aGa5ZAYmVHd+bHmpcSNcG0Sp6NDYIVfL0TRRzfHXgQuMdeP
	 wlx0iI81MEfFJbRmefOiIzCeDeIzg8kSxGjEteVyaEuLi7Meawv3vB7yKGBPFSeCFb
	 f5K6fVYEW1SbCkbSxmFi3dueStAE/b0fuAXsirfezZl27pPAosjHgGcRgYMiIMUNG7
	 NqZRE7koxL92IDhmdfgc35skkEphk//rbyrIpbQIvyoEBiY/MRZZ6/OfRXWz2sMGzo
	 G8MJXwdEQvTJ1Em3PEHSlsToo79O74nxNTqtbbRAHmpICP7L/R6fBgdjF2idVLjvQ4
	 EIsJiybTdYv9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B37ED8C981;
	Wed,  7 Feb 2024 03:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tg3: convert EEE handling to use linkmode bitmaps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170727543030.7995.14520101133109804670.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 03:10:30 +0000
References: <0652b910-6bcc-421f-8769-38f7dae5037e@gmail.com>
In-Reply-To: <0652b910-6bcc-421f-8769-38f7dae5037e@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
 linux@armlinux.org.uk, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 3 Feb 2024 22:12:50 +0100 you wrote:
> Convert EEE handling to use linkmode bitmaps. This prepares for
> removing the legacy bitmaps from struct ethtool_keee.
> No functional change intended.
> 
> Note: The change to mii_eee_cap1_mod_linkmode_t(tp->eee.advertised, val)
> in tg3_phy_autoneg_cfg() isn't completely obvious, but it doesn't change
> the current functionality.
> 
> [...]

Here is the summary with links:
  - [net-next] tg3: convert EEE handling to use linkmode bitmaps
    https://git.kernel.org/netdev/net-next/c/9bc791341bc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



