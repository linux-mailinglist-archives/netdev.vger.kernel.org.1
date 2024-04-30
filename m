Return-Path: <netdev+bounces-92434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6368B7516
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 14:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096892862B4
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 12:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D6413D25F;
	Tue, 30 Apr 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pR9XeIyA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B309312D741
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478431; cv=none; b=to1EtY+htJUAFK+GtgTpkoC1RiG8Vg6PmdL2ahk3hYq1j2reQHo3WEAfeVi6uGy1iJnsYMoi+bO4JJNK1XuuTXGIDZR+H8ANmBJCvowh7zILcgA/HMa/k/UxK2It7NG48TLJdAQQ9gFElC68uCa40q4te5DcCfodoAuRoUB7bOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478431; c=relaxed/simple;
	bh=vVxntyf1vu4gJPxPxCvLN0fS28zoNfzyqadtVr0GiBI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qARlapJdIzHwgJ8Nb/3PcwltO/rmHmFTOdQj/cs0Dg3TPfEZonYB7RD2Ule6kdGsHoqDYYUDSULHn6OdXnK2Br2uPOJxLUA85SoV2K8XRalQMClIM/aH/Dnc1G6whu7y2iWIhNL1T5LRUc9bPkIBVR01LkWUBSsUW1iaxdvSj5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pR9XeIyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CA3DC4AF18;
	Tue, 30 Apr 2024 12:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714478430;
	bh=vVxntyf1vu4gJPxPxCvLN0fS28zoNfzyqadtVr0GiBI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pR9XeIyA+yNzs63Wo+bwXAqlA55U/upFHuabczh3eCJSfQOH5EHxeW0S/epUYR7CF
	 XDPXuUTrrrNshTgdbN01jacNkLXO65R63MlIk0ptUCTjpYGIX2C5cc7IiluLQXDO+Z
	 zaxrDDvpteNtnKAEnhZVUnF/38KfComk2iZ97c8V7ttSygMvHdTCCd/WY8ogot5PK+
	 cr9Ox8guGXnxzLrvyyOQuCxlZ74g8mMYHz0AXSdMXTdvXglH9WHmmnabhNVivN1vsw
	 erCnVfY7JsXNEO6ErDRXibTBSNjF+IH1IRjhYsW7ANh2OEHYII6igWT/v6p/p5F59u
	 zl7J+wCj3GZMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B6A0C43440;
	Tue, 30 Apr 2024 12:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: realtek: provide own phylink MAC
 operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171447843023.24086.10431942201135236260.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 12:00:30 +0000
References: <E1s11qJ-00AHi0-Kk@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1s11qJ-00AHi0-Kk@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: alsi@bang-olufsen.dk, linus.walleij@linaro.org, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 28 Apr 2024 11:33:11 +0100 you wrote:
> Convert realtek to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c. We need to provide a stub for
> the mandatory mac_config() method for rtl8366rb.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> This patch has been built-tested with -Wunused-const-variable
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: realtek: provide own phylink MAC operations
    https://git.kernel.org/netdev/net-next/c/8aec5b10bce6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



