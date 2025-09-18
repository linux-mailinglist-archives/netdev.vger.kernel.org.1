Return-Path: <netdev+bounces-224226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF3FB827EC
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 03:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE237A9C5E
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 01:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAFF2264AD;
	Thu, 18 Sep 2025 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTanifd8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A8E2264D5
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758159011; cv=none; b=OR9QXHfxy27ncvTEFlNf5RA2ZgwTDyjcTeWcT2TkJwmrfHjSnPkbIEYv9HcIGDGf7jxIjD5iEtLdXuEtz21EhebCkNxfSILv0iGosaX9XhUONYlvwD6Ehn5iVB5SIflD3hGFKxGHo8ciuKPnEhyQsIILdQtcopNMeVmc2rSClaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758159011; c=relaxed/simple;
	bh=OuT4LW924L6O3nHVMVMZpTuxwz+uaW0JcFWhVgxOoog=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eGFDYYQ0wjbDIWeZHjCY6O6vGuN6w4LQ38YCaDnXy7QJPbeJbX78FX0cAi3jq6cAboj42o/9YUx/sgHCsdR/y2Djnr7x2CbLD/ke28xjmmNFgy0WY27q1RxjhkHzBBtNi4aou8wFiBaD8FtlE/PscRvf0rzAQk1TTSrk+vzdPeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTanifd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6A9C4CEE7;
	Thu, 18 Sep 2025 01:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758159011;
	bh=OuT4LW924L6O3nHVMVMZpTuxwz+uaW0JcFWhVgxOoog=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UTanifd8NxfH2ZmbUXD6slNsA0efwpEKFXYPA77uaO132nDNa6sHydPYWTXGGJ6wq
	 A5+3E7AqP0oupqikvOri1Q1NqPYAlugRhCtbOZ7YD4QoOfJAieX/dFOxRdN1f/Uqr1
	 f2qEdQUw4so74rE+3qx8/BqIh945YLJa/nyj6NwDNrBxvMAP7w4fC4S2RXOPmDheen
	 gkZROtPDDDZsy5uhm1Q/d6cADUGa9jV4R2m/znu3GI1Z4CTiLDyjs4s6FKRimWtIzu
	 3sb6Y/yQDkAkNEI1/i6S4zLULP6FRmFcaVVXfs+7U4IPs+Cd8KtVz0i2PSBzscyJwK
	 0TyeLSOlbkPvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE4E39D0C28;
	Thu, 18 Sep 2025 01:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] net: dsa: mv88e6xxx: further PTP-related
 cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175815901175.2214107.13072874715906575656.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 01:30:11 +0000
References: <aMnJ1uRPvw82_aCT@shell.armlinux.org.uk>
In-Reply-To: <aMnJ1uRPvw82_aCT@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 olteanv@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Sep 2025 21:34:30 +0100 you wrote:
> Hi,
> 
> Further mv88e6xxx PTP-related cleanups, mostly centred around the
> register definitions, but also moving one function prototype to a
> more logical header.
> 
> These do not conflict with "net: dsa: mv88e6xxx: clean up PTP clock
> during setup failure" sent earlier today.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] net: dsa: mv88e6xxx: rename TAI definitions according to core
    https://git.kernel.org/netdev/net-next/c/a12372ac5946
  - [net-next,v2,2/5] net: dsa: mv88e6xxx: remove unused TAI definitions
    https://git.kernel.org/netdev/net-next/c/946fc083fcb5
  - [net-next,v2,3/5] net: dsa: mv88e6xxx: remove duplicated register definition
    https://git.kernel.org/netdev/net-next/c/30cf6a875e29
  - [net-next,v2,4/5] net: dsa: mv88e6xxx: remove unused 88E6165 register definitions
    https://git.kernel.org/netdev/net-next/c/a295b33b0faf
  - [net-next,v2,5/5] net: dsa: mv88e6xxx: move mv88e6xxx_hwtstamp_work() prototype
    https://git.kernel.org/netdev/net-next/c/e866e5118bb6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



