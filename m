Return-Path: <netdev+bounces-143560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E6D9C2FAA
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 22:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116381F21A56
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 21:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389721A00F8;
	Sat,  9 Nov 2024 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaa5hpX0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095FF19F471
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731189021; cv=none; b=NNMlYU99U2cQQwRQWbQ3NWUKCHj4x3NGq2Cw6aiQQqMS7JAQty40oEbwEa/lg3K6uVBQB5+QZOD3mCtasvgr2Bl7JTJYl8QAUTyEIsiWzYJHXOH3SdnkTZbZGWuRDPgbIHKtr8NB39Lvz15G8NHetjpPfaFiKfHmwMqYT4BQZAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731189021; c=relaxed/simple;
	bh=swXR1a+tlPfbvZ/wEeJtxsI1i8WsFnPqjGjeJ2smvPQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pBi7LcGhos2d6OStqTqaYX6PHQMIDSebWEeJZPJdzamr1hz7+aQtFocPyED455AXVl6hHzHNr7uFG0D1xv/NnLTTIHAgwtEkkbTwgIbrVRMagubco0rMmWvASq8LHiKHB/hY/8202WICUiaChlTnxbvtWfuyMce5J10Ms2rsay0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaa5hpX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE50C4CED2;
	Sat,  9 Nov 2024 21:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731189020;
	bh=swXR1a+tlPfbvZ/wEeJtxsI1i8WsFnPqjGjeJ2smvPQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gaa5hpX0JN3z9jQ7B3fgJLJUHXlNsU77Qkeq8pTVo7U/HgFokM671MReZ6G4AtgHU
	 LAFEGbJliHpFWVZggvur1/LA21xezUuE0NtyUGIy1Yn+pJnh/631G4EA7sa4vDqx35
	 73G7aDFqqZLEMw23b+mRa3dzCmARc7z/hNW3SwExzrcdqS7HhRVbw13PbLhtUmDv4r
	 aGedH2q9aFnz5lj0j8tM4wY5d8nPu2xyw4wcTU6mkO6xcuHxm1aBOGdZnss3uNxYwY
	 blS+kPC2QNf9vs9u6ftTh1yWaoeMR4V/8lp1IEROWaUqRo+LDoNkifggrMUggPQzXh
	 /6YYTbPvpNw5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC763809A80;
	Sat,  9 Nov 2024 21:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] r8169: improve wol/suspend-related code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173118903023.3018960.12845984242276994035.git-patchwork-notify@kernel.org>
Date: Sat, 09 Nov 2024 21:50:30 +0000
References: <be734d10-37f7-4830-b7c2-367c0a656c08@gmail.com>
In-Reply-To: <be734d10-37f7-4830-b7c2-367c0a656c08@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 6 Nov 2024 17:54:27 +0100 you wrote:
> This series improves wol/suspend-related code parts.
> 
> Heiner Kallweit (3):
>   r8169: improve __rtl8169_set_wol
>   r8169: improve rtl_set_d3_pll_down
>   r8169: align WAKE_PHY handling with r8125/r8126 vendor drivers
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] r8169: improve __rtl8169_set_wol
    https://git.kernel.org/netdev/net-next/c/c507e96b5763
  - [net-next,2/3] r8169: improve rtl_set_d3_pll_down
    https://git.kernel.org/netdev/net-next/c/330dc2297c82
  - [net-next,3/3] r8169: align WAKE_PHY handling with r8125/r8126 vendor drivers
    https://git.kernel.org/netdev/net-next/c/e3e9e9039fa6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



