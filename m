Return-Path: <netdev+bounces-235342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED73C2EC1B
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 02:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCF2189B4C0
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 01:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F046122D7B0;
	Tue,  4 Nov 2025 01:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlriV+fl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E2D22B8CB;
	Tue,  4 Nov 2025 01:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762219844; cv=none; b=a0WxkimR0PM/qlzYArlZtNbQXj2Q3XljGjFvJN6iH234uXnpMocIPs4J859+IpLhn9qRT6UffvelE/8396mc0w2twy2zuXnXe0P1L5G8bv57t82e5zEOiRYKCVf/YX7DCy/QZW6I7KQ6dyeZoPQnM0v+9m+oEr8OHmX4Bw94GIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762219844; c=relaxed/simple;
	bh=3J1Rb8Iwm7Bi3wu+yp/VgP+Ys1fBv/l3I3gQyVTtQqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZnLPwmxDitvXhQds+zWohHxOnl+IRveX4iBlcKuIeagxLdOPyYTol3AdYld+eT2nkk10ptcKKKUO1dyXS65/ZL1EkL4QGgvx39ZpdXQJzK2VOiNXaQchS6TVLuAX8CJcU1pDKAgf1+iJCOo0hgqU7LNRdsTrVivjthAjW66M8A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlriV+fl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64479C116C6;
	Tue,  4 Nov 2025 01:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762219844;
	bh=3J1Rb8Iwm7Bi3wu+yp/VgP+Ys1fBv/l3I3gQyVTtQqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SlriV+fli9f1GAKr0rpGWQnr7HKdG+lsLU+/DExX0yjtJD2hHU+GVAl1WND3gfIUt
	 dIxu8c1DEfn5hoeJvi/mR0q4EjGgWBYQfV0rod+q5f5R7rjj/rZT+qNkFQexDt1WeG
	 500ooYtvROqcPoqu1zLyASnR8GlukNi80jXovDe4XpdDjylJJ221E500NOvH8URH9e
	 9i8je0eSRw/XJUl/omkcVQmJQ1/vpVB+Yoh5514k1I+M3y0p0petg/Wuje6tmogDpz
	 wbV/+Jgy0ptB8ieYrJghapD3cbA1JkOpMvwo1jbUreqGP5SIHTnuIdQeNLVG8c95jA
	 pFqsp/Usm4JWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE033809A8A;
	Tue,  4 Nov 2025 01:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: realtek: add interrupt support for
 RTL8221B
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176221981849.2281445.7129169862335846863.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 01:30:18 +0000
References: <20251102152644.1676482-1-olek2@wp.pl>
In-Reply-To: <20251102152644.1676482-1-olek2@wp.pl>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michael@fossekall.de, daniel.braunwarth@kuka.com, rmk+kernel@armlinux.org.uk,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, zhaojh329@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  2 Nov 2025 16:26:37 +0100 you wrote:
> From: Jianhui Zhao <zhaojh329@gmail.com>
> 
> This commit introduces interrupt support for RTL8221B (C45 mode).
> Interrupts are mapped on the VEND2 page. VEND2 registers are only
> accessible via C45 reads and cannot be accessed by C45 over C22.
> 
> Signed-off-by: Jianhui Zhao <zhaojh329@gmail.com>
> [Enable only link state change interrupts]
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: realtek: add interrupt support for RTL8221B
    https://git.kernel.org/netdev/net-next/c/18aa36238a4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



