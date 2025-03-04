Return-Path: <netdev+bounces-171483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F2AA4D171
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 03:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0661D188EB44
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 02:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0224157E88;
	Tue,  4 Mar 2025 02:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhwtgDV1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E66156C40;
	Tue,  4 Mar 2025 02:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054203; cv=none; b=rEYuELs5rL3DhuBhA1uS1oX50P/edtu77Li03cnOWo56jRSUcbn1RU34+ZryYU1NdwqH6IHwCgLWSO40Hscc2not2GTyUhBZMyOZ49AUhRxb7hndT+pT+X7pISCO77gKqBTfJgBirTfeKzZydDDseT+e2+8TgSXtAAZSep9p9P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054203; c=relaxed/simple;
	bh=OwLX+7cEjJHDjLyFk0BVXuVXiP4vf4mvrSpkC3eLXD0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BTTSSiC2iVm2mbusDPdJHqiVFjwtg4t77Rh/0dqbt6V+/qPgckQIYIxiYrTyL3JrzVTWJ1V8jbsOBIlpFyP1dYWyhvIEVBOzw4MYM0SYu32tlPh+xHMcWYBpBK6fHXfyzXtHnEAyiZTjNJlkq3Nr3ZvyL2nX07aLumc4JUa9GmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhwtgDV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3074FC4CEEA;
	Tue,  4 Mar 2025 02:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741054203;
	bh=OwLX+7cEjJHDjLyFk0BVXuVXiP4vf4mvrSpkC3eLXD0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PhwtgDV1vMVqs2mFB86qjtlTiQPoxyFf3Vi31fPVnko+WSEhBc1Ihmmp6UP3e8pN7
	 T6Gc2/aepdCqTCgfvyp5k4TdtygY6nECxK4ztcV/NBkQ8mqNVhaXpJ3BPkAyIivM0h
	 D/8RK6xZoEBmxAnDxTe7ZS0nNi21BJ/gb7MaeDLLATDwlcJzl2vPVO8Ev9OJSv9ijN
	 hLoST8574LwkIohCDdOXoZL9mm4fkPu3OTn47WqmcPCIfwyKmPMZqGwQLe6iYPc2Ry
	 wagSk8BHVyTUrYmD6ooEkgwzMrHYamqfLEvnWk9Odiur1pOnp47tyqplfB468kUD1c
	 KARECl5Bm2N3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E56380AA7F;
	Tue,  4 Mar 2025 02:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: sfp: add quirk for FS SFP-10GM-T copper SFP+
 module
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174105423575.3834266.13147803894017307670.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 02:10:35 +0000
References: <20250227071058.1520027-1-ms@dev.tdt.de>
In-Reply-To: <20250227071058.1520027-1-ms@dev.tdt.de>
To: Martin Schiller <ms@dev.tdt.de>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Feb 2025 08:10:58 +0100 you wrote:
> Add quirk for a copper SFP that identifies itself as "FS" "SFP-10GM-T".
> It uses RollBall protocol to talk to the PHY and needs 4 sec wait before
> probing the PHY.
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: sfp: add quirk for FS SFP-10GM-T copper SFP+ module
    https://git.kernel.org/netdev/net-next/c/05ec5c085eb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



