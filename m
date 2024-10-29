Return-Path: <netdev+bounces-140066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92769B5251
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5121C2293E
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871412076B0;
	Tue, 29 Oct 2024 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fivzsKqX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AAD2076A4
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228435; cv=none; b=SxOd1jgsHBMvBunBLH6nPjluulqZI2cXO4v2lHFCfjDHnW+Z3MwzAGqbIcP48u/ZDMMKoDcaBLkYInADlLN3rXhDaVZxvt9PXhr4qdWGU5z+Eq+6LpXEltzDTt3b9xhZOyIX2xW5pMqUo9kHp1Ot2tUbLTFVaEwAmELiAK3CnVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228435; c=relaxed/simple;
	bh=kuoOgaLHaWn0Omxsk0+kDDWhcW+8ldz1NrqPXXwVAZ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bBH5OcVrpR0Bbl3YyKUIDfydllOqVED0ykUhCu7Cp+Y6ueSotxNXnvE7+bhOPb1ftoKUQ2eKd/SZCwOeLSzjXet6iVwywdcOep0xgStD29eBJj9AU+PYCPcOU78ShM/ABSzOu56dJa6KLO2e2MDejbJCUrY16smLdyiav8yb1Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fivzsKqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A8BC4CEE8;
	Tue, 29 Oct 2024 19:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730228435;
	bh=kuoOgaLHaWn0Omxsk0+kDDWhcW+8ldz1NrqPXXwVAZ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fivzsKqXr7Sa+d6I/gTq9fcaBVtO6Sq6tmLbLLoow4zCsMdy4VfTmqkDmq9Q5Qcak
	 LwhvQBoGq/GSvWHfdf8mO4QNTtkuB0qwvm6FbutUUvgPIOPe3ehOAK+K497OvQ3ucO
	 xH60YwmBOZZ92OKFhUFdmgfkLnO+s/3S+0xE3ysZBZNEd2SFdhO/VlUMvBPTkkS6pq
	 vNtgc1ZGdKIgg9PGEJwLMIB9uQL+CBttIukJxsnrwfpT7SdiLO+pUyvbx95e+oxI0O
	 WM3bhX/N5ACKiHmFbo5jxne1LdUJroiK67aGylTBaPGhNMRBE+r0ca6B/FJ8Sj51Oh
	 Pz6xicYSqrG/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE31380AC08;
	Tue, 29 Oct 2024 19:00:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phylink: simplify phylink_parse_fixedlink()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173022844224.790671.18072155776540519535.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 19:00:42 +0000
References: <E1t3Fh5-000aQi-Nk@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1t3Fh5-000aQi-Nk@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Oct 2024 15:17:07 +0100 you wrote:
> phylink_parse_fixedlink() wants to preserve the pause, asym_pause and
> autoneg bits in pl->supported. Rather than reading the bits into
> separate bools, zeroing pl->supported, and then setting them if they
> were previously set, use a mask and linkmode_and() to achieve the same
> result.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phylink: simplify phylink_parse_fixedlink()
    https://git.kernel.org/netdev/net-next/c/e0e918494c3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



