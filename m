Return-Path: <netdev+bounces-212862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED148B224BF
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98EC1B62EE4
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EFE2EBDD3;
	Tue, 12 Aug 2025 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QifySFFX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDF72EBDC8;
	Tue, 12 Aug 2025 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995195; cv=none; b=qOTpnPHLWFF20X+6mM3wZ011JBao9I3tst9qU8hrCFxsZuoeKW1fRFtzPUpmyz2iao8Dbytxo4QpquURY/jxdXqgXlyVCGK7zTgXkRgfODh6+CkIOm+ra4Gi6F+0rkf7E7Nk3R8z2SLGyFjZ9ZmePGSh972VDJgA81XO3VtK5qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995195; c=relaxed/simple;
	bh=yVZkwPxYgjMUDfH1WgTDq1x+4n/M2A7TWVb2Pp9NP24=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tqvcFRII8fjjpQ0G4ZbyfqD6/rhehBDSLuYYLCEIVnV6GSpDBJUHt2SnuQhBVU2DHeaBlPaTZ3wzksKxYCpro0XoxRoIQNyDlIV9KopfhcgYJrUmYGsQlwzTrizHuRgkUME12TcBO4r6B2b2y1mvdVuoF8eG7Iwb8JkWdYf1FhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QifySFFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AC7C16AAE;
	Tue, 12 Aug 2025 10:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754995195;
	bh=yVZkwPxYgjMUDfH1WgTDq1x+4n/M2A7TWVb2Pp9NP24=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QifySFFXit5WSKnF6brW6NTFQZ3uJIr3H7toaIkCO06fNnWdx6/u0zy6J0JNngYFj
	 YBRjCKs/Qux+HMbI1itKDCCsmmOd6QIFlXo+65kOZTJn8Z2n3QWxv7eBz07ZpbI3fZ
	 yVJt4nnNdkj7sxyoD0ZEjDu+hq2LJ6PolVUKEgcCgoL90WyxOF4cAMm3Ay3dOGTh81
	 Y0vgNPVbxa/JebPWV01CUvNRGrSMkNRl2/u0WF0V/YOKbObfSiqdZhBezwrNethrYO
	 pY+MVK78v10QcaweYI0PISi7VqTFrXqDOJHb+AXsuZvRTlJ6eAVJWdU7Voo/wrj5lQ
	 MoUANsS8WPZ8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEC5383BF51;
	Tue, 12 Aug 2025 10:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: nxp-c45-tja11xx: fix the PHY ID mismatch
 issue
 when using C45
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175499520750.2526251.1270077410677904489.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 10:40:07 +0000
References: <20250807040832.2455306-1-xiaoning.wang@nxp.com>
In-Reply-To: <20250807040832.2455306-1-xiaoning.wang@nxp.com>
To: Clark Wang <xiaoning.wang@nxp.com>
Cc: andrei.botila@oss.nxp.com, andrew@lunn.ch, ansuelsmth@gmail.com,
 davem@davemloft.net, edumazet@google.com, hkallweit1@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
 sd@queasysnail.net, linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  7 Aug 2025 12:08:32 +0800 you wrote:
> TJA1103/04/20/21 support both C22 and C45 accessing methods.
> 
> The TJA11xx driver has implemented the match_phy_device() API.
> However, it does not handle the C45 ID. If C45 was used to access
> TJA11xx, match_phy_device() would always return false due to
> phydev->phy_id only used by C22 being empty, resulting in the
> generic phy driver being used for TJA11xx PHYs.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: nxp-c45-tja11xx: fix the PHY ID mismatch issue when using C45
    https://git.kernel.org/netdev/net/c/8ee90742cf29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



