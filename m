Return-Path: <netdev+bounces-184035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C52A92FBF
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DC617AD0DC
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D258A2676C5;
	Fri, 18 Apr 2025 02:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdPGaER1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90842676C4;
	Fri, 18 Apr 2025 02:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942194; cv=none; b=tAgM6qom3/8G2CJxe5i1i2aVtqujy4qrj2VCpwbxk8E2hCIHPg/6bZCi3ayAVV1dzRVT+VTUz6nc197e2lNUkbQRZE8vHZn3E7xKi8jq4nhuKi/4vHUPibbfOZ/WhUGM/6nIxFPrPsvAxn1RLGcMJOn7vHd/ZAeACqjfDVe5hcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942194; c=relaxed/simple;
	bh=XXuoxbGRXJI/nFv3Zm5JjFVAsdsJbYo6PHU2jNjqd4I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YEImYyAaZ1i2Dds+VtccM7XH6ajC1eaTkYw8eE1otYD3tHVs1E+CY3HAr0pzLl9WGTLgjiO3pxk3AKfvaxGel69qTqXtywfr7lrLn6iozdFzqx50jzqHI5sNrRHn3UFXKbLhMvZTJGr+6YFXA4hI8s48m82dFoYqLFEu/0R3t3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdPGaER1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC0CC4CEEA;
	Fri, 18 Apr 2025 02:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744942194;
	bh=XXuoxbGRXJI/nFv3Zm5JjFVAsdsJbYo6PHU2jNjqd4I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YdPGaER11sBr6DPuRVmbb7ak5yTBVaTi5hgqdw1k7BoV+ocgtcB85WOpGLuzqqaCi
	 U4WiHc7HHW0e1rt88n2TUsfgcmL91v/ifL7UP9ekC7H4bEuLOEAKj/RVlkITeapsY6
	 Lg3mbLLKDmFemXF5sCH4OT+NtikOSOIau5KuRIEN+CM6KYJgSu88WGlrepj7Xcw/AL
	 s+80ukQWvfgVmeUt3ShbNwV+vIT7c/j9No1MyeCKq1DS5PcIMur2xtZO/o1jsL13cF
	 kuQT/6qIc0MhV90IhR6VRxQBzhOZgUby9yaSXQ0ubDFDoUmTqEnBSsZhj0MAtD0oHR
	 Jxf2dADb+5eaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713B0380AAEB;
	Fri, 18 Apr 2025 02:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: Add entry for Socfpga DWMAC ethernet glue
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174494223208.79616.4144128336191730850.git-patchwork-notify@kernel.org>
Date: Fri, 18 Apr 2025 02:10:32 +0000
References: <20250416125453.306029-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20250416125453.306029-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, andrew@lunn.ch, linux@armlinux.org.uk,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, horms@kernel.org, alexis.lothore@bootlin.com,
 dinguyen@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Apr 2025 14:54:48 +0200 you wrote:
> Socfpga's DWMAC glue comes in a variety of flavours with multiple
> options when it comes to physical interfaces, making it not so easy to
> test. Having access to a Cyclone5 with RGMII as well as Lynx PCS
> variants, add myself as a maintainer to help with reviews and testing.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: Add entry for Socfpga DWMAC ethernet glue driver
    https://git.kernel.org/netdev/net/c/750d0ac001e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



