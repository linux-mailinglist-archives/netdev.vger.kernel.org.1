Return-Path: <netdev+bounces-193805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3822AC5EDB
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 03:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD12174ABD
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 01:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F273194098;
	Wed, 28 May 2025 01:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeVJG1ZS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AFE74BE1;
	Wed, 28 May 2025 01:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748396394; cv=none; b=LM2L1spYIJXMEaC4m5hYMEjCqmxFxBmZGcPkaWonmA9V+JBIE0kU/FF6qGKUggkbBXitSVAP7/ZxBCnqqoWhrqSjEduzrHtWCON9GHzkQT7Dgx5ppNYXr/ZLQHbNLS2r2sTrutB50c7mi+lph7yB6pLw40oEhGJRvE7LZfJviPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748396394; c=relaxed/simple;
	bh=LojGjkQqGbTJ0CBPEPoT3VM9OKVeG/iLdVnCgfZ7Nsc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gry4UfwWo6YS80SfZjN/Ho6QC/xO6leNoexrGMBhIHAaIrFiraJY4pOQRV1awCVMg0l8y+h/1SC/5uPIKOcecqhVrCC0h6Ql+A17T7h3W2xTLeTpWNBQ63Dp4qMCxfzqwo7QLW4qzoZsQLEgsW/Cw1jKKGy0yer3FS2uEwpRPtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeVJG1ZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A31C4CEE9;
	Wed, 28 May 2025 01:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748396393;
	bh=LojGjkQqGbTJ0CBPEPoT3VM9OKVeG/iLdVnCgfZ7Nsc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jeVJG1ZS5bFlNz6LdcJ59n/elKvoY4GMtkSXd/XRCwK22MgwrdSSF5SHMlBiTtUUO
	 hyV2tYCV4ikRFs08yQFezZntSN8p8PaBkaqN1+dFM4rF9+awJOO+DPBe9r03NpCfhx
	 v9UogcLHLZ6L04OGnEOHFRnw30Z3eQqWS5xkoCnKS7Y3Ub1JbN7Ni4yUcghIJiZwJB
	 PsRp6aY2LcXSnJdv4MJTVAgBVg4kmJ4G17kW4fbo5gzDJXMByUkBAHp9c8i0pFZrqH
	 0PvcWvS4PXVMV1wt/5GMbavqFTfG/0Vx+Le4Wsdxm1RsE7+E1M7t8z1pq3DplcCP+1
	 Wh8I98WsXy/Zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE0F3822D1A;
	Wed, 28 May 2025 01:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] net: lan743x: Modify the EEPROM and OTP size for
 PCI1xxxx devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174839642775.1854922.5423339868812530293.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 01:40:27 +0000
References: <20250523173326.18509-1-rengarajan.s@microchip.com>
In-Reply-To: <20250523173326.18509-1-rengarajan.s@microchip.com>
To: Rengarajan S <rengarajan.s@microchip.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 May 2025 23:03:26 +0530 you wrote:
> Maximum OTP and EEPROM size for hearthstone PCI1xxxx devices are 8 Kb
> and 64 Kb respectively. Adjust max size definitions and return correct
> EEPROM length based on device. Also prevent out-of-bound read/write.
> 
> Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
> ---
>  .../net/ethernet/microchip/lan743x_ethtool.c   | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [v1,net-next] net: lan743x: Modify the EEPROM and OTP size for PCI1xxxx devices
    https://git.kernel.org/netdev/net-next/c/3b9935586a9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



