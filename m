Return-Path: <netdev+bounces-243551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB29CA36EB
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 12:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12C393149CC9
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 11:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B53F33CEAE;
	Thu,  4 Dec 2025 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3O0NmT0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D431C33CEB4;
	Thu,  4 Dec 2025 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764847388; cv=none; b=jKuWgJXJYhu2j0GkxfYquZSoKBGGY4onUXlAjwEwTryMvNzufMCu7z1he+o3P+suNmDlq9vfzzA+l6zn5TMpHceOQbEaAbn2RQErzOdsqAjZ8iqHOx1+IVWNV1ypUjJVOERSxcTrU7cRfQBFGNmoAYsJjx8HEzhUqJmOuDzo6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764847388; c=relaxed/simple;
	bh=dz5qXYAmoirXKTeo4N21YGOLuAhJJAhSfYXRElm1n2Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HhqyU4m4tp1ajq9dFFfKzuMfbiIkgwJ5SvHmG8Kx5GOXJ51j4GySY/jxhdQdARsADkWw49nydl8G+4GZfwW8XC0CkxKmia6PDr1Bb1uY10oVR+Fa0/LeU4VEN4mz2cbti1I5QWk3DqaN2dOcrtAHux0CCE4G5gU41XDBE7xPQkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3O0NmT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D846C113D0;
	Thu,  4 Dec 2025 11:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764847387;
	bh=dz5qXYAmoirXKTeo4N21YGOLuAhJJAhSfYXRElm1n2Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c3O0NmT0zz2x3BgLqGZXPd1bieCSMFERvSW8kHmRLzMLb6uFev36afwoGnXjOMmeY
	 tPYSg6faOdTxFAfEy2g4tjAeYwbzJ9mFBPPhhUKpV2+87VQaK3UirgYVvC6gO6sylm
	 o5Xu6iOouKE705bPBx2kCCJrdlNe0/ZumkJDiGfJSLA3UHIoscc05k5nfP+9otIx3i
	 UG/Z0NqJwRt/l2CgGaKTU6RcqGFAZ6xWsojnk8lf6BG3fFQAGd68+KjMg0wYlmkDvj
	 wDyQdE1gluS7kGf4CK8av6CGrfLjiWGbaV4F+9I6MR4JsWYPEaZbiflIaB3GwgePCt
	 L5GxlvZuwa/4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5B303AA9A9C;
	Thu,  4 Dec 2025 11:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] net: phy: RTL8211FVD: Restore disabling of
 PHY-mode EEE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176484720554.739056.14290406476453393021.git-patchwork-notify@kernel.org>
Date: Thu, 04 Dec 2025 11:20:05 +0000
References: <20251202-phy_eee-v1-1-fe0bf6ab3df0@axis.com>
In-Reply-To: <20251202-phy_eee-v1-1-fe0bf6ab3df0@axis.com>
To: Ivan Galkin <ivan.galkin@axis.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 rmk+kernel@armlinux.org.uk, marek.vasut@mailbox.org,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@axis.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 2 Dec 2025 10:07:42 +0100 you wrote:
> When support for RTL8211F(D)(I)-VD-CG was introduced in commit
> bb726b753f75 ("net: phy: realtek: add support for RTL8211F(D)(I)-VD-CG")
> the implementation assumed that this PHY model doesn't have the
> control register PHYCR2 (Page 0xa43 Address 0x19). This
> assumption was based on the differences in CLKOUT configurations
> between RTL8211FVD and the remaining RTL8211F PHYs. In the latter
> commit 2c67301584f2
> ("net: phy: realtek: Avoid PHYCR2 access if PHYCR2 not present")
> this assumption was expanded to the PHY-mode EEE.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: RTL8211FVD: Restore disabling of PHY-mode EEE
    https://git.kernel.org/netdev/net/c/4f0638b12451

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



