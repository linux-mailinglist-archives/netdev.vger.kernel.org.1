Return-Path: <netdev+bounces-211636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 604ECB1ABBA
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 02:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006123BE042
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 00:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DC61922C4;
	Tue,  5 Aug 2025 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB7AQBZt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B1718B464;
	Tue,  5 Aug 2025 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754353805; cv=none; b=AVHac715SL4R+BdKrA0Be3udzxhnaQ86P1ohRP93BQYiv/oB0Lu6jE1ev2pf6BWipe1Jq/Dpkm09KDP5JrouoE/eFRFbUnGvrcZj8SXEK/RtLRYkdhGGrJfYK02aUY7psg3a00WpWosE9S3zeGxV76pzVMTFS7xLeEXHNccXo3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754353805; c=relaxed/simple;
	bh=ZZmsioiAVCLf5lQBbdXNC1wttb6c0dEotQM5pn5yPGU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PnH8t1ork8sFOTwTCZ88yQ3qa9w+3KxmV1g5gq5+PTLLYHlJioXSxURW1naV3Tfz0rUnG4rtrD4sO0+gEtrGL7pqa4sKaq9G79dZRiePb5TNb6HjgYzaI7Qpm2EV5FQBbdnbDWMDKcuZBfGmwiIT3AzlOaqIZY/xquKZlkFT+pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB7AQBZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DF5C4CEF0;
	Tue,  5 Aug 2025 00:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754353805;
	bh=ZZmsioiAVCLf5lQBbdXNC1wttb6c0dEotQM5pn5yPGU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NB7AQBZteACnc55bMP+fFC4eJVfCrzYH7DetsottTkNRquhHvaqClkAx0Ud6peSRQ
	 npshHDe1XtUDVXDogdrrRG2MbYMTGPR4LoNFBDFCASZeZinxxeM0vb69khkP6wNyae
	 ZMtTVxp8YDq3a4OMSjamrLXZsxx7CHsUc5rn5UaSU9U89wYMbzZfgfbVi/hNkEwyBI
	 aaDYEqOGjJPnazQdhF/vP+TdjfKTetGsgBfuJbObHTD53NtpjMDKMe3tEyk87yvGfx
	 y3cnjI7dk/CIrUTzGvfSxo4itNA0K9ukxHB/iUYV1sMNWxQ+GnQkspEoL6CmtnxTfP
	 r6S6vkW8nCLJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D32383BF63;
	Tue,  5 Aug 2025 00:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dpll: zl3073x: ZL3073X_I2C and ZL3073X_SPI should depend
 on
 NET
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175435381825.1400451.8676043781177752154.git-patchwork-notify@kernel.org>
Date: Tue, 05 Aug 2025 00:30:18 +0000
References: <20250802155302.3673457-1-geert+renesas@glider.be>
In-Reply-To: <20250802155302.3673457-1-geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: ivecera@redhat.com, Prathosh.Satish@microchip.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  2 Aug 2025 17:53:02 +0200 you wrote:
> When making ZL3073X invisible, it was overlooked that ZL3073X depends on
> NET, while ZL3073X_I2C and ZL3073X_SPI do not, causing:
> 
>     WARNING: unmet direct dependencies detected for ZL3073X when selected by ZL3073X_I2C
>     WARNING: unmet direct dependencies detected for ZL3073X when selected by ZL3073X_SPI
>     WARNING: unmet direct dependencies detected for ZL3073X
> 	Depends on [n]: NET [=n]
> 	Selected by [y]:
> 	- ZL3073X_I2C [=y] && I2C [=y]
> 	Selected by [y]:
> 	- ZL3073X_SPI [=y] && SPI [=y]
> 
> [...]

Here is the summary with links:
  - dpll: zl3073x: ZL3073X_I2C and ZL3073X_SPI should depend on NET
    https://git.kernel.org/netdev/net/c/4eabe4cc0958

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



