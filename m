Return-Path: <netdev+bounces-103757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B9290957C
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 04:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECEF1F218CE
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 02:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB671FB4;
	Sat, 15 Jun 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrIYl1MZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FAB173;
	Sat, 15 Jun 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718416830; cv=none; b=Xg4vJdEC0hJW7ttebCogHlL3lBUCpcBWmGX22cKNDIfj6tB2r0b85dqFvW2aNDLLKac4b92/MxIVtQDUsCteklJWiqq5Rh+mcq2h9KNtKWZjhokOvftXs6K2IefCbKORW8tTlZY5TXs04i6y0acPGuqkmU5Vkdi7UhbRcuF3cCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718416830; c=relaxed/simple;
	bh=3odm+rS1904QGtNDMzGCAI1IeUZHCG2NP436V+dZs3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eE1J7zRPNhCL/cxl0bq9bJZIjI+GMdFRLJAI2+5DNJhzb5PgV9gcvFSN2XbE82wGMwm/HGYxr+y8Qd9iTsI/pw+71+GAWUZ98UEs5oQqFU4SXOtHg5PhKImvGfWv0jPNdpWbThPMFRcpwDxsZjYlTTbFE7B5GIOj+EgKPlRizCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrIYl1MZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00138C32786;
	Sat, 15 Jun 2024 02:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718416830;
	bh=3odm+rS1904QGtNDMzGCAI1IeUZHCG2NP436V+dZs3c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XrIYl1MZKDB5/W367HemCh8jMh3WFQYyNZMBFwW8Ig3OqrRIZpnJ3UPyeaJkCLOA8
	 W4hqGB7ZPypR0ju4HC8I10rgQ5eHKpDpiqXrMylRjhh/sQ2OSLVbCBUPlINFkT+I1o
	 szYv/Gm9fRiCayqgkH/4l0JnUN7nreBmmgnGFwe4RjEFge28JbSnr/84rjikeTy3gQ
	 umzumkRQK8EQMXyruIsFY4mHH59u+Z+0/NTQBZd3m4VSarhA4WhDlAk9gASH8RpqM7
	 OAstU5n+OTcWuyelGUdvBIIkC83qMEdTcO+faXGsJPa7ezt71xMSjjj5WnUsTeqKBQ
	 KOiaAxP5ZT0Fg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDF4AC43612;
	Sat, 15 Jun 2024 02:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH next-next] net: phy: realtek: add support for rtl8224 2.5Gbps
 PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171841682983.7457.6487866515980243691.git-patchwork-notify@kernel.org>
Date: Sat, 15 Jun 2024 02:00:29 +0000
References: <20240611053415.2111723-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240611053415.2111723-1-chris.packham@alliedtelesis.co.nz>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Jun 2024 17:34:14 +1200 you wrote:
> The Realtek RTL8224 PHY is a 2.5Gbps capable PHY. It only uses the
> clause 45 MDIO interface and can leverage the support that has already
> been added for the other 822x PHYs.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> [...]

Here is the summary with links:
  - [next-next] net: phy: realtek: add support for rtl8224 2.5Gbps PHY
    https://git.kernel.org/netdev/net-next/c/9e42a2ea7f67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



