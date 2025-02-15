Return-Path: <netdev+bounces-166634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0C9A36AC4
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 02:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625403B108E
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 01:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B4829CE7;
	Sat, 15 Feb 2025 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4AlnUY7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9503210F2
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739582404; cv=none; b=E5DnZ7uEeGyrt/V0W4fN1N903VE6xWqenV+F4WqZ3nfLhdO6CNya/xLCEz6K6N/G23ZlgwR1FxTc0BE0Y1EIfi5rhYJmG4vWXs1ipElCKc9z64/Uam+xzHnApg7xprbDAzGRzzUjxjq1SPub6TSc6YjYcqJ57vjs7Sqm1M1HPjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739582404; c=relaxed/simple;
	bh=R7qQkOGLCPvgnlI+8XqFjyk9Ecs+QAFoHBZiujkHuHQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nfw2F4Tl2qARUUTWgJXTNHQ8S0vHxmFlJL3kmqQfBDI/gvuLwwKsERy3ou7EXCS28rcgsOW/FlaS/tcl6qIPcy3E096l+tkLzlbrsx02Ijv8tBcmE0/dQ2fJ+CgW3D1Al2rZwrNvI6b606mP2mpPEWraucKOpkUBD2fomiSofCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4AlnUY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5D4C4CED1;
	Sat, 15 Feb 2025 01:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739582404;
	bh=R7qQkOGLCPvgnlI+8XqFjyk9Ecs+QAFoHBZiujkHuHQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i4AlnUY75wNXpiccKdc7RdfBlFR0+lN0okVUzrhnfguCMP9PVJ7+Piaq6/9BCoJFa
	 8rN+GicfUFL48SQKsj7g3BrSWvHKY0t9/I355uHGIJqQbkE5tE7vxEqwbwDy4zuf4/
	 YpdBPJeiL3ojVW2o5RiIrSc17xDCcJjVDdJrzK+LMg86rg1bx2AmFj3BGj0gYRbBaV
	 5DSCXtCYUrAEW7/zoTLo60WZ1Q5dYMPojs1Dz14BFd/BtuepJqPQI+6Bg+mCVeGhCG
	 Q9/RZXIz1/1aErnnymHwutcn2ShSjOjGxsyIPVeZj9BIs7SxVQ28IR3cPbV8F1wUl+
	 iCbBzqp2ylnwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE91380CEE8;
	Sat, 15 Feb 2025 01:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/3] net: phy: realtek: improve MMD register
 access for internal PHY's
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173958243352.2159741.4378517292820789211.git-patchwork-notify@kernel.org>
Date: Sat, 15 Feb 2025 01:20:33 +0000
References: <c6a969ef-fd7f-48d6-8c48-4bc548831a8d@gmail.com>
In-Reply-To: <c6a969ef-fd7f-48d6-8c48-4bc548831a8d@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 andrew@lunn.ch, linux@armlinux.org.uk, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Feb 2025 20:14:09 +0100 you wrote:
> The integrated PHYs on chip versions from RTL8168g allow to address
> MDIO_MMD_VEND2 registers. All c22 standard registers are mapped to
> MDIO_MMD_VEND2 registers. So far the paging mechanism is used to
> address PHY registers. Add support for c45 ops to address MDIO_MMD_VEND2
> registers directly, w/o the paging.
> 
> v2:
> - remove superfluous space in patch 1
> - make check in r8169_mdio_write_reg_c45 more strict
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/3] r8169: add PHY c45 ops for MDIO_MMD_VENDOR2 registers
    https://git.kernel.org/netdev/net-next/c/853e80369cfc
  - [v2,net-next,2/3] net: phy: realtek: improve mmd register access for internal PHY's
    https://git.kernel.org/netdev/net-next/c/da681ed73fb9
  - [v2,net-next,3/3] net: phy: realtek: switch from paged to MMD ops in rtl822x functions
    https://git.kernel.org/netdev/net-next/c/02d3b306ac2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



