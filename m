Return-Path: <netdev+bounces-241751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B774C87EFD
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DA364EAA1F
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96F730E0C3;
	Wed, 26 Nov 2025 03:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpVEvcx7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8B30DED1
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 03:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127264; cv=none; b=YNzWDiPmW31frTB4pY3RC8S7A62i56TU0j6ZQ70ObgqeBV2+SdexEsBAd6y23H0Jp9BB27i8tOIrLVL34gFCz07rKbXUHk5I2qUEoxwQ2ZtUHGV6SQYAB+Htj60q/g5bRdtNDaivci8jy65g2S/oKifTKuHHsQNbGZbt3cX7UiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127264; c=relaxed/simple;
	bh=izmvYNURJGETIFue/8EODRVmUCcwI2CU2at93/ulSFk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QjT44+IzzJQXmdywWquRyy3K88l/hlz+3Xg5tEm6gOXQfTlqOzVCCEPIl17/hiHkN9S3WKge7PBoJ2aqIvrg94zVAefbt7cvN/ycBhmxn0bhj74toXbEGSNj5GlGgxvv83HhKEudxWH5/dpoYPN0+RbasIznlE5tlCxzIXjH8gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpVEvcx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0451FC16AAE;
	Wed, 26 Nov 2025 03:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764127264;
	bh=izmvYNURJGETIFue/8EODRVmUCcwI2CU2at93/ulSFk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NpVEvcx7j5MhKlKLJm22/Txk5E0w/EER9JBuFFMH+rJG1FyhoPEg53FgTJYsiRwZl
	 WHNAI5TdSzDUbLJ+yNAQNJgF/1PtYri1BWuYY4EL4aKAHBWPNhnK5Bm+r6E7SOQqrz
	 GhBCANw96fbF8WriOujUDZfm6jl8FH20Zh0YOblnOGabCmwo9d1MernP4KTN8/aKXd
	 ehWPVeIk1sYxBn4fzIH0SnEhBOPTeGZLWo9SsVPX4kQR1DEgiopVKBWGizMDAcWVHR
	 gv0awhpcKvyK9wtNif3X7hknVVVZZvzJHi5KkRys0wiQx055NzBiD3gO+yeAsRbdKu
	 CPB2Xdbh12ntg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AD4380AAE9;
	Wed, 26 Nov 2025 03:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: improve MAC EEE handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176412722601.1502845.15182983259827422270.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 03:20:26 +0000
References: <91bcb837-3fab-4b4e-b495-038df0932e44@gmail.com>
In-Reply-To: <91bcb837-3fab-4b4e-b495-038df0932e44@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew+netdev@lunn.ch, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, nic_swsd@realtek.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Nov 2025 08:37:53 +0100 you wrote:
> Let phydev->enable_tx_lpi control whether MAC enables TX LPI, instead of
> enabling it unconditionally. This way TX LPI is disabled if e.g. link
> partner doesn't support EEE. This helps to avoid potential issues like
> link flaps.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: improve MAC EEE handling
    https://git.kernel.org/netdev/net-next/c/87ad869feaed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



