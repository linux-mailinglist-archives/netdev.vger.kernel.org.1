Return-Path: <netdev+bounces-222360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1247CB53F81
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 02:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44AA11C8254D
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 00:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1002CCC5;
	Fri, 12 Sep 2025 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsU/Vy5j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994C92B9BA
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757637003; cv=none; b=KSCLZ909ThsWKbFuKwYaq6uufm/5f8SvmleqH+fyqRncPJBygGF5Mcxh0a4/MmVtwK5YBm7lSJQDHbj24nrA6jo3Pe4PS98raxONhRK+XkCs+lfayDv7AVSRdlSv1l/T2Pwf+BCunYQ8Ho66rKb0jxVPv/Wlrx4dEV8rLG5/q1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757637003; c=relaxed/simple;
	bh=hCB1bYh/Zfl/BHj3L3wNbTP4w+J7Tg8cUI9SnKEhs8Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BA0ftSsa9BETpleEyTPE2NgB4gzHbPn747Lk54/Pe52YtORJXzFUROwoOVaN39XHmLAha4jJyFM+ltmSH3isjBN9kfgittfXKJWPRahySa+VyvqbuB8+R1g90+t4dWyc9DRJXqr7GNS83ZbIuCnVA0/t6vWQASUbMrcELr6bL1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsU/Vy5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693C5C4CEF0;
	Fri, 12 Sep 2025 00:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757637003;
	bh=hCB1bYh/Zfl/BHj3L3wNbTP4w+J7Tg8cUI9SnKEhs8Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GsU/Vy5jEW6KRckiRrwEvrJVrwuTipIEGQM/wWq/t200eoMLq2EwIhZGdZ86L7yIf
	 4m+XJ5+liWlCvbLpL/vUpUP5cqKe7Gx24tWlILDRcV9o3GspOWhR9rE61ZrFwlNK/K
	 QaP48fKtU3z9ZNmDDKQNueRG+vj1xjlPPn24kYCAnQKMKgtZTOBXcSdttwxTaCgLAz
	 mqBAq6HBu2oP6w2UxtyZQEH/G9F5EopllzU+gt6HaROGUDudIDNFAsSaIm14o2L4bk
	 gsPTHmhN2aSazBOdoz7xx1jaQWRjGg0V/UBQkVlrcH2GLUy2/qH+e/d6goDerlUOrb
	 dyTgv2ytdf12A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D29383BF69;
	Fri, 12 Sep 2025 00:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: fixed_phy: remove two function stubs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175763700604.2356569.14398367568729798118.git-patchwork-notify@kernel.org>
Date: Fri, 12 Sep 2025 00:30:06 +0000
References: <8729170d-cf39-48d9-aabc-c9aa4acda070@gmail.com>
In-Reply-To: <8729170d-cf39-48d9-aabc-c9aa4acda070@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, andrew+netdev@lunn.ch,
 pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Sep 2025 22:42:47 +0200 you wrote:
> Remove stubs for fixed_phy_set_link_update() and
> fixed_phy_change_carrier() because all callers
> (actually just one per function) select config
> symbol FIXED_PHY.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: fixed_phy: remove two function stubs
    https://git.kernel.org/netdev/net-next/c/5f790208d68f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



