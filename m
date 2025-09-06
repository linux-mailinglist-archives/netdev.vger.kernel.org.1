Return-Path: <netdev+bounces-220524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0240B467A6
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 02:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706CE1C236FF
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 00:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E973D3594A;
	Sat,  6 Sep 2025 00:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gxjil0eg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45C9DF49
	for <netdev@vger.kernel.org>; Sat,  6 Sep 2025 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757119804; cv=none; b=fd1i0bIj1EH4hmdzkaanoOtzHMGXPdlvWk4zE+lpL2CyvMgXiKZM5KszgKYlicupsva/2w0am8lobHM5sd5jBNQ1qANrB53rv/+vzthq2KYX7sZwul+Dl6QLZA16q06ynk7MOhVkYQF2Q2KmfUcbQunXS7MZVoZnJRNN8OZXjro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757119804; c=relaxed/simple;
	bh=2JqPSTiL2PqdR5XKddKwDNhxrz7NNw4m6gNC77S3KEk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kp90fgZwpNB8Fv+m2Z300YvHlDOBjDZg9BRaW9xWpcRvH4HZZ29zdzrtw2YWkZNp1FOMjKpH8sSZOHmZ3BXG3I0S1KSujmU/0aN8FnR2/wwAiAcXKr4VH+Ocvr2hwYdUpNQ5tHNJPgRVDVSgcbezbBfO1ma8GwciuxLSyRkMNow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gxjil0eg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C94C4CEF1;
	Sat,  6 Sep 2025 00:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757119802;
	bh=2JqPSTiL2PqdR5XKddKwDNhxrz7NNw4m6gNC77S3KEk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gxjil0egx3HZF3i7mnCk6EnlsyS8p3Re+GfC5gxOH8L3VxEsbGSxQwl1M2UMtLrzi
	 CZPdp3XdpYcYCayWZNg/MDpovQT0h2uK3LbY7oaU0ApkepXLXzzn4mY6Q/qE2ETQvY
	 912grSlIYOQcCuKuq/DuAwYTyZpEM+SKN1DiL2DDvALXvbrZIfgvoThNewg2OrUDxa
	 AKywBbYMMzjdPH9z+mTTZttCtlpnkj3DWrT/eXis5ZQist7OnC47GztJfKH6Hi+Ecz
	 XPaP0gpIfT4ic1nbetoKn5OxdPpgoWYfUwzuVJQMOqu4aUCxOJG/LU1AgDMfzClxLH
	 wk4mzhcITSb/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC47383BF69;
	Sat,  6 Sep 2025 00:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] net: phy: fixed_phy: remove link gpio support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175711980675.2732461.3201926665490095310.git-patchwork-notify@kernel.org>
Date: Sat, 06 Sep 2025 00:50:06 +0000
References: <75295a9a-e162-432c-ba9f-5d3125078788@gmail.com>
In-Reply-To: <75295a9a-e162-432c-ba9f-5d3125078788@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, andrew+netdev@lunn.ch,
 pabeni@redhat.com, edumazet@google.com, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, f.fainelli@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 4 Sep 2025 08:08:18 +0200 you wrote:
> The only user of fixed_phy gpio functionality was here:
> arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts
> Support for the switch on this board was migrated to phylink
> (DSA - mv88e6xxx) years ago, so the functionality is unused now.
> Therefore remove it.
> 
> Note: There is a very small risk that there's out-of-tree users
> who use link gpio with a switch chip not handled by DSA.
> However we care about in-tree device trees only.
> 
> [...]

Here is the summary with links:
  - [v3,net-next] net: phy: fixed_phy: remove link gpio support
    https://git.kernel.org/netdev/net-next/c/43a42b85162a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



