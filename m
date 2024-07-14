Return-Path: <netdev+bounces-111326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 293C6930823
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 02:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5989F28267E
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 00:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8A68465;
	Sun, 14 Jul 2024 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bH55iZxe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E73468E;
	Sun, 14 Jul 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720915231; cv=none; b=R0yRKdUKMehcaCyWZO7c0UeenW3ieFOjJez+Pr5SPg13ZlDEc88xk+3lzJ7FCCFI2UY6xnPaF+yJCowJ9r9yzee1d6G2fXiXyQyi5kkg1OllXNS/rHxkO72mhL5cJA3cbuJ285XU+PdD6KTIgGME0mY5WG10m779MXv0jvlgxgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720915231; c=relaxed/simple;
	bh=Zt++9+KS+Zq/2PiDsClE1+zOplP3asbnw2mTMuviQXA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LQJSK0EffDKAL7mV8eikctZt9nc/kG0aWedgu/omoE5a2KAcOj6XjvuWZDxqnr56ZVTvTeLZr9t6SycRUKA3r+HNOJGTmUVP1//5QPFdAG54tR1k8wSi8tgdYtpAlc3R0gY6wcxQCDdjjIRxDKMd4E78fZFhYql0dqojRr4bHaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bH55iZxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F6C8C4AF0B;
	Sun, 14 Jul 2024 00:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720915230;
	bh=Zt++9+KS+Zq/2PiDsClE1+zOplP3asbnw2mTMuviQXA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bH55iZxeRK398dfSaFhj1gZ327Q1h1AtAiHeuxiHOgiNXkigsn42R+e2K8wGm7NDb
	 YQC2YHaof8x3GAladxIB2XeKKTP5bRKQLW2VttNGr3v1h8OqZd4/vwjQ6Wk43xvUr9
	 eDexXVxB+1WdCywpfCQBIp2D4TRLKFGmGOdFh50hRBulLCRsJgZksPA0kecZCFvicj
	 1AZsRvPI4vz7AQ883zOGXXBfJVrO2rrsowlOEcPdOBe48vRtn2M6O090mkjd74xn4b
	 sUaIYthXB46ogFbckUdNsFPVMVlVLUSZuwy+V2aD4FzLnG8GWNnqLVwQof7qDkGogH
	 1ubTSpnVHbdgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6AC7BC43168;
	Sun, 14 Jul 2024 00:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/1] net: phy: dp83td510: add cable testing
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172091523043.919.16581581924126130339.git-patchwork-notify@kernel.org>
Date: Sun, 14 Jul 2024 00:00:30 +0000
References: <20240712152848.2479912-1-o.rempel@pengutronix.de>
In-Reply-To: <20240712152848.2479912-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jul 2024 17:28:48 +0200 you wrote:
> This patch implements the TDR test procedure as described in
> "Application Note DP83TD510E Cable Diagnostics Toolkit revC", section 3.2.
> 
> The procedure was tested with "draka 08 signalkabel 2x0.8mm". The reported
> cable length was 5 meters more for each 20 meters of actual cable length.
> For instance, a 20-meter cable showed as 25 meters, and a 40-meter cable
> showed as 50 meters. Since other parts of the diagnostics provided by this
> PHY (e.g., Active Link Cable Diagnostics) require accurate cable
> characterization to provide proper results, this tuning can be implemented
> in a separate patch/interface.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/1] net: phy: dp83td510: add cable testing support
    https://git.kernel.org/netdev/net-next/c/0cda1acfa235

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



