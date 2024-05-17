Return-Path: <netdev+bounces-97032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1B68C8D51
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 22:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720FE1F23A95
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 20:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3475320B3D;
	Fri, 17 May 2024 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUPJroVQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB9C1CAA9;
	Fri, 17 May 2024 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715978310; cv=none; b=otdGbkTy7v7c4PyMbRdftDnBPQP85kyR1cqXpF+XH+VrOf4EUT3PJzViYtVjyqiU2Io5S7YY4ddIH5h72Aju6/GHNfAXPOMGkA57aXi7h5NzLA59l/+KkUbWsmw6L5sfmuf4BWieY2YMeuoZi1qMIkIkWYV+LvuUffs7n82zE98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715978310; c=relaxed/simple;
	bh=rjXgBf9SXm9iJZB7YQT2V26iQljWZCNDD8RD97X8MY8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B4xQoQKxxlAMdRpsPoX3G0zKPTb5drlqbsYkhnI93k2Lc8LNdpBbjehkx+Ag0Qou5KWjjxUfPuOIsLdMN6j9F0Bk1RPeABe+exVGFQX2pWKMmhPl0siHULaRdnAM4LHVAQ/dps+j+IL28HDLiESuaAs8zCX6dbx7IQYCfvlWR6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUPJroVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5BE4C2BD10;
	Fri, 17 May 2024 20:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715978309;
	bh=rjXgBf9SXm9iJZB7YQT2V26iQljWZCNDD8RD97X8MY8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hUPJroVQ5Kj6AV04VCin3eTymgh6ea1Kz6huBswXme5ZumhjmHKyX7sd5lryRWhCB
	 N+JEc7kf3j2hjmIvetJclTeq0poiq5hudFQmmqMJft4GgzbjkOHvb97xEdFRZla+g0
	 fvFRb5fM/sq0tgamwLAz9N40Hi73A8PHH5vkXdZDhTy/lPWT3AkZGCX2BOaK/kLywo
	 +CIASrfGqdP4qn5O6Mll63dMe3c7zFxxDFslWPRmNdotbSzJVDGGezI8zTytJFNF40
	 l1vkviSBH2KfP1MzHyCmYFgdq+fCuFDGeGRvGTnrsUSaLIUR79AUIt0BUUi0jcyNk0
	 qQ1jZmgyDUK+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95E00C54BD4;
	Fri, 17 May 2024 20:38:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/1] net: dsa: microchip: Correct initialization order
 for KSZ88x3 ports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171597830961.5541.4864481930303671659.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 20:38:29 +0000
References: <20240517050121.2174412-1-o.rempel@pengutronix.de>
In-Reply-To: <20240517050121.2174412-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com,
 woojung.huh@microchip.com, arun.ramadoss@microchip.com, hkelam@marvell.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, dsahern@kernel.org, horms@kernel.org,
 willemb@google.com, san@skov.dk

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 May 2024 07:01:21 +0200 you wrote:
> Adjust the initialization sequence of KSZ88x3 switches to enable
> 802.1p priority control on Port 2 before configuring Port 1. This
> change ensures the apptrust functionality on Port 1 operates
> correctly, as it depends on the priority settings of Port 2. The
> prior initialization sequence incorrectly configured Port 1 first,
> which could lead to functional discrepancies.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] net: dsa: microchip: Correct initialization order for KSZ88x3 ports
    https://git.kernel.org/netdev/net/c/f0fa84116434

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



