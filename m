Return-Path: <netdev+bounces-191198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4942ABA60E
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1565BA24CF6
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE3E280A50;
	Fri, 16 May 2025 22:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIOYvBt+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8180280A46;
	Fri, 16 May 2025 22:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747435800; cv=none; b=WCuU7szIc96CX/xo8PaPdVnPPNBP7UWjoM47pTaYpCc9nXR/uDYcTSz5npSMJ4zIOXad5eJHJjpn85SAtVApLUx0jSnlg3pkDJKKxlgwoPdBhWS23v0wZx1MuWPrWpBqvLwNgYJMNLN0SqqsszLq9+i2aAufuUIbFXELx0s81yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747435800; c=relaxed/simple;
	bh=jaqgZ8jTqjEHCQOEGpjn1OUVdzxI1XKNc7sg63lUh1A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tFwFZUiQmk4XrVd9F8/Ee5h12H5osKf/Ss1mVzrz/3kL2antbYinOHx7/A2jcRQyPrP6ByDoYmzc33is0qJRjPQn1baFcvJelgFY7zJhCRqfOYCFh+ObfpzH2yf1/0dR/QBKmXx7zoaMh0WPBYukQx3HMTC3t/jcT6B74YFXnDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIOYvBt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2B8C4CEE4;
	Fri, 16 May 2025 22:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747435800;
	bh=jaqgZ8jTqjEHCQOEGpjn1OUVdzxI1XKNc7sg63lUh1A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZIOYvBt+b0EDDr0oLpmf/qCjyaIY1n2GsW1nysdMWgaTAXD5bMRWus+MiOd5atZJB
	 Q0mKL6Kz8NudIm25uoIgMaDV4HPZs8k1VtbMsS7upJvVVVAb5doVSFNF0ueG77kihr
	 PXvC8tKLAh1+6q4vK4IUMOhoIbAcl7AHDCXK5vNmOpWOaQJND9m9JasKLmj7WFaSmp
	 3gCp078VlsetaQ+CWPMgBRQuv008D3t9xBUHj9ffbzHR9i1bQ6RnY/d2yTVghQK+fy
	 YWYSPmL0/zmIxPqA78wBWvwBJIzQ7Pt+/bEwyIPfvSARcGyqIx5inc20IxA4y5bNJr
	 QYag+2smslkHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 352EB3806659;
	Fri, 16 May 2025 22:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next,
 PATCH v2] net: phy: mediatek: do not require syscon compatible for pio
 property
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174743583700.4084431.5953049222658087870.git-patchwork-notify@kernel.org>
Date: Fri, 16 May 2025 22:50:37 +0000
References: <20250510174933.154589-1-linux@fw-web.de>
In-Reply-To: <20250510174933.154589-1-linux@fw-web.de>
To: Frank Wunderlich <linux@fw-web.de>
Cc: daniel@makrotopia.org, dqfext@gmail.com, SkyLake.Huang@mediatek.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 frank-w@public-files.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 10 May 2025 19:49:32 +0200 you wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Current implementation requires syscon compatible for pio property
> which is used for driving the switch leds on mt7988.
> 
> Replace syscon_regmap_lookup_by_phandle with of_parse_phandle and
> device_node_to_regmap to get the regmap already assigned by pinctrl
> driver.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: mediatek: do not require syscon compatible for pio property
    https://git.kernel.org/netdev/net-next/c/15d7b3dfafa9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



