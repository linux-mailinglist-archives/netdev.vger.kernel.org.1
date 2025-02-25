Return-Path: <netdev+bounces-169294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB330A4339E
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 04:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A7C176161
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 03:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A87624BC06;
	Tue, 25 Feb 2025 03:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8eaW7ZD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC85824BBF0
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 03:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740454198; cv=none; b=X0fpLB7hcMXE/zmNGrMQL51ynvIruC4Dt3YV3yFxo73Dmb9/dBuA6T4ORc7KIeEK79gE66+ZXZx0u5C+VKI8HE6HTcLmZWyuKms2AFa9kt52a47TZ9Bbjv9gDSDo/X6QYJYA2e35bp0bbRssBsaN767jSMjgawgU3bGYY0fPvbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740454198; c=relaxed/simple;
	bh=W9oh9UYB3pG83qMbWInW6A4jZti4xFyUjmTMAP/wUsQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jIZCspdiJlhSnYIn5RHETD9zCna9krjP09owz5ioWHXxMOSQbUAb37nPI3YW60LpuqmjXukE/FiPmtxfQvCbNPUhnaaPZQ/BI4dl58NGVEwnufeQ2QrYW9VHi/q3k4necaG0+YnvrfLIbnyIWv+F3o8uGu3HAMbHQxeP086N1pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8eaW7ZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E8EC4CEE2;
	Tue, 25 Feb 2025 03:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740454197;
	bh=W9oh9UYB3pG83qMbWInW6A4jZti4xFyUjmTMAP/wUsQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P8eaW7ZDliCtY1Uf0gZbV1kmvchHhr3f1iVFVYcFP12yafUVLncfkWDptwZScgnJJ
	 efHYIh3e8Ba8mwGKuOGlCPLoelB4xSFnQDEGukddp7hUXcPO8ueLnPBUNnc4W30HK4
	 3KAq/uDjX9tapL3YlqC00fKqfn5PvEFbvQSW/Wp2N1+AjvL5I/pq8097JIlGs4c2Ag
	 ul+19UIchZ49RrbEUfD6N9T5zidngms6waAdlu1EBQDkIzf7Z7mNmPnFv51IiInv+V
	 GdZmBx0UpF/ga0b659X/tEpFCuUFBpF7yX8uULMAui6QpTiHVChlKls7gRW9VkLGgi
	 MnqazEnQQYgcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7122C380CFD8;
	Tue, 25 Feb 2025 03:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: phy: add phylib-internal.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174045422927.3693125.11050185335432001962.git-patchwork-notify@kernel.org>
Date: Tue, 25 Feb 2025 03:30:29 +0000
References: <082eacd2-a888-4716-8797-b3491ce02820@gmail.com>
In-Reply-To: <082eacd2-a888-4716-8797-b3491ce02820@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 22 Feb 2025 09:36:10 +0100 you wrote:
> This patch is a starting point for moving phylib-internal
> declarations to a private header file.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - fix spdx comment style
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: phy: add phylib-internal.h
    https://git.kernel.org/netdev/net-next/c/a3e51d471179

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



