Return-Path: <netdev+bounces-244358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F23ECB565F
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 10:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34E2D3019194
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 09:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4922FD67F;
	Thu, 11 Dec 2025 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z00bsfJ/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD30F2FD66E;
	Thu, 11 Dec 2025 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765446205; cv=none; b=EWd0/5ymfQJP9t2dVNiL+Id9mTVeVTdmBbRS66BLxyQn8p+BwolGw1Zjx4tv9RwY+lskvVoidSmiG5nkAQyY+VWEpXMSbhGc5iYFN26oKhAiGiAYTqr0KFai12HtMzN8LQhAh1QqO6ERtM0Kx8hSos5D0vQ9mFSsDszWDjTgmWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765446205; c=relaxed/simple;
	bh=7umMjSgQbTfPmEUISZCRsrOrSoI1Ip5gO+NwMJLSGzg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S8BNFqjOy6U79gV8fsIKE+X7ob+y3Km5qLxEeasOROWZ6e4oDxc/1PEJy9aiNzwd89p7459CYFN/qr/imZo9YgLbYQVqu2aHu0NxZyHLFSsBMDwxfCnjViy/qIqntOJamR7c97xXx0oliPizNxRgVlmIgERZz4qp1wqfgeIa5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z00bsfJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C715C4CEF7;
	Thu, 11 Dec 2025 09:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765446205;
	bh=7umMjSgQbTfPmEUISZCRsrOrSoI1Ip5gO+NwMJLSGzg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z00bsfJ//Hy2hmbk25JEENJWAgCgCBvRw7KmjxirOpiolwB6q9mgTRThFac9npMPd
	 nuHTSEd8yVaz87jQBauYIisUPQoZOxKyw0103n9Z8WitvA7bHlGvYoW44w8BUSjJU3
	 gTj8H4aKyHShb1JsnYMy7rej9AprvIJHLgAWlEa7eGV2F3CGriI77aLjMKrOQqCC0c
	 MWQwAEzAjqQIpitHlmnjwL23scELNbqJM/Ef4YRHZGU6tRa2j6ygqb35ZdmKVERJZI
	 YBmQgeoqdsL+pKmBy+91A6pX6oRpizNNzAds/ZF0uehsP9SMK/aCjx3IcEP9RsSUgE
	 f7nOYX3fL0vxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 788453809A35;
	Thu, 11 Dec 2025 09:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sfp: extend Potron XGSPON quirk to cover additional
 EEPROM variant
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176544601902.1308621.10788873361579147045.git-patchwork-notify@kernel.org>
Date: Thu, 11 Dec 2025 09:40:19 +0000
References: <20251207210355.333451-1-marcus.hughes@betterinternet.ltd>
In-Reply-To: <20251207210355.333451-1-marcus.hughes@betterinternet.ltd>
To: Marcus Hughes <marcus.hughes@betterinternet.ltd>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  7 Dec 2025 21:03:55 +0000 you wrote:
> Some Potron SFP+ XGSPON ONU sticks are shipped with different EEPROM
> vendor ID and vendor name strings, but are otherwise functionally
> identical to the existing "Potron SFP+ XGSPON ONU Stick" handled by
> sfp_quirk_potron().
> 
> These modules, including units distributed under the "Better Internet"
> branding, use the same UART pin assignment and require the same
> TX_FAULT/LOS behaviour and boot delay. Re-use the existing Potron
> quirk for this EEPROM variant.
> 
> [...]

Here is the summary with links:
  - net: sfp: extend Potron XGSPON quirk to cover additional EEPROM variant
    https://git.kernel.org/netdev/net/c/71cfa7c893a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



