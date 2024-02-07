Return-Path: <netdev+bounces-69826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6585484CC01
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47A729050B
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 13:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9C077F0E;
	Wed,  7 Feb 2024 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PocdG//P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A25117BDD
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313827; cv=none; b=uiHHg69uBzMr4XHtZN9mXRSLUJno0ejFwc6aR6uf8jZvpSTWWabvxMDg3YA3Djgixa6AUe8k9RhBhJbmWnnWoiU78t0Bketz5NqELyerYrdmahsarIYvFyuaD4iCNnS8ssMe8/0EMQPJFXxWao7f5tmJF3z2pXeDRUsrkIaZ26U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313827; c=relaxed/simple;
	bh=L5ECQGtzmTpOcq+2zuu0gYL7Pdswm2ST+wK4QRL76LY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=anCltrAne+lqskMG09qDTM/xlyRWzFdRJbK22c0dzPR/qhDFCZ3VmjiVsDtHBHUBB0W1+sfLDuTeWQVHvnBr4TM7UbhZm9gWAZJ1Yf4KHWfcFjYggirUV+onT/wBQ68Df1dhTIP+fYLNnOgYW7it/eYmO7Mskk9YLP+6gCxXMZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PocdG//P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89C48C43390;
	Wed,  7 Feb 2024 13:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707313826;
	bh=L5ECQGtzmTpOcq+2zuu0gYL7Pdswm2ST+wK4QRL76LY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PocdG//PDXRDYzu1+N4K0A8A79Qb2zPceFIpxE76sUG5iUch0XmLnADZeWxwQMUKp
	 QB7DMui9OGBQ7vkmryzDyAcjFqRjFmIPKe+CxtjDZbwrSKwsN126VxAIaY+tFwiMyq
	 TQNXRQI/oeNKNd3YKqS0rbolM2poMKwXc3NzFW2wn1rl7ygeo2PwGJgySMexFS7eSX
	 +dOshr6R7JgyOcemArqDLc3FI8bjbdHOwWKGBCOpgC/bnGYGB8iBFCpFmE5SWjWDtb
	 po1yN2cqGruHp5Q8Kd3BwvkQUgO+XVmIDKuOeLQuc/HEPSNg4yO+aysNd8Lbvt5E/X
	 a193tUALGAWAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C1ACD8C978;
	Wed,  7 Feb 2024 13:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] Unify C22 and C45 error handling during
 bus enumeration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170731382643.23380.7564110034003524760.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 13:50:26 +0000
References: <20240204-unify-c22-c45-scan-error-handling-v2-0-0273623f9c57@lunn.ch>
In-Reply-To: <20240204-unify-c22-c45-scan-error-handling-v2-0-0273623f9c57@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 f.fainelli@gmail.com, olteanv@gmail.com, netdev@vger.kernel.org,
 tmenninger@purestorage.com, florian.fainelli@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 04 Feb 2024 17:14:13 -0600 you wrote:
> When enumerating an MDIO bus, an MDIO bus driver can return -ENODEV to
> a C22 read transaction to indicate there is no device at that address
> on the bus. Enumeration will then continue with the next address on
> the bus.
> 
> Modify C45 enumeration so that it also accepts -ENODEV and moves to
> the next address on the bus, rather than consider -ENODEV as a fatal
> error.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: phy: c45 scanning: Don't consider -ENODEV fatal
    https://git.kernel.org/netdev/net-next/c/17b447539408
  - [net-next,v2,2/2] net: dsa: mv88e6xxx: Return -ENODEV when C45 not supported
    https://git.kernel.org/netdev/net-next/c/88b3934e3f31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



