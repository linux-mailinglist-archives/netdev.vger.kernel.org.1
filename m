Return-Path: <netdev+bounces-153545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D4D9F8A05
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4EF189231B
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71516208A9;
	Fri, 20 Dec 2024 02:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2bM2bon"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA0A1C6BE;
	Fri, 20 Dec 2024 02:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734660616; cv=none; b=oyfjJn+cTBgDQbfmryx/MEj9e07ascQcn6skTUyb+gj/PI0galBRNu2ZnAb/91aAKSANZkREVcy4SDLRvukQ2OZlHRo1jJnSzmjRfq+CGJCvR3xy8e7YwmueUKibqu1qGUMCgMgWAUoaMfBuOpHvto2HbWHxi0Ae1tVr4xdjlWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734660616; c=relaxed/simple;
	bh=iPjAPw6aqXtrteovxz27aCq3oYNC0QAbdY+/E99V0W4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WKXyNxFWkeX2KNDdnQTeppmcATcm7497BMO0nswodqsEpx/+zNNFczArj8056jiDAlQohQuCNMbwvm6DhDPed7RgOcHaSTvBw+z+bMnjyU45tGy2DDuETknD4C83x0XT62GSvjnNo+mQM7QgV02yR7POq4epkfWe/jBHmMufxnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2bM2bon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EFEC4CECE;
	Fri, 20 Dec 2024 02:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734660616;
	bh=iPjAPw6aqXtrteovxz27aCq3oYNC0QAbdY+/E99V0W4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V2bM2bonxgbmzsmBxFAoXqBOMZK39O2I8M+6vQy6AWm6sqMKZm90dOs5yxMYd8OO/
	 8Juneouyt5MKO3CweZ7KIPhyl+ibYVHhOKzRaB7THKPLMIhA6BmviLvn9uS69rlHGC
	 tMLh1aiCjxt9Spzqtp9wFbx/ZXzoFZUHJhV88TnEpNcgY4IHE7FEesnSSFOPBRumNU
	 okfV9mTKnYzy6Wl6SyzpK6raYo+z7jTs/oRSiZQ/TwzPfcQ3Hy5SdI9Xdu0VVo4JSl
	 OYUAjjFlg6TkLG5p0RCjXGcVYf89n4wBGaaESECgxTZdbF9prVtkwndq+X1+5k9k56
	 vr3QWf9+WmK0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ED6E53806656;
	Fri, 20 Dec 2024 02:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net] net: phy: micrel: Dynamically control external clock
 of KSZ PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173466063368.2449610.9075254555093719369.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 02:10:33 +0000
References: <20241217063500.1424011-1-wei.fang@nxp.com>
In-Reply-To: <20241217063500.1424011-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 florian.fainelli@broadcom.com, heiko.stuebner@cherry.de, frank.li@nxp.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Dec 2024 14:35:00 +0800 you wrote:
> On the i.MX6ULL-14x14-EVK board, enet1_ref and enet2_ref are used as the
> clock sources for two external KSZ PHYs. However, after closing the two
> FEC ports, the clk_enable_count of the enet1_ref and enet2_ref clocks is
> not 0. The root cause is that since the commit 985329462723 ("net: phy:
> micrel: use devm_clk_get_optional_enabled for the rmii-ref clock"), the
> external clock of KSZ PHY has been enabled when the PHY driver probes,
> and it can only be disabled when the PHY driver is removed. This causes
> the clock to continue working when the system is suspended or the network
> port is down.
> 
> [...]

Here is the summary with links:
  - [v5,net] net: phy: micrel: Dynamically control external clock of KSZ PHY
    https://git.kernel.org/netdev/net/c/25c6a5ab151f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



