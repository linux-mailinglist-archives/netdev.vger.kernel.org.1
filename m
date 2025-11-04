Return-Path: <netdev+bounces-235333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BFDC2EB51
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 02:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89F6234C746
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 01:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD742222C4;
	Tue,  4 Nov 2025 01:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKjeQEXL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D99221FA0;
	Tue,  4 Nov 2025 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762218649; cv=none; b=SoV7BvwaKktS1USoQMt8zpOwgA0tfOle4HyES9pVm+S0w/TbtYaUW+wKXtmox+hy/SqNtpAol9luCqLco6r1cCuxk/TQQQ3ScoQhLRWlDmMw2qsRe5+ByzDIvwyLXP/qzcgzZjahWFfrJRH7KS6hp82vWf7IlPq55jQRG7xXguw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762218649; c=relaxed/simple;
	bh=CpDTFQRqklx8Z6Ylk9ALuFyuD705QvUittxiGqgudp8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IHqX7m9FKcQkbNYjoeyu8KiNXwtYYNxABQ/Hu2vfBB9KmBSXwv41FkmsDmxO0ltIJy517OSYmnWRS/LOgyyeUEHV4+W7TxEIZ8LbEPwYnbu7VyAhBuRYOm3wXNLeiBP/rcRFcwZj6PYr4jpL2Tx7aWtLdhW/ec/UKEZlNX9nU28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKjeQEXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB80C4CEE7;
	Tue,  4 Nov 2025 01:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762218648;
	bh=CpDTFQRqklx8Z6Ylk9ALuFyuD705QvUittxiGqgudp8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dKjeQEXLzm7dmp3ejef2C9HtrDMk5KYgPU5Yy9Pc6OazAZpXwE7ORQURrOGgwRZor
	 0Y2D5ByrX3o8NsowNq2xBrWQu+31t3noo1xWEBAlZQ1ZOmaMCUAv1z3LkxNLho/ZBu
	 SALhxGZ9+2qEMB7QtUsipWcxYwE8KsMTyXMF4ct+b/84eK6CaJwe8gfVBFPSBf7vLM
	 G4ZhlrWOHieriW99fa2PtIcu0B1h7m7+OyEADmeMAPh92aI2k5O07u6XIUTNcwYuwK
	 Gl3WsoTdJrxb8QQQeeHrRLnReT1+K+FS/jtpDBsg/k5ACx34eimjIJwQdDPxjy9n9a
	 0wjGafDJCqI8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 344BE3809A8A;
	Tue,  4 Nov 2025 01:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] net: phy: micrel: lan8842 erratas
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176221862298.2276313.3624607988691456338.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 01:10:22 +0000
References: <20251031121629.814935-1-horatiu.vultur@microchip.com>
In-Reply-To: <20251031121629.814935-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Oct 2025 13:16:27 +0100 you wrote:
> Add two erratas to the lan8842. The errata document can be found here [1]
> The two erratas are:
> - module 2 ("Analog front-end not optimized for PHY-side shorted center taps").
> - module 7 ("1000BASE-T PMA EEE TX wake timer is non-compliant")
> 
> v3->v4:
> - introduce struct to contains all the register accesses
> - fix commit message for second commit
> v2->v3
> - fix some register addresses
> - add reviewed-by tag
> v1->v2:
> - split the patch in 2 patches, one patch for each errata
> - rebase on net instead of net-next
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] net: phy: micrel: lan8842 errata
    https://git.kernel.org/netdev/net/c/c8732e933925
  - [net,v4,2/2] net: phy: micrel: lan8842 errata
    https://git.kernel.org/netdev/net/c/65bd9a262644

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



