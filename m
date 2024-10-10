Return-Path: <netdev+bounces-134193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E04599856E
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D59B1F24B02
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE361C3F11;
	Thu, 10 Oct 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SH5FpR9X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88AB1C3306;
	Thu, 10 Oct 2024 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728561629; cv=none; b=qPGQuGeiX/nEtdjq82WxNq5GGnGSNk/JwAD4cx9y7sbnquztZwdq+eZYyUAiP/4O8GRm+pB/bB1fEZr4mqNdU0lp3FgU0lCqa7ThXe+KQR0C9OBsDWPjDEV2EjA0BI/TI1H2gEe3DPhr9rou/kIIKszumH/xinSEI1QaOb5DXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728561629; c=relaxed/simple;
	bh=c6+i1oawfsenOZuvjfVtY8wlO4pXPtXlWnDmDo2bqRo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J3/FHU8UdHWTwTsEiiYa06nq9PGOWW8wqhuhfsszr9RTQ2PU5yPONUQof5f9J98jPr1xIpTWKdPYbvMSQMvL2E890cVVI37l7YATYs+M243ZvE6Nz5/e4Y/9fp0MF2NbKBPFQ06XPZ/CmCXzcCyuoLP2X8bV2Tk2f23BCfc1bNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SH5FpR9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E5DC4CEC5;
	Thu, 10 Oct 2024 12:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728561629;
	bh=c6+i1oawfsenOZuvjfVtY8wlO4pXPtXlWnDmDo2bqRo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SH5FpR9X9NNcCs5WWwqg80EZEujJCm7aKGpjn9UyaudKJPuIbYOLwJGDAWePYiUlx
	 EWVlI5cWTend5SLFuEtqiLn5n2jwuroy4psKEuDipCXAEOUVJ+dGREU2T1SKJ1k+2I
	 O6Qc+iSAkJeksnyT6lVyG0Hl3B+KLCKR4EXi1xcb24NmvsXAAsubGKcHmmTpcCN5ik
	 kyn9FDwtii3RY9oRgsBX5ntji7sGU0KC1uQA+2W1Oh1cs6ktae3UDv3n2ciMH+9zmU
	 dkeAU2UBpSg6vFxklkXNCZhWLYGJ/m6b0EXbLVhYKBdK8gW8XXOenzprYQxQ61BROw
	 PNDCqCKe2atLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB7683803263;
	Thu, 10 Oct 2024 12:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v3] net: phy: Validate PHY LED OPs presence before
 registering
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172856163374.1995536.676807232332177441.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 12:00:33 +0000
References: <20241008194718.9682-1-ansuelsmth@gmail.com>
In-Reply-To: <20241008194718.9682-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  8 Oct 2024 21:47:16 +0200 you wrote:
> Validate PHY LED OPs presence before registering and parsing them.
> Defining LED nodes for a PHY driver that actually doesn't supports them
> is redundant and useless.
> 
> It's also the case with Generic PHY driver used and a DT having LEDs
> node for the specific PHY.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: phy: Validate PHY LED OPs presence before registering
    https://git.kernel.org/netdev/net-next/c/16aef66643a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



