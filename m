Return-Path: <netdev+bounces-223820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB960B7C9FF
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CA42A5360
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 00:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DDA1A76BB;
	Wed, 17 Sep 2025 00:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeY1d2Xx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8B2137932;
	Wed, 17 Sep 2025 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758068410; cv=none; b=GelVVXzJPDyUQ7+pqA9lyyzZSVRECi5HLUuwUizSJzZSuYSH2ZyoPexY4DnmIvKwmLivXTnOMSQr66wOBawKuRGldt7EZnb3X0qTCdKGYgskmYkLH/28X2w2e2tK7YnD5Qltzn/u4O198e+3xsIPlFkTumaRosSDtU956w8g4EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758068410; c=relaxed/simple;
	bh=OzleEIf7+dKdcTTZ5WCjK9PoRh4NVG7uCJFwUeh2KSE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=idbkKQEtDombJyJNymHdeUcZL6XEx+qUvX/og+dTBofg2Dumzo70JEkwWL7apqc33SRl95VhJl+cppw9otf89K0IINrxXQJnvnkT57ixS83P1rKSbRipMXhc4VSRPwFWc+Mcjutsadz+fHJWA+bHkjidhyZUAJVItkKJTypQFOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeY1d2Xx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2E9C4CEEB;
	Wed, 17 Sep 2025 00:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758068409;
	bh=OzleEIf7+dKdcTTZ5WCjK9PoRh4NVG7uCJFwUeh2KSE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AeY1d2XxgeLHZOPTLzxS8GrJVBqj0qzHlNZco5R9r/PxKeBvPn80F/hKSlWUon82b
	 uobQ9xCLmvZqMssOdz2SLsRHVyRGAPj8eZKLStXcJqoOIYYz7hmXle/t/RdYy5EBGU
	 MkGHO1H5bJA7EeVhwiL380pIPamT1cOlf5AxVyYPH8B5U81ykJE25mHzxP4Lje8ach
	 HJmabBBNJaC8nljlrwan2fsUoJ12MntmjbwFyMYhM2CT1Irp1qYrICcdjizaLHjreO
	 cGSsnPTDBjhdWooO7yU8L6rqQskYszkDxhNMjbzj7rwhrnql/hihYPxljSGQUaGxrJ
	 n/y9ll+aeF7AQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 98B4C39D0C1A;
	Wed, 17 Sep 2025 00:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/5] net: pse-pd: pd692x0: Add permanent
 configuration management support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175806841048.1411137.2912854101933686336.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 00:20:10 +0000
References: 
 <20250915-feature_poe_permanent_conf-v3-0-78871151088b@bootlin.com>
In-Reply-To: 
 <20250915-feature_poe_permanent_conf-v3-0-78871151088b@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: o.rempel@pengutronix.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 horms@kernel.org, corbet@lwn.net, donald.hunter@gmail.com,
 kernel@pengutronix.de, dentproject@linuxfoundation.org,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
 linux-doc@vger.kernel.org, kyle.swenson@est.tech

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Sep 2025 19:06:25 +0200 you wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> This patch series introduces a new devlink-conf uAPI to manage device
> configuration stored in non-volatile memory. This provides a standardized
> interface for devices that need to persist configuration changes across
> reboots. The uAPI is designed to be generic and can be used by any device
> driver that manages persistent configuration storage.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] net: pse-pd: pd692x0: Replace __free macro with explicit kfree calls
    (no matching commit)
  - [net-next,v3,2/5] net: pse-pd: pd692x0: Separate configuration parsing from hardware setup
    (no matching commit)
  - [net-next,v3,3/5] docs: devlink: Sort table of contents alphabetically
    https://git.kernel.org/netdev/net-next/c/7cfbe1c3397c
  - [net-next,v3,4/5] devlink: Add devlink-conf uAPI for NV memory management
    (no matching commit)
  - [net-next,v3,5/5] net: pse-pd: pd692x0: Add devlink interface for configuration save/reset
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



