Return-Path: <netdev+bounces-131431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D34598E7E0
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF4D2B23212
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 00:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6EC28373;
	Thu,  3 Oct 2024 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFmwFI2P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B031125DF;
	Thu,  3 Oct 2024 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727916048; cv=none; b=l2ucwPmC1isZ8qgOUw/S2bwqoo9IAx6RXPvMCwWhschH37olyZpfc4N8RFRyJgtI257mf4y9es8j8z9paVd4nYDPNOXBCiG6za2bOE0wS3MpZY3YqVOct+EYU6hbFIxz0xcBesZDYGijt7Kmn11iMJ9ePZrbc7MDMZigA39ImiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727916048; c=relaxed/simple;
	bh=dCdjA3HeObW987EWU/yaPcS6yoeIOkM77mYAtQ5piu0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BtgeQ3+XBHs2ufzTOTCv6CdL+jDrC18uLZqf/1F1ZWbhi4nsrp+H/rnOWX/oJv+uCt4HQk9NhNyahUyliyyA+3D0fTZrdEEDeLqRIcZMrJycjd54gRqcBpLfTnS2KYh1Fi3FA8jJqNJ7JC/aAYLU79nuYA/bdkxwEPZGeFu3RYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFmwFI2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A907C4CECE;
	Thu,  3 Oct 2024 00:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727916048;
	bh=dCdjA3HeObW987EWU/yaPcS6yoeIOkM77mYAtQ5piu0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mFmwFI2PCXScjjpSEfgrrY1r5Ni2ALU3vIyPtXNAwT11JR3d5xwvFKB1t+lnZGiF4
	 hfUUwtW8rjVm05BD+B21hTegEBRzCasIbbBdEc0GfMsdETWuUPV1DZNV1hA7inZtqS
	 ZgLSX5pbPSpen6o/5hUwjOKs0O1ApJ6gu3ScuIO8eblxelchX9t2nDYvBDtuEepYg4
	 oqbV9nkveGr3WYSCAgS3h5rjab+f/vfTedStIMXKvl9EBZ/+U1wEsAERBD5XUuWUsT
	 1wT4tNmEdrDwVbsC2I8WbLETwVg49Pj+BwZQVBBxzutVtmPiGnPBzA3vD/usXyA+2G
	 iTJYkZb1pkfKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF6E380DBD1;
	Thu,  3 Oct 2024 00:40:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: mxl-gpy: add basic LED support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172791605125.1387504.11373567543576124257.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 00:40:51 +0000
References: <b6ec9050339f8244ff898898a1cecc33b13a48fc.1727741563.git.daniel@makrotopia.org>
In-Reply-To: <b6ec9050339f8244ff898898a1cecc33b13a48fc.1727741563.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: lxu@maxlinear.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mail@david-bauer.net,
 ansuelsmth@gmail.com, john@phrozen.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Oct 2024 01:17:18 +0100 you wrote:
> Add basic support for LEDs connected to MaxLinear GPY2xx and GPY115 PHYs.
> The PHYs allow up to 4 LEDs to be connected.
> Implement controlling LEDs in software as well as netdev trigger offloading
> and LED polarity setup.
> 
> The hardware claims to support 16 PWM brightness levels but there is no
> documentation on how to use that feature, hence this is not supported.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: mxl-gpy: add basic LED support
    https://git.kernel.org/netdev/net-next/c/78997e9a5e4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



