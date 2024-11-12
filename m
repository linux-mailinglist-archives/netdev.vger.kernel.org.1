Return-Path: <netdev+bounces-143905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC629C4B77
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 02:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6800FB2A31E
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 01:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A41D204F71;
	Tue, 12 Nov 2024 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pf6cRdZm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E582D204F69;
	Tue, 12 Nov 2024 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373226; cv=none; b=fKHYBtNr47vf7jfozdruyr4ONvnqSm7FVjslxK4UH+U1dOli/tzzQMMvViZBJWdF3ouy0PM27JoCnDN4LeI6DNUkkLj6GEVvOAZ4GpxzaxPZz5ajiIYBrPOERlPf0fX/URnCuJSKspp6FCVSTF+KElEP4giFl9ezlBSCpLpXTW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373226; c=relaxed/simple;
	bh=XDi78O8LiEB1ZSRs5hsMzJJBiHT6fO/M3EM+IrAkdKM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cGX2BqCn8vccfvHIGZo1Mya5BMoFUxfcQTKk7l0DUknltjJAq1skzmDjyF+l6557EM8tLO7z11fzdi3nP2MUDuzfMw6Ns7LsMhc4yJbfvA1ZLZ0gv9lZpBPkip8DqzEfaPC8DT5Wxa6IsQgJo0W8aE5uXZ9Krkj8aOD4Xmlr0dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pf6cRdZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6362DC4CED5;
	Tue, 12 Nov 2024 01:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731373225;
	bh=XDi78O8LiEB1ZSRs5hsMzJJBiHT6fO/M3EM+IrAkdKM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pf6cRdZmhk9zhPBxud3yJwYkNUQD5R7YP0y4CyHGnfmcy7jsQPs/x9Biz8QUR4edj
	 +vgdYqYn34aBeH/TSUQtgJpsGAaZRlC1BPZSJKu/E+hUt7n1bL6gQCPGsFuSdyAM1W
	 sQpJ925a5xD7WqRlGvwx3SyUAZ9t4gzueOBK5+E+JbhlS1A9Z9RSwvPOAmq1z47RSn
	 6TtJdKgqdBzX9Xu83EAdcz+f3gLdBGUEWeBenjWS6LIailVivLn6n/zYUjHUmL4Otp
	 0388Lxt5tKhoYkjwk0hBZp0NuBQDb8SBONkbSCatVub36YgP7TYVTvg4uaG+SgrqvQ
	 NryKJGaXBXZAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE983809A80;
	Tue, 12 Nov 2024 01:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: aquantia: Add mdix config and reporting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173137323550.33228.294651309025242322.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 01:00:35 +0000
References: <20241106222057.3965379-1-paul.davey@alliedtelesis.co.nz>
In-Reply-To: <20241106222057.3965379-1-paul.davey@alliedtelesis.co.nz>
To: Paul Davey <paul.davey@alliedtelesis.co.nz>
Cc: andrew@lunn.ch, daniel@makrotopia.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Nov 2024 11:20:57 +1300 you wrote:
> Add support for configuring MDI-X state of PHY.
> Add reporting of resolved MDI-X state in status information.
> 
> Tested on AQR113C.
> 
> Signed-off-by: Paul Davey <paul.davey@alliedtelesis.co.nz>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: aquantia: Add mdix config and reporting
    https://git.kernel.org/netdev/net-next/c/bc3d60bd4c91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



