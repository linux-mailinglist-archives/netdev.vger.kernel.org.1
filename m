Return-Path: <netdev+bounces-193787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A079AAC5E98
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 03:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376773A58DC
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 00:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B91154BE2;
	Wed, 28 May 2025 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzPaQ71N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBFB10FD;
	Wed, 28 May 2025 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748393997; cv=none; b=eDOfqbn9Novy66B6qnqsiGzi6X4UKqFMJsiDLwzeBvdOz6XD8+P3hXaO4sgeeBg6KZI2YpaW3RV5Dm+uZMxM4LdRucL4vJ2tFokryfp5WKEchK8LxSvSs1bo3BaBvq6v0KkYQl7MmA/T3xnkYA69OGh2P4gzUOqIJdHd3Yfm3BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748393997; c=relaxed/simple;
	bh=XlID4LzREOELOZp/bI7Bjb9nl5T3UEA/2HALcUJr4AE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sz3Tpi2Nwv/Va9r21zf4l5llcszcHRlA8l6BGYycDQXy5EV2wP9b1UL9Nkt12ljMchohSz3Bx1o9KYByPlMlMgzpPvj9JXBz7406EYmkkTijZ0ZjcXVasE/l4/uqMvPYKHmKwHhyuaJnUDSRFmk2kT3dqXuqtp23bgMvRv0Z+gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzPaQ71N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1085C4CEE9;
	Wed, 28 May 2025 00:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748393996;
	bh=XlID4LzREOELOZp/bI7Bjb9nl5T3UEA/2HALcUJr4AE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VzPaQ71N7/fHj9hP2SGA2YZrFv9PNJ9QSEDshsebFpZnqny4BBBOW06q6ANNRurSl
	 J2a2ZT0ibYRXryd7hGFZrgg3BFBfkvaoYr18STZ1KdsgNcTsXIKezT9bVALb25LQUS
	 fuwZC2QqHXDHuZKno082yGlGk7hQiDwmzYRWYtvKiaNKx6Ti/nd1sV1sDF2xe8E+xu
	 XZ6yhcCSmMO/x3gBbopmTYKs7yQnsrWHeHhZ+dSIO4Iga7itIVaxX77TyA9tlaYKFy
	 jTrhtbqVOHOZYI2QdekfDqZCRwvBbMS9wQhJB0phwnwNeWJ6n/7dqwzduiWnOP3SI9
	 BtQct/Eb3Ic9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C52380AAE2;
	Wed, 28 May 2025 01:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] Refactor PHY reset handling and
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174839403100.1846337.7897415854786709434.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 01:00:31 +0000
References: <20250526053048.287095-1-thangaraj.s@microchip.com>
In-Reply-To: <20250526053048.287095-1-thangaraj.s@microchip.com>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 May 2025 11:00:46 +0530 you wrote:
> This patch series refines the PHY reset and initialization logic in the
> lan743x driver. It includes the following changes
> 
> Rename lan743x_reset_phy to lan743x_hw_reset_phy
> Clarifies the functions purpose as performing a hardware-level PHY
> reset, improving naming consistency and readability.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] net: lan743x: rename lan743x_reset_phy to lan743x_hw_reset_phy
    https://git.kernel.org/netdev/net/c/68927eb52d0a
  - [v2,net,2/2] net: lan743x: Fix PHY reset handling during initialization and WOL
    https://git.kernel.org/netdev/net/c/82d1096ca8b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



