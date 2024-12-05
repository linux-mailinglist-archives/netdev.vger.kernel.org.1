Return-Path: <netdev+bounces-149223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BECAF9E4CAB
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 04:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8287518818F1
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 03:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D673F18BC19;
	Thu,  5 Dec 2024 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qt+++y/u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C9B17A5BD
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733369425; cv=none; b=FU00inJ1rtknTBrnFEAfWb3wxLmU6Z3BITSd2lGzHckhwWZ5JMyCnxFVn2egZF/4BFsU7CgbljDvvthtvL8ysZ+pcis0zOTldozbB6wwDIRs9+MPcQEgFf86AKN0829BWeru2PqYopXTi0Z254ryv2I2hV6HNxY08fVnQw/CuBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733369425; c=relaxed/simple;
	bh=n2yaS19lTSvPCvppsIIULqDudd0DTA8wDjgkEyMzRVQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dgct3OZl1gT5Ih9ZC1AvhE7DWGlZYZvphUXi3/dz1sC/a16sKM0whD2/CHNE7edDNdXU9/mDf/AOm25ZmOxo21BL4l7eQXRF7QPSZAC9Zcaa4HEihmHpFVOUN4LoZs39PQ0OMOiMsn1mUl3wFlDD9zcxt6s9d7EJqgEwGjtEz98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qt+++y/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253B4C4CED6;
	Thu,  5 Dec 2024 03:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733369425;
	bh=n2yaS19lTSvPCvppsIIULqDudd0DTA8wDjgkEyMzRVQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qt+++y/uPxQjyfdUbELM19i0089ME2qCiqaniNK47Tsf3Tiz19b4oRWVgOaaRRK9b
	 2KvS5V1wpUHiD5L64OqR52CgsnzSbhmn9+lGH4NFSyfxpuXRnIJldXpK/jMB53yyjx
	 vmTbcZMh7DBlA/1MyiFqOmObs3ZAsoedxf1xHtumNL1BZhTOtfIcOVEpf/p6tuwkX4
	 CsQt5iozGHB6fTCGSoVyV7UUxkVTEP1/itCDBwN8DlgtXFek8qMo4NLb1x1f43bHtB
	 v6edFLsISRRBHgzWhQy5Y9kfPaSuFQtioIL62BD+TugnOdgx/5SYf+WpR7I1Fm9ohb
	 FgvYCCzI5X/tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB68B380A94C;
	Thu,  5 Dec 2024 03:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/13] net: add negotiation of in-band capabilities
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173336943950.1431012.10844708315992493621.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 03:30:39 +0000
References: <Z08kCwxdkU4n2V6x@shell.armlinux.org.uk>
In-Reply-To: <Z08kCwxdkU4n2V6x@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
 edumazet@google.com, florian.fainelli@broadcom.com, kuba@kernel.org,
 marcin.s.wojtas@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 3 Dec 2024 15:30:19 +0000 you wrote:
> Hi,
> 
> This is a repost without RFC for this series, shrunk down to 13 patches
> by removing the non-Marvell PCS.
> 
> Phylink's handling of in-band has been deficient for a long time, and
> people keep hitting problems with it. Notably, situations with the way-
> to-late standardized 2500Base-X and whether that should or should not
> have in-band enabled. We have also been carrying a hack in the form of
> phylink_phy_no_inband() for a PHY that has been used on a SFP module,
> but has no in-band capabilities, not even for SGMII.
> 
> [...]

Here is the summary with links:
  - [net-next,01/13] net: phylink: pass phylink and pcs into phylink_pcs_neg_mode()
    https://git.kernel.org/netdev/net-next/c/17ed1911f9c8
  - [net-next,02/13] net: phylink: split cur_link_an_mode into requested and active
    https://git.kernel.org/netdev/net-next/c/1f92ead7e150
  - [net-next,03/13] net: phylink: add debug for phylink_major_config()
    https://git.kernel.org/netdev/net-next/c/4e7d000286fe
  - [net-next,04/13] net: phy: add phy_inband_caps()
    https://git.kernel.org/netdev/net-next/c/b4c7698dd95f
  - [net-next,05/13] net: phy: bcm84881: implement phy_inband_caps() method
    https://git.kernel.org/netdev/net-next/c/c64c7fa0a774
  - [net-next,06/13] net: phy: marvell: implement phy_inband_caps() method
    https://git.kernel.org/netdev/net-next/c/1c86828dff88
  - [net-next,07/13] net: phy: add phy_config_inband()
    https://git.kernel.org/netdev/net-next/c/5d58a890c027
  - [net-next,08/13] net: phy: marvell: implement config_inband() method
    https://git.kernel.org/netdev/net-next/c/a219912e0fec
  - [net-next,09/13] net: phylink: add pcs_inband_caps() method
    https://git.kernel.org/netdev/net-next/c/df874f9e52c3
  - [net-next,10/13] net: mvneta: implement pcs_inband_caps() method
    https://git.kernel.org/netdev/net-next/c/513e8fb8fa32
  - [net-next,11/13] net: mvpp2: implement pcs_inband_caps() method
    https://git.kernel.org/netdev/net-next/c/d4169f0c7665
  - [net-next,12/13] net: phylink: add negotiation of in-band capabilities
    https://git.kernel.org/netdev/net-next/c/5fd0f1a02e75
  - [net-next,13/13] net: phylink: remove phylink_phy_no_inband()
    https://git.kernel.org/netdev/net-next/c/77ac9a8b2536

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



